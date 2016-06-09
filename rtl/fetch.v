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
	* Instruction fetch module of the processor.
	* Consists of Program Counter, and Branch.
	*

******************************************************************************************/
`include "defines.v"

`define J 6'b000010
`define JAL 6'b000011

`define EQ 3'b100 
`define NE 3'b101
`define GE 3'b010
`define LT 3'b001
`define GT 3'b111
`define LE 3'b110

module fetch(
	
	// Input
	input 				clk,
	input 				rst,
	// For Branch	
	input [2:0]			branchtype_i,
	input 				branchen_i,
	input [15:0]			branchtarget_i, // Max is 16 bits
	input 				jumpregsel_i,
	input [15:0]			jumpregtarget_i,
	input [`DATA_WIDTH-1:0]		p_i, // 
	input [`DATA_WIDTH-1:0] 	inst_i, // where is this from? -- data mem
	input 				sign_bit_i,
	
	// Output
	// => Instruction Memory
	output [`IM_ADDR_WIDTH-1:0] 	pc_o
	);

// Internal Wires
reg [`IM_ADDR_WIDTH-1:0] 		pc;
reg					jumpsel;
wire [25:0]		 		jumptarget; 
reg 					branchsel;
wire [5:0]		 		opcode;
wire 					zero;

// Absolute Branch Detect
assign opcode = inst_i[31:26];
assign jumptarget = inst_i[25:0];

always@ (opcode)
begin
	if (opcode == `J || opcode == `JAL)
		jumpsel = 1'b1; // PCSrc
   	else
		jumpsel = 1'b0; 
end

// Conditional Branch 
assign zero = ~(|p_i[31:0]);

always@ (*)
begin
	case (branchtype_i)
		`EQ/*100*/: branchsel = zero & branchen_i;
		`GE/*010*/: branchsel = /*Greater than*/ (~sign_bit_i & ~zero) | /*Equal*/ (zero) & branchen_i;
		`GT/*111*/: branchsel = ~sign_bit_i & ~zero & branchen_i;
		`LE/*110*/: branchsel = /*Less than*/ sign_bit_i | /*Equal*/ (zero) & branchen_i;
		`LT/*001*/: branchsel = sign_bit_i & branchen_i;
		`NE/*3'b101*/: branchsel = ~zero & branchen_i;
		default: branchsel = 1'b0;
	endcase
end

// Program Counter
always@ (posedge clk) // This is meant to be priority
begin
	if (rst)
		pc <= {(`IM_ADDR_WIDTH){1'b0}};
	else if (branchsel) // PCSrc
		pc <= branchtarget_i;
	else if (jumpsel) // PCSrc
		pc <= jumptarget; // PCJumpAddrImm
	else if (jumpregsel_i)
		pc <= jumpregtarget_i;
	else
		pc <= pc + 1'b1;
end

// Instruction Memory
assign pc_o = pc;

endmodule
