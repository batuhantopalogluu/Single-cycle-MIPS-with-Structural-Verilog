
module mips32(clk, result,clk2/*,index*/, pc_counter);

	//input [31:0] instruction; hw4 ---
   output [31:0] result;
	input clk;
	input clk2;
	//***********input [7:0]  index;

	wire [31:0]  index_out; // 32 bit pc tutuyorum
	wire [4:0] readReg_1;
	wire [4:0] WriteReg; //*+++++++++++++++++++ BATILGAN BAK HELE
	
	wire [31:0] read_data_1;
	wire [31:0] read_data_2;
	
	wire [31:0] alu_alt_bacak;
	wire [31:0] alu_alt_bacak_temp1; // ++++ hw4
	wire [31:0] alu_alt_bacak_temp2; // ++++ hw4
	
	wire [31:0] out_data_dataMem;// +++ data mem out hw4
	wire [31:0] aluOrSltuResult;// +++  out hw4
	wire [31:0] write_data;  
	
	wire [31:0] extended_shift,extended_sltu;

	wire shiftOperation; // control unit belirler yada başka bir şekilde belirleriz
	
	wire [2:0] select_bits_ALU;
	
	wire [31:0] temp_result;
	
	wire [31:0] sign_extended_Immediate; //// assignment 4
	wire [31:0] zero_extended_Immediate; //// assignment 4
	
	wire select_sltu;
	wire ZERO;
	wire select_writeReg; /// 0 sa RD 1 se RT
   wire select_zeroOrSign;///  alu alt bacağı için ZERO EXTEND YADA SİGN EXTEND++++++++++/op_Code[2] nin NOT ı
	wire alu_alt_select ; // HW4 alu_alt_bacak_temp1, alu_alt_bacak_temp2 ARASINDA 0 SA 1 ,1 İSE 2 
	wire memRead_enable,memWrite_enable;
	wire branch;
	wire jump;
	wire [31:0] instruction;
	wire isBranch;
	output [31:0]pc_counter;
	wire write_enable;
	//wire select_finalResult, // hw4 en son result değirine karar verilen mux. BAŞAK DEĞİŞKENLE BUNA GEREK KALMAMIŞ
	
	
	// BATILGAN BATILGAN BATILGAN
	
	
	// BAK HELE  BU PC Yİ ÇÖZ HELE BAKİM 
	//   PC nextPC();
	nextPC pcc(index_out,clk2,branch,sign_extended_Immediate,jump,instruction[25:0]);
	instructionMemory insmem (instruction,clk2,index_out);	//// assignment 4
	assign_32bit pca(pc_counter,index_out);
	//	$display("opcode = %6b, rs = %5b, rt = %5b, rd = %5b, shamnt = %5b, funct = %6b",instruction[31:26],instruction[25:21],instruction[20:16],instruction[15:11],instruction[10:6],instruction[5:0]);
	// pc_counter   SORUN ÇÖZÜLMELİ
	//------------------------------------------------------------------------------------------------------------------------------------
	// DEĞİŞMELİ           DEĞİŞMELİ           DEĞİŞMELİ           DEĞİŞMELİ           DEĞİŞMELİ           DEĞİŞMELİ           DEĞİŞMELİ           
	//------------------------------------------------------------------------------------------------------------------------------------
	
	// Sİ MÜ LASYONDA ,LK CASE XXX OLUYOR DÜZELTİLMELİ
	
	
	// --------------------------------------------------------------------------------------------------------------------------------------
	//     B U N D A N    A L T I N D A    S I K I N T I    Y O K   G İ B İ     B.T.		
   //   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   
	//	  V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   
	//---------------------------------------------------------------------------------------------------------------------------------------
	_5bit_2_1mux blokGirisi1(readReg_1,instruction[25:21],instruction[20:16],shiftOperation); //shiftOperation = 0 ise rs i 1 se rt yi almalı 		
	_5bit_2_1mux writeRegSecimi (WriteReg,instruction[15:11],instruction[20:16],select_writeReg);  // 0 sa RD 1 se RT write data sadece rd ye değil RD VEYA RT ye yazılabilir. TAMAM
	mips_registers REGG( read_data_1, read_data_2, write_data, readReg_1, instruction[20:16],WriteReg,write_enable,clk);// hw4 ++                                       
	signExtender EXT0(extended_shift,instruction[10:6]); // shamt 32bit e uzatılır.
	zeroExtender ZE (zero_extended_Immediate,instruction[15:0]); // ori , andi için 
	signExtender_v3 SE_V3(sign_extended_Immediate,instruction[15:0]); // ADDIU ,LW, SW	
	_32bit_2_1mux zsExS(alu_alt_bacak_temp1,zero_extended_Immediate,sign_extended_Immediate,select_zeroOrSign); // hw4	
	_32bit_2_1mux blokCikisi(alu_alt_bacak_temp2,read_data_2,extended_shift,shiftOperation);// eger shift operasyonu ise sll,srl gibi o bacak secilir.
	_32bit_2_1mux aluu_alt(alu_alt_bacak,alu_alt_bacak_temp2,alu_alt_bacak_temp1,alu_alt_select);//alu_alt_select alu_alt_select  SEÇİMİ alu_alt_bacak
	// control unit çalışmasi
	control_unit cunit(select_bits_ALU,isBranch,select_writeReg,memWrite_enable,memRead_enable,select_sltu,shiftOperation,alu_alt_select,select_zeroOrSign,instruction[5:0],instruction[31:26],write_enable,jump);
	
	// B U R A Y A    K A D A R   O L M U Ş B E  B A T I L G A N  B A K   H E L E 
 	//------------------------------------------------------------------------------------------------------------------------------------------
	
	alu32 alum(temp_result,ZERO,read_data_1,alu_alt_bacak,select_bits_ALU);
	and branchOP(branch,ZERO,isBranch); // BATILGAN BAK HELE  BU BRANH I KULLANMAYI UNUTMA BAK BAK HELE HELE
	
	//  branch branch  branch branch branch branch  branch branch branch branch branch branch  branch  branch branch branch branch   
	//------------------------------------------------------------------------------------------------------------------------------------
	// DEĞİŞMELİ ?           DEĞİŞMELİ    ?      DEĞİŞMELİ     ?      DEĞİŞMELİ     ?      DEĞİŞMELİ       ?    DEĞİŞMELİ     ?      DEĞİŞMELİ           	
	//------------------------------------------------------------------------------------------------------------------------------------
