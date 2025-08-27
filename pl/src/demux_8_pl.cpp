// demux_8_pl.cpp  (ap_ctrl_hs version: handles ONE packet per run)
#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

typedef ap_axiu<32, 1, 1, 8> axis_t;

extern "C" {
void demux_8_pl(hls::stream<axis_t>& in,
                hls::stream<axis_t>& out0,
                hls::stream<axis_t>& out1,
                hls::stream<axis_t>& out2,
                hls::stream<axis_t>& out3,
                hls::stream<axis_t>& out4,
                hls::stream<axis_t>& out5,
                hls::stream<axis_t>& out6,
                hls::stream<axis_t>& out7) {
#pragma HLS interface axis port=in
#pragma HLS interface axis port=out0
#pragma HLS interface axis port=out1
#pragma HLS interface axis port=out2
#pragma HLS interface axis port=out3
#pragma HLS interface axis port=out4
#pragma HLS interface axis port=out5
#pragma HLS interface axis port=out6
#pragma HLS interface axis port=out7
#pragma HLS interface ap_ctrl_hs port=return

    // Optional buffering for timing
#pragma HLS stream variable=out0 depth=128
#pragma HLS stream variable=out1 depth=128
#pragma HLS stream variable=out2 depth=128
#pragma HLS stream variable=out3 depth=128
#pragma HLS stream variable=out4 depth=128
#pragma HLS stream variable=out5 depth=128
#pragma HLS stream variable=out6 depth=128
#pragma HLS stream variable=out7 depth=128

    // Route is (re)latched for this run only
    ap_uint<3> route = 0;
    bool have_route = false;

read_and_route:
    do {
#pragma HLS pipeline II=1
        axis_t t = in.read();

        if (!have_route) {
            ap_uint<8> d = t.dest;
            route = (d < 8) ? (ap_uint<3>)d : (ap_uint<3>)7;
            have_route = true;
        }

        axis_t o = t;
        o.id   = 0;
        o.user = 0;
        o.dest = 0;

        switch ((unsigned)route) {
            case 0: out0.write(o); break;
            case 1: out1.write(o); break;
            case 2: out2.write(o); break;
            case 3: out3.write(o); break;
            case 4: out4.write(o); break;
            case 5: out5.write(o); break;
            case 6: out6.write(o); break;
            default: out7.write(o); break;
        }

        if (t.last) break;   // end of packet -> kernel returns (ap_done=1)
    } while (1);
}
}
