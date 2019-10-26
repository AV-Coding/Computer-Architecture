module EX_MEM_Register(Clock, MemWriteIn, MemReadIn, BranchIn, MemToRegIn, RegWriteIn, WriteRegisterIn, ALUResultIn, 
                              MemWriteOut, MemReadOut, BranchOut, MemToRegOut, RegWriteOut, WriteRegisterOut, ALUResultOut);
input Clock, RegWriteIn, MemWriteIn, MemReadIn, BranchIn, MemToRegIn;
input [31:0] WriteRegisterIn;
input [31:0] ALUResultIn;

/*reg [31:0] WriteRegister;
reg [31:0] ALUResult;
reg RegWrite;*/

output reg [31:0] WriteRegisterOut;
output reg [31:0] ALUResultOut;
output reg RegWriteOut, MemWriteOut, MemReadOut, BranchOut, MemToRegOut;

always @(posedge Clock)
    begin
    WriteRegisterOut <= WriteRegisterIn;
    ALUResultOut <= ALUResultIn;
    RegWriteOut <= RegWriteIn;
    MemWriteOut <= MemWriteIn;
    MemReadOut <= MemReadIn;
    BranchOut <= BranchIn;
    MemToRegOut <= MemToRegIn;
    end

/*always @(negedge Clock)
    begin
    WriteRegisterOut = WriteRegister;
    ALUResultOut = ALUResult;
    RegWriteOut = RegWrite;
    end*/

endmodule