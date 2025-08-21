#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" {
    // Move data from memory to an AXI stream.  The memory pointer and
    // transfer length are provided at run time so the same kernel instance
    // can be reused for any block of data without recompilation.
    void mm2s_pl(float* mem, hls::stream<axis_t>& s, int offset, int size) {
        #pragma HLS INTERFACE m_axi port=mem offset=slave bundle=gmem depth=4096
        #ifndef __SYNTHESIS__
            #pragma HLS INTERFACE axis port=s depth=4096
        #else
            #pragma HLS INTERFACE axis port=s
        #endif
        #pragma HLS INTERFACE s_axilite port=mem bundle=control
        #pragma HLS INTERFACE s_axilite port=offset bundle=control
        #pragma HLS INTERFACE s_axilite port=size bundle=control
        #pragma HLS INTERFACE s_axilite port=return bundle=control

        // Start reading from the specified offset so arbitrary sub-buffers can
        // be transmitted.
        for (int i = 0; i < size; ++i) {
            #pragma HLS PIPELINE II=1
            axis_t val;
            val.data = mem[offset + i];
            s.write(val);
        }
    }
}
