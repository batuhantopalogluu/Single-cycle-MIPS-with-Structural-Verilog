module instructionMemory(instruction_out,clk2,index);

	output reg [31:0] instruction_out;
	input clk2;
	input [31:0] index;
	reg  [31:0] instructions[0:19];// testbenchte dolduruluyor.

	always @(posedge clk2)
	begin
		instruction_out <= instructions[index];
	end
	
endmodule
	