module ID_EX_Register(Clk, ID_EX_Signal, JumpReturnSignalIn, jal_signalIn, PCAdder_MuxSignalIn, InstructionIn, RegWriteIn, ReadData1In, ReadData2In, SignExtendOutIn, ALUInstructionIn, PCResultIn, InputA_MuxSignalIn, InputB_MuxSignalIn, RegDstIn, MemWriteIn, MemReadIn, BranchIn, MemToRegIn,
                          EX_JumpReturnSignal, EX_jal_signal, EX_PCAdder_MuxSignal, EX_Instruction, EX_RegWrite, EX_ReadData1, EX_ReadData2, EX_SignExtendOut, EX_ALUInstruction, EX_PCResult, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_RegDst, EX_MemWrite, EX_MemRead, EX_Branch, EX_MemToReg);
input Clk, RegWriteIn, InputA_MuxSignalIn, InputB_MuxSignalIn, BranchIn, MemToRegIn, PCAdder_MuxSignalIn, jal_signalIn, JumpReturnSignalIn, ID_EX_Signal;
input [1:0] MemWriteIn, MemReadIn;
input [31:0] ReadData1In;
input [31:0] ReadData2In;
input [31:0] SignExtendOutIn;
input [5:0] ALUInstructionIn;
input [31:0] PCResultIn;
input [31:0] InstructionIn;
input [31:0] RegDstIn;

output reg EX_RegWrite, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_Branch, EX_MemToReg, EX_PCAdder_MuxSignal, EX_jal_signal, EX_JumpReturnSignal; //convert EX_AluSRC to exALU_Inputbs
output reg [31:0] EX_ReadData1;
output reg [1:0] EX_MemWrite, EX_MemRead;
output reg [31:0] EX_ReadData2;
output reg [31:0] EX_SignExtendOut;
output reg [5:0] EX_ALUInstruction;
output reg [31:0] EX_PCResult;
output reg [31:0] EX_Instruction;
output reg [31:0] EX_RegDst;

always @(posedge Clk)
    if(ID_EX_Signal==1)begin
    EX_RegWrite = 0;
    EX_ReadData1 =0;
    EX_ReadData2 = 0;
    EX_SignExtendOut = 0;
    EX_ALUInstruction = 0;
    EX_PCResult = 0;
    EX_InputA_MuxSignal = 0;
    EX_InputB_MuxSignal = 0;
    EX_RegDst = 0;
    EX_Instruction= 0;
    EX_MemRead= 0;
    EX_Branch = 0;
    EX_MemToReg = 1;
    EX_MemWrite = 0;
    EX_PCAdder_MuxSignal =0;
    EX_jal_signal = 0;
    EX_JumpReturnSignal = 0;
    end
    else begin
    EX_RegWrite = RegWriteIn;
    EX_ReadData1 = ReadData1In;
    EX_ReadData2 = ReadData2In;
    EX_SignExtendOut = SignExtendOutIn;
    EX_ALUInstruction = ALUInstructionIn;
    EX_PCResult = PCResultIn;
    EX_InputA_MuxSignal = InputA_MuxSignalIn;
    EX_InputB_MuxSignal = InputB_MuxSignalIn;
    EX_RegDst = RegDstIn;
    EX_Instruction = InstructionIn;
    EX_MemRead = MemReadIn;
    EX_Branch = BranchIn;
    EX_MemToReg = MemToRegIn;
    EX_MemWrite =MemWriteIn;
    EX_PCAdder_MuxSignal = PCAdder_MuxSignalIn;
    EX_jal_signal = jal_signalIn;
    EX_JumpReturnSignal = JumpReturnSignalIn;
    end                
endmodule