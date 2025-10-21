#include "graph.h"
#include "data_paths.h"
#include "nn_defs10.h"
#include <cstring>
#include <fstream>
#include <initializer_list>
#include <iostream>
#include <string>
#include <utility>
#include <vector>

NeuralNetworkGraph g;

#if defined(__AIESIM__) || defined(__X86SIM__)

namespace {

constexpr std::size_t EMBED_DENSE0_WEIGHTS_COUNT = static_cast<std::size_t>(EMBED_DENSE0_WEIGHTS_TOTAL);
constexpr std::size_t EMBED_DENSE1_WEIGHTS_PER_PART_HOST =
    static_cast<std::size_t>(EMBED_DENSE1_WEIGHTS_PER_PART);
constexpr std::size_t EMBED_INPUT_VECTOR_LENGTH = static_cast<std::size_t>(INPUT_SIZE);

constexpr std::size_t SOLVER_DENSE0_PART_COUNT = static_cast<std::size_t>(SUBSOLVER0_INPUT_PARTS);
constexpr std::size_t SOLVER_DENSE0_WEIGHTS_PER_PART_HOST =
    static_cast<std::size_t>(SOLVER_DENSE0_WEIGHTS_PER_PART);

constexpr std::size_t SOLVER_DENSEX_PART_COUNT = static_cast<std::size_t>(SUBSOLVER0_LAYER_WEIGHTS_PARTS);
constexpr std::size_t SOLVER_DENSEX_WEIGHTS_PER_PART_HOST =
    static_cast<std::size_t>(SOLVER_DENSEX_WEIGHTS_PER_PART);

} // namespace

