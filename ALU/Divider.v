`timescale 1ns/1ns
module Divider( clk, dataA, dataB, Signal, dataOut, reset);
input clk ;
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [3:0] Signal ;
output reg [63:0] dataOut ;
reg [5:0]	counter ;
reg [63:0] temp  ;


always@( posedge clk or reset or Signal  )
begin
        if ( reset ) begin
        	temp = 64'd0;
        	counter = 0;
        end
		else begin
			if ( Signal == 4'b0100 ) begin
				if ( counter < 32 )  begin
				
					if ( counter == 0 ) begin
						temp = temp + dataA ;
						temp = temp << 1 ;
					end
				
					temp[63:32] = temp[63:32] - dataB ;
					if( temp[63] == 0 ) begin 
						temp = temp << 1 ;
						temp[0] = 1 ;
					end
					else begin
						temp[63:32] = temp[63:32] + dataB ;
						temp = temp << 1;
					end
			
					counter = counter + 1 ;	
					if (counter == 32)
						temp[63:32] = temp[63:32] >> 1 ;
				end

			end	
			
			dataOut = temp ;
			
        end


end

endmodule
