`timescale 1ns/1ps

/*
    ID Stage: Instruction Decode
    - Decodes instruction into control signals
    - Reads register operands
    - Sign-extends immediate
*/

module ID_stage(
    input clk,
    input reset,

    // From IF/ID pipeline register
    input [31:0] instruction,
    input [63:0] PCPlus4Out,

    // Outputs to ID/EX pipeline register
    output [63:0] BusA,
    output [63:0] BusB,
    output [63:0] SignExtImm64,
    output [4:0] Rd,
    output [4:0] Rm,
    output [4:0] Rn,
    output RegWrite,
    output MemRead,
    output MemWrite,
    output MemtoReg,
    output Branch,
    output ALUSrc,
    output Uncondbranch,
    output [1:0] signop,
    output [1:0] ALUOp,
    output [63:0] PCplus4_IDEX
    output reg PCWrite,
    output reg IF_ID_Write,
    output sel

);

    // Extract fields from instruction
    wire [10:0] opcode = instruction[31:21];
    wire [4:0]  Rn_in = instruction[20:16];
    wire [4:0]  Rm_in = instruction[9:5];
    wire [4:0]  Rd_in = instruction[4:0];

    // Control Unit
    control control(
		   .reg2loc(reg2loc),
		   .alusrc(ALUSrc),
		   .mem2reg(MemtoReg),
		   .regwrite(RegWrite),
		   .memread(MemRead),
		   .memwrite(MemWrite),
		   .branch(Branch),
		   .uncond_branch(Uncondbranch),
		   .aluop(ALUOp),
		   .signop(signop),
		   .opcode(opcode)
	);

    // Register File
    RegisterFile RF (
        .BusA(BusA),
        .BusB(BusB),
        .BusW(),              
        .RA(Rn_in),
        .RB(Rm_in),
        .RW(),                
        .RegWr(1'b0),         
        .Clk(clk)
    );

    SignExtender SignExt(
        .BusImm(SignExtImm64),
        .Inst(instruction[25:0]),
        .Ctrl(signop)
	);

    
    // Outputs
    assign Rd = Rd_in;
    assign Rn = Rn_in;
    assign Rm = Rm_in;
    assign PCplus4_IDEX = PCPlus4Out;

endmodule
