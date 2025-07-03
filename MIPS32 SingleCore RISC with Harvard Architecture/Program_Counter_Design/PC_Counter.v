module PC_Counter(
    input clk,
    input reset,
    input Branch,          
    input Jump,            
    input is0,             
    input [25:0] address, 
    input [31:0] immediate, 
    output reg [31:0] PC   
);

    reg [31:0] next_PC;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 32'd0;
        end else begin
            PC <= next_PC;
        end
    end

    always @(*) begin
        if (Jump) begin
            next_PC = {PC[31:28], address, 2'b00};
        end else if (Branch && is0) begin
            next_PC = PC + 4 + (immediate << 2);  
        end else begin
            next_PC = PC + 4; 
        end
    end

endmodule
