`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUInstruction, ALUhi, ALUlo, A, B, ALUResult, ALUResult2);

	input [4:0] ALUInstruction; // control bits for ALU operation
	input [31:0] A, B;
	input [31:0] ALUlo;
	input [31:0] ALUhi;
	output reg [63:0] ALUResult;	// answer
	reg [31:0] tempReg;
    reg [63:0] tempreg2;
    reg [63:0] ALUResultTemp1;    // answer
    //input [31:0] A, B, ALUlo, ALUhi;
    reg [31:0] ALUResultTemp2;
    output reg [63:0] ALUResult2;  
	//Start of Arithmetic Controls//
    always @(/*ALUhi, ALUlo, A, B, ALUInstruction*/*)
        case (ALUInstruction)
        
        //ADD,ADDI
        'b00000:                            
        begin
        ALUResult = A+B;
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //SUB
        'b00001:
        begin
        ALUResult= A-B;    
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //AND (This is a bitwise AND)
        'b00010:
        begin
        ALUResult=A&B;
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //OR (This is a bitwise OR)
        'b00011:
        begin
        ALUResult=A|B;
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //NOR (This is a bitwise NOR)
        'b00100:
        begin
        tempReg = A|B;
        ALUResult= ~tempReg;
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //XOR (This is a bitwise XOR)
        'b00101:
        begin
        ALUResult=A^B;
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //SEH
        'b00110:
        begin
        ALUResult= {{16{B[15]}}, B[15:0]}; // I think this works, but i'm not sure, will have to test.
        ALUResult2 = {ALUhi, ALUlo};
        end
      
   		//SLL
        'b00111: //7
        begin
        ALUResult=B<<A;
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //SRL
        'b01000: //8
        begin
        ALUResult=B>>A;
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //SLT #ask
        'b01001: //9
        begin
        if($signed(A)<$signed(B))begin
        ALUResult<=1;
        ALUResult2 = {ALUhi, ALUlo};
        end
        else begin
        ALUResult<=0;
        ALUResult2 = {ALUhi, ALUlo};
        end
        end
        
        //MOVN
        'b01010: //10
        begin
        if(B != 'h00 )begin
            ALUResult = A;
            ALUResult2 = {ALUhi, ALUlo};
        end 
        else begin
            /*This else statement should be switched to send out the value of register rd since, if B is equal to 0, it will remain the same.
            ALUResult2 = {ALUhi, ALUlo};*/
            ALUResult2 = {ALUhi, ALUlo};
        end
        end
        
        //MOVZ
        'b01011: //11
        begin
        if(B=='h00)begin
            ALUResult = A;
            ALUResult2 = {ALUhi, ALUlo};
        end 
        else begin    
            /*This else statement should be switched to send out the value of register rd since, if B is not equal to 0, it will remain the same.
            ALUResult2 = {ALUhi, ALUlo};*/
            ALUResult2 = {ALUhi, ALUlo};
        end           
        end
        
        //ROTRV,ROTR
        'b01100: //12
        begin
        tempReg = (B>>A);
        ALUResultTemp2 = B<<(32-A);
        ALUResult = ALUResultTemp2|tempReg;
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //SRA
        'b01101: //13
        begin
        if(B[31]==1)
        begin
        ALUResultTemp2 = B >>> A; 
        ALUResult=ALUResultTemp2;
        ALUResult2 = {ALUhi, ALUlo};
        end
        else
        begin
        ALUResultTemp2 = B >> A; 
        ALUResult=ALUResultTemp2;
        ALUResult2 = {ALUhi, ALUlo};
        end
        end
        
        //SRAV
        'b01110: //14
        begin
        ALUResult = B>>>A;
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //SEB
        'b01111: //15
        begin
        ALUResult = {{24{B[7]}}, B[7:0]};
        ALUResult2 = {ALUhi, ALUlo};
        end 
        
        //SLTIU
        'b10000: //16
        begin
        if($unsigned(A) < $unsigned(B))
        begin
        ALUResult = 1;
        ALUResult2 = {ALUhi, ALUlo};
        end
        else
        begin
        ALUResult = 0;
        ALUResult2 = {ALUhi, ALUlo};
        end
        end
        
        //SLTU
        'b10001: //17
        begin
        if($unsigned(A) < $unsigned(B))
        begin
        ALUResult = 1;
        ALUResult2 = {ALUhi, ALUlo};
        end
        else
        begin
        ALUResult = 0;
        ALUResult2 = {ALUhi, ALUlo};
        end
        end
        
        //MUL
        'b10010: //18
        begin
        ALUResult = A * B;
        ALUResult2 = {ALUhi, ALUlo};
        end  

        //MULTU
        'b10011: //19
         begin
         ALUResult2 = $unsigned(A)*$unsigned(B);
        end
        
        //MADD
        'b10100: //20
        begin
        tempreg2 = {ALUhi, ALUlo};
        ALUResultTemp1 = $signed(tempreg2) + $signed(A)*$signed(B);
        ALUResult2=ALUResultTemp1;
        //ALUResult2 = {ALUhi, ALUlo} + $signed(A)*$signed(B);
        end
        
        //MSUB
        'b10101: //21
        begin
        //tempreg2 = {ALUhi, ALUlo};
        //ALUResultTemp1 = tempreg2 - $signed(A)*$signed(B);
        //ALUResult=ALUResultTemp1;
        
        ALUResult2 = $signed({ALUhi, ALUlo}) - $signed(A)*$signed(B);
        end 
        
        //MULT
        'b10110: //22
        begin
        ALUResult2 = $signed(A)*$signed(B);
        end  
        
        //ADDU, ADDIU
        'b10111:
        begin
        ALUResult = $unsigned(A) + $unsigned(B);
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //MFHI
        'b11011: //23
        begin
        ALUResult = ALUhi;
       // ALUResult = 64'h12;
        ALUResult2 = {ALUhi, ALUlo};
        end  
        
        //MFLO
        'b11000: //24
        begin
        ALUResult = ALUlo;
        ALUResult2 = {ALUhi, ALUlo};
        end  
        
        //MTHI
        'b11001: //25
        begin
        ALUResult2 = {A, ALUlo};
        end  
        
        //MTLO
        'b11010: //26
        begin
        ALUResult2 = {ALUhi, A};
        end 
        
        endcase
endmodule

