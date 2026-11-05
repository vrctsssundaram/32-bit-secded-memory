# SECDED-SRAM

32-bit word memory with 7-bit SECDED error detection and correction.

## Features

- Parity encoding on writes and syndrome decoding on reads
- Single-bit correction and double-bit error indication
- Optional error injection for verification

## Run

```sh
make test
make synth
```

Design sources are in `rtl/`, directed tests in `tb/`, and interface, architecture, testing and measured results in `docs/`.

**Architecture:** SECDED-protected 32-bit scratchpad with read correction, status flags and fault injection.

Project owner: Sundaram S S.
