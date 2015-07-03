`timescale 1ns / 1ps
/******************************************************************************************
* iDEA Soft-Core Processor v1.01
* Copyright (C) by HuiYan Cheah 2014 hycheah1@e.ntu.edu.sg
* School of Computer Engineering
* Nanyang Technological University
*
	* This processor is a proof-of-concept of the usability of the DSP48E1 as
	* the execution unit of a general-purpose processor. It is not a full-blown processor.
	*
	* Description:
	* Testbench for functional verification arithmetic register instructions.	
	*

******************************************************************************************/

`define TRACE_PC 		test_tb.i_cpu_top.i_cpu_core.i_fetch.pc_o
`define TRACE_OPCODE		test_tb.i_cpu_top.i_cpu_core.i_fetch.inst_i[25:21] 
`define TRACE_BRANCHEN		test_tb.i_cpu_top.i_cpu_core.i_fetch.branchen_i
`define TRACE_BRANCHSEL		test_tb.i_cpu_top.i_cpu_core.i_fetch.branchsel
`define TRACE_BRANCHTARGET  	test_tb.i_cpu_top.i_cpu_core.i_fetch.branchtarget_i
`define TRACE_INST		test_tb.i_cpu_top.i_cpu_core.i_decode.inst_i
`define TRACE_RA_DATA		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.ra_readdata_o
`define TRACE_RB_DATA		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rb_readdata_o
`define TRACE_RC_DATA		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rc_readdata_o
`define TRACE_REGFILE_WE	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.we
`define TRACE_RD_ADDR		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_addr_i
`define TRACE_RD_DATA_31	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_31
`define TRACE_RD_DATA_30	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_30
`define TRACE_RD_DATA_29	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_29
`define TRACE_RD_DATA_28	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_28
`define TRACE_RD_DATA_27	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_27
`define TRACE_RD_DATA_26	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_26
`define TRACE_RD_DATA_25	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_25
`define TRACE_RD_DATA_24	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_24
`define TRACE_RD_DATA_23	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_23
`define TRACE_RD_DATA_22	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_22
`define TRACE_RD_DATA_21	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_21
`define TRACE_RD_DATA_20	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_20
`define TRACE_RD_DATA_19	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_19
`define TRACE_RD_DATA_18	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_18
`define TRACE_RD_DATA_17	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_17
`define TRACE_RD_DATA_16	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_16
`define TRACE_RD_DATA_15	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_15
`define TRACE_RD_DATA_14	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_14
`define TRACE_RD_DATA_13	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_13
`define TRACE_RD_DATA_12	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_12
`define TRACE_RD_DATA_11	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_11
`define TRACE_RD_DATA_10	test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_10
`define TRACE_RD_DATA_9		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_9
`define TRACE_RD_DATA_8		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_8
`define TRACE_RD_DATA_7		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_7
`define TRACE_RD_DATA_6		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_6
`define TRACE_RD_DATA_5		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_5
`define TRACE_RD_DATA_4		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_4
`define TRACE_RD_DATA_3		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_3
`define TRACE_RD_DATA_2		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_2
`define TRACE_RD_DATA_1		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_1
`define TRACE_RD_DATA_0		test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.rd_writedata_0
`define TRACE_RD_WRITEDATA	{`TRACE_RD_DATA_15, `TRACE_RD_DATA_14, `TRACE_RD_DATA_13, `TRACE_RD_DATA_12, `TRACE_RD_DATA_11, `TRACE_RD_DATA_10, `TRACE_RD_DATA_9, `TRACE_RD_DATA_8, `TRACE_RD_DATA_7, `TRACE_RD_DATA_6, `TRACE_RD_DATA_5, `TRACE_RD_DATA_4, `TRACE_RD_DATA_3, `TRACE_RD_DATA_2, `TRACE_RD_DATA_1, `TRACE_RD_DATA_0}
`define TRACE_DM_WE		test_tb.i_cpu_top.i_data_mem.wea
`define TRACE_DM_ADDR		test_tb.i_cpu_top.i_data_mem.addra
`define TRACE_DM_WRITEDATA 	test_tb.i_cpu_top.i_data_mem.dina

