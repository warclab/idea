/******************************************************************************************
Copyright (c) 2016 HuiYan Cheah.
All rights reserved.

Redistribution and use in source and binary forms are permitted provided that
the above copyright notice and this paragraph are duplicated in all such forms
and that any documentation, advertising materials, and other materials related
to such distribution and use acknowledge that the software was developed by
Nanyang Technological University. The name of Nanyang Technological University
may not be used to endorse or promote products derived from this software
without specific prior written permission.  THIS SOFTWARE IS PROVIDED ``AS IS''
AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

* iDEA Soft-Core Processor
* HuiYan Cheah, 2016 hycheah1@e.ntu.edu.sg
* School of Computer Engineering
* Nanyang Technological University
*
	* This processor is a proof-of-concept of the usability of the DSP48E1 as
	* the execution unit of a general-purpose processor. It is not a full-blown processor.
	*
	* Description:
	* Decode module of the processor. Consists of sub-modules in instruction decode stage.
	* Sub-modules: Control unit. Status Register. Register file. Input Map. 
	* Occupies only 1-pipeline stage.
	*

******************************************************************************************/
`include "defines.v"

module decode #(
	parameter n = 1
)
(
	// ***** Input *****
	input wire				clk,
	input wire				rst,
	input wire [`DATA_WIDTH-1:0]		inst_i,
	input wire [`IM_ADDR_WIDTH-1:0]		pc_i,
	input wire				regwrite_i,
	input wire				regwriteui_i,
	input wire [`REG_ADDR_WIDTH-1:0]	rd_addr_i,
	input wire				cmpsel_i,
	input wire [2:0]			loadtype_i,
	input wire				dm_re_i,
	input wire [`DATA_WIDTH-1:0]		dm_readdata_i,
	input wire [35:0]			p_i,
	input wire				sr_i,
	
	// ***** Output *****
`ifdef EXTLOOPBACK
	output reg				extloopback_o,
`endif
	output reg [`REG_ADDR_WIDTH-1:0] 	rd_addr_o,
	output reg 				regwrite_o,
	output reg 				regwriteui_o,
	output reg				sr_o,

	// => Data Memory
	output reg [3:0]			dm_we_o,
	output reg 				dm_re_o,
	output reg [`DM_ADDR_WIDTH-1:0] 	dm_addr_o,
	output reg [`DATA_WIDTH-1:0] 		dm_writedata_o,

	// => Execute => Branch
	output reg 				branchen_o,
	output reg [2:0] 			branchtype_o,
	output reg [15:0]		 	branchtarget_o,

	output reg 				jumpregsel_o,
	output reg [15:0]			jumpregtarget_o,		

	// => ALU
	output reg 				cmpsel_o,
	output reg [2:0]			loadtype_o,
	output reg [4:0] 			inmode_o,
	output reg [3:0] 			alumode_o,
	output reg [6:0] 			opmode_o,
	output reg 				ce2_o,
	output reg 				usemult_o,
	output reg [`PORTAWIDTH-1:0] 	 	data_a_o,
	output reg [`PORTBWIDTH-1:0] 	 	data_b_o,
	output reg [`PORTCWIDTH-1:0] 	 	data_c_o
);


// ***** Internal signals *****
// => ALU
	wire [6:0] 				opmode;
	wire [4:0]				inmode;
	wire [3:0]				alumode;
	wire					ce2;
	wire [`PORTAWIDTH-1:0] 			data_a;
	wire [`PORTBWIDTH-1:0] 			data_b;
	wire [`PORTCWIDTH-1:0] 			data_c;
`ifdef EXTLOOPBACK
	wire					extloopback;
`endif

// => Input Map
	wire usemult, useimm;
	wire [15:0] imm;
	wire [31:0] ra_readdata, rb_readdata, rc_readdata;

// => Register File
	wire [4:0] ra_addr, rb_addr, rc_addr;
	reg [31:0] rd_writedata;

