module ALU #(parameter Width = 32)(
    input logic [Width - 1:0] Data1,
    input logic [Width - 1:0] Data2,
    input logic [3:0] ALU_Select,
    output logic [Width - 1:0] ALU_Out,
    output logic Zero,
    output logic B_Flag
);

always_comb begin
    unique case(ALU_Select)
        4'b0000 : ALU_Out = Data1 + Data2;
        4'b0001 : ALU_Out = Data1 - Data2;
        4'b0010 : ALU_Out = Data2;
        4'b0011 : ALU_Out = Data1 << Data2;
        4'b0100 : ALU_Out = Data1 >> Data2;
        4'b0101 : ALU_Out = Data1 >>> Data2;
        4'b0110 : ALU_Out = Data1 && Data2;
        4'b0111 : ALU_Out = Data1 || Data2;
        4'b1000 : ALU_Out = Data1 ^ Data2;
        4'b1001 : ALU_Out = Data1 < Data2;
        4'b1010 : ALU_Out = $unsigned(Data1) < $unsigned(Data2);
        default : ALU_Out = 32'd0;
    endcase
end

assign Zero = (ALU_Out == 0);
//assign B_Flag = (ALU_Out[Width - 1] == 0);

always_comb begin
    unique case(ALU_Select)
        4'b1011 : B_Flag = $signed(Data1) < $signed(Data2);
        4'b1100 : B_Flag = $signed(Data1) >= $signed(Data2);
        4'b1101 : B_Flag = $unsigned(Data1) < $unsigned(Data2);
        4'b1110 : B_Flag = $unsigned(Data1) >= $unsigned(Data2);
        default : B_Flag = 1'd0;
    endcase
end

endmodule