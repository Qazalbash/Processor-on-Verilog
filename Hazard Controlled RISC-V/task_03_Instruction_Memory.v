module Instruction_Memory_3
(
    input [63:0] Inst_Address,
    output [31:0] Instruction
);

reg [7:0] memory [131:0];



initial begin
    
    // memory[0] = 8'b00000011;
    // memory[1] = 8'b00100001;
    // memory[2] = 8'b00000000;
    // memory[3] = 8'b00000000;

    // memory[4] = 8'b10110011;
    // memory[5] = 8'b00000010;
    // memory[6] = 8'b00010001;
    // memory[7] = 8'b00000000;


    //Lab 11 Instructions
    
    // memory[0] = 8'b10000011;
    // memory[1] = 8'b00110100;
    // memory[2] = 8'b10000101;
    // memory[3] = 8'b00000010;
    // memory[0] = 8'b10110011;
    // memory[1] = 8'b10000100;
    // memory[2] = 8'b10011010;
    // memory[3] = 8'b00000000;
    // memory[8] = 8'b10010011;
    // memory[9] = 8'b10000100;
    // memory[10] = 8'b00010100;
    // memory[11] = 8'b00000000;
    // memory[12] = 8'b00100011;
    // memory[13] = 8'b00110100;
    // memory[14] = 8'b10010101;
    // memory[15] = 8'b00000010;
    

    //Bubble sort instructions
    memory[0] = 8'b10010011;
    memory[1] = 8'b00000010;
    memory[2] = 8'b00110000;
    memory[3] = 8'b00000000;
    
    memory[4] = 8'b00100011;
    memory[5] = 8'b00110010;
    memory[6] = 8'b01010000;
    memory[7] = 8'b00000000;

    memory[11] = 8'b00000000;
    memory[10] = 8'b00100000;
    memory[9] = 8'b00000010;
    memory[8] = 8'b10010011;
    
    memory[12] = 8'b00100011;
    memory[13] = 8'b00110110;
    memory[14] = 8'b01010000;
    memory[15] = 8'b00000000;
    
    memory[16] = 8'b10010011;
    memory[17] = 8'b00000010;
    memory[18] = 8'b10100000;
    memory[19] = 8'b00000000;
    
    memory[20] = 8'b00100011;
    memory[21] = 8'b00111010;
    memory[22] = 8'b01010000;
    memory[23] = 8'b00000000;
    
    memory[24] = 8'b00010011;
    memory[25] = 8'b00000101;
    memory[26] = 8'b01000000;
    memory[27] = 8'b00000000;
    
    
    memory[28] = 8'b10010011;
    memory[29] = 8'b00000101;
    memory[30] = 8'b00110000;
    memory[31] = 8'b00000000;
    
    memory[32] = 8'b01100011;
    memory[33] = 8'b00010110;
    memory[34] = 8'b00000101;
    memory[35] = 8'b00000000;
    
    memory[36] = 8'b01100011;
    memory[37] = 8'b10010100;
    memory[38] = 8'b00000101;
    memory[39] = 8'b00000000;
    
    memory[40] = 8'b01100011;
    memory[41] = 8'b00001100;
    memory[42] = 8'b00000000;
    memory[43] = 8'b00000100;
    
    memory[44] = 8'b00010011;
    memory[45] = 8'b00001001;
    memory[46] = 8'b00000000;
    memory[47] = 8'b00000000;
    
    memory[48] = 8'b01100011;
    memory[49] = 8'b00000110;
    memory[50] = 8'b10111001;
    memory[51] = 8'b00000100;
    
    memory[52] = 8'b10110011;
    memory[53] = 8'b00001001;
    memory[54] = 8'b00100000;
    memory[55] = 8'b00000001;
    
    memory[56] = 8'b01100011;
    memory[57] = 8'b10001110;
    memory[58] = 8'b10111001;
    memory[59] = 8'b00000010;
    
    memory[60] = 8'b10010011;
    memory[61] = 8'b00010010;
    memory[62] = 8'b00111001;
    memory[63] = 8'b00000000;
    
    memory[64] = 8'b00010011;
    memory[65] = 8'b10010011;
    memory[66] = 8'b00111001;
    memory[67] = 8'b00000000;
    
    memory[68] = 8'b10110011;
    memory[69] = 8'b10000010;
    memory[70] = 8'b10100010;
    memory[71] = 8'b00000000;
    
    memory[72] = 8'b00110011;
    memory[73] = 8'b00000011;
    memory[74] = 8'b10100011;
    memory[75] = 8'b00000000;
    
    memory[76] = 8'b00000011;
    memory[77] = 8'b10111110;
    memory[78] = 8'b00000010;
    memory[79] = 8'b00000000;
    
    memory[80] = 8'b10000011;
    memory[81] = 8'b00111110;
    memory[82] = 8'b00000011;
    memory[83] = 8'b00000000;
    
    memory[84] = 8'b01100011;
    memory[85] = 8'b01011100;
    memory[86] = 8'b11011110;
    memory[87] = 8'b00000001;
    
    memory[88] = 8'b00110011;
    memory[89] = 8'b00001111;
    memory[90] = 8'b11000000;
    memory[91] = 8'b00000001;
    
    memory[92] = 8'b00110011;
    memory[93] = 8'b00001110;
    memory[94] = 8'b11010000;
    memory[95] = 8'b00000001;
    
    memory[96] = 8'b10110011;
    memory[97] = 8'b00001110;
    memory[98] = 8'b11100000;
    memory[99] = 8'b00000001;
    
    memory[100] =8'b00100011;
    memory[101] =8'b10110000;
    memory[102] =8'b11000010;
    memory[103] =8'b00000001;
    
    memory[104] =8'b00100011;
    memory[105] =8'b00110000;
    memory[106] =8'b11010011;
    memory[107] =8'b00000001;
    
    memory[108] =8'b10010011;
    memory[109] =8'b10001001;
    memory[110] =8'b00011001;
    memory[111] =8'b00000000;
    
    memory[112] =8'b11100011;
    memory[113] =8'b00000100;
    memory[114] =8'b00000000;
    memory[115] =8'b11111100;
    
    memory[116] =8'b00010011; 
    memory[117] =8'b00001001;
    memory[118] =8'b00011001;
    memory[119] =8'b00000000;

    memory[120] =8'b11100011;
    memory[121] =8'b00001100;
    memory[122] =8'b00000000;
    memory[123] =8'b11111010;
    
    memory[124] =8'b01100011;
    memory[125] =8'b00000010;   
    memory[126] =8'b00000000;
    memory[127] =8'b00000000;
    
    memory[128] =8'b00010011;
    memory[129] =8'b00000000;
    memory[130] =8'b00000000;
    memory[131] =8'b00000000;


end

assign Instruction = {memory[Inst_Address+3], memory[Inst_Address+2],
       memory[Inst_Address+1], memory[Inst_Address]}; 


endmodule // Instruction_Memory