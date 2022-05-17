module RISC_V_Processor_3
(
    input clk, reset
);

wire [63:0] PC_Out;
wire [31:0] instruction;
wire [6:0] opcode; 
wire[4:0] rd;
wire [2:0] funct3;
wire [6:0] funct7;
wire [4:0] rs1, rs2;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire Is_Greater;
wire [1:0] ALUOp;
wire [63:0] MEM_WB_WriteData;
wire [63:0] PC_In;
wire [3:0] ALU_C_Operation;
wire [63:0] ReadData1, ReadData2;
wire [63:0] imm_data;



wire [63:0] fixed_4 = 64'd4;
wire [63:0] Adder1Out;

wire [63:0] alu_mux;

wire [63:0] result;
wire zero;

wire [63:0] imm_to_adder;
wire [63:0] imm_adder_to_mux;

wire [63:0] DM_Read_Data;

wire pc_mux_sel_wire;
wire PCWrite;


wire ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg,
ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_RegWrite;

//ID_EX_ WIRES
wire [63:0] ID_EX_PC_addr, ID_EX_ReadData1, ID_EX_ReadData2,
            ID_EX_imm_data;
wire [3:0] ID_EX_funct_in;
wire [4:0] ID_EX_rd, ID_EX_rs1, ID_EX_rs2;
wire [1:0] ID_EX_ALUOp;

assign imm_to_adder = ID_EX_imm_data<< 1;


//EXMEM WIRES
wire EXMEM_Branch, EXMEM_MemRead, EXMEM_MemtoReg,
EXMEM_MemWrite, EXMEM_RegWrite; 
wire EXMEM_zero, EXMEM_Is_Greater;
wire [63:0] EXMEM_PC_plus_imm, EXMEM_alu_result,
    EXMEM_ReadData2;
wire [3:0] EXMEM_funct_in;
wire [4:0] EXMEM_rd;
wire reset;

//MEMWB WIRES
wire MEMWB_MemtoReg, MEMWB_RegWrite;
wire [63:0] MEMWB_DM_Read_Data, MEMWB_alu_result;
wire [4:0] MEM_WB_rd;


mux_3 pc_mux
(
    .a(EXMEM_PC_plus_imm),   //value when sel is 1
    .b(Adder1Out),
    .sel(pc_mux_sel_wire),
    .data(PC_In)
);

Program_Counter_3 PC (
    .clk(clk),
    .reset(reset),
    .PCWrite(PCWrite),
    .PC_In(PC_In),
    .PC_Out(PC_Out)
);

Adder_3 PC_plus_4
(
    .A(PC_Out),
    .B(fixed_4),
    .out(Adder1Out)
);

Instruction_Memory_3 IM
(
    .Inst_Address(PC_Out),
    .Instruction(instruction)
);

wire [63:0] IF_ID_PC_Out;
wire [31:0] IF_ID_Instruction;
wire IF_ID_Write;


IF_ID_3 IF_ID1
(
    .clk(clk),
    .Flush(reset),
    .IFID_Write(IF_ID_Write),
    .PC_addr(PC_Out),
    .Instruc(instruction),
    .PC_store(IF_ID_PC_Out),
    .Instr_store(IF_ID_Instruction)
);
//IF_ID HERE

wire control_mux_sel;

Hazard_Detection_3 Hazard_Detection
(
    .ID_EX_rd(ID_EX_rd),
    .IFID_rs1(rs1),
    .IFID_rs2(rs2),
    .ID_EX_MemRead(ID_EX_MemRead),
    .ID_EX_mux(control_mux_sel),
    .IFID_Write(IF_ID_Write),
    .PCWrite(PCWrite)
);



instruc_parse_3 instruc_parse1
(
    .instruc(IF_ID_Instruction),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)
);

wire [3:0] IF_ID_Instruction_EX;
assign IF_ID_Instruction_EX = {IF_ID_Instruction[30],IF_ID_Instruction[14:12]};
//assign [63:0] nop_to_mux = 64'd0;

Control_Unit_3 control_unit1
(
    .Opcode(opcode),
    .Branch(Branch), 
    .MemRead(MemRead), 
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite), 
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
);

