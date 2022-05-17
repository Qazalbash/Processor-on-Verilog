module Data_Memory_3
(
    input [63:0] Mem_Addr,
    input [63:0] Write_Data,
    input clk,
    input MemWrite, MemRead,
    output [63:0] Read_Data
);

reg [7:0] memory [63:0];
reg [63:0] temp_data;
integer i;

initial begin
for (i=0 ;i<64 ; i = i + 1) begin
    memory[i] = 0;
end

end


always @(negedge clk) begin
    if (MemWrite) begin
        memory[Mem_Addr] = Write_Data[7:0];
        memory[Mem_Addr+1] = Write_Data[15:8];
        memory[Mem_Addr+2] = Write_Data[23:16];
        memory[Mem_Addr+3] = Write_Data[31:24];
        memory[Mem_Addr+4] = Write_Data[39:32];
        memory[Mem_Addr+5] = Write_Data[47:40];
        memory[Mem_Addr+6] = Write_Data[55:48];
        memory[Mem_Addr+7] = Write_Data[63:56];
    end
end



always @(*) begin
    if (MemRead) begin
        temp_data <= {memory[Mem_Addr+7], memory[Mem_Addr+6], memory[Mem_Addr+5], memory[Mem_Addr+4], memory[Mem_Addr+3], memory[Mem_Addr+2], memory[Mem_Addr+1], memory[Mem_Addr]};
    end
end

assign Read_Data = temp_data;



endmodule // Data_Memory