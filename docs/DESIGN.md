# Technical design

Thirty-two payload bits and six Hamming parity bits occupy positions 1–38, with parity positions 1, 2, 4, 8, 16, and 32. An additional overall parity bit makes the code SECDED.

The syndrome is computed by comparing stored parity with parity freshly encoded from the read data. A nonzero syndrome plus odd overall parity error identifies a correctable single-bit error. A nonzero syndrome plus even overall parity identifies a detected double-bit error. The SECDED code corrects single-bit errors and signals detected double-bit errors.

The fault-injection option uses `FAULT_INJECTION=1` during test builds. Serialize same-address read/write operations for deterministic memory semantics.
