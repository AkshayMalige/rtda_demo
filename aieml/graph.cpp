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

    // CRITICAL FIX:
    // The RTP port in the single-kernel graph has a fixed buffer size of 8192 bytes.
    // The adf::graph::update() API for typed ports expects the size in ELEMENTS, not bytes.
    // The tool internally multiplies (elements * sizeof(type)) to verify against the port size.
    //
    // Port Capacity: 8192 bytes
    // Int16 Capacity: 8192 / 2 = 4096 elements
    // Float Capacity: 8192 / 4 = 2048 elements
    
    const size_t PORT_CAPACITY_BYTES = 8192;
    const size_t MAX_ELEMENTS = PORT_CAPACITY_BYTES / sizeof(DATA_TYPE);
    
    // We send the smaller of what we have vs what fits.
    // Ideally the graph should be resized to fit the model, but for "work as it was", we clip.
    const size_t elements_to_send = std::min(weights.size(), MAX_ELEMENTS);

    g.update(g.embed_matrixA0_rtp, weights.data(), elements_to_send);


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

    const std::size_t total_input_elements = run_count * EMBED_INPUT_VECTOR_LENGTH;
    const std::size_t total_output_elements = run_count * OUTPUT_VECTOR_LENGTH;
    
    // GMIO transactions use bytes, not elements.
    const std::size_t input_transaction_bytes = total_input_elements * sizeof(DATA_TYPE);
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

    std::memcpy(gmio_input_buffer, embed_inputs.data(), input_transaction_bytes);

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