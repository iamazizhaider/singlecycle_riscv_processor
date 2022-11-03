module Controller(
input logic [31:0] Instr,
output logic [2:0] ALUControl, 
output logic ResultSrc,RegWrite,ImmSrc,Branch,ALUSrc);

	logic [1:0] ALUOp;
	//Calling two modules into controller
	MainDecoder MD(Instr[6:0],RegWrite,ImmSrc,ResultSrc,Branch,ALUSrc,ALUOp);
	ALUDecoder AD(ALUOp,Instr[5],Instr[30],Instr[14:12],ALUControl);

endmodule