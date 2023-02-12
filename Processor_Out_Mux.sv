`timescale 1ns / 1ps


module Processor_Out_Mux(
    input logic switch,
    input logic [31:0] ALU_Output,
    input logic [31:0] PC_out,
    output logic [31:0] Seg_IN
    );
    
    assign Seg_IN = switch ? ALU_Output : PC_out;
endmodule
