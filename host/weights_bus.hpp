#pragma once

#include <cstdint>
#include <vector>
#include <cstring>

// Packet type identifiers for the weight/bias bus
enum DataKind : std::uint8_t {
  KIND_INPUT  = 0,
  KIND_WEIGHT = 1,
  KIND_BIAS   = 2,
};

// Header prepended to each packet sent through the switch kernel.
struct WeightsHdr {
  std::uint32_t ctrl;
  std::uint32_t len;
  std::uint32_t rsvd0;
  std::uint32_t rsvd1;

  WeightsHdr(std::uint8_t bus_id, DataKind kind, std::uint32_t length_words)
      : ctrl((0u << 24) | (static_cast<std::uint32_t>(kind) << 16) | std::uint32_t(bus_id)),
        len(length_words), rsvd0(0), rsvd1(0) {}
};

// Append a packet consisting of the header followed by \p data to \p dst.
inline void append_packet(std::vector<std::uint32_t>& dst,
                          const std::vector<float>& data,
                          std::uint8_t bus_id,
                          DataKind kind) {
  WeightsHdr hdr(bus_id, kind, data.size());
  dst.push_back(hdr.ctrl);
  dst.push_back(hdr.len);
  dst.push_back(hdr.rsvd0);
  dst.push_back(hdr.rsvd1);
  for (float f : data) {
    std::uint32_t w;
    std::memcpy(&w, &f, sizeof(float));
    dst.push_back(w);
  }
}

