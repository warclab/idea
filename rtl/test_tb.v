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
	* Testbench for functional verification.	
	*
	* Testcase: Fibonacci
	*

******************************************************************************************/

/***************** Macro Definition Hierarchy Tap **********************/
// Regfile
`define reg_inst_15 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_15.mem_a 
`define reg_inst_14 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_14.mem_a 
`define reg_inst_13 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_13.mem_a 
`define reg_inst_12 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_12.mem_a 
`define reg_inst_11 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_11.mem_a 
`define reg_inst_10 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_10.mem_a 
`define reg_inst_9 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_9.mem_a 
`define reg_inst_8 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_8.mem_a 
`define reg_inst_7 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_7.mem_a 
`define reg_inst_6 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_6.mem_a 
`define reg_inst_5 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_5.mem_a 
`define reg_inst_4 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_4.mem_a 
`define reg_inst_3 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_3.mem_a 
`define reg_inst_2 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_2.mem_a 
`define reg_inst_1 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_1.mem_a 
`define reg_inst_0 test_tb.i_cpu_top.i_cpu_core.i_decode.i_regfile.RAM32M_inst_0.mem_a 
// Fetch
`define trace_pc 	test_tb.i_cpu_top.i_cpu_core.i_fetch.pc_o
`define trace_inst	test_tb.i_cpu_top.i_cpu_core.i_fetch.inst_i 

/***************** Testbench **********************/
module test_tb();

integer file;

// For debugging purposes
wire [63:0] treg_inst_15, treg_inst_14, treg_inst_13, treg_inst_12, treg_inst_11, treg_inst_10, treg_inst_9, treg_inst_8;
wire [63:0] treg_inst_7, treg_inst_6, treg_inst_5, treg_inst_4, treg_inst_3, treg_inst_2, treg_inst_1, treg_inst_0;
wire [31:0] reg_addr_0, reg_addr_1, reg_addr_2, reg_addr_3, reg_addr_4;

assign treg_inst_15 = `reg_inst_15;
assign treg_inst_14 = `reg_inst_14;
assign treg_inst_13 = `reg_inst_13;
assign treg_inst_12 = `reg_inst_12;
assign treg_inst_11 = `reg_inst_11;
assign treg_inst_10 = `reg_inst_10;
assign treg_inst_9 = `reg_inst_9;
assign treg_inst_8 = `reg_inst_8;
assign treg_inst_7 = `reg_inst_7;
assign treg_inst_6 = `reg_inst_6;
assign treg_inst_5 = `reg_inst_5;
assign treg_inst_4 = `reg_inst_4;
assign treg_inst_3 = `reg_inst_3;
assign treg_inst_2 = `reg_inst_2;
assign treg_inst_1 = `reg_inst_1;
assign treg_inst_0 = `reg_inst_0;

assign reg_addr_0 = {treg_inst_15[1:0], treg_inst_14[1:0], treg_inst_13[1:0], treg_inst_12[1:0], treg_inst_11[1:0], treg_inst_10[1:0], treg_inst_9[1:0], treg_inst_8[1:0], 
					treg_inst_7[1:0], treg_inst_6[1:0], treg_inst_5[1:0], treg_inst_4[1:0], treg_inst_3[1:0], treg_inst_2[1:0], treg_inst_1[1:0], treg_inst_0[1:0]};
assign reg_addr_1 = {treg_inst_15[3:2], treg_inst_14[3:2], treg_inst_13[3:2], treg_inst_12[3:2], treg_inst_11[3:2], treg_inst_10[3:2], treg_inst_9[3:2], treg_inst_8[3:2], 
					treg_inst_7[3:2], treg_inst_6[3:2], treg_inst_5[3:2], treg_inst_4[3:2], treg_inst_3[3:2], treg_inst_2[3:2], treg_inst_1[3:2], treg_inst_0[3:2]};
