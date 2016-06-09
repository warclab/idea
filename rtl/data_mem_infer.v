`timescale 1ns / 1ps
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
