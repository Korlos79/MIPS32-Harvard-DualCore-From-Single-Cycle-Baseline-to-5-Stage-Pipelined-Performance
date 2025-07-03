module Mux2to1_32bit(
	input [31:0] a,
	input [31:0] b,
	output [31:0] out,
	input sel
);
	assign out = (sel) ? (b) : (a);
endmodule