module alu_ctl( ALUOp, Funct, ALUOperation);
    input [1:0] ALUOp;
    input [5:0] Funct;
    output [3:0] ALUOperation;
    reg    [3:0] ALUOperation;

    // symbolic constants for instruction function code
    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
    parameter F_slt = 6'd42;
	parameter F_sll = 6'h0;
	parameter F_ori = 6'hd;
	parameter F_divu = 6'd27;
	parameter F_mfhi = 6'd16;
	parameter F_mflo = 6'd18;


    // symbolic constants for ALU Operations
    parameter ALU_add = 4'b0010;
    parameter ALU_sub = 4'b0110;
    parameter ALU_and = 4'b0000;
    parameter ALU_or  = 4'b0001;
    parameter ALU_slt = 4'b0111;
	parameter ALU_sll = 4'b0011;
	parameter ALU_divu= 4'b0100;
	parameter ALU_mfhi = 4'b1000 ;
	parameter ALU_mflo = 4'b1001 ;
	parameter ALU_bne_sub = 4'b0101 ;
	
	reg [5:0] temp ;
	reg [6:0] counter ;
	
    always @(ALUOp or Funct)
    begin
        case (ALUOp) 
            2'b00 : ALUOperation = ALU_add;
            2'b01 : ALUOperation = ALU_sub;
            2'b11 : ALUOperation = ALU_bne_sub ;
            2'b10 : case (Funct)
                        F_add : ALUOperation = ALU_add;
                        F_sub : ALUOperation = ALU_sub;
                        F_and : ALUOperation = ALU_and;
                        F_or  : ALUOperation = ALU_or;
                        F_slt : ALUOperation = ALU_slt;
						F_sll : ALUOperation = ALU_sll;
						F_divu : ALUOperation = ALU_divu;
						F_mfhi : ALUOperation = ALU_mfhi;
						F_mflo : ALUOperation = ALU_mflo;
						F_ori : ALUOperation = ALU_or;
                        default ALUOperation = 4'bxxxx;
                    endcase
            default ALUOperation = 4'bxxxx;
        endcase
    end
endmodule
