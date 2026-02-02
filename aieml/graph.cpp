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
#include <algorithm>

NeuralNetworkGraph g;

// #if defined(__AIESIM__) || defined(__X86SIM__)

namespace {

    constexpr std::size_t EMBED_DENSE0_WEIGHTS_COUNT = static_cast<std::size_t>(EMBED_DENSE0_WEIGHTS_TOTAL);
    constexpr std::size_t EMBED_INPUT_VECTOR_LENGTH = static_cast<std::size_t>(INPUT_SIZE);
    constexpr std::size_t OUTPUT_VECTOR_LENGTH = static_cast<std::size_t>(HIDDEN_SIZE);


} // namespace

int main() {

    g.init();

    // 1. Load and Pad Weights
    auto weights = load_vector_from_datadir<DATA_TYPE>(EMBED_DENSE0_WEIGHTS, EMBED_DENSE0_WEIGHTS_COUNT);
    if (weights.empty()) {
        std::cerr << "Error: Failed to load weights from " << EMBED_DENSE0_WEIGHTS << std::endl;
        return -1;
    }

    std::vector<DATA_TYPE> padded_weights;
    const DATA_TYPE* weights_data_ptr = weights.data();
    size_t weights_count_to_send = weights.size();

    // If GRAPH_INPUT_SIZE (16 for int16) > INPUT_SIZE (e.g. 8), we pad the weights matrix.
    // Rows = HIDDEN_SIZE, Cols = INPUT_SIZE -> Padded to GRAPH_INPUT_SIZE
    if (GRAPH_INPUT_SIZE > EMBED_INPUT_VECTOR_LENGTH) {
        padded_weights = pad_matrix_rows(weights, OUTPUT_VECTOR_LENGTH, EMBED_INPUT_VECTOR_LENGTH, GRAPH_INPUT_SIZE);
        weights_data_ptr = padded_weights.data();
        weights_count_to_send = padded_weights.size();
    }

    // Update RTP port with element count (tool multiplies by sizeof(T))
    g.update(g.embed_matrixA0_rtp, weights_data_ptr, weights_count_to_send);


    // 1.1 Load Bias
    auto bias_data = load_vector_from_datadir<DATA_TYPE>(EMBED_DENSE0_BIAS, HIDDEN_SIZE);
    if (bias_data.empty()) {
        std::cerr << "Error: Failed to load bias from " << EMBED_DENSE0_BIAS << std::endl;
        return -1;
    }
    
    // Update Bias RTP
    g.update(g.embed_bias0_rtp, bias_data.data(), HIDDEN_SIZE);


    // 2. Load Inputs
    const auto embed_inputs = load_vector_from_datadir<DATA_TYPE>(EMBED_INPUT_DATA, 0U);
    if (embed_inputs.empty()) {
        std::cerr << "Error: embed input data is empty" << std::endl;
        return -1;
    }
    
    // Validate input dimensions
    if ((embed_inputs.size() % EMBED_INPUT_VECTOR_LENGTH) != 0U) {
        std::cerr << "Error: embed input size (" << embed_inputs.size()
                  << ") is not a multiple of " << EMBED_INPUT_VECTOR_LENGTH << std::endl;
        return -1;
    }
    const auto run_count = static_cast<std::size_t>(embed_inputs.size() / EMBED_INPUT_VECTOR_LENGTH);
    
    
    // 3. Pad Inputs if Necessary
    std::vector<DATA_TYPE> padded_inputs;
    const DATA_TYPE* inputs_data_ptr = embed_inputs.data();
    size_t total_elements_to_send = embed_inputs.size();

    if (GRAPH_INPUT_SIZE > EMBED_INPUT_VECTOR_LENGTH) {
        padded_inputs = pad_transaction_stream(embed_inputs, EMBED_INPUT_VECTOR_LENGTH, GRAPH_INPUT_SIZE);
        inputs_data_ptr = padded_inputs.data();
        total_elements_to_send = padded_inputs.size();
    }

    
    // 4. Prepare GMIO Transactions
    const std::size_t total_output_elements = run_count * OUTPUT_VECTOR_LENGTH;
    const std::size_t input_transaction_bytes = total_elements_to_send * sizeof(DATA_TYPE);
    const std::size_t output_transaction_bytes = total_output_elements * sizeof(DATA_TYPE);
    
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

    std::memcpy(gmio_input_buffer, inputs_data_ptr, input_transaction_bytes);

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
