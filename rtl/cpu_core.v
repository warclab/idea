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
	* The iDEA processor. Consists of fetch, decode and execute modules of the
	* processor. 
	* Memory is connected outside of this module.
	*

******************************************************************************************/

module cpu_core (
	
	// Input 
	input							clk,
	input							rst,
	// => Fetch
	input [`datawidth-1:0] 			im_inst_i,
	// => Execute => EX4
	input [`datawidth-1:0] 			dm_dout_i,
	
	// Output
	// Fetch => IM
	output [`im_addr_width-1:0] 	pc_o,
	// Execute => DM
	output 							dm_we_o,
	output [`dm_addr_width-1:0] 	dm_addr_o,
	output [`datawidth-1:0] 		dm_din_o
);

// Decode => Execute
wire [6:0]						    id_ex_opmode;
wire [4:0] 							id_ex_inmode;
wire [3:0] 							id_ex_alumode;
wire 								id_ex_ce2;
wire [`portawidth-1:0] 				id_ex_data_a;
wire [`portbwidth-1:0] 				id_ex_data_b;
wire [`portcwidth-1:0] 				id_ex_data_c;
wire 								id_ex_usemult;
wire 								id_ex_regfile_we_w;
wire								id_ex_regfile_we_uhw;
wire [`reg_addr_width-1:0] 			id_ex_addr_rd;
wire 								id_ex_dm_we, id_ex_dm_re;
wire 								id_ex_ofsadden;
wire [31:0] 						id_ex_din_dm;
wire 								id_ex_branchen;
wire 								id_ex_sr_we;
wire [`im_addr_width-1:0] 			id_ex_branchtarget;
wire [`cond_code_width-1:0] 		id_ex_condcode;
wire [`dm_addr_width-1:0] 			id_ex_addr_base, id_ex_addr_offset;

// Execute => Decode
wire [47:0] 						ex_ifid_p;
wire 								ex_id_regfile_we_w, ex_id_regfile_we_uhw;
wire [`reg_addr_width-1:0] 			ex_id_addr_rd;
wire 								ex_id_sr_we;

// Execute => Fetch
wire [`im_addr_width-1:0] 			ex_if_branchtarget;
wire 								ex_if_branchen;
wire [`cond_code_width-1:0] 		ex_ifid_condcode;

// ******* Fetch ******
fetch i_fetch (
	
	// Input
    .clk							(clk), 
    .rst							(rst), 
    .branchen_i						(ex_if_branchen), 
    .condcode_i						(ex_ifid_condcode),
    .branchtarget_i					(ex_if_branchtarget),
    .p_i							(ex_ifid_p),
	.inst_i							(im_inst_i),
	// Output
	.pc_o 							(pc_o)

);

// ******* Decode ******
decode i_decode (

	// Input
    .clk 							(clk), 
    .rst 							(rst), 
    .inst_i 						(im_inst_i), 
    .regfile_we_w_i 				(ex_id_regfile_we_w), 
    .regfile_we_uhw_i 				(ex_id_regfile_we_uhw), 
    .addr_rd_i 						(ex_id_addr_rd), 
    .sr_we_i 						(ex_id_sr_we), 
    .condcode_i 					(ex_ifid_condcode), 
    .p_i 							(ex_ifid_p), 

	// Output
    // => Execute => Register file
	.addr_rd_o 						(id_ex_addr_rd), 
    .regfile_we_w_o 				(id_ex_regfile_we_w), 
    .regfile_we_uhw_o 				(id_ex_regfile_we_uhw), 
	
	// => Data Memory
    .dm_we_o 						(id_ex_dm_we), 
    .dm_re_o 						(id_ex_dm_re), 
	
	// => Offset Adder
    .ofsadden_o 					(id_ex_ofsadden), 
	.din_dm_o 						(id_ex_din_dm),
	.base_addr_o 					(id_ex_addr_base),
	.offset_addr_o 					(id_ex_addr_offset),
	
	// => Execute => Branch
    .branchen_o 					(id_ex_branchen), 
    .condcode_o 					(id_ex_condcode), 
    .branchtarget_o 				(id_ex_branchtarget), 
	

	// => Execute => Status Register
    .sr_we_o 						(id_ex_sr_we), 

	// => ALU
    .inmode_o 						(id_ex_inmode), 
    .alumode_o 						(id_ex_alumode), 
    .opmode_o 						(id_ex_opmode), 
    .ce2_o 							(id_ex_ce2), 
	.usemult_o 						(id_ex_usemult),
    .data_a_o 						(id_ex_data_a), 
    .data_b_o 						(id_ex_data_b), 
    .data_c_o 						(id_ex_data_c)

);


// ****** Execute ******
// DSP ALU
execute i_execute (

	// Input
    .clk 							(clk), 
    .rst 							(rst), 
    .regfile_we_w_i 				(id_ex_regfile_we_w), 
    .regfile_we_uhw_i 				(id_ex_regfile_we_uhw), 
    .dm_we_i 						(id_ex_dm_we), 
    .dm_re_i 						(id_ex_dm_re), 
    .ofsadden_i 					(id_ex_ofsadden), 
    .addr_base_i 					(id_ex_addr_base), 
    .addr_offset_i 					(id_ex_addr_offset), 
    .din_dm_i 						(id_ex_din_dm), // from regfile data_rc 
    .branchen_i 					(id_ex_branchen), 
    .condcode_i 					(id_ex_condcode), 
    .branchtrgt_i 					(id_ex_branchtarget), 
    .sr_we_i 						(id_ex_sr_we), 
	// => Execute => EX4
	.dm_regfile_data_i 				(dm_dout_i),
    .alumode_i 						(id_ex_alumode), 
    .inmode_i 						(id_ex_inmode), 
    .opmode_i 						(id_ex_opmode), 
    .ce2_i 							(id_ex_ce2), 
    .usemult_i 						(id_ex_usemult), 
    .data_a_i 						(id_ex_data_a), 
    .data_b_i 						(id_ex_data_b), 
    .data_c_i 						(id_ex_data_c), 
    .addr_rd_i 						(id_ex_addr_rd), 

	// Output
    .p_o 							(ex_ifid_p), 
    .regfile_we_w_o 				(ex_id_regfile_we_w), 
    .regfile_we_uhw_o 				(ex_id_regfile_we_uhw), 
    .regfile_addr_o 				(ex_id_addr_rd), 

	// => DM
	.dm_we_o 						(dm_we_o),
	.ofs_dm_addr_o 					(dm_addr_o),
	.ofs_dm_data_o 					(dm_din_o),
    .branchen_o 					(ex_if_branchen), 
    .condcode_o 					(ex_ifid_condcode), 
    .branchtrgt_o 					(ex_if_branchtarget), 
    .sr_we_o 						(ex_id_sr_we)

);

endmodule
