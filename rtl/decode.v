/******************************************************************************************
* iDEA Soft-Core Processor v1.00
* Copyright (C) by HuiYan Cheah 2012 hycheah1@e.ntu.edu.sg
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

module decode ( /*dec*/
	// ***** Input *****
	input 								clk,
	input 								rst,
	// => Control
	input [31:0] 						inst_i,
	// => Regfile
	input								regfile_we_w_i,
	input 								regfile_we_uhw_i,
	input [`reg_addr_width-1:0]			addr_rd_i,

	// => Status Register
	input 								sr_we_i,
	input [2:0] 						condcode_i,
	input [47:0] 						p_i,
	
	// ***** Output *****
	// => Execute => Register file
	output reg [`reg_addr_width-1:0] 	addr_rd_o,
	output reg 							regfile_we_w_o,
	output reg 							regfile_we_uhw_o,

	// => Data Memory
	output reg 							dm_we_o,
	output reg 							dm_re_o,

	// => Offset Adder
	output reg 							ofsadden_o,
	output reg [31:0] 					din_dm_o,
	output reg [`dm_addr_width-1:0] 	base_addr_o,
	output reg [`dm_addr_width-1:0] 	offset_addr_o,

	// => Execute => Branch
	output reg 							branchen_o,
	output reg [`cond_code_width-1:0] 	condcode_o,
	output reg [`im_addr_width-1:0] 	branchtarget_o,

	// => Execute => Status Register
	output reg 							sr_we_o,

	// => ALU
	output reg [4:0] 					inmode_o,
	output reg [3:0] 					alumode_o,
	output reg [6:0] 					opmode_o,
	output reg 							ce2_o,
	output reg 							usemult_o,
	output reg [`portawidth-1:0] 	 	data_a_o,
	output reg [`portbwidth-1:0] 	 	data_b_o,
	output reg [`portcwidth-1:0] 	 	data_c_o
);

// ***** Internal signals *****
// => ALU
	wire [6:0] 								opmode;
	wire [4:0]								inmode;
	wire [3:0]								alumode;
	wire									ce2;
	wire [`portawidth-1:0] 					data_a;
	wire [`portbwidth-1:0] 					data_b;
	wire [`portcwidth-1:0] 					data_c;

// => Input Map
	wire ctr_imap_usemult, ctr_imap_useimm, ctr_imap_usemov, ctr_imap_seta0, ctr_imap_setb0, ctr_imap_setc0;
	wire [15:0] ctr_imap_imm;
	wire [31:0] rf_imap_data_ra, rf_imap_data_rb, rf_imap_data_rc;

// => Register File
	wire [4:0] ctr_rf_addr_ra, ctr_rf_addr_rb, ctr_rf_addr_rc;
	wire [31:0] data_rd;

