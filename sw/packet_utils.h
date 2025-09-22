#pragma once

#include <cstddef>
#include <cstdint>
#include <vector>

namespace packet_utils {

struct PayloadView {
    uint32_t    id;
    const float* data;
    std::size_t length;
};

uint32_t build_header(uint32_t pkt_type, uint32_t id, uint32_t payload_len_words);

std::vector<uint32_t> pack_packets(const std::vector<PayloadView>& payloads, uint32_t pkt_type = 0);

bool header_has_valid_parity(uint32_t header_word);

} // namespace packet_utils
