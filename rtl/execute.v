`include "defines.v"
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

module execute (
	
	// *******************************
	// ********** Input **************
	// *******************************
	input 							clk,
	input 							rst,
	// **** To regfile ****
	input 							regfile_we_w_i,
	input 							regfile_we_uhw_i,
	// **** To Data Memory ****
	input 							dm_we_i,
   	input 							dm_re_i,
	// **** To Offset Adder ****
	input 							ofsadden_i,
	input [`dm_addr_width-1:0] 		addr_base_i,
	input [`dm_addr_width-1:0] 		addr_offset_i,
	input [`datawidth-1:0] 			din_dm_i,
	// **** To Branch ****
	input 							branchen_i,
	input [`cond_code_width-1:0] 	condcode_i, 
	input [`im_addr_width-1:0] 		branchtrgt_i,
	// **** To Status Register ****
	input 							sr_we_i,
	// **** To Execute 4 ****
	input [`datawidth-1:0] 			dm_regfile_data_i,
	// **** To ALU ****
	input [3:0] 					alumode_i,
	input [4:0] 					inmode_i,
	input [6:0]					 	opmode_i,
	input 							ce2_i,
	input							usemult_i,
	input [29:0] 					data_a_i,
	input [17:0] 					data_b_i,
	input [47:0] 					data_c_i,
	// **** To Propagate ****
	input [`reg_addr_width-1:0] 	addr_rd_i,
	
	// *******************************
	// ********** Output *************
	// *******************************
	// **** To Fetch/ Regfile ****
	output [47:0]	 				p_o,
	// **** To Regfile ****
	output 							regfile_we_w_o,
	output 							regfile_we_uhw_o,
	output [`reg_addr_width-1:0] 	regfile_addr_o,
	// **** To Data Memory ****
	output 							dm_we_o,
	output [`dm_addr_width-1:0] 	ofs_dm_addr_o,
	output [`datawidth-1:0] 		ofs_dm_data_o,
	// **** To Branch ****
	output 							branchen_o,
	// **** To Branch/ Status Register ****
	output [`cond_code_width-1:0] 	condcode_o,
	output [`im_addr_width-1:0] 	branchtrgt_o,
	// **** To Status Register ****
	output sr_we_o
);

// From EX1
wire 						ex1_dm_we; 
wire						ex1_ex2_dm_re, ex2_ex3_dm_re, ex3_ex4_dm_re;
wire [`reg_addr_width-1:0] 	ex1_ex2_regfile_addr;
wire 						ex1_ex2_regfile_we_w;
wire 						ex1_ex2_regfile_we_uhw;
wire 						ex1_ex2_branchen;
wire [`cond_code_width-1:0] ex1_ex2_condcode;
wire [`im_addr_width-1:0] 	ex1_ex2_branchtrgt;
wire 						ex1_ex2_sr_we;
// From EX2
wire [`reg_addr_width-1:0] 	ex2_ex3_regfile_addr;
wire						ex2_ex3_regfile_we_w; 
wire 						ex2_ex3_regfile_we_uhw;
wire 						ex2_ex3_branchen;
wire [`cond_code_width-1:0] ex2_ex3_condcode;
wire [`im_addr_width-1:0] 	ex2_ex3_branchtrgt;
wire 						ex2_ex3_sr_we;
// From EX3
wire [`reg_addr_width-1:0] 	ex3_ex4_regfile_addr;
wire 						ex3_ex4_regfile_we_w;
wire 						ex3_ex4_regfile_we_uhw;
wire 						ex3_ex4_branchen;
wire [`cond_code_width-1:0] ex3_ex4_condcode;
wire [`im_addr_width-1:0] 	ex3_ex4_branchtrgt;
wire 						ex3_ex4_sr_we;
wire [47:0] 				alu_ex4_p;

// Memory Address Generator
// TODO: Remove from this module and place in the same module as data memory.
// Functionally correct here. Just physically may cause confusion.
offset_add i_offset_add (
	.rst 					(rst),
	.clk 					(clk),
	.en_i 					(ofsadden_i),
	.data_ra_i 				(addr_base_i),
	.data_rb_i 				(addr_offset_i),
	.data_rc_i 				(din_dm_i),
	.addr_datamem_o 		(ofs_dm_addr_o), 
	.data_datamem_o 		(ofs_dm_data_o)
);

// Execution Unit
alu_core i_alu_core (
    .a_i					(data_a_i), 
    .alumode_i				(alumode_i), 
    .b_i					(data_b_i), 
    .c_i					(data_c_i), 
    .cea2_i					(ce2_i), 
    .ceb2_i					(ce2_i), 
    .clk					(clk), 
    .inmode_i				(inmode_i), 
    .opmode_i				(opmode_i), 
    .rst					(rst), 
    .usemult_i				(usemult_i), 
    .p_o					(alu_ex4_p)
);

