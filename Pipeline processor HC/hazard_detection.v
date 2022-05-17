module Hazard_Detection
(
    input [4:0] ID_EX_rd, IF_ID_rs1, IF_ID_rs2,
    input ID_EX_MemRead,
    output reg ID_EX_mux_out,
    output reg IF_ID_Write, PCWrite
);

always@(*)
begin    
    if (ID_EX_MemRead && (ID_EX_rd == IF_ID_rs1 || ID_EX_rd == IF_ID_rs2))
        begin
            ID_EX_mux_out = 0;
            IF_ID_Write = 0;
            PCWrite = 0;
        end
    else
        begin
            ID_EX_mux_out = 1;
            IF_ID_Write = 1;
            PCWrite = 1;
        end

end

endmodule // Hazard_Detection