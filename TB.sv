module TB();

	logic clk,rst;
	logic [6:0] display;
	logic [7:0] seg;

	RiscV_SS_Processor CEP(clk,rst,seg,display);

	initial begin
		clk = 0;
		forever #10 clk = ~clk; //Time Period for 100MHz
	end

	initial begin
		rst = 1;
		@(posedge clk);
		rst = 0;
		repeat (350) @(posedge clk);
		$stop;
	end

endmodule