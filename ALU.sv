module ALU(
input logic [31:0] A,B,                 
input logic [2:0] sel,
output logic [31:0] result);
    
    always_comb begin
        case (sel)
        3'b000:result = A + B; //AND	
        3'b001:result = A - B; //SUB		
		3'b010:result = A | B; //OR		
        3'b011:result = A ^ B; //XOR		
        3'b100:result = A & B; //AND		
		3'b101:result = A < B; //SLTU
		default: result = A + B; 
	    endcase
	end
	
endmodule