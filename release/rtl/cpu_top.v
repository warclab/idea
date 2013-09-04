`timescale 1ns / 1ps
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
	* Top level wrapper of the processor. Consists of Instruction Memory, Data
	* Memory and CPU.

******************************************************************************************/

`include "defines.v"

module cpu_top(
	input clk,
	input rst,
	output dummy
    );

wire [`im_addr_width-1:0] 	cpu_im_pc;	
wire 						cpu_dm_we;
wire [`datawidth-1:0] 		cpu_dm_din;
wire [`dm_addr_width-1:0] 	cpu_dm_ofs_addr;
wire [`datawidth-1:0] 		dm_cpu_ex4_regfile_data;
wire [`datawidth-1:0] 		im_cpu_inst;

assign dummy = im_cpu_inst[0];

// Instruction Memory
inst_mem i_inst_mem (
    .clk					(clk), 
    .addr_i					(cpu_im_pc), 
    .dout_o					(im_cpu_inst)
    );

// Data Memory
data_mem i_data_mem (
	// Input
	.clk 					(clk),
	.we_i 					(cpu_dm_we),
	.addr_i 				(cpu_dm_ofs_addr), 
	.din_i 					(cpu_dm_din), 
	// Output
	.dout_o 				(dm_cpu_ex4_regfile_data) 
	);
	
// CPU
cpu_core i_cpu_core (
	// Input
    .clk					(clk), 
    .rst					(rst), 
	.im_inst_i				(im_cpu_inst),
	.dm_dout_i			 	(dm_cpu_ex4_regfile_data),
	// Output
    .pc_o					(cpu_im_pc),
	.dm_we_o 				(cpu_dm_we),
	.dm_addr_o			 	(cpu_dm_ofs_addr),
	.dm_din_o				(cpu_dm_din)
    );
	 
endmodule
