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
* HuiYan Cheah, 2016 hycheah1@e.ntu.edu.sg
* School of Computer Engineering
* Nanyang Technological University
*
	* This processor is a proof-of-concept of the usability of the DSP48E1 as
	* the execution unit of a general-purpose processor. It is not a full-blown processor.
	*
	* Description:
	* Control Unit of the processor.
	* Control signals are hardwired combinational logic
	* Input is a 32-bit intruction and decoded according to the format of the
	* instruction. 
	*

******************************************************************************************/
`include "defines.v"
`include "bitmask.v"

module control (

	// ***** Input *****
	input wire [31:0] inst_i,
	
	// ***** Output *****
`ifdef EXTLOOPBACK
	output reg	extloopback_o,
`endif

	output wire [4:0] ra_addr_o,
	output wire [4:0] rb_addr_o,
	output wire [4:0] rc_addr_o,
	output wire [4:0] rd_addr_o,

	// => Data memory 
	output reg [3:0] dm_we_o, // MemWrite -- 3 bits SW, SH,SB
	output reg 	 dm_re_o, // MemtoReg
	
	// Input Map
	output wire useimm_o, // ALUSRc
	output reg sa_o,
	output reg se_o,
	output reg ze_o,
	output reg sr_o,
	output reg usemult_o, 
	output wire [15:0] imm_o,

	output reg regwrite_o, // regwrite
	output reg regwriteui_o, // regwriteui
	output reg regwritepc_o, // regwritepc
	// ALU
	output reg [4:0] inmode_o,
	output reg [3:0] alumode_o,
	output reg [6:0] opmode_o,
	output reg ce2_o,

	// Jump
	output reg jumpregsel_o,
	output reg cmpsel_o, 
	output reg [2:0] loadtype_o,
	
	// Branch
	output reg 		branchen_o, // Branch
	output reg [2:0]	branchtype_o,
	output wire [15:0] 	branchtarget_o // this is equivalent to imm; should be removed...

);

wire [5:0] opcode;
wire [4:0] rs, rt, rd;
//wire [4:0] shamt;
wire [5:0] funct;
wire [15:0] imm;

assign opcode = inst_i[31:26];
assign rs = inst_i[25:21];
assign rt = inst_i[20:16];
assign rd = inst_i[15:11];
//assign shamt = inst_i[10:6];
assign funct = inst_i[5:0];
assign imm = inst_i[15:0];

assign immstatus = (opcode[5:3] == 3'b001 || opcode[5:3] == 3'b111) ? 1'b1 : 1'b0; // If I-type -- status 

