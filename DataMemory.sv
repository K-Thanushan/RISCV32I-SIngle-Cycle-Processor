module DataMemory #(parameter Width = 32) (
    input logic [Width - 1:0] Address,
    input logic [Width - 1:0] W_Data,
    input logic [2:0] Mode,
    input logic clk,
    input logic MemWrite,
    input logic MemRead,
    input logic reset,
    output logic [Width - 1:0] R_Data
);
    logic [29:0] Block_Address;
    logic [1:0] Index;
    reg [7:0] MEM [0:31];
    integer p;
	
	 
    initial begin
        for (p = 0; p < 32; p = p + 1)begin
                MEM[p]<= 0;
        end
    end
    

    //assign R_Data = (MemRead) ? {MEM[Block_Address][Index + 3], MEM[Block_Address][Index + 2], MEM[Block_Address][Index + 1], MEM[Block_Address][Index]} : 32'bx;

    always_ff @( posedge clk or posedge reset) begin
        if (reset == 1'b1)
        begin
           MEM[0]<= 0;
			  MEM[1]<= 0;
			  MEM[2]<= 0;
			  MEM[3]<= 0;
			  MEM[4]<= 0;
			  MEM[5]<= 0;
			  MEM[6]<= 0;
			  MEM[7]<= 0;
			  MEM[8]<= 0;
			  MEM[9]<= 0;
			  MEM[10]<= 0;
			  MEM[11]<= 0;
			  MEM[12]<= 0;
			  MEM[13]<= 0;
			  MEM[14]<= 0;
			  MEM[15]<= 0;
			  MEM[16]<= 0;
			  MEM[17]<= 0;
			  MEM[18]<= 0;
			  MEM[19]<= 0;
			  MEM[20]<= 0;
			  MEM[21]<= 0;
			  MEM[22]<= 0;
			  MEM[23]<= 0;
			  MEM[24]<= 0;
			  MEM[25]<= 0;
			  MEM[26]<= 0;
			  MEM[27]<= 0;
			  MEM[28]<= 0;
			  MEM[29]<= 0;
			  MEM[30]<= 0;
			  MEM[31]<= 0;
        end

        else if (MemWrite == 1'b1)
            begin
                unique case (Mode)
                    3'b101 : begin   //SB
                        MEM[Block_Address][Index] <= W_Data[7:0];
                    end
                    3'b110 : begin   //SH
                        MEM[Block_Address][Index + 1] <= W_Data[15:8];
                        MEM[Block_Address][Index] <= W_Data[7:0];
                    end
                    3'b111 : begin  //SW
                        MEM[Block_Address][Index + 3] <= W_Data[31:24];
                        MEM[Block_Address][Index + 2] <= W_Data[23:16];
                        MEM[Block_Address][Index + 1] <= W_Data[15:8];
                        MEM[Block_Address][Index] <= W_Data[7:0];
                    end 
                endcase
            end
        /*else if (MemRead == 1'b1)
            begin
                unique case (Mode)
                    3'b000 : R_Data <= 32'(signed'(MEM[Block_Address][Index])); //LB
                    3'b001 : R_Data <= 32'(signed'({MEM[Block_Address][Index + 1], MEM[Block_Address][Index]}));  //LH
                    3'b010 : R_Data <= {MEM[Block_Address][Index + 3], MEM[Block_Address][Index + 2], MEM[Block_Address][Index + 1], MEM[Block_Address][Index]};  //LW
                    3'b011 : R_Data <= {24'd0, MEM[Block_Address][Index]};  //LBU
                    3'b100 : R_Data <= {16'd0, MEM[Block_Address][Index + 1], MEM[Block_Address][Index]};  //LHU
                endcase
            end*/
    end
    assign R_Data = (Mode == 3'b000)  && (MemRead) ? 32'(signed'(MEM[Block_Address][Index])) :  //LB
                  (Mode == 3'b001)  && (MemRead) ? 32'(signed'({MEM[Block_Address][Index + 1], MEM[Block_Address][Index]})) : //LH
                  (Mode == 3'b010)  && (MemRead) ? {MEM[Block_Address][Index + 3], MEM[Block_Address][Index + 2], MEM[Block_Address][Index + 1], MEM[Block_Address][Index]}:  //LW
                  (Mode == 3'b011)  && (MemRead) ? {24'd0, MEM[Block_Address][Index]}:  //LBU
                  (Mode == 3'b100)  && (MemRead) ? {16'd0, MEM[Block_Address][Index + 1], MEM[Block_Address][Index]}:  //LHU
                  32'd0;
    
endmodule