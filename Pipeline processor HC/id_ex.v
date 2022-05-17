module ID_EX(input clk, 
             input Flush,
             
             input [1:0] ALU_Op,
             input Branch,
             input MemRead,
             input MemtoReg,
             input MemWrite,
             input ALUSrc,        
             input RegWrite,
            
             input [3:0] IF_ID_Ins,
             input [4:0] IF_ID_rs1, IF_ID_rs2,  IF_ID_rd,
             input [63:0] IF_ID_Immediate, IF_ID_ReadData1, IF_ID_ReadData2, IF_ID_PC_Out,
             
             output reg [1:0] ID_EX_ALU_Op,
             output reg ID_EX_Branch,
             output reg ID_EX_MemRead,
             output reg ID_EX_MemtoReg,
             output reg ID_EX_MemWrite,
             output reg ID_EX_ALUSrc,
             output reg ID_EX_RegWrite,
            
             output reg [3:0] ID_EX_Ins,
             output reg [4:0] ID_EX_rs1, ID_EX_rs2,  ID_EX_rd,
             output reg [63:0] ID_EX_Immediate, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_PC_Out);
  
  always @ (posedge clk or Flush)
    begin
      if (Flush == 1'b1)
        begin
          ID_EX_ALU_Op = 0;
          ID_EX_Branch = 0;
          ID_EX_MemRead = 0;
          ID_EX_MemtoReg = 0;
          ID_EX_MemWrite = 0;
          ID_EX_ALUSrc = 0;  
          ID_EX_RegWrite = 0;
            
          ID_EX_Ins = 0;
          ID_EX_rs1= 0;
          ID_EX_rs2 = 0;  
          ID_EX_rd = 0;
          ID_EX_Immediate=0; 
          ID_EX_ReadData1=0; 
          ID_EX_ReadData2=0;  
          ID_EX_PC_Out=0;         
        end
      else if (clk == 1'b1)
        begin
          ID_EX_ALU_Op = ALU_Op;
          ID_EX_Branch = Branch;
          ID_EX_MemRead = MemRead;
          ID_EX_MemtoReg = MemtoReg;
          ID_EX_MemWrite = MemWrite;
          ID_EX_ALUSrc = ALUSrc;  
          ID_EX_RegWrite = RegWrite;
            
          ID_EX_Ins = IF_ID_Ins;
          ID_EX_rs1= IF_ID_rs1;
          ID_EX_rs2 = IF_ID_rs2;  
          ID_EX_rd = IF_ID_rd;
          ID_EX_Immediate=IF_ID_Immediate; 
          ID_EX_ReadData1=IF_ID_ReadData1; 
          ID_EX_ReadData2=IF_ID_ReadData2; 
          ID_EX_PC_Out=IF_ID_PC_Out;  
        end
      
    end  
  
endmodule