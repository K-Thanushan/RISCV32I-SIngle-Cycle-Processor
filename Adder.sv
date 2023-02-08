module Adder (
    input logic [31:0] A,
    input logic [31:0] B,
    output logic [31:0] Sum
);
    always_comb begin
        Sum = A + B;
    end
    
endmodule