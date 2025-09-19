# Packet Contract v1

- Stream width: 32-bit AXI4-Stream.
- Packet format: `[HEADER][N payload words]`, TLAST asserted on the last payload word.
- Header v1 fields:
  - `[7:0]` — `ID` (0..3 → AIE domain; 4..5 → PL domain)
  - `[11:8]` — `RESERVED = 0`
  - `[14:12]` — `pktType` (0 by default)
  - `[27:16]` — `payload_len` (optional, zero if unused)
  - `[31]` — `PARITY` (odd parity over bits `[30:0]`)
- Sender emits a packet only if `N > 0`.
- Receivers route by ID and consume exactly the host-specified packet count.
- Versioning note: Any change bumps v2 and requires compatibility handling.
