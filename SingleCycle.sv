module SingleCycle #( parameter Width = 32) (
    input logic clk,
    input logic reset
);
    logic [Width - 1:0] PC_Out; // PC
    logic [Width -1:0] Instruction; //Instructionmemory
    logic [Width - 1:0] Imm_Data; //Immediate Generator
    logic [6:0]opcode; logic [4:0]rd; logic [2:0]funct3; logic [4:0]rs1; logic [4:0]rs2; logic [6:0]funct7; //Data Separator
    logic [Width - 1:0] ReadData1; logic [Width - 1:0]ReadData2; //RegisterFile 
    logic [Width - 1:0] Result; //ALU 32bit
    logic Zero, B_Flag;
    logic [Width - 1:0] Read_Data; //Data memory
    logic [Width - 1:0]Data_out1; //mux1
    logic [Width - 1:0]Data_out2; //mux2
    logic [Width - 1:0]Data_out3; //mux3
    logic Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, MEMControl, BranchCondition; //CU
    logic [2:0] ImGenControl;
    logic [1:0] ALUOp; logic [3:0] Operation; //ALU control
    logic [2:0] Mode; //Memory Controller
    logic [Width - 1:0] Adder1_out; //adder1
    logic [Width - 1:0] Adder2_out; //adder2


    ProgramCounter PC(	
        .Next_PC(Data_out1),
        .clk(clk),
        .reset(reset),
        .Current_PC(PC_Out)
    );

    InstructionMemory INSMEM(
        .Address(PC_Out),
        .Instruction(Instruction)
    );

    ImmediateGenerator ImmGem(
        .Instruction(Instruction),
        .ImGenControl(ImGenControl),
        .Immediate(Imm_Data)
    );

    DataSeparator DataSep(
        .Instruction(Instruction),
        .Opcode(opcode),
        .rd(rd),
        .funct3(funct3),
        .rs1(rs1),
        .rs2(rs2),
        .funct7(funct7)
    );

    RegisterFile RF(
        .clk(clk), 
        .reset(reset), 
        .RegWrite(RegWrite),
        .W_Data(Data_out3), 
        .R_add1(rs1), 
        .R_add2(rs2), 
        .W_Add(rd),
        .R_Data1(ReadData1), 
        .R_Data2(ReadData2)
    );

    ALU ALU1(
        .Data1(ReadData1),
        .Data2(Data_out2),
        .ALU_Select(Operation),
        .ALU_Out(Result),
        .Zero(Zero),
        .B_Flag(B_Flag)
    );

    ALUControl ALUCU(
        .ALUOpcode(ALUOp),
        .ALUFunction({Instruction[30], Instruction[14:12]}), //ask ms aiman
        .ALUControl(Operation)
    );
    
    BranchControl BranchCU(
        .Branch(Branch),
        .zero(Zero),
        .B_Flag(B_Flag), 
        .Funct3(funct3),
        .BranchCondition(BranchCondition)
    );

    Mux M1(
        .A(Adder1_out), 
        .B(Adder2_out), 
        .selection(BranchCondition), //check criteria
        .Data(Data_out1)
    );

    Mux M2(
        .A(ReadData2), 
        .B(Imm_Data), 
        .selection(ALUSrc),
        .Data(Data_out2)
    );

    Mux M3(
        .A(Result), 
        .B(Read_Data), 
        .selection(MemtoReg),
        .Data(Data_out3)
    );

    MEMControlUnit MEMCU(
        .Funct3(funct3),
        .MEMControl(MEMControl),
        .Mode(Mode)
    );

    DataMemory DM(
        .Address(Result), 
        .W_Data(ReadData2),
        .Mode(Mode),
        .clk(clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead),
        .reset(reset),
        .R_Data(Read_Data)
    );

    ControlUnit CU(
        .Opcode(opcode),
        .Branch(Branch), 
        .MemRead(MemRead), 
        .MemtoReg(MemtoReg), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite),
        .MEMControl(MEMControl),
        .ImGenControl(ImGenControl),
        .ALUOp(ALUOp)
    );

    Adder A1(
        .A(PC_Out), 
        .B(32'd4),
        .Sum(Adder1_out) 
    );

    Adder A2(
        .A(PC_Out), 
        .B(Imm_Data<<1), //check
        .Sum(Adder2_out) 
    );

endmodule