module nextPC(index_out,clk2,branch,SignExtImm,jumpp,jumpAdress);
	input clk2;
	input jumpp;
	input branch;
	input [25:0] jumpAdress;
	input [31:0] SignExtImm;
	output reg [31:0]  index_out;
	reg  [31:0]  index;
	reg [27:0] j;
	reg [31:0] temp;
	

	initial begin
		 index = -1;
	end 
	always @(negedge clk2) 
	begin
		if (branch || jumpp)begin        
			
			if(branch) begin 
				index = index + 1 + SignExtImm;	
				index_out = index;
			end						
			if (jumpp) begin 
			   j = {2'b00,jumpAdress};			
				temp = {index[31:28],j};
				index = temp; 
				index_out = index;       // pc = basina iki bir 0 eklenen jumpAdress ile o anki pc'ın ilk 4 biti concatenate edilir.
			end
		end 
		else begin 
			index = index + 1;  // jump veya branch instruction ı hariç durum
			index_out = index;	
		end
							
		if(index > 32'd20) //nstructionların bitme durumu
		begin
			$display("%32b test completed \n",index);
			$finish;
		end
	end


endmodule 