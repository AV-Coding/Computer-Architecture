`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 3 (memory[i] = i * 3;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 
    integer i;
    output reg [31:0] Instruction;    // Instruction at memory location Address
    
    reg [31:0] Memory [0:1024];
    
    initial begin
    //$readmemh("private_instruction_memory.txt",Memory);
    Memory[0] <= 'h20130000;
    Memory[1] <= 'h20140000;
    Memory[2] <= 'h2010ffff;
    Memory[3] <= 'h2011ff00;
    Memory[4] <= 'h200900f0;
    Memory[5] <= 'h200a0000;
    Memory[6] <= 'h34120000;
    Memory[7] <= 'h02119824;
    Memory[8] <= 'h0269a025;
    Memory[9] <= 'h20130000;
    Memory[10] <= 'h20140000;
    Memory[11] <= 'h2010ffff;
    Memory[12] <= 'h2011ff00;
    Memory[13] <= 'h200900f0;
    Memory[14] <= 'h200a0000;
    Memory[15] <= 'h34120000;
    Memory[16] <= 'h02119824;
    Memory[17] <= 'h01338825;
    Memory[18] <= 'h20130000;
    Memory[19] <= 'h20140000;
    Memory[20] <= 'h20100001;
    Memory[21] <= 'h20110001;
    Memory[22] <= 'h20090001;
    Memory[23] <= 'h200a0000;
    Memory[24] <= 'h34120000;
    Memory[25] <= 'h02119820;
    Memory[26] <= 'h012a4022;
    Memory[27] <= 'h0269a022;
    Memory[28] <= 'h20130000;
    Memory[29] <= 'h20140000;
    Memory[30] <= 'h20100001;
    Memory[31] <= 'h20110001;
    Memory[32] <= 'h20090001;
    Memory[33] <= 'h200a0000;
    Memory[34] <= 'h34120000;
    Memory[35] <= 'h02119820;
    Memory[36] <= 'h012a4022;
    Memory[37] <= 'h0133a022;
    Memory[38] <= 'h34120000;
    Memory[39] <= 'h20130000;
    Memory[40] <= 'h20140000;
    Memory[41] <= 'h20100001;
    Memory[42] <= 'h20110001;
    Memory[43] <= 'h20090001;
    Memory[44] <= 'h200a0000;
    Memory[45] <= 'h22520004;
    Memory[46] <= 'h8e540000;
    Memory[47] <= 'h34120000;
    Memory[48] <= 'h20130000;
    Memory[49] <= 'h20140000;
    Memory[50] <= 'h20100001;
    Memory[51] <= 'h20110001;
    Memory[52] <= 'h20090001;
    Memory[53] <= 'h200a0000;
    Memory[54] <= 'h22340004;
    Memory[55] <= 'hae54000c;
    Memory[56] <= 'h8e51000c;
    Memory[57] <= 'h34120000;
    Memory[58] <= 'h20130000;
    Memory[59] <= 'h201400ff;
    Memory[60] <= 'h20100001;
    Memory[61] <= 'h20110001;
    Memory[62] <= 'h20090001;
    Memory[63] <= 'h200a0000;
    Memory[64] <= 'h22520004;
    Memory[65] <= 'hae54000c;
    Memory[66] <= 'h8e52000c;
    Memory[67] <= 'h34120000;
    Memory[68] <= 'h20130000;
    Memory[69] <= 'h20140000;
    Memory[70] <= 'h20100001;
    Memory[71] <= 'h20110001;
    Memory[72] <= 'h20090001;
    Memory[73] <= 'h200a0000;
    Memory[74] <= 'h22520004;
    Memory[75] <= 'h20090001;
    Memory[76] <= 'h8e540000;
    Memory[77] <= 'h34120000;
    Memory[78] <= 'h20130000;
    Memory[79] <= 'h20140000;
    Memory[80] <= 'h20100001;
    Memory[81] <= 'h20110001;
    Memory[82] <= 'h20090001;
    Memory[83] <= 'h200a0000;
    Memory[84] <= 'h22340001;
    Memory[85] <= 'h20090001;
    Memory[86] <= 'hae540010;
    Memory[87] <= 'h8e510010;
    Memory[88] <= 'h34120000;
    Memory[89] <= 'h20130000;
    Memory[90] <= 'h201400ff;
    Memory[91] <= 'h20100001;
    Memory[92] <= 'h20110001;
    Memory[93] <= 'h20090001;
    Memory[94] <= 'h200a0000;
    Memory[95] <= 'h22520004;
    Memory[96] <= 'h20090001;
    Memory[97] <= 'hae540010;
    Memory[98] <= 'h8e520010;
    Memory[99] <= 'h34120000;
    Memory[100] <= 'h201300aa;
    Memory[101] <= 'h20100055;
    Memory[102] <= 'h201400ff;
    Memory[103] <= 'h20110001;
    Memory[104] <= 'h20090001;
    Memory[105] <= 'h200a0000;
    Memory[106] <= 'h02138826;
    Memory[107] <= 'h12340005;
    Memory[108] <= 'h34140000;
    Memory[109] <= 'h34130000;
    Memory[110] <= 'h34120000;
    Memory[111] <= 'h34110000;
    Memory[112] <= 'h34100000;
    Memory[113] <= 'h341400ff;
    Memory[114] <= 'h341300ff;
    Memory[115] <= 'h34120000;
    Memory[116] <= 'h201300aa;
    Memory[117] <= 'h20100055;
    Memory[118] <= 'h20140aa0;
    Memory[119] <= 'h20110001;
    Memory[120] <= 'h20090001;
    Memory[121] <= 'h200a0000;
    Memory[122] <= 'h00138900;
    Memory[123] <= 'h12910005;
    Memory[124] <= 'h34140000;
    Memory[125] <= 'h34130000;
    Memory[126] <= 'h34120000;
    Memory[127] <= 'h34110000;
    Memory[128] <= 'h34100000;
    Memory[129] <= 'h341400ff;
    Memory[130] <= 'h341300ff;
    Memory[131] <= 'h34120000;
    Memory[132] <= 'h201300aa;
    Memory[133] <= 'h20100055;
    Memory[134] <= 'h201400ff;
    Memory[135] <= 'h20110001;
    Memory[136] <= 'h20090001;
    Memory[137] <= 'h200a0000;
    Memory[138] <= 'h02138826;
    Memory[139] <= 'h20130001;
    Memory[140] <= 'h12340005;
    Memory[141] <= 'h34140000;
    Memory[142] <= 'h34130000;
    Memory[143] <= 'h34120000;
    Memory[144] <= 'h34110000;
    Memory[145] <= 'h34100000;
    Memory[146] <= 'h341400ff;
    Memory[147] <= 'h341300ff;
    Memory[148] <= 'h34120000;
    Memory[149] <= 'h201300aa;
    Memory[150] <= 'h20100055;
    Memory[151] <= 'h20140aa0;
    Memory[152] <= 'h20110001;
    Memory[153] <= 'h20090001;
    Memory[154] <= 'h200a0000;
    Memory[155] <= 'h00138900;
    Memory[156] <= 'h20130001;
    Memory[157] <= 'h12910005;
    Memory[158] <= 'h34140000;
    Memory[159] <= 'h34130000;
    Memory[160] <= 'h34120000;
    Memory[161] <= 'h34110000;
    Memory[162] <= 'h34100000;
    Memory[163] <= 'h341400ff;
    Memory[164] <= 'h341300ff;
    Memory[165] <= 'h34120000;
    Memory[166] <= 'h20130000;
    Memory[167] <= 'h20100000;
    Memory[168] <= 'h20140000;
    Memory[169] <= 'h20110000;
    Memory[170] <= 'h20090001;
    Memory[171] <= 'h200a0000;
    Memory[172] <= 'h8e510000;
    Memory[173] <= 'h02339020;
    Memory[174] <= 'h34120000;
    Memory[175] <= 'h20130000;
    Memory[176] <= 'h20100000;
    Memory[177] <= 'h20140000;
    Memory[178] <= 'h20110000;
    Memory[179] <= 'h20090001;
    Memory[180] <= 'h200a0000;
    Memory[181] <= 'h8e510000;
    Memory[182] <= 'h0274a022;
    Memory[183] <= 'h02339020;
    Memory[184] <= 'h34120000;
    Memory[185] <= 'h20130000;
    Memory[186] <= 'h20100000;
    Memory[187] <= 'h20140000;
    Memory[188] <= 'h20110000;
    Memory[189] <= 'h20090001;
    Memory[190] <= 'h200a0000;
    Memory[191] <= 'h8e510000;
    Memory[192] <= 'h02719020;
    Memory[193] <= 'h34120000;
    Memory[194] <= 'h20130000;
    Memory[195] <= 'h20100000;
    Memory[196] <= 'h20140000;
    Memory[197] <= 'h20110000;
    Memory[198] <= 'h20090001;
    Memory[199] <= 'h200a0000;
    Memory[200] <= 'h8e510000;
    Memory[201] <= 'h0274a022;
    Memory[202] <= 'h02719020;
    Memory[203] <= 'h34120000;
    Memory[204] <= 'h20130000;
    Memory[205] <= 'h20100000;
    Memory[206] <= 'h20140000;
    Memory[207] <= 'h20110000;
    Memory[208] <= 'h20090001;
    Memory[209] <= 'h200a0000;
    Memory[210] <= 'h8e510000;
    Memory[211] <= 'hae510004;
    Memory[212] <= 'h20090001;
    Memory[213] <= 'h20090001;
    Memory[214] <= 'h20090001;
    Memory[215] <= 'h8e530004;
    Memory[216] <= 'h34120000;
    Memory[217] <= 'h20130000;
    Memory[218] <= 'h20100000;
    Memory[219] <= 'h20140000;
    Memory[220] <= 'h2011000f;
    Memory[221] <= 'h20090001;
    Memory[222] <= 'h200a0000;
    Memory[223] <= 'hae51000c;
    Memory[224] <= 'h8e52000c;
    Memory[225] <= 'h34120000;
    Memory[226] <= 'h20130000;
    Memory[227] <= 'h20100000;
    Memory[228] <= 'h20140000;
    Memory[229] <= 'h2011000f;
    Memory[230] <= 'h20090001;
    Memory[231] <= 'h200a0000;
    Memory[232] <= 'h8e510000;
    Memory[233] <= 'h12340002;
    Memory[234] <= 'h34140021;
    Memory[235] <= 'h34130021;
    Memory[236] <= 'h341400ff;
    Memory[237] <= 'h341300ff;
    Memory[238] <= 'h34120000;
    Memory[239] <= 'h20130000;
    Memory[240] <= 'h20100000;
    Memory[241] <= 'h20140064;
    Memory[242] <= 'h20110000;
    Memory[243] <= 'h20090064;
    Memory[244] <= 'h200a0000;
    Memory[245] <= 'h8e510000;
    Memory[246] <= 'h12910002;
    Memory[247] <= 'h341400ff;
    Memory[248] <= 'h341300ff;
    Memory[249] <= 'h34140022;
    Memory[250] <= 'h34130022;
    Memory[251] <= 'h34120000;
    Memory[252] <= 'h20130000;
    Memory[253] <= 'h20100000;
    Memory[254] <= 'h20140064;
    Memory[255] <= 'h20110000;
    Memory[256] <= 'h20090001;
    Memory[257] <= 'h200a0000;
    Memory[258] <= 'h8e510000;
    Memory[259] <= 'h0254b020;
    Memory[260] <= 'h12340002;
    Memory[261] <= 'h341400ff;
    Memory[262] <= 'h341300ff;
    Memory[263] <= 'h34140023;
    Memory[264] <= 'h34130023;
    Memory[265] <= 'h34120000;
    Memory[266] <= 'h20130000;
    Memory[267] <= 'h20100000;
    Memory[268] <= 'h20140064;
    Memory[269] <= 'h20110000;
    Memory[270] <= 'h20090001;
    Memory[271] <= 'h200a0000;
    Memory[272] <= 'h8e510000;
    Memory[273] <= 'h02739820;
    Memory[274] <= 'h12910002;
    Memory[275] <= 'h341400ff;
    Memory[276] <= 'h341300ff;
    Memory[277] <= 'h34140024;
    Memory[278] <= 'h34130024;
    Memory[279] <= 'h34120000;
    Memory[280] <= 'h20130000;
    Memory[281] <= 'h20100000;
    Memory[282] <= 'h20140064;
    Memory[283] <= 'h20110000;
    Memory[284] <= 'h20090001;
    Memory[285] <= 'h200a0000;
    Memory[286] <= 'h8e510000;
    Memory[287] <= 'h3a9000ff;
    Memory[288] <= 'h02549820;
    Memory[289] <= 'h12340002;
    Memory[290] <= 'h341400ff;
    Memory[291] <= 'h341300ff;
    Memory[292] <= 'h34140025;
    Memory[293] <= 'h34130025;
    Memory[294] <= 'h34120000;
    Memory[295] <= 'h20130000;
    Memory[296] <= 'h20100000;
    Memory[297] <= 'h20140064;
    Memory[298] <= 'h20110000;
    Memory[299] <= 'h20090001;
    Memory[300] <= 'h200a0000;
    Memory[301] <= 'h8e510000;
    Memory[302] <= 'h329000ff;
    Memory[303] <= 'h02549820;
    Memory[304] <= 'h12910002;
    Memory[305] <= 'h341400ff;
    Memory[306] <= 'h341300ff;
    Memory[307] <= 'h34140026;
    Memory[308] <= 'h34130026;
    Memory[309] <= 'h34120000;
    Memory[310] <= 'h20130000;
    Memory[311] <= 'h20100000;
    Memory[312] <= 'h20140064;
    Memory[313] <= 'h20110000;
    Memory[314] <= 'h20090001;
    Memory[315] <= 'h200a0000;
    Memory[316] <= 'h8e510000;
    Memory[317] <= 'h329000ff;
    Memory[318] <= 'h12300002;
    Memory[319] <= 'h341400ff;
    Memory[320] <= 'h341300ff;
    Memory[321] <= 'h34140027;
    Memory[322] <= 'h34130027;
    Memory[323] <= 'h34120000;
    Memory[324] <= 'h20130000;
    Memory[325] <= 'h20100000;
    Memory[326] <= 'h20140064;
    Memory[327] <= 'h20110000;
    Memory[328] <= 'h20090001;
    Memory[329] <= 'h200a0000;
    Memory[330] <= 'h8e510000;
    Memory[331] <= 'h329000ff;
    Memory[332] <= 'h012a4020;
    Memory[333] <= 'h12300002;
    Memory[334] <= 'h341400ff;
    Memory[335] <= 'h341300ff;
    Memory[336] <= 'h34140028;
    Memory[337] <= 'h34130028;
    Memory[338] <= 'h34120000;
    Memory[339] <= 'h20130000;
    Memory[340] <= 'h20100000;
    Memory[341] <= 'h20140064;
    Memory[342] <= 'h20110000;
    Memory[343] <= 'h20090001;
    Memory[344] <= 'h200a0000;
    Memory[345] <= 'h8e510000;
    Memory[346] <= 'h329000ff;
    Memory[347] <= 'h012a4020;
    Memory[348] <= 'h012a5826;
    Memory[349] <= 'h12300002;
    Memory[350] <= 'h341400ff;
    Memory[351] <= 'h341300ff;
    Memory[352] <= 'h34140029;
    Memory[353] <= 'h34130029;
    Memory[354] <= 'h34120000;
    Memory[355] <= 'h20130000;
    Memory[356] <= 'h20100000;
    Memory[357] <= 'h20140064;
    Memory[358] <= 'h20110000;
    Memory[359] <= 'h20090001;
    Memory[360] <= 'h200a0000;
    Memory[361] <= 'h0800016c;
    Memory[362] <= 'h341400ff;
    Memory[363] <= 'h341300ff;
    Memory[364] <= 'h34140030;
    Memory[365] <= 'h34130030;
    Memory[366] <= 'h34120000;
    Memory[367] <= 'h20130000;
    Memory[368] <= 'h20100000;
    Memory[369] <= 'h20140064;
    Memory[370] <= 'h20110000;
    Memory[371] <= 'h20090001;
    Memory[372] <= 'h200a0000;
    Memory[373] <= 'h0c000179;
    Memory[374] <= 'h341400ff;
    Memory[375] <= 'h341300ff;
    Memory[376] <= 'h0800017a;
    Memory[377] <= 'h03e00008;
    Memory[378] <= 'h0800017a;
    end
    /* Please fill in the implementation here */
    always @(Address)begin
    
    Instruction = Memory[Address[31:2]];
    //end
    end

endmodule
