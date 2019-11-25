module EX_MEM_Register(Clock, ReadData2In, MemWriteIn, MemReadIn, MemToRegIn, RegWriteIn, WriteRegisterIn, ALUResultIn, 
                              ReadData2Out, MemWriteOut, MemReadOut, MemToRegOut, RegWriteOut, WriteRegisterOut, ALUResultOut);

input Clock, RegWriteIn, MemToRegIn;
input [1:0] MemWriteIn, MemReadIn;
input [31:0] WriteRegisterIn;
input [31:0] ALUResultIn;
input [31:0] ReadData2In;

output reg [1:0] MemWriteOut, MemReadOut;
output reg [31:0] WriteRegisterOut;
output reg [31:0] ALUResultOut;
output reg [31:0] ReadData2Out;
output reg RegWriteOut, MemToRegOut;

always @(posedge Clock)
    begin
    WriteRegisterOut <= WriteRegisterIn;
    ALUResultOut <= ALUResultIn;
    RegWriteOut <= RegWriteIn;
    MemWriteOut <= MemWriteIn;
    MemReadOut <= MemReadIn;
    MemToRegOut <= MemToRegIn;
    ReadData2Out <= ReadData2In;
    end

endmodule