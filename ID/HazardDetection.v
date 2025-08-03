module HazardDetectionUnit(
    input [4:0] ID_EX_Rd,       // Destination register in EX stage
    input ID_EX_MemRead,        
    input [4:0] IF_ID_Rn,       // Source register 1 in ID stage
    input [4:0] IF_ID_Rm,       // Source register 2 in ID stage
    output reg PCWrite,
    output reg IF_ID_Write,
    output reg ControlMuxSel    // 1 = stall (zero control signals)
);

always @(*) begin
    if (ID_EX_MemRead && ((ID_EX_Rd == IF_ID_Rn) || (ID_EX_Rd == IF_ID_Rm))) begin
        PCWrite = 0;
        IF_ID_Write = 0;
        ControlMuxSel = 1;
    end else begin
        PCWrite = 1;
        IF_ID_Write = 1;
        ControlMuxSel = 0;
    end
end

endmodule
