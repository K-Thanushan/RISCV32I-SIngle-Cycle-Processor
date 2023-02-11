module ImmediateGenerator (
    input logic [31:0] Instruction,
    input logic [2:0] ImGenControl,
    output logic [31:0] Immediate
);

    logic [11:0] Data1;
    logic [11:0] Data2;
    logic [11:0] Data3;
    logic [19:0] Data4;
    logic [5:0] Opcode;

    assign Data1 = Instruction[31:20]; //load

    assign Data2[3:0] = Instruction[11:8]; //SB Type
    assign Data2[9:4] = Instruction[30:25];
    assign Data2[10] = Instruction[7];
    assign Data2[11] = Instruction[31];
    
    assign Data3[4:0] = Instruction[11:7]; //Store
    assign Data3[11:5] = Instruction[31:25];
    
    assign Data4[9:0] = Instruction[30:21]; 
    assign Data4[10] = Instruction[20];
    assign Data4[18:11] = Instruction[19:12];
    assign Data4[19] = Instruction[31];

    always_comb begin
        unique case (ImGenControl)
            3'b000 : Immediate =  32'(signed'(Data1)); //Load
            3'b001 : Immediate =  32'(signed'(Data3)); //Store
            3'b010 : Immediate =  32'(signed'(Data2)); //SB Type
            3'b011 : Immediate =  32'(signed'(Data4)); //JAL
        endcase
    end
    
    
endmodule