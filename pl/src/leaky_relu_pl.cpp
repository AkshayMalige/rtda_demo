#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <ap_int.h>
#include "../../common/nn_defs.h"

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" {
    // Apply bias then leaky ReLU to `size` elements
    void leaky_relu_pl(hls::stream<axis_t>& in_stream,
                       hls::stream<axis_t>& bias_stream,
                       hls::stream<axis_t>& out_stream,
                       int size) {
        #pragma HLS interface axis port=in_stream bundle=gmem depth=OUTPUT_DENSE0_OUT_PAD
        #pragma HLS interface axis port=bias_stream bundle=gmem depth=OUTPUT_DENSE0_OUT_PAD
        #pragma HLS interface axis port=out_stream bundle=gmem depth=OUTPUT_DENSE0_OUT_PAD
        #pragma HLS INTERFACE s_axilite port=size bundle=control
        #pragma HLS INTERFACE s_axilite port=return bundle=control

        for (int i = 0; i < size; i++) {
            #pragma HLS pipeline II=1
            axis_t val       = in_stream.read();
            axis_t bias_val  = bias_stream.read();
            data_t input_val = val.data + bias_val.data;
            data_t output_val = (input_val >= 0) ? input_val : (input_val * LEAKY_SLOPE);
            val.data = output_val;
            out_stream.write(val);
        }
    }
}