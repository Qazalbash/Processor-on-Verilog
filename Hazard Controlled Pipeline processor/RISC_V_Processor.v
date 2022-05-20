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
`include "hazard_control.v"
`include "branch_control.v"

module RISC_V_Processor(
    input clk, reset
);
    wire [63: 0] ALUresult, Adder1Out, Adder2Out, EX_MEM_ALU_Out, EX_MEM_MUX_ForwardB, EX_MEM_PC_Adder, ID_EX_Immediate, ID_EX_PC_Out, ID_EX_ReadData1;
    wire [63: 0] ID_EX_ReadData2, IF_ID_PC_Out, MEM_WB_ALU_Out, MEM_WB_Read_Data, MEM_WB_WriteData, MuxALUOut, MuxMemOut, PC_In, PC_Out, ReadData1, ReadData2;
    wire [63: 0] ReadDataMem, Read_Data, WriteData, data_out, triplemux_to_a, triplemux_to_b, imm_data, out1, result;
    
    wire [31: 0] instruction, IF_ID_Instruction;
    
    wire [ 6: 0] Opcode, funct7;
    
    wire [ 4: 0] EX_MEM_rd, ID_EX_rd, ID_EX_rs1, ID_EX_rs2, MEM_WB_rd, rd, rs1, rs2;
    
    wire [ 3: 0] Funct, Operation, ID_EX_Instruction, IF_ID_Instruction_EX, EX_MEM_funct_in;
    
    wire [ 2: 0] funct3;
    
    wire [ 1: 0] ALUOp, Forward_A, Forward_B, ID_EX_ALUOp;
    
    wire ALUSrc, Branch, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_MemtoReg, EX_MEM_RegWrite, EX_MEM_Zero, ID_EX_ALUSrc, ID_EX_Branch;
    wire ID_EX_MemRead, ID_EX_MemWrite, ID_EX_MemtoReg, ID_EX_RegWrite, MEM_WB_MemtoReg, MEM_WB_RegWrite, MemRead, MemWrite, MemtoReg, RegWrite;
    wire pc_mux_sel_wire, Is_Greater,EX_MEM_Is_Greater;

    MUX pc_mux(
        .A(EX_MEM_PC_Adder),
        .B(Adder1Out),
        .S(pc_mux_sel_wire),
        .O(PC_In)
    );
    
    Program_Counter PC(
            .clk(clk),
            .reset(reset),
            .PC_In(PC_In),
            .PC_Out(PC_Out)
        );
    
    Adder add1(
            .a(64'd4),
            .b(PC_Out),
            .c(Adder1Out)
        );

    Instruction_Memory iMem(
            .Inst_address(PC_Out),
            .Instruction(instruction)
        );
    
    wire IF_ID_Write_out;


    IF_ID if_id(
            .clk(clk),
            .Flush(reset),
            .IF_ID_Write(IF_ID_Write_out),
            .Instruction(instruction),
            .PC_Out(PC_Out),
            .IF_ID_Instruction(IF_ID_Instruction),
            .IF_ID_PC_Out(IF_ID_PC_Out)
        );

    wire control_mux_sel;

    Hazard_Detection_3 Hazard_Detection(
            .ID_EX_rd(ID_EX_rd),
            .IF_ID_rs1(rs1),
            .IF_ID_rs2(rs2),
            .ID_EX_MemRead(ID_EX_MemRead_out),
            .ID_EX_mux_out(control_mux_sel),
            .IF_ID_Write(IF_ID_Write_out)
        );

    instruction_parser iParser(
            .instruction(IF_ID_Instruction),
            .opcode(Opcode),
            .rd(rd),
            .rs1(rs1),
            .rs2(rs2),
            .funct3(funct3),
            .funct7(funct7)
        );

    Control_Unit cu(
            .Opcode(Opcode),
            .Branch(Branch), 
            .MemRead(MemRead), 
            .MemtoReg(MemtoReg), 
            .MemWrite(MemWrite), 
            .ALUSrc(ALUSrc), 
            .RegWrite(RegWrite), 
            .ALUOp(ALUOp)
        );
    
    registerFile rFile(
            .clk(clk), 
            .reset(reset), 
            .WriteData(MEM_WB_WriteData), 
            .rs1(rs1), 
            .rs2(rs2), 
            .rd(MEM_WB_rd), 
            .RegWrite(MEM_WB_RegWrite), 
            .ReadData1(ReadData1),
            .ReadData2(ReadData2)
        );

    assign IF_ID_Instruction_EX = {
            IF_ID_Instruction[30],
            IF_ID_Instruction[14:12]
        };

    immediate_generator Igen(
            .instruction(IF_ID_Instruction),
            .immed_value(imm_data)
        );

    assign MemtoReg_IDEXin = control_mux_sel ? MemtoReg_out : 0;
    assign RegWrite_IDEXin = control_mux_sel ? RegWrite_out : 0;
    assign Branch_IDEXin = control_mux_sel ? Branch_out : 0;
    assign MemWrite_IDEXin = control_mux_sel ? MemWrite_out : 0;
    assign MemRead_IDEXin = control_mux_sel ? MemRead_out : 0;
    assign ALUSrc_IDEXin = control_mux_sel ? ALUSrc_out : 0;
    wire [1:0] ALUop_IDEXin;
    assign ALUop_IDEXin = control_mux_sel ? ALUOp_out : 2'b00;

    ID_EX id_ex(
            .clk(clk),
            .reset(reset),
            
            .ALU_Op(ALUop_IDEXin),
            .Branch(Branch_IDEXin),
            .MemRead(MemRead_IDEXin),
            .MemtoReg(MemtoReg_IDEXin),
            .MemWrite(MemWrite_IDEXin),
            .ALUSrc(ALUSrc_IDEXin),
            .RegWrite(RegWrite_IDEXin),
            
            .IF_ID_Ins(IF_ID_Instruction_EX),
            .IF_ID_rs1(rs1),
            .IF_ID_rs2(rs2),
            .IF_ID_rd(rd),
            .IF_ID_Immediate(imm_data),
            .IF_ID_ReadData1(ReadData1),
            .IF_ID_ReadData2(ReadData2),
            .IF_ID_PC_Out(IF_ID_PC_Out),
            
            .ID_EX_ALU_Op(ID_EX_ALUOp),
            .ID_EX_Branch(ID_EX_Branch),
            .ID_EX_MemRead(ID_EX_MemRead),
            .ID_EX_MemtoReg(ID_EX_MemtoReg),
            .ID_EX_MemWrite(ID_EX_MemWrite),
            .ID_EX_ALUSrc(ID_EX_ALUSrc),
            .ID_EX_RegWrite(ID_EX_RegWrite),

            .ID_EX_Ins(ID_EX_Instruction),
            .ID_EX_rs1(ID_EX_rs1),
            .ID_EX_rs2(ID_EX_rs2),
            .ID_EX_rd(ID_EX_rd),
            .ID_EX_Immediate(ID_EX_Immediate),
            .ID_EX_ReadData1(ID_EX_ReadData1),
            .ID_EX_ReadData2(ID_EX_ReadData2),
            .ID_EX_PC_Out(ID_EX_PC_Out)
        );

    ALU_Control ac1(
            .ALUOp(ID_EX_ALUOp),
            .Funct(ID_EX_Instruction),
            .Operation(Operation)
        );
    
    Adder add2(
            .a(ID_EX_PC_Out),
            .b(ID_EX_Immediate << 1),
            .c(out1)
        );
    
    MUX_3_1 muxBranch1(
            .A(ID_EX_ReadData1),
            .B(MEM_WB_WriteData),
            .C(EX_MEM_ALU_Out),
            .O(triplemux_to_a),
            .S(Forward_A)
    );
    
    MUX_3_1 muxBranch2(
            .A(ID_EX_ReadData2),
            .B(MEM_WB_WriteData),
            .C(EX_MEM_ALU_Out),
            .O(triplemux_to_b),
            .S(Forward_B)
    );

    MUX muxBranch(
            .A(triplemux_to_b),
            .B(ID_EX_Immediate),
            .O(data_out),
            .S(ID_EX_ALUSrc)
        );
    

    ALU_64_bit ALU64(
            .A(triplemux_to_a),
            .B(data_out),
            .Operation(Operation),
            .funct3(funct3),
            .Zero(zero), 
            .O(result),
            .Is_Greater(Is_Greater)
        );

    F_Unit f1(
            .ID_EX_rs1(ID_EX_rs1),
            .ID_EX_rs2(ID_EX_rs2),
            .EX_MEM_rd(EX_MEM_rd),
            .EX_MEM_RegWrite(EX_MEM_RegWrite),
            .MEM_WB_rd(MEM_WB_rd),
            .MEM_WB_RegWrite(MEM_WB_RegWrite),
            .Forward_A(Forward_A),
            .Forward_B(Forward_B)
        );

    EX_MEM b3(
            .clk(clk),
            .reset(reset),
            
            .ID_EX_Branch(ID_EX_Branch),
            .ID_EX_MemRead(ID_EX_MemRead),
            .ID_EX_MemWrite(ID_EX_MemWrite),
            .ID_EX_RegWrite(ID_EX_RegWrite),
            .ID_EX_MemtoReg(ID_EX_MemtoReg),
            
            .Zero(zero),
            
            .ID_EX_rd(ID_EX_rd),
            
            .ALU_Out(result),
            .MUX_ForwardB(triplemux_to_b),
            .PC_Adder(out1),
            
            .EX_MEM_Zero(EX_MEM_Zero),
            .EX_MEM_Is_Greater(EX_MEM_Is_Greater),
            
            .EX_MEM_rd(EX_MEM_rd),
            
            .EX_MEM_MUX_ForwardB(EX_MEM_MUX_ForwardB),
            .EX_MEM_ALU_Out(EX_MEM_ALU_Out),
            .EX_MEM_PC_Adder(EX_MEM_PC_Adder),
            
            .EX_MEM_Branch(EX_MEM_Branch),
            .EX_MEM_MemRead(EX_MEM_MemRead),
            .EX_MEM_MemWrite(EX_MEM_MemWrite),
            .EX_MEM_RegWrite(EX_MEM_RegWrite),
            .EX_MEM_MemtoReg(EX_MEM_MemtoReg)
        );
    
    Branch_Control_3 Branch_Control(
            .Branch(EX_MEM_Branch),
            .Flush(reset),
            .Zero(EX_MEM_Zero),
            .Is_Greater(EX_MEM_Is_Greater),
            .funct(EX_MEM_funct_in),
            .switch_branch(pc_mux_sel_wire)
        );
    
    Data_Memory DMem(
            .Mem_Addr(EX_MEM_ALU_Out),
            .WriteData(EX_MEM_MUX_ForwardB),
            .clk(clk),
            .MemWrite(EX_MEM_MemWrite), 
            .MemRead(EX_MEM_MemRead), 
            .Read_Data(Read_Data)
        );

    Adder add3(
            .a(64'd4),
            .b(PC_Out),
            .c(Adder1Out)
        );

    MUX muxMemory(
            .A(Adder1Out),
            .B(EX_MEM_PC_Adder),
            .O(PC_In),
            .S(EX_MEM_Branch & EX_MEM_Zero)
        );

    MEM_WB b4(
            .clk(clk),
            .reset(reset),
            .EX_MEM_RegWrite(EX_MEM_RegWrite),
            .EX_MEM_MemtoReg(EX_MEM_MemtoReg),
            .EX_MEM_rd(EX_MEM_rd),
            .EX_MEM_ALU_Out(EX_MEM_ALU_Out),
            .Read_Data(Read_Data),
            .MEM_WB_RegWrite(MEM_WB_RegWrite),
            .MEM_WB_MemtoReg(MEM_WB_MemtoReg),
            .MEM_WB_rd(MEM_WB_rd),
            .MEM_WB_ALU_Out(MEM_WB_ALU_Out),
            .MEM_WB_Read_Data(MEM_WB_Read_Data)
        );

    MUX a14(
            .A(MEM_WB_Read_Data),
            .B(MEM_WB_ALU_Out),
            .S(MEM_WB_MemtoReg),
            .O(MEM_WB_WriteData)
        );

endmodule
