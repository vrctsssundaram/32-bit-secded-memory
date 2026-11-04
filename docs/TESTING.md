# Test procedure

Run `make test`, verify zero exit code and `PASS`, then check the hosted job for the same commit.

The regression writes a word and tests clean read, a single flipped data bit, two flipped data bits, one flipped Hamming parity bit, and one flipped overall parity bit.

Further work: ECC exhaustive syndrome sweep, multi-address random read/write, collision policy, retention fault modeling, FPGA inference/synthesis, static timing and scrubbing controller.

Run `make synth` with Yosys installed to reproduce the generic RTL synthesis check. Hardware placement, timing and power remain separate.
