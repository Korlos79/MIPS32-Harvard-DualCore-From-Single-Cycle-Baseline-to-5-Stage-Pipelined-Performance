`timescale 1ns/1ps

module ALU32bit_tb;
    reg [31:0] a, b;
    reg [2:0] S;
    reg sign1, sign2;
    wire [31:0] ALUresult;
    wire is0;

    ALU32bit uut (
        .a(a),
        .b(b),
        .sign1(sign1),
        .sign2(sign2),
        .S(S),
        .ALUresult(ALUresult),
        .is0(is0)
    );

    initial begin
        $monitor("Time=%0t | S=%b | a=%0d | b=%0d | sign1=%b | sign2=%b | Result=%0d | is0=%b",
                 $time, S, a, b, sign1, sign2, ALUresult, is0);

        sign1 = 0; sign2 = 0;

        S = 3'b000; a = 4; b = 8; #10;
        S = 3'b001; a = 7; b = 2; #10;
        S = 3'b010; a = 8; b = 3; #10;
        S = 3'b011; a = 5; b = 4; #10;
        S = 3'b100; a = 7; b = 6; #10;
        S = 3'b101; a = 1; b = 2; #10;
        S = 3'b110; a = 4; b = 8; #10;
        S = 3'b111; a = 9; b = 6; #10;

        sign1 = 1; sign2 = 1;
        S = 3'b000; a = -5; b = -7; #10;
        S = 3'b001; a = -3; b = -6; #10;

        $finish;
    end
endmodule
