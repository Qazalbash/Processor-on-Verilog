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

module Instruction_Memory(
  input [63:0] Inst_address,
  output reg [31:0] Instruction);
  
  reg [7:0] instr_mem [75:0];
  
  initial 
    begin
      
      instr_mem[75] = 8'hfb;
      instr_mem[74] = 8'hfe;
      instr_mem[73] = 8'hce;
      instr_mem[72] = 8'he3;
      
      instr_mem[71] = 8'h00;
      instr_mem[70] = 8'h85;
      instr_mem[69] = 8'h05;
      instr_mem[68] = 8'h13;
      
      instr_mem[67] = 8'h00;
      instr_mem[66] = 8'h1e;
      instr_mem[65] = 8'h8e;
      instr_mem[64] = 8'h93;
      
      instr_mem[63] = 8'h00;
      instr_mem[62] = 8'h98;
      instr_mem[61] = 8'h30;
      instr_mem[60] = 8'h23;
      
      instr_mem[59] = 8'h00;
      instr_mem[58] = 8'he5;
      instr_mem[57] = 8'h30;
      instr_mem[56] = 8'h23;
      
      instr_mem[55] = 8'hff;
      instr_mem[54] = 8'hff;
      instr_mem[53] = 8'h44;
      instr_mem[52] = 8'he3;
      
      instr_mem[51] = 8'h00;
      instr_mem[50] = 8'h85;
      instr_mem[49] = 8'h85;
      instr_mem[48] = 8'h93;
      
      instr_mem[47] = 8'h00;
      instr_mem[46] = 8'h1f;
      instr_mem[45] = 8'h0f;
      instr_mem[44] = 8'h13;
      
      instr_mem[43] = 8'h00;
      instr_mem[42] = 8'h08;
      instr_mem[41] = 8'h37;
      instr_mem[40] = 8'h03;
      
      instr_mem[39] = 8'h00;
      instr_mem[38] = 8'h05;
      instr_mem[37] = 8'h88;
      instr_mem[36] = 8'h33;
      
      instr_mem[35] = 8'h01;
      instr_mem[34] = 8'h17;
      instr_mem[33] = 8'h46;
      instr_mem[32] = 8'h63;
      
      instr_mem[31] = 8'h00;
      instr_mem[30] = 8'h05;
      instr_mem[29] = 8'hb8;
      instr_mem[28] = 8'h83;
      
      instr_mem[27] = 8'h00;
      instr_mem[26] = 8'h08;
      instr_mem[25] = 8'h37;
      instr_mem[24] = 8'h03;
      
      instr_mem[23] = 8'h00;
      instr_mem[22] = 8'ha0;
      instr_mem[21] = 8'h08;
      instr_mem[20] = 8'h33;
      
      instr_mem[19] = 8'h00;
      instr_mem[18] = 8'h85;
      instr_mem[17] = 8'h05;
      instr_mem[16] = 8'h93;
      
      instr_mem[15] = 8'h00;
      instr_mem[14] = 8'h05;
      instr_mem[13] = 8'h34;
      instr_mem[12] = 8'h83;
      
      instr_mem[11] = 8'h00;
      instr_mem[10] = 8'h1e;
      instr_mem[9] = 8'h8f;
      instr_mem[8] = 8'h13;
      
      instr_mem[7] = 8'h00;
      instr_mem[6] = 8'h00;
      instr_mem[5] = 8'h0f;
      instr_mem[4] = 8'h13;
      
      instr_mem[3] = 8'h00;
      instr_mem[2] = 8'ha0;
      instr_mem[1] = 8'h0f;
      instr_mem[0] = 8'h93;
      
    end
  
  always @(*)   // Fethcing address.  
      Instruction = {instr_mem[Inst_address +3], instr_mem[Inst_address + 2], instr_mem[Inst_address + 1], instr_mem[Inst_address]};
  
endmodule
// module Instruction_Memory
// (
//     input [63:0] Inst_address,
//     output reg [31:0]Instruction
// );

//     reg [7:0] instr_mem [11:0];

//     initial 
//         begin
//             {instr_mem[3], instr_mem[2], instr_mem[1], instr_mem[0]} = 32'h003100b3; 
//             // add x1 x2 x3
//             {instr_mem[7], instr_mem[6], instr_mem[5], instr_mem[4]} = 32'h00308133; 
//             // add x2 x1 x3
//             {instr_mem[11], instr_mem[10], instr_mem[9], instr_mem[8]} = 32'h00108193; 
//             // addi x3 x1 1      
//         end

//     always @(*)   // Fethcing address.  
//         Instruction = {instr_mem[Inst_address +3], instr_mem[Inst_address + 2], instr_mem[Inst_address + 1], instr_mem[Inst_address]};

// endmodule