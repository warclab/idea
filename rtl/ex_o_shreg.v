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
	* Propagates data and control signals back to fetch or register file.
	*

******************************************************************************************/
`include "defines.v"


module ex_o_shreg #(
	parameter n = 1
)
(
	input wire			clk,
	input wire			rst,	
	input wire [3:0]		dm_re_i,
	input wire [`REG_ADDR_WIDTH-1:0] rd_addr_i,
	input wire			regwrite_i, 
	input wire			regwriteui_i, 
	input wire [1:0]		regwritehilo_i,
	input wire			sr_i,
	input wire			branchen_i,
	input wire [2:0] 		branchtype_i,
	input wire [15:0] 		branchtarget_i,
	input wire [`DATA_WIDTH-1:0] 	dm_regfile_data_i, 
	input wire			cmpsel_i,
	input wire [36:0]		p_i,

	output reg [`REG_ADDR_WIDTH-1:0] rd_addr_o,
	output reg 			regwrite_o,
	output reg 			regwriteui_o,
	output reg [1:0]		regwritehilo_o,
	output reg			sr_o,
	output reg 			branchen_o,
	output reg [2:0] 		branchtype_o,
	output reg [15:0] 		branchtarget_o,
	output reg [36:0]		p_o,
	output reg			cmpsel_o,
	output reg [3:0]		dm_re_o,
	output reg [`DATA_WIDTH-1:0]	dm_regfile_data_o
);

	reg [`REG_ADDR_WIDTH-1:0]		shreg_rd_addr[0:n];
	reg 					shreg_regwrite[0:n];
	reg					shreg_regwriteui[0:n];
	reg [1:0]				shreg_regwritehilo[0:n];
	reg					shreg_sr[0:n];
	reg					shreg_branchen[0:n];
	reg [2:0]				shreg_branchtype[0:n];
	reg [15:0]				shreg_branchtarget[0:n];
	reg					shreg_cmpsel[0:n];
	reg [36:0]				shreg_p[0:n];
	reg [`DATA_WIDTH-1:0] 			shreg_dm_regfile_data[0:n]; 
	reg [3:0]		 		shreg_dm_re[0:n]; 

	always@ (*) // Input
	begin
		shreg_rd_addr[0] 		= rd_addr_i;
		shreg_regwrite[0] 		= regwrite_i;
		shreg_regwriteui[0] 		= regwriteui_i;
		shreg_regwritehilo[0]		= regwritehilo_i;
		shreg_sr[0] 			= sr_i;
		shreg_branchen[0] 		= branchen_i;
		shreg_branchtype[0] 		= branchtype_i;
		shreg_branchtarget[0] 		= branchtarget_i;
		shreg_cmpsel[0]			= cmpsel_i;
		shreg_p[0]			= p_i;
		shreg_dm_re[0] 			= dm_re_i;
		shreg_dm_regfile_data[0]	= dm_regfile_data_i;
	end

	always@ (*) // Ouput
	begin
		dm_re_o 		= shreg_dm_re[n];
		rd_addr_o 		= shreg_rd_addr[n];
		regwrite_o 		= shreg_regwrite[n];
		regwriteui_o 		= shreg_regwriteui[n];
		regwritehilo_o		= shreg_regwritehilo[n];
		sr_o 			= shreg_sr[n];
		branchen_o 		= shreg_branchen[n];
		branchtype_o 		= shreg_branchtype[n];
		branchtarget_o 		= shreg_branchtarget[n];
		cmpsel_o		= shreg_cmpsel[n];
		p_o			= shreg_p[n];
		dm_re_o 		= shreg_dm_re[n];
		dm_regfile_data_o	= shreg_dm_regfile_data[n];
	end

	genvar i;
	generate
	for (i = 0; i < n; i = i + 1)
	begin: shregister_ex_o
		always@ (posedge clk)
		begin
			if (rst)
			begin
				shreg_rd_addr[i+1] 		<= {`REG_ADDR_WIDTH{1'b0}};
				shreg_regwrite[i+1] 		<= 1'b0;
				shreg_regwriteui[i+1] 		<= 1'b0;
				shreg_regwritehilo[i+1]		<= {2{1'b0}};
				shreg_sr[i+1] 			<= 1'b0;
				shreg_branchen[i+1] 		<= 1'b0;
				shreg_branchtype[i+1] 		<= {3{1'b0}};
				shreg_branchtarget[i+1]		<= {`IM_ADDR_WIDTH{1'b0}};
				shreg_cmpsel[i+1]		<= 1'b0;
				shreg_dm_re[i+1]		<= {4{1'b0}};
				shreg_p[i+1]			<= {36{1'b0}};
				shreg_dm_regfile_data[i+1]	<= {`DATA_WIDTH{1'b0}};
			end
			else
			begin
				shreg_cmpsel[i+1]		<= shreg_cmpsel[i];
				shreg_rd_addr[i+1] 		<= shreg_rd_addr[i];
				shreg_regwrite[i+1] 		<= shreg_regwrite[i];
				shreg_regwriteui[i+1] 		<= shreg_regwriteui[i];
				shreg_regwritehilo[i+1]		<= shreg_regwritehilo[i];
				shreg_sr[i+1]		 	<= shreg_sr[i];
				shreg_branchen[i+1] 		<= shreg_branchen[i];
				shreg_branchtype[i+1] 		<= shreg_branchtype[i];
				shreg_branchtarget[i+1] 	<= shreg_branchtarget[i];
				shreg_dm_re[i+1]		<= shreg_dm_re[i];
				shreg_p[i+1]			<= shreg_p[i];
				shreg_dm_regfile_data[i+1]	<= shreg_dm_regfile_data[i];
			end
		end
	end
	endgenerate

endmodule

