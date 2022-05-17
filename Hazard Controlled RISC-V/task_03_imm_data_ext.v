module imm_data_ext_3
(
    input [31:0] instruc,
    output reg [63:0] imm_data
);

wire [6:0] opcode;
assign opcode = instruc[6:0];
reg [63:0] imm_data_reg;

always @(*)
begin
    case (opcode)
        7'b0000011: imm_data =  {{52{instruc[31]}}, instruc [31:20]}; //I
        7'b0100011: imm_data = {{52{instruc[31]}}, instruc [31:25], instruc [11:7]}; //S
        7'b1100011: imm_data = {{52{instruc[31]}}, instruc [31] , instruc [7], instruc [30:25], instruc [11:8]};
        7'b0010011: imm_data = {    {52{instruc[31]}}, instruc[31:20] };
        default : imm_data = 64'd0;
    endcase
end

endmodule // imm_data