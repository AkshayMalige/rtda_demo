#include "hls_stream.h"
#include "ap_int.h"
#include "ap_axi_sdata.h"
static const unsigned int pktType = 0;
static const int PACKET_NUM = 6;

static const unsigned int packet_ids[PACKET_NUM] = {0, 1, 2, 3, 4, 5};

typedef ap_axiu<32, 0, 0, 0> axis32_t;

static inline ap_uint<32> generateHeader(unsigned int pktType, unsigned int ID) {
#pragma HLS inline
    ap_uint<32> header = 0;
    header(7, 0)  = ID;
    header(11, 8) = 0;
    header(14,12) = pktType;
    header[15]    = 0;
    header(20,16) = (ap_uint<5>)-1; // source row
    header(27,21) = (ap_uint<7>)-1; // source col
    header(30,28) = 0;
    header[31]    = header(30, 0).xor_reduce() ? (ap_uint<1>)0 : (ap_uint<1>)1;
    return header;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wswitch"

// Helper: read exactly one word from channel i
static inline axis32_t read_from_ch(
    int i,
    hls::stream<axis32_t>& s0,
    hls::stream<axis32_t>& s1,
    hls::stream<axis32_t>& s2,
    hls::stream<axis32_t>& s3,
    hls::stream<axis32_t>& s4,
    hls::stream<axis32_t>& s5)
{
#pragma HLS inline
    switch(i){
        case 0: return s0.read();
        case 1: return s1.read();
        case 2: return s2.read();
        case 3: return s3.read();
        case 4: return s4.read();
        default: return s5.read();
    }
}

#pragma GCC diagnostic pop

extern "C" void hls_packet_sender(
    hls::stream<axis32_t>& s0,
    hls::stream<axis32_t>& s1,
    hls::stream<axis32_t>& s2,
    hls::stream<axis32_t>& s3,
    hls::stream<axis32_t>& s4,
    hls::stream<axis32_t>& s5,
    hls::stream<axis32_t>& out,    // → AI Engine (channels 0..3 only)
    hls::stream<axis32_t>& plout,  // → PL (channels 4..5 only)
    const unsigned int *max_words_per_ch)
{
    // ------- Interfaces (good HLS/Versal practice) -------
    #pragma HLS INTERFACE axis port=s0
    #pragma HLS INTERFACE axis port=s1
    #pragma HLS INTERFACE axis port=s2
    #pragma HLS INTERFACE axis port=s3
    #pragma HLS INTERFACE axis port=s4
    #pragma HLS INTERFACE axis port=s5
    #pragma HLS INTERFACE axis port=out
    #pragma HLS INTERFACE axis port=plout

    #pragma HLS INTERFACE m_axi     port=max_words_per_ch  offset=slave depth=PACKET_NUM bundle=gmem0
    #pragma HLS INTERFACE s_axilite port=max_words_per_ch  bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control

    // Make a local copy so the tool can fully partition & schedule well
    unsigned int words[PACKET_NUM];
    #pragma HLS ARRAY_PARTITION variable=words complete dim=1
    load_words: for (int i = 0; i < PACKET_NUM; ++i) {
        #pragma HLS UNROLL
        words[i] = max_words_per_ch[i];
    }

    // No artificial cross-stream deps; preserve streaming
    #pragma HLS DATAFLOW disable_start_propagation

    // One contiguous packet per channel:
    //  header → payload[0..N-1] (TLAST set on last)
    channel_loop:
    for (int i = 0; i < PACKET_NUM; ++i) {
        unsigned int N = words[i];
        if (N == 0) {
            continue; // Skip zero-length channels entirely.
        }

        const unsigned int ID = packet_ids[i];
        const bool to_aie = (ID < 4);
        const bool to_pl  = (ID >= 4);
        ap_uint<32>  hdr_word = generateHeader(pktType, ID);
        hdr_word(27,16) = N & 0x0FFF;
        hdr_word[31]    = hdr_word(30, 0).xor_reduce() ? (ap_uint<1>)0 : (ap_uint<1>)1;

        // Packet v1: [HEADER(ID,pktType,len,parity)][N payload], TLAST on last. See docs/packet_contract.md
        axis32_t hdr;
        hdr.data = hdr_word;
        hdr.keep = -1;
        hdr.last = 0;

        if (to_aie) {
            out.write(hdr);
        } else if (to_pl) {
            plout.write(hdr);
        }

        payload_loop:
        for (unsigned int j = 0; j < N; ++j) {
            #pragma HLS PIPELINE II=1

            axis32_t d = read_from_ch(i, s0, s1, s2, s3, s4, s5);
            d.keep = -1;
            d.last = (j == (N - 1)) ? (ap_uint<1>)1 : (ap_uint<1>)0;

            if (to_aie) {
                out.write(d);
            } else if (to_pl) {
                plout.write(d);
            }
        }
    }
}
