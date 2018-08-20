
/*
Sonya Schuppan
Digital Logic
Spring 2018
*/

//*************************EQUAL*************************
module isEqual(input[3:0] x,
					input[3:0] y,
					output reg result);
	always@(x,y)
	begin
		if(x[3:0] == y[3:0])
			result = 1;
		else
			result = 0;
	end
					
endmodule


//**********************GREATER*THAN*********************
module isGreaterThan(input[3:0] x,
							input[3:0] y,
							output reg result);
							
	always@(x,y)
	begin
		if(x[3:0] > y[3:0])
			result = 1;
		else
			result = 0;
	end
					
endmodule


//************************LESS*THAN**********************
module isLessThan(input[3:0] x,
						input[3:0] y,
						output reg result);
	always@(x,y)
	begin
		if(x[3:0] < y[3:0])
			result = 1;
		else
			result = 0;
	end
					
endmodule


//***************************MAX**************************
module max(input[3:0] x,
				input[3:0] y,
				output reg[3:0] result);
	wire isY;		
		
	assign isY = ~x[3] & ~x[2] & ~x[1] & ~x[0] & ~y[3] & ~y[2] & ~y[1] & y[0] | 
						~x[3] & ~x[2] & ~x[1] & ~y[3] & ~y[2] & y[1] | 
						~x[3] & ~x[2] & ~y[3] & y[2] | 
						~x[3] & y[3] | 
						~x[3] & ~x[2] & x[1] & ~x[0] & ~y[3] & ~y[2] & y[1] & y[0] | 
						~x[3] & x[2] & ~x[1] & ~y[3] & y[2] & y[1] | 
						~x[3] & x[2] & x[1] & ~x[0] & ~y[3] & y[2] & y[1] & y[0] | 
						x[3] & ~x[2] & ~x[1] & ~x[0] & y[3] & ~y[2] & ~y[1] & y[0] | 
						x[3] & ~x[2] & ~x[1] & y[3] & ~y[2] & y[1] | 
						x[3] & ~x[2] & y[3] & y[2] | 
						x[3] & ~x[2] & x[1] & ~x[0] & y[3] & ~y[2] & y[1] & y[0] | 
						x[3] & x[2] & ~x[1] & ~x[0] & y[3] & y[2] & ~y[1] & y[0] | 
						x[3] & x[2] & ~x[1] & y[3] & y[2] & y[1] | 
						x[3] & x[2] & x[1] & ~x[0] & y[3] & y[2] & y[1] & y[0] | 
						~x[3] & x[2] & ~x[1] & ~x[0] & ~y[3] & y[2] & ~y[1] & y[0];
	always@(isY)
	begin
		if(isY)
			result = y;
		else
			result = x;
	end
		
endmodule

//*******************Comparison*Module****************
module comparison(input[1:0] select,
						input[3:0] x, 
						input[3:0] y,
						output[8:0] result);

	wire equal_result, greater_result, less_result;
	wire[3:0] max_result;
	
	isEqual(x, y, equal_result);
	isLessThan(x, y, less_result);
	isGreaterThan(x, y, greater_result);
	max(x, y, max_result);
	
	mux4by9to1by9_switch COMP_MUX(select, {8'b0, equal_result}, {8'b0, less_result},
									{8'b0, greater_result}, {5'b0, max_result}, result);

endmodule
