module ControlUnit (
    input logic [6:0] Opcode,
    output logic Branch,
    output logic MemRead,
    output logic MemtoReg,
    output logic MemWrite,
    output logic ALUSrc,
    output logic RegWrite,
    output logic MEMControl,
    output logic ImGenControl,
    output logic [1:0] ALUOp
);

    always_comb begin
        unique case (Opcode)
            7'b0110011 : begin  //R-Type
                Branch = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b1;
                MEMControl = 1'bx;
                ImGenControl = 3'dx;
                ALUOp = 2'b10;   
            end

            7'b0000011 : begin    //I-Type load
                Branch = 1'b0;
                MemRead = 1'b1;
                MemtoReg = 1'b1;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
                MEMControl = 1'b0;
                ImGenControl = 3'b000;
                ALUOp = 2'b00;
            end

            7'b0100011 : begin    //S-Type store
                Branch = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'bx;
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                RegWrite = 1'b0;
                MEMControl = 1'b1;
                ImGenControl = 3'b001;
                ALUOp = 2'b00;
            end

            7'b1100011 : begin    //SB-Type 
                Branch = 1'b1;
                MemRead = 1'b0;
                MemtoReg = 1'bx;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
                MEMControl = 1'bx;
                ImGenControl = 3'b010;
                ALUOp = 2'b01;
            end

            7'b0010011 : begin    //I-Type immediate
                Branch = 1'b0;
                MemRead = 1'b1;
                MemtoReg = 1'b0;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
                MEMControl = 1'bx;
                ImGenControl = 3'b011;
                ALUOp = 2'b11;
            end 
        endcase
    end
    
endmodule