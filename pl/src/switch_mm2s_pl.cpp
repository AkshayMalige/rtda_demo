#include <ap_int.h>
#include <hls_stream.h>
#include <stdint.h>
#include <assert.h>
#include <ap_axi_sdata.h> // ap_axiu

// 32-bit data, 1-bit user, 1-bit id, 8-bit dest; keep/strb implied by width (AXIS)
typedef ap_axiu<32,1,1,8> axis_t;  // data,user,id,dest

extern "C" {
void switch_mm2s_pl(const ap_uint<32>* in,      // AXI4-MM (DDR)
                  hls::stream<axis_t>& out,   // AXI4-Stream (1 physical bus)
                  uint32_t total_words        // total 32-bit words in "in"
) {
#pragma HLS INTERFACE m_axi     port=in  offset=slave bundle=gmem depth=65536
#ifndef __SYNTHESIS__
#pragma HLS INTERFACE axis port=out depth=256
#else
#pragma HLS INTERFACE axis port=out
#endif
#pragma HLS INTERFACE s_axilite port=in           bundle=control
#pragma HLS INTERFACE s_axilite port=total_words  bundle=control
#pragma HLS INTERFACE s_axilite port=return       bundle=control

  const uint32_t WORDS_PER_HDR = 4; // 16 bytes / 4 bytes per word
  uint32_t idx = 0;

  while (idx + WORDS_PER_HDR <= total_words) {
    // Header layout:
    // w0: [31:24]=part, [23:16]=kind, [15:8]=reserved, [7:0]=layer_id
    // w1: len_words (payload length)
    // w2: reserved
    // w3: reserved
    ap_uint<32> w0 = in[idx + 0];
    ap_uint<32> w1 = in[idx + 1];
    // ap_uint<32> w2 = in[idx + 2];
    // ap_uint<32> w3 = in[idx + 3];
    idx += WORDS_PER_HDR;

    ap_uint<8>  part     = w0.range(31,24);
    ap_uint<8>  kind     = w0.range(23,16);
    ap_uint<8>  layer_id = w0.range(7,0);
    uint32_t    len_words= (uint32_t)w1;

    // Safety: bail if malformed
    if (idx + len_words > total_words) break;

    // Stream payload
    for (uint32_t i = 0; i < len_words; ++i) {
#pragma HLS PIPELINE II=1
      axis_t t;
      t.data = in[idx + i];
      t.keep = -1;  // all bytes valid
      t.strb = -1;
      t.user = 0;
      t.id   = 0;
      t.dest = layer_id;
      t.last = (i == (len_words - 1)) ? 1 : 0;
      out.write(t);
    }
    idx += len_words;
  }
}
}
