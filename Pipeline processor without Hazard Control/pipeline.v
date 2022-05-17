`include "ALU.v"
`include "ALUControl.v"
`include "Adder.v"
`include "ControlUnit.v" 
`include "DataMemory.v"
`include "EX_MEM.v"
`include "Forwarding_Unit.v"
`include "ID_EX.v"
`include "IF_ID.v"
`include "ImmediateDataExtractor.v"
`include "InstructionMemory.v"
`include "InstructionParser.v"
`include "MEM_WB.v"
`include "MUX.v"
`include "MUX_3bit.v"
`include "ProgramCounter.v"
`include "RegisterFile.v"

module RISC_V_Processor(clk, reset);
  input clk;
  input reset;
  
  wire [63:0] Adder1Out, EX_MEM_ALU_Out, EX_MEM_MUX_ForwardB, EX_MEM_PC_Adder, ID_EX_Immediate, ID_EX_PC_Out, ID_EX_ReadData1, ID_EX_ReadData2, IF_ID_PC_Out, MEM_WB_ALU_Out, MEM_WB_Read_Data, MEM_WB_WriteData, PC_In, PC_Ou, ReadData1, ReadData2, Read_Data, WriteData, data_out, data_out_c1, data_out_c2, imm_data, out1, result;
  
  wire [31:0] IF_ID_Instruction, Instruction;
  
  wire [6:0] opcode, funct7;
  
  wire [4:0] EX_MEM_rd, ID_EX_rd, ID_EX_rs1, ID_EX_rs2, MEM_WB_rd, rd, rs, rs2;
  
  wire [3:0] Funct, ID_EX_Instruction, IF_ID_Instruction_EX, Operation;
  
  wire [2:0] funct3;
  
  wire [1:0] ALUOp, Forward_A, Forward_B, ID_EX_ALUOp;
  
  wire ALUSrc, Branch, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_MemtoReg, EX_MEM_RegWrite, EX_MEM_Zero, ID_EX_ALUSrc, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_MemtoReg, ID_EX_RegWrite, MEM_WB_MemtoReg, MEM_WB_RegWrite, MemRead, MemWrite, MemtoReg, RegWrite, zero;



  Program_Counter a1(clk, reset, PC_In, PC_Out);
  
  Adder a11(PC_Out,64'd4,Adder1Out);
  
  Instruction_Memory a2(PC_Out, Instruction);
  
  IF_ID b1(clk, reset, Instruction, PC_Out, IF_ID_Instruction, IF_ID_PC_Out);
  
  instruction_parser a3(IF_ID_Instruction, opcode, rd, funct3, rs1, rs2, funct7);
  
  Control_Unit a4(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
  
  
  data_extractor a5(IF_ID_Instruction, imm_data);
  
  
  registerFile a6(MEM_WB_WriteData, rs1, rs2, MEM_WB_rd, MEM_WB_RegWrite, clk, reset, ReadData1, ReadData2 );
  
  
  assign IF_ID_Instruction_EX = {IF_ID_Instruction[30], IF_ID_Instruction[14:12]};
  
  ID_EX b2(clk, reset, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
           IF_ID_Instruction_EX, rs1, rs2, rd, imm_data, ReadData1, ReadData2, IF_ID_PC_Out,
           ID_EX_ALUOp, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite,
           ID_EX_ALUSrc, ID_EX_RegWrite, ID_EX_Instruction, ID_EX_rs1, ID_EX_rs2,  ID_EX_rd,
           ID_EX_Immediate, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_PC_Out);
  
  
  Adder a12(ID_EX_PC_Out, ID_EX_Immediate << 1,out1);
  
  mux_3bit c1(ID_EX_ReadData1, MEM_WB_WriteData, EX_MEM_ALU_Out, Forward_A, data_out_c1);
  
  mux_3bit c2(ID_EX_ReadData2, MEM_WB_WriteData, EX_MEM_ALU_Out, Forward_B, data_out_c2);
  
  
  mux c3(data_out_c2, ID_EX_Immediate, ID_EX_ALUSrc, data_out);
  
  

  
  ALU_Control a7(ID_EX_ALUOp, ID_EX_Instruction, Operation);

  
  
  ALU a9(data_out_c1, data_out, Operation, funct3, zero, result);

  F_Unit f1(ID_EX_rs1, ID_EX_rs2, EX_MEM_rd, EX_MEM_RegWrite, MEM_WB_rd, MEM_WB_RegWrite,
            Forward_A, Forward_B);
  
  
  
  EX_MEM b3(clk, reset, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_RegWrite, ID_EX_MemtoReg,
         zero, ID_EX_rd, result, data_out_c2, out1, 
         EX_MEM_Zero, EX_MEM_rd, EX_MEM_MUX_ForwardB,
         EX_MEM_ALU_Out, EX_MEM_PC_Adder, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_RegWrite,
         EX_MEM_MemtoReg);
  
  
  
  Data_Memory a10(EX_MEM_ALU_Out, ReadData2, clk, EX_MEM_MemWrite, EX_MEM_MemRead, Read_Data);
  

  
  Adder a19(PC_Out,64'd4,Adder1Out);
  
  mux a13(Adder1Out, EX_MEM_PC_Adder, EX_MEM_Branch & EX_MEM_Zero, PC_In);

 
  
  MEM_WB b4(clk, reset, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_rd, EX_MEM_ALU_Out, Read_Data,
            MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_rd, MEM_WB_ALU_Out, MEM_WB_Read_Data);
  

  
  mux a14(MEM_WB_ALU_Out, MEM_WB_Read_Data, MEM_WB_MemtoReg, MEM_WB_WriteData);
  
  
endmodule

