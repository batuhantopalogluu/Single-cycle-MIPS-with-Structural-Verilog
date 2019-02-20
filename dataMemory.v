module dataMemory(out_data,in_data,adress,memWr,memRd,clk);
		
	input [31:0] adress;
	input [31:0] in_data;
	input memWr,memRd,clk;
	output reg [31:0] out_data;
	
	
	reg [31:0] data_MemoryB [255:0];
	

	always @(posedge clk) begin
		$readmemb("data_memory.mem",data_MemoryB);
		if(memWr) begin
			data_MemoryB[adress[7:0]] = in_data;
			$writememb("data_memory.mem",data_MemoryB);
			out_data = 32'b0; // memory çıktısı olmayan yerlerin xxx gözükmemesi için
		end
		
		if(memRd) begin
			  out_data = data_MemoryB[adress[7:0]];			
		end 
	end
	
	
	
	
endmodule 