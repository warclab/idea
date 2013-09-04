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
	* Macro definition of the constants used in the design files.
	*

******************************************************************************************/
// control.v ctrl
`define datawidth 				32
`define cond_code_width 		3
`define opcode_width 			5
`define opcode_bit_3			3
`define opcode_bit_4			4
`define inst_label_0			0
`define inst_label_7			7
`define inst_label_8			8
`define inst_imm_0				0
`define inst_imm_15				15
`define inst_rc_0				1
`define inst_rc_4				5
`define inst_rb_0				6
`define inst_rb_4				10
`define inst_ra_0				11
`define inst_ra_4				15
`define inst_rd_0				16
`define inst_rd_4				20
`define inst_ra_cb_0			16
`define inst_ra_cb_4			20
`define inst_rb_cb_4			15
`define inst_rb_cb_0			11
`define inst_rc_cb_0			6
`define inst_rc_cb_4			10
`define inst_opcode_bit_4		25
`define inst_opcode_bit_0		21
`define inst_imm_bit			26
`define inst_set_bit			27
`define inst_cond_code_bit_2	30
`define inst_cond_code_bit_0	28
`define ARITH 	2'b00
`define LOGIC	2'b01
`define CTRL	2'b10
`define TRANS	2'b11
`define NOP 	5'b00000
`define ADD 	5'b00001
`define SUB 	5'b00010
`define MUL 	5'b00100
`define MAC 	5'b00101
`define MADD 	5'b00110
`define MSUB 	5'b00111
`define AND 	5'b01000
`define XOR 	5'b01001
`define XNR 	5'b01010
`define OR 		5'b01011
`define NOR 	5'b01100
`define NAND 	5'b01101
`define CMP 	5'b10000
`define CB	 	5'b10001
`define B 		5'b10010
`define BEQ 	5'b10011
`define BNE 	5'b10011
`define MOV 	5'b11000
`define MOVU 	5'b11001
`define MOVL 	5'b11010
`define LDR 	5'b11100
`define STR 	5'b11101
// regfile.v rf
`define reg_addr_width 5
// input_alloc.v ia
`define portawidth 30
`define portbwidth 18
`define portcwidth 48
`define portpwidth 48
`define mult_data_width 16
// memaddr_gen.v maddgen
`define dm_depth 		/*256*/ 512
`define dm_addr_width 	/*8*/ 9
// instruction memory
`define im_depth 		/*256*/ 512
`define im_addr_width 	/*8*/ 9
// branch.v
`define EQ 3'b000 
`define NE 3'b001
`define GE 3'b010
`define LT 3'b011
`define GT 3'b100
`define LE 3'b101
`define AL 3'b110 
