/******************************************************************************************
 iDEA Soft-Core Processor v2.00
* Copyright (C) by HuiYan Cheah 2014 hycheah1@e.ntu.edu.sg
* School of Computer Engineering
* Nanyang Technological University
*
	* This processor is a proof-of-concept of the usability of the DSP48E1 as
	* the execution unit of a general-purpose processor. It is not a full-blown processor.
	*
	* Description:
	* Propagates data and control signals that are not used in the execution
	* unit to the next stage.
	*

******************************************************************************************/
`include "defines.v"

module alu_shreg #(
	parameter p = 3
)
(
	input wire				clk,
	input wire				rst,	
	input wire [3:0]			dm_re_i,
	input wire [`REG_ADDR_WIDTH-1:0]	rd_addr_i,
	input wire				regwrite_i,
	input wire				regwriteui_i,
	input wire [1:0]			regwritehilo_i,
	input wire				sr_i,
	input wire				branchen_i,
	input wire [2:0]			branchtype_i,
	input wire [15:0]		 	branchtarget_i,
	input wire				cmpsel_i,

	output reg [3:0]			dm_re_o, // should be named as sel_dm
	output reg [`REG_ADDR_WIDTH-1:0] 	rd_addr_o,
	output reg 				regwrite_o,
	output reg 				regwriteui_o,
	output reg [1:0]			regwritehilo_o,
	output reg 				sr_o,
	output reg 				branchen_o,
	output reg [2:0]			branchtype_o,
	output reg [15:0]		 	branchtarget_o,
	output reg				cmpsel_o

);

reg [3:0]			shreg_dm_re[0:p];
reg [`REG_ADDR_WIDTH-1:0]	shreg_rd_addr[0:p];
reg 				shreg_regwrite[0:p];
reg				shreg_regwriteui[0:p];
reg [1:0]			shreg_regwritehilo[0:p];
reg				shreg_sr[0:p];
reg				shreg_branchen[0:p];
reg [2:0]			shreg_branchtype[0:p];
reg [15:0]			shreg_branchtarget[0:p];
reg				shreg_cmpsel[0:p];

	always@ (*) // Input
	begin
		shreg_dm_re[0] 			= dm_re_i;
		shreg_rd_addr[0] 		= rd_addr_i;
		shreg_regwrite[0] 		= regwrite_i;
		shreg_regwriteui[0] 		= regwriteui_i;
		shreg_regwritehilo[0]		= regwritehilo_i;
		shreg_sr[0]	 		= sr_i;
		shreg_branchen[0] 		= branchen_i;
		shreg_branchtype[0] 		= branchtype_i;
		shreg_branchtarget[0] 		= branchtarget_i;
		shreg_cmpsel[0]			= cmpsel_i;
	end

	always@ (*) // Ouput
	begin
		dm_re_o 			= shreg_dm_re[p];
		rd_addr_o 			= shreg_rd_addr[p];
		regwrite_o 			= shreg_regwrite[p];
		regwriteui_o 			= shreg_regwriteui[p];
		regwritehilo_o			= shreg_regwritehilo[p];
		sr_o	 			= shreg_sr[p];
		branchen_o 			= shreg_branchen[p];
		branchtype_o 			= shreg_branchtype[p];
		branchtarget_o 			= shreg_branchtarget[p];
		cmpsel_o			= shreg_cmpsel[p];
	end

	genvar i;
	generate
	for (i = 0; i < p; i = i + 1)
	begin: shregister_alu_shreg
		always@ (posedge clk)
		begin
			if (rst)
			begin
				shreg_dm_re[i+1]		<= {4{1'b0}};
				shreg_rd_addr[i+1] 		<= {`REG_ADDR_WIDTH{1'b0}};
				shreg_regwrite[i+1] 		<= 1'b0;
				shreg_regwriteui[i+1] 		<= 1'b0;
				shreg_regwritehilo[i+1]		<= {2{1'b0}};
				shreg_sr[i+1]	 		<= 1'b0;
				shreg_branchen[i+1] 		<= 1'b0;
				shreg_branchtype[i+1] 		<= {3{1'b0}};
				shreg_branchtarget[i+1]		<= {16{1'b0}};
				shreg_cmpsel[i+1]		<= 1'b0;
			end
			else
			begin
				shreg_dm_re[i+1] 		<= shreg_dm_re[i];
				shreg_rd_addr[i+1] 		<= shreg_rd_addr[i];
				shreg_regwrite[i+1] 		<= shreg_regwrite[i];
				shreg_regwriteui[i+1] 		<= shreg_regwriteui[i];
				shreg_regwritehilo[i+1]		<= shreg_regwritehilo[i];
				shreg_sr[i+1]	 		<= shreg_sr[i];
				shreg_branchen[i+1] 		<= shreg_branchen[i];
				shreg_branchtype[i+1] 		<= shreg_branchtype[i];
				shreg_branchtarget[i+1] 	<= shreg_branchtarget[i];
				shreg_cmpsel[i+1]		<= shreg_cmpsel[i];
			end
		end
	end
	endgenerate

endmodule
