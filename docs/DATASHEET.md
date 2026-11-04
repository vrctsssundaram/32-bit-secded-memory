# Interface summary

| Port / parameter | Meaning |
|---|---|
| `ADDR_W` | SRAM depth is `2**ADDR_W` words |
| `wr_en, wr_addr, wr_data[31:0]` | Synchronous write |
| `rd_en, rd_addr` | Synchronous read request |
| `rd_valid, rd_data[31:0]` | Registered read output |
| `rd_corrected` | Correctable one-bit data/parity error |
| `rd_uncorrectable` | Detected even-parity multi-bit error |
| `FAULT_INJECTION` | Enable qualification-only error injection |
| `inject_en, inject_addr, inject_mask[38:0]` | Controlled storage-bit fault |

No power, frequency, endurance, safety-integrity or reliability-rate claims are made.
