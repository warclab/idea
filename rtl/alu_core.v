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

module alu_core (

	input [29:0]	a_i,
	input [3:0]		alumode_i,
	input [17:0]	b_i,
	input [47:0]	c_i,
	input 			cea2_i,
	input			ceb2_i,
	input			clk,
	input [4:0]		inmode_i,
	input [6:0]		opmode_i,
	input			rst,
	input			usemult_i,	// select mux

	output [47:0]	p_o		// to ex3 and regfile
);

// Internal signals
reg [6:0]	qopmode_o_reg1;
reg [3:0]	qalumode_o_reg1;
reg [4:0]	qinmode_o_reg1;
wire [4:0]	qinmode_o_mux;
reg 		qcea2_o_reg1, qceb2_o_reg1;
reg [47:0] 	qc0_o_reg1;



	DSP48E1 #( 
		// Parameters
		.ACASCREG 		( 2 ), // ACASCRAG = AREG = ADREG = CREG
		.ADREG			( 0 ),
		.ALUMODEREG 	( 1 ),
		.AREG 			( 2 ),
		.BCASCREG 		( 2 ),
		.BREG 			( 2 ),
		.CARRYINREG 	( 1 ),
		.CARRYINSELREG 	( 1 ),
		.CREG 			( 1 ),
		.DREG 			( 0 ),
		.INMODEREG 		( 1 ), 
		.MREG 			( 1 ),
		.OPMODEREG 		( 1 ), 
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
		.ACOUT			(/*cascade*/), 
		.BCOUT			(/*cascade*/), 
		.CARRYCASCOUT	(/*cascade*/), 
		.CARRYOUT		(/*carryout*/), 
		.MULTSIGNOUT	(/*cascade*/), 
		.OVERFLOW		(/*overflow_o*/), 
		.P				(p_o), 
		.PATTERNBDETECT	(), 
		.PATTERNDETECT	(), 
		.PCOUT			(/*cascade*/), 
		.UNDERFLOW		(), 
		.A				(a_i), 
		.ACIN			(/*cascade*/), 
		.ALUMODE		(qalumode_o_reg1), 
		.B				(b_i), 
		.BCIN			(/*cascade*/),
		.C				(qc0_o_reg1), 
		.CARRYCASCIN	(/*cascade*/), 
		.CARRYIN		(1'b0), 
		.CARRYINSEL		(3'b000), 
		.CEA1			(1'b1), 
		.CEA2			(qcea2_o_reg1), 
		.CEAD			(1'b0), 
		.CEALUMODE		(1'b1), 
		.CEB1			(1'b1), 
		.CEB2			(qceb2_o_reg1), 
		.CEC			(1'b1), 
		.CECARRYIN		(1'b1), 
		.CECTRL			(1'b1), 
		.CED			(1'b0), 
		.CEINMODE		(1'b1), 
		.CEM			(1'b1), 
		.CEP			(1'b1), 
		.CLK			(clk), 
		.D				(25'h0000000), 
		.INMODE			(qinmode_o_mux), 
		.MULTSIGNIN		(/*cascade*/), 
		.OPMODE			(qopmode_o_reg1), 
		.PCIN			(/*cascade*/),
		.RSTA			(rst), 
		.RSTALLCARRYIN	(rst), 
		.RSTALUMODE		(rst), 
		.RSTB			(rst), 
		.RSTC			(rst), 
		.RSTCTRL		(rst), 
		.RSTD			(rst), 
		.RSTINMODE		(rst), 
		.RSTM			(rst), 
		.RSTP			(rst)
	);

// extra c0 register in the fabric
// Control signal for C0REG (Capital C Zero)
// FF
always@(posedge clk)
begin
	if (rst)
	begin
		qc0_o_reg1 <= 48'h000000000000;
		qinmode_o_reg1 <= 5'h00;

	end
	else
	begin
		qc0_o_reg1 <= c_i;
		qinmode_o_reg1 <= inmode_i;
	end
end

// Mux
assign qinmode_o_mux = (~usemult_i) ? qinmode_o_reg1 : inmode_i; // add an extra reg for inmode for non-mult ops 

// ********* Input: Control Signals ********
// CEA2, CEB2, ALUMODE and OPMODE to hold for 1 clk cycle 
// in order to reach the second stage of the pipeline
always@(posedge clk)
begin
	if (rst)
	begin
		qcea2_o_reg1 <= 1'b0;
		qceb2_o_reg1 <= 1'b0;
		qalumode_o_reg1 <= 4'h0;
		qopmode_o_reg1 <= 7'b0000000;
	end		
	else
	begin
		qcea2_o_reg1 <= cea2_i;
		qceb2_o_reg1 <= ceb2_i;
		qalumode_o_reg1 <= alumode_i;
		qopmode_o_reg1 <= opmode_i;
	end
end

endmodule
