module InstructionMemory (
    input logic [31:0] Address,
    //input logic clk,
    output logic [31:0] Instruction
);
    reg [7:0] INSMEM [147:0];

    initial
    begin
        //addi x1,zero,2
        INSMEM[0] = 8'b10010011;
        INSMEM[1] = 8'b00000000;
        INSMEM[2] = 8'b01000000;
        INSMEM[3] = 8'b00000000;
        //addi x22,zero,0
        INSMEM[4] = 8'b00010011;
        INSMEM[5] = 8'b00001011;
        INSMEM[6] = 8'b00000000;
        INSMEM[7] = 8'b00000000;
        //addi x23,zero,0
        INSMEM[8] = 8'b10010011;
        INSMEM[9] = 8'b00001011;
        INSMEM[10] = 8'b00000000;
        INSMEM[11] = 8'b00000000;
        //add x5,zero,zero
        INSMEM[12] = 8'b10110011;
        INSMEM[13] = 8'b00000010;
        INSMEM[14] = 8'b00000000;
        INSMEM[15] = 8'b00000000;
        //add x2,zero,zero
        INSMEM[16] = 8'b00110011;
        INSMEM[17] = 8'b00000001;
        INSMEM[18] = 8'b00000000;
        INSMEM[19] = 8'b00000000;
        //addi x3,zero,0 array
        INSMEM[20] = 8'b10010011;
        INSMEM[21] = 8'b00000001;
        INSMEM[22] = 8'b00000000;
        INSMEM[23] = 8'b00000000;
        //add x12, x2, x3
        INSMEM[24] = 8'b00110011;
        INSMEM[25] = 8'b00000110;
        INSMEM[26] = 8'b00110001;
        INSMEM[27] = 8'b00000000;
        //sw x22, 0(x12)
        INSMEM[28] = 8'b00100011;
        INSMEM[29] = 8'b00100000;
        INSMEM[30] = 8'b01100110;
        INSMEM[31] = 8'b00000001;
        //addi x22, x22, 1
        INSMEM[32] = 8'b00010011;
        INSMEM[33] = 8'b00001011;
        INSMEM[34] = 8'b00011011;
        INSMEM[35] = 8'b00000000;
        //addi x2,x2,8
        INSMEM[36] = 8'b00010011;
        INSMEM[37] = 8'b00000001;
        INSMEM[38] = 8'b10000001;
        INSMEM[39] = 8'b00000000;
        //bne x22, x1, Loop
        INSMEM[40] = 8'b11100011;
        INSMEM[41] = 8'b00011000;
        INSMEM[42] = 8'b00011011;
        INSMEM[43] = 8'b11111110;
        //addi x22, zero, 0
        INSMEM[44] = 8'b00010011;
        INSMEM[45] = 8'b00001011;
        INSMEM[46] = 8'b00000000;
        INSMEM[47] = 8'b00000000;
        //add x2,zero,zero
        INSMEM[48] = 8'b00110011;
        INSMEM[49] = 8'b00000001;
        INSMEM[50] = 8'b00000000;
        INSMEM[51] = 8'b00000000;
        //add x11,zero,zero
        INSMEM[52] = 8'b10110011;
        INSMEM[53] = 8'b00000101;
        INSMEM[54] = 8'b00000000;
        INSMEM[55] = 8'b00000000;
        //add x23,zero,x22
        INSMEM[56] = 8'b10110011;
        INSMEM[57] = 8'b00001011;
        INSMEM[58] = 8'b01100000;
        INSMEM[59] = 8'b00000001;
        //add x12, x2, x3
        INSMEM[60] = 8'b00110011;
        INSMEM[61] = 8'b00000110;
        INSMEM[62] = 8'b00110001;
        INSMEM[63] = 8'b00000000;
        //lw x15, 0(x12)
        INSMEM[64] = 8'b10000011;
        INSMEM[65] = 8'b00100111;
        INSMEM[66] = 8'b00000110;
        INSMEM[67] = 8'b00000000;
        //addi x11,x23,0
        INSMEM[68] = 8'b10010011;
        INSMEM[69] = 8'b10000101;
        INSMEM[70] = 8'b00001011;
        INSMEM[71] = 8'b00000000;
        //add x11,x11,x23
        INSMEM[72] = 8'b10110011;
        INSMEM[73] = 8'b10000101;
        INSMEM[74] = 8'b01110101;
        INSMEM[75] = 8'b00000001;
        //add x11,x11,x23
        INSMEM[76] = 8'b10110011;
        INSMEM[77] = 8'b10000101;
        INSMEM[78] = 8'b01110101;
        INSMEM[79] = 8'b00000001;
        //add x11,x11,x23
        INSMEM[80] = 8'b10110011;
        INSMEM[81] = 8'b10000101;
        INSMEM[82] = 8'b01110101;
        INSMEM[83] = 8'b00000001;
        //add x11,x11,x23
        INSMEM[84] = 8'b10110011;
        INSMEM[85] = 8'b10000101;
        INSMEM[86] = 8'b01110101;
        INSMEM[87] = 8'b00000001;
        //add x11,x11,x23
        INSMEM[88] = 8'b10110011;
        INSMEM[89] = 8'b10000101;
        INSMEM[90] = 8'b01110101;
        INSMEM[91] = 8'b00000001;
        //add x11,x11,x23
        INSMEM[92] = 8'b10110011;
        INSMEM[93] = 8'b10000101;
        INSMEM[94] = 8'b01110101;
        INSMEM[95] = 8'b00000001;
        //add x11,x11,x23
        INSMEM[96] = 8'b10110011;
        INSMEM[97] = 8'b10000101;
        INSMEM[98] = 8'b01110101;
        INSMEM[99] = 8'b00000001;
        //add x10, x11, x3	
        INSMEM[100] = 8'b00110011;
        INSMEM[101] = 8'b10000101;
        INSMEM[102] = 8'b00110101;
        INSMEM[103] = 8'b00000000;
        //lw x16, 0(x10)
        INSMEM[104] = 8'b00000011;
        INSMEM[105] = 8'b00101000;
        INSMEM[106] = 8'b00000101;
        INSMEM[107] = 8'b00000000;
        //blt x15,x16,else
        INSMEM[108] = 8'b01100011;
        INSMEM[109] = 8'b11000100;
        INSMEM[110] = 8'b00000111;
        INSMEM[111] = 8'b00000001;
        //beq x0,x0,exit
        INSMEM[112] = 8'b01100011;
        INSMEM[113] = 8'b00001000;
        INSMEM[114] = 8'b00000000;
        INSMEM[115] = 8'b00000000;
        //add x5, zero, x15
        INSMEM[116] = 8'b10110011;
        INSMEM[117] = 8'b00000010;
        INSMEM[118] = 8'b11110000;
        INSMEM[119] = 8'b00000000;
        //sw x16, 0(x12)
        INSMEM[120] = 8'b00100011;
        INSMEM[121] = 8'b00100000;
        INSMEM[122] = 8'b00000110;
        INSMEM[123] = 8'b00000001;
        //sw x5, 0(x10)
        INSMEM[124] = 8'b00100011;
        INSMEM[125] = 8'b00100000;
        INSMEM[126] = 8'b01010101;
        INSMEM[127] = 8'b00000000;
        //addi x23,x23,1
        INSMEM[128] = 8'b10010011;
        INSMEM[129] = 8'b10001011;
        INSMEM[130] = 8'b00011011;
        INSMEM[131] = 8'b00000000;
        //bne x23, x1, loopinner
        INSMEM[132] = 8'b11100011;
        INSMEM[133] = 8'b10011100;
        INSMEM[134] = 8'b00011011;
        INSMEM[135] = 8'b11111010;
        //addi x22, x22, 1
        INSMEM[136] = 8'b00010011;
        INSMEM[137] = 8'b00001011;
        INSMEM[138] = 8'b00011011;
        INSMEM[139] = 8'b00000000;
        //addi x2,x2,8
        INSMEM[140] = 8'b00010011;
        INSMEM[141] = 8'b00000001;
        INSMEM[142] = 8'b10000001;
        INSMEM[143] = 8'b00000000;
        //bne x22, x1, loopouter
        INSMEM[144] = 8'b11100011;
        INSMEM[145] = 8'b00010100;
        INSMEM[146] = 8'b00011011;
        INSMEM[147] = 8'b11111010;
    end
    
    //assign Instruction = {INSMEM[Address + 3], INSMEM[Address + 2], INSMEM[Address + 1], INSMEM[Address]};
    
    always_ff @(*) begin
        Instruction = {INSMEM[Address + 3], INSMEM[Address + 2], INSMEM[Address + 1], INSMEM[Address]};
    end

endmodule