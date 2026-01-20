`include "PC.v"
`include "Instruction_Memory.v"
`include "Register_File.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "Data_Memory.v"
`include "PC_Adder.v"
`include "Mux.v"

module Single_Cycle_Top (
    input clk,
    input rst
);

    wire [31:0] PC_Top;
    wire [31:0] RD_Instr;
    wire [31:0] RD1_Top;
    wire [31:0] RD2_Top;
    wire [31:0] Imm_Ext_Top;
    wire [31:0] SrcB;
    wire [31:0] ALUResult;
    wire [31:0] ReadData;
    wire [31:0] Result;
    wire [31:0] PCPlus4;

    wire RegWrite;
    wire MemWrite;
    wire ALUSrc;
    wire ResultSrc;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl_Top;

    // Program Counter
    PC_Module PC (
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

    // PC + 4
    PC_Adder PC_Adder (
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)
    );

    // Instruction Memory
    Instruction_Memory Instruction_Memory (
        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );

    // Register File
    Register_File Register_File (
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .WD3(Result),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );

    // Sign Extend
    Sign_Extend Sign_Extend (
        .In(RD_Instr),
        .ImmSrc(ImmSrc[0]),
        .Imm_Ext(Imm_Ext_Top)
    );

    // ALU Source Mux
    Mux Mux_Register_to_ALU (
        .a(RD2_Top),
        .b(Imm_Ext_Top),
        .s(ALUSrc),
        .c(SrcB)
    );

    // ALU
    ALU ALU (
        .A(RD1_Top),
        .B(SrcB),
        .Result(ALUResult),
        .ALUControl(ALUControl_Top),
        .OverFlow(),
        .Carry(),
        .Zero(),
        .Negative()
    );

    Control_Unit_Top Control_Unit_Top (
        .Op(RD_Instr[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(),
        .funct3(RD_Instr[14:12]),
        .funct7(RD_Instr[31:25]),  
        .ALUControl(ALUControl_Top)
    );

    Data_Memory Data_Memory (
        .clk(clk),
        .rst(rst),
        .WE(MemWrite),
        .WD(RD2_Top),
        .A(ALUResult),
        .RD(ReadData)
    );

    Mux Mux_DataMemory_to_Register (
        .a(ALUResult),
        .b(ReadData),
        .s(ResultSrc),
        .c(Result)
    );

endmodule
