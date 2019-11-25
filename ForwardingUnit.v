`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2018 08:19:45 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(RegisterDestination, Instruction, MEM_RegisterRd, MEM_RegisterWrite, WB_RegisterRd, WB_RegisterWrite, InputAMuxSignal, InputBMuxSignal);
input [31:0] RegisterDestination;
input [31:0]Instruction;
input [31:0]MEM_RegisterRd;
input [31:0]WB_RegisterRd;
input MEM_RegisterWrite, WB_RegisterWrite;
output reg [1:0] InputAMuxSignal, InputBMuxSignal;
reg [31:0]EX_Rt; // Bits 20-16
reg [31:0]EX_Rs; // Bits 25-21
reg [5:0]Opcode;
reg [5:0]Function;

always @(*)begin
EX_Rt <= Instruction[20:16];
EX_Rs <= Instruction[25:21];
Opcode <= Instruction[31:26];
Function <= Instruction[5:0];

/*Checks if rs regsiter rs equal to register desination in Memory stage*/
if(((EX_Rs == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && ((EX_Rt == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    InputAMuxSignal <= 'b01;
    InputBMuxSignal <= 'b10;
end
else if(((EX_Rs == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && !((EX_Rt == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    InputAMuxSignal <= 'b01;
    InputBMuxSignal <='b00;
end
else if(!((EX_Rs == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && ((EX_Rt == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    if(RegisterDestination == WB_RegisterRd)begin // May need to check if RegWrite == 1, What would happen with a lw, or sw in this situation
    InputAMuxSignal <= 'b00;
    InputBMuxSignal <='b00;
    end
    else begin
    InputAMuxSignal <= 'b00;
    InputBMuxSignal <='b10;
    end
end
/***/
else if(((EX_Rt == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && ((EX_Rs == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    InputAMuxSignal <='b10;
    InputBMuxSignal <='b01;
end
else if(((EX_Rt == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && !((EX_Rs == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    if(RegisterDestination == MEM_RegisterRd)begin // May need to check if RegWrite == 1, What would happen with a lw, or sw in this situation
    InputAMuxSignal <= 'b00;
    InputBMuxSignal <='b00;
    end
    else begin
    InputAMuxSignal <='b00;
    InputBMuxSignal <='b01;
    end
end
else if(!((EX_Rt == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && ((EX_Rs == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    InputAMuxSignal <='b10;
    InputBMuxSignal <='b00;
end
/**/
else begin
    InputAMuxSignal <= 'b00;
    InputBMuxSignal <= 'b00;
end

end

endmodule
