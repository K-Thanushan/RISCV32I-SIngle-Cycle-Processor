timeunit 1ns;
timeprecision 1ps;

module SingleCycle_tb();
    localparam CLK_PERIOD = 50;//00000;
    logic clk;
    initial begin
        clk <= 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end
	logic reset;
	
	SingleCycle RP1(
		.clk(clk),
		.reset(reset)
	);
		
	initial
	begin
		@(posedge clk);
        #(CLK_PERIOD*2);

		@(posedge clk);
		reset <= 1'b1;
		
		@(posedge clk);
		reset <= 1'b0;
	end
		
	
	
endmodule