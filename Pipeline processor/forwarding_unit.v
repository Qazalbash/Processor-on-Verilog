module F_Unit
(
  input [4:0] ID_EX_rs1,
  input [4:0] ID_EX_rs2,
  input [4:0] EX_MEM_rd,
  input EX_MEM_RegWrite,
  input [4:0] MEM_WB_rd,
  input MEM_WB_RegWrite,
  
  output reg [1:0] Forward_A, Forward_B

);

  
  always @(*)
    begin
      
      
                       //Forward A
      
      //1a. EX/MEM.RegisterRd == ID/EX.RegisterRs1
      if ((EX_MEM_rd == ID_EX_rs1) && (EX_MEM_RegWrite == 1) && (EX_MEM_rd != 0))

		Forward_A = 2'b10;   //ForwardA = 10
      
		
	  //2a. MEM/WB.RegisterRd == ID/EX.RegisterRs1
      else if ((MEM_WB_rd == ID_EX_rs1) && (MEM_WB_RegWrite == 1) && (MEM_WB_rd != 0) && !(EX_MEM_RegWrite == 1 && EX_MEM_rd != 0 && EX_MEM_rd == ID_EX_rs1))
        
		Forward_A = 2'b01;  //ForwardA = 01
      
      
      else
        Forward_A = 2'b00; //ForwardA = 00
			
      
      
      
      				//Forward B

		
      //1b. EX/MEM.RegisterRd == ID/EX.RegisterRs2
      if ((EX_MEM_rd == ID_EX_rs2) && (EX_MEM_RegWrite == 1) && (EX_MEM_rd != 0))

		Forward_B = 2'b10;   //ForwardB = 10
		
      //2b. MEM/WB.RegisterRd == ID/EX.RegisterRs2
      else if ((MEM_WB_rd == ID_EX_rs2) && (MEM_WB_RegWrite == 1) && (MEM_WB_rd != 0) &&!(EX_MEM_RegWrite == 1 && EX_MEM_rd != 0 && EX_MEM_rd == ID_EX_rs2))
        
		Forward_B = 2'b01;  //ForwardB = 01
      
      
      else
        Forward_B = 2'b00; //ForwardB = 00
    
    
    end

endmodule