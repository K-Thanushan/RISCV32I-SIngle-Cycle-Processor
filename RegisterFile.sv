module RegisterFile #(parameter Width = 32) (
    input logic [4:0] R_add1,
    input logic [4:0] R_add2,
    input logic [4:0] W_Add,
    input logic clk,
    input logic reset,
    input logic RegWrite,
    input logic [Width - 1:0] W_Data,
    output logic [Width - 1:0] R_Data1,
    output logic [Width - 1:0] R_Data2
);

    reg [Width - 1:0] Register_File[Width - 1:0];
    integer n;

    //assign Register_File[5'b00000] = 32'd0;
    assign R_Data1 = Register_File[R_add1];
    assign R_Data2 = Register_File[R_add2];

    always_ff@(posedge clk or posedge reset)begin
		if (reset==1'b1)
		begin
			for (n=0; n<32; n=n+1) 
			begin
			Register_File[1] <= 32'd0;
			end
		end 
		
		else if ((RegWrite == 1'b1) && (W_Add != 5'b00000))
		begin
			Register_File[W_Add] <= W_Data;
		end
		
	end
endmodule