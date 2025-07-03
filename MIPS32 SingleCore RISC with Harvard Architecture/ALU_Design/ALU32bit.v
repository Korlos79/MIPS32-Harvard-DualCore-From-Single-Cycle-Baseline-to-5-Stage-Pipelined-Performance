module ALU32bit(
    input [31:0] a, 
    input [31:0] b,
    input sign1,
    input sign2,
    input [2:0] S,
    output reg [31:0] ALUresult,
    output reg is0
);
    // Biến a và b sẽ được tính toán lại dựa trên sign1, sign2
    wire [31:0] a_modified = (sign1 == 1'b1) ? (a[31] ? -a : a) : a;
    wire [31:0] b_modified = (sign2 == 1'b1) ? (b[31] ? -b : b) : b;

    always @(*) begin
        case(S)
            3'b000: ALUresult <= a_modified + b_modified;          // Cộng
            3'b001: ALUresult <= a_modified - b_modified;          // Trừ
            3'b010: ALUresult <= a_modified & b_modified;          // AND
            3'b011: ALUresult <= a_modified | b_modified;          // OR
            3'b100: ALUresult <= ~(a_modified | b_modified);       // NOR
            3'b101: ALUresult <= a_modified << b_modified[4:0];    // Dịch trái
            3'b110: ALUresult <= a_modified >> b_modified[4:0];    // Dịch phải
            3'b111: ALUresult <= (a_modified < b_modified) ? 32'd1 : 32'd0;  // Kiểm tra nhỏ hơn
            default: ALUresult <= 32'd0;                           // Mặc định là 0
        endcase

        is0 <= (a == b);  // Kiểm tra nếu a == b
    end
endmodule
