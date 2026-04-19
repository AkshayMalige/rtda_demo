#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

// Data type selection via preprocessor
#ifdef USE_INT16
    typedef ap_int<16> data_t;
    typedef int32_t accum_t;  // Use wider type for accumulation to prevent overflow
    typedef ap_int<32> stream_t;  // 32-bit stream to match plio_32_bits
#else  // USE_FLOAT32 or default
    typedef float data_t;
    typedef float accum_t;
    typedef float stream_t;
#endif

typedef hls::axis<stream_t, 0, 0, 0> axis_t;  // Always 32-bit AXI stream

static constexpr int VECTOR_SIZE = 128;

// Memory port type: always 32-bit to avoid cosim issues with sub-32-bit m_axi
#ifdef USE_INT16
    typedef int32_t mem_t;
#else
    typedef float mem_t;
#endif

extern "C" {
    // Average incoming AXI stream frames into memory outputs
    void track_average_pl(hls::stream<axis_t>& s, mem_t* mem, int size, int threshold) {
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

#ifdef USE_INT16
        // AIE-ML packs two int16 elements into each 32-bit AXI beat
        // (low half = element N, high half = element N+1). `size` is the
        // total element count expected, so we consume size/2 beats.
        int beats = size >> 1;
        for (int b = 0; b < beats; b++) {
            #pragma HLS PIPELINE II=1
            axis_t val = s.read();
            data_t d0 = val.data.range(15, 0);
            data_t d1 = val.data.range(31, 16);

            // ---- element N ----
            if (window_count == 0) accum[element_index]  = static_cast<accum_t>(d0);
            else                   accum[element_index] += static_cast<accum_t>(d0);
            element_index++;
            if (element_index == VECTOR_SIZE) {
                element_index = 0;
                window_count++;
                if (window_count == threshold) {
                    for (int j = 0; j < VECTOR_SIZE; j++) {
                        #pragma HLS UNROLL
                        mem[output_index * VECTOR_SIZE + j] =
                            static_cast<mem_t>(static_cast<data_t>(accum[j] / threshold));
                    }
                    output_index++;
                    window_count = 0;
                }
            }

            // ---- element N+1 ----
            if (window_count == 0) accum[element_index]  = static_cast<accum_t>(d1);
            else                   accum[element_index] += static_cast<accum_t>(d1);
            element_index++;
            if (element_index == VECTOR_SIZE) {
                element_index = 0;
                window_count++;
                if (window_count == threshold) {
                    for (int j = 0; j < VECTOR_SIZE; j++) {
                        #pragma HLS UNROLL
                        mem[output_index * VECTOR_SIZE + j] =
                            static_cast<mem_t>(static_cast<data_t>(accum[j] / threshold));
                    }
                    output_index++;
                    window_count = 0;
                }
            }
        }
#else
        // float32: one element per 32-bit beat.
        for (int i = 0; i < size; i++) {
            #pragma HLS PIPELINE II=1
            axis_t val = s.read();
            data_t data = val.data;

            if (window_count == 0) accum[element_index]  = static_cast<accum_t>(data);
            else                   accum[element_index] += static_cast<accum_t>(data);

            element_index++;
            if (element_index == VECTOR_SIZE) {
                element_index = 0;
                window_count++;
                if (window_count == threshold) {
                    for (int j = 0; j < VECTOR_SIZE; j++) {
                        #pragma HLS UNROLL
                        mem[output_index * VECTOR_SIZE + j] =
                            accum[j] / static_cast<accum_t>(threshold);
                    }
                    output_index++;
                    window_count = 0;
                }
            }
        }
#endif
    }
}
