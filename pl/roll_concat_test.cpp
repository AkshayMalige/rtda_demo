#include <hls_stream.h>
#include <iostream>
#include <cmath>

#define FEATURE_SIZE 128
#define SUBSET_SIZE 6
#define OUTPUT_SIZE (FEATURE_SIZE * SUBSET_SIZE)

typedef float data_t;
void roll_concat(hls::stream<data_t> &in, hls::stream<data_t> &out);

// Golden model
void reference_model(data_t in[FEATURE_SIZE], data_t out[OUTPUT_SIZE]) {
    for (int shift = 0; shift < SUBSET_SIZE; shift++) {
        for (int i = 0; i < FEATURE_SIZE; i++) {
            int idx = (i + shift) % FEATURE_SIZE;
            out[shift * FEATURE_SIZE + i] = in[idx];
        }
    }
}

int main() {
    hls::stream<data_t> in_stream("input_stream");
    hls::stream<data_t> out_stream("output_stream");

    data_t input[FEATURE_SIZE];
    data_t ref_output[OUTPUT_SIZE];
    data_t test_output[OUTPUT_SIZE];

    // Initialize input with known pattern
    for (int i = 0; i < FEATURE_SIZE; i++) {
        input[i] = (data_t)i;
        in_stream.write(input[i]);
    }

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