// Regfile
`define REG_INST_31 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_31.mem_a 
`define REG_INST_30 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_30.mem_a 
`define REG_INST_29 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_29.mem_a 
`define REG_INST_28 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_28.mem_a 
`define REG_INST_27 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_27.mem_a 
`define REG_INST_26 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_26.mem_a 
`define REG_INST_25 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_25.mem_a 
`define REG_INST_24 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_24.mem_a 
`define REG_INST_23 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_23.mem_a 
`define REG_INST_22 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_22.mem_a 
`define REG_INST_21 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_21.mem_a 
`define REG_INST_20 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_20.mem_a 
`define REG_INST_19 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_19.mem_a 
`define REG_INST_18 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_18.mem_a 
`define REG_INST_17 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_17.mem_a 
`define REG_INST_16 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_16.mem_a 
`define REG_INST_15 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_15.mem_a 
`define REG_INST_14 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_14.mem_a 
`define REG_INST_13 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_13.mem_a 
`define REG_INST_12 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_12.mem_a 
`define REG_INST_11 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_11.mem_a 
`define REG_INST_10 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_10.mem_a 
`define REG_INST_9 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_9.mem_a 
`define REG_INST_8 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_8.mem_a 
`define REG_INST_7 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_7.mem_a 
`define REG_INST_6 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_6.mem_a 
`define REG_INST_5 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_5.mem_a 
`define REG_INST_4 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_4.mem_a 
`define REG_INST_3 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_3.mem_a 
`define REG_INST_2 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_2.mem_a 
`define REG_INST_1 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_1.mem_a 
`define REG_INST_0 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_0.mem_a 

`define REG_ADDR_0 {`REG_INST_15[1:0], `REG_INST_14[1:0], `REG_INST_13[1:0], `REG_INST_12[1:0], `REG_INST_11[1:0], `REG_INST_10[1:0], `REG_INST_9[1:0], `REG_INST_8[1:0], `REG_INST_7[1:0], `REG_INST_6[1:0], `REG_INST_5[1:0], `REG_INST_4[1:0], `REG_INST_3[1:0], `REG_INST_2[1:0], `REG_INST_1[1:0], `REG_INST_0[1:0]}

`define REG_ADDR_1 {`REG_INST_15[3:2], `REG_INST_14[3:2], `REG_INST_13[3:2], `REG_INST_12[3:2], `REG_INST_11[3:2], `REG_INST_10[3:2], `REG_INST_9[3:2], `REG_INST_8[3:2], `REG_INST_7[3:2], `REG_INST_6[3:2], `REG_INST_5[3:2], `REG_INST_4[3:2], `REG_INST_3[3:2], `REG_INST_2[3:2], `REG_INST_1[3:2], `REG_INST_0[3:2]}

`define REG_ADDR_2 {`REG_INST_15[5:4], `REG_INST_14[5:4], `REG_INST_13[5:4], `REG_INST_12[5:4], `REG_INST_11[5:4], `REG_INST_10[5:4], `REG_INST_9[5:4], `REG_INST_8[5:4], `REG_INST_7[5:4], `REG_INST_6[5:4], `REG_INST_5[5:4], `REG_INST_4[5:4], `REG_INST_3[5:4], `REG_INST_2[5:4], `REG_INST_1[5:4], `REG_INST_0[5:4]}

`define REG_ADDR_3 {`REG_INST_15[7:6], `REG_INST_14[7:6], `REG_INST_13[7:6], `REG_INST_12[7:6], `REG_INST_11[7:6], `REG_INST_10[7:6], `REG_INST_9[7:6], `REG_INST_8[7:6], `REG_INST_7[7:6], `REG_INST_6[7:6], `REG_INST_5[7:6], `REG_INST_4[7:6], `REG_INST_3[7:6], `REG_INST_2[7:6], `REG_INST_1[7:6], `REG_INST_0[7:6]}

