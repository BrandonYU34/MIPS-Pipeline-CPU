module EX_MEM( clk, rst, EX_MEM_WB, EX_MEM_M, EX_MEM_ALU, EX_MEM_ADD,
				EX_MEM_RD2, EX_MEM_WReg, EX_MEM_Zero, WB, M, ADD, 
				ALU, RD2, zero, WReg, en_reg ) ;
				
	input clk, rst, zero, en_reg ; 
	input [1:0] WB ;
	input [2:0] M ;
	input [31:0] ADD, ALU, RD2 ;
	input [4:0] WReg ;
	
	output reg EX_MEM_Zero ;
	output reg [1:0] EX_MEM_WB ;
	output reg [2:0] EX_MEM_M ;
	output reg [31:0] EX_MEM_ADD, EX_MEM_ALU, EX_MEM_RD2 ;
	output reg [4:0] EX_MEM_WReg ;
	
	always @( posedge clk ) begin 
		if( rst ) begin
			EX_MEM_Zero <= 1'b0 ;
			EX_MEM_WB <= 2'b0 ;
			EX_MEM_M <= 3'b0 ;
			EX_MEM_ADD <= 32'b0 ;
			EX_MEM_ALU <= 32'b0 ;
			EX_MEM_WReg <= 1'b0 ;
			EX_MEM_RD2 <= 1'b0 ;
		end
		else if( en_reg ) begin
			EX_MEM_Zero <= zero ;
			EX_MEM_WB <= WB ;
			EX_MEM_M <= M ;
			EX_MEM_ADD <= ADD ;
			EX_MEM_ALU <= ALU ;
			EX_MEM_WReg <= WReg ;
			EX_MEM_RD2 <= RD2 ;
		end
		
	end
	
endmodule