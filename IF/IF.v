`timescale 1ns/1ps

/*
    Module: Instruction Fetch (IF) Stage top file
    - Keeps track of current PC
    - Fetches instruction from Instruction Memory
    - Computes NextPC based on the opcode
*/

module IF_stage(
    input clk,
    input reset,
    input [63:0] SignExtImm64, 
    input 	Branch, 
    input ALUZero, 
    input Uncondbranch, 
    output [63:0] PC_reg; 
    output [63:0] PCplus4;
    output [31:0] instruction
);

    reg [63:0] PC;
    wire [63:0] NextPC;

    assign PC_reg = PC;
    assign PCplus4 = PC + 64'b100;

    InstructionMemory imem(
		.Data(instruction),
		.Address(PC)
	);

    NextPClogic PClogic(
        .NextPC(NextPC),
        .CurrentPC(PC),
        .SignExtImm64(SignExtImm64),
        .Branch(Branch),
        .ALUZero(zero),
        .Uncondbranch(Uncondbranch)
	);

    always @(posedge clk or posedge reset) begin
        if (reset)
            PC_reg <= 64'b0;
        else
            PC_reg <= NextPC;
    end

endmodule