// => Data Memory
	wire [3:0]			dm_we;
	wire				dm_re;
	wire [`DM_ADDR_WIDTH-1:0] 	dm_addr;
	wire [`DATA_WIDTH-1:0] 		dm_writedata;
	wire [2:0]			loadtype;

	wire [4:0] 			rd_addr;
	wire [15:0]		 	branchtarget;
	wire [2:0]			branchtype;

	wire [15:0] 			jumpregtarget;
	wire 				regwritepc;

	reg [`DATA_WIDTH-1:0] dm_readdata;

	wire sa, se, ze, sr;

`ifdef EXTLOOPBACK
	wire 		extloopback_shreg;
`endif
	wire [4:0]	ra_addr_shreg;
	wire [4:0]	rb_addr_shreg;
	wire [4:0]	rc_addr_shreg;
	wire [4:0]	rd_addr_shreg;
	wire [3:0]	dm_we_shreg;
	wire		dm_re_shreg;
	wire		useimm_shreg;
	wire		sa_shreg;
	wire		se_shreg;
	wire		ze_shreg;
	wire		sr_shreg;
	wire		usemult_shreg; 
	wire [15:0] 	imm_shreg;
	wire 		regwrite_shreg;
	wire 		regwriteui_shreg;
	wire 		regwritepc_shreg;
	wire [4:0]	inmode_shreg;
	wire [3:0]	alumode_shreg;
	wire [6:0]	opmode_shreg;
	wire 		ce2_shreg;
	wire 		jumpregsel_shreg;
	wire 		cmpsel_shreg; 
	wire [2:0] 	loadtype_shreg;
	wire 		branchen_shreg; 
	wire [2:0]	branchtype_shreg;
	wire [15:0] 	branchtarget_shreg; 
	wire [`IM_ADDR_WIDTH-1:0] pc_shreg;
	wire 		regwrite_in_shreg;
	wire		regwriteui_in_shreg;
	wire [4:0]	rd_addr_in_shreg;
	wire [31:0]	rd_writedata_shreg;


reg				shreg_cmpsel[0:n];
reg [2:0]			shreg_loadtype[0:n];
reg [4:0]			shreg_inmode[0:n];
reg [3:0]			shreg_alumode[0:n];
reg [6:0]			shreg_opmode[0:n];
reg				shreg_ce2[0:n];
reg				shreg_usemult[0:n];
reg [`PORTAWIDTH-1:0]		shreg_data_a[0:n];
reg [`PORTBWIDTH-1:0]		shreg_data_b[0:n];
reg [`PORTCWIDTH-1:0]		shreg_data_c[0:n];
reg [3:0]			shreg_dm_we[0:n];
reg 				shreg_dm_re[0:n];
reg [`DM_ADDR_WIDTH-1:0] 	shreg_dm_addr[0:n];
reg [`DATA_WIDTH-1:0] 		shreg_dm_writedata[0:n];

`ifdef EXTLOOPBACK
reg				shreg_extloopback[0:n];
`endif
reg [`REG_ADDR_WIDTH-1:0] 	shreg_rd_addr[0:n];
reg			      	shreg_regwrite[0:n];		
reg			      	shreg_regwriteui[0:n];		
reg			      	shreg_sr[0:n];		
reg			      	shreg_branchen[0:n];
reg [15:0] 			shreg_branchtarget[0:n];
reg [2:0] 			shreg_branchtype[0:n];
reg [15:0] 			shreg_jumpregtarget[0:n];
reg 				shreg_jumpregsel[0:n];

assign jumpregtarget = ra_readdata[15:0];

always@ (*)
begin
	case(loadtype_i)
		3'b001 : dm_readdata = dm_readdata_i;
/*LBU*/		3'b100 : dm_readdata = $unsigned(dm_readdata_i[7:0]);
/*LB*/	//	3'b101 : dm_readdata = $signed(dm_readdata_i[7:0]);
/*LHU*/	//	3'b110 : dm_readdata = $unsigned(dm_readdata_i[15:0]);
/*LH*/		3'b111 : dm_readdata = $signed(dm_readdata_i[15:0]);
		default: dm_readdata = dm_readdata_i;
	endcase
end

// Select data to be written to regfile: alu, data memory
always@ (*)
begin
	case({cmpsel_i, dm_re_i, sr_i})
		3'b001: rd_writedata = $signed(p_i[35:18]); // 
		3'b010: rd_writedata = dm_readdata; // memory
		3'b100: rd_writedata = $unsigned(p_i[31]); // 
		default: rd_writedata = p_i[31:0]; // alu
	endcase
end

