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
void leaky_splitter_pl(hls::stream<axis_t>& in_stream,
                       hls::stream<axis_t> out_stream[CASCADE_LENGTH]);
}

int main() {
    hls::stream<axis_t> in_stream;
    hls::stream<axis_t> out_stream[CASCADE_LENGTH];

    std::ifstream fin(std::string(DATA_DIR) + "/leakyrelu_output_ref.txt");
    if (!fin.is_open()) {
        std::cerr << "ERROR: Cannot open dense1_output_ref.txt" << std::endl;
        return 1;
    }

    for (int i = 0; i < HIDDEN_SIZE; ++i) {
        data_t val;
        fin >> val;
        axis_t temp;
        temp.data = val;
        temp.keep = -1;
        temp.last = (i == HIDDEN_SIZE - 1);
        in_stream.write(temp);
    }
    fin.close();

    leaky_splitter_pl(in_stream, out_stream);

    std::ofstream fout[CASCADE_LENGTH];
    fout[0].open(std::string(DATA_DIR) + "/leakyrelu_output_pl_part0.txt");
    fout[1].open(std::string(DATA_DIR) + "/leakyrelu_output_pl_part1.txt");

    for (int i = 0; i < CASCADE_LENGTH; ++i) {
        if (!fout[i].is_open()) {
            std::cerr << "ERROR: Cannot open output file part " << i << std::endl;
            return 1;
        }
    }

    const int SPLIT_SIZE = HIDDEN_SIZE / CASCADE_LENGTH;
    for (int i = 0; i < CASCADE_LENGTH; ++i) {
        for (int j = 0; j < SPLIT_SIZE; ++j) {
            axis_t temp = out_stream[i].read();
            fout[i] << temp.data << std::endl;
        }
        fout[i].close();
    }

    std::cout << "Testbench completed successfully." << std::endl;
    return 0;
}
