module SEGMENT_7_INTERFACE(
   	input logic [31:0] data,
		output reg [6:0] dig_arr [7:0]
   	);
    
   	reg [3:0] bcd_arr [7:0];
	
		assign bcd_arr[0] = data[3:0];
		assign bcd_arr[1] = data[7:4];
		assign bcd_arr[2] = data[11:8];
		assign bcd_arr[3] = data[15:12];
		assign bcd_arr[4] = data[19:16];
		assign bcd_arr[5] = data[23:20];
		assign bcd_arr[6] = data[27:24];
		assign bcd_arr[7] = data[31:28];

		SSD SSD_0(
			.BCD(bcd_arr[0]),
			.digit(dig_arr[0])
		);
		SSD SSD_1(
			.BCD(bcd_arr[1]),
			.digit(dig_arr[1])
		);
		SSD SSD_2(
			.BCD(bcd_arr[2]),
			.digit(dig_arr[2])
		);
		SSD SSD_3(
			.BCD(bcd_arr[3]),
			.digit(dig_arr[3])
		);
		SSD SSD_4(
			.BCD(bcd_arr[4]),
			.digit(dig_arr[4])
		);
		SSD SSD_5(
			.BCD(bcd_arr[5]),
			.digit(dig_arr[5])
		);
		SSD SSD_6(
			.BCD(bcd_arr[6]),
			.digit(dig_arr[6])
		);
		SSD SSD_7(
			.BCD(bcd_arr[7]),
			.digit(dig_arr[7])
		);
		 

endmodule
