module DataPath(
output logic [31:0] y,
output logic [31:0] Instr,
input logic [2:0] ALUControl, 
input logic Branch,RegWrite,ImmSrc,ResultSrc,ALUSrc,clk,rst);

	logic [31:0] PCNext;
	logic [31:0] PCPlus4,PCTarget;

	//PC Counter
	logic [31:0] PC = 0;
	always_ff @(posedge clk) begin
		PC <= #1 PCNext;
	end
	
	//Adder for PC 
	always_comb begin
		PCPlus4 = PC + 4;
	end

	InstructionMemory IM(PC,Instr); //Instruction Memory

	logic [31:0] SrcA,SrcB,RD2;
	logic [31:0] Result;

	RegisterFile RF(SrcA,RD2,Result,Instr[19:15],Instr[24:20],Instr[11:7],RegWrite,clk,rst); //Register File
	
	//Immediate Generator and extender to 32 bits
	logic [31:0] ImmExt;
	ImmediateGen IG(ImmSrc,Instr,ImmExt);
	
	//Adder for Branching
	always_comb begin
		PCTarget = PC + ImmExt;
	end
	
	//Comparator for branching if beq or bne occurs
	logic PCSrc;
	BranchComparator BC(SrcA,RD2,Branch,Instr[14:12],PCSrc);
	
	//mux for Source 2 of ALU
	always_comb begin
		case(ALUSrc)
		0: SrcB = RD2;
		1: SrcB = ImmExt;
		endcase
	end
	
	//mux for PC Counter
	always_comb begin
		case(PCSrc)
		0: PCNext = PCPlus4;
		1: PCNext = PCTarget;
		endcase
	end
	
	//Algorithmic Logic Unit
	logic [31:0] ALUResult;
	ALU LogicUnit(SrcA,SrcB,ALUControl,ALUResult); 
	
	//Data Memory
	logic [31:0] ReadData;
	DataMemory DM(ALUResult,ReadData);
	
	//Mux for Result Source of Instruction
	always_comb begin
		case(ResultSrc)
		0: Result = ALUResult;
		1: Result = ReadData;
		endcase
	end
	
	//Using this variable for output
	always_comb begin
		y = SrcA;
	end

endmodule