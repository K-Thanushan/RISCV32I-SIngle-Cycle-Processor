module ProgramCounter_tb(

    );
    timeunit 1ns;
    timeprecision 1ps;
    
    localparam CLK_PERIOD = 10;
    logic clk;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end
   
    logic [31:0] Next_PC; 
    logic reset;
    logic [31:0] Current_PC;
    
    ProgramCounter CFSM(.*);
    
    initial begin
        
        @(posedge clk);
        #(CLK_PERIOD*2);
        
        @(posedge clk);
        reset <= 1'b0;
        Next_PC <= 32'd15;
        
        @(posedge clk);
        reset <= 1'b0;
        Next_PC <= 32'd19;

     
     end

  
endmodule
