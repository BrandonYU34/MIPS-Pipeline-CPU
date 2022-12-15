module ID_EX( clk, rst, ID_EX_WB, ID_EX_M, ID_EX_EX, ID_EX_RD1,
			ID_EX_RD2, ID_EX_rt, ID_EX_rd, ID_EX_PC, ID_EX_extend,
			Control_signal, RD1, RD2, rt, rd, PC, extend, en_reg ) ;
			
	input clk, rst, en_reg ;
	input [31:0] PC, RD1, RD2, extend ;
	input [4:0] rd, rt ;
	input [8:0] Control_signal ;
	
	output reg [31:0] ID_EX_PC, ID_EX_extend, ID_EX_RD1, ID_EX_RD2 ;
	output reg [4:0] ID_EX_rt, ID_EX_rd ;
	output reg [1:0] ID_EX_WB ;
	output reg [2:0] ID_EX_M ;
	output reg [3:0] ID_EX_EX ;
	
	always @ ( posedge clk ) begin
		if( rst ) begin
			ID_EX_PC <= 32'b0 ;
			ID_EX_extend <= 32'b0 ;
			ID_EX_RD1 <= 5'b0 ;
			ID_EX_RD2 <= 5'b0 ;
			ID_EX_rt <= 5'b0 ;
			ID_EX_rd <= 5'b0 ;
			ID_EX_WB <= 2'b0 ;
			ID_EX_M <= 3'b0 ;
			ID_EX_EX <= 4'b0 ;
		end
		else if( en_reg ) begin
			ID_EX_PC <= PC ;
			ID_EX_extend <= extend ;
			ID_EX_RD1 <= RD1 ;
			ID_EX_RD2 <= RD2 ;
			ID_EX_rt <= rt ;
			ID_EX_rd <= rd;
			
			ID_EX_WB <= Control_signal[1:0] ;
			ID_EX_M <= Control_signal[4:2] ;
			ID_EX_EX <= Control_signal[8:5] ;

			
		end
		
	end
	
endmodule