control i_control ( /*ctr*/
	.inst_i			(inst_i),		// Input
`ifdef EXTLOOPBACK
	.extloopback_o		(extloopback),
`endif
	.ra_addr_o		(ra_addr), 	// => Register file
	.rb_addr_o		(rb_addr), 
	.rc_addr_o		(rc_addr), 
	.rd_addr_o		(rd_addr), 			// => Output 
	.regwrite_o		(regwrite),	
	.regwriteui_o		(regwriteui), 
	.dm_we_o		(dm_we), 				// => Data Memory
	.dm_re_o		(dm_re), 
	.usemult_o		(usemult), 	// => Input Map 
	.useimm_o		(useimm),
	.sa_o			(sa),
	.se_o			(se),
	.ze_o			(ze),
	.sr_o			(sr),
	.imm_o			(imm), 
	.branchen_o		(branchen), 			// => Output
	.branchtarget_o		(branchtarget), 
	.branchtype_o		(branchtype), 
	.cmpsel_o		(cmpsel),
	.loadtype_o		(loadtype),
	.inmode_o		(inmode), 
	.alumode_o		(alumode), 
	.opmode_o		(opmode), 
	.ce2_o			(ce2),
	.jumpregsel_o		(jumpregsel),
	.regwritepc_o		(regwritepc)
	);

id_shreg i_id_shreg (
	// Input
	.clk			(clk),
	.rst			(rst),
`ifdef EXTLOOPBACK
	.extloopback_i		(extloopback),
`endif
  	.ra_addr_i		(ra_addr), 	
  	.rb_addr_i		(rb_addr), 
  	.rc_addr_i		(rc_addr), 
  	.rd_addr_i		(rd_addr), 
  	.regwrite_i		(regwrite),	
  	.regwriteui_i		(regwriteui), 
  	.dm_we_i		(dm_we), 
  	.dm_re_i		(dm_re), 
	.usemult_i		(usemult),
	.useimm_i		(useimm),
	.sa_i			(sa),
	.se_i			(se),
	.ze_i			(ze),
	.sr_i			(sr),
	.imm_i			(imm), 
	.branchen_i		(branchen), 
	.branchtarget_i		(branchtarget), 
	.branchtype_i		(branchtype), 
	.cmpsel_i		(cmpsel),
	.loadtype_i		(loadtype),
	.inmode_i		(inmode), 
	.alumode_i		(alumode), 
	.opmode_i		(opmode), 
	.ce2_i			(ce2),
	.jumpregsel_i		(jumpregsel),
	.regwritepc_i		(regwritepc),
	.pc_i			(pc_i),
	.regwrite_in_i		(regwrite_i),
	.regwriteui_in_i	(regwriteui_i),
	.rd_addr_in_i		(rd_addr_i),
	.rd_writedata_i		(rd_writedata),
	// Output
`ifdef EXTLOOPBACK
	.extloopback_o		(extloopback_shreg),
`endif
	.ra_addr_o		(ra_addr_shreg), 
	.rb_addr_o		(rb_addr_shreg), 
	.rc_addr_o		(rc_addr_shreg), 
	.rd_addr_o		(rd_addr_shreg), 	
	.regwrite_o		(regwrite_shreg),	
	.regwriteui_o		(regwriteui_shreg), 
	.dm_we_o		(dm_we_shreg), 
	.dm_re_o		(dm_re_shreg), 
	.usemult_o		(usemult_shreg),
	.useimm_o		(useimm_shreg),
	.sa_o			(sa_shreg),
	.se_o			(se_shreg),
	.ze_o			(ze_shreg),
	.sr_o			(sr_shreg),
	.imm_o			(imm_shreg), 
	.branchen_o		(branchen_shreg), 	
	.branchtarget_o		(branchtarget_shreg), 
	.branchtype_o		(branchtype_shreg), 
	.cmpsel_o		(cmpsel_shreg),
	.loadtype_o		(loadtype_shreg),
	.inmode_o		(inmode_shreg), 
	.alumode_o		(alumode_shreg), 
	.opmode_o		(opmode_shreg), 
	.ce2_o			(ce2_shreg),
	.jumpregsel_o		(jumpregsel_shreg),
	.regwritepc_o		(regwritepc_shreg),
	.pc_o			(pc_shreg),
	.regwrite_in_o		(regwrite_in_shreg),
	.regwriteui_in_o	(regwriteui_in_shreg),
	.rd_addr_in_o		(rd_addr_in_shreg),
	.rd_writedata_o		(rd_writedata_shreg)
);

effective_addr i_effective_addr (
	.dm_addr_base_i		(ra_readdata), // 
	.dm_addr_offset_i	(imm_shreg/*inst_i[15:0]*/), // add in intermediate_shreg
	.dm_writedata_i		(rb_readdata),
	.dm_addr_o		(dm_addr),
	.dm_writedata_o		(dm_writedata)
);

