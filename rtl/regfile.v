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
	* Register file of size 32 x 32. 
	* 32 x 2 (Depth x Width) x 16 (Number of RAM32Ms)
	* Built using direct instantiation of RAM32M soft-primitive. Synthesized to LUTs.
	* Inference through behavioural description would consume ~twice as much
	* resources compared to direct instantiation.
	*

******************************************************************************************/

module regfile (
	input 							clk,
	input 							regfile_we_w_i,
	input 							regfile_we_uhw_i,
	input 							sr_we_i, // TODO: remove sr_we_i
	input [`reg_addr_width-1:0] 	addr_ra_i, // register a read
	input [`reg_addr_width-1:0] 	addr_rb_i, // register b read
	input [`reg_addr_width-1:0] 	addr_rc_i, // register c read
	input [`reg_addr_width-1:0] 	addr_rd_i, // register d write
	input [`datawidth-1:0]			data_rd_i, 
	output [`datawidth-1:0]			data_ra_o, 
	output [`datawidth-1:0]			data_rb_o, 
	output [`datawidth-1:0]			data_rc_o 
);
assign we_b = 	(regfile_we_uhw_i) ? 1'b0 : regfile_we_w_i; // dun write lower 16-bit if MOVT is high
assign we_t = 	regfile_we_w_i; // upper 16-bit is always written regardless of MOVT or MOVB

// read data
wire [1:0] data_ra_0, data_ra_1, data_ra_2, data_ra_3, data_ra_4, data_ra_5, data_ra_6, data_ra_7;
wire [1:0] data_ra_8, data_ra_9, data_ra_10, data_ra_11, data_ra_12, data_ra_13, data_ra_14, data_ra_15;
wire [1:0] data_rb_0, data_rb_1, data_rb_2, data_rb_3, data_rb_4, data_rb_5, data_rb_6, data_rb_7;
wire [1:0] data_rb_8, data_rb_9, data_rb_10, data_rb_11, data_rb_12, data_rb_13, data_rb_14, data_rb_15;
wire [1:0] data_rc_0, data_rc_1, data_rc_2, data_rc_3, data_rc_4, data_rc_5, data_rc_6, data_rc_7;
wire [1:0] data_rc_8, data_rc_9, data_rc_10, data_rc_11, data_rc_12, data_rc_13, data_rc_14, data_rc_15;
// written data
wire [1:0] data_rd_0, data_rd_1, data_rd_2, data_rd_3, data_rd_4, data_rd_5, data_rd_6, data_rd_7;
wire [1:0] data_rd_8, data_rd_9, data_rd_10, data_rd_11, data_rd_12, data_rd_13, data_rd_14, data_rd_15;

assign {data_rd_15, data_rd_14, data_rd_13, data_rd_12, data_rd_11, data_rd_10, data_rd_9, data_rd_8} = (regfile_we_uhw_i) ? data_rd_i[15:0] : data_rd_i[31:16]; // write
assign {data_rd_7, data_rd_6, data_rd_5, data_rd_4, data_rd_3, data_rd_2, data_rd_1, data_rd_0} = data_rd_i[15:0]; // write bottom

