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
	* Maps the operands fetched from register to the inputs of the DSP48E1.
	* Combinational logic.
	* 

******************************************************************************************/

module input_map (
	// control signals
	input usemult_i, 	// 0: non-mult 1:mult
	input useimm_i,  	// 0: reg 1:imm
	input usemov_i,
	input seta0_i,	// set port a to 0s 	
	input setb0_i,	// set port b to 0s
	input setc0_i,	// set port b to 0s		
	// data signals
	input [`mult_data_width-1:0] data_imm_i,
	input [`datawidth-1:0] data_ra_i,
	input [`datawidth-1:0] data_rb_i,
	input [`datawidth-1:0] data_rc_i,
	output reg [`portawidth-1:0] data_a_o,
	output reg [`portbwidth-1:0] data_b_o,
	output reg [`portcwidth-1:0] data_c_o
);

reg [`portawidth-1:0] qa_o_mux0;
reg [`portbwidth-1:0] qb_o_mux0, qb_o_mux1;
reg [`portcwidth-1:0] qc_o_mux0;

// *** Route of input A ***
always@(usemult_i or data_rb_i)
   	case (usemult_i)
		1'b0: qa_o_mux0 = {{16{data_rb_i[31]}}, data_rb_i[31:18]};
		1'b1: qa_o_mux0 = {{14{data_rb_i[15]}}, data_rb_i[`mult_data_width-1:0]};
		default: qa_o_mux0 = {{16{data_rb_i[31]}}, data_rb_i[31:18]};
	endcase 

always@(seta0_i or qa_o_mux0)
   	case (seta0_i)
		1'b0: data_a_o = qa_o_mux0;
		1'b1: data_a_o = 30'h00000000;
		default: data_a_o = qa_o_mux0;
	endcase 

always@ (usemult_i or data_rb_i[17:0] or data_rc_i[15:0])
	case (usemult_i)
		1'b0: qb_o_mux0 = data_rb_i[17:0];
		1'b1: qb_o_mux0 = {{2{data_rc_i[15]}}, data_rc_i[`mult_data_width-1:0]};
		default: qb_o_mux0 = data_rb_i[17:0];
	endcase

always@ (useimm_i or qb_o_mux0 or data_imm_i[10:0])
	case (useimm_i)
		1'b0: qb_o_mux1 = qb_o_mux0;
		1'b1: qb_o_mux1 = {{7{data_imm_i[10]}}, data_imm_i[10:0]}; 
		default: qb_o_mux1 = qb_o_mux0;
	endcase

always@ (setb0_i or qb_o_mux1)
	case (setb0_i)
		1'b0: data_b_o = qb_o_mux1;
		1'b1: data_b_o = 18'h00000;
		default: data_b_o = qb_o_mux1;
	endcase

// *** Route of input C ***
// Everything could be configured by Z mux input
always@(usemov_i or data_ra_i or data_imm_i)
   	case (usemov_i)
		1'b0: qc_o_mux0 = {{16{data_ra_i[31]}}, data_ra_i}; // the MSB is extended.
		1'b1: qc_o_mux0 = {{32{data_imm_i[15]}}, data_imm_i[15:0]};
		default: qc_o_mux0 = {{16{data_ra_i[31]}}, data_ra_i};
	endcase

always@(setc0_i or qc_o_mux0 or data_ra_i)
   	case (setc0_i)
		1'b0: data_c_o = qc_o_mux0; // the MSB is extended.
		1'b1: data_c_o = 48'h000000000000;
		default: data_c_o = data_ra_i;
	endcase

endmodule

