#include <iostream>
#include <fstream>
#include <vector>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include "../../common/data_paths.h"

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 5> axis_t;

extern "C" void mm2s_pl(float* mem, hls::stream<axis_t>& s, int offset, int size, int dest);

constexpr int SIZE = 128;

int main() {
    std::vector<data_t> mem_in(SIZE);
    std::vector<data_t> golden_data;
    golden_data.reserve(SIZE);

    std::ifstream fin(std::string(DATA_DIR) + "/output_data_ref.txt");
    if (!fin.is_open()) {
        std::cerr << "ERROR: Cannot open input file leakyrelu_output_ref.txt" << std::endl;
        return 1;
    }

    for (int i = 0; i < SIZE; ++i) {
        data_t val;
        fin >> val;
        mem_in[i] = val;
        golden_data.push_back(val);
    }
    fin.close();

    hls::stream<axis_t> s_out;
    mm2s_pl(mem_in.data(), s_out, 0, SIZE, 0);

    bool pass = true;
    for (int i = 0; i < SIZE; ++i) {
        axis_t val = s_out.read();
        if (val.data != golden_data[i]) {
            std::cerr << "Mismatch @ index " << i << ": Expected " << golden_data[i]
                      << ", Got " << val.data << std::endl;
            pass = false;
        }
    }

    if (pass)
        std::cout << "Test PASSED – all " << SIZE << " words streamed correctly." << std::endl;
    else
        std::cout << "Test FAILED." << std::endl;

    return pass ? 0 : 1;
}
