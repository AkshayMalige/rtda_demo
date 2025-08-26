#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

// 32-bit data, 1-bit user, 1-bit id, 8-bit dest
typedef ap_axiu<32,1,1,8> axis_t;

extern "C" {
void demux_8_pl(
  hls::stream<axis_t>& in,
  hls::stream<axis_t>& out0,
  hls::stream<axis_t>& out1,
  hls::stream<axis_t>& out2,
  hls::stream<axis_t>& out3,
  hls::stream<axis_t>& out4,
  hls::stream<axis_t>& out5,
  hls::stream<axis_t>& out6,
  hls::stream<axis_t>& out7,
  unsigned int        word_count
) {
  // AXI-Stream ports
#pragma HLS INTERFACE axis port=in
#pragma HLS INTERFACE axis port=out0
#pragma HLS INTERFACE axis port=out1
#pragma HLS INTERFACE axis port=out2
#pragma HLS INTERFACE axis port=out3
#pragma HLS INTERFACE axis port=out4
#pragma HLS INTERFACE axis port=out5
#pragma HLS INTERFACE axis port=out6
#pragma HLS INTERFACE axis port=out7
  // AXI-Lite control interface
#pragma HLS INTERFACE s_axilite port=word_count bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

  // Optional elasticity on ports (tune if you see back-pressure)
#pragma HLS STREAM variable=out0 depth=64
#pragma HLS STREAM variable=out1 depth=64
#pragma HLS STREAM variable=out2 depth=64
#pragma HLS STREAM variable=out3 depth=64
#pragma HLS STREAM variable=out4 depth=64
#pragma HLS STREAM variable=out5 depth=64
#pragma HLS STREAM variable=out6 depth=64
#pragma HLS STREAM variable=out7 depth=64

  bool       have_route = false;
  ap_uint<8> route      = 0;
  for (unsigned int i = 0; i < word_count; ++i) {
#pragma HLS PIPELINE II=1
    // Blocking read simplifies logic and helps the scheduler
    axis_t t = in.read();

    // On the first beat of a packet, latch TDEST as the route
    if (!have_route) {
      route = t.dest;
      have_route = true;
    }

    // Prepare output beat: preserve data/keep/strb/last; clear meta we don't use
    axis_t o = t;
    o.id   = 0;
    o.user = 0;
    o.dest = 0; // we've already consumed TDEST into 'route'

    // Clamp to 0..7 (unknown TDESTs go to out7 by default)
    ap_uint<8> r = (route < 8) ? route : (ap_uint<8>)7;

    switch (r) {
      case 0: out0.write(o); break;
      case 1: out1.write(o); break;
      case 2: out2.write(o); break;
      case 3: out3.write(o); break;
      case 4: out4.write(o); break;
      case 5: out5.write(o); break;
      case 6: out6.write(o); break;
      default: out7.write(o); break;
    }

    // End of packet → unlock route for next packet
    if (t.last) {
      have_route = false;
    }
  }
}
}
