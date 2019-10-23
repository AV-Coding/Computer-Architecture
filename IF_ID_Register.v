`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2019 03:20:25 PM
// Design Name: 
// Module Name: IF_ID_Register
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


module IF_ID_Register(Clock, InstructionIn, PCResultIn, InstructionOut, PCResultOut);
input Clock;
input [31:0] InstructionIn;
input [31:0] PCResultIn;
output reg [31:0] InstructionOut;
output reg [31:0] PCResultOut;
reg [31:0] Instruction;
reg [31:0] PCResult;

always @( posedge Clock)
    begin
    Instruction <= InstructionIn;
    PCResult <= PCResultIn;
    end

always @( negedge Clock)
    begin
    InstructionOut = Instruction;
    PCResultOut = PCResult;
    end
endmodule
