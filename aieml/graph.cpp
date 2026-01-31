#include "graph.h"
#include "data_paths.h"
#include "nn_defs10.h"
#include "utils.hpp"
#include "data_types.h"
#include <cstring>
#include <fstream>
#include <initializer_list>
#include <iomanip>
#include <iostream>
#include <limits>
#include <string>
#include <utility>
#include <vector>
#include <algorithm> // For std::min

NeuralNetworkGraph g;

// #if defined(__AIESIM__) || defined(__X86SIM__)

namespace {

    constexpr std::size_t EMBED_DENSE0_WEIGHTS_COUNT = static_cast<std::size_t>(EMBED_DENSE0_WEIGHTS_TOTAL);
    constexpr std::size_t EMBED_INPUT_VECTOR_LENGTH = static_cast<std::size_t>(INPUT_SIZE);
    constexpr std::size_t OUTPUT_VECTOR_LENGTH = static_cast<std::size_t>(HIDDEN_SIZE);


} // namespace

int main() {

    g.init();

    // Load weights manually
    auto weights = load_vector_from_datadir<DATA_TYPE>(EMBED_DENSE0_WEIGHTS, EMBED_DENSE0_WEIGHTS_COUNT);
    if (weights.empty()) {
        std::cerr << "Error: Failed to load weights from " << EMBED_DENSE0_WEIGHTS << std::endl;
        return -1;
    }

    // --- Weights Padding Logic ---
    // If GRAPH_INPUT_SIZE (aligned) > INPUT_SIZE (logical), we must pad the weights matrix.
    // The matrix is row-major: Rows = HIDDEN_SIZE, Cols = INPUT_SIZE.
    // We assume DimALeading=1 in the graph definition implies row-major storage.
    
    std::vector<DATA_TYPE> padded_weights;
    const DATA_TYPE* weights_data_ptr = weights.data();
    size_t weights_count_to_send = weights.size();

    // Check if alignment padding is required
    // GRAPH_INPUT_SIZE comes from graph.h
    if (GRAPH_INPUT_SIZE > EMBED_INPUT_VECTOR_LENGTH) {
        size_t rows = OUTPUT_VECTOR_LENGTH; // HIDDEN_SIZE
        size_t cols = EMBED_INPUT_VECTOR_LENGTH; // INPUT_SIZE
        size_t aligned_cols = GRAPH_INPUT_SIZE;
        size_t padding_per_row = aligned_cols - cols;
        
        padded_weights.reserve(rows * aligned_cols);
        
        for (size_t r = 0; r < rows; ++r) {
            // Copy row data
            size_t row_start = r * cols;
            // Check bounds safety
            if (row_start + cols > weights.size()) {
                 std::cerr << "Error: Weights data insufficient for " << rows << "x" << cols << std::endl;
                 return -1;
            }
            
            for (size_t c = 0; c < cols; ++c) {
                padded_weights.push_back(weights[row_start + c]);
            }
            // Pad row
            for (size_t p = 0; p < padding_per_row; ++p) {
                padded_weights.push_back(0);
            }
        }
        
        weights_data_ptr = padded_weights.data();
        weights_count_to_send = padded_weights.size();
    }

    // Update RTP port with element count.
    // The tool validates (element_count * sizeof(T)) == port_size_bytes.
    g.update(g.embed_matrixA0_rtp, weights_data_ptr, weights_count_to_send);


    const auto embed_inputs = load_vector_from_datadir<DATA_TYPE>(EMBED_INPUT_DATA, 0U);
    if (embed_inputs.empty()) {
        std::cerr << "Error: embed input data is empty" << std::endl;
        return -1;
    }
    if ((embed_inputs.size() % EMBED_INPUT_VECTOR_LENGTH) != 0U) {
        std::cerr << "Error: embed input size (" << embed_inputs.size()
                  << ") is not a multiple of " << EMBED_INPUT_VECTOR_LENGTH << std::endl;
        return -1;
    }
    const auto run_count = static_cast<std::size_t>(embed_inputs.size() / EMBED_INPUT_VECTOR_LENGTH);
    if (run_count == 0U) {
        std::cerr << "Error: run_count evaluated to zero" << std::endl;
        return -1;
    }
    if (run_count > static_cast<std::size_t>(std::numeric_limits<int>::max())) {
        std::cerr << "Error: run_count exceeds supported iteration range" << std::endl;
        return -1;
    }

    // --- Input Padding Logic for Int16 ---
    // Use the same GRAPH_INPUT_SIZE logic to pad inputs
    
    std::vector<DATA_TYPE> padded_inputs;
    const DATA_TYPE* data_ptr_to_send = nullptr;
    std::size_t elements_per_transaction = EMBED_INPUT_VECTOR_LENGTH; // Default logical

    if (GRAPH_INPUT_SIZE > EMBED_INPUT_VECTOR_LENGTH) {
        size_t padding_elements = GRAPH_INPUT_SIZE - EMBED_INPUT_VECTOR_LENGTH;
        
        elements_per_transaction = GRAPH_INPUT_SIZE;
        padded_inputs.reserve(run_count * elements_per_transaction);
        
        for (size_t i = 0; i < run_count; ++i) {
            size_t start_idx = i * EMBED_INPUT_VECTOR_LENGTH;
            for (size_t j = 0; j < EMBED_INPUT_VECTOR_LENGTH; ++j) {
                padded_inputs.push_back(embed_inputs[start_idx + j]);
            }
            for (size_t p = 0; p < padding_elements; ++p) {
                padded_inputs.push_back(0);
            }
        }
        
        data_ptr_to_send = padded_inputs.data();
    } else {
        data_ptr_to_send = embed_inputs.data();
    }

    const std::size_t total_input_elements_sent = run_count * elements_per_transaction;
    
    // -------------------------------------

    const std::size_t total_output_elements = run_count * OUTPUT_VECTOR_LENGTH;
    
    // GMIO transactions use bytes
    const std::size_t input_transaction_bytes = total_input_elements_sent * sizeof(DATA_TYPE);
    const std::size_t output_transaction_bytes = total_output_elements * sizeof(DATA_TYPE);
    
    // Allocate buffers using DATA_TYPE
    DATA_TYPE* gmio_input_buffer = static_cast<DATA_TYPE*>(adf::GMIO::malloc(input_transaction_bytes));
    DATA_TYPE* gmio_output_buffer = static_cast<DATA_TYPE*>(adf::GMIO::malloc(output_transaction_bytes));

    if (gmio_input_buffer == nullptr || gmio_output_buffer == nullptr) {
        std::cerr << "Error: GMIO::malloc failed" << std::endl;
        if (gmio_input_buffer != nullptr) {
            adf::GMIO::free(gmio_input_buffer);
        }
        if (gmio_output_buffer != nullptr) {
            adf::GMIO::free(gmio_output_buffer);
        }
        g.end();
        return -1;
    }

    std::memcpy(gmio_input_buffer, data_ptr_to_send, input_transaction_bytes);

    const auto gm2aie_status = g.embed_input_gmio.gm2aie_nb(gmio_input_buffer, input_transaction_bytes);
    const auto aie2gm_status = g.embed_output_gmio.aie2gm_nb(gmio_output_buffer, output_transaction_bytes);

    if (gm2aie_status != adf::return_code::ok || aie2gm_status != adf::return_code::ok) {
        std::cerr << "Error: GMIO transaction setup failed" << std::endl;
        adf::GMIO::free(gmio_input_buffer);
        adf::GMIO::free(gmio_output_buffer);
        g.end();
        return -1;
    }

    g.run(static_cast<int>(run_count));
    g.wait();
    g.embed_input_gmio.wait();
    g.embed_output_gmio.wait();

    const bool write_status = write_vector_to_datadir<DATA_TYPE>(AIEML10_OUTPUT_FILE, gmio_output_buffer, total_output_elements);

    adf::GMIO::free(gmio_input_buffer);
    adf::GMIO::free(gmio_output_buffer);

    g.end();
    
    return 0;

}