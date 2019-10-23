`timescale 1ns / 1ps

module Mux32Bit2To1(inA, inB, select, out);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input select;

    always @(select, inA, inB) begin
        if (select == 0) begin
            out <= inA;
        end else begin
            out <= inB;
        end
    end

endmodule
