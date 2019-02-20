module mips32_testbench();

	wire [31:0] R;	
	reg  clk ,clk2;
	wire [31:0] index;
	
	mips32 io(.clk(clk),.result(R),.clk2(clk2),.pc_counter(index));
	
	always 
	begin
			#5 clk = ~clk;
	end
	
	always begin
			#35 clk2 = ~clk2;
	end
	
	initial begin
		clk = 0;
		clk2= 0;
		$readmemb("test_input.tv",io.insmem.instructions); 
		$readmemb("registers.mem",io.REGG.registers); 
		
	end
	
	always @(negedge clk2) 
	begin
		
		if(index >= 0) begin
			$display("\n -index = %32b",io.index_out);
			$display("instruction = %32b",io.instruction);
			$display("alu control = %3b, branch = %1b = , jump = %1b",io.select_bits_ALU,io.branch,io.jump);
			$display("result = %32b ",R);
	    end
	end
		
		
endmodule 