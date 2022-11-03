module ImmediateGen(
input logic ImmSrc,
input logic [31:0] Instr,
output logic [31:0] Imm);

	always_comb begin
		case(ImmSrc)
			1'b0: Imm = {{20{Instr[31]}}, Instr[31:20]}; //If the Immediate is I type 
			1'b1: Imm =  {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}; //If the Immediate is B type
			default: Imm = 32'bx; // undefined
		endcase
	end

endmodule