`define REG_ADDR_4 {`REG_INST_15[9:8], `REG_INST_14[9:8], `REG_INST_13[9:8], `REG_INST_12[9:8], `REG_INST_11[9:8], `REG_INST_10[9:8], `REG_INST_9[9:8], `REG_INST_8[9:8], `REG_INST_7[9:8], `REG_INST_6[9:8], `REG_INST_5[9:8], `REG_INST_4[9:8], `REG_INST_3[9:8], `REG_INST_2[9:8], `REG_INST_1[9:8], `REG_INST_0[9:8]}

`define REG_ADDR_5 {`REG_INST_15[11:10], `REG_INST_14[11:10], `REG_INST_13[11:10], `REG_INST_12[11:10], `REG_INST_11[11:10], `REG_INST_10[11:10], `REG_INST_9[11:10], `REG_INST_8[11:10], `REG_INST_7[11:10], `REG_INST_6[11:10], `REG_INST_5[11:10], `REG_INST_4[11:10], `REG_INST_3[11:10], `REG_INST_2[11:10], `REG_INST_1[11:10], `REG_INST_0[11:10]}

`define REG_ADDR_6 {`REG_INST_15[13:12], `REG_INST_14[13:12], `REG_INST_13[13:12], `REG_INST_12[13:12], `REG_INST_11[13:12], `REG_INST_10[13:12], `REG_INST_9[13:12], `REG_INST_8[13:12], `REG_INST_7[13:12], `REG_INST_6[13:12], `REG_INST_5[13:12], `REG_INST_4[13:12], `REG_INST_3[13:12], `REG_INST_2[13:12], `REG_INST_1[13:12], `REG_INST_0[13:12]}

`define REG_ADDR_7 {`REG_INST_15[15:14], `REG_INST_14[15:14], `REG_INST_13[15:14], `REG_INST_12[15:14], `REG_INST_11[15:14], `REG_INST_10[15:14], `REG_INST_9[15:14], `REG_INST_8[15:14], `REG_INST_7[15:14], `REG_INST_6[15:14], `REG_INST_5[15:14], `REG_INST_4[15:14], `REG_INST_3[15:14], `REG_INST_2[15:14], `REG_INST_1[15:14], `REG_INST_0[15:14]}

`define REG_ADDR_8 {`REG_INST_15[17:16], `REG_INST_14[17:16], `REG_INST_13[17:16], `REG_INST_12[17:16], `REG_INST_11[17:16], `REG_INST_10[17:16], `REG_INST_9[17:16], `REG_INST_8[17:16], `REG_INST_7[17:16], `REG_INST_6[17:16], `REG_INST_5[17:16], `REG_INST_4[17:16], `REG_INST_3[17:16], `REG_INST_2[17:16], `REG_INST_1[17:16], `REG_INST_0[17:16]}

`define REG_ADDR_9 {`REG_INST_15[19:18], `REG_INST_14[19:18], `REG_INST_13[19:18], `REG_INST_12[19:18], `REG_INST_11[19:18], `REG_INST_10[19:18], `REG_INST_9[19:18], `REG_INST_8[19:18], `REG_INST_7[19:18], `REG_INST_6[19:18], `REG_INST_5[19:18], `REG_INST_4[19:18], `REG_INST_3[19:18], `REG_INST_2[19:18], `REG_INST_1[19:18], `REG_INST_0[19:18]}