registerFile_3 reg_file
(
    .clk(clk),
    .reset(reset),
    .RegWrite(MEMWB_RegWrite), //change
    .WriteData(MEM_WB_WriteData),//??
    .RS1(rs1),
    .RS2(rs2),
    .RD(MEM_WB_rd),    //??
    .ReadData1(ReadData1),
    .ReadData2(ReadData2) 
);


imm_data_ext_3 immediate_ext
(
    .instruc(IF_ID_Instruction),
    .imm_data(imm_data)
);

assign MemtoReg_ID_EX_in = control_mux_sel ? MemtoReg : 0;
assign RegWrite_ID_EX_in = control_mux_sel ? RegWrite : 0;
assign Branch_ID_EX_in = control_mux_sel ? Branch : 0;
assign MemWrite_ID_EX_in = control_mux_sel ? MemWrite : 0;
assign MemRead_ID_EX_in = control_mux_sel ? MemRead : 0;
assign ALUSrc_ID_EX_in = control_mux_sel ? ALUSrc : 0;
wire [1:0] ALUop_ID_EX_in;
assign ALUop_ID_EX_in = control_mux_sel ? ALUOp : 2'b00;


ID_EX_3 ID_EX1
(
    .clk(clk),
    .Flush(reset),
    .PC_addr(IF_ID_PC_Out),
    .read_data1(ReadData1),
    .read_data2(ReadData2),
    .imm_val(imm_data),
    .IF_ID_Instruction_EX(IF_ID_Instruction_EX),
    .rd_in(rd),
    .rs1_in(rs1),
    .rs2_in(rs2),
    .RegWrite(RegWrite_ID_EX_in),
    .MemtoReg(MemtoReg_ID_EX_in),
    .Branch(Branch_ID_EX_in),
    .MemWrite(MemWrite_ID_EX_in),
    .MemRead(MemRead_ID_EX_in),
    .ALUSrc(ALUSrc_ID_EX_in),
    .ALU_op(ALUop_ID_EX_in),

    .PC_addr_store(ID_EX_PC_addr),
    .read_data1_store(ID_EX_ReadData1),
    .read_data2_store(ID_EX_ReadData2),
    .imm_val_store(ID_EX_imm_data),
    .funct_in_store(ID_EX_funct_in),
    .rd_in_store(ID_EX_rd),
    .rs1_in_store(ID_EX_rs1),
    .rs2_in_store(ID_EX_rs2),
    .RegWrite_store(ID_EX_RegWrite),
    .MemtoReg_store(ID_EX_MemtoRegID_EX_ALUSrc),
    .Branch_store(ID_EX_BranchID_EX_ALUSrc),
    .MemWrite_store(ID_EX_MemWrite),
    .MemRead_store(ID_EX_MemRead),
    .ALUSrc_store(ID_EX_ALUSrc),
    .ALU_op_store(ID_EX_ALUOp)

);
// ID/EX HERE

ALU_Control_3 ALU_Control1
(
    .ALUOp(ID_EX_ALUOp),
    .Funct(ID_EX_funct_in),
    .Operation(ALU_C_Operation)
);

wire [1:0] fwd_A, fwd_B;

wire [63:0] triplemux_to_a, triplemux_to_b;

mux_3 ALU_mux
(
    .a(ID_EX_imm_data), //value when sel is 1
    .b(triplemux_to_b),
    .sel(ID_EX_ALUSrc),
    .data(alu_mux)
);



mux_triple_3 mux_for_a
(
    .a(ID_EX_ReadData1), //00
    .b(MEM_WB_WriteData), //01
    .c(EXMEM_alu_result),   //10
    .sel(fwd_A),
    .data(triplemux_to_a)  
);

mux_triple_3 mux_for_b
(
    .a(ID_EX_ReadData2), //00
    .b(MEM_WB_WriteData), //01
    .c(EXMEM_alu_result),   //10
    .sel(fwd_B),
    .data(triplemux_to_b)  
);

ALU_64_bit_3 ALU64
(
    .a(triplemux_to_a),
    .b(alu_mux), 
    .ALUOp(ALU_C_Operation),
    .Result(result),
    .Zero(zero),
    .Is_Greater(Is_Greater)
);



