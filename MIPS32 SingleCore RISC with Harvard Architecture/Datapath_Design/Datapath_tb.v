`timescale 1ns / 1ps

module Datapath_tb;

    // Inputs
    reg clk = 0;
    reg [4:0] rs, rt, rd, shamt;
    reg [15:0] immediate;
    reg sign1, sign2, RegDst, RegWrite, ALUsrc;
    reg [2:0] ALUcontrol;
    reg MemWrite, MemRead, MemtoReg, oe, shift;

    // Outputs
    wire [31:0] out;
    wire beq;
    wire [31:0] extend;

    // Instantiate the Unit Under Test (UUT)
    Datapath uut (
        .clk(clk), .rs(rs), .rt(rt), .rd(rd), .shamt(shamt),
        .immediate(immediate), .sign1(sign1), .sign2(sign2),
        .RegDst(RegDst), .RegWrite(RegWrite), .ALUsrc(ALUsrc),
        .ALUcontrol(ALUcontrol), .MemWrite(MemWrite), .MemRead(MemRead),
        .MemtoReg(MemtoReg), .oe(oe), .shift(shift),
        .out(out), .beq(beq), .extend(extend)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initial values
        rs = 5'd0; rt = 5'd2; rd = 5'd0; shamt = 5'd0;
        immediate = 16'd10;
        sign1 = 1; sign2 = 1;
        RegDst = 0; RegWrite = 1; ALUsrc = 1;
        ALUcontrol = 3'b000; // Add
        MemWrite = 0; MemRead = 0; MemtoReg = 0;
        oe = 1; shift = 0;

        #10;
        // Change immediate to 5
		   rs = 5'd0; rt = 5'd3; rd = 5'd0; shamt = 5'd0;
        immediate = 16'd5;
        sign1 = 1; sign2 = 1;
        RegDst = 0; RegWrite = 1; ALUsrc = 1;
        ALUcontrol = 3'b000; // Add
        MemWrite = 0; MemRead = 0; MemtoReg = 0;
        oe = 1; shift = 0;

        #10;
        // Change rd and rt
		  rs = 5'd2;
        rt = 5'd3;
		  rd = 5'd4;
        ALUsrc = 0;
		  RegDst = 1;
			sign1 = 0; sign2 = 0;
        #10;
        // Kết thúc mô phỏng
        $stop;
    end

endmodule
