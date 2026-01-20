module Data_Memory(clk, rst, WE, WD, A, RD);

    input clk, rst, WE;
    input [31:0] A, WD;
    output [31:0] RD;

    reg [31:0] mem [1023:0];

    always @(posedge clk) begin
        if (WE)
            mem[A[11:2]] <= WD;
    end

    assign RD = mem[A[11:2]];

    initial begin
        mem[28] = 32'h00000020;
    end

endmodule
