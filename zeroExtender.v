module zeroExtender(out,in);

	input [15:0] in;
	output [31:0] out;
	
	buf sev0(out[0],in[0]),
		 sev1(out[1],in[1]),
		 sev2(out[2],in[2]),
		 sev3(out[3],in[3]),
		 sev4(out[4],in[4]),
		 sev5(out[5],in[5]),
		 sev6(out[6],in[6]),
		 sev7(out[7],in[7]),
		 sev8(out[8],in[8]),
		 sev9(out[9],in[9]),
		 sev10(out[10],in[10]),
		 sev11(out[11],in[11]),
		 sev12(out[12],in[12]),
		 sev13(out[13],in[13]),
		 sev14(out[14],in[14]),			 
		 sev15(out[15],in[15]),
		 sev16(out[16],1'b0),
		 sev17(out[17],1'b0),
		 sev18(out[18],1'b0),
		 sev19(out[19],1'b0),
		 sev20(out[20],1'b0),
		 sev21(out[21],1'b0),
		 sev22(out[22],1'b0),
		 sev23(out[23],1'b0),
		 sev24(out[24],1'b0),
		 sev25(out[25],1'b0),
		 sev26(out[26],1'b0),
		 sev27(out[27],1'b0),
		 sev28(out[28],1'b0),
		 sev29(out[29],1'b0),
		 sev30(out[30],1'b0),
		 sev31(out[31],1'b0);
endmodule 		 