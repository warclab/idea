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
	* Description:
	* Top level wrapper of the processor. Consists of Instruction Memory, Data
	* Memory and CPU.

******************************************************************************************/
// Is there a cleaner way to handle defines and parameters for both verification and synthesis?

`define INSTMEM_P 3 	// IF - to set pipeline of IF p = 1, 2, 3, n
`define DEC_O_P 1 	// ID - n = 0, 1, 2, n
`define DEC_INTER 0	// ID - p = 0, 1
`define ALU3 		// ALU1, ALU2, ALU3
`define EX_O_P 1	// EX - to set output pipeline of ALU p = 0, 1, 2
// WB 1

`include "defines.v"
 
module cpu_top(
	input clk,
	input rst,
	output dummy
    );

	defparam i_inst_mem.p = `INSTMEM_P;	
	defparam i_cpu_core.i_if_o_shreg.n = `INSTMEM_P;	
	defparam i_cpu_core.i_decode.n = `DEC_O_P; 
	defparam i_cpu_core.i_decode.i_id_shreg.p = `DEC_INTER;
	defparam i_cpu_core.i_execute.i_ex_o_shreg.n = `EX_O_P;

`ifdef ALU1
	defparam i_data_mem.p = 1;
	defparam i_cpu_core.i_execute.i_alu_shreg.p = 1;
	// ALU_P1
	defparam i_cpu_core.i_execute.i_alu_core.p_acascreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_adreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_alumodereg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_areg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_bcascreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_breg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_carryinreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_carryinselreg 	= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_creg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_dreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_inmodereg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_mreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_opmodereg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_preg 		= 1; // option: 0, 1
	defparam i_cpu_core.i_execute.i_alu_core.p_cea1 		= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_ceb1 		= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_cec 			= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_cealumode 		= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_ceinmode 		= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_ceopmode 		= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_cem 			= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_cep 			= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_nalupipe		= "P1";
`endif

`ifdef ALU2
	defparam i_data_mem.p = 2;
	defparam i_cpu_core.i_execute.i_alu_shreg.p = 2;
	// ALU_P2
	defparam i_cpu_core.i_execute.i_alu_core.p_acascreg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_adreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_alumodereg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_areg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_bcascreg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_breg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_carryinreg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_carryinselreg 	= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_creg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_dreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_inmodereg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_mreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_opmodereg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_preg 		= 1; // option: 0, 1
	defparam i_cpu_core.i_execute.i_alu_core.p_cea1 		= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_ceb1 		= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_cec 			= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_cealumode 		= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_ceinmode 		= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_ceopmode 		= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_cem 			= 1'b0;
	defparam i_cpu_core.i_execute.i_alu_core.p_cep 			= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_nalupipe		= "P2";
`endif

`ifdef ALU3
	defparam i_data_mem.p = 3; 
	defparam i_cpu_core.i_execute.i_alu_shreg.p = 3;
	//ALU_P3
	defparam i_cpu_core.i_execute.i_alu_core.p_acascreg 		= 2;
	defparam i_cpu_core.i_execute.i_alu_core.p_adreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_alumodereg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_areg 		= 2;
	defparam i_cpu_core.i_execute.i_alu_core.p_bcascreg 		= 2;
	defparam i_cpu_core.i_execute.i_alu_core.p_breg			= 2;
	defparam i_cpu_core.i_execute.i_alu_core.p_carryinreg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_carryinselreg 	= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_creg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_dreg 		= 0;
	defparam i_cpu_core.i_execute.i_alu_core.p_inmodereg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_mreg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_opmodereg 		= 1;
	defparam i_cpu_core.i_execute.i_alu_core.p_preg 		= 1; // option: 0, 1
	defparam i_cpu_core.i_execute.i_alu_core.p_cea1 		= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_ceb1 		= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_cec 			= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_cealumode 		= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_ceinmode 		= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_ceopmode 		= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_cem 			= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_cep 			= 1'b1;
	defparam i_cpu_core.i_execute.i_alu_core.p_nalupipe		= "P3";
`endif

wire [`IM_ADDR_WIDTH-1:0] 	cpu_im_pc;	
wire [3:0]			cpu_dm_we;
wire [`DATA_WIDTH-1:0] 		cpu_dm_din;
wire [`DM_ADDR_WIDTH-1:0] 	cpu_dm_ofs_addr;
wire [`DATA_WIDTH-1:0] 		dm_cpu_ex4_regfile_data;
wire [`DATA_WIDTH-1:0] 		im_cpu_inst;

assign dummy = im_cpu_inst[0];

// Instruction Memory
inst_mem i_inst_mem (
    	.clka		(clk),
    	.rsta		(rst),
    	.wea		({4{1'b0}}),
    	.dina		(),
    	.addra		(cpu_im_pc), 
    	.douta_o	(im_cpu_inst),
	.clkb 		(),
	.rstb 		(),
	.web		(),
	.dinb 		(),
	.addrb 		(),
	.doutb_o	()//,
);

// Data Memory
data_mem i_data_mem (
	.clka 		(clk),
	.rsta 		(rst),
	.wea 		(cpu_dm_we),
	.dina 		(cpu_dm_din),
	.addra 		(cpu_dm_ofs_addr),
	.douta_o	(dm_cpu_ex4_regfile_data),
	.clkb 		(),
	.rstb 		(),
	.web		(),
	.dinb 		(),
	.addrb 		(),
	.doutb_o	()//,
);	

// CPU
cpu_core i_cpu_core (
	// Input
    	.clk		(clk), 
    	.rst		(rst), 
	.im_inst	(im_cpu_inst),
	.dm_readdata	(dm_cpu_ex4_regfile_data),
	// Output
    	.pc_o		(cpu_im_pc),
	.dm_we 		(cpu_dm_we),
	.dm_addr	(cpu_dm_ofs_addr),
	.dm_writedata	(cpu_dm_din)
    );
	 
endmodule
