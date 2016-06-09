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
* HuiYan Cheah 2016, hycheah1@e.ntu.edu.sg
* School of Computer Engineering
* Nanyang Technological University
*
	* This processor is a proof-of-concept of the usability of the DSP48E1 as
	* the execution unit of a general-purpose processor. It is not a full-blown processor.
	*
	* Description:
	* Maps the operands fetched from register to the inputs of the DSP48E1.
	* Combinational logic.
	* 

******************************************************************************************/
`include "defines.v"

module input_map (
	// control signals
	input wire usemult_i, 	// 0: non-mult 1:mult
	input wire useimm_i,  	// 0: reg 1:imm
	input wire sa_i,
	input wire se_i,
	input wire ze_i,
	input wire regwritepc_i,
	// data signals
	input wire [`IM_ADDR_WIDTH-1:0] pc_i,
	input wire [15:0] data_imm_i,
	input wire [`DATA_WIDTH-1:0] ra_readdata_i,
	input wire [`DATA_WIDTH-1:0] rb_readdata_i,
	input wire [`DATA_WIDTH-1:0] rc_readdata_i,
	output reg [`PORTAWIDTH-1:0] data_a_o,
	output reg [`PORTBWIDTH-1:0] data_b_o,
	output reg [`PORTCWIDTH-1:0] data_c_o
);

//reg [`PORTBWIDTH-1:0] qb_o_mux0, qb_o_mux1;
//reg [`PORTCWIDTH-1:0] qc_o_mux0;

// *** Route of input A ***

always@ (*)
	case ({usemult_i, useimm_i, se_i, ze_i}) // Input map needs to be re-designed: use of se and ze is very limited: only for ze sign-extending $signed(a:b)
	//	4'b0000: data_a_o = $signed(rb_readdata_i[31:18]);
		4'b1000: data_a_o = rb_readdata_i[24:0];	
	//	4'b1001: data_a_o = $unsigned(rb_readdata_i[24:0]);  // $unsigned no effect since the bit width is already 25 bits
	//	4'b1010: data_a_o = $signed(rb_readdata_i[24:0]);  // seriously no-brainer
		4'b0110: data_a_o = $signed(data_imm_i[15]);
		default: data_a_o = $signed(rb_readdata_i[31:18]);
	endcase

// *** Route of input B ***
/*
always@ (*)
	case ({usemult_i, useimm_i, sa_i})
		3'b000: qb_o_mux0 = rb_readdata_i[17:0];
		3'b010: qb_o_mux0 = rb_readdata_i[17:0];
		3'b100: qb_o_mux0 = ra_readdata_i[17:0];
		3'b101: qb_o_mux0 = $unsigned(data_imm_i[10:6]);
		default: qb_o_mux0 = rb_readdata_i[17:0];
	endcase

always@ (*)
	case ({usemult_i, useimm_i})
		2'b00: data_b_o = qb_o_mux0;
		2'b01: data_b_o = $signed(data_imm_i); 
		2'b10: data_b_o = qb_o_mux0;
		2'b11: data_b_o = qb_o_mux0;
		default: data_b_o = qb_o_mux0;
	endcase
*/

always@ (*)
	case ({usemult_i, useimm_i, sa_i})
		3'b010: data_b_o = $signed(data_imm_i[15:0]);
		3'b100: data_b_o = ra_readdata_i[17:0]; // synthesis: if i use this as [15:0], would it be better?
		3'b101: data_b_o = $unsigned(data_imm_i[10:6]); // sa
		3'b110: data_b_o = $signed(data_imm_i[15:0]);	// usemult, imm
		default: data_b_o = rb_readdata_i[17:0];
	endcase

// *** Route of input C ***

always@(*)
   	case (regwritepc_i)
		1'b0: data_c_o = $signed(ra_readdata_i); // the MSB is extended.
		1'b1: data_c_o = $unsigned(pc_i[`IM_ADDR_WIDTH-1:0]);
		default: data_c_o = $signed(ra_readdata_i);
	endcase

endmodule

