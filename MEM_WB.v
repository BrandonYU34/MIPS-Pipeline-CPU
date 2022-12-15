module MEM_WB( clk, rst, MEM_WB_WB, MEM_WB_RD, MEM_WB_ALU, MEM_WB_WReg,
				WB, RD, ALU, WReg, en_reg ) ;
				
	input clk, rst, en_reg ;
	input [1:0] WB ;
	input [4:0] WReg ;
	input [31:0] RD, ALU ;
	
	output reg [1:0] MEM_WB_WB ;
	output reg [4:0] MEM_WB_WReg ;
	output reg [31:0] MEM_WB_RD, MEM_WB_ALU ;
	
	always @( posedge clk ) begin
		if( rst ) begin
			MEM_WB_WB <= 2'b0 ;
			MEM_WB_WReg <= 5'b0 ;
			MEM_WB_RD <= 32'b0 ;
			MEM_WB_ALU <= 32'b0 ;
		end
		else if( en_reg ) begin
			MEM_WB_WB <= WB ;
			MEM_WB_WReg <= WReg ;
			MEM_WB_RD <= RD ;
			MEM_WB_ALU <= ALU ;
		end
				
	end
	
endmodule