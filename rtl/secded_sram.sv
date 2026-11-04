module secded_sram #(
    parameter integer ADDR_W = 4,
    parameter integer FAULT_INJECTION = 0
) (
    input  wire                 clk,
    input  wire                 rst_n,
    input  wire                 wr_en,
    input  wire [ADDR_W-1:0]    wr_addr,
    input  wire [31:0]          wr_data,
    input  wire                 rd_en,
    input  wire [ADDR_W-1:0]    rd_addr,
    output reg  [31:0]          rd_data,
    output reg                  rd_valid,
    output reg                  rd_corrected,
    output reg                  rd_uncorrectable,
    input  wire                 inject_en,
    input  wire [ADDR_W-1:0]    inject_addr,
    input  wire [38:0]          inject_mask
);
    reg [38:0] memory [0:(1<<ADDR_W)-1];
    wire [38:0] selected = memory[rd_addr];

    function automatic is_parity(input integer position);
        begin
            is_parity = (position == 1 || position == 2 ||
                         position == 4 || position == 8 ||
                         position == 16 || position == 32);
        end
    endfunction

    function automatic [6:0] encode_ecc(input [31:0] data);
        reg [5:0] parity;
        integer bit_index, position, parity_index;
        begin
            parity = 0;
            bit_index = 0;
            for (position=1; position<=38; position=position+1) begin
                if (!is_parity(position)) begin
                    for (parity_index=0; parity_index<6; parity_index=parity_index+1)
                        if ((position & (1 << parity_index)) != 0)
                            parity[parity_index] = parity[parity_index] ^ data[bit_index];
                    bit_index = bit_index + 1;
                end
            end
            encode_ecc[5:0] = parity;
            encode_ecc[6] = (^data) ^ (^parity);
        end
    endfunction

    // Return {uncorrectable, corrected, corrected_data}.
    function automatic [33:0] decode(input [38:0] encoded);
        reg [31:0] value;
        reg [6:0] expected_ecc;
        reg [5:0] syndrome;
        reg overall_error;
        reg fixed, fatal_error;
        integer position, data_index;
        begin
            value = encoded[31:0];
            expected_ecc = encode_ecc(value);
            syndrome = expected_ecc[5:0] ^ encoded[37:32];
            overall_error = (^value) ^ (^encoded[37:32]) ^ encoded[38];
            fixed = 0;
            fatal_error = 0;
            if (syndrome != 0 && overall_error) begin
                fixed = 1;
                data_index = 0;
                for (position=1; position<=38; position=position+1) begin
                    if (!is_parity(position)) begin
                        if (position == syndrome) value[data_index] = ~value[data_index];
                        data_index = data_index + 1;
                    end
                end
            end else if (syndrome == 0 && overall_error) begin
                fixed = 1; // Overall parity bit alone was corrupted.
            end else if (syndrome != 0 && !overall_error) begin
                fatal_error = 1;
            end
            decode = {fatal_error, fixed, value};
        end
    endfunction

    wire [33:0] decoded = decode(selected);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_data <= 0;
            rd_valid <= 0;
            rd_corrected <= 0;
            rd_uncorrectable <= 0;
        end else begin
            if (wr_en)
                memory[wr_addr] <= {encode_ecc(wr_data), wr_data};
            if (FAULT_INJECTION && inject_en && !wr_en)
                memory[inject_addr] <= memory[inject_addr] ^ inject_mask;
            rd_valid <= rd_en;
            if (rd_en) begin
                rd_data <= decoded[31:0];
                rd_corrected <= decoded[32];
                rd_uncorrectable <= decoded[33];
            end
        end
    end
endmodule
