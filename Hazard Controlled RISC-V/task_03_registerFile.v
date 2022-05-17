module registerFile_3
(
    input clk, reset, RegWrite,
    input [63:0] WriteData,
    input [4:0] RS1, RS2, RD,
    output reg [63:0] ReadData1, ReadData2    
);

reg [63:0] Registers [31:0];
integer i;

initial
begin
    Registers[0] = 64'd0;
    Registers[1] = 64'd1;
    Registers[2] = 64'd0;
    Registers[3] = 64'd0;
    Registers[4] = 64'd0;
    Registers[5] = 64'd0;
    Registers[6] = 64'd0;
    Registers[7] = 64'd0;
    Registers[8] = 64'd0;
    Registers[9] = 64'd0;
    Registers[10] = 64'd0;
    Registers[11] = 64'd0;
    Registers[12] = 64'd0;
    Registers[13] = 64'd0;
    Registers[14] = 64'd0;
    Registers[15] = 64'd0;
    Registers[16] = 64'd0;
    Registers[17] = 64'd0;
    Registers[18] = 64'd20; //20 for testing
    Registers[19] = 64'd0;
    Registers[20] = 64'd0;
    Registers[21] = 64'd1; //register x21 = 1
    Registers[22] = 64'd0;
    Registers[23] = 64'd0;
    Registers[24] = 64'd0;
    Registers[25] = 64'd0;
    Registers[26] = 64'd0;
    Registers[27] = 64'd0;
    Registers[28] = 64'd0;
    Registers[29] = 64'd0;
    Registers[30] = 64'd0;
    Registers[31] = 64'd0;
    
end


always @(negedge clk ) begin
    
    if (RegWrite) begin
        Registers[RD] = WriteData;
    end
end

always@(*) begin
    ReadData1 = reset ? 0 : Registers[RS1];
    ReadData2 = reset ? 0 : Registers[RS2];
end

endmodule // registerFile