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

**Evidence:** Tool-reported Icarus Verilog regression and Yosys synthesis results for the source revision cited above.
