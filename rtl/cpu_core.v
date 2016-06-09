`include "defines.v"

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

* iDEA Soft-Core Processor v1.00
* HuiYan Cheah, 2016 hycheah1@e.ntu.edu.sg
* School of Computer Engineering
* Nanyang Technological University
*
	* This processor is a proof-of-concept of the usability of the DSP48E1 as
	* the execution unit of a general-purpose processor. It is not a full-blown processor.
	*
	* Description:
	* The iDEA processor. Consists of fetch, decode and execute modules of the
	* processor. 
	* Memory is connected outside of this module.
	*

******************************************************************************************/

module cpu_core (
	
	// Input 
	input				clk,
	input				rst,
	// Instruction Memory
	input [`DATA_WIDTH-1:0] 	im_inst,
	output [`IM_ADDR_WIDTH-1:0] 	pc_o,
	// Data Memory
	input [`DATA_WIDTH-1:0] 	dm_readdata, // dm_dout_i,
	output [3:0] 			dm_we,
	output [`DM_ADDR_WIDTH-1:0] 	dm_addr,
	output [`DATA_WIDTH-1:0] 	dm_writedata// dm_din_o
);

// Decode => Execute
wire					id_ex_cmpsel;
wire [2:0]				id_ex_loadtype;
wire [6:0]			    	id_ex_opmode;
wire [4:0] 				id_ex_inmode;
wire [3:0] 				id_ex_alumode;
wire 					id_ex_ce2;
wire [`PORTAWIDTH-1:0] 			id_ex_data_a;
wire [`PORTBWIDTH-1:0] 			id_ex_data_b;
wire [`PORTCWIDTH-1:0] 			id_ex_data_c;
wire 					id_ex_usemult;
wire 					id_ex_regwrite;
wire					id_ex_regwriteui;
wire					id_ex_sr;
wire [`REG_ADDR_WIDTH-1:0] 		id_ex_rd_addr;
wire [3:0]				id_ex_dm_we;
wire 					id_ex_dm_re;
wire [`DATA_WIDTH-1:0]			id_ex_din_dm;
wire 					id_ex_branchen;
wire [15:0]		 		id_ex_branchtarget;
wire [2:0]		 		id_ex_branchtype;
wire [`DM_ADDR_WIDTH-1:0] 		id_ex_addr_base, id_ex_addr_offset;
`ifdef EXTLOOPBACK
wire					id_ex_extloopback;
`endif

// Execute => Decode
wire [36:0] 				ex_if_id_p;
wire 					ex_id_regwrite, ex_id_regwriteui;
wire 					ex_id_sr;
wire [`REG_ADDR_WIDTH-1:0] 		ex_id_rd_addr;
wire 					ex_id_cmpsel;
wire [2:0]				ex_id_loadtype;
wire 					ex_id_dm_re;
wire [`DATA_WIDTH-1:0] 			ex_dm_readdata;

// Execute => Fetch
wire [15:0]		 		ex_if_branchtarget;
wire 					ex_if_branchen;
wire [2:0]		 		ex_if_branchtype;

