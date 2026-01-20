module Main_Decoder(Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

    input [6:0] Op;
    output RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    output [1:0] ImmSrc, ALUOp;

    assign RegWrite = (Op == 7'b0000011 || Op == 7'b0110011);
    assign ImmSrc   = (Op == 7'b0100011) ? 2'b01 :
                      (Op == 7'b1100011) ? 2'b10 :
                                           2'b00;
    assign ALUSrc   = (Op == 7'b0000011 || Op == 7'b0100011);
    assign MemWrite = (Op == 7'b0100011);
    assign ResultSrc= (Op == 7'b0000011);
    assign Branch   = (Op == 7'b1100011);

    assign ALUOp    = (Op == 7'b0110011) ? 2'b10 :
                      (Op == 7'b1100011) ? 2'b01 :
                                           2'b00;

endmodule
