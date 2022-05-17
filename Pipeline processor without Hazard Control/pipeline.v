`include "MUX.v"
`include "adder.v"
`include "alu_64.v"
`include "alu_control.v"
`include "control_unit.v"
`include "data_memory.v"
`include "ex_mem.v"
`include "forwarding_unit.v"
`include "id_ex.v"
`include "if_id.v"
`include "immediate_generator.v"
`include "instruction_memory.v"
`include "instruction_parser.v"
`include "mem_wb.v"
`include "program_counter.v"
`include "reg_file.v"

module RISC_V_Processor(clk, reset);
  input clk;
  input reset;
  
  wire [63:0] Adder1Out, EX_MEM_ALU_Out, EX_MEM_MUX_ForwardB, EX_MEM_PC_Adder, ID_EX_Immediate, ID_EX_PC_Out, ID_EX_ReadData1, ID_EX_ReadData2, IF_ID_PC_Out, MEM_WB_ALU_Out, MEM_WB_Read_Data, MEM_WB_WriteData, PC_In, PC_Out, ReadData1, ReadData2, Read_Data, WriteData, data_out, data_out_c1, data_out_c2, imm_data, out1, result;
  
  wire [31:0] IF_ID_Instruction, instruction;
  
  wire [6:0] opcode, funct7;
  
  wire [4:0] EX_MEM_rd, ID_EX_rd, ID_EX_rs1, ID_EX_rs2, MEM_WB_rd, rd, rs1, rs2;
  
  wire [3:0] Funct, ID_EX_Instruction, IF_ID_Instruction_EX, Operation;
  
  wire [2:0] funct3;
  
  wire [1:0] ALUOp, Forward_A, Forward_B, ID_EX_ALUOp;
  
  wire ALUSrc, Branch, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_MemtoReg, EX_MEM_RegWrite, EX_MEM_Zero, ID_EX_ALUSrc, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_MemtoReg, ID_EX_RegWrite, MEM_WB_MemtoReg, MEM_WB_RegWrite, MemRead, MemWrite, MemtoReg, RegWrite, zero;



  Program_Counter PC(clk, reset, PC_In, PC_Out);
  
  Adder adder1(PC_Out,64'd4,Adder1Out);
  
  Instruction_Memory iMem(PC_Out, instruction);
  
  IF_ID if_id(clk, reset, instruction, PC_Out, IF_ID_Instruction, IF_ID_PC_Out);
  
  instruction_parser iParser(IF_ID_Instruction, opcode, rd, funct3, rs1, rs2, funct7);
  
  Control_Unit cu(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
  
  
  immediate_generator Igen(IF_ID_Instruction, imm_data);
  
  
  registerFile rFile(MEM_WB_WriteData, rs1, rs2, MEM_WB_rd, MEM_WB_RegWrite, clk, reset, ReadData1, ReadData2 );
  
  
  assign IF_ID_Instruction_EX = {IF_ID_Instruction[30], IF_ID_Instruction[14:12]};
  
  ID_EX b2(clk, reset, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
           IF_ID_Instruction_EX, rs1, rs2, rd, imm_data, ReadData1, ReadData2, IF_ID_PC_Out,
           ID_EX_ALUOp, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite,
           ID_EX_ALUSrc, ID_EX_RegWrite, ID_EX_Instruction, ID_EX_rs1, ID_EX_rs2,  ID_EX_rd,
           ID_EX_Immediate, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_PC_Out);
  
  
  Adder a12(ID_EX_PC_Out, ID_EX_Immediate << 1,out1);
  
  MUX_3_1 c1(ID_EX_ReadData1, MEM_WB_WriteData, EX_MEM_ALU_Out, Forward_A, data_out_c1);
  
  MUX_3_1 c2(ID_EX_ReadData2, MEM_WB_WriteData, EX_MEM_ALU_Out, Forward_B, data_out_c2);
  
  
  MUX c3(data_out_c2, ID_EX_Immediate, ID_EX_ALUSrc, data_out);
  
  

  
  ALU_Control a7(ID_EX_ALUOp, ID_EX_Instruction, Operation);

  
  
  ALU_64_bit a9(data_out_c1, data_out, Operation, funct3, zero, result);

  F_Unit f1(ID_EX_rs1, ID_EX_rs2, EX_MEM_rd, EX_MEM_RegWrite, MEM_WB_rd, MEM_WB_RegWrite,
            Forward_A, Forward_B);
  
  
  
  EX_MEM b3(clk, reset, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_RegWrite, ID_EX_MemtoReg,
         zero, ID_EX_rd, result, data_out_c2, out1, 
         EX_MEM_Zero, EX_MEM_rd, EX_MEM_MUX_ForwardB,
         EX_MEM_ALU_Out, EX_MEM_PC_Adder, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_RegWrite,
         EX_MEM_MemtoReg);
  
  
  
  Data_Memory a10(EX_MEM_ALU_Out, ReadData2, clk, EX_MEM_MemWrite, EX_MEM_MemRead, Read_Data);
  

  
  Adder a19(PC_Out,64'd4,Adder1Out);
  
  MUX a13(Adder1Out, EX_MEM_PC_Adder, EX_MEM_Branch & EX_MEM_Zero, PC_In);

 
  
  MEM_WB b4(clk, reset, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_rd, EX_MEM_ALU_Out, Read_Data,
            MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_rd, MEM_WB_ALU_Out, MEM_WB_Read_Data);
  

  
  MUX a14(MEM_WB_ALU_Out, MEM_WB_Read_Data, MEM_WB_MemtoReg, MEM_WB_WriteData);
  
  
endmodule

