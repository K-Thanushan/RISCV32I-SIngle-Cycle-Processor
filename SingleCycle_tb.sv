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

/*module SingleCycle_tb();

// Input and output signals
reg clk;
reg reset;

// Test bench top level
initial begin
  // Initialize input signals
  clk = 0;
  reset = 1;

  // Wait 100 ns for global reset to finish
  #1000;

  // Release reset
  reset = 0;

  // Clock generator
  forever begin
    #500 clk = ~clk;
  end
end

// Connect DUT to test bench
SingleCycle dut (
  .clk(clk),
  .reset(reset),
);
endmodule*/