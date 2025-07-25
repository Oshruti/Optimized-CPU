`timescale 1ns/1ps

/*
    Module: IF/ID Pipeline Regsiter
*/

module IF_ID(
    input clk;
    input reset;
    input [63:0] PCPlus4In,
    input [31:0] InstructionIn,
    output reg [63:0] PCPlus4Out,
    output reg [31:0] InstructionOut
);

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            InstructionOut <= 32'b0;
            PCPlus4Out <= 64'b0;
        end else begin
            InstructionOut <= InstructionIn;
            PCPlus4Out <= PCPlus4In;
        end
    end
endmodule
