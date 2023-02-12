module TOPFPGAModule(
	input logic clk,
   input logic reset,
   input logic OutputSwitch,
   output reg [6:0] Dig_Arr [7:0]
);

	 logic clk_out;
    
    ClockDivider CD(.clk(clk), .divided_clk(clk_out));
    
    logic [31:0] PC_OUT;
    logic [31:0] ALU_OUT;
    
    SingleCycle RVCore(
        .clk(clk_out),
		  .reset(reset),
		  .Result(ALU_OUT),
        .PC_Out(PC_OUT) 
         /////////////// This goes to LED Pin
        );
    
    logic [31:0] Seg_IN;
    
    Processor_Out_Mux POM(
        .switch(OutputSwitch),
        .ALU_Output(ALU_OUT),
        .PC_out(PC_OUT),
        .Seg_IN(Seg_IN)
        );
     
    SEGMENT_7_INTERFACE SEG(
        .data(Seg_IN),
        .dig_arr(Dig_Arr)
        );
		  
endmodule