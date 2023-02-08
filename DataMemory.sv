module DataMemory #(parameter Width = 32) (
    input logic [Width - 1:0] Address,
    input logic [Width - 1:0] W_Data,
    input logic [2:0] Mode,
    input logic clk,
    input logic MemWrite,
    input logic MemRead,
    input logic reset,
    output logic [Width - 1:0] R_Data
);

    reg [7:0] MEM [63:0];
    integer p;
    integer q;

    initial begin
        for ( p = 0; p < 64; p = p + 1) begin
            MEM[p] <= 0;
        end
    end

    //assign R_Data = (MemRead) ? {MEM[Address + 3], MEM[Address + 2], MEM[Address + 1], MEM[Address]} : 32'bx;

    always_ff @( posedge clk or posedge reset) begin
        if (reset == 1'b1)
        begin
            for ( q = 0; q < 64; q = q + 1)
            begin
                MEM[q] <= 0;
            end
        end

        else if (MemWrite == 1'b1)
            begin
                unique case (Mode)
                    3'b101 : begin   //SB
                        MEM[Address] = W_Data[7:0];
                    end
                    3'b110 : begin   //SH
                        MEM[Address + 1] = W_Data[15:8];
                        MEM[Address] = W_Data[7:0];
                    end
                    3'b111 : begin  //SW
                        MEM[Address + 3] = W_Data[31:24];
                        MEM[Address + 2] = W_Data[23:16];
                        MEM[Address + 1] = W_Data[15:8];
                        MEM[Address] = W_Data[7:0];
                    end 
                endcase
            end
        else if (MemRead == 1'b1)
            begin
                unique case (Mode)
                    3'b000 : R_Data = 32'(signed'(MEM[Address])); //LB
                    3'b001 : R_Data = 32'(signed'({MEM[Address + 1], MEM[Address]}));  //LH
                    3'b010 : R_Data = {MEM[Address + 3], MEM[Address + 2], MEM[Address + 1], MEM[Address]};  //LW
                    3'b011 : R_Data = {24'd0, MEM[Address]};  //LBU
                    3'b100 : R_Data = {16'd0, MEM[Address + 1], MEM[Address]};  //LHU
                endcase
            end
    end
    
endmodule