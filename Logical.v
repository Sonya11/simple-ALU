
/*
Sonya Schuppan
Digital Logic
Spring 2018
*/

//************************AND**********************
module bitwise_and(input[3:0] x, 
						input[3:0] y, 
						output[3:0] result);
						
		assign result[3:0] = x[3:0] & y[3:0]; //<--continuous assignment

endmodule

//************************OR***********************
module bitwise_or(input[3:0] x, 
						input[3:0] y, 
						output[3:0] result);
						
		assign result[3:0] = x[3:0] | y[3:0];

endmodule

//************************XOR**********************
module bitwise_xor(input[3:0] x, 
						input[3:0] y, 
						output[3:0] result);
						
		assign result[3:0] = x[3:0] ^ y[3:0];

endmodule

//************************NOT**********************
module bitwise_not(input[7:0] x,  
						output[7:0] result);
						
		assign result[7:0] = ~x[7:0];

endmodule


//*******************Logical*Module****************
module logical(input[1:0] select,
					input[3:0] x, 
					input[3:0] y,
					output[8:0] result);

	wire[3:0] and_result, or_result, xor_result;
	wire[7:0] not_result;
	
	bitwise_and(x, y, and_result);
	bitwise_or(x, y, or_result);
	bitwise_xor(x, y, xor_result);
	bitwise_not({x, y}, not_result);
	
	mux4by9to1by9_switch LOG_MUX(select, {5'b0, and_result}, {5'b0, or_result}, 
									{5'b0, xor_result}, {1'b0, not_result}, result);

endmodule