// Output
	wire [4:0] 								addr_rd;
	wire [2:0] 								condcode;
	wire [`im_addr_width-1:0] 				branchtarget;

assign data_rd = p_i[31:0];

control i_control ( /*ctr*/
		.inst_i(inst_i), 				// Input
		.addr_ra_o		(ctr_rf_addr_ra), 	// => Register file
		.addr_rb_o		(ctr_rf_addr_rb), 
		.addr_rc_o		(ctr_rf_addr_rc), 
		.addr_rd_o		(addr_rd), 			// => Output 
		.regfile_we_w_o	(regfile_we_w),	
		.regfile_we_uhw_o(regfile_we_uhw), 
		.dm_we_o		(dm_we), 				// => Data Memory
		.dm_re_o		(dm_re), 
		.ofsadden_o		(ofsadden), 
		.usemult_o		(ctr_imap_usemult), 	// => Input Map 
		.useimm_o		(ctr_imap_useimm), 
		.usemov_o		(ctr_imap_usemov),
		.seta0_o		(ctr_imap_seta0), 
		.setb0_o		(ctr_imap_setb0), 
		.setc0_o		(ctr_imap_setc0), 
		.imm_o			(ctr_imap_imm), 
		.branchen_o		(branchen), 			// => Output
		.condcode_o		(condcode), 
		.branchtarget_o	(branchtarget), 
		.sr_we_o		(sr_we), 
		.inmode_o		(inmode), 
		.alumode_o		(alumode), 
		.opmode_o		(opmode), 
		.ce2_o			(ce2)
	);

status_register i_status_register ( /*sr*/
    .clk				(clk),			// Input 
    .rst				(rst), 
    .sr_we_i			(sr_we_i), 
    .p_i				(p_i), 
    .condcode_i			(condcode_i), 
    .we_o				(sr_rf_we) 		// => Register file
);

regfile i_regfile ( /*rf*/
	.clk				(clk),				// Input
	.regfile_we_w_i		(regfile_we_w_i),
	.regfile_we_uhw_i	(regfile_we_uhw_i),
	.sr_we_i			(sr_rf_we),			
	.addr_ra_i			(ctr_rf_addr_ra), // 
	.addr_rb_i			(ctr_rf_addr_rb), // 
	.addr_rc_i			(ctr_rf_addr_rc), // 
	.addr_rd_i			(addr_rd_i),
	.data_rd_i			(data_rd),
	.data_ra_o			(rf_imap_data_ra), // => Input Map
	.data_rb_o			(rf_imap_data_rb),
	.data_rc_o			(rf_imap_data_rc)
);

input_map i_input_map ( /*ia*/
	// control signals
	.usemult_i			(ctr_imap_usemult), 	// 0: non-mult 1:mult
	.useimm_i			(ctr_imap_useimm),  	// 0: reg 1:imm
	.usemov_i			(ctr_imap_usemov),
	.seta0_i			(ctr_imap_seta0),		 // set port a to 0s 	
	.setb0_i			(ctr_imap_setb0),		 // set port b to 0s
	.setc0_i			(ctr_imap_setc0),
	// data signals
	.data_imm_i			(ctr_imap_imm),
	.data_ra_i			(rf_imap_data_ra),
	.data_rb_i			(rf_imap_data_rb),
	.data_rc_i			(rf_imap_data_rc),
	.data_a_o			(data_a),
	.data_b_o			(data_b),
	.data_c_o			(data_c)
);

always@ (posedge clk)
begin
	if (rst)
	begin

		// => ALU
		inmode_o			<= {5{1'b0}};
		alumode_o			<= {4{1'b0}};
		opmode_o			<= {7{1'b0}};
		ce2_o				<= 1'b0;
		usemult_o			<= 1'b0;
		data_a_o			<= {(`portawidth){1'b0}};
		data_b_o			<= {(`portbwidth){1'b0}};
		data_c_o			<= {(`portcwidth){1'b0}};

		// => Data Memory
		dm_we_o				<= 1'b0;
		dm_re_o				<= 1'b0;

		// => Offset Adder
		ofsadden_o			<= 1'b0;
		din_dm_o			<= {32{1'b0}};
		base_addr_o			<= {`dm_addr_width{1'b0}};
		offset_addr_o		<= {`dm_addr_width{1'b0}};

		// => Execute => Register File
		addr_rd_o			<= {(`reg_addr_width){1'b0}};
		regfile_we_w_o		<= 1'b0;
		regfile_we_uhw_o	<= 1'b0;

		// => Execute => Branch
		branchen_o			<= 1'b0;
		branchtarget_o		<= {(`im_addr_width){1'b0}};
		condcode_o			<= {(`cond_code_width){1'b0}};
	
		// => Execute => Status Register	
		sr_we_o				<= 1'b0;

		end
	else
	begin
		// => ALU
		inmode_o			<= inmode;
		alumode_o			<= alumode;
		opmode_o			<= opmode;
		ce2_o				<= ce2;
		usemult_o 			<= ctr_imap_usemult;
		data_a_o			<= data_a;
		data_b_o			<= data_b;
		data_c_o			<= data_c;

		// => Data Memory
		dm_we_o				<= dm_we;
		dm_re_o				<= dm_re;

		// => Offset Adder
		ofsadden_o			<= ofsadden;
		din_dm_o			<= rf_imap_data_rc;
		base_addr_o			<= rf_imap_data_ra[`dm_addr_width-1:0];
		offset_addr_o		<= rf_imap_data_rb[`dm_addr_width-1:0];

		// => Execute => Register File
		addr_rd_o			<= addr_rd;
		regfile_we_w_o		<= regfile_we_w;		
		regfile_we_uhw_o	<= regfile_we_uhw;		

		// => Execute => Branch
		branchen_o			<= branchen;
		branchtarget_o		<= branchtarget;
		condcode_o			<= condcode;

		// => Execute => Status Register	
		sr_we_o				<= sr_we;

		end
end

endmodule
