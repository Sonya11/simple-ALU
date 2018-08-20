
/*
Sonya Schuppan
Digital Logic
Spring 2018
*/

module SevenSegment(input overflow, input[3:0] value, output reg[7:0] display);

	// overflow will only be 1 for mult and div because these are the only operations that could produce a nubmer larger than 8 bits
	//     --for division: if overflow is a 1, the actual result of the operation is <value[3:0]>.5 because only dividing by 2 :)
	//     --for multiplication: if overflow is a 1 the actual result of the operation is 256 + <value[3:0] because only multiplying by 2 :)
	
	always@(value)
	begin
		if(overflow)//add decimal pt if there is a carry to show that full represntation of number is out of bounds 
			case(value)             //.gfedcba
				4'b0000: display = ~8'b10111111;
				4'b0001: display = ~8'b10000110;
				4'b0010: display = ~8'b11011011;
				4'b0011: display = ~8'b11001111;
				4'b0100: display = ~8'b11100110;
				4'b0101: display = ~8'b11101101;
				4'b0110: display = ~8'b11111101;
				4'b0111: display = ~8'b10000111;
				4'b1000: display = ~8'b11111111;
				4'b1001: display = ~8'b11100111;
				4'b1010: display = ~8'b11110111;
				4'b1011: display = ~8'b11111100;
				4'b1100: display = ~8'b10111001;
				4'b1101: display = ~8'b11011110;
				4'b1110: display = ~8'b11111001;
				4'b1111: display = ~8'b11110001;
			endcase
		else //full represtnation of number is in bounds
			case(value)             //.gfedcba
				4'b0000: display = ~8'b00111111;
				4'b0001: display = ~8'b00000110;
				4'b0010: display = ~8'b01011011;
				4'b0011: display = ~8'b01001111;
				4'b0100: display = ~8'b01100110;
				4'b0101: display = ~8'b01101101;
				4'b0110: display = ~8'b01111101;
				4'b0111: display = ~8'b00000111;
				4'b1000: display = ~8'b01111111;
				4'b1001: display = ~8'b01100111;
				4'b1010: display = ~8'b01110111;
				4'b1011: display = ~8'b01111100;
				4'b1100: display = ~8'b00111001;
				4'b1101: display = ~8'b01011110;
				4'b1110: display = ~8'b01111001;
				4'b1111: display = ~8'b01110001;
			endcase
		
		
	end

endmodule
 

 
 
 



