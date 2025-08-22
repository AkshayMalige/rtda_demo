#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <iostream>

static const int NUM_OUTPUTS = 17;

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 5> axis_t;

extern "C" void axis_switch_pl(hls::stream<axis_t> &in,
                                hls::stream<axis_t> out[NUM_OUTPUTS],
                                unsigned int total);

int main() {
    hls::stream<axis_t> in;
    hls::stream<axis_t> out[NUM_OUTPUTS];

    const int NUM = 34;
    // Generate input data with varying destinations
    for (int i = 0; i < NUM; ++i) {
        axis_t val;
        val.data = i;
        val.keep = -1;
        val.dest = i % NUM_OUTPUTS;
        val.last = (i == NUM - 1);
        in.write(val);
    }

    // Invoke with an explicit element count
    axis_switch_pl(in, out, NUM);

    // Verify that each output received the correct element
    for (int i = 0; i < NUM; ++i) {
        axis_t v = out[i % NUM_OUTPUTS].read();
        if (v.data != i) {
            std::cerr << "Mismatch at index " << i << std::endl;
            return 1;
        }
    }
    std::cout << "Testbench completed successfully." << std::endl;
    return 0;
}