int main() {
    auto load_values = [](const std::string& path, std::size_t expected_count) -> std::vector<float> {
        std::ifstream file(path);
        if (!file.is_open()) {
            std::cerr << "Error: Could not open file '" << path << "'" << std::endl;
            return {};
        }

        std::vector<float> values;
        values.reserve(expected_count);
        float value = 0.0f;
        while (file >> value) {
            values.push_back(value);
        }

        if (expected_count != 0U && values.size() != expected_count) {
            std::cerr << "Error: Expected " << expected_count << " values from '" << path
                      << "', got " << values.size() << std::endl;
            return {};
        }
        return values;
    };

    g.init();
    const std::string basePath = std::string(DATA_DIR) + "/";
    auto load_vector = [&](const std::string& relative_path, std::size_t expected_count) {
        return load_values(basePath + relative_path, expected_count);
    };
    auto send_vector_via_gmio = [&](const std::vector<float>& values,
                                    input_gmio& gmio_port,
                                    const std::string& context) -> bool {
        if (values.empty()) {
            std::cerr << "Error: No data available for '" << context << "'" << std::endl;
            return false;
        }
        const std::size_t transaction_bytes = values.size() * sizeof(float);
        float* gmio_buffer = static_cast<float*>(adf::GMIO::malloc(transaction_bytes));
        if (gmio_buffer == nullptr) {
            std::cerr << "Error: GMIO::malloc failed for '" << context << "'" << std::endl;
            return false;
        }
        std::memcpy(gmio_buffer, values.data(), transaction_bytes);
        const auto status = gmio_port.gm2aie(gmio_buffer, transaction_bytes);
        adf::GMIO::free(gmio_buffer);
        if (status != adf::return_code::ok) {
            std::cerr << "Error: gm2aie failed for '" << context << "'" << std::endl;
            return false;
        }
        return true;
    };
    auto load_and_update_ports = [&](const std::string& relative_path,
                                     std::size_t expected_count,
                                     std::initializer_list<input_port*> ports) -> bool {
        const auto values = load_vector(relative_path, expected_count);
        if (values.empty()) {
            return false;
        }
        for (auto* port : ports) {
            g.update(*port, values.data(), expected_count);
        }
        return true;
    };
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
    auto load_solver_weights = [&](const char* dense0_prefix,
                                   const char* dense1_prefix,
                                   const char* dense2_prefix,
                                   const char* dense3_prefix,
                                   auto& dense0_ports,
                                   auto& dense1_ports,
                                   auto& dense2_ports,
                                   auto& dense3_ports) -> bool {
        if (!load_and_update_matrix_parts(dense0_prefix,
                                          SOLVER_DENSE0_PART_COUNT,
                                          SOLVER_DENSE0_WEIGHTS_PER_PART_HOST,
                                          dense0_ports)) {
            return false;
        }
        if (!load_and_update_matrix_parts(dense1_prefix,
                                          SOLVER_DENSEX_PART_COUNT,
                                          SOLVER_DENSEX_WEIGHTS_PER_PART_HOST,
                                          dense1_ports)) {
            return false;
        }
        if (!load_and_update_matrix_parts(dense2_prefix,
                                          SOLVER_DENSEX_PART_COUNT,
                                          SOLVER_DENSEX_WEIGHTS_PER_PART_HOST,
                                          dense2_ports)) {
            return false;
        }
        if (!load_and_update_matrix_parts(dense3_prefix,
                                          SOLVER_DENSEX_PART_COUNT,
                                          SOLVER_DENSEX_WEIGHTS_PER_PART_HOST,
                                          dense3_ports)) {
            return false;
        }
        return true;
    };
    auto load_solver_biases = [&](const char* bias0_path,
                                  const char* bias1_path,
                                  const char* bias2_path,
                                  const char* bias3_path,
                                  input_port& bias0_port,
                                  input_port& bias1_port,
                                  input_port& bias2_port,
                                  input_port& bias3_port) -> bool {
        if (!load_and_update_ports(bias0_path,
                                   SUBSOLVER0_DENSE0_BIAS_SIZE,
                                   {&bias0_port})) {
            return false;
        }
        if (!load_and_update_ports(bias1_path,
                                   SUBSOLVER0_DENSE1_BIAS_SIZE,
                                   {&bias1_port})) {
            return false;
        }
        if (!load_and_update_ports(bias2_path,
                                   SUBSOLVER0_DENSE2_BIAS_SIZE,
                                   {&bias2_port})) {
            return false;
        }
        if (!load_and_update_ports(bias3_path,
                                   SUBSOLVER0_DENSE3_BIAS_SIZE,
                                   {&bias3_port})) {
            return false;
        }
        return true;
    };

    // Weight preload via RTP -------------------------------------------------

    if (!load_and_update_ports(EMBED_DENSE0_WEIGHTS,
                               EMBED_DENSE0_WEIGHTS_COUNT,
                               {&g.embed_matrixA0_rtp})) {
        return -1;
    }
    for (std::size_t part = 0; part < static_cast<std::size_t>(EMBED_DENSE1_CASC_LEN); ++part) {
        const auto path = EMBED_DENSE1_WEIGHTS_PREFIX + std::to_string(part) + ".txt";
        input_port* target_port = nullptr;
        if (part == 0U) {
            target_port = &g.embed_matrixA1_0_rtp;
        } else if (part == 1U) {
            target_port = &g.embed_matrixA1_1_rtp;
        } else {
            std::cerr << "Error: Unsupported embed_dense1 cascade index " << part << std::endl;
            return -1;
        }
        if (!load_and_update_ports(path,
                                   EMBED_DENSE1_WEIGHTS_PER_PART_HOST,
                                   {target_port})) {
            return -1;
        }
    }
    if (!load_and_update_ports(EMBED_DENSE0_BIAS,
                               EMBED_DENSE0_BIAS_SIZE,
                               {&g.embed_bias0_rtp})) {
        return -1;
    }
    if (!load_and_update_ports(EMBED_DENSE1_BIAS,
                               EMBED_DENSE1_BIAS_SIZE,
                               {&g.embed_bias1_rtp})) {
        return -1;
    }

    if (!load_solver_weights(SUBSOLVER0_DENSE0_WEIGHTS_PREFIX,
                             SUBSOLVER0_DENSE1_WEIGHTS_PREFIX,
                             SUBSOLVER0_DENSE2_WEIGHTS_PREFIX,
                             SUBSOLVER0_DENSE3_WEIGHTS_PREFIX,
                             g.solver0_dense0_matrixA_rtp,
                             g.solver0_dense1_matrixA_rtp,
                             g.solver0_dense2_matrixA_rtp,
                             g.solver0_dense3_matrixA_rtp)) {
        return -1;
    }
    if (!load_solver_weights(SUBSOLVER1_DENSE0_WEIGHTS_PREFIX,
                             SUBSOLVER1_DENSE1_WEIGHTS_PREFIX,
                             SUBSOLVER1_DENSE2_WEIGHTS_PREFIX,
                             SUBSOLVER1_DENSE3_WEIGHTS_PREFIX,
                             g.solver1_dense0_matrixA_rtp,
                             g.solver1_dense1_matrixA_rtp,
                             g.solver1_dense2_matrixA_rtp,
                             g.solver1_dense3_matrixA_rtp)) {
        return -1;
    }
    if (!load_solver_weights(SUBSOLVER2_DENSE0_WEIGHTS_PREFIX,
                             SUBSOLVER2_DENSE1_WEIGHTS_PREFIX,
                             SUBSOLVER2_DENSE2_WEIGHTS_PREFIX,
                             SUBSOLVER2_DENSE3_WEIGHTS_PREFIX,
                             g.solver2_dense0_matrixA_rtp,
                             g.solver2_dense1_matrixA_rtp,
                             g.solver2_dense2_matrixA_rtp,
                             g.solver2_dense3_matrixA_rtp)) {
        return -1;
    }

    // // Solver0 bias updates ------------------------------------------------
   
    if (!load_solver_biases(SUBSOLVER0_DENSE0_BIAS,
                            SUBSOLVER0_DENSE1_BIAS,
                            SUBSOLVER0_DENSE2_BIAS,
                            SUBSOLVER0_DENSE3_BIAS,
                            g.solver0_bias0_rtp,
                            g.solver0_bias1_rtp,
                            g.solver0_bias2_rtp,
                            g.solver0_bias3_rtp)) {
        return -1;
    }
    if (!load_solver_biases(SUBSOLVER1_DENSE0_BIAS,
                            SUBSOLVER1_DENSE1_BIAS,
                            SUBSOLVER1_DENSE2_BIAS,
                            SUBSOLVER1_DENSE3_BIAS,
                            g.solver1_bias0_rtp,
                            g.solver1_bias1_rtp,
                            g.solver1_bias2_rtp,
                            g.solver1_bias3_rtp)) {
        return -1;
    }
    if (!load_solver_biases(SUBSOLVER2_DENSE0_BIAS,
                            SUBSOLVER2_DENSE1_BIAS,
                            SUBSOLVER2_DENSE2_BIAS,
                            SUBSOLVER2_DENSE3_BIAS,
                            g.solver2_bias0_rtp,
                            g.solver2_bias1_rtp,
                            g.solver2_bias2_rtp,
                            g.solver2_bias3_rtp)) {
        return -1;
    }

// // // Output block updates ---------------------------------------------
    if (!load_and_update_ports(OUTPUT_DENSE0_WEIGHTS,
                               OUTPUT_DENSE0_WEIGHTS_SIZE,
                               {&g.output_matrixA_rtp})) {
        return -1;
    }

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
    if (run_count == 0U) {
        std::cerr << "Error: run_count evaluated to zero" << std::endl;
        return -1;
    }
    if (!send_vector_via_gmio(embed_inputs, g.embed_input_gmio, "embed_input")) {
        return -1;
    }

    g.run(static_cast<int>(run_count));
    g.wait();
    g.end();
    return 0;
}
#endif
