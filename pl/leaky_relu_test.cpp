#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <ap_int.h>
#include <fstream>
#include <iostream>

#define SIZE 128
#define LEAKY_SLOPE 0.1f

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

// Declare DUT
extern void leaky_relu_pl(hls::stream<axis_t>& in_stream,
                          hls::stream<axis_t>& out_stream);

int main() {
    hls::stream<axis_t> in_stream;
    hls::stream<axis_t> out_stream;

    // Read input data from file
    std::ifstream fin("../aieml/data/dense1_output.txt");
    if (!fin.is_open()) {
        std::cerr << "ERROR: Cannot open input_data.txt" << std::endl;
        return 1;
    }

    for (int i = 0; i < SIZE; ++i) {
        data_t val;
        fin >> val;
        axis_t temp;
        temp.data = val;
        temp.keep = -1; // Optional: Set to all-1s
        temp.last = 0;
        in_stream.write(temp);
    }
    fin.close();

    // Call DUT
    leaky_relu_pl(in_stream, out_stream);

    // Write output data to file
    std::ofstream fout("leakyrelu_output.txt");
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