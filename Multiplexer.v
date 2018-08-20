
/*
Sonya Schuppan
Digital Logic
Spring 2018
*/

//*********************switch*mux************************

module mux4by9to1by9_switch (choose, 
										result0, 
										result1, 
										result2, 
										result3, 
										result_out);
				
	parameter n = 9; // default size in bits of input and output
	
	input[1:0] choose; 
	input [n-1:0] result0, result1, result2, result3;
	output reg[n-1:0] result_out;
	
	always@(choose)
	begin
		case(choose)
			2'b00: result_out = result0;
			2'b01: result_out = result1;
			2'b10: result_out = result2;
			2'b11: result_out = result3;
		endcase
	end
	
endmodule

//*********************button*mux*************************

module mux4by9to1by9_button(input[1:0] button, 
									input[1:0] old_choose, 
									input[8:0] result0, 
									input[8:0] result1, 
									input[8:0] result2, 
									input[8:0] result3,
									output reg[1:0] new_choose,
									output reg[8:0] result_out);																	
									
	always@(negedge button[0])
	begin
		new_choose[0] <= ~old_choose[0]; //invert previous state of button choice 
	end
	
	always@(negedge button[1])
	begin
		new_choose[1] <= ~old_choose[1]; //button[1]
	end	
	
	always@(new_choose)
	begin	
		case(new_choose)
			2'b00 : result_out = result0;
			2'b01 : result_out = result1;
			2'b10 : result_out = result2;
			2'b11 : result_out = result3;
		endcase
	end
		
endmodule
