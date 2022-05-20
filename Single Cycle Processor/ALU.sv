module ALU_64_bit(
  input [63:0]a,
  input [63:0]b,
  input [3:0]ALUOp,
  input [2:0]Beta,
  output reg [63:0]Result,
  output reg Zero);
  
  always @ (*)
    begin  
      
      case (ALUOp[3:0])
   
        4'b0000: Result = a & b;
        
        4'b0001: Result = a | b;
        
        4'b0010: Result = a + b;
        
        4'b0110: Result = a - b;
        
        4'b1100: Result = ~a & ~b;
        
      endcase
      
      if ((a<b) & Beta == 3'b100)   //BLT
      	Zero = 1;
      else if ((a>=b) & Beta == 3'b101) //BGE
        Zero=1;
      else
        Zero=0;
      
    end
endmodule