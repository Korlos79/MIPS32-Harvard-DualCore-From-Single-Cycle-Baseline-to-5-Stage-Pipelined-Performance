`timescale 1ns/1ps

module DataMemory_tb();
    reg clk;
    reg [31:0] addr;
    reg [31:0] WriteData;
    wire [31:0] ReadData;
    reg WriteEn;
    reg ReadEn;

    // Gọi module chính
    DataMemory uut(
        .clk(clk),
        .addr(addr),
        .WriteData(WriteData),
        .ReadData(ReadData),
        .WriteEn(WriteEn),
        .ReadEn(ReadEn)
    );

    // Tạo clock 10ns (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Các thao tác kiểm tra
    initial begin
        // Khởi tạo
        WriteEn = 0;
        ReadEn = 0;
        addr = 0;
        WriteData = 0;

        // Ghi dữ liệu
        #10;
        addr = 4;
        WriteData = 32;
        WriteEn = 1;
        #10;
        WriteEn = 0;

        // Ghi dữ liệu khác
        #10;
        addr = 5;
        WriteData = -65;
        WriteEn = 1;
        #10;
        WriteEn = 0;

        // Đọc dữ liệu từ địa chỉ 10
        #10;
        addr = 4;
        ReadEn = 1;
        #10;
        ReadEn = 0;

        // Đọc dữ liệu từ địa chỉ 20
        #10;
        addr = 5;
        ReadEn = 1;
        #10;
        ReadEn = 0;

        // Kết thúc mô phỏng
        #20;
        $stop;
    end

    // Hiển thị các giá trị trong quá trình mô phỏng
    initial begin
        $monitor("At time %t: addr=%d, WriteData=0x%h, ReadData=0x%h, WriteEn=%b, ReadEn=%b",
                  $time, addr, WriteData, ReadData, WriteEn, ReadEn);
    end
endmodule
