module EX_MEM_Register(Clock, ReadData2In, PCAddResultIn, MemWriteIn, MemReadIn, BranchIn, MemToRegIn, RegWriteIn, WriteRegisterIn, ALUResultIn, ZeroIn, 
                              ReadData2Out, PCAddResultOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut, RegWriteOut, WriteRegisterOut, ALUResultOut, ZeroOut);

input Clock, RegWriteIn, BranchIn, MemToRegIn, ZeroIn;
input [1:0] MemWriteIn, MemReadIn;
input [31:0] WriteRegisterIn;
input [31:0] ALUResultIn;
input [31:0] PCAddResultIn, ReadData2In;

output reg [1:0] MemWriteOut, MemReadOut;
output reg [31:0] WriteRegisterOut;
output reg [31:0] ALUResultOut;
output reg [31:0] PCAddResultOut, ReadData2Out;
output reg RegWriteOut, BranchOut, MemToRegOut, ZeroOut;

always @(posedge Clock)
    begin
    WriteRegisterOut <= WriteRegisterIn;
    ALUResultOut <= ALUResultIn;
    RegWriteOut <= RegWriteIn;
    MemWriteOut <= MemWriteIn;
    MemReadOut <= MemReadIn;
    BranchOut <= BranchIn;
    MemToRegOut <= MemToRegIn;
    ZeroOut <= ZeroIn;
    PCAddResultOut <= PCAddResultIn;
    ReadData2Out <= ReadData2In;
    end

/*always @(negedge Clock)
    begin
    WriteRegisterOut = WriteRegister;
    ALUResultOut = ALUResult;
    RegWriteOut = RegWrite;
    end*/

endmodule