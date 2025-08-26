#pragma once

#include <cstdint>

// Logical stream IDs used by the switch_mm2s and demux kernels.
// These values are placed in the packet header and map directly to the
// TDEST field consumed by the demux_8_pl kernel.

namespace bus {

// Input feature stream for layer 0.
constexpr std::uint8_t DIN         = 0;

// Layer 0 weight stream.
constexpr std::uint8_t WEIGHTS0    = 1;

// Layer 1 weight streams (split in two parts).
constexpr std::uint8_t WEIGHTS1_A  = 2;
constexpr std::uint8_t WEIGHTS1_B  = 3;

// Bias streams for layers 0 and 1.
constexpr std::uint8_t BIAS0       = 4;
constexpr std::uint8_t BIAS1       = 5;

} // namespace bus

