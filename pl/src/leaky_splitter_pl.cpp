#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <ap_int.h>

#define SIZE 128
#define CASCADE_LENGTH 2   // Must be even and divide SIZE

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" {

void leaky_splitter_pl(hls::stream<axis_t>& in_stream,
                     hls::stream<axis_t> out_stream[CASCADE_LENGTH]) {

#pragma HLS interface axis port=in_stream
#pragma HLS interface axis port=out_stream
// #pragma HLS interface ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=return bundle=control

    const int SPLIT_SIZE = SIZE / CASCADE_LENGTH;

split_loop:
    for (int i = 0; i < SIZE; i++) {
#pragma HLS pipeline II=1
        axis_t val = in_stream.read();

        int out_idx = i / SPLIT_SIZE;

        out_stream[out_idx].write(val);
    }
}
}