assign ra_addr_o = rs;
assign rb_addr_o = rt;
assign rc_addr_o = 5'b00000;
assign rd_addr_o = (opcode[5:3] == 3'b001 || opcode[5:3] == 3'b100 || opcode[5:3] == 3'b111) ? rt : // IMM instruction // perhaps this can be moved to the case statement
			(opcode == `JAL) ? 5'h1f : // r31 
			rd; // Reg Instruction*/

assign imm_o = imm;
assign branchtarget_o = imm; // 
assign useimm_o = immstatus;

always@ (*)
begin
	case(opcode) // -- tomodify -- can we use just 3 bits instead of all 6 bits?
		// Type R
		6'b000000: begin
			case(funct)
				`ADD: 	begin
						inmode_o = (`BM_ADD) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_ADD) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_ADD) ? 7'b0110011 : 7'bxxxxxxx;
						regwrite_o = (`BM_ADD) ? 1'b1 : 1'bx; // RegWrite
						regwriteui_o = (`BM_ADD) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_ADD) ? 1'b1 : 1'bx;
						branchen_o = (`BM_ADD) ? 1'b0 : 1'bx; // Branch
						jumpregsel_o = (`BM_ADD) ? 1'b0 : 1'bx;
						regwritepc_o =  1'bx; 
						dm_re_o = (`BM_ADD) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_ADD) ? 4'b0000 : 4'bxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_ADD) ? 1'b0 : 1'bx;
						sa_o = (`BM_ADD) ? 1'b0 : 1'bx;
						ze_o = (`BM_ADD) ? 1'b0 : 1'bx;
						se_o = (`BM_ADD) ? 1'b0 : 1'bx;
						sr_o = (`BM_ADD) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_ADD) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_ADD) ? 1'b0 : 1'bx;
						`endif
					end
				`ADDLB: begin
						inmode_o = (`BM_ADDLB) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_ADDLB) ? 4'b0000 : 4'bxxxx;
						regwrite_o = (`BM_ADDLB) ? 1'b1 : 1'bx; // RegWrite
						regwriteui_o = (`BM_ADDLB) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_ADDLB) ? 1'b1 : 1'bx;
						branchen_o = (`BM_ADDLB) ? 1'b0 : 1'bx; // Branch
						jumpregsel_o = (`BM_ADDLB) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_ADDLB) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_ADDLB) ? 4'b0000 : 4'bxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_ADDLB) ? 1'b0 : 1'bx;
						sa_o = (`BM_ADDLB) ? 1'b0 : 1'bx;
						ze_o = (`BM_ADDLB) ? 1'b0 : 1'bx;
						se_o = (`BM_ADDLB) ? 1'b0 : 1'bx;
						sr_o = (`BM_ADDLB) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_ADDLB) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_ADDLB) ? 1'b1 : 1'bx;
							opmode_o = (`BM_ADDLB) ? 7'b0110011 : 7'bxxxxxxx;
						`else
							opmode_o = (`BM_ADDLB) ? 7'b0110010 : 7'bxxxxxxx;
						`endif
					end
				`ADDU: 	begin
						inmode_o = (`BM_ADDU) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_ADDU) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_ADDU) ? 7'b0110011 : 7'bxxxxxxx;
						regwrite_o = (`BM_ADDU) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_ADDU) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_ADDU) ? 1'b1 : 1'bx;
						branchen_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_ADDU) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						sa_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						ze_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						se_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						sr_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_ADDU) ? 1'b0 : 1'bx;
						`endif
					end
				`AND: begin
						inmode_o = (`BM_AND) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_AND) ? 4'b1100 : 4'bxxxx;
						opmode_o = (`BM_AND) ? 7'b0110011 : 7'bxxxxxxx;
						regwrite_o = (`BM_AND) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_AND) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_AND) ? 1'b1 : 1'bx;
						branchen_o = (`BM_AND) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_AND) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_AND) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_AND) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_AND) ? 1'b0 : 1'bx;
						sa_o = (`BM_AND) ? 1'b0 : 1'bx;
						ze_o = (`BM_AND) ? 1'b0 : 1'bx;
						se_o = (`BM_AND) ? 1'b0 : 1'bx;
						sr_o = (`BM_AND) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_AND) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_AND) ? 1'b0 : 1'bx;
						`endif
					end
				`ANDLB: begin
						inmode_o = (`BM_ANDLB) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_ANDLB) ? 4'b1100 : 4'bxxxx;
						regwrite_o = (`BM_ANDLB) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_ANDLB) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_ANDLB) ? 1'b1 : 1'bx;
						branchen_o = (`BM_ANDLB) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_ANDLB) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_ANDLB) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_ANDLB) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_ANDLB) ? 1'b0 : 1'bx;
						sa_o = (`BM_ANDLB) ? 1'b0 : 1'bx;
						ze_o = (`BM_ANDLB) ? 1'b0 : 1'bx;
						se_o = (`BM_ANDLB) ? 1'b0 : 1'bx;
						sr_o = (`BM_ANDLB) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_ANDLB) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_ANDLB) ? 1'b1 : 1'bx;
							opmode_o = (`BM_ANDLB) ? 7'b0110011 : 7'bxxxxxxx;
						`else
							opmode_o = (`BM_ANDLB) ? 7'b0110010 : 7'bxxxxxxx;
						`endif
					end
				`JR:	begin
						inmode_o = 5'bxxxxx;
						alumode_o = 4'bxxxx;
						opmode_o = 7'bxxxxxxx;
						regwrite_o = (`BM_JR) ? 1'b0 : 1'bx;
						regwriteui_o = (`BM_JR) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = 1'bx;
						branchen_o = (`BM_JR) ? 1'b0 : 1'bx; // a type of branch; changes value of pc
						jumpregsel_o = (`BM_JR) ? 1'b1 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_JR) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_JR) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = 1'bx;
						sa_o = 1'bx;
						ze_o = 1'bx;
						se_o = 1'bx;
						sr_o = (`BM_JR) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_JR) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_JR) ? 1'b0 : 1'bx;
						`endif
					end
				`MULT:	begin
						inmode_o = (`BM_MULT) ? 5'b10001 : 5'bxxxxx;
						alumode_o = (`BM_MULT) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_MULT) ? 7'b0000101 : 7'bxxxxxxx;
						regwrite_o = (`BM_MULT) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_MULT) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_MULT) ? 1'b0 : 1'bx;
						branchen_o = (`BM_MULT) ? 1'b0 : 1'bx; 
						jumpregsel_o = (`BM_MULT) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; // not sure
						dm_re_o = (`BM_MULT) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_MULT) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_MULT) ? 1'b1 : 1'bx;
						sa_o = (`BM_MULT) ? 1'b0 : 1'bx;
						ze_o = (`BM_MULT) ? 1'b0 : 1'bx;
						se_o = (`BM_MULT) ? 1'b0 : 1'bx;
						sr_o = (`BM_MULT) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_MULT) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_MULT) ? 1'b0 : 1'bx;
						`endif
					end
				`MULTU:	begin
						inmode_o = (`BM_MULTU) ? 5'b10001 : 5'bxxxxx;
						alumode_o = (`BM_MULTU) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_MULTU) ? 7'b0000101 : 7'bxxxxxxx;
						regwrite_o = (`BM_MULTU) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_MULTU) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						branchen_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_MULTU) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_MULTU) ? 1'b1 : 1'bx;
						sa_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						ze_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						se_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						sr_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_MULTU) ? 1'b0 : 1'bx;
						`endif
					end
				`NOR: begin
						inmode_o = (`BM_NOR) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_NOR) ? 4'b1110 : 4'bxxxx;
						opmode_o = (`BM_NOR) ? 7'b0111011 : 7'bxxxxxxx;
						regwrite_o = (`BM_NOR) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_NOR) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_NOR) ? 1'b1 : 1'bx;
						branchen_o = (`BM_NOR) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_NOR) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_NOR) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_NOR) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_NOR) ? 1'b0 : 1'bx;
						sa_o = (`BM_NOR) ? 1'b0 : 1'bx;
						ze_o = (`BM_NOR) ? 1'b0 : 1'bx;
						se_o = (`BM_NOR) ? 1'b0 : 1'bx;
						sr_o = (`BM_NOR) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_NOR) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_NOR) ? 1'b0 : 1'bx;
						`endif
					end
				`NORLB: begin
						inmode_o = (`BM_NORLB) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_NORLB) ? 4'b1110 : 4'bxxxx;
						regwrite_o = (`BM_NORLB) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_NORLB) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_NORLB) ? 1'b1 : 1'bx;
						branchen_o = (`BM_NORLB) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_NORLB) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_NORLB) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_NORLB) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_NORLB) ? 1'b0 : 1'bx;
						sa_o = (`BM_NORLB) ? 1'b0 : 1'bx;
						ze_o = (`BM_NORLB) ? 1'b0 : 1'bx;
						se_o = (`BM_NORLB) ? 1'b0 : 1'bx;
						sr_o = (`BM_NORLB) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_NORLB) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_NORLB) ? 1'b1 : 1'bx;
							opmode_o = (`BM_NORLB) ? 7'b0111011 : 7'bxxxxxxx;
						`else
							opmode_o = (`BM_NORLB) ? 7'b0111010 : 7'bxxxxxxx;
						`endif
					end
				`OR: begin
						inmode_o = (`BM_OR) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_OR) ? 4'b1100 : 4'bxxxx;
						opmode_o = (`BM_OR) ? 7'b0111011 : 7'bxxxxxxx;
						regwrite_o = (`BM_OR) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_OR) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_OR) ? 1'b1 : 1'bx;
						branchen_o = (`BM_OR) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_OR) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_OR) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_OR) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_OR) ? 1'b0 : 1'bx;
						sa_o = (`BM_OR) ? 1'b0 : 1'bx;
						ze_o = (`BM_OR) ? 1'b0 : 1'bx;
						se_o = (`BM_OR) ? 1'b0 : 1'bx;
						sr_o = (`BM_OR) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_OR) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_OR) ? 1'b0 : 1'bx;
						`endif
					end
				`ORLB: begin
						inmode_o = (`BM_ORLB) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_ORLB) ? 4'b1100 : 4'bxxxx;
						regwrite_o = (`BM_ORLB) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_ORLB) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_ORLB) ? 1'b1 : 1'bx;
						branchen_o = (`BM_ORLB) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_ORLB) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_ORLB) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_ORLB) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_ORLB) ? 1'b0 : 1'bx;
						sa_o = (`BM_ORLB) ? 1'b0 : 1'bx;
						ze_o = (`BM_ORLB) ? 1'b0 : 1'bx;
						se_o = (`BM_ORLB) ? 1'b0 : 1'bx;
						sr_o = (`BM_ORLB) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_ORLB) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_ORLB) ? 1'b1 : 1'bx;
							opmode_o = (`BM_ORLB) ? 7'b0111011 : 7'bxxxxxxx;
						`else // INTLOOPBACK
							opmode_o = (`BM_ORLB) ? 7'b0111010 : 7'bxxxxxxx;
						`endif
					end
				`SLL:	begin
						inmode_o = (`BM_SLL) ? 5'b10001 : 5'bxxxxx;
						alumode_o = (`BM_SLL) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_SLL) ? 7'b0000101 : 7'bxxxxxxx;
						regwrite_o = (`BM_SLL) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SLL) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SLL) ? 1'b0 : 1'bx;
						branchen_o = (`BM_SLL) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SLL) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SLL) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SLL) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SLL) ? 1'b1 : 1'bx;
						sa_o = (`BM_SLL) ? 1'b1 : 1'bx;
						ze_o = (`BM_SLL) ? 1'b0 : 1'bx;
						se_o = (`BM_SLL) ? 1'b0 : 1'bx;
						sr_o = (`BM_SLL) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SLL) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SLL) ? 1'b0 : 1'bx;
						`endif
					end
				`SLLV:	begin
						inmode_o = (`BM_SLLV) ? 5'b10001 : 5'bxxxxx;
						alumode_o = (`BM_SLLV) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_SLLV) ? 7'b0000101 : 7'bxxxxxxx;
						regwrite_o = (`BM_SLLV) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SLLV) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						branchen_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SLLV) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SLLV) ? 1'b1 : 1'bx;
						sa_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						ze_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						se_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						sr_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SLLV) ? 1'b0 : 1'bx;
						`endif
					end
				`SLT: 	begin
						inmode_o = (`BM_SLT) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_SLT) ? 4'b0011 : 4'bxxxx;
						opmode_o = (`BM_SLT) ? 7'b0110011 : 7'bxxxxxxx;
						regwrite_o = (`BM_SLT) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SLT) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SLT) ? 1'b1 : 1'bx;
						branchen_o = (`BM_SLT) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SLT) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SLT) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SLT) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SLT) ? 1'b0 : 1'bx;
						sa_o = (`BM_SLT) ? 1'b0 : 1'bx;
						ze_o = (`BM_SLT) ? 1'b0 : 1'bx;
						se_o = (`BM_SLT) ? 1'b0 : 1'bx;
						sr_o = (`BM_SLT) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SLT) ? 1'b1 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SLT) ? 1'b0 : 1'bx;
						`endif
					end
				`SLTU: 	begin
						inmode_o = (`BM_SLTU) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_SLTU) ? 4'b0011 : 4'bxxxx;
						opmode_o = (`BM_SLTU) ? 7'b0110011 : 7'bxxxxxxx;
						regwrite_o = (`BM_SLTU) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SLTU) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SLTU) ? 1'b1 : 1'bx;
						branchen_o = (`BM_SLTU) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SLTU) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SLTU) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SLTU) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SLTU) ? 1'b0 : 1'bx;
						sa_o = (`BM_SLTU) ? 1'b0 : 1'bx;
						ze_o = (`BM_SLTU) ? 1'b0 : 1'bx;
						se_o = (`BM_SLTU) ? 1'b0 : 1'bx;
						sr_o = (`BM_SLTU) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SLTU) ? 1'b1 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SLTU) ? 1'b0 : 1'bx;
						`endif
					end
				`SRL:	begin
						inmode_o = (`BM_SRL) ? 5'b10001 : 5'bxxxxx;
						alumode_o = (`BM_SRL) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_SRL) ? 7'b0000101 : 7'bxxxxxxx;
						regwrite_o = (`BM_SRL) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SRL) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SRL) ? 1'b0 : 1'bx;
						branchen_o = (`BM_SRL) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SRL) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SRL) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SRL) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SRL) ? 1'b1 : 1'bx;
						sa_o = (`BM_SRL) ? 1'b1 : 1'bx;
						ze_o = (`BM_SRL) ? 1'b1 : 1'bx;
						se_o = (`BM_SRL) ? 1'b0 : 1'bx;
						sr_o = (`BM_SRL) ? 1'b1 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SRL) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SRL) ? 1'b0 : 1'bx;
						`endif
					end
				`SRA:	begin
						inmode_o = (`BM_SRA) ? 5'b10001 : 5'bxxxxx;
						alumode_o = (`BM_SRA) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_SRA) ? 7'b0000101 : 7'bxxxxxxx;
						regwrite_o = (`BM_SRA) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SRA) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SRA) ? 1'b0 : 1'bx;
						branchen_o = (`BM_SRA) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SRA) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SRA) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SRA) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SRA) ? 1'b1 : 1'bx;
						sa_o = (`BM_SRA) ? 1'b1 : 1'bx;
						ze_o = (`BM_SRA) ? 1'b0 : 1'bx;
						se_o = (`BM_SRA) ? 1'b1 : 1'bx;
						sr_o = (`BM_SRA) ? 1'b1 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SRA) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SRA) ? 1'b0 : 1'bx;
						`endif
					end
				`SRAV:	begin
						inmode_o = (`BM_SRAV) ? 5'b10001 : 5'bxxxxx;
						alumode_o = (`BM_SRAV) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_SRAV) ? 7'b0000101 : 7'bxxxxxxx;
						regwrite_o = (`BM_SRAV) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SRAV) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SRAV) ? 1'b0 : 1'bx;
						branchen_o = (`BM_SRAV) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SRAV) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SRAV) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SRAV) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SRAV) ? 1'b1 : 1'bx;
						sa_o = (`BM_SRAV) ? 1'b0 : 1'bx;
						ze_o = (`BM_SRAV) ? 1'b0 : 1'bx;
						se_o = (`BM_SRAV) ? 1'b1 : 1'bx;
						sr_o = (`BM_SRAV) ? 1'b1 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SRAV) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SRAV) ? 1'b0 : 1'bx;
						`endif
					end
				`SRLV:	begin
						inmode_o = (`BM_SRLV) ? 5'b10001 : 5'bxxxxx;
						alumode_o = (`BM_SRLV) ? 4'b0000 : 4'bxxxx;
						opmode_o = (`BM_SRLV) ? 7'b0000101 : 7'bxxxxxxx;
						regwrite_o = (`BM_SRLV) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SRLV) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SRLV) ? 1'b0 : 1'bx;
						branchen_o = (`BM_SRLV) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SRLV) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SRLV) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SRLV) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SRLV) ? 1'b1 : 1'bx;
						sa_o = (`BM_SRLV) ? 1'b0 : 1'bx;
						ze_o = (`BM_SRLV) ? 1'b1 : 1'bx;
						se_o = (`BM_SRLV) ? 1'b0 : 1'bx;
						sr_o = (`BM_SRLV) ? 1'b1 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SRLV) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SRLV) ? 1'b0 : 1'bx;
						`endif
					end

				`SUB: 	begin
						inmode_o = (`BM_SUB) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_SUB) ? 4'b0011 : 4'bxxxx;
						opmode_o = (`BM_SUB) ? 7'b0110011 : 7'bxxxxxxx;
						regwrite_o = (`BM_SUB) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SUB) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SUB) ? 1'b1 : 1'bx;
						branchen_o = (`BM_SUB) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SUB) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SUB) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SUB) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SUB) ? 1'b0 : 1'bx;
						sa_o = (`BM_SUB) ? 1'b0 : 1'bx;
						ze_o = (`BM_SUB) ? 1'b0 : 1'bx;
						se_o = (`BM_SUB) ? 1'b0 : 1'bx;
						sr_o = (`BM_SUB) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SUB) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SUB) ? 1'b0 : 1'bx;
						`endif
					end
				`SUBLB: 	begin
						inmode_o = (`BM_SUBLB) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_SUBLB) ? 4'b0011 : 4'bxxxx;
						regwrite_o = (`BM_SUBLB) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SUBLB) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SUBLB) ? 1'b1 : 1'bx;
						branchen_o = (`BM_SUBLB) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SUBLB) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SUBLB) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SUBLB) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SUBLB) ? 1'b0 : 1'bx;
						sa_o = (`BM_SUBLB) ? 1'b0 : 1'bx;
						ze_o = (`BM_SUBLB) ? 1'b0 : 1'bx;
						se_o = (`BM_SUBLB) ? 1'b0 : 1'bx;
						sr_o = (`BM_SUBLB) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SUBLB) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SUBLB) ? 1'b1 : 1'bx;
							opmode_o = (`BM_SUBLB) ? 7'b0110011 : 7'bxxxxxxx;
						`else
							opmode_o = (`BM_SUBLB) ? 7'b0110010 : 7'bxxxxxxx;
						`endif
					end
				`SUBU: 	begin
						inmode_o = (`BM_SUBU) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_SUBU) ? 4'b0011 : 4'bxxxx;
						opmode_o = (`BM_SUBU) ? 7'b0110011 : 7'bxxxxxxx;
						regwrite_o = (`BM_SUBU) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_SUBU) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_SUBU) ? 1'b1 : 1'bx;
						branchen_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_SUBU) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						sa_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						ze_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						se_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						sr_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_SUBU) ? 1'b0 : 1'bx;
						`endif
					end

				`XOR: begin
						inmode_o = (`BM_XOR) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_XOR) ? 4'b0100 : 4'bxxxx;
						opmode_o = (`BM_XOR) ? 7'b0110011 : 7'bxxxxxxx;
						regwrite_o = (`BM_XOR) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_XOR) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_XOR) ? 1'b1 : 1'bx;
						branchen_o = (`BM_XOR) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_XOR) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_XOR) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_XOR) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_XOR) ? 1'b0 : 1'bx;
						sa_o = (`BM_XOR) ? 1'b0 : 1'bx;
						ze_o = (`BM_XOR) ? 1'b0 : 1'bx;
						se_o = (`BM_XOR) ? 1'b0 : 1'bx;
						sr_o = (`BM_XOR) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_XOR) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_XOR) ? 1'b0 : 1'bx;
						`endif
					end
				`XORLB: begin
						inmode_o = (`BM_XORLB) ? 5'b00000 : 5'bxxxxx;
						alumode_o = (`BM_XORLB) ? 4'b0100 : 4'bxxxx;
						regwrite_o = (`BM_XORLB) ? 1'b1 : 1'bx;
						regwriteui_o = (`BM_XORLB) ? 1'b0 : 1'bx; // RegWrite
						ce2_o = (`BM_XORLB) ? 1'b1 : 1'bx;
						branchen_o = (`BM_XORLB) ? 1'b0 : 1'bx;
						jumpregsel_o = (`BM_XORLB) ? 1'b0 : 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = (`BM_XORLB) ? 1'b0 : 1'bx;
						dm_we_o = (`BM_XORLB) ? 4'b0000 : 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = (`BM_XORLB) ? 1'b0 : 1'bx;
						sa_o = (`BM_XORLB) ? 1'b0 : 1'bx;
						ze_o = (`BM_XORLB) ? 1'b0 : 1'bx;
						se_o = (`BM_XORLB) ? 1'b0 : 1'bx;
						sr_o = (`BM_XORLB) ? 1'b0 : 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = (`BM_XORLB) ? 1'b0 : 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = (`BM_XORLB) ? 1'b1 : 1'bx;
							opmode_o = (`BM_XORLB) ? 7'b0110011 : 7'bxxxxxxx;
						`else
							opmode_o = (`BM_XORLB) ? 7'b0110010 : 7'bxxxxxxx;
						`endif
					end
				default: begin
						inmode_o = 5'bxxxxx;
						alumode_o = 4'bxxxx;
						opmode_o = 7'bxxxxxxx;
						regwrite_o = 1'bx;
						regwriteui_o = 1'bx; // RegWrite
						ce2_o = 1'bx;
						branchen_o = 1'bx;
						jumpregsel_o = 1'bx;
						regwritepc_o = 1'bx; 
						dm_re_o = 1'bx;
						dm_we_o = 4'bxxxx;
						loadtype_o = 3'bxxx;
						usemult_o = 1'bx;
						sa_o = 1'bx;
						ze_o = 1'bx;
						se_o = 1'bx;
						sr_o = 1'bx;
						branchtype_o = 3'bxxx;
						cmpsel_o = 1'bx;
						
						`ifdef EXTLOOPBACK
							extloopback_o = 1'bx;
						`endif
					end
			endcase
		end
		// Type I
		`ADDI:	begin 
				inmode_o = (`BM_ADDI) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_ADDI) ? 4'b0000 : 4'bxxxx;
				opmode_o = (`BM_ADDI) ? 7'b0110011 : 7'bxxxxxxx;
				regwrite_o = (`BM_ADDI) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_ADDI) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_ADDI) ? 1'b1 : 1'bx;
				branchen_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				regwritepc_o = (`BM_ADDI) ? 1'b0 : 1'bx; 
				dm_re_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_ADDI) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				sa_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				ze_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				se_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				sr_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_ADDI) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				`endif
			end
		`ADDILB:begin 
				inmode_o = (`BM_ADDILB) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_ADDILB) ? 4'b0000 : 4'bxxxx;
				regwrite_o = (`BM_ADDILB) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_ADDILB) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_ADDILB) ? 1'b1 : 1'bx;
				branchen_o = (`BM_ADDILB) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_ADDILB) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_ADDILB) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_ADDILB) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_ADDILB) ? 1'b0 : 1'bx;
				sa_o = (`BM_ADDILB) ? 1'b0 : 1'bx;
				ze_o = (`BM_ADDILB) ? 1'b0 : 1'bx;
				se_o = (`BM_ADDILB) ? 1'b0 : 1'bx;
				sr_o = (`BM_ADDILB) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_ADDILB) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_ADDILB) ? 1'b1 : 1'bx;
					opmode_o = (`BM_ADDILB) ? 7'b0110011 : 7'bxxxxxxx;
				`else
					opmode_o = (`BM_ADDILB) ? 7'b0100011 : 7'bxxxxxxx;
				`endif
			end
		`ADDIU: begin
				inmode_o = (`BM_ADDIU) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_ADDIU) ? 4'b0000 : 4'bxxxx;
				opmode_o = (`BM_ADDIU) ? 7'b0110011 : 7'bxxxxxxx;
				regwrite_o = (`BM_ADDIU) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_ADDIU) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_ADDIU) ? 1'b1 : 1'bx;
				branchen_o = (`BM_ADDIU) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_ADDI) ? 1'b0 : 1'bx;
				regwritepc_o = (`BM_ADDIU) ? 1'b0 : 1'bx; 
				dm_re_o = (`BM_ADDIU) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_ADDIU) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_ADDIU) ? 1'b0 : 1'bx;
				sa_o = (`BM_ADDIU) ? 1'b0 : 1'bx;
				ze_o = (`BM_ADDIU) ? 1'b0 : 1'bx;
				se_o = (`BM_ADDIU) ? 1'b1 : 1'bx;
				sr_o = (`BM_ADDIU) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_ADDIU) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_ADDIU) ? 1'b0 : 1'bx;
				`endif
			end
		`ANDI: begin
				inmode_o = (`BM_ANDI) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_ANDI) ? 4'b1100 : 4'bxxxx;
				opmode_o = (`BM_ANDI) ? 7'b0110011 : 7'bxxxxxxx;
				regwrite_o = (`BM_ANDI) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_ANDI) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_ANDI) ? 1'b1 : 1'bx;
				branchen_o = (`BM_ANDI) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_ANDI) ? 1'b0 : 1'bx;
				regwritepc_o = (`BM_ANDI) ? 1'b0 : 1'bx; 
				dm_re_o = (`BM_ANDI) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_ANDI) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_ANDI) ? 1'b0 : 1'bx;
				sa_o = (`BM_ANDI) ? 1'b0 : 1'bx;
				ze_o = (`BM_ANDI) ? 1'b0 : 1'bx;
				se_o = (`BM_ANDI) ? 1'b0 : 1'bx;
				sr_o = (`BM_ANDI) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_ANDI) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_ANDI) ? 1'b0 : 1'bx;
				`endif
			end
		`ANDILB: begin
				inmode_o = (`BM_ANDILB) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_ANDILB) ? 4'b1100 : 4'bxxxx;
				regwrite_o = (`BM_ANDILB) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_ANDILB) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_ANDILB) ? 1'b1 : 1'bx;
				branchen_o = (`BM_ANDILB) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_ANDILB) ? 1'b0 : 1'bx;
				regwritepc_o = (`BM_ANDILB) ? 1'b0 : 1'bx; 
				dm_re_o = (`BM_ANDILB) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_ANDILB) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_ANDILB) ? 1'b0 : 1'bx;
				sa_o = (`BM_ANDILB) ? 1'b0 : 1'bx;
				ze_o = (`BM_ANDILB) ? 1'b0 : 1'bx;
				se_o = (`BM_ANDILB) ? 1'b0 : 1'bx;
				sr_o = (`BM_ANDILB) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_ANDILB) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_ANDILB) ? 1'b1 : 1'bx;
					opmode_o = (`BM_ANDILB) ? 7'b0110011 : 7'bxxxxxxx;
				`else
					opmode_o = (`BM_ANDILB) ? 7'b0100011 : 7'bxxxxxxx;
				`endif
			end
		`BEQ:	begin // BEQZ
				inmode_o = (`BM_BEQ | `BM_BEQZ) 	? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_BEQ | `BM_BEQZ) 	? 4'b0011 : 4'bxxxx;
				opmode_o = (`BM_BEQ | `BM_BEQZ) 	? 7'b0110011 : 7'bxxxxxxx;
				regwrite_o = (`BM_BEQ | `BM_BEQZ) 	? 1'b0 : 1'bx;
				regwriteui_o = (`BM_BEQ | `BM_BEQZ) 	? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_BEQ | `BM_BEQZ) 		? 1'b1 : 1'bx;
				branchen_o = (`BM_BEQ | `BM_BEQZ) 	? 1'b1 : 1'bx;
				jumpregsel_o = (`BM_BEQ | `BM_BEQZ) 	? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_BEQ | `BM_BEQZ) 		? 1'b0 : 1'bx;
				dm_we_o = (`BM_BEQ | `BM_BEQZ) 		? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_BEQ | `BM_BEQZ) 	? 1'b0 : 1'bx;
				sa_o = (`BM_BEQ | `BM_BEQZ) 		? 1'b0 : 1'bx;
				ze_o = (`BM_BEQ | `BM_BEQZ) 		? 1'b0 : 1'bx;
				se_o = (`BM_BEQ | `BM_BEQZ) 		? 1'b0 : 1'bx;
				sr_o = (`BM_BEQ | `BM_BEQZ) 		? 1'b0 : 1'bx;
				branchtype_o = (`BM_BEQ | `BM_BEQZ) 	? 3'b100 : 3'bxxx;
				cmpsel_o = (`BM_BEQ | `BM_BEQZ) 	? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_BEQ) ? 1'b0 : 1'bx;
				`endif
			end	
		`BGEZ:	begin // BLTZ
				inmode_o = (`BM_BGEZ | `BM_BLTZ) 	? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_BGEZ | `BM_BLTZ) 	? 4'b0011 : 4'bxxxx;
				opmode_o = (`BM_BGEZ | `BM_BLTZ) 	? 7'b0110000 : 7'bxxxxxxx; // set mux x = 0
				regwrite_o = (`BM_BGEZ | `BM_BLTZ) 	? 1'b0 : 1'bx;
				regwriteui_o = (`BM_BGEZ | `BM_BLTZ) 	? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_BGEZ | `BM_BLTZ) 		? 1'b1 : 1'bx;
				branchen_o = (`BM_BGEZ | `BM_BLTZ) 	? 1'b1 : 1'bx;
				jumpregsel_o = (`BM_BGEZ | `BM_BLTZ) 	? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_BGEZ | `BM_BLTZ) 	? 1'b0 : 1'bx;
				dm_we_o = (`BM_BGEZ | `BM_BLTZ) 	? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_BGEZ | `BM_BLTZ) 	? 1'b0 : 1'bx;
				sa_o = (`BM_BGEZ | `BM_BLTZ) 		? 1'b0 : 1'bx;
				ze_o = (`BM_BGEZ | `BM_BLTZ) 		? 1'b0 : 1'bx;
				se_o = (`BM_BGEZ | `BM_BLTZ) 		? 1'b0 : 1'bx;
				sr_o = (`BM_BGEZ | `BM_BLTZ) 		? 1'b0 : 1'bx;
				branchtype_o = (`BM_BGEZ | `BM_BLTZ)	? {1'b0, inst_i[16], ~inst_i[16]} : 3'bxxx;
				cmpsel_o = (`BM_BGEZ | `BM_BLTZ) 	? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_BGEZ) 	? 1'b0 : 1'bx;
				`endif
			end	
		`BGTZ:	begin 
				inmode_o = (`BM_BGTZ) 			? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_BGTZ) 			? 4'b0011 : 4'bxxxx;
				opmode_o = (`BM_BGTZ) 			? 7'b0110000 : 7'bxxxxxxx;
				regwrite_o = (`BM_BGTZ) 		? 1'b0 : 1'bx;
				regwriteui_o = (`BM_BGTZ) 		? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_BGTZ) 			? 1'b1 : 1'bx;
				branchen_o = (`BM_BGTZ) 		? 1'b1 : 1'bx;
				jumpregsel_o = (`BM_BGTZ) 		? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_BGTZ) 			? 1'b0 : 1'bx;
				dm_we_o = (`BM_BGTZ) 			? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_BGTZ) 			? 1'b0 : 1'bx;
				sa_o = (`BM_BGTZ) 			? 1'b0 : 1'bx;
				ze_o = (`BM_BGTZ) 			? 1'b0 : 1'bx;
				se_o = (`BM_BGTZ) 			? 1'b0 : 1'bx;
				sr_o = (`BM_BGTZ) 			? 1'b0 : 1'bx;
				branchtype_o = (`BM_BGTZ) 		? 3'b111 : 3'bxxx;
				cmpsel_o = (`BM_BGTZ) 			? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_BGTZ) 	? 1'b0 : 1'bx;
				`endif
			end	
		`BLEZ:	begin 
				inmode_o = (`BM_BLEZ) 			? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_BLEZ) 			? 4'b0011 : 4'bxxxx;
				opmode_o = (`BM_BLEZ) 			? 7'b0110000 : 7'bxxxxxxx;
				regwrite_o = (`BM_BLEZ) 		? 1'b0 : 1'bx;
				regwriteui_o = (`BM_BLEZ) 		? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_BLEZ) 			? 1'b1 : 1'bx;
				branchen_o = (`BM_BLEZ) 		? 1'b1 : 1'bx;
				jumpregsel_o = (`BM_BLEZ) 		? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_BLEZ) 			? 1'b0 : 1'bx;
				dm_we_o = (`BM_BLEZ) 			? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_BLEZ) 			? 1'b0 : 1'bx;
				sa_o = (`BM_BLEZ) 			? 1'b0 : 1'bx;
				ze_o = (`BM_BLEZ) 			? 1'b0 : 1'bx;
				se_o = (`BM_BLEZ) 			? 1'b0 : 1'bx;
				sr_o = (`BM_BLEZ) 			? 1'b0 : 1'bx;
				branchtype_o = (`BM_BLEZ) 		? 3'b110 : 3'bxxx;
				cmpsel_o = (`BM_BLEZ) 			? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_BLEZ) 	? 1'b0 : 1'bx;
				`endif
			end	
		`BNE:	begin // BNEZ
				inmode_o = (`BM_BNE | `BM_BNEZ)		? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_BNE | `BM_BNEZ) 	? 4'b0011 : 4'bxxxx;
				opmode_o = (`BM_BNE | `BM_BNEZ) 	? 7'b0110011 : 7'bxxxxxxx;
				regwrite_o = (`BM_BNE | `BM_BNEZ) 	? 1'b0 : 1'bx;
				regwriteui_o = (`BM_BNE | `BM_BNEZ) 	? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_BNE | `BM_BNEZ) 		? 1'b1 : 1'bx;
				branchen_o = (`BM_BNE | `BM_BNEZ) 	? 1'b1 : 1'bx;
				jumpregsel_o = (`BM_BNE | `BM_BNEZ) 	? 1'b0 : 11'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_BNE | `BM_BNEZ) 		? 1'b0 : 1'bx;
				dm_we_o = (`BM_BNE | `BM_BNEZ) 		? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_BNE | `BM_BNEZ) 	? 1'b0 : 1'bx;
				sa_o = (`BM_BNE | `BM_BNEZ) 		? 1'b0 : 1'bx;
				ze_o = (`BM_BNE | `BM_BNEZ) 		? 1'b0 : 1'bx;
				se_o = (`BM_BNE | `BM_BNEZ)		? 1'b0 : 1'bx;
				sr_o = (`BM_BNE | `BM_BNEZ) 		? 1'b0 : 1'bx;
				branchtype_o = (`BM_BNE | `BM_BNEZ) 	? 3'b101 : 3'bxxx;
				cmpsel_o = (`BM_BNE | `BM_BNEZ) 	? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_BNE) 	? 1'b0 : 1'bx;
				`endif
			end	
		`LBU:	begin
				inmode_o = 5'bxxxxx;
				alumode_o = 4'bxxxx;
				opmode_o = 7'bxxxxxxx;
				regwrite_o = (`BM_LBU) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_LBU) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = 1'bx;
				branchen_o = (`BM_LBU) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_LBU) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_LBU) ? 1'b1 : 1'bx;
				dm_we_o = (`BM_LBU) ? 4'b0000 : 4'bxxxx;
				loadtype_o = (`BM_LBU) ? 3'b100 : 3'bxxx;
				usemult_o = 1'bx;
				sa_o = 1'bx;
				ze_o = 1'bx;
				se_o = 1'bx;
				sr_o = (`BM_LBU) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_LBU) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_LBU) ? 1'b0 : 1'bx;
				`endif
			end
		`LH:	begin
				inmode_o = 5'bxxxxx;
				alumode_o = 4'bxxxx;
				opmode_o = 7'bxxxxxxx;
				regwrite_o = (`BM_LH) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_LH) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = 1'bx;
				branchen_o = (`BM_LH) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_LH) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_LH) ? 1'b1 : 1'bx;
				dm_we_o = (`BM_LH) ? 4'b0000 : 4'bxxxx; // fix this! you dun want to write accidentally
				loadtype_o = (`BM_LH) ? 3'b111 : 3'bxxx;
				usemult_o = 1'bx;
				sa_o = 1'bx;
				ze_o = 1'bx;
				se_o = 1'bx;
				sr_o = (`BM_LH) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_LH) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_LH) ? 1'b0 : 1'bx;
				`endif
			end
		`LUI:	begin 
				inmode_o = (`BM_LUI) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_LUI) ? 4'b0000 : 4'bxxxx;
				opmode_o = (`BM_LUI) ? 7'b0000011 : 7'bxxxxxxx; // still using a:b
				regwrite_o = (`BM_LUI) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_LUI) ? 1'b1 : 1'bx; // RegWrite
				ce2_o = (`BM_LUI) ? 1'b1 : 1'bx;
				branchen_o = (`BM_LUI) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_LUI) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_LUI) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_LUI) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_LUI) ? 1'b0 : 1'bx;
				sa_o = (`BM_LUI) ? 1'b0 : 1'bx;
				ze_o = 1'bx;
				se_o = 1'bx;
				sr_o = (`BM_LUI) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_LUI) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_LUI) ? 1'b0 : 1'bx;
				`endif
			end
		`LW:	begin
				inmode_o = 5'bxxxxx;
				alumode_o = 4'bxxxx;
				opmode_o = 7'bxxxxxxx;
				regwrite_o = (`BM_LW) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_LW) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = 1'bx;
				branchen_o = (`BM_LW) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_LW) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_LW) ? 1'b1 : 1'bx;
				dm_we_o = (`BM_LW) ? 4'b0000 : 4'bxxxx;
				loadtype_o = (`BM_LW) ? 3'b001 : 3'bxxx;
				usemult_o = 1'bx;
				sa_o = 1'bx;
				ze_o = 1'bx;
				se_o = 1'bx;
				sr_o = (`BM_LW) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_LW) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_LW) ? 1'b0 : 1'bx;
				`endif
			end
		`ORI: begin
				inmode_o = (`BM_ORI) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_ORI) ? 4'b1100 : 4'bxxxx;
				opmode_o = (`BM_ORI) ? 7'b0111011 : 7'bxxxxxxx;
				regwrite_o = (`BM_ORI) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_ORI) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_ORI) ? 1'b1 : 1'bx;
				branchen_o = (`BM_ORI) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_ORI) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_ORI) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_ORI) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_ORI) ? 1'b0 : 1'bx;
				sa_o = (`BM_ORI) ? 1'b0 : 1'bx;
				ze_o = (`BM_ORI) ? 1'b0 : 1'bx;
				se_o = (`BM_ORI) ? 1'b0 : 1'bx;
				sr_o = (`BM_ORI) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_ORI) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_ORI) ? 1'b0 : 1'bx;
				`endif
			end
		`ORILB: begin
				inmode_o = (`BM_ORILB) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_ORILB) ? 4'b1100 : 4'bxxxx;
				regwrite_o = (`BM_ORILB) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_ORILB) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_ORILB) ? 1'b1 : 1'bx;
				branchen_o = (`BM_ORILB) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_ORILB) ? 1'b0 : 1'bx;
				regwritepc_o = (`BM_ORILB) ? 1'b0 : 1'bx; 
				dm_re_o = (`BM_ORILB) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_ORILB) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_ORILB) ? 1'b0 : 1'bx;
				sa_o = (`BM_ORILB) ? 1'b0 : 1'bx;
				ze_o = (`BM_ORILB) ? 1'b0 : 1'bx;
				se_o = (`BM_ORILB) ? 1'b0 : 1'bx;
				sr_o = (`BM_ORILB) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_ORILB) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_ORILB) ? 1'b1 : 1'bx;
					opmode_o = (`BM_ORILB) ? 7'b0111011 : 7'bxxxxxxx;
				`else
					opmode_o = (`BM_ORILB) ? 7'b0101011 : 7'bxxxxxxx;
				`endif
			end

		`SLTI:	begin 
				inmode_o = (`BM_SLTI) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_SLTI) ? 4'b0011 : 4'bxxxx;
				opmode_o = (`BM_SLTI) ? 7'b0110011 : 7'bxxxxxxx;
				regwrite_o = (`BM_SLTI) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_SLTI) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_SLTI) ? 1'b1 : 1'bx;
				branchen_o = (`BM_SLTI) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_SLTI) ? 1'b0 : 1'bx;
				regwritepc_o = (`BM_SLTI) ? 1'b0 : 1'bx; 
				dm_re_o = (`BM_SLTI) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_SLTI) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_SLTI) ? 1'b0 : 1'bx;
				sa_o = (`BM_SLTI) ? 1'b0 : 1'bx;
				ze_o = (`BM_SLTI) ? 1'b0 : 1'bx;
				se_o = (`BM_SLTI) ? 1'b0 : 1'bx;
				sr_o = (`BM_SLTI) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_SLTI) ? 1'b1 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_SLTI) ? 1'b0 : 1'bx;
				`endif
			end
		`SLTIU:	begin 
				inmode_o = (`BM_SLTIU) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_SLTIU) ? 4'b0011 : 4'bxxxx;
				opmode_o = (`BM_SLTIU) ? 7'b0110011 : 7'bxxxxxxx;
				regwrite_o = (`BM_SLTIU) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_SLTIU) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_SLTIU) ? 1'b1 : 1'bx;
				branchen_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				regwritepc_o = (`BM_SLTIU) ? 1'b0 : 1'bx; 
				dm_re_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				sa_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				ze_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				se_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				sr_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_SLTIU) ? 1'b1 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_SLTIU) ? 1'b0 : 1'bx;
				`endif
			end
		`SW:	begin
				inmode_o = 5'bxxxxx;
				alumode_o = 4'bxxxx;
				opmode_o = 7'bxxxxxxx;
				regwrite_o = (`BM_SW) ? 1'b0 : 1'bx;
				regwriteui_o = (`BM_SW) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = 1'bx;
				branchen_o = (`BM_SW) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_SW) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_SW) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_SW) ? 4'b1111 : 1'bx;
				loadtype_o = 3'bxxx;
				usemult_o = 1'bx;
				sa_o = 1'bx;
				ze_o = 1'bx;
				se_o = 1'bx;
				sr_o = (`BM_SW) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_SW) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_SW) ? 1'b0 : 1'bx;
				`endif
			end
		`SH:	begin
				inmode_o = 5'bxxxxx;
				alumode_o = 4'bxxxx;
				opmode_o = 7'bxxxxxxx;
				regwrite_o = (`BM_SH) ? 1'b0 : 1'bx;
				regwriteui_o = (`BM_SH) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = 1'bx;
				branchen_o = (`BM_SH) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_SH) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_SH) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_SH) ? 4'b0011 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = 1'bx;
				sa_o = 1'bx;
				ze_o = 1'bx;
				se_o = 1'bx;
				sr_o = (`BM_SH) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_SH) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_SH) ? 1'b0 : 1'bx;
				`endif
			end

		`SB:	begin
				inmode_o = 5'bxxxxx;
				alumode_o = 4'bxxxx;
				opmode_o = 7'bxxxxxxx;
				regwrite_o = (`BM_SB) ? 1'b0 : 1'bx;
				regwriteui_o = (`BM_SB) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = 1'bx;
				branchen_o = (`BM_SB) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_SB) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_SB) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_SB) ? 4'b0001 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = 1'bx;
				sa_o = 1'bx;
				ze_o = 1'bx;
				se_o = 1'bx;
				sr_o = (`BM_SB) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_SB) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_SB) ? 1'b0 : 1'bx;
				`endif
			end

		`XORI: begin
				inmode_o = (`BM_XORI) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_XORI) ? 4'b0100 : 4'bxxxx;
				opmode_o = (`BM_XORI) ? 7'b0110011 : 7'bxxxxxxx;
				regwrite_o = (`BM_XORI) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_XORI) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_XORI) ? 1'b1 : 1'bx;
				branchen_o = (`BM_XORI) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_XORI) ? 1'b0 : 1'bx;
				regwritepc_o = (`BM_XORI) ? 1'b0 : 1'bx; 
				dm_re_o = (`BM_XORI) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_XORI) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_XORI) ? 1'b0 : 1'bx;
				sa_o = (`BM_XORI) ? 1'b0 : 1'bx;
				ze_o = (`BM_XORI) ? 1'b0 : 1'bx;
				se_o = (`BM_XORI) ? 1'b0 : 1'bx;
				sr_o = (`BM_XORI) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_XORI) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_XORI) ? 1'b0 : 1'bx;
				`endif
			end
		`XORILB: begin
				inmode_o = (`BM_XORILB) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_XORILB) ? 4'b0100 : 4'bxxxx;
				regwrite_o = (`BM_XORILB) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_XORILB) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_XORILB) ? 1'b1 : 1'bx;
				branchen_o = (`BM_XORILB) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_XORILB) ? 1'b0 : 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = (`BM_XORILB) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_XORILB) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_XORILB) ? 1'b0 : 1'bx;
				sa_o = (`BM_XORILB) ? 1'b0 : 1'bx;
				ze_o = (`BM_XORILB) ? 1'b0 : 1'bx;
				se_o = (`BM_XORILB) ? 1'b0 : 1'bx;
				sr_o = (`BM_XORILB) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_XORILB) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_XORILB) ? 1'b1 : 1'bx;
					opmode_o = (`BM_XORILB) ? 7'b0110011 : 7'bxxxxxxx;
				`else
					opmode_o = (`BM_XORILB) ? 7'b0100011 : 7'bxxxxxxx;
				`endif
			end

		// Type J
		`J:	begin
				inmode_o = 5'bxxxxx;
				alumode_o = 4'bxxxx;
				opmode_o = 7'bxxxxxxx;
				regwrite_o = (`BM_J) ? 1'b0 : 1'bx;
				regwriteui_o = (`BM_J) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = 1'bx; // doesn't matter actually -- as the ALU is not used
				branchen_o = (`BM_J) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_J) ? 1'b0 : 1'bx; 
				regwritepc_o = (`BM_J) ? 1'b0 : 1'bx; 
				dm_re_o = (`BM_J) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_J) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_J) ? 1'b0 : 1'bx;
				sa_o = 1'bx;
				ze_o = 1'bx;
				se_o = 1'bx;
				sr_o = (`BM_J) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_J) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_J) ? 1'b0 : 1'bx;
				`endif
			end
		`JAL:	begin 
				inmode_o = (`BM_JAL) ? 5'b00000 : 5'bxxxxx;
				alumode_o = (`BM_JAL) ? 4'b0000 : 4'bxxxx;
				opmode_o = (`BM_JAL) ? 7'b0110011 : 7'bxxxxxxx;
				regwrite_o = (`BM_JAL) ? 1'b1 : 1'bx;
				regwriteui_o = (`BM_JAL) ? 1'b0 : 1'bx; // RegWrite
				ce2_o = (`BM_JAL) ? 1'b1 : 1'bx;
				branchen_o = (`BM_JAL) ? 1'b0 : 1'bx;
				jumpregsel_o = (`BM_JAL) ? 1'b0 : 1'bx; 
				regwritepc_o = (`BM_JAL) ? 1'b1 : 1'bx; 
				dm_re_o = (`BM_JAL) ? 1'b0 : 1'bx;
				dm_we_o = (`BM_JAL) ? 4'b0000 : 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = (`BM_JAL) ? 1'b0 : 1'bx;
				sa_o = (`BM_JAL) ? 1'b0 : 1'bx;
				ze_o = (`BM_JAL) ? 1'b0 : 1'bx;
				se_o = (`BM_JAL) ? 1'b0 : 1'bx;
				sr_o = (`BM_JAL) ? 1'b0 : 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = (`BM_JAL) ? 1'b0 : 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = (`BM_JAL) ? 1'b0 : 1'bx;
				`endif

			end
		default: begin
				inmode_o = 5'bxxxxx;
				alumode_o = 4'bxxxx;
				opmode_o = 7'bxxxxxxx;
				regwrite_o = 1'bx;
				regwriteui_o = 1'bx; // RegWrite
				ce2_o = 1'bx;
				branchen_o = 1'bx;
				jumpregsel_o = 1'bx;
				regwritepc_o = 1'bx; 
				dm_re_o = 1'bx;
				dm_we_o = 4'bxxxx;
				loadtype_o = 3'bxxx;
				usemult_o = 1'bx;
				sa_o = 1'bx;
				ze_o = 1'bx;
				se_o = 1'bx;
				sr_o = 1'bx;
				branchtype_o = 3'bxxx;
				cmpsel_o = 1'bx;
						
				`ifdef EXTLOOPBACK
					extloopback_o = 1'bx;
				`endif
			end
	endcase
end

endmodule
