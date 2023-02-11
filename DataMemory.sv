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
    logic [29:0] Block_Address;
    logic [1:0] Index;
    reg [7:0] MEM [0:127][0:3];
    integer p;
    integer q;
    integer m;
    integer n;

    initial begin
        for (p = 0; p < 128; p = p + 1)begin
            for (q = 0; q < 3; q = q + 1) begin
                MEM[p][q] <= 0;
            end
        end
    end

    //assign R_Data = (MemRead) ? {MEM[Block_Address][Index + 3], MEM[Block_Address][Index + 2], MEM[Block_Address][Index + 1], MEM[Block_Address][Index]} : 32'bx;

    always_ff @( posedge clk or posedge reset) begin
        if (reset == 1'b1)
        begin
            for (m = 0; m < 128; m = m + 1)
            begin
                for (n = 0; n < 3; n = n + 1) begin
                    MEM[p][q] <= 0;
                end
            end
        end

        else if (MemWrite == 1'b1)
            begin
                unique case (Mode)
                    3'b101 : begin   //SB
                        MEM[Block_Address][Index] <= W_Data[7:0];
                    end
                    3'b110 : begin   //SH
                        MEM[Block_Address][Index + 1] <= W_Data[15:8];
                        MEM[Block_Address][Index] <= W_Data[7:0];
                    end
                    3'b111 : begin  //SW
                        MEM[Block_Address][Index + 3] <= W_Data[31:24];
                        MEM[Block_Address][Index + 2] <= W_Data[23:16];
                        MEM[Block_Address][Index + 1] <= W_Data[15:8];
                        MEM[Block_Address][Index] <= W_Data[7:0];
                    end 
                endcase
            end
        else if (MemRead == 1'b1)
            begin
                unique case (Mode)
                    3'b000 : R_Data <= 32'(signed'(MEM[Block_Address][Index])); //LB
                    3'b001 : R_Data <= 32'(signed'({MEM[Block_Address][Index + 1], MEM[Block_Address][Index]}));  //LH
                    3'b010 : R_Data <= {MEM[Block_Address][Index + 3], MEM[Block_Address][Index + 2], MEM[Block_Address][Index + 1], MEM[Block_Address][Index]};  //LW
                    3'b011 : R_Data <= {24'd0, MEM[Block_Address][Index]};  //LBU
                    3'b100 : R_Data <= {16'd0, MEM[Block_Address][Index + 1], MEM[Block_Address][Index]};  //LHU
                endcase
            end
    end
    
endmodule