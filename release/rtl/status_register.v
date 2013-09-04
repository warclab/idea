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
	* Store the status flags of an outcome of an operation.
	* Under-utlized, may be removed in future revisions.
	*

******************************************************************************************/
`include "defines.v"

module status_register(
	input 							clk,
	input 							rst,
	input 							sr_we_i, 	// write enable for status register
	input [47:0] 					p_i,
	input [`cond_code_width-1:0] 	condcode_i, // from ALU, not inst mem
	output reg 						we_o 		// to control unit
    );

reg eq_o_reg, ne_o_reg, ge_o_reg, lt_o_reg, gt_o_reg, le_o_reg, al_o_reg; 

always@ (posedge clk)
begin
	if (rst)
	begin
		eq_o_reg <= 1'b0;
		ne_o_reg <= 1'b0;
		ge_o_reg <= 1'b0;
		lt_o_reg <= 1'b0;
		gt_o_reg <= 1'b0;
		le_o_reg <= 1'b0;
		al_o_reg <= 1'b0;
	end
	else if (sr_we_i)
	begin
		eq_o_reg <= ~(|p_i);
		ne_o_reg <= (|p_i);
		ge_o_reg <= ~p_i[47] || (~|p_i);
		lt_o_reg <= p_i[47];
		gt_o_reg <= ~p_i[47];
		le_o_reg <= p_i[47] || (~|p_i);
		al_o_reg <= 1'b1;
	end
	else
	begin
		eq_o_reg <= eq_o_reg;
		ne_o_reg <= ne_o_reg;
		ge_o_reg <= ge_o_reg;
		lt_o_reg <= lt_o_reg;
		gt_o_reg <= gt_o_reg;
		le_o_reg <= le_o_reg;
		al_o_reg <= al_o_reg;
	end
end

always@ (condcode_i or  eq_o_reg or ne_o_reg or ge_o_reg or lt_o_reg or gt_o_reg or le_o_reg or al_o_reg)	
begin
	case (condcode_i[`cond_code_width-1:0])
		`EQ: we_o = eq_o_reg;	// ~(0)
		`NE: we_o = ne_o_reg; 	// 1
		`GE: we_o = ge_o_reg; 
		`LT: we_o = lt_o_reg;  
		`GT: we_o = gt_o_reg; 
		`LE: we_o = gt_o_reg;	 
		`AL: we_o = al_o_reg;
		default: we_o = 1'b1;
	endcase
end

endmodule
