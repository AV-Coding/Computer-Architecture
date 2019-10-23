`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2019 04:02:32 PM
// Design Name: 
// Module Name: Control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Control(Instruction, RegWrite, ALUInstruction, InputA_MuxSignal, InputB_MuxSignal, RegDst, signExtendSignal);
input [31:0] Instruction;
reg [5:0] OpCode;
reg [5:0] Funct;
reg [4:0] Special;
output reg RegDst;
output reg signExtendSignal; //used for signextending 0's in logical xori,ori,andi
output reg [4:0] ALUInstruction;
output reg RegWrite, InputA_MuxSignal, InputB_MuxSignal;

always @(Instruction) begin
	Special=Instruction[10:6]; //check seh
	OpCode= Instruction [31:26];
	Funct=Instruction[5:0];
	//Start of Arithmetic Controls//

    if((OpCode == 'b000000) && (Funct == 'b100000))//ADD 
        begin
        RegWrite = 1;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		ALUInstruction = 'b00000;
		RegDst = 1;
		signExtendSignal=0;
        end
    else if(OpCode == 'b001000)//ADDI 
        begin
        RegWrite = 1;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b00000;
		RegDst = 0;
		signExtendSignal=0;
        end
	else if(OpCode=='b001001)//ADDIU							
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b10111;
		RegDst = 0;
		signExtendSignal=0;
		end
	else if((OpCode=='b00000)&&(Funct=='b100010))//SUB 
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b00001;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b100100))//AND
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b00010;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if(OpCode=='b001100)//ANDI
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b00010;
        RegDst = 0;
        signExtendSignal=1;
		end
	else if((OpCode=='b000000)&&(Funct=='b100101))//OR
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b00011;
        RegDst = 1;
        signExtendSignal=0;
		end
	else if(OpCode=='b001101)//ORI
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b00011;
		RegDst = 0;
		signExtendSignal=1;
		end
	else if((OpCode=='b000000)&&(Funct=='b100111))//NOR
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b00100;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b100110))//XOR
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b00101;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if(OpCode=='b001110)//XORI
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b00101;
		RegDst = 0;
		signExtendSignal=1;
		end
	else if((OpCode=='b011111)&&(Special=='b11000)&&(Funct=='b100000))//SEH
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b00110;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000000))//SLL #ask
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b00111;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000010) && (Instruction[21]=='b0))//SRL #ask
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b01000;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000100))//SLLV #ask
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b00111;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000110) && (Instruction[6] == 'b0))//SRLV #ask
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b01000;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b101010))//SLT
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b01001;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if(OpCode=='b001010)//SLTI
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b01001;
		RegDst = 0;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b001011))//MOVN
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b01010;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b001010))//MOVZ
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b01011;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000110) && (Instruction[6] == 'b1))//ROTRV
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b01100;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000010)&&(Instruction[21]=='b1))//ROTR
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b01100;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000011))//SRA
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b01101;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000111))//SRAV
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b01110;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b011111)&&(Funct=='b100000)&&(Special=='b10000))//SEB
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b01111;
		RegDst = 1;
		signExtendSignal=0;
		end	
	else if(OpCode=='b001011)//SLTIU
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b10000;
		RegDst = 0;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b101011))//SLTU
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b10001;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b011100)&&(Funct=='b000010))//MUL
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b10010;
		RegDst = 1;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b011001))//MULTU
		begin
		RegWrite=0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b10011;
		RegDst = 0;
		signExtendSignal=0;
		end
	else if((OpCode=='b011100)&&(Funct=='b000000))//MADD
		begin
		RegWrite=0;
		RegDst = 0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b10100;
		signExtendSignal=0;
		end
	else if((OpCode=='b011100)&&(Funct=='b000100))//MSUB
		begin
		RegWrite=0;
		RegDst = 0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b10101;
		signExtendSignal=0;
		end
	else if((OpCode=='b000000)&&(Funct=='b011000))//MULT
		begin
		RegWrite=0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b10110;
		RegDst = 0;
		signExtendSignal=0;
		end
    else if((OpCode=='b000000)&&(Funct=='b100001))//ADDU
        begin
        RegWrite=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction = 'b10111;
        RegDst = 0;
        signExtendSignal=0;
        end
	else if((OpCode=='b000000)&&(Funct=='b010000))//MFHI
        begin
        RegWrite=1;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b11011;
        signExtendSignal=0;
        end
    else if((OpCode=='b000000)&&(Funct=='b010010))//MFLO
        begin
        RegWrite=1;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b11000;
        signExtendSignal=0;
        end
    else if((OpCode=='b000000)&&(Funct=='b010001))//MTHI
        begin
        RegWrite=0;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b11001;
        signExtendSignal=0;
        end
    else if((OpCode=='b000000)&&(Funct=='b010011))//MTLO
        begin
        RegWrite=0;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b11010;
        signExtendSignal=0;
        end
	
	end
endmodule
