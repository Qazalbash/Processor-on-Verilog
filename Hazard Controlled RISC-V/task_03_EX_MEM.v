module EX_MEM_3
(
    input clk, Flush,
    input RegWrite, MemtoReg, Branch, Zero, MemWrite, MemRead, Is_Greater,
    input [63:0] PCplusimm, ALU_result, WriteData,
    input [3:0] funct_in,
    input [4:0] rd,

    output reg RegWrite_store, MemtoReg_store,
    output reg Branch_store, Zero_store, MemWrite_store, MemRead_store, Is_Greater_store,
    output reg [63:0] PCplusimm_store, ALU_result_store, WriteData_store,
    output reg [3:0] funct_in_store,
    output reg [4:0] rd_store
);


always @(posedge clk) begin
    if (Flush)
        begin
            RegWrite_store = 0;
            MemtoReg_store = 0;
            Branch_store = 0;
            Zero_store = 0;
            Is_Greater_store = 0;
            MemWrite_store = 0;
            MemRead_store = 0;
            PCplusimm_store = 0;
            ALU_result_store = 0;
            WriteData_store = 0;
            funct_in_store = 0;
            rd_store = 0;
        end
    else
        begin
            RegWrite_store = RegWrite;
            MemtoReg_store = MemtoReg;
            Branch_store = Branch;
            Zero_store = Zero;
            Is_Greater_store = Is_Greater;
            MemWrite_store = MemWrite;
            MemRead_store = MemRead;
            PCplusimm_store = PCplusimm;
            ALU_result_store = ALU_result;
            WriteData_store = WriteData;
            funct_in_store = funct_in;
            rd_store = rd;
        end
end


endmodule // EX_MEM