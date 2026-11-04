# Verification record

Date: 04 November 2026
Source revision tested: `22cf2e959260e769d81d8e8a86ee2d640c540d7e`
Hosted regression: https://github.com/vrctsssundaram/Project-Repo-3/actions/runs/41869410093

| Measurement | Recorded result |
|---|---|
| SystemVerilog compilation | **PASS** (`iverilog -g2012 -Wall`) |
| Self-checking simulation | **PASS** (`vvp`, exit code 0) |
| Directed checks | SECDED clean, single data, double data, parity and overall parity faults |
| FPGA synthesis / utilization | **Not run** |
| Static timing / Fmax | **Not measured** |
| Power and hardware throughput | **Not measured** |

The recorded checks apply to the named revision and exercise the bounded first implementation. No waveform image, fabricated timing report or estimated resource figure is presented as measured evidence.
