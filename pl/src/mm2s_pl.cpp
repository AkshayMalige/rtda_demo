

#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" {
	void mm2s_pl(float*                mem,
				 hls::stream<axis_t>&  s,
				 int                   size)
	{
	  // ---- AXI master (must have depth for *both* synthesis & sim) ----
	  #pragma HLS INTERFACE m_axi     port=mem offset=slave bundle=gmem depth=4096
	
	  // ---- AXI-Stream: big FIFO only for sim, tiny (or none) for RTL ----
	  #ifndef __SYNTHESIS__
		#pragma HLS INTERFACE axis port=s depth=4096   // large virtual FIFO
	  #else
		#pragma HLS INTERFACE axis port=s              // let backend choose
	  #endif
	
	  #pragma HLS INTERFACE s_axilite port=mem  bundle=control
	  #pragma HLS INTERFACE s_axilite port=size bundle=control
	  #pragma HLS INTERFACE s_axilite port=return bundle=control
	
	  for (int i = 0; i < size; ++i) {
		#pragma HLS PIPELINE II=1
		axis_t val;   val.data = mem[i];
		s.write(val);
	  }
	}
}