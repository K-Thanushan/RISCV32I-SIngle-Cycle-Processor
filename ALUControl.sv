module ALUControl (
    input logic [1:0] ALUOpcode,
    input logic [3:0] ALUFunction,
    output logic [3:0] ALUControl
);
    always_comb begin
        unique case (ALUOpcode)
            2'b00 : ALUControl = 4'b0000; //Load or Store type
            2'b01 : begin  //SB type
                unique case (ALUFunction)
                    4'bx000 : ALUControl = 4'b0001; //BEQ
                    4'bx001 : ALUControl = 4'b0001; //BNE
                    4'bx100 : ALUControl = 4'b1011; //BLT
                    4'bx101 : ALUControl = 4'b1100; //BGE
                    4'bx110 : ALUControl = 4'b1101; //BLTU
                    4'bx111 : ALUControl = 4'b1110; //BGEU
					default : ALUControl =4'b0001;
                endcase
            end
            2'b10 : begin
                unique case (ALUFunction)
                    4'b0000 : ALUControl = 4'b0000;
                    4'b1000 : ALUControl = 4'b0001;
                    4'b0001 : ALUControl = 4'b0011;
                    4'b0010 : ALUControl = 4'b1001;
                    4'b0011 : ALUControl = 4'b1010;
                    4'b0100 : ALUControl = 4'b1000;
                    4'b0101 : ALUControl = 4'b0100;
                    4'b1101 : ALUControl = 4'b0101;
                    4'b0110 : ALUControl = 4'b0111;
                    4'b0111 : ALUControl = 4'b0110;
					default : ALUControl =4'b0000;
                endcase
            end
            2'b11 : begin
                unique case (ALUFunction[2:0])
                    3'b000 : ALUControl = 4'b0000;
                    3'b001 : ALUControl = 4'b0011;
                    3'b010 : ALUControl = 4'b1001;
                    3'b011 : ALUControl = 4'b1010;
                    3'b100 : ALUControl = 4'b1000;
                    3'b101 : begin
                        unique case (ALUFunction[3])
                            1'b0 : ALUControl = 4'b0100;
                            1'b1 : ALUControl = 4'b0101;
									 default : ALUControl =4'b0000;
                        endcase
                    end
                    3'b110 : ALUControl = 4'b0111;
                    3'b111 : ALUControl = 4'b0110;
						  default : ALUControl =4'b0000;
                endcase
            end
				default : ALUControl = 4'd0;
        endcase
    end
    
endmodule