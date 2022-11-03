module MainDecoder(input logic [6:0] op,
output logic RegWrite,ImmSrc,ResultSrc,Branch,ALUSrc,
output logic [1:0] ALUOp);

	logic [6:0] control;
	assign {RegWrite,ImmSrc,ResultSrc,ALUSrc,ALUOp,Branch} = control; //Concatenate the output to make coding easy

	always_comb begin
		case(op)
		//I-type lw instruction
		7'b0000011: control = 7'b1_0_1_1_00_0;
		//I-type addi instructions
		7'b0010011: control = 7'b1_0_0_1_10_0;
		//R-type
		7'b0110011: control = 7'b1_x_0_0_10_0;
		//B-type
		7'b1100011: control = 7'b0_1_x_1_01_1;
		default: control = 7'bx_x_x_x_xx_x;
		endcase
	end

endmodule