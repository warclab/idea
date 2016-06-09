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
	* This processor is a proof-of-concept of the usability of the DSP48E1 as
	* the execution unit of a general-purpose processor. It is not a full-blown processor.
	*
	* Description:
	* Macro definition of the constants used in the design files.
	*

******************************************************************************************/
// Compiler directives
//`define EXTLOOPBACK
`define DATA_WIDTH 32
`define REG_ADDR_WIDTH 5
`define PORTAWIDTH 30
`define PORTBWIDTH 18
`define PORTCWIDTH 48
`define PORTPWIDTH 48
`define MULT_DATA_WIDTH 16
`define DM_ADDR_WIDTH 	9
`define IM_ADDR_WIDTH 	9
// R-Type Opcode=000000 Funct=
`define ADD 	6'b100000
`define ADDU	6'b100001
`define AND	6'b100100
`define JR	6'b001000
`define MULT	6'b011000
`define MULTU	6'b011001
`define NOR	6'b100111
`define OR	6'b100101
`define SLL	6'b000000
`define SLLV	6'b000100
`define SLT	6'b101010
`define SLTU	6'b101011
`define SRL	6'b000010
`define SRA	6'b000011
`define SRLV	6'b000110
`define SRAV	6'b000111
`define SUB	6'b100010
`define SUBU	6'b100011
`define XOR	6'b100110
`define ORLB	6'b110101
`define NORLB	6'b110111
`define ANDLB	6'b110100
`define ADDLB	6'b110000
`define XORLB	6'b110110
`define SUBLB	6'b110010
// I-Type Opcode=
`define ADDI 	6'b001000
`define ADDIU 	6'b001001
`define ANDI	6'b001100
`define BEQ	6'b000100
`define BEQZ	6'b000100
`define BGEZ	6'b000001
`define BGTZ	6'b000111
`define BLEZ	6'b000110
`define BLTZ	6'b000001
`define BNE	6'b000101
`define BNEZ	6'b000101
`define SLTI	6'b001010
`define SLTIU	6'b001011
`define SB	6'b101000
`define SH	6'b101001
`define SW	6'b101011
`define LUI	6'b001111
`define LBU	6'b100100
`define LH	6'b100001
`define LW	6'b100011
`define ORI	6'b001101
`define XORI	6'b001110
`define ORILB	6'b111101
`define ANDILB	6'b111100
`define ADDILB	6'b111000
`define XORILB	6'b111110
// J-Type Opcode=
`define J       6'b000010
`define JAL     6'b000011
