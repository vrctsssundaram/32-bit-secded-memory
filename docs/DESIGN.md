# Technical design

Thirty-two payload bits and six Hamming parity bits occupy positions 1–38, with parity positions 1, 2, 4, 8, 16, and 32. An additional overall parity bit makes the code SECDED.

The syndrome is computed by comparing stored parity with parity freshly encoded from the read data. A nonzero syndrome plus odd overall parity error identifies a correctable single-bit error. A nonzero syndrome plus even overall parity identifies a detected double-bit error. Errors of three or more bits are outside the guaranteed correction/detection model.

The fault-injection port is disabled by default with `FAULT_INJECTION=0` and is intended only for qualification builds. Simultaneous write and read to the same address have implementation-dependent behavior; systems must arbitrate those operations.