wire 					id_if_jumpregsel;
wire [15:0]				id_if_jumpregtarget;
wire [`IM_ADDR_WIDTH-1:0] 		pc;

// ******* Fetch ******
fetch i_fetch (
	// Input
	.clk			(clk), 
	.rst			(rst), 
	.branchen_i		(ex_if_branchen), 
	.branchtype_i		(ex_if_branchtype),
	.branchtarget_i		(ex_if_branchtarget),
	.p_i			(ex_if_id_p[31:0]),
	.sign_bit_i		(ex_if_id_p[36]), // 47
	.inst_i			(im_inst),
	.jumpregsel_i		(id_if_jumpregsel),
	.jumpregtarget_i	(id_if_jumpregtarget),
	// Output
	.pc_o 			(pc_o)
);

if_o_shreg i_if_o_shreg (
	.clk			(clk),
	.rst			(rst),
	.pc_i 			(pc_o),
	.pc_o 			(pc)
);

// ******* Decode ******
decode i_decode (

	// Input
	.clk 			(clk), 
	.rst 			(rst), 
	.pc_i			(pc),
	.inst_i 		(im_inst), 
	.regwrite_i 		(ex_id_regwrite), 
	.regwriteui_i 		(ex_id_regwriteui), 
	.sr_i			(ex_id_sr),
	.rd_addr_i 		(ex_id_rd_addr), 
	.cmpsel_i		(ex_id_cmpsel),
	.loadtype_i		(ex_id_loadtype),
	.dm_re_i		(ex_id_dm_re),
	.dm_readdata_i		(ex_dm_readdata),
	.p_i 			(ex_if_id_p[35:0]), 

	// Output
	// => Execute => Register file
	.rd_addr_o 		(id_ex_rd_addr), 
	.regwrite_o 		(id_ex_regwrite), 
	.regwriteui_o 		(id_ex_regwriteui), 
	.sr_o			(id_ex_sr),
	    
	// => Data Memory
	.dm_we_o 		(dm_we), 
	.dm_re_o 		(id_ex_dm_re), 
	.dm_addr_o		(dm_addr),
	.dm_writedata_o		(dm_writedata),
	    
	// => Execute => Branch
	.branchen_o 		(id_ex_branchen), 
	.branchtarget_o 	(id_ex_branchtarget), 
	.branchtype_o 		(id_ex_branchtype), 
	    
	// => ALU
`ifdef EXTLOOPBACK
	.extloopback_o		(id_ex_extloopback),
`endif
	.cmpsel_o		(id_ex_cmpsel),
	.loadtype_o		(id_ex_loadtype),
	.inmode_o 		(id_ex_inmode), 
	.alumode_o 		(id_ex_alumode), 
	.opmode_o 		(id_ex_opmode), 
	.ce2_o 			(id_ex_ce2), 
	.usemult_o 		(id_ex_usemult),
	.data_a_o 		(id_ex_data_a), 
	.data_b_o 		(id_ex_data_b), 
	.data_c_o 		(id_ex_data_c),
	.jumpregsel_o		(id_if_jumpregsel),
	.jumpregtarget_o	(id_if_jumpregtarget)
);


// ****** Execute ******
// DSP ALU
execute i_execute (

	// Input
	.clk 			(clk), 
	.rst 			(rst), 
	.regwrite_i 		(id_ex_regwrite), 
	.regwriteui_i 		(id_ex_regwriteui), 
	.sr_i			(id_ex_sr),
	.dm_re_i 		(id_ex_dm_re), 
	.branchen_i 		(id_ex_branchen), 
	.branchtarget_i		(id_ex_branchtarget), 
	.branchtype_i		(id_ex_branchtype), 
	// => Execute => EX4
`ifdef EXTLOOPBACK
	.extloopback_i		(id_ex_extloopback),
`endif
	.dm_regfile_data_i 	(dm_readdata), 
	.cmpsel_i		(id_ex_cmpsel),
	.loadtype_i		(id_ex_loadtype),
	.alumode_i 		(id_ex_alumode), 
	.inmode_i 		(id_ex_inmode), 
	.opmode_i 		(id_ex_opmode), 
	.ce2_i 			(id_ex_ce2), 
	.usemult_i 		(id_ex_usemult), 
	.data_a_i 		(id_ex_data_a), 
	.data_b_i 		(id_ex_data_b), 
	.data_c_i 		(id_ex_data_c), 
	.rd_addr_i 		(id_ex_rd_addr), 

	// Output
	.p_o 			(ex_if_id_p), 
	.regwrite_o 		(ex_id_regwrite), 
	.regwriteui_o 		(ex_id_regwriteui), 
	.sr_o			(ex_id_sr),
	.regfile_addr_o 	(ex_id_rd_addr), 

	// => DM
	.branchen_o 		(ex_if_branchen), 
	.branchtarget_o		(ex_if_branchtarget), 
	.branchtype_o		(ex_if_branchtype), 
	.cmpsel_o		(ex_id_cmpsel),
	.loadtype_o		(ex_id_loadtype),
	.dm_re_o		(ex_id_dm_re),
	.dm_regfile_data_o	(ex_dm_readdata)

);

endmodule
