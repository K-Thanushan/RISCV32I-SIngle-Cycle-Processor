module DataSeparator (
    input logic [31:0] Instruction,
    output logic [6:0] Opcode,
    output logic [4:0] rd,
    output logic [2:0] funct3,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [6:0] funct7
);
    
    assign Opcode = Instruction[6:0];
    assign rd = Instruction[11:7];
    assign funct3 = Instruction[14:12];
    assign rs1 = Instruction[19:15];
    assign rs2 = Instruction[24:20];
    assign funct7 = Instruction[31:25];
endmodule
