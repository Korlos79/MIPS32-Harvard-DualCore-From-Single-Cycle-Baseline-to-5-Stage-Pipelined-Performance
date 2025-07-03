`timescale 1ns/1ps
module RegisterFile_tb;

    reg clk;
    reg ReadWriteEn;
    reg [4:0] ReadAddress1;
    reg [4:0] ReadAddress2;
    reg [4:0] WriteAddress;
    reg [31:0] WriteData;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;

    RegisterFile uut (
        .clk(clk),
        .ReadWriteEn(ReadWriteEn),
        .ReadAddress1(ReadAddress1),
        .ReadAddress2(ReadAddress2),
        .WriteAddress(WriteAddress),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("T=%0t | WE=%b | WAddr=%0d WData=%0d | RAddr1=%0d RData1=%0d | RAddr2=%0d RData2=%0d",
                 $time, ReadWriteEn, WriteAddress, WriteData,
                 ReadAddress1, ReadData1, ReadAddress2, ReadData2);
    end

    initial begin
        clk = 0;
        ReadWriteEn = 0;
        WriteAddress = 0;
        WriteData = 0;
        ReadAddress1 = 0;
        ReadAddress2 = 0;

        #3;  ReadWriteEn = 1; WriteAddress = 5'd1; WriteData = 32'd3;
        #10;

        WriteAddress = 5'd3; WriteData = 32'd1;
        #10;

        ReadWriteEn = 0; ReadAddress1 = 5'd1;  
        #10;
		  
        ReadAddress2 = 5'd3; ReadAddress1 = 5'd0;
        #10;
		  
        WriteAddress = 5'd4; WriteData = -9; ReadWriteEn = 1;
        #10;

        WriteAddress = 5'd1; WriteData = 32'd45; ReadWriteEn = 1;
        #10;

        ReadWriteEn = 0;
        ReadAddress1 = 5'd4; ReadAddress2 = 5'd1;
        #10;
        $display("Check: R4 = %0d (expected -9), R1 = %0d (expected 45)", ReadData1, ReadData2);

        $finish;
    end

endmodule
