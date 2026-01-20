`include "ALU_Decoder.v"
`include "Main_Decoder.v"

module Control_Unit_Top(Op, RegWrite, ImmSrc, ALUSrc, MemWrite,
                        ResultSrc, Branch, funct3, funct7, ALUControl);

    input [6:0] Op, funct7;
    input [2:0] funct3;
    output RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    output [1:0] ImmSrc;
    output [2:0] ALUControl;

    wire [1:0] ALUOp;

    Main_Decoder MD (
        .Op(Op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    ALU_Decoder AD (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(Op),
        .ALUControl(ALUControl)
    );

endmodule
