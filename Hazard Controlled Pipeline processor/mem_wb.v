module MEM_WB(input clk,
              input reset,
              
              input EX_MEM_RegWrite,
              input EX_MEM_MemtoReg,
              
              input [4:0] EX_MEM_rd,
              
              input [63:0] EX_MEM_ALU_Out,
              input [63:0] Read_Data,
              
              output reg MEM_WB_RegWrite,
              output reg MEM_WB_MemtoReg,
              output reg [4:0] MEM_WB_rd,
              output reg [63:0] MEM_WB_ALU_Out,
              output reg [63:0] MEM_WB_Read_Data);
  
  always @ (posedge clk or reset)
    begin
      if (reset == 1'b1)
        begin
          MEM_WB_RegWrite = 0;
          MEM_WB_MemtoReg = 0;
          MEM_WB_rd = 0;
          MEM_WB_ALU_Out = 0;
          MEM_WB_Read_Data = 0;
        end
      
      else if (clk == 1'b1)
        begin
          MEM_WB_RegWrite = EX_MEM_RegWrite;
          MEM_WB_MemtoReg = EX_MEM_MemtoReg;
          MEM_WB_rd= EX_MEM_rd;
          MEM_WB_ALU_Out = EX_MEM_ALU_Out;
          MEM_WB_Read_Data = Read_Data;
        end
      
    end
  
endmodule