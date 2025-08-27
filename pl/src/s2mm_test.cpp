#include <iostream>
#include <fstream>
#include <vector>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include "../../common/data_paths.h"
#include <string>

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" void s2mm_pl(hls::stream<axis_t>& s, float* mem, int size);

constexpr int SIZE = 128;

int main() {
    hls::stream<axis_t> s_in;
    std::vector<data_t> golden_data;
    golden_data.reserve(SIZE);
    
    const char* data_dir = DATA_DIR;
    std::cout << "DATA_DIR resolved to: " << data_dir << std::endl;
    std::string filepath = std::string(data_dir) + "/" + EMBED_DENSE0_BIAS;
    std::ifstream fin(filepath);
    if (!fin.is_open()) {
        std::cerr << "ERROR: Cannot open file: " << filepath << std::endl;
        return 1;
    }

    for (int i = 0; i < SIZE; ++i) {
        data_t val;
        fin >> val;
        golden_data.push_back(val);
        axis_t temp;
        temp.data = val;
        temp.keep = -1;
        temp.last = (i == SIZE - 1);
        s_in.write(temp);
    }
    fin.close();

    data_t mem_out[SIZE];
    s2mm_pl(s_in, mem_out, SIZE);

    bool pass = true;
    for (int i = 0; i < SIZE; ++i) {
        if (mem_out[i] != golden_data[i]) {
            std::cerr << "Mismatch @ index " << i << ": Expected " << golden_data[i]
                      << ", Got " << mem_out[i] << std::endl;
            pass = false;
        }
    }

    if (pass)
        std::cout << "Test PASSED – all " << SIZE << " words written to memory correctly." << std::endl;
    else
        std::cout << "Test FAILED." << std::endl;

    return pass ? 0 : 1;
}
