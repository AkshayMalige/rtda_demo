#include "packet_kernels.h"

#include <cstdio>

namespace pkt_adapters {

bool PacketHeader::has_valid_parity() const {
    return detail::compute_odd_parity(raw);
}

PacketHeader PacketHeader::build(std::uint8_t id, std::uint16_t payload_words) {
    std::uint32_t header = static_cast<std::uint32_t>(id & kIdMask);
    header |= (static_cast<std::uint32_t>(payload_words) & kPayloadMask) << kPayloadShift;
    header &= ~kParityBitMask;

    const bool base_is_odd = detail::compute_odd_parity(header);
    if (!base_is_odd) {
        header |= kParityBitMask;
    }
    return PacketHeader{header};
}

namespace {

inline std::size_t window_word_count(adf::output_window<float>* w) {
    return window_size(w) / sizeof(float);
}

inline std::size_t window_word_count(adf::input_window<float>* w) {
    return window_size(w) / sizeof(float);
}

void pkt_to_win_common(const char* tag, adf::input_pktstream* s, adf::output_window<float>* w) {
    const std::uint32_t header_word = readincr(s);
    const PacketHeader header       = PacketHeader::from_word(header_word);
    const std::size_t  words        = window_word_count(w);

    detail::log_packet(tag, header.id(), words);
    if (!header.has_valid_parity()) {
        printf("%s: parity error (raw=0x%08x)\n", tag, header_word);
    }

    if (header.payload_words() != 0U && header.payload_words() != words) {
        printf("%s: payload length mismatch (hdr=%u, expected=%zu)\n", tag, header.payload_words(), words);
    }

    for (std::size_t i = 0; i < words; ++i) {
        const std::uint32_t word = readincr(s);
        const float         val  = detail::bits_to_float(word);
        window_writeincr(w, val);
    }
}

void win_to_pkt_common(const char* tag,
                       adf::input_window<float>* w,
                       adf::output_pktstream*   s,
                       std::uint8_t        out_id) {
    const std::size_t words = window_word_count(w);
    const PacketHeader header = PacketHeader::build(out_id, static_cast<std::uint16_t>(words));

    detail::log_packet(tag, out_id, words);
    writeincr(s, header.raw, false);

    for (std::size_t i = 0; i < words; ++i) {
        const float         value = window_readincr(w);
        const std::uint32_t word  = detail::float_to_bits(value);
        const bool          last  = (i + 1U == words);
        writeincr(s, word, last);
    }
}

}  // namespace

void pkt_to_win_vec(adf::input_pktstream* s, adf::output_window<float>* w) {
    pkt_to_win_common("pkt_to_win_vec", s, w);
}

void pkt_to_win_mat(adf::input_pktstream* s, adf::output_window<float>* w) {
    pkt_to_win_common("pkt_to_win_mat", s, w);
}

void win_to_pkt_vec(adf::input_window<float>* w, adf::output_pktstream* s, std::uint8_t out_id) {
    win_to_pkt_common("win_to_pkt_vec", w, s, out_id);
}

void win_to_pkt_vec_d1(adf::input_window<float>* w, adf::output_pktstream* s) {
    win_to_pkt_vec(w, s, 16U);
}

void win_to_pkt_vec_d2(adf::input_window<float>* w, adf::output_pktstream* s) {
    win_to_pkt_vec(w, s, 17U);
}

namespace detail {

void log_packet(const char* tag, std::uint8_t id, std::size_t words) {
    printf("%s: id=%u words=%zu\n", tag, static_cast<unsigned>(id), words);
}

}  // namespace detail

}  // namespace pkt_adapters
