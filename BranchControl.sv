module BranchControl (
    input logic Branch,
    input logic zero,
    input logic B_Flag,
    input logic [2:0] Funct3,
    output logic BranchCondition
);

    always_comb begin
        unique case (Branch)
            1'b0 : BranchCondition = 1'b0;
            1'b1 : begin
                unique case (Funct3)
                    3'b000 : begin
                        unique case (zero)
                            1'b0 : BranchCondition = 1'b0;
                            1'b1 : BranchCondition = 1'b1; 
                        endcase
                    end
                    3'b001 : begin
                        unique case (zero)
                            1'b0 : BranchCondition = 1'b1;
                            1'b1 : BranchCondition = 1'b0; 
                        endcase
                    end
                    3'b100 : begin
                        unique case (B_Flag)
                            1'b0 : BranchCondition = 1'b0;
                            1'b1 : BranchCondition = 1'b1; 
                        endcase
                    end
                    3'b101 : begin
                        unique case (B_Flag)
                            1'b0 : BranchCondition = 1'b0;
                            1'b1 : BranchCondition = 1'b1; 
                        endcase
                    end
                    3'b110 : begin
                        unique case (B_Flag)
                            1'b0 : BranchCondition = 1'b0;
                            1'b1 : BranchCondition = 1'b1; 
                        endcase
                    end
                    3'b111 : begin
                        unique case (B_Flag)
                            1'b0 : BranchCondition = 1'b0;
                            1'b1 : BranchCondition = 1'b1; 
                        endcase
                    end
                endcase
            end
        endcase
    end
endmodule