module Mux2to1_5bit(
	input [4:0] a,
	input [4:0] b,
	output [4:0] out,
	input sel
);
	assign out = (sel) ? (b) : (a);
endmodule