//  

	// ah ulan ah adam daha control uniti ayarlamamıi-ş gelmiş bize artizlik yapıyor...... YAP HEMEN 

// yoRUM   yaptım galiba cu bende sen raat ol


	//-----------------------------------------------------------------------------------------------------------------------------------
	//	      B U N D A N    A L T I N D A    S I K I N T I    Y O K   G İ B İ     B.T.																	|
	//-----------------------------------------------------------------------------------------------------------------------------------
	//   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   
	//	  V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V    
	// alu nun ilk biti 32 bit e extend edilmeli sltu için
	signExtender_v2 sev2(extended_sltu,temp_result[31]);
	
	//module dataMemory(out_data,in_data,adress,memWr,memRd,clk)  HW4
	dataMemory dm(out_data_dataMem,read_data_2,temp_result,memWrite_enable,memRead_enable,clk); 	
	
	// alunun sonucu ile sltu için signextends edilmiş alu sonucu arasında seçim yapılmalı bunun içi mux konulur.	
   _32bit_2_1mux dataMemCikisi(aluOrSltuResult,temp_result,extended_sltu,select_sltu); 
	
	// data memory çıkışı ile sltu,alu sonucu arasında seçim   HW4
	_32bit_2_1mux resultMux(result,aluOrSltuResult,out_data_dataMem,memRead_enable);// memRead ı kullanıyorum aynı şey çünkü 1 ken DATA MEM SONUCU RESULT OLUCAK
		
	
	//register a geri yazmak için result write_data ya atılır.
	assign_32bit ass(write_data,result);


endmodule