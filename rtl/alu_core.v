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
	* Execution Unit of the processor.
	* Consists of direct instantation of DSP48E1 primitive to perform data
	* processing operations.
	* DSP48E1 is pipelined at 3 stages.
	*

******************************************************************************************/
//`define DSP_LUT
`include "defines.v"

module alu_core (

	input [29:0]	a_i,
	input [3:0]	alumode_i,
	input [17:0]	b_i,
	input [47:0]	c_i,
	input 		cea2_i,
	input		ceb2_i,
	input		clk,
	input [4:0]	inmode_i,
	input [6:0]	opmode_i,
	input		rst,
	input		usemult_i,	// select mux
`ifdef EXTLOOPBACK
	input		extloopback_i,
`endif

	output [47:0]	p_o		// to ex3 and regfile
);
// Parameter, default = P3
	parameter integer p_acascreg = 2;
	parameter integer p_adreg = 0;
	parameter integer p_alumodereg = 1;
	parameter integer p_areg = 2;
	parameter integer p_bcascreg = 2;
	parameter integer p_breg = 2;
	parameter integer p_carryinreg = 1;
	parameter integer p_carryinselreg = 1;
	parameter integer p_creg = 1;
	parameter integer p_dreg = 0;
	parameter integer p_inmodereg = 1;
	parameter integer p_mreg = 1;
	parameter integer p_opmodereg = 1;
	parameter integer p_preg = 1; // option: 0, 1

	parameter p_cea1 = 1'b1;
	parameter p_ceb1 = 1'b1;
	parameter p_cec = 1'b1;
	parameter p_cealumode = 1'b1;
	parameter p_ceinmode = 1'b1;
	parameter p_ceopmode = 1'b1;
	parameter p_cem = 1'b1;
	parameter p_cep = 1'b1;

	parameter p_nalupipe = "P3";

	// Internal signals
	reg [6:0]	opmode;
	reg [3:0]	alumode;
	wire [4:0]	inmode;
	reg 		cea2, ceb2;
	wire [29:0]	a;
	wire [17:0]	b;
	wire [47:0]	c;
	reg [47:0] 	c0;

`ifdef EXTLOOPBACK
	assign a = (extloopback_i) ? $signed(p_o[42:18]) : a_i;
	assign b = (extloopback_i) ? p_o[17:0] : b_i;
	assign c = c_i;
`else
	assign a = a_i;
	assign b = b_i;
	assign c = c_i;
`endif

