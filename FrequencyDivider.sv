module FrequencyDivider(input logic clk, output logic reduced_clk);
	
	//FPGA gives us a clock frequency of 100MHz
	//We need 25 MHz for our single cycle risc v processor
	//We use two T-flip flops for that purpose 
	//Basically T flip flop is a bit counter (synchronous) with enable
	
	logic [1:0] t = 0;
	always_ff @(posedge clk) begin
		t[0] <= #1 t[0] + 1;
	end

	always_ff @(posedge t) begin
		t[1] <= #1 t[1] + 1;
	end
	assign reduced_clk = t[1];
	
endmodule