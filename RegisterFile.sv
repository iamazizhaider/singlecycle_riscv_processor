module RegisterFile(
output logic [31:0] RD1, RD2,
input logic [31:0] WD3,
input logic [4:0] A1, A2, A3,
input  logic RegWrite, clk, rst);

	logic [31:0] memory [31:0];  //2D Array
	//mux 1
	always_comb begin
		if(A1==0) RD1 = 0;
		else RD1 = memory[A1];
	end
	//mux 2
	always_comb begin
		if(A2==0) RD2 = 0;
		else RD2 = memory[A2];
	end

	//Writing data to register file
	always_ff @(posedge clk) begin
		if(rst) begin  //Added reset for the purpose of simulation
			for (int i = 0; i <= 31; i += 1) memory[i] <= #1 0; 
		end	
		else if (RegWrite) memory[A3] <= #1 WD3;
	end

endmodule