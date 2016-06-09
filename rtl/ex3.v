`include "defines.v"
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

* iDEA Soft-Core Processor v1.00
* HuiYan Cheah 2016, hycheah1@e.ntu.edu.sg
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

module ex3 (

	input 								clk,
	input 								rst,	
	input 								dm_re_i,
	input [`reg_addr_width-1:0] 		addr_rd_i,
	input 								regfile_we_w_i,
	input 								regfile_we_uhw_i,
	input 								branchen_i,
	input [`cond_code_width-1:0] 		condcode_i,
	input [`im_addr_width-1:0] 			branchtrgt_i,
	input 								sr_we_i,

	output reg 							dm_re_o,
	output reg [`reg_addr_width-1:0] 	addr_rd_o,
	output reg 							regfile_we_w_o,
	output reg 							regfile_we_uhw_o,
	output reg 							branchen_o,
	output reg [`cond_code_width-1:0] 	condcode_o,
	output reg [`im_addr_width-1:0] 	branchtrgt_o,
	output reg 							sr_we_o

);

always@ (posedge clk)
begin
	if (rst)
	begin
		dm_re_o 						<= 1'b0;
		addr_rd_o 						<= {`reg_addr_width{1'b0}};
		regfile_we_w_o 					<= 1'b0;
		regfile_we_uhw_o 				<= 1'b0;
		branchen_o 						<= 1'b0;
		condcode_o 						<= {`cond_code_width{1'b0}};
		branchtrgt_o 					<= {`im_addr_width{1'b0}};
		sr_we_o 						<= 1'b0;
	end
	else
	begin
		dm_re_o 						<= dm_re_i;
		addr_rd_o 						<= addr_rd_i;
		regfile_we_w_o 					<= regfile_we_w_i;
		regfile_we_uhw_o 				<= regfile_we_uhw_i;
		branchen_o 						<= branchen_i;
		condcode_o 						<= condcode_i;
		branchtrgt_o 					<= branchtrgt_i;
		sr_we_o 						<= sr_we_i;
	end
end

endmodule