assign data_ra_o = {data_ra_15, data_ra_14, data_ra_13, data_ra_12, data_ra_11, data_ra_10, data_ra_9, data_ra_8, data_ra_7, data_ra_6, data_ra_5, data_ra_4, data_ra_3, data_ra_2, data_ra_1, data_ra_0}; // read
assign data_rb_o = {data_rb_15, data_rb_14, data_rb_13, data_rb_12, data_rb_11, data_rb_10, data_rb_9, data_rb_8, data_rb_7, data_rb_6, data_rb_5, data_rb_4, data_rb_3, data_rb_2, data_rb_1, data_rb_0}; // read
assign data_rc_o = {data_rc_15, data_rc_14, data_rc_13, data_rc_12, data_rc_11, data_rc_10, data_rc_9, data_rc_8, data_rc_7, data_rc_6, data_rc_5, data_rc_4, data_rc_3, data_rc_2, data_rc_1, data_rc_0}; // read1

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_15 (
	.DOA(data_ra_15), // Read port A 2-bit output
	.DOB(data_rb_15), // Read port B 2-bit output
	.DOC(data_rc_15), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_15), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_15), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_15), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_15), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_t) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_14 (
	.DOA(data_ra_14), // Read port A 2-bit output
	.DOB(data_rb_14), // Read port B 2-bit output
	.DOC(data_rc_14), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_14), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_14), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_14), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_14), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_t) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_13 (
	.DOA(data_ra_13), // Read port A 2-bit output
	.DOB(data_rb_13), // Read port B 2-bit output
	.DOC(data_rc_13), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_13), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_13), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_13), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_13), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_t) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_12 (
	.DOA(data_ra_12), // Read port A 2-bit output
	.DOB(data_rb_12), // Read port B 2-bit output
	.DOC(data_rc_12), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_12), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_12), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_12), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_12), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_t) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_11 (
	.DOA(data_ra_11), // Read port A 2-bit output
	.DOB(data_rb_11), // Read port B 2-bit output
	.DOC(data_rc_11), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_11), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_11), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_11), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_11), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_t) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_10 (
	.DOA(data_ra_10), // Read port A 2-bit output
	.DOB(data_rb_10), // Read port B 2-bit output
	.DOC(data_rc_10), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_10), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_10), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_10), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_10), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_t) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0fea954000000000), // Initial contents of A Port
	.INIT_B(64'h0fea954000000000), // Initial contents of B Port
	.INIT_C(64'h0fea954000000000), // Initial contents of C Port
	.INIT_D(64'h0fea954000000000) // Initial contents of D Port
	) RAM32M_inst_9 (
	.DOA(data_ra_9), // Read port A 2-bit output
	.DOB(data_rb_9), // Read port B 2-bit output
	.DOC(data_rc_9), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_9), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_9), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_9), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_9), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_t) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0939393900000000), // Initial contents of A Port
	.INIT_B(64'h0939393900000000), // Initial contents of B Port
	.INIT_C(64'h0939393900000000), // Initial contents of C Port
	.INIT_D(64'h0939393900000000) // Initial contents of D Port
	) RAM32M_inst_8 (
	.DOA(data_ra_8), // Read port A 2-bit output
	.DOB(data_rb_8), // Read port B 2-bit output
	.DOC(data_rc_8), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_8), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_8), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_8), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_8), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_t) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_7 (
	.DOA(data_ra_7), // Read port A 2-bit output
	.DOB(data_rb_7), // Read port B 2-bit output
	.DOC(data_rc_7), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_7), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_7), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_7), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_7), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_b) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_6 (
	.DOA(data_ra_6), // Read port A 2-bit output
	.DOB(data_rb_6), // Read port B 2-bit output
	.DOC(data_rc_6), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_6), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_6), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_6), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_6), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_b) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_5 (
	.DOA(data_ra_5), // Read port A 2-bit output
	.DOB(data_rb_5), // Read port B 2-bit output
	.DOC(data_rc_5), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_5), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_5), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_5), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_5), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_b) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_4 (
	.DOA(data_ra_4), // Read port A 2-bit output
	.DOB(data_rb_4), // Read port B 2-bit output
	.DOC(data_rc_4), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_4), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_4), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_4), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_4), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_b) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_3 (
	.DOA(data_ra_3), // Read port A 2-bit output
	.DOB(data_rb_3), // Read port B 2-bit output
	.DOC(data_rc_3), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_3), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_3), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_3), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_3), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_b) // Write enable input
);

RAM32M #(
	.INIT_A(64'h0000000000000000), // Initial contents of A Port
	.INIT_B(64'h0000000000000000), // Initial contents of B Port
	.INIT_C(64'h0000000000000000), // Initial contents of C Port
	.INIT_D(64'h0000000000000000) // Initial contents of D Port
	) RAM32M_inst_2 (
	.DOA(data_ra_2), // Read port A 2-bit output
	.DOB(data_rb_2), // Read port B 2-bit output
	.DOC(data_rc_2), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_2), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_2), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_2), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_2), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_b) // Write enable input
);

RAM32M #(
	.INIT_A(64'h00000000ffaa5500), // Initial contents of A Port
	.INIT_B(64'h00000000ffaa5500), // Initial contents of B Port
	.INIT_C(64'h00000000ffaa5500), // Initial contents of C Port
	.INIT_D(64'h00000000ffaa5500) // Initial contents of D Port
	) RAM32M_inst_1 (
	.DOA(data_ra_1), // Read port A 2-bit output
	.DOB(data_rb_1), // Read port B 2-bit output
	.DOC(data_rc_1), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_1), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_1), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_1), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_1), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_b) // Write enable input
);

RAM32M #(
	.INIT_A(64'h00000000e4e4e4e4), // Initial contents of A Port
	.INIT_B(64'h00000000e4e4e4e4), // Initial contents of B Port
	.INIT_C(64'h00000000e4e4e4e4), // Initial contents of C Port
	.INIT_D(64'h00000000e4e4e4e4) // Initial contents of D Port
	) RAM32M_inst_0 (
	.DOA(data_ra_0), // Read port A 2-bit output
	.DOB(data_rb_0), // Read port B 2-bit output
	.DOC(data_rc_0), // Read port C 2-bit output
	.DOD(), 		 // not used -- Read/Write port D 2-bit output
	.ADDRA(addr_ra_i), // Read port A 5-bit address input
	.ADDRB(addr_rb_i), // Read port B 5-bit address input
	.ADDRC(addr_rc_i), // Read port C 5-bit address input
	.ADDRD(addr_rd_i), // Read/Write port D 5-bit address input
	.DIA(data_rd_0), // RAM 2-bit data write input addressed by ADDRD,
	.DIB(data_rd_0), // RAM 2-bit data write input addressed by ADDRD,
	.DIC(data_rd_0), // RAM 2-bit data write input addressed by ADDRD,
	.DID(data_rd_0), // RAM 2-bit data write input addressed by ADDRD,
	.WCLK(clk), // Write clock input
	.WE(we_b) // Write enable input
);

endmodule
