
/*
Sonya Schuppan
Digital Logic
Spring 2018
*/

module Project1_top_try2(input[9:0] SW, 
								  	input[1:0] KEY, 
									output[9:0] LEDR, 
									output[7:0] HEX0,  
									output[7:0] HEX1,
									output[7:0] HEX4,
									output[7:0] HEX5);
	
	//****************CPU*Operation*Multiplexer***********************
	
	wire[8:0] arith_result, log_result, comp_result, result;
	wire[1:0] new_choose, old_choose; //be explicit! 
	
	assign old_choose = new_choose;
	
	//calculate all results
	arithmetic ARITH(SW[9:8], SW[7:4], SW[3:0], arith_result); 
	logical LOG(SW[9:8], SW[7:4], SW[3:0], log_result);
	comparison COMP(SW[9:8], SW[7:4], SW[3:0], comp_result);
	
	//choose result to display with button multiplexer
	mux4by9to1by9_button MODE_MUX(KEY[1:0], old_choose, 8'b0, arith_result, log_result, comp_result, new_choose, result);
	
	
	//******************Mode*and*Result*Display************************
	
	wire no_overflow = 1'b0;
	
	//display state of button mux on hex display 4 and 5
	SevenSegment SEG4(no_overflow, {3'b0, new_choose[0]}, HEX4[7:0]);
	SevenSegment SEG5(no_overflow, {3'b0, new_choose[1]}, HEX5[7:0]);
	
	//dispaly result of chosen operation with LEDs (9th LED signifies overflow)
	assign LEDR[8:0] = result; 
	
	//display result of chosen operation on hex display 0 and 1, 
	//if overflow, display decimal point on HEX0 
	SevenSegment SEG0(result[8], result[3:0], HEX0[7:0]);
	SevenSegment SEG1(no_overflow, result[7:4], HEX1[7:0]);
	
endmodule
