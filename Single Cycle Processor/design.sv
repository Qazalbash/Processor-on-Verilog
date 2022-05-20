// Code your design here
`include "PC.sv"
`include "Instruction_memory.sv"
`include "Instruction_parser.sv"
`include "Register_file.sv"
`include "MUX.sv"
`include "ALU.sv"
`include "Data_memory.sv"
`include "Imm_gen.sv"
`include "Adder.sv"
`include "ALU_Control.sv"
`include "Control_Unit.sv"

module RISC_V_Processor(
  input clk,
  input reset
  );
  
  
  wire [63:0] PC_Out;
  wire [63:0] PC_In;
  wire [31:0] Instruction;
  wire [63:0] Out_1;
  wire [63:0] Out_2;
  wire [63:0] Imm_Data;
  wire [63:0] Write_Data;
  wire [63:0] Read_Data_1;
  wire [63:0] Read_Data_2;
  wire [63:0] Data_Out;
  wire [63:0] Result;
  wire [63:0] Read_Data;
  wire [6:0] Opcode;
  wire [6:0] Funct7;
  wire [2:0] Funct3;
  wire [4:0] RD;
  wire [4:0] RS1;
  wire [4:0] RS2;
  wire [1:0] ALUOp;
  wire [3:0] Operation;
  wire Zero;
  wire Regwrite;
  wire Branch;
  wire MemRead;
  wire MemtoReg;
  wire MemWrite;
  wire ALUSrc;
  
  Program_counter PC(
    .PC_In(PC_In),
    .clk(clk),
    .reset(reset),
    .PC_Out(PC_Out)
  );
  
  Instruction_memory Ins_mem(
    .Instr_Addr(PC_Out), 
    .Instruction(Instruction)
  );
  
  Instruction_parser Ins_par(
    .Inst(Instruction), 
    .rs1(RS1), 
    .rs2(RS2), 
    .rd(RD), 
    .opcode(Opcode)
  );
  
  Register_file RF(
    .Write_data(Write_Data), 
    .RS1(RS1), 
    .RS2(RS2), 
    .RD(RD), 
    .Reg_write(Regwrite), 
    .clk(clk), 
    .reset(reset), 
    .Read_data_1(Read_Data_1),
    .Read_data_2(Read_Data_2)
  );
  
  Immediate_data_extractor Imm_gen(
    .Instruction(Instruction), 
    .Imm_data(Imm_Data)
  );
  
  MUX l6(
    .A(Read_Data_2), 
    .B(Imm_Data), 
    .S(ALUSrc), 
    .Y(Data_Out)
  );
  
  ALU_Control ALU_Ctrl(
    .ALUOp(ALUOp), 
    .Funct({Instruction[30], Instruction[14:12]}), 
    .Operation(Operation)
  );
  
  ALU_64_bit ALU(
    .a(Read_Data_1), 
    .b(Data_Out), 
    .ALUOp(Operation), 
    .Beta(Instruction[14:12]), 
    .Result(Result), 
    .Zero(Zero)
  );
  
  Control_Unit C_U(
    .Opcode(Opcode), 
    .Branch(Branch), 
    .MemRead(MemRead), 
    .MemtoReg(MemtoReg), 
    .ALUOp(ALUOp), 
    .MemWrite(MemWrite), 
    .ALUSrc(ALUSrc), 
    .RegWrite(Regwrite)
  );
  
  Adder A10(
    .a(PC_Out), 
    .b(64'd4), 
    .out(Out_1)
  );
  
  Adder A11(
    .a(PC_Out), 
    .b(Imm_Data<<1), 
    .out(Out_2)
  );
  
  MUX l12(
    .A(Out_1), 
    .B(Out_2), 
    .S((Branch&Zero)),
    .Y(PC_In)
  );
  
  Data_Memory Data_Mem(
    .Mem_Addr(Result), 
    .Write_Data(Read_Data_2), 
    .clk(clk), 
    .Mem_Read(MemRead), 
    .Mem_Write(MemWrite), 
    .Read_Data(Read_Data)
  );
  
  MUX l14(
    .A(Result), 
    .B(Read_Data), 
    .S(MemtoReg), 
    .Y(Write_Data)
  );
  
endmodule 
  