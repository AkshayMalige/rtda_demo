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

    constexpr std::size_t EMBED_INPUT_VECTOR_LENGTH = static_cast<std::size_t>(INPUT_SIZE);
    // solver0_dense0 output is HIDDEN_SIZE (Rows=128)
    constexpr std::size_t OUTPUT_VECTOR_LENGTH = static_cast<std::size_t>(HIDDEN_SIZE);

} // namespace

int main() {

    g.init();

    const std::string basePath = std::string(DATA_DIR) + "/";

    // =========================================================================
    // Reusable helper lambdas (adapted from rtda_demo)
    // =========================================================================

    // Load a text file of DATA_TYPE values
    auto load_vector = [&](const std::string& relative_path, std::size_t expected_count) {
        return load_values<DATA_TYPE>(basePath + relative_path, expected_count);
    };

    // Write DATA_TYPE values to a text file
    auto write_output = [&](const std::string& relative_path,
                            const DATA_TYPE* values,
                            std::size_t count) -> bool {
        return write_vector<DATA_TYPE>(basePath + relative_path, values, count);
    };

    // Load values and update one or more RTP ports
    auto load_and_update_ports = [&](const std::string& relative_path,
                                     std::size_t expected_count,
                                     std::initializer_list<adf::input_port*> ports) -> bool {
        const auto values = load_vector(relative_path, expected_count);
        if (values.empty()) {
            return false;
        }
        for (auto* port : ports) {
            g.update(*port, values.data(), expected_count);
        }
        return true;
    };

    // Load partitioned weight files (prefix0.txt, prefix1.txt, ...) into a port array
    auto load_and_update_matrix_parts = [&](const std::string& prefix,
                                            std::size_t part_count,
                                            std::size_t expected_count_per_part,
                                            auto& port_array) -> bool {
        for (std::size_t part = 0; part < part_count; ++part) {
            const auto path = prefix + std::to_string(part) + ".txt";
            if (!load_and_update_ports(path,
                                       expected_count_per_part,
                                       {&port_array[part]})) {
                return false;
            }
        }
        return true;
    };

    // =========================================================================
    // 1. Embed weights & biases
    // =========================================================================

    // 1.0 Dense0 weights (with padding for int16 alignment)
    {
        auto weights = load_vector(EMBED_DENSE0_WEIGHTS,
                                   static_cast<std::size_t>(EMBED_DENSE0_WEIGHTS_TOTAL));
        if (weights.empty()) {
            std::cerr << "Error: Failed to load " << EMBED_DENSE0_WEIGHTS << std::endl;
            return -1;
        }

        std::vector<DATA_TYPE> padded_weights;
        const DATA_TYPE* weights_ptr = weights.data();
        std::size_t weights_count = weights.size();

        // int16 requires GRAPH_INPUT_SIZE (16) > INPUT_SIZE (8) -> pad each row
        if (GRAPH_INPUT_SIZE > INPUT_SIZE) {
            padded_weights = pad_matrix_rows(weights,
                                             static_cast<std::size_t>(HIDDEN_SIZE),
                                             static_cast<std::size_t>(INPUT_SIZE),
                                             static_cast<std::size_t>(GRAPH_INPUT_SIZE));
            weights_ptr = padded_weights.data();
            weights_count = padded_weights.size();
        }

        g.update(g.embed_matrixA0_rtp, weights_ptr, weights_count);
    }

    // 1.1 Dense0 bias
    if (!load_and_update_ports(EMBED_DENSE0_BIAS,
                               EMBED_DENSE0_BIAS_SIZE,
                               {&g.embed_bias0_rtp})) {
        return -1;
    }

    // 1.2 Dense1 weights (2 cascade parts)
    {
        adf::input_port* dense1_ports[] = {&g.embed_matrixA1_0_rtp, &g.embed_matrixA1_1_rtp};
        for (std::size_t i = 0; i < static_cast<std::size_t>(EMBED_DENSE1_CASC_LEN); ++i) {
            const auto path = std::string(EMBED_DENSE1_WEIGHTS_PREFIX) + std::to_string(i) + ".txt";
            if (!load_and_update_ports(path,
                                       EMBED_DENSE1_WEIGHTS_PER_PART,
                                       {dense1_ports[i]})) {
                return -1;
            }
        }
    }

    // 1.3 Dense1 bias
    if (!load_and_update_ports(EMBED_DENSE1_BIAS,
                               EMBED_DENSE1_BIAS_SIZE,
                               {&g.embed_bias1_rtp})) {
        return -1;
    }

    // =========================================================================
    // 2. Solver0 dense0 weights (4 cascade parts)
    // =========================================================================
    if (!load_and_update_matrix_parts(SUBSOLVER0_DENSE0_WEIGHTS_PREFIX,
                                      static_cast<std::size_t>(SUBSOLVER0_INPUT_PARTS),
                                      static_cast<std::size_t>(SOLVER_DENSE0_WEIGHTS_PER_PART),
                                      g.solver0_dense0_matrixA_rtp)) {
        return -1;
    }

    // =========================================================================
    // 3. Load input data & run
    // =========================================================================
    const auto embed_inputs = load_vector(EMBED_INPUT_DATA, 0U);
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

    // Pad inputs if needed (int16 alignment: 8 -> 16)
    std::vector<DATA_TYPE> padded_inputs;
    const DATA_TYPE* inputs_ptr = embed_inputs.data();
    std::size_t total_input_elements = embed_inputs.size();

    if (GRAPH_INPUT_SIZE > EMBED_INPUT_VECTOR_LENGTH) {
        padded_inputs = pad_transaction_stream(embed_inputs, EMBED_INPUT_VECTOR_LENGTH, GRAPH_INPUT_SIZE);
        inputs_ptr = padded_inputs.data();
        total_input_elements = padded_inputs.size();
    }

    // GMIO transactions
    const std::size_t total_output_elements = run_count * OUTPUT_VECTOR_LENGTH;
    const std::size_t input_transaction_bytes = total_input_elements * sizeof(DATA_TYPE);
    const std::size_t output_transaction_bytes = total_output_elements * sizeof(DATA_TYPE);

    DATA_TYPE* gmio_in  = static_cast<DATA_TYPE*>(adf::GMIO::malloc(input_transaction_bytes));
    DATA_TYPE* gmio_out = static_cast<DATA_TYPE*>(adf::GMIO::malloc(output_transaction_bytes));

    if (gmio_in == nullptr || gmio_out == nullptr) {
        std::cerr << "Error: GMIO::malloc failed" << std::endl;
        if (gmio_in  != nullptr) adf::GMIO::free(gmio_in);
        if (gmio_out != nullptr) adf::GMIO::free(gmio_out);
        g.end();
        return -1;
    }

    std::memcpy(gmio_in, inputs_ptr, input_transaction_bytes);

    const auto gm2aie_status = g.embed_input_gmio.gm2aie_nb(gmio_in, input_transaction_bytes);
    const auto aie2gm_status = g.embed_output_gmio.aie2gm_nb(gmio_out, output_transaction_bytes);

    if (gm2aie_status != adf::return_code::ok || aie2gm_status != adf::return_code::ok) {
        std::cerr << "Error: GMIO transaction setup failed" << std::endl;
        adf::GMIO::free(gmio_in);
        adf::GMIO::free(gmio_out);
        g.end();
        return -1;
    }

    g.run(static_cast<int>(run_count));
    g.wait();
    g.embed_input_gmio.wait();
    g.embed_output_gmio.wait();

    write_output(AIEML10_OUTPUT_FILE, gmio_out, total_output_elements);

    adf::GMIO::free(gmio_in);
    adf::GMIO::free(gmio_out);

    g.end();

    return 0;

}
