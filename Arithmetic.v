
/*
Sonya Schuppan
Digital Logic
Spring 2018
*/

//*************************ADD*********************************

//Full Adder module for RCA
module full_adder(input c_in, 
						input a, 
						input b, 
						output c_out, 
						output sum);
						
	assign c_out = a & b | a & c_in | b & c_in;
	assign sum = c_in ^ a ^ b;
	
endmodule

//4-bit Ripple Carry Adder!
module ripple_carry_adder(A, B, SUM, C_OUT);
	parameter n = 4; //size of adder 
	//(you could change the value of n somewhere else and dynamiacally change the size of the adder 
	//-- this just sets the default to 4)

	input [n-1:0] A;
	input [n-1:0] B;
	output [n-1:0] SUM;
	output C_OUT;
	wire [n:0] C; //carry wires connecting the full adders
	
	assign C[0] = 1'b0; //set first carry to 0 to make first adder module a half adder
	assign C_OUT = C[n]; //C4
	
	genvar k;
	generate
		for(k = 0; k < n; k = k + 1) 
		begin:add //<-- the name of the loop is the name of the individual modules made inside the loop! (add[0].FA, add[1].FA, etc)
			full_adder FA(C[k], A[k], B[k], C[k+1], SUM[k]); //instantiate n full adder modules, output sum and final carry
		end
	endgenerate
	
endmodule

	
//*************************SUBTRACT****************************
module full_subtracter(input b_in, 
								input x, 
								input y, 
								output b_out, 
								output dif);
						
	assign b_out = ~x & b_in | ~x & y | y & b_in; 
	assign dif = b_in ^ x ^ y;
	
endmodule

//4-bit Ripple Borrow Subtracter
module ripple_borrow_sub(X, Y, DIF, B_OUT); 
	parameter m = 4; 
	
	input [m-1:0] X;
	input [m-1:0] Y;
	output [m-1:0] DIF;
	output B_OUT;
	wire [m:0] B; //borrow wires connecting the full subtractor 
	
	assign B[0] = 1'b0; 
	assign B_OUT = B[m]; 
	
	genvar k;
	generate
		for(k = 0; k < m; k = k + 1) 
		begin:subtract 
			full_subtracter FS(B[k], X[k], Y[k], B[k+1], DIF[k]); //instantiate n full subtracter modules, output differnce and final borrow
		end
	endgenerate
	
endmodule

//*************************MULT BY 2***************************

module multby2(input[7:0] x, 
					output[7:0] result, 
					output carry);

	assign carry = x[7]; //this will show that there is a decimal point :)
	assign result = x << 1;

endmodule

//*************************DIV BY 2****************************

module divby2(input[7:0] x, 
					output[7:0] result, 
					output carry);

	assign carry = x[0];
	assign result = x >> 1;

endmodule

//**********************arithmetic*module**********************

module arithmetic(input[1:0] select,
						input[3:0] x, 
						input[3:0] y,
						output[8:0] result);
	
	wire[3:0] sum, dif;
	wire[7:0] mult, div;
	wire sum_cout, dif_cout, mult_cout, div_cout;
	wire[8:0] sum_result, dif_result, mult_result, div_result;
				
	ripple_carry_adder RCA(x, y, sum, sum_cout);
	ripple_borrow_sub RBS(x, y, dif, dif_cout);
	multby2 MB2({x,y}, mult, mult_cout);
	divby2 DB2({x,y}, div, div_cout);
	
	assign sum_result = {4'b0, sum_cout, sum};
	assign dif_result = {4'b0, dif_cout, dif};
	assign mult_result = {mult_cout, mult}; //9th bit being a 1 for mult represents overflow ...but that means LEDS will still display correct #
	assign div_result = {div_cout, div};  //9th bit represents there is a 0b0.1 (aka .5) after the last 1
	
	mux4by9to1by9_switch ARITH_MUX(select, sum_result, dif_result, mult_result, div_result, result);
	
endmodule
				
					

