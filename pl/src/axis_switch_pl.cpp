#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

typedef float data_t;
typedef hls::axis<data_t,0,0,4> axis_t;

extern "C" {
void axis_switch_pl(hls::stream<axis_t>& s_in,
                    hls::stream<axis_t>& out0,
                    hls::stream<axis_t>& out1,
                    hls::stream<axis_t>& out2,
                    hls::stream<axis_t>& out3,
                    hls::stream<axis_t>& out4,
                    hls::stream<axis_t>& out5) {
#pragma HLS INTERFACE axis port=s_in
#pragma HLS INTERFACE axis port=out0
#pragma HLS INTERFACE axis port=out1
#pragma HLS INTERFACE axis port=out2
#pragma HLS INTERFACE axis port=out3
#pragma HLS INTERFACE axis port=out4
#pragma HLS INTERFACE axis port=out5
#pragma HLS INTERFACE ap_ctrl_none port=return

    while (true) {
#pragma HLS PIPELINE II=1
        axis_t val = s_in.read();
        switch (val.dest) {
            case 0: out0.write(val); break;
            case 1: out1.write(val); break;
            case 2: out2.write(val); break;
            case 3: out3.write(val); break;
            case 4: out4.write(val); break;
            case 5: out5.write(val); break;
            default: break;
        }
    }
}
}
