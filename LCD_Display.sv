module LCD_Display #(parameter Width = 32)(
  input logic [Width-1:0] data,
  output logic [7:0] rs,
  output logic [7:0] e,
  output logic [7:0] d0,
  output logic [7:0] d1,
  output logic [7:0] d2,
  output logic [7:0] d3,
  output logic [7:0] d4,
  output logic [7:0] d5,
  output logic [7:0] d6,
  output logic [7:0] d7
);

  reg [31:0] lcd_data;
  reg [7:0] lcd_char [4];

  always @ (data) begin
    lcd_data = data;
    for (int i = 0; i < 4; i = i + 1) begin
      lcd_char[i] = lcd_data[i*8 + 7:i*8];
    end
  end

  assign rs = 8'b00000001;
  assign e = 8'b10000000;
  assign d0 = lcd_char[0];
  assign d1 = lcd_char[1];
  assign d2 = lcd_char[2];
  assign d3 = lcd_char[3];
  assign d4 = 8'b00000000;
  assign d5 = 8'b00000000;
  assign d6 = 8'b00000000;
  assign d7 = 8'b00000000;

endmodule