module IF_ID_3
(

    input clk, IF_ID_Write, Flush,
    input [63:0] PC_Out,
    input [31:0] Instruction,
    output reg [63:0] IF_ID_PC_Out,
    output reg [31:0] IF_ID_Instruction
);

    always @(posedge clk)
        begin
            if (Flush)
                begin
                    IF_ID_PC_Out = 0;
                    IF_ID_Instruction = 0;
                end
            else if (!IF_ID_Write)
                begin
                    IF_ID_PC_Out = IF_ID_PC_Out;
                    IF_ID_Instruction = IF_ID_Instruction;
                end
            else
                begin
                    IF_ID_PC_Out = PC_Out;
                    IF_ID_Instruction = Instruction;
                end
        end



endmodule // IF_ID  