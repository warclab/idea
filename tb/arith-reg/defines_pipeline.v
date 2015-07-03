
`ifdef IF1_EX1_T4 
	parameter ID_WB = 2;
	parameter IF_WB = 3;
	parameter ID_EX = 1;
	parameter IF_EX = 2;
	parameter EX1 = 0;
`endif

`ifdef IF2_EX1_T5 
	parameter ID_WB = 2;
	parameter IF_WB = 4;
	parameter ID_EX = 1;
	parameter IF_EX = 3;
	parameter EX1 = 0;
`endif

`ifdef IF3_EX1_T6 
	parameter ID_WB = 2;
	parameter IF_WB = 6;
	parameter ID_EX = 1;
	parameter IF_EX = 3;
	parameter EX1 = 0;
`endif
//***********************

`ifdef IF1_EX2_T5 
	parameter ID_WB = 3;
	parameter IF_WB = 4;
	parameter ID_EX = 1;
	parameter IF_EX = 2;
	parameter TOTAL_PIPELINE = 5;
	parameter IF_PIPELINE = 1;
	parameter EXE_PIPELINE = 2;
	parameter EX1 = 0;
`endif

`ifdef IF2_EX2_T6 
	parameter ID_WB = 3;
	parameter IF_WB = 5;
	parameter ID_EX = 1;
	parameter IF_EX = 3;
	parameter TOTAL_PIPELINE = 6;
	parameter IF_PIPELINE = 2;
	parameter EXE_PIPELINE = 2;
	parameter EX1 = 0;
`endif

`ifdef IF3_EX2_T7 
	parameter ID_WB = 3;
	parameter IF_WB = 6;
	parameter ID_EX = 1;
	parameter IF_EX = 4;
	parameter TOTAL_PIPELINE = 7;
	parameter IF_PIPELINE = 3;
	parameter EXE_PIPELINE = 2;
	parameter EX1 = 0;
`endif

`ifdef IF1_EX3_T6 
	parameter ID_WB = 4;
	parameter IF_WB = 5;
	parameter ID_EX = 1;
	parameter IF_EX = 2;
	parameter TOTAL_PIPELINE = 6;
	parameter IF_PIPELINE = 1;
	parameter EXE_PIPELINE = 3;
	parameter EX1 = 0;
`endif

`ifdef IF2_EX3_T7 
	parameter ID_WB = 4;
	parameter IF_WB = 6;
	parameter ID_EX = 1;
	parameter IF_EX = 3;
	parameter TOTAL_PIPELINE = 7;
	parameter IF_PIPELINE = 2;
	parameter EXE_PIPELINE = 3;
	parameter EX1 = 0;
`endif

`ifdef IF3_EX3_T8  
	parameter ID_WB = 4;
	parameter IF_WB = 7;
	parameter ID_EX = 1;
	parameter IF_EX = 4;
	parameter TOTAL_PIPELINE = 8;
	parameter IF_PIPELINE = 3;
	parameter EXE_PIPELINE = 3;
	parameter EX1 = 0;
`endif

`ifdef IF1_EX4_T7 
	parameter ID_WB = 5;
	parameter IF_WB = 6;
	parameter ID_EX = 1;
	parameter IF_EX = 2;
	parameter TOTAL_PIPELINE = 7;
	parameter IF_PIPELINE = 1;
	parameter EXE_PIPELINE = 4;
	parameter EX1 = 1;
`endif

`ifdef IF2_EX4_T8 
	parameter ID_WB = 5;
	parameter IF_WB = 7;
	parameter ID_EX = 1;
	parameter IF_EX = 3;
	parameter TOTAL_PIPELINE = 8;
	parameter IF_PIPELINE = 2;
	parameter EXE_PIPELINE = 4;
	parameter EX1 = 1;
`endif

`ifdef IF3_EX4_T9 
	parameter ID_WB = 5; // ex_pipeline
	parameter IF_WB = 8; // total_pipeline
	parameter ID_EX = 1; // total_pipeline - (if_pipeline + 1)
	parameter IF_EX = 4;
	parameter TOTAL_PIPELINE = 9;
	parameter IF_PIPELINE = 3;
	parameter EXE_PIPELINE = 4;
	parameter EX1 = 1;
`endif

