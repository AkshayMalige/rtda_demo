/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_axi_sdata.h"
static const int PACKET_NUM=4;

typedef ap_axiu<32,0,0,0> axis32_t;

unsigned int getPacketId(ap_uint<32> header){
#pragma HLS inline
        ap_uint<32> ID=0;
        ID(7,0)=header(7,0);
        return ID;
}

void hls_packet_receiver(hls::stream<axis32_t>& in, hls::stream<axis32_t>& out,
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
        const ap_uint<8>  id          = static_cast<ap_uint<8>>(getPacketId(header_word));
        const ap_uint<12> payload_len = header_word(27, 16);
        const bool        valid_channel = (id < PACKET_NUM);
        const bool        has_payload   = (header.last == ap_uint<1>(0));

#ifdef VERIFY_PAYLOAD_LEN
        const unsigned expected_len = static_cast<unsigned>(payload_len);
        unsigned       seen         = 0U;
#endif

        if (valid_channel) {
            axis32_t header_out = header;
            header_out.keep = -1;
            header_out.last = has_payload ? ap_uint<1>(0) : ap_uint<1>(1);
            out.write(header_out);
        }

        bool last_word = !has_payload;
        if (!last_word) {
        payload_loop:
            do {
#pragma HLS PIPELINE II = 1
                axis32_t tmp = in.read();
                last_word     = tmp.last;
                tmp.keep      = -1;

                if (valid_channel) {
                    out.write(tmp);
                }
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
