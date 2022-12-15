`timescale 1ns/1ns
module TotalALU( clk, dataA, dataB, Signal, Output, reset, zero );
input reset ;
input clk ;
input [31:0] dataA ;
input [31:0] dataB ;
input [3:0] Signal ;
output [31:0] Output ;
output zero ;


wire [31:0] temp ;


    // symbolic constants for ALU Operations
    parameter ADD = 3'b010;
    parameter SUB = 3'b110;
    parameter AND = 3'b000;
    parameter OR  = 3'b001;
    parameter SLT = 3'b111;
    parameter SLL = 3'b011;
	parameter DIVU= 3'b100;

parameter MFHI= 6'b010000;
parameter MFLO= 6'b010010;

wire [31:0] ALUOut, HiOut, LoOut, ShifterOut ;
wire [31:0] dataOut ;
wire [63:0] DivAns ;

ALU ALU( .inputA(dataA), .inputB(dataB), .SignalIn(Signal), .out(ALUOut), .reset(reset), .zero(zero) );
Divider Divider( .clk(clk), .dataA(dataA), .dataB(dataB), .Signal(Signal), .dataOut(DivAns), .reset(reset) );
Shifter Shifter( .inputA(dataA), .inputB(dataB), .SignalIn(Signal), .out(ShifterOut), .reset(reset) );
HiLo HiLo( .clk(clk), .DivAns(DivAns), .HiOut(HiOut), .LoOut(LoOut), .reset(reset) );
MUX MUX( .ALUOut(ALUOut), .HiOut(HiOut), .LoOut(LoOut), .Shifter(ShifterOut), .Signal(Signal), .dataOut(dataOut) );


assign Output = dataOut ;


endmodule
