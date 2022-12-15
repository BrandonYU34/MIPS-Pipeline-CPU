`timescale 1ns/1ns
module MUX( ALUOut, HiOut, LoOut, Shifter, Signal, dataOut );
input [31:0] ALUOut ;
input [31:0] HiOut ;
input [31:0] LoOut ;
input [31:0] Shifter ;
input [3:0] Signal ;
output [31:0] dataOut ;


reg [31:0] temp ;

parameter ADD = 4'b0010;
parameter SUB = 4'b0110;
parameter AND = 4'b0000;
parameter OR  = 4'b0001;
parameter SLT = 4'b0111;
parameter SLL = 4'b0000;
parameter DIVU = 4'b0100;
parameter MFHI = 4'b1000;
parameter MFLO = 4'b1001;

always@( ALUOut or HiOut or LoOut or Shifter or Signal )
begin

	case ( Signal )
	AND:
	begin
		temp = ALUOut ;
	end
	OR:
	begin
		temp = ALUOut ;
	end
	ADD:
	begin
		temp = ALUOut ;
	end
	SUB:
	begin
		temp = ALUOut ;
	end
	SLT:
	begin
		temp = ALUOut ;
	end

	
	MFHI:
	begin
		temp = HiOut ;
	end
	MFLO:
	begin
		temp = LoOut ;
	end
	
	SLL:
	begin
		temp = Shifter ;
	end
	default: temp = 32'b0 ;	
	
	endcase
end
assign dataOut = temp ;



endmodule
