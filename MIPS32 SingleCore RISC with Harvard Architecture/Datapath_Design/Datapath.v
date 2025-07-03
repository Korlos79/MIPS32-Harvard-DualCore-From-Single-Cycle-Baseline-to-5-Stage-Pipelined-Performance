module Datapath(
    input clk,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [4:0] shamt,
    input [15:0] immediate,
    input sign1,
    input sign2,
    input RegDst,
    input RegWrite,
    input ALUsrc,
    input [2:0] ALUcontrol,
    input MemWrite,
    input MemRead,
    input MemtoReg,
    input oe,
    input shift,
    output [31:0] out,
    output beq,
	 output [31:0] extend
);

    wire [4:0] mx1;
    wire [31:0] mx2, mx3;
    wire [31:0] data1, data2;
    wire [31:0] result, read;

    // Mux để chọn địa chỉ ghi
    Mux2to1_5bit Mux1(
        .a(rt),
        .b(rd),
        .out(mx1),
        .sel(RegDst)
    );

    // Bộ mở rộng 16-bit (sign/zero extend)
    SignExtend SignExt(
        .in1(shamt),
        .in2(immediate),
        .sel(shift),
        .out(extend)
    );

    // Tập thanh ghi
    RegisterFile Regs(
        .clk(clk),
        .ReadWriteEn(RegWrite),
        .ReadAddress1(rs),
        .ReadAddress2(rt),
        .WriteAddress(mx1),
        .WriteData(mx3),
        .ReadData1(data1),
        .ReadData2(data2)
    );

    // Mux chọn nguồn cho ALU
    Mux2to1_32bit Mux2(
        .a(data2),
        .b(extend),
        .out(mx2),
        .sel(ALUsrc)
    );

    // ALU thực hiện phép tính
    ALU32bit ALU(
        .a(data1),
        .b(mx2),
        .sign1(sign1),
        .sign2(sign2),
		  .S(ALUcontrol),
        .ALUresult(result),
        .is0(beq)
    );

    // Bộ nhớ dữ liệu
    DataMemory DMem(
        .clk(clk),
        .addr(result),
        .WriteData(data2),
        .ReadData(read),
        .WriteEn(MemWrite),
        .ReadEn(MemRead)
    );

    // Mux chọn dữ liệu ghi lại vào thanh ghi
    Mux2to1_32bit Mux3(
        .a(result),
        .b(read),
        .out(mx3),
        .sel(MemtoReg)
    );

    // Xuất kết quả nếu được phép
   assign out = oe ? mx3 : 32'bz;
endmodule
