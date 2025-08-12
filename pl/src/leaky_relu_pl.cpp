#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <ap_int.h>

#define SIZE 128
#define LEAKY_SLOPE (-0.1f)

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" {
    // Apply bias then leaky ReLU to SIZE elements
    void leaky_relu_pl(hls::stream<axis_t>& in_stream,
                       hls::stream<axis_t>& bias_stream,
                       hls::stream<axis_t>& out_stream) {
        #pragma HLS interface axis port=in_stream bundle=gmem depth=128
        #pragma HLS interface axis port=bias_stream bundle=gmem depth=128
        #pragma HLS interface axis port=out_stream bundle=gmem depth=128
        #pragma HLS INTERFACE s_axilite port=return bundle=control

        for (int i = 0; i < SIZE; i++) {
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