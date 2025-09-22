#include "packet_utils.h"

#include <cstring>

namespace packet_utils {
namespace {

constexpr uint32_t mask_lower_31_bits = 0x7FFFFFFFu;

uint32_t compute_parity_bit(uint32_t lower31_bits) {
    lower31_bits &= mask_lower_31_bits;
    unsigned parity = 0U;
    while (lower31_bits) {
        parity ^= 1U;
        lower31_bits &= (lower31_bits - 1U);
    }
    return parity ? 0U : 1U;
}

} // namespace

uint32_t build_header(uint32_t pkt_type, uint32_t id, uint32_t payload_len_words) {
    uint32_t header = 0U;

    header |= (id & 0xFFU);
    header |= ((pkt_type & 0x7U) << 12);
    header |= (0x1FU << 16);
    header |= (0x7FU << 21);

    header &= ~static_cast<uint32_t>(0x0FFFU << 16);
    header |= ((payload_len_words & 0x0FFFU) << 16);

    header &= mask_lower_31_bits;
    const uint32_t parity_bit = compute_parity_bit(header);
    header |= (parity_bit << 31);

    return header;
}

std::vector<uint32_t> pack_packets(const std::vector<PayloadView>& payloads, uint32_t pkt_type) {
    std::size_t total_words = 0U;
    for (const auto& payload : payloads) {
        if (!payload.data || payload.length == 0U)
            continue;
        total_words += 1U + payload.length;
    }

    std::vector<uint32_t> words;
    words.reserve(total_words);

    for (const auto& payload : payloads) {
        if (!payload.data || payload.length == 0U)
            continue;

        const uint32_t header = build_header(pkt_type, payload.id, static_cast<uint32_t>(payload.length));
        words.push_back(header);

        for (std::size_t idx = 0U; idx < payload.length; ++idx) {
            uint32_t word = 0U;
            std::memcpy(&word, payload.data + idx, sizeof(uint32_t));
            words.push_back(word);
        }
    }

    return words;
}

bool header_has_valid_parity(uint32_t header_word) {
    const uint32_t lower31 = header_word & mask_lower_31_bits;
    const uint32_t parity_bit = (header_word >> 31) & 0x1U;
    return parity_bit == compute_parity_bit(lower31);
}

} // namespace packet_utils
