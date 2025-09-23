#include <cassert>
#include <cmath>
#include <cstdint>
#include <vector>

#include "aie/packet_kernels.h"

using namespace pkt_adapters;

namespace {

std::vector<std::uint32_t> make_packet(std::uint8_t id, const std::vector<float>& payload) {
    std::vector<std::uint32_t> words;
    words.reserve(payload.size() + 1U);
    const PacketHeader header = PacketHeader::build(id, static_cast<std::uint16_t>(payload.size()));
    words.push_back(header.raw);
    for (float value : payload) {
        words.push_back(detail::float_to_bits(value));
    }
    return words;
}

void assert_close(float a, float b, float tol = 1e-6f) {
    assert(std::fabs(a - b) <= tol);
}

}  // namespace

int main() {
    // pkt_to_win_vec: single packet
    {
        std::vector<float> payload = {0.5f, -1.0f, 2.5f, 3.25f};
        adf::input_pktstream stream(make_packet(1U, payload));
        adf::output_window<float> window(payload.size());

        pkt_to_win_vec(&stream, &window);

        assert(window.index == payload.size());
        for (std::size_t i = 0; i < payload.size(); ++i) {
            assert_close(window.data[i], payload[i]);
        }
    }

    // pkt_to_win_mat: ensure generic handling of larger payloads
    {
        std::vector<float> payload(10);
        for (std::size_t i = 0; i < payload.size(); ++i) {
            payload[i] = static_cast<float>(i) * 0.25f;
        }
        auto words = make_packet(4U, payload);
        adf::input_pktstream stream(words);
        adf::output_window<float> window(payload.size());

        pkt_to_win_mat(&stream, &window);

        assert(window.index == payload.size());
        for (std::size_t i = 0; i < payload.size(); ++i) {
            assert_close(window.data[i], payload[i]);
        }
    }

    // win_to_pkt_vec: verify header composition and TLAST propagation
    {
        std::vector<float> values = {1.0f, -2.0f, 3.5f};
        adf::input_window<float>  window(values);
        adf::output_pktstream     stream;

        win_to_pkt_vec(&window, &stream, 17U);

        assert(stream.words.size() == values.size() + 1U);
        PacketHeader header = PacketHeader::from_word(stream.words[0]);
        assert(header.id() == 17U);
        assert(header.payload_words() == values.size());
        assert(header.has_valid_parity());

        for (std::size_t i = 0; i < values.size(); ++i) {
            const std::uint32_t expected = detail::float_to_bits(values[i]);
            assert(stream.words[i + 1U] == expected);
        }

        assert(stream.last.size() == stream.words.size());
        assert(stream.last[0] == false);
        assert(stream.last[1] == false);
        assert(stream.last[2] == false);
        assert(stream.last[3] == true);
    }

    // Back-to-back packets on single stream
    {
        std::vector<float> first_payload  = {4.0f, 5.0f};
        std::vector<float> second_payload = {-1.5f, 2.25f, 3.75f};

        auto words = make_packet(2U, first_payload);
        auto more  = make_packet(3U, second_payload);
        words.insert(words.end(), more.begin(), more.end());

        adf::input_pktstream stream(words);
        adf::output_window<float> first(first_payload.size());
        adf::output_window<float> second(second_payload.size());

        pkt_to_win_vec(&stream, &first);
        pkt_to_win_vec(&stream, &second);

        assert(first.index == first_payload.size());
        assert(second.index == second_payload.size());
        for (std::size_t i = 0; i < first_payload.size(); ++i) {
            assert_close(first.data[i], first_payload[i]);
        }
        for (std::size_t i = 0; i < second_payload.size(); ++i) {
            assert_close(second.data[i], second_payload[i]);
        }
    }

    // Multiple win_to_pkt_vec invocations append sequential packets
    {
        std::vector<float> values_a = {0.0f, 1.0f};
        std::vector<float> values_b = {2.0f, 3.0f, 4.0f};

        adf::input_window<float>  window_a(values_a);
        adf::input_window<float>  window_b(values_b);
        adf::output_pktstream     stream;

        win_to_pkt_vec(&window_a, &stream, 16U);
        win_to_pkt_vec(&window_b, &stream, 17U);

        // Expect two packets: headers at positions 0 and values_a.size()+1
        std::size_t offset = 0;
        {
            PacketHeader header = PacketHeader::from_word(stream.words[offset]);
            assert(header.id() == 16U);
            assert(header.payload_words() == values_a.size());
            assert(stream.last[offset] == false);
            for (std::size_t i = 0; i < values_a.size(); ++i) {
                assert(stream.words[offset + 1U + i] == detail::float_to_bits(values_a[i]));
                bool last_flag = stream.last[offset + 1U + i];
                if (i + 1U == values_a.size()) {
                    assert(last_flag == true);
                } else {
                    assert(last_flag == false);
                }
            }
            offset += values_a.size() + 1U;
        }
        {
            PacketHeader header = PacketHeader::from_word(stream.words[offset]);
            assert(header.id() == 17U);
            assert(header.payload_words() == values_b.size());
            assert(stream.last[offset] == false);
            for (std::size_t i = 0; i < values_b.size(); ++i) {
                assert(stream.words[offset + 1U + i] == detail::float_to_bits(values_b[i]));
                bool last_flag = stream.last[offset + 1U + i];
                if (i + 1U == values_b.size()) {
                    assert(last_flag == true);
                } else {
                    assert(last_flag == false);
                }
            }
        }
    }

    return 0;
}
