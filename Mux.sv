module Mux #(parameter Width = 32)(
    input logic [Width - 1:0] A,
    input logic [Width - 1:0] B,
    input logic selection,
    output logic [Width - 1:0] Data
);

    assign Data = selection? B: A;
    
endmodule