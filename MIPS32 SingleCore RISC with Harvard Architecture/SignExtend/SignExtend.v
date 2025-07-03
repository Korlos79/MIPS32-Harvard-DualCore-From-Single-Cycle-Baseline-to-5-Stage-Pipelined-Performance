module SignExtend(
    input wire [4:0] in1,
	 input wire [15:0] in2,
	 input sel,
    output wire [31:0] out
);
	wire[31:0] temp1, temp2;
   assign temp1 = {{27{in1[4]}}, in1};
	assign temp2 = {{16{in2[15]}}, in2};
	assign out = sel ? temp1 : temp2;
endmodule
