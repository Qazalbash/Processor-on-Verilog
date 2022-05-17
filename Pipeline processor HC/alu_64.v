module ALU_64_bit
(
    input      [63:0] A,
    input      [63:0] B,
    input      [ 3:0] ALUOp, 
    output reg [63:0] O,
    output reg        Zero,
    output reg        Is_Greater
);

    always@(*)
        begin
            
            case (ALUOp)
                4'd0:     O <=  A  &  B; 
                4'd1:     O <=  A  |  B; 
                4'd2:     O <=  A  +  B; 
                4'd6:     O <=  A  -  B; 
                default:  O <= ~(A | B);
            endcase
            
            // if (O == 64'd0)
            //     Zero = 1'b1;
            
            // else
            //     Zero = 1'b0;
            
            Zero = (O == 64'd0) ? 1'b1 : 1'b0;

            Is_Greater = (a > b) ? 1'b1 : 1'b0;
                        
        end
endmodule
