module ControlUnit(
    input [5:0] opcode,
    input [5:0] funct,
    output reg sign1,
    output reg sign2,
    output reg RegDst,
    output reg Jump,
    output reg Branch,
    output reg RegWrite,
    output reg ALUsrc,
    output reg [2:0] ALUop,
    output reg MemWrite,
    output reg MemRead,
    output reg MemtoReg,
    output reg oe,
    output reg shift
);

    always @(*) begin
        // Reset all control signals
        sign1 <= 0;
        sign2 <= 0;
        RegDst <= 0;
        Jump <= 0;
        Branch <= 0;
        RegWrite <= 0;
        ALUsrc <= 0;
        ALUop <= 3'b000;
        MemWrite <= 0;
        MemRead <= 0;
        MemtoReg <= 0;
        oe <= 0;
        shift <= 0;

        case(opcode)
            6'b100011: begin // lw
                RegDst <= 0;
                RegWrite <= 1;
                ALUsrc <= 1;
                MemRead <= 1;
                MemtoReg <= 1;
                oe <= 1;
            end
            6'b101011: begin // sw
                ALUsrc <= 1;
                MemWrite <= 1;
            end
            6'b000000: begin // R-type
                RegDst <= 1;
                RegWrite <= 1;
                ALUsrc <= 0;
                MemtoReg <= 0;
                oe <= 1;
                case(funct)
                    6'b100000: ALUop <= 3'b000; // add
                    6'b100001: begin           // addu
                        ALUop <= 3'b000;
                        sign1 <= 1;
                        sign2 <= 1;
                    end
                    6'b100010: ALUop <= 3'b001; // sub
                    6'b100011: begin           // subu
                        ALUop <= 3'b001;
                        sign1 <= 1;
                        sign2 <= 1;
                    end
                    6'b100100: ALUop <= 3'b010; // and
                    6'b100101: ALUop <= 3'b011; // or
                    6'b100111: ALUop <= 3'b100; // nor
                    6'b101010: ALUop <= 3'b111; // slt
                    6'b101011: begin           // sltu
                        ALUop <= 3'b111;
                        sign1 <= 1;
                        sign2 <= 1;
                    end
                    6'b000000: begin           // sll
                        ALUop <= 3'b101;
                        shift <= 1;
                    end
                    6'b000010: begin           // srl
                        ALUop <= 3'b110;
                        shift <= 1;
                    end
                endcase
            end
            6'b000100: begin // beq
                Branch <= 1;
                ALUsrc <= 0;
            end
            6'b000010: begin // j
                Jump <= 1;
            end
            6'b001000: begin // addi
                RegDst <= 0;
                RegWrite <= 1;
                ALUsrc <= 1;
                ALUop <= 3'b000;
                MemtoReg <= 0;
                oe <= 1;
					 
            end
            6'b001001: begin // addiu
                RegDst <= 0;
                RegWrite <= 1;
                ALUsrc <= 1;
                ALUop <= 3'b000;
                MemtoReg <= 0;
                oe <= 1;
                sign1 <= 1;
                sign2 <= 1;
            end
            6'b001100: begin // andi
                RegDst <= 0;
                RegWrite <= 1;
                ALUsrc <= 1;
                ALUop <= 3'b010;
                MemtoReg <= 0;
                oe <= 1;
            end
            6'b001101: begin // ori
                RegDst <= 0;
                RegWrite <= 1;
                ALUsrc <= 1;
                ALUop <= 3'b011;
                MemtoReg <= 0;
                oe <= 1;
            end
            6'b001010: begin // slti
                RegDst <= 0;
                RegWrite <= 1;
                ALUsrc <= 1;
                ALUop <= 3'b111;
                MemtoReg <= 0;
                oe <= 1;
            end
            6'b001011: begin // sltiu
                RegDst <= 0;
                RegWrite <= 1;
                ALUsrc <= 1;
                ALUop <= 3'b111;
                MemtoReg <= 0;
                oe <= 1;
                sign1 <= 1;
                sign2 <= 1;
            end
        endcase
    end

endmodule
