`timescale 1ns/1ns
module RunLastALU( out, CarryOut, Set, inputA, inputB, CarryIn, SignalIn, Less ) ;
	input inputA, inputB, CarryIn, Less ;
	input [3:0] SignalIn ;
	output out, CarryOut, Set ;

    // symbolic constants for ALU Operations
    parameter ADD = 4'b0010;
    parameter SUB = 4'b0110;
    parameter AND = 4'b0000;
    parameter OR  = 4'b0001;
    parameter SLT = 4'b0111;
    parameter SLL = 4'b0011;
	parameter DIVU= 4'b0100;
	parameter BNE = 4'b0101;
	
	wire binvert, sum ;
	//看要不要做sub
	assign binvert = ( SignalIn == BNE ) ? 1'b0 :( SignalIn == SUB ) ? 1'b0 : ( SignalIn == SLT ) ? 1'b0 : 1'b1 ;
	//如果binvert是0，就把b做exclusive_or + 1
	wire BIn ;
	assign BIn = ( binvert == 0 ) ? inputB ^ binvert + 1'b1 : inputB ;
	//做FA(可做減法或加法)
	FA  fa( .cout(CarryOut), .sum(sum), .inputA(inputA), .inputB(BIn), .c(CarryIn) ) ;
	assign Set = sum ;
	wire output0, output1, output2 ;
	assign output0 = inputA & inputB ;
	assign output1 = inputA | inputB ;
	assign output2 = sum ;
	assign out = ( SignalIn == AND ) ? output0 :
				 ( SignalIn == OR ) ? output1 :
				 ( SignalIn == SLT ) ? 1'b0 : output2 ;
endmodule
