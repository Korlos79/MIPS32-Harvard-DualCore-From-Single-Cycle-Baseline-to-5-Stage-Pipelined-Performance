module DataMemory(
	input clk,
	input [31:0] addr,
	input [31:0] WriteData, 
	output reg [31:0] ReadData, 
	input WriteEn, 
	input ReadEn
);
	reg [31:0] mem [0:1023];
always @(posedge clk) begin
	if(ReadEn) begin
		ReadData <= mem[addr];
	end
	if(WriteEn) begin
		mem[addr] <= WriteData;
	end
end
endmodule
