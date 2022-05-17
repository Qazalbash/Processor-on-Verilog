module ALU_64_bit(
    input  [63:0] A,
    input  [63:0] B,
    input  [ 3:0] Operation, 
    input  [ 2:0] funct3,
    output reg Zero,
    output reg [63:0] O
);

    always@(*)
        begin
            
            case (Operation)
                4'd0:     O <= A & B; 
                4'd1:     O <= A | B; 
                4'd2:     O <= A + B; 
                4'd6:     O <= A - B; 
                default:  O <=~(A|B);
            endcase
            
            case (funct3)
                3'b000:
                    begin
                        if (O == 64'b0)
                            Zero = 1;
                        else
                            Zero = 0;
                    end
                3'b100:
                    begin
                        if (B < A)
                            Zero = 1;
                        else
                            Zero = 0;
                    end 
            endcase
                
        end
endmodule
