module Instruction_memory(
  input [63:0]Instr_Addr,
  output reg [31:0]Instruction);
  
  reg [7:0]I_Memory[75:0];
  
  initial 
    begin
      
      I_Memory[75] = 8'hfb;
      I_Memory[74] = 8'hfe;
      I_Memory[73] = 8'hce;
      I_Memory[72] = 8'he3;
      
      I_Memory[71] = 8'h00;
      I_Memory[70] = 8'h85;
      I_Memory[69] = 8'h05;
      I_Memory[68] = 8'h13;
      
      I_Memory[67] = 8'h00;
      I_Memory[66] = 8'h1e;
      I_Memory[65] = 8'h8e;
      I_Memory[64] = 8'h93;
      
      I_Memory[63] = 8'h00;
      I_Memory[62] = 8'h98;
      I_Memory[61] = 8'h30;
      I_Memory[60] = 8'h23;
      
      I_Memory[59] = 8'h00;
      I_Memory[58] = 8'he5;
      I_Memory[57] = 8'h30;
      I_Memory[56] = 8'h23;
      
      I_Memory[55] = 8'hff;
      I_Memory[54] = 8'hff;
      I_Memory[53] = 8'h44;
      I_Memory[52] = 8'he3;
      
      I_Memory[51] = 8'h00;
      I_Memory[50] = 8'h85;
      I_Memory[49] = 8'h85;
      I_Memory[48] = 8'h93;
      
      I_Memory[47] = 8'h00;
      I_Memory[46] = 8'h1f;
      I_Memory[45] = 8'h0f;
      I_Memory[44] = 8'h13;
      
      I_Memory[43] = 8'h00;
      I_Memory[42] = 8'h08;
      I_Memory[41] = 8'h37;
      I_Memory[40] = 8'h03;
      
      I_Memory[39] = 8'h00;
      I_Memory[38] = 8'h05;
      I_Memory[37] = 8'h88;
      I_Memory[36] = 8'h33;
      
      I_Memory[35] = 8'h01;
      I_Memory[34] = 8'h17;
      I_Memory[33] = 8'h46;
      I_Memory[32] = 8'h63;
      
      I_Memory[31] = 8'h00;
      I_Memory[30] = 8'h05;
      I_Memory[29] = 8'hb8;
      I_Memory[28] = 8'h83;
      
      I_Memory[27] = 8'h00;
      I_Memory[26] = 8'h08;
      I_Memory[25] = 8'h37;
      I_Memory[24] = 8'h03;
      
      I_Memory[23] = 8'h00;
      I_Memory[22] = 8'ha0;
      I_Memory[21] = 8'h08;
      I_Memory[20] = 8'h33;
      
      I_Memory[19] = 8'h00;
      I_Memory[18] = 8'h85;
      I_Memory[17] = 8'h05;
      I_Memory[16] = 8'h93;
      
      I_Memory[15] = 8'h00;
      I_Memory[14] = 8'h05;
      I_Memory[13] = 8'h34;
      I_Memory[12] = 8'h83;
      
      I_Memory[11] = 8'h00;
      I_Memory[10] = 8'h1e;
      I_Memory[9] = 8'h8f;
      I_Memory[8] = 8'h13;
      
      I_Memory[7] = 8'h00;
      I_Memory[6] = 8'h00;
      I_Memory[5] = 8'h0f;
      I_Memory[4] = 8'h13;
      
      I_Memory[3] = 8'h00;
      I_Memory[2] = 8'ha0;
      I_Memory[1] = 8'h0f;
      I_Memory[0] = 8'h93;
      
    end
  
  always @(*)   // Fethcing address.  
      Instruction = {I_Memory[Instr_Addr +3], I_Memory[Instr_Addr + 2], I_Memory[Instr_Addr + 1], I_Memory[Instr_Addr]};
  
endmodule