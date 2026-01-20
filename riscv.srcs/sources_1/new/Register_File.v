module Register_File (
    input  wire        clk,
    input  wire        rst,
    input  wire        WE3,
    input  wire [4:0]  A1, A2, A3,
    input  wire [31:0] WD3,
    output wire [31:0] RD1, RD2
);

    reg [31:0] Register [31:0];
    integer i;

    always @(posedge clk) begin
        if (!rst) begin
            for (i = 0; i < 32; i = i + 1)
                Register[i] <= 32'b0;
        end
        else if (WE3 && (A3 != 5'd0)) begin
            Register[A3] <= WD3;
        end
    end

    assign RD1 = (A1 == 5'd0) ? 32'b0 : Register[A1];
    assign RD2 = (A2 == 5'd0) ? 32'b0 : Register[A2];

endmodule
