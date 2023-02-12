module ClockDivider(
  input wire clk,
  output reg divided_clk
);
   
  reg[27:0] counter = 28'd0;
  parameter DIVISOR = 28'd50000000;

  always @(posedge clk)
  begin
    counter <= counter + 28'd1;
    if(counter>=(DIVISOR-1))
    counter <= 28'd0;

    divided_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
end
 
endmodule
