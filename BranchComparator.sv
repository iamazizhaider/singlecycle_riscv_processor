module BranchComparator(input logic [31:0] A,B, 
input logic Branch,
input logic [2:0]func3,
output logic PCSrc);

	logic beq,bne;

	always_comb begin
		if (A == B) begin 
			beq = 1; //Set beq = 1 if the statements are equa
			bne = 0;
			end
		else begin
			beq = 0; //Otherwise set bne = 1 if statements are not equal
			bne = 1;
			end
	end

	always_comb begin
		case({Branch,func3})
		4'b0_000: PCSrc = 1'b0; //add - addi - sub
		4'b0_010: PCSrc = 1'b0; //lw
		4'b0_011: PCSrc = 1'b0;	//sltu
		4'b1_000: PCSrc = beq; 
		4'b1_001: PCSrc = bne;
		default: PCSrc = 1'bx;
		endcase
	end

endmodule