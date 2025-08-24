#include <iostream>
#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include "../../common/data_paths.h"
#include <fstream>

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 4> axis_t;

extern "C" void mm2s_pl(float* mem, hls::stream<axis_t>& s, int size, int dest);

constexpr int SIZE = 8;

int main() {
    data_t mem[SIZE];

    std::ifstream fin(std::string(DATA_DIR) + "/" + EMBED_INPUT_DATA);
    if (!fin.is_open()) {
        std::cerr << "ERROR: Cannot open input_data.txt" << std::endl;
        return 1;
    }
    for (int i = 0; i < SIZE; ++i) {
        data_t val;
        fin >> val;
        mem[i] = val;
    }

    hls::stream<axis_t> s_out;
    mm2s_pl(mem, s_out, SIZE, 0);

    bool pass = true;
    for (int i = 0; i < SIZE; ++i) {
        if (s_out.empty()) {
            std::cerr << "ERROR: stream underrun at word " << i << std::endl;
            pass = false;
            break;
        }
        axis_t val = s_out.read();
        std::cout << val.data << std::endl;
        if (val.data != mem[i]) {
            std::cerr << "Mismatch @ " << i << std::endl;
            pass = false;
        }
    }
    if (!s_out.empty()) {
        std::cerr << "ERROR: stream contains extra data!" << std::endl;
        pass = false;
    }

    if (pass)
        std::cout << "Test PASSED – all " << SIZE << " words correct." << std::endl;
    else
        std::cout << "Test FAILED." << std::endl;

    return pass ? 0 : 1;
}
