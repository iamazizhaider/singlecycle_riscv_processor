module DataMemory(
input logic [31:0] A,
output logic [31:0] RD);

	logic [31:0] DataMem [31:0];  //2D Array
	
	//Instantiating the data memory
	initial begin 
		$readmemh("C:/Users/PC/OneDrive/Desktop/CEP/Codes/DM_Data.mem",DataMem);
	end

	always_comb begin
		RD = DataMem[A[4:0]]; //Reading Data from Data Memory
	end
	
endmodule