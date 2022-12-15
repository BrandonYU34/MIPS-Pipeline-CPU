module control_single( opcode, RegDst, ALUSrc, MemtoReg, RegWrite, 
					   MemRead, MemWrite, Branch, Jump, ALUOp, funct );
    input[5:0] opcode, funct;
    output RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite , MemRead, Branch, Jump;
    output[1:0] ALUOp;
    reg RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite , MemRead, Branch, Jump;
    reg[1:0] ALUOp;

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
	parameter nop = 6'h0;
	parameter mfhi = 6'h10 ;
	parameter mflo = 6'h12;
	parameter divu = 6'd27;

    always @( opcode or funct ) begin
        case ( opcode )
          R_FORMAT : 
          begin	
			case(funct)
				//jr: $display( "%d, J\n" ); //有jr要改
				
				sll: begin
					RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b0; 
					RegWrite = 1'b1; MemRead = 1'b0; ALUOp = 2'b10; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0 ;
				end
				
				divu: begin
					RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; 
					RegWrite = 1'b0; MemRead = 1'b0; ALUOp = 2'b10; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0 ;
				end
				
				nop: begin
					RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; 
					RegWrite = 1'bx; MemRead = 1'bx; ALUOp = 2'b10; 
					MemWrite = 1'bx; Branch = 1'b0; Jump = 1'b0 ;
				end				
					
							
				default begin
			
					RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b1; 
					RegWrite = 1'b1; MemRead = 1'b0; ALUOp = 2'b10; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; 
					
				end
			endcase
          end
          LW :
          begin
				RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b1; 
				RegWrite = 1'b1; MemRead = 1'b1; ALUOp = 2'b00; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; 
          end
          SW :
          begin
				RegDst = 1'bx; ALUSrc = 1'b1; MemtoReg = 1'bx; 
				RegWrite = 1'b0; MemRead = 1'b0; ALUOp = 2'b00; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; 
          end
		  
		  ori :
          begin
				RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b0; 
				RegWrite = 1'b1; MemRead = 1'b0; ALUOp = 2'b10; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; 
          end
		  
          BEQ :
          begin
				RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; 
				RegWrite = 1'b0; MemRead = 1'b0; ALUOp = 2'b01; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b0; 
          end
        
          BNE :
          begin
				RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; 
				RegWrite = 1'b0; MemRead = 1'b0; ALUOp = 2'b11; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b0; 
          end
		  		  
		  J :
		  begin
				RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; 
				RegWrite = 1'b0; MemRead = 1'b0; ALUOp = 2'b01; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b1; 
		  end	  		  
		  
		  
          default
          begin
				RegDst = 1'bx; ALUSrc = 1'bx; MemtoReg = 1'bx; 
				RegWrite = 1'bx; MemRead = 1'bx; ALUOp = 2'bxx; 
				MemWrite = 1'bx; Branch = 1'bx; Jump = 1'bx; 
          end

        endcase
    end
endmodule
