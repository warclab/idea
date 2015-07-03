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
	* Register file of size 32 x 32. 
	* 32 x 2 (Depth x Width) x 16 (Number of RAM32Ms)
	* Built using direct instantiation of RAM32M soft-primitive. Synthesized to LUTs.
	* Inference through behavioural description would consume ~twice as much
	* resources compared to direct instantiation.
	*

******************************************************************************************/
`include "defines.v"

module regfile (
	input 				clk,
	input 				regwrite_i,
	input 				regwriteui_i,
	input [`REG_ADDR_WIDTH-1:0] 	ra_addr_i, // register a read
	input [`REG_ADDR_WIDTH-1:0] 	rb_addr_i, // register b read
	input [`REG_ADDR_WIDTH-1:0] 	rc_addr_i, // register c read
	input [`REG_ADDR_WIDTH-1:0] 	rd_addr_i, // register d write
	input [`DATA_WIDTH-1:0]		rd_writedata_i, 
	output [`DATA_WIDTH-1:0]	ra_readdata_o, 
	output [`DATA_WIDTH-1:0]	rb_readdata_o, 
	output [`DATA_WIDTH-1:0]	rc_readdata_o 
);

assign we = 	regwrite_i | regwriteui_i; 

// read data
wire [1:0] ra_readdata_0, ra_readdata_1, ra_readdata_2, ra_readdata_3, ra_readdata_4, ra_readdata_5, ra_readdata_6, ra_readdata_7;
wire [1:0] ra_readdata_8, ra_readdata_9, ra_readdata_10, ra_readdata_11, ra_readdata_12, ra_readdata_13, ra_readdata_14, ra_readdata_15;
wire [1:0] rb_readdata_0, rb_readdata_1, rb_readdata_2, rb_readdata_3, rb_readdata_4, rb_readdata_5, rb_readdata_6, rb_readdata_7;
wire [1:0] rb_readdata_8, rb_readdata_9, rb_readdata_10, rb_readdata_11, rb_readdata_12, rb_readdata_13, rb_readdata_14, rb_readdata_15;
wire [1:0] rc_readdata_0, rc_readdata_1, rc_readdata_2, rc_readdata_3, rc_readdata_4, rc_readdata_5, rc_readdata_6, rc_readdata_7;
wire [1:0] rc_readdata_8, rc_readdata_9, rc_readdata_10, rc_readdata_11, rc_readdata_12, rc_readdata_13, rc_readdata_14, rc_readdata_15;
// written data
wire [1:0] rd_writedata_0, rd_writedata_1, rd_writedata_2, rd_writedata_3, rd_writedata_4, rd_writedata_5, rd_writedata_6, rd_writedata_7;
wire [1:0] rd_writedata_8, rd_writedata_9, rd_writedata_10, rd_writedata_11, rd_writedata_12, rd_writedata_13, rd_writedata_14, rd_writedata_15;

assign {rd_writedata_15, rd_writedata_14, rd_writedata_13, rd_writedata_12, rd_writedata_11, rd_writedata_10, rd_writedata_9, rd_writedata_8} = (regwriteui_i) ? rd_writedata_i[15:0] : rd_writedata_i[31:16]; // write
assign {rd_writedata_7, rd_writedata_6, rd_writedata_5, rd_writedata_4, rd_writedata_3, rd_writedata_2, rd_writedata_1, rd_writedata_0} = (regwriteui_i) ? {16{1'b0}} : rd_writedata_i[15:0]; // write bottom

assign ra_readdata_o = {ra_readdata_15, ra_readdata_14, ra_readdata_13, ra_readdata_12, ra_readdata_11, ra_readdata_10, ra_readdata_9, ra_readdata_8, ra_readdata_7, ra_readdata_6, ra_readdata_5, ra_readdata_4, ra_readdata_3, ra_readdata_2, ra_readdata_1, ra_readdata_0}; // reada
assign rb_readdata_o = {rb_readdata_15, rb_readdata_14, rb_readdata_13, rb_readdata_12, rb_readdata_11, rb_readdata_10, rb_readdata_9, rb_readdata_8, rb_readdata_7, rb_readdata_6, rb_readdata_5, rb_readdata_4, rb_readdata_3, rb_readdata_2, rb_readdata_1, rb_readdata_0}; // readb
assign rc_readdata_o = {rc_readdata_15, rc_readdata_14, rc_readdata_13, rc_readdata_12, rc_readdata_11, rc_readdata_10, rc_readdata_9, rc_readdata_8, rc_readdata_7, rc_readdata_6, rc_readdata_5, rc_readdata_4, rc_readdata_3, rc_readdata_2, rc_readdata_1, rc_readdata_0}; // readc

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_15 (
	.DOA(ra_readdata_15), // Read port A 2-bit output
	.DOB(rb_readdata_15), // Read port B 2-bit output
	.DOC(rc_readdata_15), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_15), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_15), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_15), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_15), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_14 (
	.DOA(ra_readdata_14), // Read port A 2-bit output
	.DOB(rb_readdata_14), // Read port B 2-bit output
	.DOC(rc_readdata_14), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_14), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_14), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_14), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_14), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_13 (
	.DOA(ra_readdata_13), // Read port A 2-bit output
	.DOB(rb_readdata_13), // Read port B 2-bit output
	.DOC(rc_readdata_13), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_13), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_13), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_13), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_13), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_12 (
	.DOA(ra_readdata_12), // Read port A 2-bit output
	.DOB(rb_readdata_12), // Read port B 2-bit output
	.DOC(rc_readdata_12), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_12), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_12), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_12), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_12), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_11 (
	.DOA(ra_readdata_11), // Read port A 2-bit output
	.DOB(rb_readdata_11), // Read port B 2-bit output
	.DOC(rc_readdata_11), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_11), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_11), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_11), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_11), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_10 (
	.DOA(ra_readdata_10), // Read port A 2-bit output
	.DOB(rb_readdata_10), // Read port B 2-bit output
	.DOC(rc_readdata_10), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_10), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_10), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_10), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_10), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port

	) RAM32M_inst_9 (
	.DOA(ra_readdata_9), // Read port A 2-bit output
	.DOB(rb_readdata_9), // Read port B 2-bit output
	.DOC(rc_readdata_9), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_9), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_9), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_9), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_9), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port

	) RAM32M_inst_8 (
	.DOA(ra_readdata_8), // Read port A 2-bit output
	.DOB(rb_readdata_8), // Read port B 2-bit output
	.DOC(rc_readdata_8), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_8), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_8), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_8), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_8), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_7 (
	.DOA(ra_readdata_7), // Read port A 2-bit output
	.DOB(rb_readdata_7), // Read port B 2-bit output
	.DOC(rc_readdata_7), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_7), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_7), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_7), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_7), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_6 (
	.DOA(ra_readdata_6), // Read port A 2-bit output
	.DOB(rb_readdata_6), // Read port B 2-bit output
	.DOC(rc_readdata_6), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_6), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_6), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_6), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_6), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_5 (
	.DOA(ra_readdata_5), // Read port A 2-bit output
	.DOB(rb_readdata_5), // Read port B 2-bit output
	.DOC(rc_readdata_5), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_5), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_5), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_5), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_5), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_4 (
	.DOA(ra_readdata_4), // Read port A 2-bit output
	.DOB(rb_readdata_4), // Read port B 2-bit output
	.DOC(rc_readdata_4), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_4), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_4), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_4), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_4), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_3 (
	.DOA(ra_readdata_3), // Read port A 2-bit output
	.DOB(rb_readdata_3), // Read port B 2-bit output
	.DOC(rc_readdata_3), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_3), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_3), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_3), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_3), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'h5555555500000000), // Initial contents of A Port
	.INIT_B(64'h5555555500000000), // Initial contents of B Port
	.INIT_C(64'h5555555500000000), // Initial contents of C Port
	.INIT_D(64'h5555555500000000) // Initial contents of D Port
	) RAM32M_inst_2 (
	.DOA(ra_readdata_2), // Read port A 2-bit output
	.DOB(rb_readdata_2), // Read port B 2-bit output
	.DOC(rc_readdata_2), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_2), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_2), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_2), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_2), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'hffaa5500ffaa5500), // Initial contents of A Port
	.INIT_B(64'hffaa5500ffaa5500), // Initial contents of B Port
	.INIT_C(64'hffaa5500ffaa5500), // Initial contents of C Port
	.INIT_D(64'hffaa5500ffaa5500) // Initial contents of D Port
	) RAM32M_inst_1 (
	.DOA(ra_readdata_1), // Read port A 2-bit output
	.DOB(rb_readdata_1), // Read port B 2-bit output
	.DOC(rc_readdata_1), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_1), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_1), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_1), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_1), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

RAM32M #(
	.INIT_A(64'he4e4e4e4e4e4e4e4), // Initial contents of A Port
	.INIT_B(64'he4e4e4e4e4e4e4e4), // Initial contents of B Port
	.INIT_C(64'he4e4e4e4e4e4e4e4), // Initial contents of C Port
	.INIT_D(64'he4e4e4e4e4e4e4e4) // Initial contents of D Port
	) RAM32M_inst_0 (
	.DOA(ra_readdata_0), // Read port A 2-bit output
	.DOB(rb_readdata_0), // Read port B 2-bit output
	.DOC(rc_readdata_0), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(ra_addr_i), // Read port A 5-bit address input
	.ADDRB(rb_addr_i), // Read port B 5-bit address input
	.ADDRC(rc_addr_i), // Read port C 5-bit address input
	.ADDRD(rd_addr_i), // Read/Write port D 5-bit address input
	.DIA(rd_writedata_0), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(rd_writedata_0), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(rd_writedata_0), // RAM 2-bit data write input addressed by ADDRD,
	.DID(rd_writedata_0), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we) // Write enable input
);

endmodule