regfile i_regfile ( /*rf*/
	.clk			(clk),				// Input
	.regwrite_i		(regwrite_in_shreg),
	.regwriteui_i		(regwriteui_in_shreg),
	.ra_addr_i		(ra_addr_shreg), //  
	.rb_addr_i		(rb_addr_shreg), // 
	.rc_addr_i		(rc_addr_shreg), // 
	.rd_addr_i		(rd_addr_in_shreg),
	.rd_writedata_i		(rd_writedata_shreg),
	.ra_readdata_o		(ra_readdata), // => Input Map
	.rb_readdata_o		(rb_readdata),
	.rc_readdata_o		(rc_readdata)
);


input_map i_input_map ( /*ia*/
	// control signals
	.regwritepc_i		(regwritepc_shreg),
	.usemult_i		(usemult_shreg), 	// 0: non-mult 1:mult
	.useimm_i		(useimm_shreg),  	// 0: reg 1:imm
	.sa_i			(sa_shreg),
	.se_i			(se_shreg),
	.ze_i			(ze_shreg),
	// data signals
	.pc_i			(pc_shreg),
	.data_imm_i		(imm_shreg),
	.ra_readdata_i		(ra_readdata),
	.rb_readdata_i		(rb_readdata),
	.rc_readdata_i		(rc_readdata),
	.data_a_o		(data_a),
	.data_b_o		(data_b),
	.data_c_o		(data_c)
);
// ****************************
// Shift Register *************
// ***************************

always@ (*) // Input
begin
		// => ALU
		shreg_cmpsel[0]			= cmpsel_shreg;
		shreg_loadtype[0]		= loadtype_shreg;
		shreg_inmode[0]			= inmode_shreg;
		shreg_alumode[0]		= alumode_shreg;
		shreg_opmode[0]			= opmode_shreg;
		shreg_ce2[0]			= ce2_shreg;
		shreg_usemult[0]		= usemult_shreg;
		shreg_data_a[0]			= data_a;
		shreg_data_b[0]			= data_b;
		shreg_data_c[0]			= data_c;

		// => Data Memory
		shreg_dm_we[0]			= dm_we_shreg;
		shreg_dm_re[0]			= dm_re_shreg;
		shreg_dm_addr[0]		= dm_addr;
		shreg_dm_writedata[0]		= dm_writedata;

		// => Execute => Register File
		shreg_rd_addr[0]		= rd_addr_shreg;
		shreg_regwrite[0]		= regwrite_shreg;		
		shreg_regwriteui[0]		= regwriteui_shreg;		
		shreg_sr[0]			= sr_shreg;

		// => Execute => Branch
		shreg_branchen[0]		= branchen_shreg;
		shreg_branchtarget[0]		= branchtarget_shreg;
		shreg_branchtype[0]		= branchtype_shreg;
		shreg_jumpregsel[0]		= jumpregsel_shreg; 
		shreg_jumpregtarget[0]		= jumpregtarget; 

		`ifdef EXTLOOPBACK
			shreg_extloopback[0]	= extloopback_shreg;
		`endif

end

always@ (*) // Output
begin
		// => ALU
		cmpsel_o			= shreg_cmpsel[n];
		loadtype_o			= shreg_loadtype[n];
		inmode_o			= shreg_inmode[n];
		alumode_o			= shreg_alumode[n];
		opmode_o			= shreg_opmode[n];
		ce2_o				= shreg_ce2[n];
		usemult_o 			= shreg_usemult[n];
		data_a_o			= shreg_data_a[n];
		data_b_o			= shreg_data_b[n];
		data_c_o			= shreg_data_c[n];
						       			 
		// => Data Memory
		dm_we_o				= shreg_dm_we[n];
		dm_re_o				= shreg_dm_re[n];
		dm_addr_o			= shreg_dm_addr[n];
		dm_writedata_o			= shreg_dm_writedata[n];

		// => Execute => Register File
		rd_addr_o			= shreg_rd_addr[n];
		regwrite_o			= shreg_regwrite[n];		
		regwriteui_o			= shreg_regwriteui[n];
		sr_o				= shreg_sr[n];
						       			 
		// => Execute => Branch
		branchen_o			= shreg_branchen[n];
		branchtarget_o			= shreg_branchtarget[n];
		branchtype_o			= shreg_branchtype[n];
		
		jumpregsel_o			= shreg_jumpregsel[n]; 
		jumpregtarget_o			= shreg_jumpregtarget[n]; 

		`ifdef EXTLOOPBACK
			extloopback_o 		= shreg_extloopback[n];
		`endif
