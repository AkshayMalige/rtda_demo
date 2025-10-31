
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include "../../common/data_paths.h"
#include "../../aieml/nn_defs10.h"
#include <ap_int.h>
#include <fstream>
#include <iostream>

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" {
    void leaky_relu_pl(hls::stream<axis_t>& in_stream,
                       hls::stream<axis_t>& bias_stream,
                       hls::stream<axis_t>& out_stream,
                       int size);
}

int main() {
    hls::stream<axis_t> in_stream;
    hls::stream<axis_t> bias_stream;
    hls::stream<axis_t> out_stream;

    std::ifstream fin_data(std::string(DATA_DIR) + "/" + std::string(EMBED_DENSE1_OUTPUT));
    if (!fin_data.is_open()) {
        std::cerr << "ERROR: Cannot open EMBED_DENSE1_OUTPUT" << std::endl;
        return 1;
    }

    std::ifstream fin_bias(std::string(DATA_DIR) + "/"  + std::string(EMBED_DENSE1_BIAS));
    if (!fin_bias.is_open()) {
        std::cerr << "ERROR: Cannot open EMBED_DENSE1_BIAS" << std::endl;
        return 1;
    }

    // Preload all bias values before streaming any input data
    data_t bias_buf[HIDDEN_SIZE];
    for (int i = 0; i < HIDDEN_SIZE; ++i) {
        fin_bias >> bias_buf[i];
        axis_t temp;
        temp.data = bias_buf[i];
        temp.keep = -1;
        temp.last = (i == HIDDEN_SIZE - 1);
        bias_stream.write(temp);
    }
    fin_bias.close();

    // Stream input data after bias preload
    data_t in_buf[HIDDEN_SIZE];
    for (int i = 0; i < HIDDEN_SIZE; ++i) {
        fin_data >> in_buf[i];
        axis_t temp;
        temp.data = in_buf[i];
        temp.keep = -1;
        temp.last = (i == HIDDEN_SIZE - 1);
        in_stream.write(temp);
    }
    fin_data.close();

    leaky_relu_pl(in_stream, bias_stream, out_stream, HIDDEN_SIZE);

    std::ofstream fout(std::string(DATA_DIR) + "/leakyrelu_output_pl.txt");
    if (!fout.is_open()) {
        std::cerr << "ERROR: Cannot open leakyrelu_output.txt" << std::endl;
        return 1;
    }

    bool pass = true;
    for (int i = 0; i < HIDDEN_SIZE; ++i) {
        data_t expected = in_buf[i] + bias_buf[i];
        expected = (expected >= 0) ? expected : (expected * LEAKY_SLOPE);
        axis_t temp = out_stream.read();
        fout << temp.data << std::endl;
        if (temp.data != expected) {
            std::cerr << "Mismatch at index " << i
                      << ": expected " << expected
                      << ", got " << temp.data << std::endl;
            pass = false;
        }
    }
    fout.close();

    if (pass)
        std::cout << "Test PASSED - all " << HIDDEN_SIZE << " outputs match." << std::endl;
    else
        std::cout << "Test FAILED." << std::endl;

    return pass ? 0 : 1;
}
