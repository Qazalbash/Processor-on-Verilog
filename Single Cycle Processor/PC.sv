module Program_counter(
  input [63:0]PC_In,
  input clk,
  input reset,
  output reg [63:0]PC_Out);
  
  
  always @(posedge clk)
    begin 
      
      if (reset == 1'b1)
        PC_Out = 0;
      else
        PC_Out = PC_In;
    end
endmodule 