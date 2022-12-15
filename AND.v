module AND( result, op1, op2 ) ;
	input op1,op2 ;
	output result ;
	wire temp ;
	assign temp = op1 & op2 ;
	assign result = ( temp == 1'b1 ) ? 1'b1 : 1'b0 ;
		
endmodule
