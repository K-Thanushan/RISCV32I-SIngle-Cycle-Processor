module SEGMENT_7_INTERFACE(
   	input logic [31:0] data,
		output reg [6:0] digit_array [7:0]
   	);
    
   	reg [3:0] BCD_array [7:0];
	
		assign BCD_array[0] = data[3:0];
		assign BCD_array[1] = data[7:4];
		assign BCD_array[2] = data[11:8];
		assign BCD_array[3] = data[15:12];
		assign BCD_array[4] = data[19:16];
		assign BCD_array[5] = data[23:20];
		assign BCD_array[6] = data[27:24];
		assign BCD_array[7] = data[31:28];

		SSD SSD_0(
			.BCD(BCD_array[0]),
			.digit(digit_array[0])
		);
		SSD SSD_1(
			.BCD(BCD_array[1]),
			.digit(digit_array[1])
		);
		SSD SSD_2(
			.BCD(BCD_array[2]),
			.digit(digit_array[2])
		);
		SSD SSD_3(
			.BCD(BCD_array[3]),
			.digit(digit_array[3])
		);
		SSD SSD_4(
			.BCD(BCD_array[4]),
			.digit(digit_array[4])
		);
		SSD SSD_5(
			.BCD(BCD_array[5]),
			.digit(digit_array[5])
		);
		SSD SSD_6(
			.BCD(BCD_array[6]),
			.digit(digit_array[6])
		);
		SSD SSD_7(
			.BCD(BCD_array[7]),
			.digit(digit_array[7])
		);
		 

endmodule
