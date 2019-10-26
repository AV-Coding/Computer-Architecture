`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Ariel Villasenor: 50%
// Ajay Katoch: 50%
// Create Date: 
// Design Name: 
// Module Name: top
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
module top(Clk, Reset, PCResult, MEMWB_ALUResult, ALUhi, ALUlo);
    input Clk, Reset;
    //wire ClkOut;
    output wire [31:0] MEMWB_ALUResult;
    wire [31:0] EX_Instruction;
    wire [63:0] ALUResult;
    wire [63:0] ALUResult2;
    wire [31:0] ALUInputA;
    wire [31:0] ALUInputB;
    
    /*Instruction Fetch Unit Stage Wires*/
    output wire [31:0] PCResult;
    wire [31:0] PCAddResult;
    wire [31:0] Instruction;
    
    /*Instrucion Decode Stage Wires*/
    wire [31:0] ID_Instruction;
    wire [31:0] ID_PCResult;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] SignExtendOut;
    wire [31:0] ArithmeticSignExtendOut;
    wire [31:0] LogicalSignExtendOut;
    //wire [31:0] DelayID_Instruction;
    //wire [31:0] DelayID_PCResult;
    wire [4:0] ALUInstruction;
    wire RegWrite, RegDst, InputA_MuxSignal, InputB_MuxSignal, SignExtendSignal, MemWrite, MemRead, Branch, MemToReg;
    
    /*Execution Stage Wires*/
    wire [31:0] EX_ReadData1;
    wire [31:0] EX_ReadData2;
    wire [31:0] EX_SignExtendOut;
    wire [31:0] EX_PCResult;
    output wire [31:0] ALUlo;
    output wire [31:0] ALUhi;
    wire [4:0] EX_ALUInstruction;
    wire EX_RegWrite, EX_RegDst, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_MemWrite, EX_MemRead, EX_Branch, EX_MemToReg;
    wire [31:0] ShiftAmount;
    wire [31:0] WriteRegister;
    
    /*Memory Access Stage Wires*/
    wire [31:0] MEM_WriteRegister;
    wire [31:0] MEM_ALUResult;
    wire MEM_RegWrite, MEM_MemWrite, MEM_MemRead, MEM_Branch, MEM_MemToReg;
    wire [31:0] DataMemoryOut;
    
    /*Memory Write Back Stage*/
    wire [31:0] MEMWB_WriteRegister, MEMWB_DataResult, MEMWB_DataMemoryOut;
    wire MEMWB_RegWrite, MEMWB_MemToReg;
    
    //output [6:0] out7;
    //output [7:0] en_out;
    
    /* Start of Instruction Fetch Stage*/
    PCAdder PCAdder_1(PCResult, PCAddResult);
    
    //ClkDiv ClkDiv_1(Clk, 0, ClkOut);
        
    ProgramCounter ProgramCounter_1(PCAddResult, Reset, Clk, PCResult);
        
    InstructionMemory InstructionMemory_1(PCResult, Instruction);
  
    IF_ID_Register Instruction_Fetch_Decode_Register(Clk, Instruction, PCAddResult, ID_Instruction, ID_PCResult);
    /* End of Instruction Fetch Stage*/
    
    /* Decode Stage*/  
    
    //Register32Bit Register32Bit_1(Clk, ID_Instruction, DelayID_Instruction);
    
    RegisterFile RegisterFile_1( Clk, ID_Instruction[25:21], ID_Instruction[20:16], MEMWB_WriteRegister, MEMWB_DataResult, MEMWB_RegWrite, ReadData1, ReadData2); 
    
    SignExtension SignExtension_1(ID_Instruction[15:0], ArithmeticSignExtendOut);
    
    //Register32Bit Register32Bit_2(Clk, ID_PCResult, DelayID_PCResult);
    
    immediate_signExtension immediate_signExtension_1(ID_Instruction[15:0], LogicalSignExtendOut);
    
    Mux32Bit2To1 ChooseSignExtend(ArithmeticSignExtendOut, LogicalSignExtendOut, SignExtendSignal, SignExtendOut);
        
    Control Control_1(/*Delay*/ID_Instruction, RegWrite, ALUInstruction, InputA_MuxSignal, InputB_MuxSignal, RegDst, SignExtendSignal, MemWrite, MemRead, Branch, MemToReg);// Add signal for SignExtendSignal 
    
    ID_EX_Register Instruction_Decode_Execute_Register(Clk, ID_Instruction, RegWrite, ReadData1, ReadData2, SignExtendOut, ALUInstruction, ID_PCResult, InputA_MuxSignal, InputB_MuxSignal, RegDst, MemWrite, MemRead, Branch, MemToReg,
                                                           EX_Instruction, EX_RegWrite, EX_ReadData1, EX_ReadData2, EX_SignExtendOut, EX_ALUInstruction, EX_PCResult, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_RegDst, EX_MemWrite, EX_MemRead, EX_Branch, EX_MemToReg);
    /* End of Decode Stage*/
   
    /* Start of Execution Stage*/
    SignExtensionShiftAmount SignExtension_2( EX_Instruction[10:6], ShiftAmount );
    
    Mux32Bit2To1 InputA_Mux( EX_ReadData1, ShiftAmount, EX_InputA_MuxSignal, ALUInputA);
   
    Mux32Bit2To1 InputB_Mux( EX_ReadData2, EX_SignExtendOut, EX_InputB_MuxSignal, ALUInputB);
    
    ALU32Bit ALU32Bit_1(EX_ALUInstruction, ALUhi, ALUlo, ALUInputA, ALUInputB, ALUResult, ALUResult2);
    
    HI_Register HI(Clk, ALUResult2[63:32], ALUhi);
    
    LO_Register LO(Clk, ALUResult2[31:0], ALUlo);
    
    Mux5Bit2To1 Mux5Bit2To1_1(EX_Instruction[20:16], EX_Instruction[15:11], EX_RegDst, WriteRegister ); //Moves this into Execute Stages 
    
    /* End of Execution Stage*/
    
    /* Start of Memory Access Stage */
    
    EX_MEM_Register Execution_Mem_Access_Register(Clk, EX_MemWrite, EX_MemRead, EX_Branch, EX_MemToReg, EX_RegWrite, WriteRegister, ALUResult[31:0], 
                                                      MEM_MemWrite, MEM_MemRead, MEM_Branch, MEM_MemToReg, MEM_RegWrite, MEM_WriteRegister, MEM_ALUResult);
    
    DataMemory DataMemory_1( MEM_MemWrite, MEM_MemRead, DataMemoryOut); // Add "Write Data" to Data Memory
    
    /* End of Memory Access Stage */                                                   
    
    /* Start of Memory Writeback stage */
    
    MEM_WB_Register Memory_Writeback_Register(Clk, MEM_MemToReg, MEM_RegWrite, MEM_WriteRegister, MEM_ALUResult, DataMemoryOut,
                                                   MEMWB_MemToReg, MEMWB_RegWrite, MEMWB_WriteRegister, MEMWB_ALUResult, MEMWB_DataMemoryOut);
                                                   
    Mux32Bit2To1 DataResult_Mux( MEMWB_DataMemoryOut, MEMWB_ALUResult, MEMWB_MemToReg, MEMWB_DataResult);
    
    /* End of Memory Writeback stage */
    
    //InstructionFetchUnit InstructionFetchUnit_1(Reset, ClkOut, Instruction);
    
    //Two4DigitDisplay Two4DigitDisplay(Clk, Instruction[15:0], Instruction[31:16], out7, en_out);
  
endmodule