module IF_ID( clk, rst, PC_in, PC_out, RD_in, RD_out, jump, IF_ID_jump ) ;
	input clk, rst ;
	input [31:0] PC_in, RD_in, jump ;
	output reg [31:0] PC_out, RD_out, IF_ID_jump ;
	
	always@( posedge clk ) begin
		if( rst ) begin
			PC_out <= 32'b0 ;
			RD_out <= 32'b0 ;
			IF_ID_jump <= 32'b0;
		end
		else begin
			PC_out <= PC_in ;
			RD_out <= RD_in ;
			IF_ID_jump <= jump;
		end
		
	end
	
endmodule
