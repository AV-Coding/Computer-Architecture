module ID_EX_Register(Clk, JumpReturnSignalIn, jal_signalIn, PCAdder_MuxSignalIn, InstructionIn, RegWriteIn, ReadData1In, ReadData2In, SignExtendOutIn, ALUInstructionIn, PCResultIn, InputA_MuxSignalIn, InputB_MuxSignalIn, RegDstIn, MemWriteIn, MemReadIn, BranchIn, MemToRegIn,
                          EX_JumpReturnSignal, EX_jal_signal, EX_PCAdder_MuxSignal, EX_Instruction, EX_RegWrite, EX_ReadData1, EX_ReadData2, EX_SignExtendOut, EX_ALUInstruction, EX_PCResult, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_RegDst, EX_MemWrite, EX_MemRead, EX_Branch, EX_MemToReg);
input Clk, RegWriteIn, RegDstIn, InputA_MuxSignalIn, InputB_MuxSignalIn, BranchIn, MemToRegIn, PCAdder_MuxSignalIn, jal_signalIn, JumpReturnSignalIn;
input [1:0] MemWriteIn, MemReadIn;
input [31:0] ReadData1In;
input [31:0] ReadData2In;
input [31:0] SignExtendOutIn;
input [5:0] ALUInstructionIn;
input [31:0] PCResultIn;
input [31:0] InstructionIn;

/*reg RegWrite, RegDst, InputA_MuxSignal, InputB_MuxSignal; 
reg [31:0] ReadData1;
reg [31:0] ReadData2;
reg [31:0] SignExtendOut;
reg [4:0] ALUInstruction;
reg [31:0] PCResult;
reg [31:0] Instruction;*/

output reg EX_RegWrite, EX_RegDst, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_Branch, EX_MemToReg, EX_PCAdder_MuxSignal, EX_jal_signal, EX_JumpReturnSignal; //convert EX_AluSRC to exALU_Inputbs
output reg [31:0] EX_ReadData1;
output reg [1:0] EX_MemWrite, EX_MemRead;
output reg [31:0] EX_ReadData2;
output reg [31:0] EX_SignExtendOut;
output reg [5:0] EX_ALUInstruction;
output reg [31:0] EX_PCResult;
output reg [31:0] EX_Instruction;

always @(posedge Clk)
    begin
    EX_RegWrite <= RegWriteIn;
    EX_ReadData1 <= ReadData1In;
    EX_ReadData2 <= ReadData2In;
    EX_SignExtendOut <= SignExtendOutIn;
    EX_ALUInstruction <= ALUInstructionIn;
    EX_PCResult <= PCResultIn;
    EX_InputA_MuxSignal <= InputA_MuxSignalIn;
    EX_InputB_MuxSignal <= InputB_MuxSignalIn;
    EX_RegDst <= RegDstIn;
    EX_Instruction <= InstructionIn;
    EX_MemRead <= MemReadIn;
    EX_Branch <= BranchIn;
    EX_MemToReg <= MemToRegIn;
    EX_MemWrite <=MemWriteIn;
    EX_PCAdder_MuxSignal <= PCAdder_MuxSignalIn;
    EX_jal_signal <= jal_signalIn;
    EX_JumpReturnSignal <= JumpReturnSignalIn;
    end
/*always @(negedge Clk)
    begin
    EX_RegWrite = RegWrite;
    EX_ReadData1 = ReadData1;
    EX_ReadData2 = ReadData2;
    EX_SignExtendOut = SignExtendOut;
    EX_ALUInstruction = ALUInstruction;
    EX_PCResult = PCResult;
    EX_InputA_MuxSignal = InputA_MuxSignal;
    EX_InputB_MuxSignal = InputB_MuxSignal;
    EX_RegDst = RegDst;
    EX_Instruction = Instruction;
    end
*/
                       
endmodule