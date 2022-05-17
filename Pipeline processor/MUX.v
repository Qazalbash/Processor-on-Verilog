module MUX(
    input [63:0] A,
    input [63:0] B,
    input S,
    output [63:0] O
);

assign O = (S==1'b0) ? A: B;

endmodule