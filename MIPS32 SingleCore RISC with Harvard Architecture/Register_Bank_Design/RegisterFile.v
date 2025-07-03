module RegisterFile( 
    input clk,
    input ReadWriteEn, 
    input [4:0] ReadAddress1, 
    input [4:0] ReadAddress2,
    input [4:0] WriteAddress,               
    input [31:0] WriteData,
    output [31:0] ReadData1, 
    output [31:0] ReadData2
);
    reg [31:0] registers [0:31];

    // Write operation
    always @(posedge clk) begin 
        if (ReadWriteEn && (WriteAddress != 5'd0)) begin
            registers[WriteAddress] <= WriteData;
        end
    end

    // Read operation
    assign ReadData1 = (ReadAddress1 == 5'd0) ? 32'b0 : registers[ReadAddress1];
    assign ReadData2 = (ReadAddress2 == 5'd0) ? 32'b0 : registers[ReadAddress2];
endmodule
