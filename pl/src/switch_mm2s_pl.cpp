// switch_mm2s_pl.cpp — one packet per run (ap_ctrl_hs)
#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <cstdint>

typedef ap_axiu<32, 1, 1, 8> axis_t;

// Memory layout at in[0]: [0]=ctrl([7:0]=bus_id), [1]=len(words), [2]=rsv, [3]=rsv, [4..]=payload
extern "C" void switch_mm2s_pl(const ap_uint<32>* in,
                               hls::stream<axis_t>& out,
                               uint32_t total_words) {
#pragma HLS INTERFACE m_axi     port=in           offset=slave bundle=gmem max_read_burst_length=64 depth=65536
#pragma HLS INTERFACE s_axilite port=in           bundle=control
#pragma HLS INTERFACE axis      port=out
#pragma HLS STREAM   variable=out depth=1024
#pragma HLS INTERFACE s_axilite port=total_words  bundle=control
#pragma HLS INTERFACE s_axilite port=return       bundle=control

  if (total_words < 4) return;

  ap_uint<32> w0 = in[0]; // ctrl
  ap_uint<32> w1 = in[1]; // len
  ap_uint<8> raw_id = w0.range(7,0);
  ap_uint<3> tdest  = (raw_id < 8) ? (ap_uint<3>)raw_id : (ap_uint<3>)7;

  uint32_t len_words = (uint32_t)w1;
  uint32_t avail     = (total_words > 4) ? (total_words - 4) : 0;
  if (len_words > avail) len_words = avail;

payload_loop:
  for (uint32_t i = 0; i < len_words; ++i) {
#pragma HLS PIPELINE II=1
    axis_t t;
    t.data = in[4 + i];
    t.keep = -1; t.strb = -1;
    t.user = 0;  t.id   = 0;
    t.dest = tdest;
    t.last = (i == len_words - 1);
    out.write(t);
  }
}