Forwarding_Unit_3 Fwd_unit
(
    .EXMEM_rd(EXMEM_rd),
    .MEMWB_rd(MEM_WB_rd),
    .ID_EX_rs1(ID_EX_rs1),
    .ID_EX_rs2(ID_EX_rs2),
    .EXMEM_RegWrite(EXMEM_RegWrite),
    .EXMEM_MemtoReg(EXMEM_MemtoReg),
    .MEMWB_RegWrite(MEMWB_RegWrite),
    .fwd_A(fwd_A),
    .fwd_B(fwd_B)
);


wire [63:0] out1;

Adder_3 PC_plus_imm
(
    .A(ID_EX_PC_addr),
    .B(imm_to_adder),
    .out(out1) //
);

EX_MEM_3 EX_MEM1
(
    .clk(clk),
    .Flush(reset),
    .RegWrite(ID_EX_RegWrite),
    .MemtoReg(ID_EX_MemtoReg),
    .Branch(ID_EX_Branch),
    .Zero(zero),
    .Is_Greater(Is_Greater),
    .MemWrite(ID_EX_MemWrite),
    .MemRead(ID_EX_MemRead),
    .PCplusimm(out1),
    .ALU_result(result),
    .WriteData(triplemux_to_b),
    .IF_ID_Instruction_EX(ID_EX_funct_in),
    .rd(ID_EX_rd),

    .RegWrite_store(EXMEM_RegWrite),
    .MemtoReg_store(EXMEM_MemtoReg),
    .Branch_store(EXMEM_Branch),
    .Zero_store(EXMEM_zero),
    .Is_Greater_store(EXMEM_Is_Greater),
    .MemWrite_store(EXMEM_MemWrite),
    .MemRead_store(EXMEM_MemRead),
    .PCplusimm_store(EXMEM_PC_plus_imm),
    .ALU_result_store(EXMEM_alu_result),
    .WriteData_store(EXMEM_ReadData2),
    .funct_in_store(EXMEM_funct_in),
    .rd_store(EXMEM_rd)
);

// EX/MEM HERE

Branch_Control_3 Branch_Control
(
    .Branch(EXMEM_Branch),
    .Flush(reset),
    .Zero(EXMEM_zero),
    .Is_Greater(EXMEM_Is_Greater),
    .funct(EXMEM_funct_in),
    .switch_branch(pc_mux_sel_wire)
);

Data_Memory_3 Data_Memory
(
    .Mem_Addr(EXMEM_alu_result),
    .Write_Data(EXMEM_ReadData2),
    .clk(clk),
    .MemWrite(EXMEM_MemWrite),
    .MemRead(EXMEM_MemRead),
    .Read_Data(DM_Read_Data) 
);



MEM_WB_3 MEM_WB1
(
    .clk(clk),
    .RegWrite(EXMEM_RegWrite),
    .MemtoReg(EXMEM_MemtoReg),
    .ReadData(DM_Read_Data),
    .ALU_result(EXMEM_alu_result),
    .rd(EXMEM_rd),

    .RegWrite_store(MEMWB_RegWrite),
    .MemtoReg_store(MEMWB_MemtoReg),
    .ReadData_store(MEMWB_DM_Read_Data),
    .ALU_result_store(MEMWB_alu_result),
    .rd_store(MEM_WB_rd)
);

// MEM/WB HERE

mux_3 mux2
(
    .a(MEMWB_DM_Read_Data), //value when sel is 1
    .b(MEMWB_alu_result),
    .sel(MEMWB_MemtoReg),
    .data(MEM_WB_WriteData)
);




// always @(posedge clk) 
//     begin
//         $monitor("PC_In = ", PC_In, ", PC_Out = ", PC_Out, 
//         ", Instruction = %b", IM_to_parse,", Opcode = %b", opcode, 
//         ", Funct3 = %b", funct3, ", rs1 = %d", rs1,
//         ", rs2 = %d", rs2, ", rd = %d", rd, ", funct7 = %b", funct7,
//         ", ALUOp = %b", ALUOp, ", imm_value = %d", imm_data,
//          ", Operation = %b", ALU_C_Operation);
//     end

endmodule // RISC_V_Processor