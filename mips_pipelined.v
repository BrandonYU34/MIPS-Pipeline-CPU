module mips_pipelined( clk, rst ) ;
	input clk, rst ;
	
	//instruction bus
	wire [31:0] instr ;
	
	//break out important fields from instruction
	wire [1:0] ID_EX_WB, EX_MEM_WB, MEM_WB_WB ;
	wire [2:0] ID_EX_M, EX_MEM_M ;
	wire [3:0] ID_EX_EX ;
	wire [5:0] opcode, funct ;
	wire [4:0] rs, rt, rd, shamt, ID_EX_rt, EX_MEM_WReg, MEM_WB_WReg, ID_EX_rd ;
				
	wire [15:0] immed ;
	wire [31:0] extend_immed, b_offset ;
	wire [25:0] jumpoffset ;
	// datapath signals
	wire [4:0] rfile_wn ;
	wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out,  b_tgt,
				pc_next, pc, pc_incr, dmem_rdata, jump_addr, branch_addr,
				IF_ID_incr, IF_ID_jump, IF_ID_instr, ID_EX_PC, ID_EX_extend, EX_MEM_ALU,
				EX_MEM_ADD, MEM_WB_RD, MEM_WB_ALU, ID_EX_RD2, ID_EX_RD1, EX_MEM_RD2 ;
	
	
	
	//control signals
	wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite,
		 ALUSrc, Zero, Jump, EX_MEM_Zero, addr_pc ;
	wire [1:0] ALUOp ;
	wire [3:0] Operation ;
	
	assign opcode = instr[31:26] ;
	assign rs = instr[25:21] ;
	assign rt = instr[20:16] ;
	assign rd = instr[15:11] ;
	assign shamt = instr[10:6] ;
	assign funct = instr[5:0] ;
	assign immed = instr[15:0] ;
	assign jumpoffset = instr[25:0] ;
	
	//branch offset shifter ;
	assign b_offset = extend_immed << 2 ;
	
	//jump offset shifter & concatenation
	assign jump_addr = { pc_incr[31:28], jumpoffset << 2 } ;
	
	// module instantiation
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) ) ;
	hazard hazard( .clk(clk), .rst(rst), .instr(instr), .addr_pc(addr_pc) ) ;	
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc), .addr_pc(addr_pc) ) ;
	sign_extend SignExt( .immed(immed), .ext_immed_out(extend_immed) ) ;
	
	
	Add32shift2 BRADD( .a(ID_EX_PC), .b(ID_EX_extend), .result(b_tgt) ) ;			
	AND BR_AND( PCSrc, EX_MEM_M[2], EX_MEM_Zero ) ;
	

	mux2 #(5) RFMUX( .sel(ID_EX_EX[3]), .a(ID_EX_rt), .b(ID_EX_rd), .y(rfile_wn) ) ;
	mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(EX_MEM_ADD), .y(branch_addr) ) ;		
	mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) ) ; //有jump功能要改
	mux2 #(32) ALUMUX( .sel(ID_EX_EX[0]), .a(ID_EX_RD2), .b(ID_EX_extend), .y(alu_b) ) ;
	mux2 #(32) WRMUX( .sel(MEM_WB_WB[0]), .a(MEM_WB_RD), .b(MEM_WB_ALU), .y(rfile_wd) ) ;
	
	control_single CTL( .opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc),
						.MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead),
						.MemWrite(MemWrite), .Branch(Branch), .Jump(Jump), .ALUOp(ALUOp), .funct(funct) ) ;	
	
	
	TotalALU totalalu( .clk(clk), .dataA(ID_EX_RD1), .dataB(alu_b), .Signal(Operation), .Output(alu_out), .reset(rst), .zero(Zero) );
	
	alu_ctl ALUCTL( .ALUOp(ID_EX_EX[2:1]), .Funct(ID_EX_extend[5:0]), .ALUOperation(Operation) ) ;
	
	reg_file RegFile( .clk(clk), .RegWrite(MEM_WB_WB[1]), .RN1(rs), .RN2(rt), 
					.WN(MEM_WB_WReg), .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) ) ;
					
	memory 	InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'b0), .addr(pc), .rd(instr) ) ;
	
	memory DatMem( .clk(clk), .MemRead(EX_MEM_M[1]), .MemWrite(EX_MEM_M[0]),
					.wd(EX_MEM_RD2), .addr(EX_MEM_ALU), .rd(dmem_rdata) ) ;
					
	IF_ID IF_ID( .clk(clk), .rst(rst), .PC_in(pc_incr), .PC_out(IF_ID_incr), .RD_in(instr), .RD_out(IF_ID_instr),
				 .IF_ID_jump(IF_ID_jump), .jump(jump_addr) ) ;
	
	
	ID_EX ID_EX( .clk(clk), .rst(rst), .ID_EX_WB(ID_EX_WB), .ID_EX_M(ID_EX_M), .ID_EX_EX(ID_EX_EX), .ID_EX_RD1(ID_EX_RD1), 
			.ID_EX_RD2(ID_EX_RD2), .ID_EX_rt(ID_EX_rt), .ID_EX_rd(ID_EX_rd), .ID_EX_PC(ID_EX_PC), .ID_EX_extend(ID_EX_extend),
			.Control_signal({RegDst, ALUOp, ALUSrc, Branch, MemRead, MemWrite, RegWrite, MemtoReg} ),
			.RD1(rfile_rd1), .RD2(rfile_rd2), .rt(rt), .rd(rd), .PC(IF_ID_incr), .extend(extend_immed), .en_reg(1'b1) ) ;
			
	EX_MEM EX_MEM( .clk(clk), .rst(rst), .EX_MEM_WB(EX_MEM_WB), .EX_MEM_M(EX_MEM_M), .EX_MEM_ALU(EX_MEM_ALU), .EX_MEM_ADD(EX_MEM_ADD),
				.EX_MEM_RD2(EX_MEM_RD2), .EX_MEM_WReg(EX_MEM_WReg), .EX_MEM_Zero(EX_MEM_Zero), .WB(ID_EX_WB), .M(ID_EX_M), .ADD(b_tgt), 
				.ALU(alu_out), .RD2(ID_EX_RD2), .zero(Zero), .WReg(rfile_wn), .en_reg(1'b1) ) ;		
	
	MEM_WB MEM_WB( .clk(clk), .rst(rst), .MEM_WB_WB(MEM_WB_WB), .MEM_WB_RD(MEM_WB_RD), .MEM_WB_ALU(MEM_WB_ALU), .MEM_WB_WReg(MEM_WB_WReg),
				.WB(ID_EX_WB), .RD(dmem_rdata), .ALU(EX_MEM_ALU), .WReg(EX_MEM_WReg), .en_reg(1'b1) ) ;					
	
					
endmodule
	
