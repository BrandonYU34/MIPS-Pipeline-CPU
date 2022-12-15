module Mux_2to1( input1, input0, sel, cout ) ;
	output cout ;
	input input1, input0, sel ;
	
	assign cout = sel ? input1 : input0 ;
	
endmodule