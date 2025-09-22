# Packet Contract v1

- Stream width: 32-bit AXI4-Stream.
- Packet format: `[HEADER][N payload words]`, TLAST asserted on the last payload word (or on the header when `payload_len == 0`).
- Header v1 fields:
  - `[7:0]` — `ID` (0..3 → AIE domain; 4..5 → PL domain)
  - `[11:8]` — `RESERVED = 0`
  - `[14:12]` — `pktType` (0 by default)
  - `[27:16]` — `payload_len` (number of payload words; zero for header-only packets)
  - `[31]` — `PARITY` (odd parity over bits `[30:0]`)
- Sender emits a packet only if `N > 0`.
- Receivers route by ID and consume exactly the host-specified packet count.
- Versioning note: Any change bumps v2 and requires compatibility handling.

## Host-composed headers

The host software now constructs every v1 header before launching the `mm2s` aggregator. When building a packet the host:

1. Chooses the target `ID` and packet type.
2. Sets `payload_len` to the exact number of 32-bit payload words that follow the header (0 for header-only packets).
3. Computes and inserts the odd parity bit so the aggregated stream is self-consistent before the first word is transferred.

Hardware blocks rely on the `payload_len` field to determine when to assert TLAST on domain-specific streams and to detect truncated packets. Any parity failure detected downstream is therefore due to in-flight corruption, not header synthesis in the fabric.

## Aggregate stream topology

There is exactly one ingress aggregate (`mm2s_1`) that fans out packets to the AIE or PL domains based on the header `ID`. Egress traffic is captured on aggregated streams that are statically partitioned by ID: currently one stream (`s2mm_1`) gathers AIE responses (IDs 0–3) and a second stream (`s2mm_2`) collects PL responses (IDs 4–5). Designs that only require AIE feedback can disable the second egress channel, but the packet format itself remains unchanged.

Headers appear on **both** ingress and egress streams. Packets received from the AIE/PL fabric are prefixed with their original headers before reaching host memory, enabling the software parser to rely on the same contract in both directions.

## Helper utilities

The host-side helpers in `sw/packet_utils.*` encapsulate header construction and validation:

- `packet_utils::PayloadView { uint32_t id; const float* data; std::size_t length; }` describes a channel payload in words.
- `uint32_t packet_utils::build_header(uint32_t pkt_type, uint32_t id, uint32_t payload_len_words)` masks the fields to v1 widths, inserts `payload_len`, and emits an odd-parity bit. The function assumes little-endian word order when interpreted on the host CPU.
- `std::vector<uint32_t> packet_utils::pack_packets(const std::vector<PayloadView>& payloads, uint32_t pkt_type = 0)` skips empty views, prepends each payload with the `build_header(...)` result, and copies the payload floats into 32-bit words using host endianness. The output buffer is exactly what `mm2s_1` expects to stream; TLAST is regenerated inside the PL using `payload_len`.
- `bool packet_utils::header_has_valid_parity(uint32_t header_word)` recomputes parity so the host can vet egress packets before interpreting their payloads.

The helpers do not encode TLAST information directly. Instead, downstream packet sender/receivers use the `payload_len` field to assert TLAST on the final payload word (or on the header if the packet is empty), ensuring consistent behaviour across ingress and egress paths.
