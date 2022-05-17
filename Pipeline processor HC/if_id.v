module IF_ID(
  input clk,
  input IF_ID_Write,
  input Flush,
  input [31:0] Instruction,
  input [63:0] PC_Out,
  output reg [31:0] IF_ID_Instruction,
  output reg [63:0] IF_ID_PC_Out
);
  
  always @ (posedge clk or posedge Flush)
    begin
      
      if (Flush == 1'b1)
        begin
          IF_ID_Instruction = 0;
          IF_ID_PC_Out = 0;
        end
      
      else if (!IF_ID_Write)
      begin
        IF_ID_PC_Out = IF_ID_PC_Out;
        IF_ID_Instruction = IF_ID_Instruction;
      end
      
      else
        begin
          IF_ID_Instruction = Instruction;
          IF_ID_PC_Out = PC_Out;
        end
      
    end
  
endmodule 