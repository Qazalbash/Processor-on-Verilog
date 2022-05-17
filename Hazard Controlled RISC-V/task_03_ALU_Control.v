module ALU_Control_3
(
    input [1:0] ALUOp, [3:0] Funct,
    output [3:0] Operation
);

reg [3:0] Op_reg;

always @(*) begin
    case (ALUOp)
    2'b00: begin 
    
        case ({Funct[2:0]})
            3'b001: Op_reg = 4'b0111; //SLLI
            default: Op_reg = 4'b0010; //ADD etc.
        endcase
    
    end
   
   2'b01: begin
        case ({Funct[2:0]})
        3'b000: Op_reg = 4'b0110; //BEQ
        3'b001: Op_reg = 4'b0110; //BNE
        3'b101: Op_reg = 4'b0110; //BGE
        endcase
    end 
    
    2'b10: 
    begin
    
        case (Funct)
        4'b0000: Op_reg = 4'b0010;
        4'b1000: Op_reg = 4'b0110; 
        4'b0111: Op_reg = 4'b0000;
        4'b0110: Op_reg = 4'b0001;
        endcase    
    
    end 
endcase
end

assign Operation = Op_reg;

endmodule // ALU_Contro