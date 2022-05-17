module EX_MEM(input clk,
              input reset,
              
              input ID_EX_Branch,
              input ID_EX_MemRead,
              input ID_EX_MemWrite,
              input ID_EX_RegWrite,
              input ID_EX_MemtoReg,
              
              input Zero,
              
              input [4:0] ID_EX_rd,
              
              input [63:0] ALU_Out,
              input [63:0] MUX_ForwardB,
              input [63:0] PC_Adder,
              
              output reg EX_MEM_Zero,
             
              output reg [4:0] EX_MEM_rd,
              
              output reg [63:0] EX_MEM_MUX_ForwardB,
              output reg [63:0] EX_MEM_ALU_Out,
              output reg [63:0] EX_MEM_PC_Adder,
             
              output reg EX_MEM_Branch,
              output reg EX_MEM_MemRead,
              output reg EX_MEM_MemWrite,
              output reg EX_MEM_RegWrite,
              output reg EX_MEM_MemtoReg);
  
  always @ (posedge clk or reset)
    begin
      
          if (reset == 1'b1)
            
            begin
             EX_MEM_Zero=0;
             EX_MEM_rd=0;
             EX_MEM_MUX_ForwardB=0;
             EX_MEM_ALU_Out=0;
             EX_MEM_PC_Adder=0;
             EX_MEM_Branch=0;
             EX_MEM_MemRead=0;
             EX_MEM_MemWrite=0;
             EX_MEM_RegWrite=0;
             EX_MEM_MemtoReg=0;
            end
      
     else if (clk == 1'b1)
       
        begin
        	EX_MEM_Zero = Zero;
            EX_MEM_rd = ID_EX_rd;
            EX_MEM_MUX_ForwardB = MUX_ForwardB;
            EX_MEM_ALU_Out = ALU_Out;
            EX_MEM_PC_Adder = PC_Adder;
            EX_MEM_Branch=ID_EX_Branch;
            EX_MEM_MemRead=ID_EX_MemRead;
            EX_MEM_MemWrite=ID_EX_MemWrite;
            EX_MEM_RegWrite=ID_EX_RegWrite;
            EX_MEM_MemtoReg=ID_EX_MemtoReg;
        end
      
    end
endmodule