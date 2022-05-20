// Code your testbench here
// or browse Examples
module tb;
  reg dclk;
  reg dreset;
  
  initial
    begin 
      dclk = 0;
      dreset = 1;
      #10 
      dreset = 0;
      #4000
      $finish; 
    end
  always 
    #5 dclk = ~dclk;
  
  RISC_V_Processor R1(dclk,dreset);
  
  initial 
    begin
      $dumpfile("testResults.vcd");
      $dumpvars();
      $monitor("Time=%0d, clk =%b, reset =%b", $time, dclk, dreset);
    end 
endmodule 
