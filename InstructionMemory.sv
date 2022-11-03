module InstructionMemory(
input logic [31:0] PC,
output logic [31:0] Instr);

	logic [31:0] InstrMem [31:0];  //2D Array

	initial begin
		$readmemb("C:/Users/PC/OneDrive/Desktop/CEP/Codes/IM_Data.mem",InstrMem);
	end

	always_comb begin
		Instr = InstrMem[PC[31:2]];
	end

endmodule