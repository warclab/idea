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
