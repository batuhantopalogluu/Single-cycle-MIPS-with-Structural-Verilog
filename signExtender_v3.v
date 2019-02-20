module signExtender_v3(out,in);
	
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
		 sev16(out[16],in[15]),
		 sev17(out[17],in[15]),
		 sev18(out[18],in[15]),
		 sev19(out[19],in[15]),
		 sev20(out[20],in[15]),
		 sev21(out[21],in[15]),
		 sev22(out[22],in[15]),
		 sev23(out[23],in[15]),
		 sev24(out[24],in[15]),
		 sev25(out[25],in[15]),
		 sev26(out[26],in[15]),
		 sev27(out[27],in[15]),
		 sev28(out[28],in[15]),
		 sev29(out[29],in[15]),
		 sev30(out[30],in[15]),
		 sev31(out[31],in[15]);
			 
endmodule 