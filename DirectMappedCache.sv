module DirectMappedCache #(
    parameter Width = 32,
    parameter CacheSize = 128,
    parameter BlockSize = 4,
    parameter VictimSize = 4
) (
    input logic clk,
    input logic [Width - 1:0] Address,
    input logic [Width - 1:0] Data_IN,
    output logic [Width - 1:0] Data_OUT,
    input logic EN_W, //Write Enable
    input logic [2:0] Mode,
    output logic Hit,
    output logic [Width - 1:0] VictimCacheReadAddress
);

localparam BlockWidth = clog2(BlockSize);
localparam IndexWidth = clog2(CacheSize/BlockSize);
localparam TagWidth = WIDTH - BlockWidth - IndexWidth;
localparam Blocks = CacheSize/BlockSize;
localparam VC_Blocks = VictimSize;

//Address
logic [IndexWidth-1:0] index = Address[IndexWidth + 1:BlockWidth];
logic [TagWidth-1:0] tag = addr[Width - 1:BlockWidth + IndexWidth];
logic [BlockWidth - 1:0] B_add = Address[BlockWidth - 1:0];

// Cache CacheDataory
reg [7:0] CacheData [0:Blocks-1][0:BlockSize-1];
reg [TagWidth-1:0] CacheTag [0:Blocks-1];
reg [INDEX_WIDTH-1:0] CacheIndex [0:Blocks-1];
reg CacheValid [0:Blocks-1];

// Victim Cache CacheDataory
reg [7:0] v_CacheData [0:VC_Blocks-1][0:BlockSize-1];
reg [TagWidth-1:0] v_CacheTag [0:VC_Blocks-1];
reg v_CacheValid [0:VC_Blocks-1];

// Outputs
assign Data_OUT = CacheData[index][B_add];
assign Hit = CacheValid[index] & (CacheTag[index] == tag);
assign VictimCacheReadAddress = {v_CacheTag[0], index, 1'b0};

// Write Back
always @(posedge clk) begin
    if (EN_W) begin
        unique case (Mode)
            3'b101 :  CacheData[index][B_add] <= Data_IN[7:0]; //SB
            3'b110 : begin //SHW
                CacheData[index][B_add] <= Data_IN[7:0];
                CacheData[index][B_add] <= Data_IN[15:8];
            end
            3'b111 : begin //SW
                CacheData[index][B_add] <= Data_IN[7:0];
                CacheData[index][B_add] <= Data_IN[15:8];
                CacheData[index][B_add] <= Data_IN[23:16];
                CacheData[index][B_add] <= Data_IN[31:24];
            end
        endcase
        CacheData[index][addr[BlockWidth-1:0]] <= Data_IN;
        CacheValid[index] <= 1;
        CacheTag[index] <= tag;
        CacheIndex[index] <= index;
    end
    else if (!EN_W) begin
        unique case (Mode)
            3'b000 : Data_OUT <= 32'(signed'(CacheData[index][B_add])); //LB
            3'b001 : Data_OUT <= 32'(signed'({CacheData[index][B_add + 1], CacheData[index][B_add]}));  //LH
            3'b010 : Data_OUT <= {CacheData[index][B_add + 3], CacheData[index][B_add + 2], CacheData[index][B_add + 1], CacheData[index][B_add]};  //LW
            3'b011 : Data_OUT <= {24'd0, CacheData[index][B_add]};  //LBU
            3'b100 : Data_OUT <= {16'd0, CacheData[index][B_add + 1], CacheData[index][B_add]};  //LHU
        endcase
    end
end

// Eviction Policy
always @(posedge clk) begin
    for (int i = 0; i < Blocks; i++) begin
        if (CacheValid[i] & (CacheIndex[i] == index) & (CacheTag[i] != tag)) begin
            // Evict from Cache
            v_CacheValid[0] <= CacheValid[i];
            v_CacheData[0] <= CacheData[i];
            v_CacheTag[0] <= CacheTag[i];

            // Shift victim cache
            for (int j = VC_Blocks-1; j > 0; j--) begin
                v_CacheValid[j] <= v_CacheValid[j-1];
                v_CacheData[j] <= v_CacheData[j-1];
                v_CacheTag[j] <= v_CacheTag[j-1];
            end
        end
    end

    if (!hit) begin
        // Check if block is present in victim cache
        for (int i = 0; i < VC_Blocks; i++) begin
            if (v_CacheValid[i] & (v_CacheTag[i] == tag)) begin
                // Hit in Victim Cache
                CacheData[index] <= v_CacheData[i];
                CacheValid[index] <= 1;
                CacheTag[index] <= tag;
                CacheIndex[index] <= index;

                // Shift victim cache
                for (int j = i; j > 0; j--) begin
                    v_CacheValid[j] <= v_CacheValid[j-1];
                    v_CacheData[j] <= v_CacheData[j-1];
                    v_CacheTag[j] <= v_CacheTag[j-1];
                end
                v_CacheValid[0] <= 0;
            end
        
    end
end
end
    
endmodule