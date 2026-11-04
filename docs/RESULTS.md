# Verification record

Date: 05 November 2026
Source revision tested: `af68f3e1820b3b3b7be1686af2a8e026a3763ef5`
Hosted regression: https://github.com/vrctsssundaram/Project-Repo-3/actions/runs/41902287513
Hosted generic synthesis: https://github.com/vrctsssundaram/Project-Repo-3/actions/runs/41902287500

| Measurement | Recorded result |
|---|---|
| SystemVerilog compilation | **PASS** (`iverilog -g2012 -Wall`) |
| Self-checking simulation | **PASS** (`vvp`, exit code 0) |
| Directed checks | SECDED clean, single data, double data, parity and overall parity faults |
| Generic Yosys synthesis | **PASS**; 3,537 technology-independent cells |
| Device-specific FPGA/ASIC utilization | **Not measured** |
| Static timing / Fmax | **Not measured** |
| Power and hardware throughput | **Not measured** |

The recorded checks apply to the named revision and exercise the bounded first implementation. No waveform image, fabricated timing report or estimated resource figure is presented as measured evidence.

The generic cell count is obtained from the cited Yosys `stat` output and is not an FPGA LUT estimate, ASIC area, or a timing result.