`ifdef DSP_LUT
	dsp_luts i_dsp_luts (
		.clk(clk),
		.rst(rst),
		.cea2(cea2),
		.ceb2(ceb2),
		.a(a_i),
		.b(b_i),
		.c(c0),
		.inmode(inmode),
		.opmode(opmode),
		.alumode(alumode),
		.p(p_o)
	);
`else
	DSP48E1 #( 
		// Parameters
		.ACASCREG 		( p_acascreg ), // ACASCRAG = AREG = ADREG = CREG
		.ADREG			( p_adreg ),
		.ALUMODEREG 		( p_alumodereg ),
		.AREG 			( p_areg ),
		.BCASCREG 		( p_bcascreg ),
		.BREG 			( p_breg ),
		.CARRYINREG 		( p_carryinreg ),
		.CARRYINSELREG 		( p_carryinselreg ),
		.CREG 			( p_creg ),
		.DREG 			( p_dreg ),
		.INMODEREG 		( p_inmodereg ), 
		.MREG 			( p_mreg ),
		.OPMODEREG 		( p_opmodereg ), 
		.PREG			( p_preg ),
		.A_INPUT 		( "DIRECT" ), 
		.B_INPUT 		( "DIRECT" ),
		.USE_DPORT 		( "FALSE" ), 			// d port and preadder not used, only a port
		.USE_MULT 		( "DYNAMIC" ),
		.USE_SIMD 		( "ONE48" ),
		.AUTORESET_PATDET ( "NO_RESET" ), 		// do not reset P register
		.MASK 			( 48'h000000000000 ), 	// every bit is compared
		.PATTERN 		( 48'h000000000000 ),
		.SEL_MASK 		( "MASK" ),
		.SEL_PATTERN 	( "C" ),			 	
		.USE_PATTERN_DETECT ( "NO_PATDET" ) 	// pattern detection disabled		
		)
		i_dsp48e1 (
		.ACOUT			(), 
		.BCOUT			(), 
		.CARRYCASCOUT		(), 
		.CARRYOUT		(), 
		.MULTSIGNOUT		(), 
		.OVERFLOW		(), 
		.P			(p_o), 
		.PATTERNBDETECT		(), 
		.PATTERNDETECT		(), 
		.PCOUT			(), 
		.UNDERFLOW		(), 
		.A			(a), 
		.ACIN			(), 
		.ALUMODE		(alumode), 
		.B			(b), 
		.BCIN			(),
		.C			(c0), 
		.CARRYCASCIN		(), 
		.CARRYIN		(1'b0), 
		.CARRYINSEL		(3'b000), 
		.CEA1			(p_cea1), 
		.CEA2			(cea2), 
		.CEAD			(1'b0), 
		.CEALUMODE		(p_cealumode), 
		.CEB1			(p_ceb1), 
		.CEB2			(ceb2), 
		.CEC			(p_cec), 
		.CECARRYIN		(1'b0), // 0 not used for now
		.CECTRL			(p_ceopmode), 
		.CED			(1'b0), // 0 not used for now
		.CEINMODE		(p_ceinmode), 
		.CEM			(p_cem), 
		.CEP			(p_cep), 
		.CLK			(clk), 
		.D				(25'h0000000), // 0 not used for now 
		.INMODE			(inmode), 
		.MULTSIGNIN		(), 
		.OPMODE			(opmode), 
		.PCIN			(),
		.RSTA			(rst), 
		.RSTALLCARRYIN		(rst), 
		.RSTALUMODE		(rst), 
		.RSTB			(rst), 
		.RSTC			(rst), 
		.RSTCTRL		(rst), 
		.RSTD			(rst), 
		.RSTINMODE		(rst), 
		.RSTM			(rst), 
		.RSTP			(rst)
	);
`endif

generate
	case(p_nalupipe)
		"P3": 
			begin
				reg [4:0] qinmode_o_reg1;

				assign inmode = (usemult_i) ? inmode_i : qinmode_o_reg1; // add an extra reg for inmode for non-mult ops 

				always@ (posedge clk)
				begin
					if (rst)
					begin
						// Enable signals
						cea2 <= 1'b0; // handled by control signal
						ceb2 <= 1'b0;
						// Control signals
						alumode <= 4'h0;
						qinmode_o_reg1 <= 5'h00;
						opmode <= 7'h00;
						// Data signal
						c0 <= 48'h000000000000;
					end
					else
					begin
						// Enable signals
						cea2 <= cea2_i; // handled by control signal
						ceb2 <= ceb2_i;
						// Control signals
						alumode <= alumode_i;
						qinmode_o_reg1 <= inmode_i;
						opmode <= opmode_i;
						// Data signal
						c0 <= c;
					end
				end
			end	
		"P2":
			begin
				assign inmode = inmode_i;

				always@ (*)
				begin
					cea2 = 1'b1;
					ceb2 = 1'b1;
					alumode = alumode_i;
					opmode = opmode_i;
					c0 = c;
				end
			end
		"P1", "P0":
			begin
				assign inmode = (usemult_i) ? {1'b0, inmode_i[3:1], 1'b0} : inmode_i;

				always@ (*)
				begin
					cea2 = 1'b0;
					ceb2 = 1'b0;
					alumode = alumode_i;
					opmode = opmode_i;
					c0 = c;
				end
			end
	endcase
endgenerate

endmodule
