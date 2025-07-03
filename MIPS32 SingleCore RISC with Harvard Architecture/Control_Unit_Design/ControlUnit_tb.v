`timescale 1ns / 1ps

module ControlUnit_tb;

    // Inputs
    reg [5:0] opcode;
    reg [5:0] funct;

    // Outputs
    wire sign1, sign2, RegDst, Jump, Branch, RegWrite, ALUsrc;
    wire [2:0] ALUop;
    wire MemWrite, MemRead, MemtoReg, oe, shift;

    // Instantiate the Unit Under Test (UUT)
    ControlUnit uut (
        .opcode(opcode), .funct(funct),
        .sign1(sign1), .sign2(sign2), .RegDst(RegDst),
        .Jump(Jump), .Branch(Branch), .RegWrite(RegWrite),
        .ALUsrc(ALUsrc), .ALUop(ALUop), .MemWrite(MemWrite),
        .MemRead(MemRead), .MemtoReg(MemtoReg), .oe(oe), .shift(shift)
    );

    initial begin
        // Test lw
        opcode = 6'b100011; funct = 6'bxxxxxx;
        #10;

        // Test sw
        opcode = 6'b101011;
        #10;

        // Test R-type: add
        opcode = 6'b000000; funct = 6'b100000;
        #10;

        // Test R-type: sub
        opcode = 6'b000000; funct = 6'b100010;
        #10;

        // Test R-type: sll
        opcode = 6'b000000; funct = 6'b000000;
        #10;

        // Test beq
        opcode = 6'b000100;
        #10;

        // Test j
        opcode = 6'b000010;
        #10;

        // Test addi
        opcode = 6'b001000;
        #10;

        // Test sltiu
        opcode = 6'b001011;
        #10;

        // Dừng mô phỏng
        $stop;
    end

endmodule
