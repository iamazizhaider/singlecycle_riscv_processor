module RiscV_SS_Processor(input logic clk,rst,
output logic [7:0] seg, 
output logic [6:0] display);

	logic [31:0] Instr,outz;
	logic RegWrite, ImmSrc, ALUSrc, ResultSrc,Branch;
	logic [2:0] ALUControl; 
	logic clk_25MHz;
	
	//we need 25MHz clock for our single cycle processor
	FrequencyDivider FD(clk,clk_25MHz);

	DataPath SCDP(outz,Instr,ALUControl,Branch,RegWrite,ImmSrc,ResultSrc,ALUSrc,clk_25MHz,rst);
	Controller SCC(Instr,ALUControl,ResultSrc,RegWrite,ImmSrc,Branch,ALUSrc);

    //4x7 Decoder for Character Display on FPGA  
    always @(*) begin
        case(outz)
            0: display = 7'b1000000;    
            1: display = 7'b1111001;    
            2: display = 7'b0100100;    
            3: display = 7'b0110000;    
            5: display = 7'b0011001;    
            6: display = 7'b0010010;    
            7: display = 7'b0000010;    
            8: display = 7'b1111000;    
            9: display = 7'b0000000;    
            default: display = 7'b1111111;        
        endcase
    end  
	
	//Assigning seg like this because we need to use only one character on FPGA
	assign seg = 8'b11111110;

endmodule