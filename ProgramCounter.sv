module ProgramCounter #(parameter Width = 32) (
    input logic [Width - 1:0] Next_PC,
    input logic clk, 
    input logic reset,
    output logic [Width - 1:0] Current_PC
);
    initial begin
        Current_PC <= 32'd0;
    end

    always@( posedge clk or posedge reset) begin
        if (reset == 1'b1)
            Current_PC <= 32'd0;
        else
            Current_PC <= Next_PC;
    end
    
endmodule