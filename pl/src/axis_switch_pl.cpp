#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

static const int NUM_OUTPUTS = 17;

typedef float data_t;
typedef hls::axis<data_t, 0, 5, 0> axis_t; // DEST width 5 bits

extern "C" {
void axis_switch_pl(hls::stream<axis_t> &in, hls::stream<axis_t> out[NUM_OUTPUTS]) {
#pragma HLS INTERFACE axis port=in
#pragma HLS INTERFACE axis port=out
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS ARRAY_PARTITION variable=out complete

    bool last = false;
    while (!last) {
#pragma HLS PIPELINE II=1
        axis_t val = in.read();
        ap_uint<5> dest = val.dest;
        if (dest < NUM_OUTPUTS) {
            out[dest].write(val);
        }
        last = val.last;
    }
}
}
