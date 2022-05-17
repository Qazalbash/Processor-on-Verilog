module IF_ID(input clk,
             input reset,
             input [31:0] Instruction,
             input [63:0] PC_Out,
             output reg [31:0] IF_ID_Instruction,
             output reg [63:0] IF_ID_PC_Out);
  
  always @ (posedge clk or posedge reset)
    begin
      
      if (reset == 1'b1)
        begin
          IF_ID_Instruction = 0;
          IF_ID_PC_Out = 0;
        end
      
      else if (clk == 1'b1)
        begin
          IF_ID_Instruction = Instruction;
          IF_ID_PC_Out = PC_Out;
        end
      
    end
  
endmodule 