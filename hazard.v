module hazard( clk, rst, instr, addr_pc );
	input clk, rst;
	input [31:0] instr;
	output reg addr_pc;
	reg [6:0] total;	
	reg [6:0] count;
	// opcode
    parameter R_FORMAT = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ = 6'd4;
    parameter BNE = 6'd5;
	parameter J = 6'd2;
	parameter ori = 6'hd;
	
	// funct
	parameter jr = 6'h8;
    parameter sll = 6'h0;

	parameter mfhi = 6'h10 ;
	parameter mflo = 6'h12;
	parameter divu = 6'h1b;
	parameter nop = 32'b0;	
	always @ ( instr ) begin
		
		if ( instr[31:26] == 6'd0 && instr[5:0] == divu ) begin
				total <= 31;
				addr_pc <= 0;
			end
		else if ( instr[31:26] == 6'd0 && instr[5:0] == mfhi ) begin
				total <= 0;
				addr_pc <= 0;
		end				
		else if ( instr[31:26] == 6'd0 && instr[5:0] == mflo ) begin
				total <= 0;
				addr_pc <= 0;
		end	
		else if ( instr[31:26] == LW ) begin
				total <= 3;
				addr_pc <= 0;
		end			
		else if ( instr[31:0] == nop ) begin 
			count <= 1;
			total <= 1;
			addr_pc <= 1;
		end
		else if ( instr[31:26] == 6'd0 ) begin 
			total = 3 ;
			addr_pc <= 0;
		end
		else if ( instr[31:26] == BEQ ) begin
			total <= 2;
			addr_pc <= 0;
		end
		else if ( instr[31:26] == BNE ) begin
			total <= 2;
			addr_pc <= 0;
		end
		else if ( instr[31:26] == J ) begin
			total <= 1 ;
			addr_pc <= 1;
		end
	
	
	end
	
	always @ ( posedge clk ) begin
	    if ( rst ) begin
	        count <= 0;
	   	    total <= 0;
			addr_pc <= 1;
	    end
	    else begin		
	        count <= count + 1;
	        if ( count == total ) begin
		      count <= 0;
			  total <= 0;
			  addr_pc <=1;			  
	        end	
	    end	
	end


endmodule