assign reg_addr_2 = {treg_inst_15[5:4], treg_inst_14[5:4], treg_inst_13[5:4], treg_inst_12[5:4], treg_inst_11[5:4], treg_inst_10[5:4], treg_inst_9[5:4], treg_inst_8[5:4], 
					treg_inst_7[5:4], treg_inst_6[5:4], treg_inst_5[5:4], treg_inst_4[5:4], treg_inst_3[5:4], treg_inst_2[5:4], treg_inst_1[5:4], treg_inst_0[5:4]};
assign reg_addr_3 = {treg_inst_15[7:6], treg_inst_14[7:6], treg_inst_13[7:6], treg_inst_12[7:6], treg_inst_11[7:6], treg_inst_10[7:6], treg_inst_9[7:6], treg_inst_8[7:6], 
					treg_inst_7[7:6], treg_inst_6[7:6], treg_inst_5[7:6], treg_inst_4[7:6], treg_inst_3[7:6], treg_inst_2[7:6], treg_inst_1[7:6], treg_inst_0[7:6]};
assign reg_addr_4 = {treg_inst_15[9:8], treg_inst_14[9:8], treg_inst_13[9:8], treg_inst_12[9:8], treg_inst_11[9:8], treg_inst_10[9:8], treg_inst_9[9:8], treg_inst_8[9:8], 
					treg_inst_7[9:8], treg_inst_6[9:8], treg_inst_5[9:8], treg_inst_4[9:8], treg_inst_3[9:8], treg_inst_2[9:8], treg_inst_1[9:8], treg_inst_0[9:8]};

  // Trace program				
  wire [8:0] tb_trace_pc;
  wire [31:0] tb_trace_inst;
  assign tb_trace_pc = `trace_pc;
  assign tb_trace_inst = `trace_inst;

  // Instruction Count Checker
  reg [31:0] inst_count;
  reg [31:0] clk_count;
  reg start_flag;

  // Inputs
  reg clk;
  reg rst;

	// Instantiate the Unit Under Test (UUT)
	cpu_top i_cpu_top (
		.clk(clk), 
		.rst(rst), 
		.dummy()
	);

	initial begin

		// Initialize inputs
		start_flag = 1'b0;
		inst_count = 32'h00000000;
		clk_count = 32'h00000000;

		// Open file for writing
		file = $fopen("fib_tb_output", "w");
		
		// Reset
		clk = 0;
		rst = 0;
		#100 rst = 1;
		#20 rst = 0;
		start_flag = 1'b1;
		
	end

	/***************** Instruction Checker/ Tracker **********************/

	/*
	* Stop simulation and report the values.
	*/
	always@ (reg_addr_4) /*register 4 stores the value of n*/
	begin
		if (~rst)
		begin
			/* When (n==50), stop the simulation */
			if (reg_addr_4 == 32'h00000032) 
			begin
				$fdisplay(file, "Testbench: Instruction count is %d", inst_count);
				$fdisplay(file, "Testbench: Clock cycle count is %d", clk_count);
				$fclose(file);
				$display("**** Simulation Done ****");
				$display("Log file: fib_tb_output");
				$display("*************************");
				start_flag <= 1'b0;

				#100 $finish;
			end
			else
			begin
				$fdisplay(file, "a: %d, b: %d, sum: %d", reg_addr_1, reg_addr_2, reg_addr_3); // compare with fib_c_output
			end
		end
	end
	
	/*
	* Increment instruction counter for every new instruction issued
	* except nops.
	*/
	always@ (posedge clk)
	begin
		if (start_flag)
		begin
			clk_count <= clk_count + 1;
			if (tb_trace_inst != 32'h00000000)
				/* Increment counter */
				inst_count <= inst_count + 1;		
		end
	end

	always #10 clk = ~clk;
      
endmodule

/***************** The C application **********************/
/*

#include <stdio.h>

int main ()
{
  int n = 50; 
  int a = 0;
  int b = 1;
  int sum;
  int i;

  // Here we call the fibonacci function 

  for ( i = 0; i < n; i++)			
  {							 
    sum = a + b;
    a = b;
    b = sum;
	// Values are printed after a and b are re-assigned.
    //printf("a: %u, b: %u, sum: %u\n", a, b, sum);
  }

  // Finally, return 0 

  return 0;
}
*/
