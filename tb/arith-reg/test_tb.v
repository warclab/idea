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
`include "defines.v"
`include "defines_tb.v"
`include "defines_pipeline.v"

//`define IF1_EX1_T4 // *** This configuration is not possible since data memory is synchro
//`define IF2_EX1_T5 // *** Reserved for future work
//`define IF3_EX1_T6

//`define IF1_EX2_T5
//`define IF2_EX2_T6
//`define IF3_EX2_T7

//`define IF1_EX3_T6
//`define IF2_EX3_T7
//`define IF3_EX3_T8

//`define IF1_EX4_T7
//`define IF2_EX4_T8
`define IF3_EX4_T9

module test_tb();

// For debugging purposes
wire [31:0] reg_addr_0, reg_addr_1, reg_addr_2, reg_addr_3, reg_addr_4, reg_addr_5, reg_addr_6, reg_addr_7, reg_addr_8, reg_addr_9;
wire [31:0] reg_addr_10, reg_addr_11, reg_addr_12, reg_addr_13, reg_addr_14, reg_addr_15, reg_addr_16, reg_addr_17, reg_addr_18, reg_addr_19;
wire [31:0] reg_addr_20, reg_addr_21, reg_addr_22, reg_addr_23, reg_addr_24, reg_addr_25, reg_addr_26, reg_addr_27, reg_addr_28, reg_addr_29;
wire [31:0] reg_addr_30, reg_addr_31;
wire [31:0] rd_writedata;

assign reg_addr_0 = `REG_ADDR_0;
assign reg_addr_1 = `REG_ADDR_1;
assign reg_addr_2 = `REG_ADDR_2;
assign reg_addr_3 = `REG_ADDR_3;
assign reg_addr_4 = `REG_ADDR_4;
assign reg_addr_5 = `REG_ADDR_5;
assign reg_addr_6 = `REG_ADDR_6;
assign reg_addr_7 = `REG_ADDR_7;
assign reg_addr_8 = `REG_ADDR_8;
assign reg_addr_9 = `REG_ADDR_9;
assign reg_addr_10 = `REG_ADDR_10;
assign reg_addr_11 = `REG_ADDR_11;
assign reg_addr_12 = `REG_ADDR_12;
assign reg_addr_13 = `REG_ADDR_13;
assign reg_addr_14 = `REG_ADDR_14;
assign reg_addr_15 = `REG_ADDR_15;
assign reg_addr_16 = `REG_ADDR_16;
assign reg_addr_17 = `REG_ADDR_17;
assign reg_addr_18 = `REG_ADDR_18;
assign reg_addr_19 = `REG_ADDR_19;
assign reg_addr_20 = `REG_ADDR_20;
assign reg_addr_21 = `REG_ADDR_21;
assign reg_addr_22 = `REG_ADDR_22;
assign reg_addr_23 = `REG_ADDR_23;
assign reg_addr_24 = `REG_ADDR_24;
assign reg_addr_25 = `REG_ADDR_25;
assign reg_addr_26 = `REG_ADDR_26;
assign reg_addr_27 = `REG_ADDR_27;
assign reg_addr_28 = `REG_ADDR_28;
assign reg_addr_29 = `REG_ADDR_29;
assign reg_addr_30 = `REG_ADDR_30;
assign reg_addr_31 = `REG_ADDR_31;
assign rd_writedata = `TRACE_RD_WRITEDATA;

// Trace program				

// Inputs
reg clk;
reg rst;

// TB Checking
integer error;
reg tb_finish;

// Output file
integer ofile;

// Hardcoded Expected Output Values
integer i, j;
reg [63:0] output0 [0:9];
reg [63:0] simulated0 [0:9];

// Internal signals

// Hierarchy tap

// Golden values: hardcoded so that they can be compared with simulated results.
// If a new instructions are to be added -- add to the end of the inst_mem and also output0.
// Change the size of output0.
initial
begin
	output0[0] = {32'd31, 32'h00000003};//1 add $31, $1, $2 
	output0[1] = {32'd30, 32'h00000007};//2 addu $30, $3, $4
	output0[2] = {32'd29, 32'h00000004};//3 and $29, $5, $6
	output0[3] = {32'd28, 32'hfffffff0};//4 nor $28, $7, $8
	output0[4] = {32'd27, 32'h0000000b};//5 or $27, $9, $10
	output0[5] = {32'd26, 32'h00000001};//6 slt $26, $11, $12
	output0[6] = {32'd25, 32'h00000000};//7 sltu $25, $14, $13
	output0[7] = {32'd24, 32'hffffffff};//8 sub $24, $15, $16
	output0[8] = {32'd23, 32'hffffffff};//9 subu $23, $17, $18
	output0[9] = {32'd22, 32'h00000007};//10 xor $22, $19, $20
end

// Instantiate the Unit Under Test (UUT)
cpu_top i_cpu_top (
	.clk(clk), 
	.rst(rst), 
	.dummy()
);

initial 
begin
	// Open file for writing
	ofile = $fopen("simulated.txt", "w"); // Kinda redundant
	i = 0;

	// Reset
	clk = 0;
	rst = 0;
	#100 rst = 1;
	#20 rst = 0;
	// Testbench
	error = 0;
	tb_finish = 1'b0;

	#1000;
	tb_finish = 1'b1;
	#100;
	$finish;
end

always #10 clk = ~clk;

// Record the addr and data every time there is a register write.
// Simulated values: register addr and register write data is stored in simulated0 ram.
always@ (posedge clk)
begin
	if (`TRACE_REGFILE_WE && `TRACE_RD_ADDR != 32'h00000000)
	begin
		$display("PC: Rd[%d] = %h", `TRACE_RD_ADDR, rd_writedata);
		$fwrite(ofile, "%d %h\n", `TRACE_RD_ADDR, rd_writedata);
		simulated0[i] <= {`TRACE_RD_ADDR, rd_writedata};
		i = i + 1;
	end
end

// Compare the simulated results in simulated0 ram and output0 ram.
always@ (tb_finish)
begin
	if (tb_finish)
	begin
		$display ("Checking the results simulated against golden hardcoded.");
		
		for ( j = 0; j <= 9; j = j + 1)
		begin
			if (simulated0[j] !== output0[j])
			begin
				$display("Error @ Rd[%d] != %h", simulated0[j][63:32], output0[j][31:0]);
				error = error + 1;
			end
		end
		
		if (error == 0)
		begin
			$display ("Simulation Passes");
		end
		else
		begin
			$display ("Simulation Fails");
			$display ("Number of errors: %d", error);
		end
	end
end

endmodule