`define REG_ADDR_10 {`REG_INST_15[21:20], `REG_INST_14[21:20], `REG_INST_13[21:20], `REG_INST_12[21:20], `REG_INST_11[21:20], `REG_INST_10[21:20], `REG_INST_9[21:20], `REG_INST_8[21:20], `REG_INST_7[21:20], `REG_INST_6[21:20], `REG_INST_5[21:20], `REG_INST_4[21:20], `REG_INST_3[21:20], `REG_INST_2[21:20], `REG_INST_1[21:20], `REG_INST_0[21:20]}

`define REG_ADDR_11 {`REG_INST_15[23:22], `REG_INST_14[23:22], `REG_INST_13[23:22], `REG_INST_12[23:22], `REG_INST_11[23:22], `REG_INST_10[23:22], `REG_INST_9[23:22], `REG_INST_8[23:22], `REG_INST_7[23:22], `REG_INST_6[23:22], `REG_INST_5[23:22], `REG_INST_4[23:22], `REG_INST_3[23:22], `REG_INST_2[23:22], `REG_INST_1[23:22], `REG_INST_0[23:22]}

`define REG_ADDR_12 {`REG_INST_15[25:24], `REG_INST_14[25:24], `REG_INST_13[25:24], `REG_INST_12[25:24], `REG_INST_11[25:24], `REG_INST_10[25:24], `REG_INST_9[25:24], `REG_INST_8[25:24], `REG_INST_7[25:24], `REG_INST_6[25:24], `REG_INST_5[25:24], `REG_INST_4[25:24], `REG_INST_3[25:24], `REG_INST_2[25:24], `REG_INST_1[25:24], `REG_INST_0[25:24]}

`define REG_ADDR_13 {`REG_INST_15[27:26], `REG_INST_14[27:26], `REG_INST_13[27:26], `REG_INST_12[27:26], `REG_INST_11[27:26], `REG_INST_10[27:26], `REG_INST_9[27:26], `REG_INST_8[27:26], `REG_INST_7[27:26], `REG_INST_6[27:26], `REG_INST_5[27:26], `REG_INST_4[27:26], `REG_INST_3[27:26], `REG_INST_2[27:26], `REG_INST_1[27:26], `REG_INST_0[27:26]}

`define REG_ADDR_14 {`REG_INST_15[29:28], `REG_INST_14[29:28], `REG_INST_13[29:28], `REG_INST_12[29:28], `REG_INST_11[29:28], `REG_INST_10[29:28], `REG_INST_9[29:28], `REG_INST_8[29:28], `REG_INST_7[29:28], `REG_INST_6[29:28], `REG_INST_5[29:28], `REG_INST_4[29:28], `REG_INST_3[29:28], `REG_INST_2[29:28], `REG_INST_1[29:28], `REG_INST_0[29:28]}

`define REG_ADDR_15 {`REG_INST_15[31:30], `REG_INST_14[31:30], `REG_INST_13[31:30], `REG_INST_12[31:30], `REG_INST_11[31:30], `REG_INST_10[31:30], `REG_INST_9[31:30], `REG_INST_8[31:30], `REG_INST_7[31:30], `REG_INST_6[31:30], `REG_INST_5[31:30], `REG_INST_4[31:30], `REG_INST_3[31:30], `REG_INST_2[31:30], `REG_INST_1[31:30], `REG_INST_0[31:30]}

`define REG_ADDR_16 {`REG_INST_15[33:32], `REG_INST_14[33:32], `REG_INST_13[33:32], `REG_INST_12[33:32], `REG_INST_11[33:32], `REG_INST_10[33:32], `REG_INST_9[33:32], `REG_INST_8[33:32], `REG_INST_7[33:32], `REG_INST_6[33:32], `REG_INST_5[33:32], `REG_INST_4[33:32], `REG_INST_3[33:32], `REG_INST_2[33:32], `REG_INST_1[33:32], `REG_INST_0[33:32]}

`define REG_ADDR_17 {`REG_INST_15[35:34], `REG_INST_14[35:34], `REG_INST_13[35:34], `REG_INST_12[35:34], `REG_INST_11[35:34], `REG_INST_10[35:34], `REG_INST_9[35:34], `REG_INST_8[35:34], `REG_INST_7[35:34], `REG_INST_6[35:34], `REG_INST_5[35:34], `REG_INST_4[35:34], `REG_INST_3[35:34], `REG_INST_2[35:34], `REG_INST_1[35:34], `REG_INST_0[35:34]}

