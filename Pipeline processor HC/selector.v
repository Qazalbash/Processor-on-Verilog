module selector(
    input branch, ZERO,
    input [63:0] a, b,
    input [2:0] funct3,
    output reg sel
);

always@(*)
begin
    if (branch == 1) 
        begin
            case(funct3)
            3'b101: //bne
            begin
                if(branch == 1 & ZERO == 0)
                    sel = 1;
            end
            3'b011: //beq
            begin
                if(branch == 1 & ZERO == 1)
                    sel = 1;
            end
            3'b111: //bge
            begin
                if (a >= b)
                    sel = 1;
            end
          endcase
        end
    else
        sel <= 0;
end
endmodule