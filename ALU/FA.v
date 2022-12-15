`timescale 1ns/1ns
module FA( cout, sum, inputA, inputB, c ) ;
	input inputA, inputB, c ;
	output cout, sum ;
	
	wire e1, e2, e3 ;
	
	assign e1 = inputA & inputB ;
	assign e2 = inputA & c ;
	assign e3 = inputB & c ;
	assign cout = e1 | e2 | e3 ;
	assign sum = inputA ^ inputB ^ c ;
	
endmodule