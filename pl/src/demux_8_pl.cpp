#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

template<int M>
struct Demux {
  typedef ap_axiu<32,1,1,8> axis_t; // data,user,id,dest

  static void run(hls::stream<axis_t>& in,
                  hls::stream<axis_t> out[M]) {
#pragma HLS INLINE off
#pragma HLS ARRAY_PARTITION variable=out complete dim=1

    bool have_route = false;
    ap_uint<8> route = 0;

    while (1) {
#pragma HLS PIPELINE II=1
      if (!in.empty()) {
        axis_t t = in.read();

        // Latch route at packet start (first beat after TLAST or reset)
        if (!have_route) {
          route = t.dest;
          have_route = true;
        }

        // Route selection (clamp to range 0..M-1)
        ap_uint<8> r = (route < (ap_uint<8>)M) ? route : (ap_uint<8>)0;

        // Forward beat to selected output
        axis_t o = t;
        // Clear meta fields we don't use downstream
        o.id = 0; o.user = 0; o.dest = 0;
        out[r].write(o);

        // End-of-packet: reset routing latch
        if (t.last) {
          have_route = false;
        }
      }
    }
  }
};

extern "C" {
void weights_demux_8( // example with 8 outputs; make variants if you need more
  hls::stream<ap_axiu<32,1,1,8>>& in,
  hls::stream<ap_axiu<32,1,1,8>>& out0,
  hls::stream<ap_axiu<32,1,1,8>>& out1,
  hls::stream<ap_axiu<32,1,1,8>>& out2,
  hls::stream<ap_axiu<32,1,1,8>>& out3,
  hls::stream<ap_axiu<32,1,1,8>>& out4,
  hls::stream<ap_axiu<32,1,1,8>>& out5,
  hls::stream<ap_axiu<32,1,1,8>>& out6,
  hls::stream<ap_axiu<32,1,1,8>>& out7
) {
#pragma HLS INTERFACE axis port=in
#pragma HLS INTERFACE axis port=out0
#pragma HLS INTERFACE axis port=out1
#pragma HLS INTERFACE axis port=out2
#pragma HLS INTERFACE axis port=out3
#pragma HLS INTERFACE axis port=out4
#pragma HLS INTERFACE axis port=out5
#pragma HLS INTERFACE axis port=out6
#pragma HLS INTERFACE axis port=out7
#pragma HLS INTERFACE s_axilite port=return bundle=control

  hls::stream<ap_axiu<32,1,1,8>> outs[8];
#pragma HLS STREAM variable=outs depth=32
#pragma HLS ARRAY_PARTITION variable=outs complete dim=1

  Demux<8>::run(in, outs);

  // Bridge array to individual AXIS ports
  if (!outs[0].empty()) out0.write(outs[0].read());
  if (!outs[1].empty()) out1.write(outs[1].read());
  if (!outs[2].empty()) out2.write(outs[2].read());
  if (!outs[3].empty()) out3.write(outs[3].read());
  if (!outs[4].empty()) out4.write(outs[4].read());
  if (!outs[5].empty()) out5.write(outs[5].read());
  if (!outs[6].empty()) out6.write(outs[6].read());
  if (!outs[7].empty()) out7.write(outs[7].read());
}
}
