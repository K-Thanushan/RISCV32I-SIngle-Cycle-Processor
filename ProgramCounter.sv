module ProgramCounter #(parameter Width = 32) (
    input logic [Width - 1:0] Next_PC,
    input logic clk, 
    input logic reset,
    output reg [Width - 1:0] Current_PC
);

    always_ff @( posedge clk ) begin
        if (reset)
            Current_PC = 0;
        else
            Current_PC = Next_PC;
    end
    
endmodule