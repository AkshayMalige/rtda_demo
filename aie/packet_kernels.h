#pragma once

#include <adf.h>

#include <cstddef>
#include <cstdint>
#include <cstring>

namespace pkt_adapters {

struct PacketHeader {
    static constexpr std::uint32_t kIdMask          = 0x1F;
    static constexpr std::uint32_t kPayloadShift    = 16;
    static constexpr std::uint32_t kPayloadMask     = 0x0FFF;
    static constexpr std::uint32_t kParityBitMask   = 0x80000000u;
    static constexpr std::uint32_t kPayloadMaskFull = kPayloadMask << kPayloadShift;

    std::uint32_t raw;

    [[nodiscard]] std::uint8_t  id() const { return static_cast<std::uint8_t>(raw & kIdMask); }
    [[nodiscard]] std::uint16_t payload_words() const {
        return static_cast<std::uint16_t>((raw >> kPayloadShift) & kPayloadMask);
    }
    [[nodiscard]] bool has_valid_parity() const;

    static PacketHeader from_word(std::uint32_t word) { return PacketHeader{word}; }
    static PacketHeader build(std::uint8_t id, std::uint16_t payload_words);
};

namespace detail {
[[nodiscard]] inline bool compute_odd_parity(std::uint32_t value) {
    const unsigned int bit_count = __builtin_popcount(value);
    return (bit_count & 0x1U) != 0U;
}

[[nodiscard]] inline std::uint32_t float_to_bits(float value) {
    std::uint32_t bits = 0U;
    std::memcpy(&bits, &value, sizeof(float));
    return bits;
}

[[nodiscard]] inline float bits_to_float(std::uint32_t bits) {
    float value = 0.0f;
    std::memcpy(&value, &bits, sizeof(float));
    return value;
}

void log_packet(const char* tag, std::uint8_t id, std::size_t words);

}  // namespace detail

void pkt_to_win_vec(adf::input_pktstream* s, adf::output_window<float>* w);
void pkt_to_win_mat(adf::input_pktstream* s, adf::output_window<float>* w);
void win_to_pkt_vec(adf::input_window<float>* w, adf::output_pktstream* s, std::uint8_t out_id);

// Convenience wrappers with fixed output IDs for graph wiring
void win_to_pkt_vec_d1(adf::input_window<float>* w, adf::output_pktstream* s);
void win_to_pkt_vec_d2(adf::input_window<float>* w, adf::output_pktstream* s);

}  // namespace pkt_adapters
