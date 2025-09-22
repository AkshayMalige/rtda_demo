#include "packet_kernels.h"
#include "nn_defs.h"

#include <cstdint>

namespace {

constexpr std::uint32_t kLengthFieldMask  = 0x0FFFu;
constexpr std::uint32_t kLengthFieldShift = 16u;
constexpr std::uint32_t kIdFieldShift     = 8u;
constexpr std::uint32_t kIdFieldMask      = 0x7u;

// Expected payload sizes (32-bit words) for each inbound packet ID.
constexpr std::uint32_t expected_words_for_input_id(std::uint32_t pkt_id) {
    switch (pkt_id) {
        case 0u: // dense1 weights
            return static_cast<std::uint32_t>(HIDDEN_SIZE * INPUT_SIZE);
        case 1u: // dense1 activations
            return static_cast<std::uint32_t>(INPUT_SIZE);
        case 2u: // dense2 weights lane 0
        case 3u: // dense2 weights lane 1
            return static_cast<std::uint32_t>(OUTPUT_SIZE * HIDDEN_SIZE / CASCADE_LENGTH);
        case 4u: // dense2 activations lane 0
        case 5u: // dense2 activations lane 1
            return static_cast<std::uint32_t>(HIDDEN_SIZE / CASCADE_LENGTH);
        default:
            return 0u;
    }
}

// Expected payload sizes (32-bit words) for each outbound packet ID.
constexpr std::uint32_t expected_words_for_output_id(std::uint32_t pkt_id) {
    switch (pkt_id) {
        case 0u: // dense1 output activations
            return static_cast<std::uint32_t>(HIDDEN_SIZE);
        case 1u: // dense2 output lane 0
        case 2u: // dense2 output lane 1
            return static_cast<std::uint32_t>(OUTPUT_SIZE / CASCADE_LENGTH);
        default:
            return 0u;
    }
}

inline std::uint32_t extract_payload_length(std::uint32_t header_word) {
    return (header_word >> kLengthFieldShift) & kLengthFieldMask;
}

inline std::uint32_t extract_packet_id(std::uint32_t header_word) {
    return (header_word >> kIdFieldShift) & kIdFieldMask;
}

inline std::uint32_t build_header_word(std::uint32_t pkt_id, std::uint32_t payload_words) {
    const std::uint32_t length_field = (payload_words & kLengthFieldMask) << kLengthFieldShift;
    const std::uint32_t id_field     = (pkt_id & kIdFieldMask) << kIdFieldShift;
    return length_field | id_field;
}

} // namespace

// Packet to stream converter
// Reads packetized data and outputs pure float stream (strips packet headers)
void packet_to_stream(input_pktstream* pkt_in, output_stream<float>* stream_out) {
    // Read the packet header and decode routing/length fields.
    const std::uint32_t header_word   = static_cast<std::uint32_t>(readincr(pkt_in));
    const std::uint32_t pkt_id        = extract_packet_id(header_word);
    const std::uint32_t header_length = extract_payload_length(header_word);

    const std::uint32_t expected_len = expected_words_for_input_id(pkt_id);

    // Prefer the advertised length; fall back to the known expectation when absent (e.g. overflowed).
    std::uint32_t words_to_forward = header_length != 0u ? header_length : expected_len;

    // If we have no guidance, there is nothing meaningful to forward—consume header and exit.
    if (words_to_forward == 0u) {
        return;
    }

    for (std::uint32_t i = 0; i < words_to_forward; ++i) {
        const float data = readincr(pkt_in);
        writeincr(stream_out, data);
    }

    // Drain any remaining words if the header advertised more than we forwarded.
    if (header_length > words_to_forward) {
        const std::uint32_t excess = header_length - words_to_forward;
        for (std::uint32_t i = 0; i < excess; ++i) {
            (void)readincr(pkt_in);
        }
    }
}

// Stream to packet converter
// Reads pure float stream and outputs packetized data (adds packet headers)
void stream_to_packet(input_stream<float>* stream_in, output_pktstream* pkt_out) {
    const std::uint32_t pkt_id = static_cast<std::uint32_t>(getPacketid(pkt_out, 0));
    const std::uint32_t payload_len = expected_words_for_output_id(pkt_id);

    if (payload_len == 0u) {
        return;
    }

    const std::uint32_t header_word = build_header_word(pkt_id, payload_len);
    writeincr(pkt_out, static_cast<int32_t>(header_word));

    for (std::uint32_t i = 0; i < payload_len; ++i) {
        const float data = readincr(stream_in);
        const bool  is_last = (i + 1u) == payload_len;
        writeincr(pkt_out, data, is_last);
    }
}
