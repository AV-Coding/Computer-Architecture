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


module Control(Instruction, RegWrite, ALUInstruction, InputA_MuxSignal, InputB_MuxSignal, RegDst, signExtendSignal, MemWrite, MemRead, Branch, MemToReg);
input [31:0] Instruction;
reg [5:0] OpCode;
reg [5:0] Funct;
reg [4:0] Special;
output reg RegDst, MemWrite, MemRead, Branch, MemToReg;
output reg signExtendSignal; //used for signextending 0's in logical xori,ori,andi
output reg [4:0] ALUInstruction;
output reg RegWrite, InputA_MuxSignal, InputB_MuxSignal;

always @(Instruction) begin
	Special=Instruction[10:6]; //check seh
	OpCode= Instruction [31:26];
	Funct=Instruction[5:0];
	
	/* Start of Arithmetic, Logical and HI/LO */
    if((OpCode == 'b000000) && (Funct == 'b100000))//ADD 
        begin
        RegWrite = 1;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		ALUInstruction = 'b000000;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
        end
    else if(OpCode == 'b001000)//ADDI 
        begin
        RegWrite = 1;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b000000;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
        end
	else if(OpCode=='b001001)//ADDIU							
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b010111;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b00000)&&(Funct=='b100010))//SUB 
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000001;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b100100))//AND
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000010;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if(OpCode=='b001100)//ANDI
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b000010;
        RegDst = 0;
        signExtendSignal=1;
        MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b100101))//OR
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000011;
        RegDst = 1;
        signExtendSignal=0;
        MemToReg = 1;
		end
	else if(OpCode=='b001101)//ORI
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b000011;
		RegDst = 0;
		signExtendSignal=1;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b100111))//NOR
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000100;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b100110))//XOR
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000101;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if(OpCode=='b001110)//XORI
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b000101;
		RegDst = 0;
		signExtendSignal=1;
		MemToReg = 1;
		end
	else if((OpCode=='b011111)&&(Special=='b11000)&&(Funct=='b100000))//SEH
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000110;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b000000))//SLL #ask
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b000111;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b000010) && (Instruction[21]=='b0))//SRL #ask
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b001000;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b000100))//SLLV #ask
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000111;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b000110) && (Instruction[6] == 'b0))//SRLV #ask
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001000;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b101010))//SLT
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001001;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if(OpCode=='b001010)//SLTI
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b001001;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b001011))//MOVN
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001010;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b001010))//MOVZ
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001011;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b000110) && (Instruction[6] == 'b1))//ROTRV
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001100;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b000010)&&(Instruction[21]=='b1))//ROTR
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b001100;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b000011))//SRA
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b001101;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b000111))//SRAV
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001110;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b011111)&&(Funct=='b100000)&&(Special=='b10000))//SEB
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001111;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end	
	else if(OpCode=='b001011)//SLTIU
		begin
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b010000;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b101011))//SLTU
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010001;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b011100)&&(Funct=='b000010))//MUL
		begin
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010010;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b011001))//MULTU
		begin
		RegWrite=0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010011;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b011100)&&(Funct=='b000000))//MADD
		begin
		RegWrite=0;
		RegDst = 0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010100;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b011100)&&(Funct=='b000100))//MSUB
		begin
		RegWrite=0;
		RegDst = 0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010101;
		signExtendSignal=0;
		MemToReg = 1;
		end
	else if((OpCode=='b000000)&&(Funct=='b011000))//MULT
		begin
		RegWrite=0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010110;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		end
    else if((OpCode=='b000000)&&(Funct=='b100001))//ADDU
        begin
        RegWrite=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction = 'b010111;
        RegDst = 0;
        signExtendSignal=0;
        MemToReg = 1;
        end
	else if((OpCode=='b000000)&&(Funct=='b010000))//MFHI
        begin
        RegWrite=1;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b011011;
        signExtendSignal=0;
        MemToReg = 1;
        end
    else if((OpCode=='b000000)&&(Funct=='b010010))//MFLO
        begin
        RegWrite=1;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b011000;
        signExtendSignal=0;
        MemToReg = 1;
        end
    else if((OpCode=='b000000)&&(Funct=='b010001))//MTHI
        begin
        RegWrite=0;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b011001;
        signExtendSignal=0;
        MemToReg = 1;
        end
    else if((OpCode=='b000000)&&(Funct=='b010011))//MTLO
        begin
        RegWrite=0;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b011010;
        signExtendSignal=0;
        MemToReg = 1;
        end
        
    /* End of Arithmetic, Logical and HI/LO */
    
    
    /* Start of Data */
    
    else if(OpCode=='b100011)// load word
        begin
        MemRead = 1;
        MemWrite = 0;
        MemToReg = 0;
        
        end
    
    else if(OpCode=='b101011)// store word
        begin
        MemRead = 0;
        MemWrite = 1;
        MemToReg = 1;
        
        end
    else if(OpCode=='b101000)// store byte
        begin
        MemRead = 0;
        MemWrite = 1;
        MemToReg = 1;
        
        end
    else if(OpCode=='b100001)// load half
        begin
        MemRead = 1;
        MemWrite = 0;
        MemToReg = 0;
        
        end
    else if(OpCode=='b100000)// load byte
        begin
        MemRead = 1;
        MemWrite = 0;
        MemToReg = 0;
        
        end
        
    else if(OpCode=='b101001)// store half
        begin
        MemRead = 0;
        MemWrite = 1;
        MemToReg = 1;
        
        end
    
    else if(OpCode=='b001111)// load upper immediate
        begin
        MemRead = 1;
        MemWrite = 0;
        MemToReg = 0;
        
        end
    
    /* End of Data */
    
    /* Start of Branch */
    
    else if((OpCode=='b000001)&&(Instruction[20:16]=='b00001))  // bgez
        begin
        Branch = 1;
        MemToReg = 1;
        end
    
    else if(OpCode=='b000100)   // beq
        begin
        Branch = 1;
        MemToReg = 1;      
        end
    
    else if(OpCode=='b000101)   // bne
        begin
        Branch = 1;
        MemToReg = 1;
        end
    
    else if(OpCode=='b000111)   // bgtz
        begin
        Branch = 1;
        MemToReg = 1;
        end
    else if((OpCode=='b000110)&&(Instruction[20:16]=='b00000))  // blez
        begin
        Branch = 1;
        MemToReg = 1;
        end
 
    else if(OpCode=='b000010)   //j
        begin
        Branch = 1;
        MemToReg = 1;
        end
    
    else if((OpCode=='b000000)&&(Funct=='b001000))  // jr
        begin
        Branch = 1;
        MemToReg = 1;
        end
    
    else if(OpCode=='b000011)   // jal
        begin
        Branch = 1;
        MemToReg = 1;
        end
    
    /* End of Branch */
	
	end
endmodule
