module Register_file(
  input [63:0]Write_data, 
  input [4:0]RS1,
  input [4:0]RS2,
  input [4:0]RD,
  input Reg_write,
  input clk,
  input reset,
  output reg [63:0]Read_data_1,
  output reg [63:0]Read_data_2,
  output reg [63:0]x25,
  output reg [63:0]x27, 
  output reg [63:0]x22,
  output reg [63:0]x23,
  output reg [63:0]x5,
  output reg [63:0]x6,
  output reg [63:0]x20,
  output reg [63:0]x21,
  output reg [63:0]x12);
 
  reg [63:0]Register[31:0];
  
  initial 
    begin 
      
      for (integer i=0;i<32;i++)
        Register[i] = 0; 
    end
  
  always @(posedge clk)    // write data 
    
    if (Reg_write)
      Register[RD] = Write_data;    
    
  always @(*)   // Read data
    
    begin
      
      if(reset)
        begin 
          Read_data_1 = 0;
          Read_data_2 = 0;
        end
      
      else
        begin
      	  Read_data_1 = Register[RS1];
          Read_data_2 = Register[RS2];
        end
    end
  
  
  always @(negedge clk)
    begin
      x25 = Register[25];
      x27 = Register[27];
      x22 = Register[22];
      x23 = Register[23];
      x5 = Register[5];
      x6 = Register[6];
      x20 = Register[20];
      x21 = Register[21];
      x12 = Register[12];
    end
  
endmodule 
