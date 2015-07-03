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
	* Execute module of the processor.
	* Consists of the Execution Unit, and propagation stages.
	*

******************************************************************************************/
`include "defines.v"

module execute (
	
	// *******************************
	// ********** Input **************
	// *******************************
	input 					clk,
	input 					rst,
	// **** To regfile ****
	input 					regwrite_i,
	input 					regwriteui_i,
	input					sr_i,
	// **** To Data Memory ****
//	input [3:0]				dm_we_i,
   	input 					dm_re_i,

	// **** To Branch ****
	input 					branchen_i,
	input [2:0] 				branchtype_i, 
	input [15:0]		 		branchtarget_i,
	// **** To Execute 4 ****
	input					cmpsel_i,
	input [2:0]				loadtype_i,
	input [`DATA_WIDTH-1:0] 		dm_regfile_data_i,
	// **** To ALU ****
`ifdef EXTLOOPBACK
	input					extloopback_i,
`endif
	input [3:0] 				alumode_i,
	input [4:0] 				inmode_i,
	input [6:0]				opmode_i,
	input 					ce2_i,
	input					usemult_i,
	input [29:0] 				data_a_i,
	input [17:0] 				data_b_i,
	input [47:0] 				data_c_i,
	// **** To Propagate ****
	input [`REG_ADDR_WIDTH-1:0] 		rd_addr_i,
	
	// *******************************
	// ********** Output *************
	// *******************************
	// **** To Fetch/ Regfile ****
	output [36:0]	 			p_o,
	// **** To Regfile ****
	output 					regwrite_o,
	output 					regwriteui_o,
	output					sr_o,
	output [`REG_ADDR_WIDTH-1:0] 		regfile_addr_o,
	output 					dm_re_o,
	output 					cmpsel_o,
	output [2:0] 				loadtype_o,
	output [`DATA_WIDTH-1:0] 		dm_regfile_data_o,

	// **** To Data Memory ****
//	output [3:0]			dm_we_o,

	// **** To Branch ****
	output 				branchen_o,
	output [2:0] 			branchtype_o,
	output [15:0]		 	branchtarget_o
);

wire [`REG_ADDR_WIDTH-1:0] 	ex3_ex4_regfile_addr;
wire 				ex3_ex4_regwrite;
wire 				ex3_ex4_regwriteui;
wire				ex3_ex4_sr;
wire 				ex3_ex4_branchen;
wire [2:0] 			ex3_ex4_branchtype;
wire [15:0]		 	ex3_ex4_branchtarget;
wire				ex3_ex4_cmpsel;
wire [2:0]			ex3_ex4_loadtype;
wire [47:0] 			alu_ex4_p;

//assign dm_we_o = dm_we_i;

// Execution Unit
alu_core i_alu_core (
	.a_i			(data_a_i), 
	.alumode_i		(alumode_i), 
	.b_i			(data_b_i), 
	.c_i			(data_c_i), 
	.cea2_i			(ce2_i), 
	.ceb2_i			(ce2_i), 
	.clk			(clk), 
	.inmode_i		(inmode_i), 
`ifdef EXTLOOPBACK
	.extloopback_i		(extloopback_i),
`endif
	.opmode_i		(opmode_i), 
	.rst			(rst), 
	.usemult_i		(usemult_i), 
	.p_o			(alu_ex4_p)
);

alu_shreg i_alu_shreg (
	// Input
	.clk 			(clk),
	.rst 			(rst),
	.dm_re_i 		(dm_re_i), 
	.rd_addr_i 	        (rd_addr_i), 
	.regwrite_i         	(regwrite_i),
	.regwriteui_i       	(regwriteui_i),
	.sr_i			(sr_i),
	.branchen_i 		(branchen_i),
	.branchtarget_i 	(branchtarget_i),
	.branchtype_i 		(branchtype_i),     
	.cmpsel_i		(cmpsel_i),
	.loadtype_i		(loadtype_i),
	// Output
	.dm_re_o		(ex3_ex4_dm_re),
	.rd_addr_o 		(ex3_ex4_regfile_addr),
	.regwrite_o 		(ex3_ex4_regwrite),
	.regwriteui_o 		(ex3_ex4_regwriteui),
	.sr_o			(ex3_ex4_sr),
	.branchen_o 		(ex3_ex4_branchen),
	.branchtarget_o 	(ex3_ex4_branchtarget),
	.branchtype_o 		(ex3_ex4_branchtype),
	.cmpsel_o		(ex3_ex4_cmpsel),
	.loadtype_o		(ex3_ex4_loadtype)
);

ex_o_shreg i_ex_o_shreg (
	// Input
	.clk (clk),
	.rst (rst),
	.dm_re_i 		(ex3_ex4_dm_re),
	.rd_addr_i 		(ex3_ex4_regfile_addr),
	.regwrite_i 		(ex3_ex4_regwrite),
	.regwriteui_i 		(ex3_ex4_regwriteui),
	.sr_i			(ex3_ex4_sr),
	.branchen_i 		(ex3_ex4_branchen),
	.branchtarget_i 	(ex3_ex4_branchtarget),
	.branchtype_i 		(ex3_ex4_branchtype),
	.cmpsel_i		(ex3_ex4_cmpsel),
	.loadtype_i		(ex3_ex4_loadtype),
	.dm_regfile_data_i 	(dm_regfile_data_i),
	.p_i			({alu_ex4_p[47],alu_ex4_p[35:0]}),
	// Output
	.rd_addr_o 		(regfile_addr_o),
	.regwrite_o 		(regwrite_o),
	.regwriteui_o 		(regwriteui_o),
	.sr_o			(sr_o),
	.branchen_o 		(branchen_o),
	.branchtarget_o 	(branchtarget_o),
	.branchtype_o 		(branchtype_o),
	.dm_re_o 		(dm_re_o),
	.cmpsel_o		(cmpsel_o),
	.loadtype_o		(loadtype_o),
	.dm_regfile_data_o 	(dm_regfile_data_o),
	.p_o			(p_o)
);

endmodule
