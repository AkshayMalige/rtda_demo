#include "graph.h"
#include "data_paths.h"
#include "nn_defs10.h"
#include "utils.hpp"
#include <cstring>
#include <fstream>
#include <initializer_list>
#include <iomanip>
#include <iostream>
#include <limits>
#include <string>
#include <utility>
#include <vector>

NeuralNetworkGraph g;

// #if defined(__AIESIM__) || defined(__X86SIM__)

namespace {

    constexpr std::size_t EMBED_DENSE0_WEIGHTS_COUNT = static_cast<std::size_t>(EMBED_DENSE0_WEIGHTS_TOTAL);
    constexpr std::size_t EMBED_INPUT_VECTOR_LENGTH = static_cast<std::size_t>(INPUT_SIZE);
    constexpr std::size_t OUTPUT_VECTOR_LENGTH = static_cast<std::size_t>(HIDDEN_SIZE);


} // namespace

int main() {

    g.init();

    if (!load_and_update_ports_helper(g, EMBED_DENSE0_WEIGHTS,
        EMBED_DENSE0_WEIGHTS_COUNT,
        {&g.embed_matrixA0_rtp})) {
        return -1;
    }


    const auto embed_inputs = load_vector_from_datadir(EMBED_INPUT_DATA, 0U);
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
    const std::size_t input_transaction_bytes = total_input_elements * sizeof(float);
    const std::size_t output_transaction_bytes = total_output_elements * sizeof(float);
    float* gmio_input_buffer = static_cast<float*>(adf::GMIO::malloc(input_transaction_bytes));
    float* gmio_output_buffer = static_cast<float*>(adf::GMIO::malloc(output_transaction_bytes));

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

    const bool write_status = write_vector_to_datadir(AIEML10_OUTPUT_FILE, gmio_output_buffer, total_output_elements);

    adf::GMIO::free(gmio_input_buffer);
    adf::GMIO::free(gmio_output_buffer);

    g.end();
    
    return 0;

}
// #endif