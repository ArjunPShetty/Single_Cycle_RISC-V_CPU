module ALU_Decoder (
    input  wire [1:0] ALUOp,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    input  wire [6:0] op,
    output reg  [2:0] ALUControl
);

    always @(*) begin
        
        ALUControl = 3'b000;

        case (ALUOp)
            2'b00: ALUControl = 3'b000; // ADD
            2'b01: ALUControl = 3'b001; // SUB

            2'b10: begin
                case (funct3)
                    3'b000: begin
                        if ({op[5], funct7[5]} == 2'b11)
                            ALUControl = 3'b001; // SUB
                        else
                            ALUControl = 3'b000; // ADD
                    end
                    3'b010: ALUControl = 3'b101; // SLT
                    3'b110: ALUControl = 3'b011; // OR
                    3'b111: ALUControl = 3'b010; // AND
                    default: ALUControl = 3'b000;
                endcase
            end

            default: ALUControl = 3'b000;
        endcase
    end

endmodule
