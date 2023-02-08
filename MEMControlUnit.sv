module MEMControlUnit (
    input logic [2:0] Funct3,
    input logic MEMControl,
    output logic [2:0] Mode
);

    always_comb begin
        unique case (MEMControl)
            1'b0 : begin
                unique case (Funct3)
                    3'b000 : Mode = 3'b000; //LB
                    3'b001 : Mode = 3'b001; //LH
                    3'b010 : Mode = 3'b010; //LW
                    3'b100 : Mode = 3'b011; //LBU
                    3'b101 : Mode = 3'b100; //LHU
                endcase
            end
            1'b1: begin
                unique case (Funct3)
                    3'b000 : Mode = 3'b101; //SB
                    3'b001 : Mode = 3'b110; //SH
                    3'b010 : Mode = 3'b111; //SW
                endcase
            end 
             
        endcase
    end    
endmodule

          