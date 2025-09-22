#include "hls_stream.h"
#include "ap_axi_sdata.h"
#include "ap_int.h"

typedef ap_axiu<32, 0, 0, 0> axis32_t;

static inline bool is_aie_id(ap_uint<8> id) {
#pragma HLS inline
    return id < 4;
}

static inline bool is_pl_id(ap_uint<8> id) {
#pragma HLS inline
    return (id >= 4) && (id < 6);
}

extern "C" void hls_packet_sender(
    hls::stream<axis32_t>& in,
    hls::stream<axis32_t>& out,
    hls::stream<axis32_t>& plout,
    unsigned int total_packets)
{
    #pragma HLS INTERFACE axis port=in
    #pragma HLS INTERFACE axis port=out
    #pragma HLS INTERFACE axis port=plout

    #pragma HLS INTERFACE s_axilite port=total_packets bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control

    packet_loop:
    for (unsigned int pkt = 0; pkt < total_packets; ++pkt) {
        axis32_t hdr = in.read();
        ap_uint<32> hdr_word = hdr.data;
        ap_uint<8>  id = hdr_word(7, 0);
        ap_uint<12> payload_len = hdr_word(27, 16);

        const bool to_aie = is_aie_id(id);
        const bool to_pl  = is_pl_id(id);
        const bool drop   = !(to_aie || to_pl);

        axis32_t hdr_out = hdr;
        hdr_out.keep = -1;
        hdr_out.last = (payload_len == 0) ? (ap_uint<1>)1 : (ap_uint<1>)0;

        if (!drop) {
            if (to_aie) {
                out.write(hdr_out);
            } else {
                plout.write(hdr_out);
            }
        }

        payload_loop:
        for (ap_uint<12> idx = 0; idx < payload_len; ++idx) {
#pragma HLS PIPELINE II=1
            axis32_t d = in.read();
            d.keep = -1;
            d.last = (idx == payload_len - 1) ? (ap_uint<1>)1 : (ap_uint<1>)0;

            if (!drop) {
                if (to_aie) {
                    out.write(d);
                } else {
                    plout.write(d);
                }
            }
        }
    }
}

