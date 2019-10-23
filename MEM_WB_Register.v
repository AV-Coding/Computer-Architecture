module MEM_WB_Register(Clock, RegWriteIn, WriteRegisterIn, ALUResultIn,
                              RegWriteOut, WriteRegisterOut, ALUResultOut);
input Clock, RegWriteIn;
input [31:0] WriteRegisterIn;
input [31:0] ALUResultIn;

reg [31:0] WriteRegister;
reg [31:0] ALUResult;
reg RegWrite;

output reg [31:0] WriteRegisterOut;
output reg [31:0] ALUResultOut;
output reg RegWriteOut;

always @(posedge Clock)
    begin
    WriteRegister <= WriteRegisterIn;
    ALUResult <= ALUResultIn;
    RegWrite <= RegWriteIn;
    end

always @(negedge Clock)
    begin
    WriteRegisterOut = WriteRegister;
    ALUResultOut = ALUResult;
    RegWriteOut = RegWrite;
    end

endmodule