module instruc_parse_3
(
    input [31:0] instruc,
    output [6:0] opcode,
    output [4:0] rd,
    output [2:0] funct3,
    output [4:0] rs1,
    output [4:0] rs2,
    output [6:0] funct7

);

assign opcode = instruc[6:0];
assign rd = instruc[11:7];
assign funct3 = instruc[14:12];
assign rs1 = instruc[19:15];
assign rs2 = instruc[24:20];
assign funct7 = instruc[31:25];


endmodule // instruc_parse 