#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" {
    // Write elements from an AXI stream into memory
    void s2mm_pl(hls::stream<axis_t>& s, float* mem, int size) {
        #pragma HLS INTERFACE m_axi port=mem offset=slave bundle=gmem depth=1024
        #pragma HLS INTERFACE axis port=s
        #pragma HLS INTERFACE s_axilite port=mem bundle=control
        #pragma HLS INTERFACE s_axilite port=size bundle=control
        #pragma HLS INTERFACE s_axilite port=return bundle=control

        for (int i = 0; i < size; i++) {
            #pragma HLS PIPELINE II=1
            axis_t val = s.read();
            mem[i] = val.data;
        }
    }
}