end

genvar i;
generate
for (i = 0; i < n; i = i +1)
begin: shregister_dec_o
	always@ (posedge clk)
	begin
		if (rst)
		begin

			// => ALU
			shreg_cmpsel[i+1]		<= 1'b0;
			shreg_loadtype[i+1]		<= 3'b000;
			shreg_inmode[i+1]		<= {5{1'b0}};
			shreg_alumode[i+1]		<= {4{1'b0}};
			shreg_opmode[i+1]		<= {7{1'b0}};
			shreg_ce2[i+1]			<= 1'b0;
			shreg_usemult[i+1]		<= 1'b0;
			shreg_data_a[i+1]		<= {(`PORTAWIDTH){1'b0}};
			shreg_data_b[i+1]		<= {(`PORTBWIDTH){1'b0}};
			shreg_data_c[i+1]		<= {(`PORTCWIDTH){1'b0}};
                                                        
			// => Data Memory              
			shreg_dm_we[i+1]		<= {3{1'b0}};
			shreg_dm_re[i+1]		<= 1'b0;
			shreg_dm_addr[i+1]		<= {(`DM_ADDR_WIDTH){1'b0}}; 
			shreg_dm_writedata[i+1]		<= {(`DATA_WIDTH){1'b0}};
                                                        
			// => Execute => Register File  
			shreg_rd_addr[i+1]		<= {(`REG_ADDR_WIDTH){1'b0}};
			shreg_regwrite[i+1]		<= 1'b0;
			shreg_regwriteui[i+1]		<= 1'b0;
			shreg_sr[i+1]			<= 1'b0;
                                                        
			// => Execute => Branch  
			shreg_branchen[i+1]		<= 1'b0;
			shreg_branchtarget[i+1]		<= {16{1'b0}};
			shreg_branchtype[i+1]		<= {2{1'b0}};
		
			shreg_jumpregsel[i+1]		<= 1'b0;
			shreg_jumpregtarget[i+1]	<= {16{1'b0}}; 

			`ifdef EXTLOOPBACK
				shreg_extloopback[i+1]	<= 1'b0;
			`endif
		
		end
		else
		begin
			// => ALU
			shreg_cmpsel[i+1]		<= shreg_cmpsel[i];
			shreg_loadtype[i+1]		<= shreg_loadtype[i];
			shreg_inmode[i+1]		<= shreg_inmode[i];
			shreg_alumode[i+1]		<= shreg_alumode[i];
			shreg_opmode[i+1]		<= shreg_opmode[i];
			shreg_ce2[i+1]			<= shreg_ce2[i];
			shreg_usemult[i+1]		<= shreg_usemult[i];
			shreg_data_a[i+1]		<= shreg_data_a[i];
			shreg_data_b[i+1]		<= shreg_data_b[i];
			shreg_data_c[i+1]		<= shreg_data_c[i];

			// => Data Memory
			shreg_dm_we[i+1]		<= shreg_dm_we[i];
			shreg_dm_re[i+1]		<= shreg_dm_re[i];
			shreg_dm_addr[i+1]		<= shreg_dm_addr[i];
			shreg_dm_writedata[i+1]		<= shreg_dm_writedata[i];

			// => Execute => Register File
			shreg_rd_addr[i+1]		<= shreg_rd_addr[i];
			shreg_regwrite[i+1]		<= shreg_regwrite[i];		
			shreg_regwriteui[i+1]		<= shreg_regwriteui[i];		
			shreg_sr[i+1]			<= shreg_sr[i];

			// => Execute => Branch
			shreg_branchen[i+1]		<= shreg_branchen[i];
			shreg_branchtarget[i+1]		<= shreg_branchtarget[i];
			shreg_branchtype[i+1]		<= shreg_branchtype[i];
		
			shreg_jumpregsel[i+1]		<= shreg_jumpregsel[i]; 
			shreg_jumpregtarget[i+1]	<= shreg_jumpregtarget[i]; 

			`ifdef EXTLOOPBACK
				shreg_extloopback[i+1]	<= shreg_extloopback[i];
			`endif

		end
	end
end
endgenerate

endmodule
