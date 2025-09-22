/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_axi_sdata.h"
typedef ap_axiu<32,0,0,0> axis32_t;

namespace {

axis32_t format_header(axis32_t header_word) {
#pragma HLS inline
    axis32_t formatted = header_word;
    formatted.keep     = -1;
    formatted.last     = ap_uint<1>(0);
    return formatted;
}

} // namespace

void hls_packet_receiver2(hls::stream<axis32_t>& in, hls::stream<axis32_t>& out,
                          const unsigned int total_num_packet) {
#pragma HLS INTERFACE axis port = in
#pragma HLS INTERFACE axis port = out
#pragma HLS INTERFACE s_axilite port = total_num_packet bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

    const int packet_limit = static_cast<int>(total_num_packet);
#ifdef VERIFY_PAYLOAD_LEN
    static bool payload_len_mismatch = false;
#endif

    packet_loop:
    for (int pkt = 0; pkt < packet_limit; ++pkt) {
        axis32_t header = in.read();
        const ap_uint<32> header_word = header.data;
        const ap_uint<12> payload_len = header_word(27, 16);
        const bool        has_payload = (header.last == ap_uint<1>(0));

#ifdef VERIFY_PAYLOAD_LEN
        const unsigned expected_len = static_cast<unsigned>(payload_len);
        unsigned       seen         = 0U;
#endif

        out.write(format_header(header));

        bool last_word = !has_payload;
        if (!last_word) {
        payload_loop:
            do {
#pragma HLS PIPELINE II = 1
                axis32_t tmp = in.read();
                last_word     = tmp.last;
                out.write(tmp);
#ifdef VERIFY_PAYLOAD_LEN
                ++seen;
#endif
            } while (!last_word);
        }

#ifdef VERIFY_PAYLOAD_LEN
        if ((expected_len != 0U) && (seen != expected_len) && !payload_len_mismatch) {
            payload_len_mismatch = true;
        }
#endif
    }
}