`define REG_ADDR_18 {`REG_INST_15[37:36], `REG_INST_14[37:36], `REG_INST_13[37:36], `REG_INST_12[37:36], `REG_INST_11[37:36], `REG_INST_10[37:36], `REG_INST_9[37:36], `REG_INST_8[37:36], `REG_INST_7[37:36], `REG_INST_6[37:36], `REG_INST_5[37:36], `REG_INST_4[37:36], `REG_INST_3[37:36], `REG_INST_2[37:36], `REG_INST_1[37:36], `REG_INST_0[37:36]}

`define REG_ADDR_19 {`REG_INST_15[39:38], `REG_INST_14[39:38], `REG_INST_13[39:38], `REG_INST_12[39:38], `REG_INST_11[39:38], `REG_INST_10[39:38], `REG_INST_9[39:38], `REG_INST_8[39:38], `REG_INST_7[39:38], `REG_INST_6[39:38], `REG_INST_5[39:38], `REG_INST_4[39:38], `REG_INST_3[39:38], `REG_INST_2[39:38], `REG_INST_1[39:38], `REG_INST_0[39:38]}

`define REG_ADDR_20 {`REG_INST_15[41:40], `REG_INST_14[41:40], `REG_INST_13[41:40], `REG_INST_12[41:40], `REG_INST_11[41:40], `REG_INST_10[41:40], `REG_INST_9[41:40], `REG_INST_8[41:40], `REG_INST_7[41:40], `REG_INST_6[41:40], `REG_INST_5[41:40], `REG_INST_4[41:40], `REG_INST_3[41:40], `REG_INST_2[41:40], `REG_INST_1[41:40], `REG_INST_0[41:40]}

`define REG_ADDR_21 {`REG_INST_15[43:42], `REG_INST_14[43:42], `REG_INST_13[43:42], `REG_INST_12[43:42], `REG_INST_11[43:42], `REG_INST_10[43:42], `REG_INST_9[43:42], `REG_INST_8[43:42], `REG_INST_7[43:42], `REG_INST_6[43:42], `REG_INST_5[43:42], `REG_INST_4[43:42], `REG_INST_3[43:42], `REG_INST_2[43:42], `REG_INST_1[43:42], `REG_INST_0[43:42]}

`define REG_ADDR_22 {`REG_INST_15[45:44], `REG_INST_14[45:44], `REG_INST_13[45:44], `REG_INST_12[45:44], `REG_INST_11[45:44], `REG_INST_10[45:44], `REG_INST_9[45:44], `REG_INST_8[45:44], `REG_INST_7[45:44], `REG_INST_6[45:44], `REG_INST_5[45:44], `REG_INST_4[45:44], `REG_INST_3[45:44], `REG_INST_2[45:44], `REG_INST_1[45:44], `REG_INST_0[45:44]}

`define REG_ADDR_23 {`REG_INST_15[47:46], `REG_INST_14[47:46], `REG_INST_13[47:46], `REG_INST_12[47:46], `REG_INST_11[47:46], `REG_INST_10[47:46], `REG_INST_9[47:46], `REG_INST_8[47:46], `REG_INST_7[47:46], `REG_INST_6[47:46], `REG_INST_5[47:46], `REG_INST_4[47:46], `REG_INST_3[47:46], `REG_INST_2[47:46], `REG_INST_1[47:46], `REG_INST_0[47:46]}

