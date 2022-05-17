// module Instruction_Memory (
//     input  [63:0] Inst_address,
//     output reg [31:0] Instruction
// );
//     reg [7:0] instr_mem [15:0]; // 16 bitsx8 = 16 bytes

//     initial
//     begin
//         instr_mem [ 0] = 8'b10000011;
//         instr_mem [ 1] = 8'b00110100;
//         instr_mem [ 2] = 8'b10000101;
//         instr_mem [ 3] = 8'b00000010;
//         instr_mem [ 4] = 8'b10110011;
//         instr_mem [ 5] = 8'b10000100;
//         instr_mem [ 6] = 8'b10011010;
//         instr_mem [ 7] = 8'b00000000;
//         instr_mem [ 8] = 8'b10010011;
//         instr_mem [ 9] = 8'b10000100;
//         instr_mem [10] = 8'b00010100;
//         instr_mem [11] = 8'b00000000;
//         instr_mem [12] = 8'b00100011;
//         instr_mem [13] = 8'b00110100;
//         instr_mem [14] = 8'b10010101;
//         instr_mem [15] = 8'b00000010;   
//     end
    
//     always @(Inst_address)
//     begin
//         case(Inst_address)
//             64'd0 : Instruction = {instr_mem[ 3], instr_mem[ 2], instr_mem[ 1], instr_mem[ 0]};
//             64'd4 : Instruction = {instr_mem[ 7], instr_mem[ 6], instr_mem[ 5], instr_mem[ 4]};
//             64'd8 : Instruction = {instr_mem[11], instr_mem[10], instr_mem[ 9], instr_mem[ 8]};
//             64'd12: Instruction = {instr_mem[15], instr_mem[14], instr_mem[13], instr_mem[12]};
//         endcase
//     end

// endmodule


module Instruction_Memory
(
    input [63:0] Inst_address,
    output reg [31:0]Instruction
);

    reg [7:0] I_Memory [11:0];

    initial 
        begin
            {I_Memory[3], I_Memory[2], I_Memory[1], I_Memory[0]} = 32'h003100b3; 
            // add x1 x2 x3
            {I_Memory[7], I_Memory[6], I_Memory[5], I_Memory[4]} = 32'h00308133; 
            // add x2 x1 x3
            {I_Memory[11], I_Memory[10], I_Memory[9], I_Memory[8]} = 32'h00108193; 
            // addi x3 x1 1      
        end

    always @(*)   // Fethcing address.  
        Instruction = {I_Memory[Inst_address +3], I_Memory[Inst_address + 2], I_Memory[Inst_address + 1], I_Memory[Inst_address]};

endmodule