//Verilog module.
module SSD(
     BCD,
     digit
    );
     
     //Declare inputs,outputs and internal variables.
     input [3:0] BCD;
     output [6:0] digit;
     reg [6:0] digit;

//always block for converting BCD digitit into 7 segment format
    always @(BCD)
    begin
        case (BCD) //case statement
            0  : digit = 7'b1000000;
            1  : digit = 7'b1111001;
            2  : digit = 7'b0100100;
            3  : digit = 7'b0110000;
            4  : digit = 7'b0011001;
            5  : digit = 7'b0010010;
            6  : digit = 7'b0000010;
            7  : digit = 7'b1111000;
            8  : digit = 7'b0000000;
            9  : digit = 7'b0010000;
				'hA: digit = 7'b0001000;
				'hB: digit = 7'b0000011;
				'hC: digit = 7'b1000110;
				'hD: digit = 7'b0100001;
				'hE: digit = 7'b0000110;
				'hF: digit = 7'b0001110;
            //switch off 7 segment character when the BCD digitit is not a decimal number.
            default : digit = 7'b1111111; 
        endcase
    end
    
endmodule