`define REG_ADDR_24 {`REG_INST_15[49:48], `REG_INST_14[49:48], `REG_INST_13[49:48], `REG_INST_12[49:48], `REG_INST_11[49:48], `REG_INST_10[49:48], `REG_INST_9[49:48], `REG_INST_8[49:48], `REG_INST_7[49:48], `REG_INST_6[49:48], `REG_INST_5[49:48], `REG_INST_4[49:48], `REG_INST_3[49:48], `REG_INST_2[49:48], `REG_INST_1[49:48], `REG_INST_0[49:48]}

`define REG_ADDR_25 {`REG_INST_15[51:50], `REG_INST_14[51:50], `REG_INST_13[51:50], `REG_INST_12[51:50], `REG_INST_11[51:50], `REG_INST_10[51:50], `REG_INST_9[51:50], `REG_INST_8[51:50], `REG_INST_7[51:50], `REG_INST_6[51:50], `REG_INST_5[51:50], `REG_INST_4[51:50], `REG_INST_3[51:50], `REG_INST_2[51:50], `REG_INST_1[51:50], `REG_INST_0[51:50]}

`define REG_ADDR_26 {`REG_INST_15[53:52], `REG_INST_14[53:52], `REG_INST_13[53:52], `REG_INST_12[53:52], `REG_INST_11[53:52], `REG_INST_10[53:52], `REG_INST_9[53:52], `REG_INST_8[53:52], `REG_INST_7[53:52], `REG_INST_6[53:52], `REG_INST_5[53:52], `REG_INST_4[53:52], `REG_INST_3[53:52], `REG_INST_2[53:52], `REG_INST_1[53:52], `REG_INST_0[53:52]}

`define REG_ADDR_27 {`REG_INST_15[55:54], `REG_INST_14[55:54], `REG_INST_13[55:54], `REG_INST_12[55:54], `REG_INST_11[55:54], `REG_INST_10[55:54], `REG_INST_9[55:54], `REG_INST_8[55:54], `REG_INST_7[55:54], `REG_INST_6[55:54], `REG_INST_5[55:54], `REG_INST_4[55:54], `REG_INST_3[55:54], `REG_INST_2[55:54], `REG_INST_1[55:54], `REG_INST_0[55:54]}

`define REG_ADDR_28 {`REG_INST_15[57:56], `REG_INST_14[57:56], `REG_INST_13[57:56], `REG_INST_12[57:56], `REG_INST_11[57:56], `REG_INST_10[57:56], `REG_INST_9[57:56], `REG_INST_8[57:56], `REG_INST_7[57:56], `REG_INST_6[57:56], `REG_INST_5[57:56], `REG_INST_4[57:56], `REG_INST_3[57:56], `REG_INST_2[57:56], `REG_INST_1[57:56], `REG_INST_0[57:56]}

`define REG_ADDR_29 {`REG_INST_15[59:58], `REG_INST_14[59:58], `REG_INST_13[59:58], `REG_INST_12[59:58], `REG_INST_11[59:58], `REG_INST_10[59:58], `REG_INST_9[59:58], `REG_INST_8[59:58], `REG_INST_7[59:58], `REG_INST_6[59:58], `REG_INST_5[59:58], `REG_INST_4[59:58], `REG_INST_3[59:58], `REG_INST_2[59:58], `REG_INST_1[59:58], `REG_INST_0[59:58]}

`define REG_ADDR_30 {	`REG_INST_15[61:60], `REG_INST_14[61:60], `REG_INST_13[61:60], `REG_INST_12[61:60], `REG_INST_11[61:60], `REG_INST_10[61:60], `REG_INST_9[61:60], `REG_INST_8[61:60], `REG_INST_7[61:60], `REG_INST_6[61:60], `REG_INST_5[61:60], `REG_INST_4[61:60], `REG_INST_3[61:60], `REG_INST_2[61:60], `REG_INST_1[61:60], `REG_INST_0[61:60]}

`define REG_ADDR_31 {`REG_INST_15[63:62], `REG_INST_14[63:62], `REG_INST_13[63:62], `REG_INST_12[63:62], `REG_INST_11[63:62], `REG_INST_10[63:62], `REG_INST_9[63:62], `REG_INST_8[63:62], `REG_INST_7[63:62], `REG_INST_6[63:62], `REG_INST_5[63:62], `REG_INST_4[63:62], `REG_INST_3[63:62], `REG_INST_2[63:62], `REG_INST_1[63:62], `REG_INST_0[63:62]}
