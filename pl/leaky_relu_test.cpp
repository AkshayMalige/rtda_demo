#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <ap_int.h>
#include <fstream>
#include <iostream>

#define SIZE 128
#define LEAKY_SLOPE 0.1f
#define CASCADE_LENGTH 2   // Must be even and divide SIZE

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

// Declare DUT with C linkage to match the definition
extern "C" {
void leaky_relu_pl(hls::stream<axis_t>& in_stream,
                   hls::stream<axis_t>& out_stream);
}

extern "C" {
void splitter_kernel(hls::stream<axis_t>& in_stream2,
    hls::stream<axis_t> out_stream2[CASCADE_LENGTH]);
}

int main() {
    hls::stream<axis_t> in_stream;
    hls::stream<axis_t> out_stream;
    hls::stream<axis_t> out_stream2[CASCADE_LENGTH];

    // Read input data from file
    std::ifstream fin("dense1_output_ref.txt");
    if (!fin.is_open()) {
        std::cerr << "ERROR: Cannot open dense1_output.txt" << std::endl;
        return 1;
    }

    for (int i = 0; i < SIZE; ++i) {
        data_t val;
        fin >> val;
        axis_t temp;
        temp.data = val;
        temp.keep = -1; 
        temp.last = (i == SIZE - 1); // Set last for the final element
        in_stream.write(temp);
    }
    fin.close();

    // Call DUT
    leaky_relu_pl(in_stream, out_stream);
    splitter_kernel(out_stream, out_stream2);

    // Write output data to file
    std::ofstream fout("leakyrelu_output.txt");
    if (!fout.is_open()) {
        std::cerr << "ERROR: Cannot open leakyrelu_output.txt" << std::endl;
        return 1;
    }

    int error_count = 0;
    for (int i = 0; i < SIZE; ++i) {
        axis_t temp = out_stream.read();
        fout << temp.data << std::endl;
    }
    fout.close();

    std::ofstream fout2("leakyrelu_output_part0.txt");
    if (!fout2.is_open()) {
        std::cerr << "ERROR: Cannot open leakyrelu_output.txt" << std::endl;
        return 1;
    }
    for (int i = 0; i < SIZE/CASCADE_LENGTH; ++i) {
        axis_t temp = out_stream2[i].read();
        fout2 << temp.data << std::endl;
    }
    fout2.close();

    std::ofstream fout3("leakyrelu_output_part1.txt");
    if (!fout3.is_open()) {
        std::cerr << "ERROR: Cannot open leakyrelu_output.txt" << std::endl;
        return 1;
    }
    for (int i = SIZE/CASCADE_LENGTH; i < SIZE; ++i) {
        axis_t temp = out_stream2[i].read();
        fout3 << temp.data << std::endl;
    }
    fout3.close();


    std::cout << "Testbench completed successfully." << std::endl;
    return 0;
}