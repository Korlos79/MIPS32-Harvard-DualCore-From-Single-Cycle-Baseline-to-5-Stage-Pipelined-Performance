module FinalProcessor(
    input clk,
    input reset,
    input [31:0] instruction,
    output [31:0] result_out,  // Output để quan sát kết quả
	 output [31:0] PC
);


    // ------------------- Instruction Fetch -------------------
    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [15:0] imm16;
    wire [25:0] addr26;

    InstructionFetch IF (
        .instruction(instruction),
        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct),
        .immediate(imm16),
        .address(addr26)
    );

    // ------------------- Control Unit -------------------
    wire sign1, sign2, RegDst, Jump, Branch, RegWrite, ALUsrc, MemWrite, MemRead, MemtoReg, oe, shift;
    wire [2:0] ALUop;

    ControlUnit CU (
        .opcode(opcode),
        .funct(funct),
        .sign1(sign1),
        .sign2(sign2),
        .RegDst(RegDst),
        .Jump(Jump),
        .Branch(Branch),
        .RegWrite(RegWrite),
        .ALUsrc(ALUsrc),
        .ALUop(ALUop),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .oe(oe),
        .shift(shift)
    );

    // ------------------- Datapath -------------------
    wire beq;
    wire [31:0] datapath_out;
    wire [31:0] extend;

    Datapath datapath (
        .clk(clk),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),     
        .immediate(imm16),
        .sign1(sign1),
        .sign2(sign2),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUsrc(ALUsrc),
        .ALUcontrol(ALUop),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .oe(oe),
        .shift(shift),
        .out(datapath_out),
        .beq(beq),
        .extend(extend)
    );

    // ------------------- PC Counter -------------------
    PC_Counter PC_module (
        .clk(clk),
        .reset(reset),
        .Branch(Branch),
        .Jump(Jump),
        .is0(beq),
        .address(addr26),
        .immediate(extend),  
        .PC(PC)
    );

    // ------------------- Output -------------------
	assign result_out = datapath_out;
endmodule
