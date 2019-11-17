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
    
    reg [31:0] Memory [400:0];
    
    initial begin
    Memory[0] <= 32'h34040000;	//	main:		ori	$a0, $zero, 0
    Memory[1] <= 32'h00000000;    //            nop
    Memory[2] <= 32'h00000000;    //            nop
    Memory[3] <= 32'h00000000;    //            nop
    Memory[4] <= 32'h00000000;    //            nop
    Memory[5] <= 32'h00000000;    //            nop
    Memory[6] <= 32'h08000018;    //            j    start
    Memory[7] <= 32'h00000000;    //            nop
    Memory[8] <= 32'h00000000;    //            nop
    Memory[9] <= 32'h00000000;    //            nop
    Memory[10] <= 32'h00000000;    //            nop
    Memory[11] <= 32'h00000000;    //            nop
    Memory[12] <= 32'h2004000a;    //            addi    $a0, $zero, 10
    Memory[13] <= 32'h00000000;    //            nop
    Memory[14] <= 32'h00000000;    //            nop
    Memory[15] <= 32'h00000000;    //            nop
    Memory[16] <= 32'h00000000;    //            nop
    Memory[17] <= 32'h00000000;    //            nop
    Memory[18] <= 32'h2004000a;    //            addi    $a0, $zero, 10
    Memory[19] <= 32'h00000000;    //            nop
    Memory[20] <= 32'h00000000;    //            nop
    Memory[21] <= 32'h00000000;    //            nop
    Memory[22] <= 32'h00000000;    //            nop
    Memory[23] <= 32'h00000000;    //            nop
    Memory[24] <= 32'h8c900004;    //    start:        lw    $s0, 4($a0)
    Memory[25] <= 32'h00000000;    //            nop
    Memory[26] <= 32'h00000000;    //            nop
    Memory[27] <= 32'h00000000;    //            nop
    Memory[28] <= 32'h00000000;    //            nop
    Memory[29] <= 32'h00000000;    //            nop
    Memory[30] <= 32'h8c900008;    //            lw    $s0, 8($a0)
    Memory[31] <= 32'h00000000;    //            nop
    Memory[32] <= 32'h00000000;    //            nop
    Memory[33] <= 32'h00000000;    //            nop
    Memory[34] <= 32'h00000000;    //            nop
    Memory[35] <= 32'h00000000;    //            nop
    Memory[36] <= 32'hac900000;    //            sw    $s0, 0($a0)
    Memory[37] <= 32'h00000000;    //            nop
    Memory[38] <= 32'h00000000;    //            nop
    Memory[39] <= 32'h00000000;    //            nop
    Memory[40] <= 32'h00000000;    //            nop
    Memory[41] <= 32'h00000000;    //            nop
    Memory[42] <= 32'hac90000c;    //            sw    $s0, 12($a0)
    Memory[43] <= 32'h00000000;    //            nop
    Memory[44] <= 32'h00000000;    //            nop
    Memory[45] <= 32'h00000000;    //            nop
    Memory[46] <= 32'h00000000;    //            nop
    Memory[47] <= 32'h00000000;    //            nop
    Memory[48] <= 32'h8c910000;    //            lw    $s1, 0($a0)       //im getting zero
    Memory[49] <= 32'h00000000;    //            nop
    Memory[50] <= 32'h00000000;    //            nop
    Memory[51] <= 32'h00000000;    //            nop
    Memory[52] <= 32'h00000000;    //            nop
    Memory[53] <= 32'h00000000;    //            nop
    Memory[54] <= 32'h8c92000c;    //            lw    $s2, 12($a0)
    Memory[55] <= 32'h00000000;    //            nop
    Memory[56] <= 32'h00000000;    //            nop
    Memory[57] <= 32'h00000000;    //            nop
    Memory[58] <= 32'h00000000;    //            nop
    Memory[59] <= 32'h00000000;    //            nop
    Memory[60] <= 32'h12000017;    //            beq    $s0, $zero, branch1
    Memory[61] <= 32'h00000000;    //            nop
    Memory[62] <= 32'h00000000;    //            nop
    Memory[63] <= 32'h00000000;    //            nop
    Memory[64] <= 32'h00000000;    //            nop
    Memory[65] <= 32'h00000000;    //            nop
    Memory[66] <= 32'h02008820;    //            add    $s1, $s0, $zero
    Memory[67] <= 32'h00000000;    //            nop
    Memory[68] <= 32'h00000000;    //            nop
    Memory[69] <= 32'h00000000;    //            nop
    Memory[70] <= 32'h00000000;    //            nop
    Memory[71] <= 32'h00000000;    //            nop
    Memory[72] <= 32'h1211000b;    //            beq    $s0, $s1, branch1
    Memory[73] <= 32'h00000000;    //            nop
    Memory[74] <= 32'h00000000;    //            nop
    Memory[75] <= 32'h00000000;    //            nop
    Memory[76] <= 32'h00000000;    //            nop
    Memory[77] <= 32'h00000000;    //            nop
    Memory[78] <= 32'h0800013e;    //            j    error
    Memory[79] <= 32'h00000000;    //            nop
    Memory[80] <= 32'h00000000;    //            nop
    Memory[81] <= 32'h00000000;    //            nop
    Memory[82] <= 32'h00000000;    //            nop
    Memory[83] <= 32'h00000000;    //            nop
    Memory[84] <= 32'h2010ffff;    //    branch1:    addi    $s0, $zero, -1
    Memory[85] <= 32'h00000000;    //            nop
    Memory[86] <= 32'h00000000;    //            nop
    Memory[87] <= 32'h00000000;    //            nop
    Memory[88] <= 32'h00000000;    //            nop
    Memory[89] <= 32'h00000000;    //            nop
    Memory[90] <= 32'h0601ffbd;    //            bgez    $s0, start
    Memory[91] <= 32'h00000000;    //            nop
    Memory[92] <= 32'h00000000;    //            nop
    Memory[93] <= 32'h00000000;    //            nop
    Memory[94] <= 32'h00000000;    //            nop
    Memory[95] <= 32'h00000000;    //            nop
    Memory[96] <= 32'h22100001;    //            addi    $s0, $s0, 1
    Memory[97] <= 32'h00000000;    //            nop
    Memory[98] <= 32'h00000000;    //            nop
    Memory[99] <= 32'h00000000;    //            nop
    Memory[100] <= 32'h00000000;    //            nop
    Memory[101] <= 32'h00000000;    //            nop
    Memory[102] <= 32'h0601000b;    //            bgez    $s0, branch2
    Memory[103] <= 32'h00000000;    //            nop
    Memory[104] <= 32'h00000000;    //            nop
    Memory[105] <= 32'h00000000;    //            nop
    Memory[106] <= 32'h00000000;    //            nop
    Memory[107] <= 32'h00000000;    //            nop
    Memory[108] <= 32'h0800013e;    //            j    error
    Memory[109] <= 32'h00000000;    //            nop
    Memory[110] <= 32'h00000000;    //            nop
    Memory[111] <= 32'h00000000;    //            nop
    Memory[112] <= 32'h00000000;    //            nop
    Memory[113] <= 32'h00000000;    //            nop
    Memory[114] <= 32'h2010ffff;    //    branch2:    addi    $s0, $zero, -1
    Memory[115] <= 32'h00000000;    //            nop
    Memory[116] <= 32'h00000000;    //            nop
    Memory[117] <= 32'h00000000;    //            nop
    Memory[118] <= 32'h00000000;    //            nop
    Memory[119] <= 32'h00000000;    //            nop
    Memory[120] <= 32'h1e000017;    //            bgtz    $s0, branch3
    Memory[121] <= 32'h00000000;    //            nop
    Memory[122] <= 32'h00000000;    //            nop
    Memory[123] <= 32'h00000000;    //            nop
    Memory[124] <= 32'h00000000;    //            nop
    Memory[125] <= 32'h00000000;    //            nop
    Memory[126] <= 32'h20100001;    //            addi    $s0, $zero, 1
    Memory[127] <= 32'h00000000;    //            nop
    Memory[128] <= 32'h00000000;    //            nop
    Memory[129] <= 32'h00000000;    //            nop
    Memory[130] <= 32'h00000000;    //            nop
    Memory[131] <= 32'h00000000;    //            nop
    Memory[132] <= 32'h1e00000b;    //            bgtz    $s0, branch3
    Memory[133] <= 32'h00000000;    //            nop
    Memory[134] <= 32'h00000000;    //            nop
    Memory[135] <= 32'h00000000;    //            nop
    Memory[136] <= 32'h00000000;    //            nop
    Memory[137] <= 32'h00000000;    //            nop
    Memory[138] <= 32'h0800013e;    //            j    error
    Memory[139] <= 32'h00000000;    //            nop
    Memory[140] <= 32'h00000000;    //            nop
    Memory[141] <= 32'h00000000;    //            nop
    Memory[142] <= 32'h00000000;    //            nop
    Memory[143] <= 32'h00000000;    //            nop
    Memory[144] <= 32'h06000017;    //    branch3:    bltz    $s0, branch4
    Memory[145] <= 32'h00000000;    //            nop
    Memory[146] <= 32'h00000000;    //            nop
    Memory[147] <= 32'h00000000;    //            nop
    Memory[148] <= 32'h00000000;    //            nop
    Memory[149] <= 32'h00000000;    //            nop
    Memory[150] <= 32'h2010ffff;    //            addi    $s0, $zero, -1
    Memory[151] <= 32'h00000000;    //            nop
    Memory[152] <= 32'h00000000;    //            nop
    Memory[153] <= 32'h00000000;    //            nop
    Memory[154] <= 32'h00000000;    //            nop
    Memory[155] <= 32'h00000000;    //            nop
    Memory[156] <= 32'h0600000b;    //            bltz    $s0, branch4
    Memory[157] <= 32'h00000000;    //            nop
    Memory[158] <= 32'h00000000;    //            nop
    Memory[159] <= 32'h00000000;    //            nop
    Memory[160] <= 32'h00000000;    //            nop
    Memory[161] <= 32'h00000000;    //            nop
    Memory[162] <= 32'h0800013e;    //            j    error
    Memory[163] <= 32'h00000000;    //            nop
    Memory[164] <= 32'h00000000;    //            nop
    Memory[165] <= 32'h00000000;    //            nop
    Memory[166] <= 32'h00000000;    //            nop
    Memory[167] <= 32'h00000000;    //            nop
    Memory[168] <= 32'h2011ffff;    //    branch4:    addi    $s1, $zero, -1
    Memory[169] <= 32'h00000000;    //            nop
    Memory[170] <= 32'h00000000;    //            nop
    Memory[171] <= 32'h00000000;    //            nop
    Memory[172] <= 32'h00000000;    //            nop
    Memory[173] <= 32'h00000000;    //            nop
    Memory[174] <= 32'h16110011;    //            bne    $s0, $s1, branch5
    Memory[175] <= 32'h00000000;    //            nop
    Memory[176] <= 32'h00000000;    //            nop
    Memory[177] <= 32'h00000000;    //            nop
    Memory[178] <= 32'h00000000;    //            nop
    Memory[179] <= 32'h00000000;    //            nop
    Memory[180] <= 32'h1600000b;    //            bne    $s0, $zero, branch5
    Memory[181] <= 32'h00000000;    //            nop
    Memory[182] <= 32'h00000000;    //            nop
    Memory[183] <= 32'h00000000;    //            nop
    Memory[184] <= 32'h00000000;    //            nop
    Memory[185] <= 32'h00000000;    //            nop
    Memory[186] <= 32'h0800013e;    //            j    error
    Memory[187] <= 32'h00000000;    //            nop
    Memory[188] <= 32'h00000000;    //            nop
    Memory[189] <= 32'h00000000;    //            nop
    Memory[190] <= 32'h00000000;    //            nop
    Memory[191] <= 32'h00000000;    //            nop
    Memory[192] <= 32'h20100080;    //    branch5:    addi    $s0, $zero, 128
    Memory[193] <= 32'h00000000;    //            nop
    Memory[194] <= 32'h00000000;    //            nop
    Memory[195] <= 32'h00000000;    //            nop
    Memory[196] <= 32'h00000000;    //            nop
    Memory[197] <= 32'h00000000;    //            nop
    Memory[198] <= 32'ha0900000;    //            sb    $s0, 0($a0)
    Memory[199] <= 32'h00000000;    //            nop
    Memory[200] <= 32'h00000000;    //            nop
    Memory[201] <= 32'h00000000;    //            nop
    Memory[202] <= 32'h00000000;    //            nop
    Memory[203] <= 32'h00000000;    //            nop
    Memory[204] <= 32'h80900000;    //            lb    $s0, 0($a0)
    Memory[205] <= 32'h00000000;    //            nop
    Memory[206] <= 32'h00000000;    //            nop
    Memory[207] <= 32'h00000000;    //            nop
    Memory[208] <= 32'h00000000;    //            nop
    Memory[209] <= 32'h00000000;    //            nop
    Memory[210] <= 32'h1a00000b;    //            blez    $s0, branch6 ///idk why it's fetching 0x80 instead of 0xffffff80
    Memory[211] <= 32'h00000000;    //            nop
    Memory[212] <= 32'h00000000;    //            nop
    Memory[213] <= 32'h00000000;    //            nop
    Memory[214] <= 32'h00000000;    //            nop
    Memory[215] <= 32'h00000000;    //            nop
    Memory[216] <= 32'h0800013e;    //            j    error
    Memory[217] <= 32'h00000000;    //            nop
    Memory[218] <= 32'h00000000;    //            nop
    Memory[219] <= 32'h00000000;    //            nop
    Memory[220] <= 32'h00000000;    //            nop
    Memory[221] <= 32'h00000000;    //            nop
    Memory[222] <= 32'h2010ffff;    //    branch6:    addi    $s0, $zero, -1
    Memory[223] <= 32'h00000000;    //            nop
    Memory[224] <= 32'h00000000;    //            nop
    Memory[225] <= 32'h00000000;    //            nop
    Memory[226] <= 32'h00000000;    //            nop
    Memory[227] <= 32'h00000000;    //            nop
    Memory[228] <= 32'ha4900000;    //            sh    $s0, 0($a0)
    Memory[229] <= 32'h00000000;    //            nop
    Memory[230] <= 32'h00000000;    //            nop
    Memory[231] <= 32'h00000000;    //            nop
    Memory[232] <= 32'h00000000;    //            nop
    Memory[233] <= 32'h00000000;    //            nop
    Memory[234] <= 32'h20100000;    //            addi    $s0, $zero, 0
    Memory[235] <= 32'h00000000;    //            nop
    Memory[236] <= 32'h00000000;    //            nop
    Memory[237] <= 32'h00000000;    //            nop
    Memory[238] <= 32'h00000000;    //            nop
    Memory[239] <= 32'h00000000;    //            nop
    Memory[240] <= 32'h84900000;    //            lh    $s0, 0($a0)
    Memory[241] <= 32'h00000000;    //            nop
    Memory[242] <= 32'h00000000;    //            nop
    Memory[243] <= 32'h00000000;    //            nop
    Memory[244] <= 32'h00000000;    //            nop
    Memory[245] <= 32'h00000000;    //            nop
    Memory[246] <= 32'h1a00000b;    //            blez    $s0, branch7
    Memory[247] <= 32'h00000000;    //            nop
    Memory[248] <= 32'h00000000;    //            nop
    Memory[249] <= 32'h00000000;    //            nop
    Memory[250] <= 32'h00000000;    //            nop
    Memory[251] <= 32'h00000000;    //            nop
    Memory[252] <= 32'h0800013e;    //            j    error
    Memory[253] <= 32'h00000000;    //            nop
    Memory[254] <= 32'h00000000;    //            nop
    Memory[255] <= 32'h00000000;    //            nop
    Memory[256] <= 32'h00000000;    //            nop
    Memory[257] <= 32'h00000000;    //            nop
    Memory[258] <= 32'h2010ffff;    //    branch7:    addi    $s0, $zero, -1
    Memory[259] <= 32'h00000000;    //            nop
    Memory[260] <= 32'h00000000;    //            nop
    Memory[261] <= 32'h00000000;    //            nop
    Memory[262] <= 32'h00000000;    //            nop
    Memory[263] <= 32'h00000000;    //            nop
    Memory[264] <= 32'h3c100001;    //            lui    $s0, 1
    Memory[265] <= 32'h00000000;    //            nop
    Memory[266] <= 32'h00000000;    //            nop
    Memory[267] <= 32'h00000000;    //            nop
    Memory[268] <= 32'h00000000;    //            nop
    Memory[269] <= 32'h00000000;    //            nop
    Memory[270] <= 32'h0601000b;    //            bgez    $s0, branch8
    Memory[271] <= 32'h00000000;    //            nop
    Memory[272] <= 32'h00000000;    //            nop
    Memory[273] <= 32'h00000000;    //            nop
    Memory[274] <= 32'h00000000;    //            nop
    Memory[275] <= 32'h00000000;    //            nop
    Memory[276] <= 32'h0800013e;    //            j    error
    Memory[277] <= 32'h00000000;    //            nop
    Memory[278] <= 32'h00000000;    //            nop
    Memory[279] <= 32'h00000000;    //            nop
    Memory[280] <= 32'h00000000;    //            nop
    Memory[281] <= 32'h00000000;    //            nop
    Memory[282] <= 32'h08000126;    //    branch8:    j    jump1
    Memory[283] <= 32'h00000000;    //            nop
    Memory[284] <= 32'h00000000;    //            nop
    Memory[285] <= 32'h00000000;    //            nop
    Memory[286] <= 32'h00000000;    //            nop
    Memory[287] <= 32'h00000000;    //            nop
    Memory[288] <= 32'h2210fffe;    //            addi    $s0, $s0, -2
    Memory[289] <= 32'h00000000;    //            nop
    Memory[290] <= 32'h00000000;    //            nop
    Memory[291] <= 32'h00000000;    //            nop
    Memory[292] <= 32'h00000000;    //            nop
    Memory[293] <= 32'h00000000;    //            nop
    Memory[294] <= 32'h0c000132;    //    jump1:        jal    jal1
    Memory[295] <= 32'h00000000;    //            nop
    Memory[296] <= 32'h00000000;    //            nop
    Memory[297] <= 32'h00000000;    //            nop
    Memory[298] <= 32'h00000000;    //            nop
    Memory[299] <= 32'h00000000;    //            nop
    Memory[300] <= 32'h08000018;    //            j    start
    Memory[301] <= 32'h00000000;    //            nop
    Memory[302] <= 32'h00000000;    //            nop
    Memory[303] <= 32'h00000000;    //            nop
    Memory[304] <= 32'h00000000;    //            nop
    Memory[305] <= 32'h00000000;    //            nop
    Memory[306] <= 32'h03e00008;    //    jal1:   nop     //jr    $ra
    Memory[307] <= 32'h00000000;    //            nop
    Memory[308] <= 32'h00000000;    //            nop
    Memory[309] <= 32'h00000000;    //            nop
    Memory[310] <= 32'h00000000;    //            nop
    Memory[311] <= 32'h00000000;    //            nop
    Memory[312] <= 32'h0800013e;    //            j    error
    Memory[313] <= 32'h00000000;    //            nop
    Memory[314] <= 32'h00000000;    //            nop
    Memory[315] <= 32'h00000000;    //            nop
    Memory[316] <= 32'h00000000;    //            nop
    Memory[317] <= 32'h00000000;    //            nop
    Memory[318] <= 32'h00000008;    //    error:        jr    $zero
    Memory[319] <= 32'h00000000;    //            nop
    Memory[320] <= 32'h00000000;    //            nop
    Memory[321] <= 32'h00000000;    //            nop
    Memory[322] <= 32'h00000000;    //            nop
    Memory[323] <= 32'h00000000;    //            nop
    Memory[324] <= 32'h3402000a;    //            ori    $v0, $zero, 10
    Memory[325] <= 32'h00000000;    //            nop
    Memory[326] <= 32'h00000000;    //            nop
    Memory[327] <= 32'h00000000;    //            nop
    Memory[328] <= 32'h00000000;    //            nop
    Memory[329] <= 32'h00000000;    //            nop
    Memory[330] <= 32'h00000000;    //            nop
    Memory[331] <= 32'h00000000;    //            nop
    Memory[332] <= 32'h00000000;    //            nop
    Memory[333] <= 32'h00000000;    //            nop
    Memory[334] <= 32'h00000000;    //            nop
    Memory[335] <= 32'h00000000;    //            nop

    end
    /* Please fill in the implementation here */
    always @(Address)begin

    Instruction = Memory[Address[31:2]];
    //end
    end

endmodule
