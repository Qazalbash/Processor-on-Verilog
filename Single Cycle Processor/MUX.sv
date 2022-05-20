module MUX( input [63:0]A, input [63:0]B, input S, output reg [63:0]Y);
	assign Y = S?B:A;
endmodule