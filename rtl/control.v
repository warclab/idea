`include "defines.v"
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
	* Control Unit of the processor.
	* Control signals are hardwired combinational logic
	* Input is a 32-bit intruction and decoded according to the format of the
	* instruction. 
	*

******************************************************************************************/

module control (

	// ***** Input *****
	input [31:0] inst_i,
	
	// ***** Output *****
	// => Register File
	output [4:0] addr_ra_o, 
	output [4:0] addr_rb_o,
	output [4:0] addr_rc_o, 
	// => Execute => Register file
	output [4:0] addr_rd_o, 
	output regfile_we_w_o,
	output regfile_we_uhw_o,
	// => Data memory 
	output dm_we_o,
	output dm_re_o,
	// => Offset Adder
	output ofsadden_o,
	// => Input Map
	output usemult_o,
	output useimm_o,
	output usemov_o,
	output seta0_o,
	output setb0_o,
	output setc0_o,
	output [15:0] imm_o,
	// => Execute => Branch
	output branchen_o,
	output [`cond_code_width-1:0] condcode_o,
	output [`im_addr_width-1:0] branchtarget_o,
	// => Execute => Status Register
	output sr_we_o,
	// => ALU
	output [4:0] inmode_o,
	output reg [3:0] alumode_o,
	output reg [6:0] opmode_o,
	output ce2_o

);

wire setstatus, immstatus;
wire [`cond_code_width-1:0] condcode;
wire [`opcode_width-1:0] opcode;

// Instruction bit allocation *********
// Control
assign condcode		= inst_i[`inst_cond_code_bit_2:`inst_cond_code_bit_0];
assign setstatus 	= inst_i[`inst_set_bit];
assign immstatus	= inst_i[`inst_imm_bit];
assign opcode 		= inst_i[`inst_opcode_bit_4:`inst_opcode_bit_0];
// Data
assign addr_rd_o	= inst_i[`inst_rd_4:`inst_rd_0];
assign addr_ra_o	= (opcode == `CB) ? inst_i[`inst_ra_cb_4:`inst_ra_cb_0] : inst_i[`inst_ra_4:`inst_ra_0];
assign addr_rb_o	= (opcode == `CB) ? inst_i[`inst_rb_cb_4:`inst_rb_cb_0] : inst_i[`inst_rb_4:`inst_rb_0];
assign addr_rc_o	= (opcode == `CB) ? inst_i[`inst_rc_cb_4:`inst_rc_cb_0] : inst_i[`inst_rc_4:`inst_rc_0];
assign imm_o			= inst_i[`inst_imm_15:`inst_imm_0];
assign branchtarget_o 	= inst_i[`inst_label_8:`inst_label_0];

// Generated Control Signals (control_signals-fpt.xls) **********

// => Register File
assign regfile_we_w_o = (opcode == `NOP) ?	1'b0 :
						(((opcode[4] == 1'b0) || (opcode == `MOV) || (opcode == `MOVL) || (opcode == `LDR)) ? 1'b1 : 1'b0); 
assign regfile_we_uhw_o = (opcode == `MOVU) ? 1'b1 : 1'b0;

// => Data Memory
assign dm_we_o = (opcode == `STR) ? 1'b1 : 1'b0;
assign dm_re_o = (opcode == `LDR) ? 1'b1 : 1'b0;

// => Offset Adder
assign ofsadden_o = ((opcode[4:2] == 3'b111)) ? 1'b1 : 1'b0; // LDR and STR

// => Input Map
assign usemult_o = ((opcode[4:2] == 3'b001)) ? 1'b1 : 1'b0; // all 4 mul instructions
assign useimm_o = immstatus;
assign usemov_o = immstatus && (opcode == `MOVU || opcode == `MOVL);
assign seta0_o = ((immstatus && (opcode[4:3] == `ARITH || opcode == `CMP)) || (opcode[4:2] == 3'b110)) ? 1'b1 : 1'b0;
assign setb0_o = (opcode == `MOV || opcode == `MOVU || opcode == `MOVL) ? 1'b1: 1'b0;
assign setc0_o = (opcode == `MUL ) ? 1'b1 : 1'b0;

// => Branch;
assign branchen_o = (opcode == `CB) ? 1'b1 : 1'b0;
assign condcode_o = condcode;

// => Status Register
assign sr_we_o = setstatus;

// => ALU
assign inmode_o = (opcode[4:2] == 3'b001) ? 5'b10001 : 5'b00000;

always@ (opcode)
begin
	case(opcode[4:3])
		`ARITH: begin
				case (opcode[2:0])
					/*`ADD*/ 3'b001: alumode_o = 4'b0000;
					/*`SUB*/ 3'b010: alumode_o = 4'b0011;
					/*`MUL*/ 3'b100: alumode_o = 4'b0000;
					/*`MAC*/ 3'b101: alumode_o = 4'b0000;
					/*`MADD*/3'b110: alumode_o = 4'b0000;
					/*`MSUB*/3'b111: alumode_o = 4'b0011;
					default: alumode_o = 4'b0000;
				endcase
				end
		`LOGIC:	begin
				case (opcode[2:0])
					/*`AND*/ 3'b000: alumode_o = 4'b1100;
					/*`XOR*/ 3'b001: alumode_o = 4'b0100;
					/*`XNR*/ 3'b010: alumode_o = 4'b0101;
					/*`OR*/  3'b011: alumode_o = 4'b1100;
					/*`NOR*/ 3'b100: alumode_o = 4'b1110;
					/*`NAND*/3'b101: alumode_o = 4'b1110;
					default: alumode_o = 4'b0000;
				endcase
				end
		`CTRL: 	begin
					alumode_o = 4'b0011;
				end
		`TRANS: begin
					alumode_o = 4'b0000;
				end
		default: alumode_o = 4'b0000;
	endcase
end

always@ (opcode)
begin
	case(opcode[4:3])
		`ARITH: begin
				case (opcode[2:0])
					/*NOP*/ 3'b000: opmode_o = 7'b0000000;
					/*ADD*/ 3'b001: opmode_o = 7'b0110011;
					/*SUB*/ 3'b010: opmode_o = 7'b0110011;
					/*MUL*/ 3'b100: opmode_o = 7'b0000101;
					/*MAC*/ 3'b101: opmode_o = 7'b1000101;
					/*MADD*/3'b110: opmode_o = 7'b0110101;
					/*MSUB*/3'b111: opmode_o = 7'b0110101;
					default: opmode_o = 7'b0000000;
				endcase
				end
		`LOGIC:	begin
				case (opcode[2:0])
					/*`AND*/ 3'b000: opmode_o = 7'b0110011;
					/*`XOR*/ 3'b001: opmode_o = 7'b0110011;
					/*`XNR*/ 3'b010: opmode_o = 7'b0110011;
					/*`OR*/  3'b011: opmode_o = 7'b0111011;
					/*`NOR*/ 3'b100: opmode_o = 7'b0111011;
					/*`NAND*/3'b101: opmode_o = 7'b0110011;
					default: opmode_o = 7'b0000000;
				endcase
				end
		`CTRL: 	begin
					opmode_o = 7'b0110011;
				end
		`TRANS: begin
					opmode_o = 7'b0110011;
				end
		default: opmode_o = 7'b0000000;
	endcase
end

assign ce2_o = (opcode[4:2] == 3'b001) ? 1'b0 : 1'b1;

endmodule
