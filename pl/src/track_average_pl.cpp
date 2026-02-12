#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

// Data type selection via preprocessor
#ifdef USE_INT16
    typedef ap_int<16> data_t;
    typedef int32_t accum_t;  // Use wider type for accumulation to prevent overflow
    #define DATA_WIDTH 16
#else  // USE_FLOAT32 or default
    typedef float data_t;
    typedef float accum_t;
    #define DATA_WIDTH 32
#endif

typedef hls::axis<data_t, 0, 0, 0> axis_t;

static constexpr int VECTOR_SIZE = 128;

extern "C" {
    // Average incoming AXI stream frames into memory outputs
#ifdef USE_INT16
    void track_average_pl(hls::stream<axis_t>& s, ap_int<16>* mem, int size, int threshold) {
#else
    void track_average_pl(hls::stream<axis_t>& s, float* mem, int size, int threshold) {
#endif
        #pragma HLS INTERFACE m_axi port=mem offset=slave bundle=gmem depth=4096
        #pragma HLS INTERFACE axis port=s
        #pragma HLS INTERFACE s_axilite port=mem bundle=control
        #pragma HLS INTERFACE s_axilite port=size bundle=control
        #pragma HLS INTERFACE s_axilite port=threshold bundle=control
        #pragma HLS INTERFACE s_axilite port=return bundle=control

        if (threshold <= 0) {
            return;
        }

        accum_t accum[VECTOR_SIZE];
        #pragma HLS ARRAY_PARTITION variable=accum complete dim=1

        int window_count = 0;
        int element_index = 0;
        int output_index = 0;

        for (int i = 0; i < size; i++) {
            #pragma HLS PIPELINE II=1
            axis_t val = s.read();
            data_t data = val.data;

            if (window_count == 0) {
                accum[element_index] = static_cast<accum_t>(data);
            } else {
                accum[element_index] += static_cast<accum_t>(data);
            }

            element_index++;
            if (element_index == VECTOR_SIZE) {
                element_index = 0;
                window_count++;

                if (window_count == threshold) {
                    for (int j = 0; j < VECTOR_SIZE; j++) {
                        #pragma HLS UNROLL
#ifdef USE_INT16
                        // For int16: divide and cast back to int16
                        mem[output_index * VECTOR_SIZE + j] = static_cast<data_t>(accum[j] / threshold);
#else
                        // For float: standard division
                        mem[output_index * VECTOR_SIZE + j] = accum[j] / static_cast<accum_t>(threshold);
#endif
                    }
                    output_index++;
                    window_count = 0;
                }
            }
        }
    }
}
