#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" {
    // Read elements from memory and write to an AXI stream
    void mm2s_pl(float* mem, hls::stream<axis_t>& s, int offset, int size) {
        #pragma HLS INTERFACE m_axi port=mem offset=slave bundle=gmem depth=128
        #pragma HLS INTERFACE axis port=s
        #pragma HLS INTERFACE s_axilite port=mem bundle=control
        #pragma HLS INTERFACE s_axilite port=offset bundle=control
        #pragma HLS INTERFACE s_axilite port=size bundle=control
        #pragma HLS INTERFACE s_axilite port=return bundle=control

        for (int i = 0; i < size; i++) {
            #pragma HLS PIPELINE II=1
            axis_t val;
            val.data = mem[offset + i];
            val.keep = -1;
            val.last = (i == size - 1);
            s.write(val);
        }
    }
}
