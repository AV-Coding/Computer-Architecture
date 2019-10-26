module MEM_WB_Register(Clock, MemToRegIn, RegWriteIn, WriteRegisterIn, ALUResultIn, DataMemoryIn,
                              MemToRegOut, RegWriteOut, WriteRegisterOut, ALUResultOut, DataMemoryOut);
input Clock, RegWriteIn, MemToRegIn;
input [31:0] WriteRegisterIn;
input [31:0] ALUResultIn;
input [31:0] DataMemoryIn;

/*reg [31:0] WriteRegister;
reg [31:0] ALUResult;
reg RegWrite;*/

output reg [31:0] WriteRegisterOut;
output reg [31:0] ALUResultOut;
output reg [31:0] DataMemoryOut;
output reg RegWriteOut, MemToRegOut;

always @(posedge Clock)
    begin
    WriteRegisterOut <= WriteRegisterIn;
    ALUResultOut <= ALUResultIn;
    RegWriteOut <= RegWriteIn;
    MemToRegOut <= MemToRegIn;
    DataMemoryOut <= DataMemoryIn;
    end

/*always @(negedge Clock)
    begin
    WriteRegisterOut = WriteRegister;
    ALUResultOut = ALUResult;
    RegWriteOut = RegWrite;
    end*/

endmodule