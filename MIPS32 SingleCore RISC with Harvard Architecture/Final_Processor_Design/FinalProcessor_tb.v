`timescale 1ns / 1ps

module FinalProcessor_tb;

    // ------------------ Inputs -----------------
    reg clk;
    reg reset;
    reg [31:0] instruction;

    // ------------------ Outputs ----------------
    wire [31:0] result_out;
    wire [31:0] PC;

    // ------------------ Instantiate FinalProcessor ------------------
    FinalProcessor uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .result_out(result_out),
        .PC(PC)
    );

    // ------------------ Clock Generation -----------------
    always begin
        #5 clk = ~clk;  // Toggle clock every 5ns
    end

    // ------------------ Test Stimulus -----------------
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;
        instruction = 32'b0;

        // Reset the processor
        reset = 1;
        #10 reset = 0;

        // ------------------ Apply Test Instructions -----------------

        instruction = 32'b00100000000010000000000000000101; // 001000 00000 00010 0000000000000101
        #10;

        instruction = 32'b00100000000010010000000000001010; // 001000 00000 00011 0000000000001010
        #10;

        instruction = 32'b00000001000010010101000000100000; // 000000 01000 01001 01010 00000 100000
        #10;

        instruction = 32'b10101101001010000000000000000000; // 101011 01001 01000 0000000000000000
        #10;

        instruction = 32'b10001101001010100000000000000000; // 100011 01001 01010 0000000000000000
        #10;

        instruction = 32'b00100000000000100000000000000001; // 001000 00000 00010 0000000000000001
        #10;

        instruction = 32'b00100000000000110000000000000001; // 001000 00000 00011 0000000000000001
        #10;

        instruction = 32'b00010000010000110000000000010101; // 000100 00010 00011 0000000000010101
        #10;

        instruction = 32'b00001000000000000000000000100000; // 000010 00000000000000000000000000
        #10;

        // Finish simulation after testing all instructions
        $finish;
    end

    // ------------------ Monitor the Output -----------------
    initial begin
        $monitor("Time: %0d, PC: %h, Result: %h", $time, PC, result_out);
    end

endmodule
