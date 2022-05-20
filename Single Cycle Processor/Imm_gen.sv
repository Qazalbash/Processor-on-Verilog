module Immediate_data_extractor(
  input [31:0]Instruction,
  output[63:0]Imm_data);
  reg [11:0]imm;

  always @ (Instruction)
    begin 
        if (Instruction[6:5] == 2'b00)
          imm = Instruction[31:20];
    

  		else if (Instruction[6:5] == 2'b01)
    		imm = {Instruction[31:25], Instruction[11:7]};
  
  		else if (Instruction[6:5] == 2'b11)
    		imm = {Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8]};
    end
  assign Imm_data = {{52{imm[11]}}, imm[11:0]};  
  
endmodule 
        