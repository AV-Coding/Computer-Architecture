module EX_MEM_Register(Clock, EX_MEM_Signal, InstructionIn, ReadData2In, MemWriteIn, MemReadIn, MemToRegIn, RegWriteIn, WriteRegisterIn, ALUResultIn, 
                                             InstructionOut, ReadData2Out, MemWriteOut, MemReadOut, MemToRegOut, RegWriteOut, WriteRegisterOut, ALUResultOut);

input Clock, RegWriteIn, MemToRegIn, EX_MEM_Signal;
input [1:0] MemWriteIn, MemReadIn;
input [31:0] WriteRegisterIn;
input [31:0] ALUResultIn;
input [31:0] ReadData2In;
input [31:0] InstructionIn;

output reg [1:0] MemWriteOut, MemReadOut;
output reg [31:0] WriteRegisterOut;
output reg [31:0] ALUResultOut;
output reg [31:0] ReadData2Out;
output reg [31:0] InstructionOut;
output reg RegWriteOut, MemToRegOut;

always @(posedge Clock)
    if(EX_MEM_Signal)begin
    WriteRegisterOut = 0;
    ALUResultOut = 0;
    RegWriteOut = 0;
    MemWriteOut = 0;
    MemReadOut = 0;
    MemToRegOut = 1;
    ReadData2Out = 0;
    InstructionOut = 0;
    end
    else begin
    WriteRegisterOut = WriteRegisterIn;
    ALUResultOut = ALUResultIn;
    RegWriteOut = RegWriteIn;
    MemWriteOut = MemWriteIn;
    MemReadOut = MemReadIn;
    MemToRegOut = MemToRegIn;
    ReadData2Out = ReadData2In;
    InstructionOut = InstructionIn;
    end

endmodule