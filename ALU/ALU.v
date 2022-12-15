
module ALU( out, inputA, inputB, SignalIn, reset, zero ) ;
	input [31:0] inputA, inputB ;
	input reset ;
	input [3:0] SignalIn ;
	output [31:0] out ;
	output zero ;
	
	wire [31:0] carry, temp ;
	wire Set ;
	

    // symbolic constants for ALU Operations
    parameter ADD = 4'b0010;
    parameter SUB = 4'b0110;
    parameter AND = 4'b0000;
    parameter OR  = 4'b0001;
    parameter SLT = 4'b0111;
    parameter SLL = 4'b0011;
	parameter DIVU= 4'b0100;
	parameter BNE = 4'b0101;
	wire Control ;
	assign Control = ( SignalIn == BNE ) ? 1'b1 : ( SignalIn == SUB ) ? 1'b1 : ( SignalIn == SLT ) ? 1'b1 : 1'b0 ;

	RunALU run0( .out(temp[0]), .CarryOut(carry[0]), .inputA(inputA[0]), .inputB(inputB[0]), .CarryIn(Control), .SignalIn(SignalIn), .Less(Set) ) ;
	RunALU run1( .out(temp[1]), .CarryOut(carry[1]), .inputA(inputA[1]), .inputB(inputB[1]), .CarryIn(carry[0]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run2( .out(temp[2]), .CarryOut(carry[2]), .inputA(inputA[2]), .inputB(inputB[2]), .CarryIn(carry[1]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run3( .out(temp[3]), .CarryOut(carry[3]), .inputA(inputA[3]), .inputB(inputB[3]), .CarryIn(carry[2]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run4( .out(temp[4]), .CarryOut(carry[4]), .inputA(inputA[4]), .inputB(inputB[4]), .CarryIn(carry[3]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run5( .out(temp[5]), .CarryOut(carry[5]), .inputA(inputA[5]), .inputB(inputB[5]), .CarryIn(carry[4]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run6( .out(temp[6]), .CarryOut(carry[6]), .inputA(inputA[6]), .inputB(inputB[6]), .CarryIn(carry[5]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run7( .out(temp[7]), .CarryOut(carry[7]), .inputA(inputA[7]), .inputB(inputB[7]), .CarryIn(carry[6]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run8( .out(temp[8]), .CarryOut(carry[8]), .inputA(inputA[8]), .inputB(inputB[8]), .CarryIn(carry[7]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run9( .out(temp[9]), .CarryOut(carry[9]), .inputA(inputA[9]), .inputB(inputB[9]), .CarryIn(carry[8]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run10( .out(temp[10]), .CarryOut(carry[10]), .inputA(inputA[10]), .inputB(inputB[10]), .CarryIn(carry[9]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run11( .out(temp[11]), .CarryOut(carry[11]), .inputA(inputA[11]), .inputB(inputB[11]), .CarryIn(carry[10]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run12( .out(temp[12]), .CarryOut(carry[12]), .inputA(inputA[12]), .inputB(inputB[12]), .CarryIn(carry[11]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run13( .out(temp[13]), .CarryOut(carry[13]), .inputA(inputA[13]), .inputB(inputB[13]), .CarryIn(carry[12]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run14( .out(temp[14]), .CarryOut(carry[14]), .inputA(inputA[14]), .inputB(inputB[14]), .CarryIn(carry[13]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run15( .out(temp[15]), .CarryOut(carry[15]), .inputA(inputA[15]), .inputB(inputB[15]), .CarryIn(carry[14]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run16( .out(temp[16]), .CarryOut(carry[16]), .inputA(inputA[16]), .inputB(inputB[16]), .CarryIn(carry[15]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run17( .out(temp[17]), .CarryOut(carry[17]), .inputA(inputA[17]), .inputB(inputB[17]), .CarryIn(carry[16]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run18( .out(temp[18]), .CarryOut(carry[18]), .inputA(inputA[18]), .inputB(inputB[18]), .CarryIn(carry[17]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run19( .out(temp[19]), .CarryOut(carry[19]), .inputA(inputA[19]), .inputB(inputB[19]), .CarryIn(carry[18]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run20( .out(temp[20]), .CarryOut(carry[20]), .inputA(inputA[20]), .inputB(inputB[20]), .CarryIn(carry[19]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run21( .out(temp[21]), .CarryOut(carry[21]), .inputA(inputA[21]), .inputB(inputB[21]), .CarryIn(carry[20]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run22( .out(temp[22]), .CarryOut(carry[22]), .inputA(inputA[22]), .inputB(inputB[22]), .CarryIn(carry[21]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run23( .out(temp[23]), .CarryOut(carry[23]), .inputA(inputA[23]), .inputB(inputB[23]), .CarryIn(carry[22]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run24( .out(temp[24]), .CarryOut(carry[24]), .inputA(inputA[24]), .inputB(inputB[24]), .CarryIn(carry[23]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run25( .out(temp[25]), .CarryOut(carry[25]), .inputA(inputA[25]), .inputB(inputB[25]), .CarryIn(carry[24]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run26( .out(temp[26]), .CarryOut(carry[26]), .inputA(inputA[26]), .inputB(inputB[26]), .CarryIn(carry[25]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run27( .out(temp[27]), .CarryOut(carry[27]), .inputA(inputA[27]), .inputB(inputB[27]), .CarryIn(carry[26]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run28( .out(temp[28]), .CarryOut(carry[28]), .inputA(inputA[28]), .inputB(inputB[28]), .CarryIn(carry[27]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run29( .out(temp[29]), .CarryOut(carry[29]), .inputA(inputA[29]), .inputB(inputB[29]), .CarryIn(carry[28]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	RunALU run30( .out(temp[30]), .CarryOut(carry[30]), .inputA(inputA[30]), .inputB(inputB[30]), .CarryIn(carry[29]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	
	RunLastALU runlast( .out(temp[31]), .CarryOut(carry[31]), .inputA(inputA[31]), .Set(Set), .inputB(inputB[31]), .CarryIn(carry[30]), .SignalIn(SignalIn), .Less(1'b0) ) ;
	
	wire [31:0] temp2 ;
	assign temp2 = ( SignalIn == SLT ) ? ( ( Set == 1 ) ? 32'd1 : 32'd0 ) : temp ; 
	assign out = ( reset == 1 ) ? 32'b0 : temp2 ;
	assign zero = ( SignalIn == BNE ) ? ( ( temp2 == 32'd0 ) ? 1'b0 : 1'b1 ) : ( ( temp2 == 32'd0 ) ? 1'b1 : 1'b0 ) ; 
endmodule
