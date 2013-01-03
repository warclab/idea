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
	* Data Memory of size 512 x 32.
	* Block RAM is inferred through behavioural description.
	* Inferred Block RAM mode is No Change to obtain maximum frequency.
	* Internal output register is enabled.
	*

******************************************************************************************/
`include "defines.v"

module data_mem (
	input 						clk,
	input 						we_i,
	input [`dm_addr_width-1:0] 	addr_i,
	input [31:0] 				din_i,
	output reg [31:0] 			dout_o
    );

	reg [31:0] 					ram0 [0:`dm_depth-1];
	reg [31:0] 					dout_r0;

	always@ (posedge clk) // No change
	begin
		if (we_i)
			ram0[addr_i] <= din_i;
		else	
			dout_r0 <= ram0[addr_i];
	end
	
	always@ (posedge clk)
	begin
			dout_o <= dout_r0;
	end

endmodule
