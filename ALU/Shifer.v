`timescale 1ns/1ns
module Shifter( out, inputA, inputB, SignalIn, reset ) ;
	input [3:0] SignalIn ;
	input [31:0] inputA, inputB ;
	output [31:0] out ;
	input reset ;
	
	wire [31:0] temp0, temp1, temp2, temp3, temp4, temp5 ;
    parameter ADD = 4'b0010;
    parameter SUB = 4'b0110;
    parameter AND = 4'b0000;
    parameter OR  = 4'b0001;
    parameter SLT = 4'b0111;
    parameter SLL = 4'b0011;
	parameter DIVU= 4'b0100;

	assign temp0 = ( ( SignalIn == SLL ) && inputB[0] == 1 ) ? { inputA[30:0], 1'b0 } : inputA ;
	assign temp1 = ( ( SignalIn == SLL ) && inputB[1] == 1 ) ? { temp0[29:0], 2'b0 } : temp0 ;
	assign temp2 = ( ( SignalIn == SLL ) && inputB[2] == 1 ) ? { temp1[27:0], 4'b0 } : temp1;
	assign temp3 = ( ( SignalIn == SLL ) && inputB[3] == 1 ) ? { temp2[23:0], 8'b0 } : temp2 ;
	assign temp4 = ( ( SignalIn == SLL ) && inputB[4] == 1 ) ? { temp3[15:0], 16'b0 } : temp3 ;

	assign out = ( reset == 1 ) ? 32'b0 : ( SignalIn == SLL ) ? temp4 : 32'b1 ;

endmodule
