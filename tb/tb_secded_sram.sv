module tb_secded_sram;
    timeunit 1ns; timeprecision 1ps;
    reg clk = 0;
    always #5 clk = ~clk;
    reg rst_n = 0;
    reg wr_en = 0, rd_en = 0, inject_en = 0;
    reg [3:0] wr_addr = 0, rd_addr = 0, inject_addr = 0;
    reg [31:0] wr_data = 0;
    reg [38:0] inject_mask = 0;
    wire [31:0] rd_data;
    wire rd_valid, corrected, uncorrectable;
    localparam [31:0] DATA = 32'hA5A51234;
    secded_sram #(.ADDR_W(4), .FAULT_INJECTION(1)) dut (
        .clk(clk), .rst_n(rst_n), .wr_en(wr_en), .wr_addr(wr_addr), .wr_data(wr_data),
        .rd_en(rd_en), .rd_addr(rd_addr), .rd_data(rd_data), .rd_valid(rd_valid),
        .rd_corrected(corrected), .rd_uncorrectable(uncorrectable),
        .inject_en(inject_en), .inject_addr(inject_addr), .inject_mask(inject_mask)
    );
    task automatic write_word;
        begin
            @(negedge clk); wr_en=1; wr_addr=3; wr_data=DATA;
            @(negedge clk); wr_en=0;
        end
    endtask
    task automatic inject(input [38:0] mask);
        begin
            @(negedge clk); inject_en=1; inject_addr=3; inject_mask=mask;
            @(negedge clk); inject_en=0;
        end
    endtask
    task automatic check(input [31:0] expect_data, input expect_fixed, input expect_fatal);
        begin
            @(negedge clk); rd_en=1; rd_addr=3;
            @(posedge clk); #1;
            if (!rd_valid || rd_data !== expect_data ||
                 corrected !== expect_fixed || uncorrectable !== expect_fatal)
                $fatal(1, "ECC check failed: %h corrected=%b fatal=%b", rd_data, corrected, uncorrectable);
            @(negedge clk); rd_en=0;
        end
    endtask
    initial begin
        #23; rst_n=1;
        write_word();
        check(DATA, 0, 0);
        inject(39'h000000001); // data bit zero
        check(DATA, 1, 0);
        write_word();
        inject(39'h000000003); // two data-bit faults
        check(DATA ^ 32'h3, 0, 1);
        write_word();
        inject(39'h100000000); // one Hamming parity bit
        check(DATA, 1, 0);
        write_word();
        inject(39'h4000000000); // overall parity bit
        check(DATA, 1, 0);
        $display("PASS: SECDED clean, single data, double data, parity and overall parity faults");
        $finish;
    end
    initial begin #20000; $fatal(1, "Watchdog timeout"); end
endmodule
