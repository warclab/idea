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
* HuiYan Cheah 2016, hycheah1@e.ntu.edu.sg
* School of Computer Engineering
* Nanyang Technological University
*
	* This processor is a proof-of-concept of the usability of the DSP48E1 as
	* the execution unit of a general-purpose processor. It is not a full-blown processor.
	*
	* Description:
	* Calcutes the address for data memory access for store or load.
	*

******************************************************************************************/
`include "defines.v"

module offset_add(
	input 								rst,
	input 								clk,
	input 								en_i,
	input [`dm_addr_width-1:0] 			data_ra_i,
	input [`dm_addr_width-1:0] 			data_rb_i,
	input [`datawidth-1:0] 				data_rc_i,
	output reg [`dm_addr_width-1:0] 	addr_datamem_o,
	output reg [`datawidth-1:0] 		data_datamem_o
    );

reg [`dm_addr_width-1:0] 				addr_datamem;
reg [`datawidth-1:0] 					data_datamem;

always@(en_i or data_ra_i or data_rb_i or data_rc_i)
begin
	if (en_i)
	begin
		addr_datamem = data_ra_i + data_rb_i;
		data_datamem = data_rc_i;
	end
	else
	begin
		addr_datamem = data_ra_i;
		data_datamem = data_rc_i;
	end
end

always@ (posedge clk)
begin
	if (rst)
	begin
		addr_datamem_o <= {`dm_addr_width{1'b0}};
		data_datamem_o <= {`datawidth{1'b0}};
	end
	else
	begin
		addr_datamem_o <= addr_datamem;
		data_datamem_o <= data_datamem;
	end
end

endmodule
