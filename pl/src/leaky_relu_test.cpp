#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include "../../common/data_paths.h"
#include <ap_int.h>
#include <fstream>
#include <iostream>

#define SIZE 128

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" {
    void leaky_relu_pl(hls::stream<axis_t>& in_stream,
                       hls::stream<axis_t>& bias_stream,
                       hls::stream<axis_t>& out_stream);
}

int main() {
    hls::stream<axis_t> in_stream;
    hls::stream<axis_t> bias_stream;
    hls::stream<axis_t> out_stream;

    // std::ifstream fin_data(std::string(DATA_DIR) + "/dense1_output_aie.txt");
    std::ifstream fin_data(std::string(DATA_DIR) + std::string(OUTPUT_DENSE1_FILE) + ".txt");

    if (!fin_data.is_open()) {
        std::cerr << "ERROR: Cannot open OUTPUT_DENSE1_FILE" << std::endl;
        return 1;
    }

    // std::ifstream fin_bias(std::string(DATA_DIR) + "/dense_0_bias.txt");
    std::ifstream fin_data(std::string(DATA_DIR) + std::string(BIAS_DENSE1_FILE) + ".txt");
    if (!fin_bias.is_open()) {
        std::cerr << "ERROR: Cannot open BIAS_DENSE1_FILE" << std::endl;
        return 1;
    }

    for (int i = 0; i < SIZE; ++i) {
        data_t val;
        fin_data >> val;
        axis_t temp;
        temp.data = val;
        temp.keep = -1;
        temp.last = (i == SIZE - 1);
        in_stream.write(temp);

        data_t bias_val;
        fin_bias >> bias_val;
        axis_t bias_temp;
        bias_temp.data = bias_val;
        bias_temp.keep = -1;
        bias_temp.last = (i == SIZE - 1);
        bias_stream.write(bias_temp);
    }
    fin_data.close();
    fin_bias.close();

    leaky_relu_pl(in_stream, bias_stream, out_stream);

    std::ofstream fout(std::string(DATA_DIR) + "/leakyrelu_output_pl.txt");
    if (!fout.is_open()) {
        std::cerr << "ERROR: Cannot open leakyrelu_output.txt" << std::endl;
        return 1;
    }

    for (int i = 0; i < SIZE; ++i) {
        axis_t temp = out_stream.read();
        fout << temp.data << std::endl;
    }
    fout.close();

    std::cout << "Testbench completed successfully." << std::endl;
    return 0;
}