#include "packet_kernels.h"

#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>
#include <algorithm>

namespace {

struct PacketHeader {
    uint32_t raw;

    explicit PacketHeader(uint32_t value = 0) : raw(value) {}

    uint8_t id() const { return static_cast<uint8_t>(raw & 0xFFu); }
    uint8_t type() const { return static_cast<uint8_t>((raw >> 12) & 0x7u); }
    uint16_t length() const { return static_cast<uint16_t>((raw >> 16) & 0x0FFFu); }
    bool has_odd_parity() const { return (__builtin_popcount(raw) & 1) == 1; }
};

inline uint32_t set_odd_parity(uint32_t word) {
    uint32_t masked = word & 0x7FFFFFFFu; // Clear parity bit
    if ((__builtin_popcount(masked) & 1) == 0) {
        masked |= 0x80000000u; // Force odd parity
    }
    return masked;
}

inline uint32_t make_header(uint8_t id, uint8_t type, uint16_t len) {
    uint32_t word = static_cast<uint32_t>(id);
    word |= static_cast<uint32_t>(type & 0x7u) << 12;
    word |= static_cast<uint32_t>(len & 0x0FFFu) << 16;
    return set_odd_parity(word);
}

inline float word_to_float(uint32_t word) {
    union {
        uint32_t u;
        float f;
    } conv;
    conv.u = word;
    return conv.f;
}

inline uint32_t float_to_word(float value) {
    union {
        float f;
        uint32_t u;
    } conv;
    conv.f = value;
    return conv.u;
}

inline uint32_t read_word(input_pktstream* in) { return readincr(in); }
inline void write_word(output_pktstream* out, uint32_t word) { writeincr(out, word); }

void consume_packet(input_pktstream* in, output_window<float>* out, uint8_t expected_id, uint16_t expected_len) {
    PacketHeader header(read_word(in));

    uint16_t payload_words = header.length();
    if (payload_words != expected_len) {
        payload_words = std::min<uint16_t>(payload_words, expected_len);
    }

    uint16_t words_written = 0;
    while (words_written < payload_words) {
        uint32_t raw = read_word(in);
        PacketHeader maybe_header(raw);
        if (maybe_header.type() == PACKET_TYPE_TLAST && maybe_header.id() == expected_id &&
            maybe_header.length() == 0 && maybe_header.has_odd_parity()) {
            continue; // Skip TLAST marker
        }

        float value = word_to_float(raw);
        window_writeincr(out, value);
        ++words_written;
    }

    while (words_written < expected_len) {
        uint32_t raw = read_word(in);
        float value = word_to_float(raw);
        window_writeincr(out, value);
        ++words_written;
    }
}

void emit_packet(input_window<float>* in, output_pktstream* out, uint8_t id, uint16_t length) {
    write_word(out, make_header(id, PACKET_TYPE_DATA, length));

    for (uint16_t i = 0; i < length; ++i) {
        if (i == length - 1) {
            write_word(out, make_header(id, PACKET_TYPE_TLAST, 0));
        }
        uint32_t raw = float_to_word(window_readincr(in));
        write_word(out, raw);
    }
}

} // namespace

void multi_packet_to_float_converter(
    input_pktstream* in0, input_pktstream* in1, input_pktstream* in2,
    input_pktstream* in3, input_pktstream* in4, input_pktstream* in5,
    output_window<float>* d1_wt,
    output_window<float>* d2a_wt,
    output_window<float>* d2b_wt,
    output_window<float>* d1_x,
    output_window<float>* d2a_x,
    output_window<float>* d2b_x) {
    consume_packet(in0, d1_wt, PACKET_ID_D1_WEIGHTS, D1_WEIGHTS_WORDS);
    consume_packet(in1, d2a_wt, PACKET_ID_D2A_WEIGHTS, D2_WEIGHTS_PART_WORDS);
    consume_packet(in2, d2b_wt, PACKET_ID_D2B_WEIGHTS, D2_WEIGHTS_PART_WORDS);
    consume_packet(in3, d1_x, PACKET_ID_D1_INPUT, D1_INPUT_WORDS);
    consume_packet(in4, d2a_x, PACKET_ID_D2A_INPUT, D2_INPUT_PART_WORDS);
    consume_packet(in5, d2b_x, PACKET_ID_D2B_INPUT, D2_INPUT_PART_WORDS);
}

void multi_float_to_packet_converter(
    input_window<float>* d1_y,
    input_window<float>* d2_y,
    output_pktstream* out0,
    output_pktstream* out1) {
    emit_packet(d1_y, out0, PACKET_ID_D1_OUTPUT, DENSE_OUTPUT_WORDS);
    emit_packet(d2_y, out1, PACKET_ID_D2_OUTPUT, DENSE_OUTPUT_WORDS);
}

