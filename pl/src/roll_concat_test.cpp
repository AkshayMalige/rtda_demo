#include <hls_stream.h>
#include <iostream>
#include <cmath>
#include <fstream>
#include "../../common/nn_defs.h"

#define OUTPUT_SIZE (HIDDEN_SIZE * ROLL_CONC_SUBSET_SIZE)

typedef float data_t;
void roll_concat(hls::stream<data_t> &in, hls::stream<data_t> &out);

// Golden model
void reference_model(data_t in[HIDDEN_SIZE], data_t out[OUTPUT_SIZE]) {
    for (int shift = 0; shift < ROLL_CONC_SUBSET_SIZE; shift++) {
        for (int i = 0; i < HIDDEN_SIZE; i++) {
            int idx = (i + shift) % HIDDEN_SIZE;
            out[shift * HIDDEN_SIZE + i] = in[idx];
        }
    }
}

int main() {
    hls::stream<data_t> in_stream("input_stream");
    hls::stream<data_t> out_stream("output_stream");

    data_t input[HIDDEN_SIZE];
    data_t ref_output[OUTPUT_SIZE];
    data_t test_output[OUTPUT_SIZE];

    // Read input vector from file
    std::ifstream infile("../data/embed_model_output.txt");
    if (!infile) {
        std::cerr << "Failed to open input file" << std::endl;
        return 1;
    }
    for (int i = 0; i < HIDDEN_SIZE; i++) {
        infile >> input[i];
        in_stream.write(input[i]);
    }
    infile.close();

    // Run kernel
    roll_concat(in_stream, out_stream);

    // Capture output
    for (int i = 0; i < OUTPUT_SIZE; i++) {
        test_output[i] = out_stream.read();
    }

    // Run reference model
    reference_model(input, ref_output);

    // Compare
    int errors = 0;
    for (int i = 0; i < OUTPUT_SIZE; i++) {
        if (std::fabs(ref_output[i] - test_output[i]) > 1e-3) {
            std::cout << "Mismatch at " << i << ": expected " << ref_output[i]
                      << ", got " << test_output[i] << std::endl;
            errors++;
        }
    }

    if (errors == 0) {
        std::cout << "Test passed." << std::endl;
    } else {
        std::cout << "Test failed with " << errors << " mismatches." << std::endl;
    }

    return errors;
}