# SECDED-SRAM

Parameterized 32-bit synchronous SRAM with 7-bit single-error-correction/double-error-detection parity.

The data word is represented as a shortened extended Hamming code. A clean read returns the original data; one-bit data/parity errors are corrected; two-bit errors raise an uncorrectable flag.

`make test` compiles and executes the self-checking fault-injection regression.

Project owner: Sundaram S S.
