module control_unit(select_bits_ALU,isBranch,select_writeReg,memWr,memRd,select_sltu,shiftOperation,alu_alt_select,select_zeroOrSign,function_code,op_code,write_enable,is_jump);

input [5:0] op_code;
input [5:0] function_code;
output [2:0] select_bits_ALU;
output select_writeReg,memWr,memRd,select_sltu;
output shiftOperation;
output alu_alt_select,select_zeroOrSign;
output isBranch;
output write_enable;
output is_jump;
	wire s00,s01;
	wire not_f5;
	wire w0,w1,w2;
	wire r_type;
	wire memR_not;
	wire sltu_temp;
	wire shift_Operation;
	wire not_instruction2;
	wire alu_s,rnot,brn;
	wire i_s0,i_s1,i_s1_not,i_s2,i_s2_not;
	wire select_bits_ALU0,select_bits_ALU1,select_bits_ALU2;
	wire sw_tempi;
	wire jmp0;
	
	
	not (rnot,r_type);
	
	nor rmi(r_type,op_code[0],op_code[1],op_code[2],op_code[3],op_code[4],op_code[5]);// r-type mı kontrolü
	not notc0(not_f5,function_code[5]);
	
	// s2 nin hesaplanmasi	
	or orc0(w0,function_code[1],not_f5);
	and sss0(select_bits_ALU2,r_type,w0);
	nor nor22(i_s2_not,op_code[0],op_code[3]);
	and and111(i_s2,i_s2_not,rnot);
	or alus2(select_bits_ALU[2],select_bits_ALU2,i_s2);
	
	// s1 in hesaplanmasi
	xnor xnorc0(w1,function_code[1],function_code[2]);
	and sss1(select_bits_ALU1,w1,r_type);
	
	not nnot(i_s1_not,op_code[2]); //// bu r type da hep true geliyor
	and and01(i_s1,i_s1_not,rnot);
	or alus1(select_bits_ALU[1],select_bits_ALU1,i_s1);
	
	// s0 in hesaplanmasi   S0 DOĞRU EMME  DİĞERLERİ YANLIŞ GİBİ BATILGAN
	and andc1(s00,function_code[0],function_code[2]);	
	and andc2(s01,not_f5,function_code[1]);
	or orc1(w2,s00,s01);	
	and sss2(select_bits_ALU0,w2,r_type);

	and and00(i_s0,op_code[0],op_code[2]);
	or alus0(select_bits_ALU[0],select_bits_ALU0,i_s0);
	
	
	//select_writeReg
	or wr(select_writeReg,op_code[0],op_code[1],op_code[2],op_code[3],op_code[4],op_code[5]); //+++ hw4 ı type sa rt dir
	
	
	// memWr
	and memw(memWr,op_code[5],op_code[3]);
	
	// memRd
	//not memrnot(memR_not,op_code[3]);	
	//and memrand(memRd,op_code[5],memR_not);
	buf bUFb(memRd,op_code[4]);
	
	//select_sltu
	not notsltu(not_instruction2,function_code[2]);
	and andsltu(sltu_temp,function_code[3],not_instruction2);
	and sltuand(select_sltu,r_type,sltu_temp);
	
	//shiftOperation
	not notg(shift_Operation,function_code[5]);
	and shopand(shiftOperation,shift_Operation,r_type);
	
	//isBranch
	not branchh0(brn,op_code[2]);
	nor branchh1(isBranch,op_code[5],op_code[4],op_code[3],op_code[1],op_code[0],brn);
	
	//alu_alt_select
	
	or alu_alt(alu_s,op_code[5],op_code[4],op_code[3]);
	and alu_and(alu_alt_select,alu_s,rnot);
	
	//select_zeroOrSign
	not zs(select_zeroOrSign,op_code[2]);
	
	// is_jump
	not jmph0(jmp0,op_code[1]);
	nor jmph1(is_jump,op_code[5],op_code[4],op_code[3],op_code[2],op_code[0],jmp0);
	
	//write_enable
	//not wre22(sw_tempi,memWr);	
	nor wre00(write_enable,memWr,isBranch,is_jump);
	
	
endmodule 