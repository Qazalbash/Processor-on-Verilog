module Instruction_parser(
  input reg [31:0]Inst,
  output reg [6:0]opcode,
  output reg [4:0]rd,
  output reg [2:0]funct3,
  output reg [4:0]rs1,
  output reg [4:0]rs2,
  output reg [6:0]funct7);
  
  
  assign opcode = Inst[6:0];
  assign rd = Inst[11:7];
  assign funct3 = Inst[14:12];
  assign rs1 = Inst[19:15];
  assign rs2 = Inst[24:20];
  assign funct7 = Inst[31:25];
endmodule