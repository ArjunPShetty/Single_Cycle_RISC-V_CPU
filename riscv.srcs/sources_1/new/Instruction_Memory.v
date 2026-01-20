module Instruction_Memory(rst, A, RD);

    input rst;
    input [31:0] A;
    output [31:0] RD;

    reg [31:0] mem [1023:0];
    assign RD = mem[A[31:2]];

    initial begin
    $readmemh("memfile.mem", mem);
end
endmodule
