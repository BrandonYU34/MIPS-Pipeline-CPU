module sign_extend( immed, ext_immed_out ) ;
	input [15:0] immed ;
	output [31:0] ext_immed_out ;
	
	assign ext_immed_out = { 16'b0, immed } ;
	
endmodule