// Propagation Stages
ex1 i_ex1 (
	// Input
	.clk 					(clk),
	.rst 					(rst),
	.dm_we_i 				(dm_we_i),
	.dm_re_i 				(dm_re_i), 
	.addr_rd_i 				(addr_rd_i), 
	.regfile_we_w_i 		(regfile_we_w_i),
	.regfile_we_uhw_i 		(regfile_we_uhw_i),
	.branchen_i 			(branchen_i),
	.condcode_i 			(condcode_i),
	.branchtrgt_i 			(branchtrgt_i), 
	.sr_we_i 				(sr_we_i),
	// Output
	.dm_we_o 				(dm_we_o),
	.dm_re_o 				(ex1_ex2_dm_re),
	.addr_rd_o 				(ex1_ex2_regfile_addr), 
	.regfile_we_w_o 		(ex1_ex2_regfile_we_w),
	.regfile_we_uhw_o 		(ex1_ex2_regfile_we_uhw),
	.branchen_o 			(ex1_ex2_branchen),
	.condcode_o 			(ex1_ex2_condcode),
	.branchtrgt_o 			(ex1_ex2_branchtrgt),
	.sr_we_o 				(ex1_ex2_sr_we)
);

ex2 i_ex2 (
	// Input
	.clk 					(clk),
	.rst 					(rst),
	.dm_re_i 				(ex1_ex2_dm_re),
	.addr_rd_i 				(ex1_ex2_regfile_addr),
	.regfile_we_w_i 		(ex1_ex2_regfile_we_w),
	.regfile_we_uhw_i 		(ex1_ex2_regfile_we_uhw),
	.branchen_i 			(ex1_ex2_branchen),
	.condcode_i 			(ex1_ex2_condcode),
	.branchtrgt_i 			(ex1_ex2_branchtrgt), 
	.sr_we_i 				(ex1_ex2_sr_we),
	// Output
	.dm_re_o				(ex2_ex3_dm_re),
	.addr_rd_o 				(ex2_ex3_regfile_addr), 
	.regfile_we_w_o 		(ex2_ex3_regfile_we_w),
	.regfile_we_uhw_o 		(ex2_ex3_regfile_we_uhw),
	.branchen_o 			(ex2_ex3_branchen),
	.condcode_o 			(ex2_ex3_condcode),
	.branchtrgt_o 			(ex2_ex3_branchtrgt),
	.sr_we_o 				(ex2_ex3_sr_we)
);

ex3 i_ex3 (
	// Input
	.clk 					(clk),
	.rst 					(rst),
	.dm_re_i 				(ex2_ex3_dm_re),
	.addr_rd_i 				(ex2_ex3_regfile_addr),
	.regfile_we_w_i 		(ex2_ex3_regfile_we_w),
	.regfile_we_uhw_i 		(ex2_ex3_regfile_we_uhw),
	.branchen_i 			(ex2_ex3_branchen),
	.condcode_i 			(ex2_ex3_condcode),
	.branchtrgt_i 			(ex2_ex3_branchtrgt), 
	.sr_we_i 				(ex2_ex3_sr_we),
	// Output
	.dm_re_o 				(ex3_ex4_dm_re),
	.addr_rd_o 				(ex3_ex4_regfile_addr),
	.regfile_we_w_o 		(ex3_ex4_regfile_we_w),
	.regfile_we_uhw_o 		(ex3_ex4_regfile_we_uhw),
	.branchen_o 			(ex3_ex4_branchen),
	.condcode_o 			(ex3_ex4_condcode),
	.branchtrgt_o 			(ex3_ex4_branchtrgt),
	.sr_we_o 				(ex3_ex4_sr_we)
);

ex4 i_ex4 ( 
	// Input
	.clk 					(clk),
	.rst 					(rst),
	.dm_re_i 				(ex3_ex4_dm_re),
	.addr_rd_i 				(ex3_ex4_regfile_addr),
	.regfile_we_w_i 		(ex3_ex4_regfile_we_w),
	.regfile_we_uhw_i 		(ex3_ex4_regfile_we_uhw),
	.branchen_i 			(ex3_ex4_branchen),
	.condcode_i 			(ex3_ex4_condcode),
	.branchtrgt_i 			(ex3_ex4_branchtrgt), 
	.sr_we_i 				(ex3_ex4_sr_we),
	.dm_regfile_data_i 		(dm_regfile_data_i),
	.p_i					(alu_ex4_p),
	// Output
	.addr_rd_o 				(regfile_addr_o),
	.regfile_we_w_o 		(regfile_we_w_o),
	.regfile_we_uhw_o 		(regfile_we_uhw_o),
	.branchen_o 			(branchen_o),
	.condcode_o 			(condcode_o),
	.branchtrgt_o 			(branchtrgt_o),
	.sr_we_o 				(sr_we_o),
	.p_o					(p_o)
);

endmodule
