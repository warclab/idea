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
	* Instruction fetch module of the processor.
	* Consists of Program Counter, and Branch.
	*

******************************************************************************************/
`include "defines.v"

module fetch(
	
	// Input
	input 							clk,
	input 							rst,
	// For Branch	
	input 							branchen_i,
	input [`cond_code_width-1:0] 	condcode_i,
	input [`im_addr_width-1:0] 		branchtarget_i,
	input [47:0] 					p_i,
	input [`datawidth-1:0] 			inst_i,
	
	// Output
	// => Instruction Memory
	output [`im_addr_width-1:0] 	pc_o
	);

// Internal Wires
reg [`im_addr_width-1:0] 			pc;
reg									absbranchsel;
wire [`im_addr_width-1:0] 			absbranchpc; 
reg 								branchsel;
wire [`opcode_width-1:0] 			opcode;
wire 								bitwise_or_p, sign_bit_p;

// Absolute Branch Detect
assign opcode = inst_i[25:21];
assign absbranchpc = inst_i[`im_addr_width-1:0];

always@ (opcode)
begin
	if (opcode == `B)
		absbranchsel = 1'b1;
   else
		absbranchsel = 1'b0; 
end

// Conditional Branch
assign bitwise_or_p = (|p_i);
assign sign_bit_p = (p_i[47]);

always@ (bitwise_or_p or sign_bit_p or condcode_i or branchen_i)
begin
	if (branchen_i)
	begin
		case (condcode_i[`cond_code_width-1:0])
			`EQ: branchsel = ~bitwise_or_p;	// ~(0)
			`NE: branchsel = bitwise_or_p; 	// 1
			`GE: branchsel = ~sign_bit_p | ~bitwise_or_p; 
			`LT: branchsel = sign_bit_p;  
			`GT: branchsel = ~sign_bit_p; 
			`LE: branchsel = sign_bit_p | ~bitwise_or_p;	 
			`AL: branchsel = 1'b1;
			default: branchsel = 1'b0;
		endcase
	end
	else branchsel = 1'b0;
end

// Program Counter
always@ (posedge clk)
begin
	if (rst)
		pc <= 9'h000;
	else if (branchsel)
		pc <= branchtarget_i;
	else if (absbranchsel)
		pc <= absbranchpc;
	else
		pc <= pc + 1'b1;
end

// Instruction Memory
assign pc_o = pc;

endmodule
