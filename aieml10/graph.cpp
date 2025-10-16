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
constexpr std::size_t EMBED_DENSE1_PART_COUNT = static_cast<std::size_t>(EMBED_DENSE1_CASC_LEN);
constexpr std::size_t EMBED_DENSE1_WEIGHTS_PER_PART_HOST =
    static_cast<std::size_t>(EMBED_DENSE1_WEIGHTS_PER_PART);

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

        if (values.size() != expected_count) {
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
    auto load_and_send_vault = [&](input_gmio& gmio_port,
                                   const std::vector<std::pair<std::string, std::size_t>>& segments,
                                   const std::string& context) -> bool {
        std::size_t total_expected = 0;
        for (const auto& segment : segments) {
            total_expected += segment.second;
        }
        std::vector<float> combined;
        combined.reserve(total_expected);
        for (const auto& [relative_path, expected_count] : segments) {
            const auto values = load_vector(relative_path, expected_count);
            if (values.size() != expected_count) {
                return false;
            }
            combined.insert(combined.end(), values.begin(), values.end());
        }
        return send_vector_via_gmio(combined, gmio_port, context);
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
    auto make_solver_segments = [&](const char* dense0_prefix,
                                    const char* dense1_prefix,
                                    const char* dense2_prefix,
                                    const char* dense3_prefix) {
        std::vector<std::pair<std::string, std::size_t>> segments;
        segments.reserve(SOLVER_DENSE0_PART_COUNT + 3 * SOLVER_DENSEX_PART_COUNT);
        for (std::size_t part = 0; part < SOLVER_DENSE0_PART_COUNT; ++part) {
            segments.emplace_back(std::string(dense0_prefix) + std::to_string(part) + ".txt",
                                  SOLVER_DENSE0_WEIGHTS_PER_PART_HOST);
        }
        for (std::size_t part = 0; part < SOLVER_DENSEX_PART_COUNT; ++part) {
            segments.emplace_back(std::string(dense1_prefix) + std::to_string(part) + ".txt",
                                  SOLVER_DENSEX_WEIGHTS_PER_PART_HOST);
        }
        for (std::size_t part = 0; part < SOLVER_DENSEX_PART_COUNT; ++part) {
            segments.emplace_back(std::string(dense2_prefix) + std::to_string(part) + ".txt",
                                  SOLVER_DENSEX_WEIGHTS_PER_PART_HOST);
        }
        for (std::size_t part = 0; part < SOLVER_DENSEX_PART_COUNT; ++part) {
            segments.emplace_back(std::string(dense3_prefix) + std::to_string(part) + ".txt",
                                  SOLVER_DENSEX_WEIGHTS_PER_PART_HOST);
        }
        return segments;
    };

    // Weight preload via GMIO ------------------------------------------------

    std::vector<std::pair<std::string, std::size_t>> embed_segments;
    embed_segments.reserve(EMBED_DENSE1_PART_COUNT + 1);
    embed_segments.emplace_back(EMBED_DENSE0_WEIGHTS, EMBED_DENSE0_WEIGHTS_COUNT);
    for (std::size_t part = 0; part < EMBED_DENSE1_PART_COUNT; ++part) {
        embed_segments.emplace_back(EMBED_DENSE1_WEIGHTS_PREFIX + std::to_string(part) + ".txt",
                                    EMBED_DENSE1_WEIGHTS_PER_PART_HOST);
    }
    if (!load_and_send_vault(g.embed_weights_gmio, embed_segments, "embed_weights_vault")) {
        return -1;
    }
    const auto solver0_segments = make_solver_segments(
        SUBSOLVER0_DENSE0_WEIGHTS_PREFIX,
        SUBSOLVER0_DENSE1_WEIGHTS_PREFIX,
        SUBSOLVER0_DENSE2_WEIGHTS_PREFIX,
        SUBSOLVER0_DENSE3_WEIGHTS_PREFIX);
    if (!load_and_send_vault(g.solver0_weights_gmio, solver0_segments, "solver0_weights_vault")) {
        return -1;
    }
    const auto solver1_segments = make_solver_segments(
        SUBSOLVER1_DENSE0_WEIGHTS_PREFIX,
        SUBSOLVER1_DENSE1_WEIGHTS_PREFIX,
        SUBSOLVER1_DENSE2_WEIGHTS_PREFIX,
        SUBSOLVER1_DENSE3_WEIGHTS_PREFIX);
    if (!load_and_send_vault(g.solver1_weights_gmio, solver1_segments, "solver1_weights_vault")) {
        return -1;
    }
    const auto solver2_segments = make_solver_segments(
        SUBSOLVER2_DENSE0_WEIGHTS_PREFIX,
        SUBSOLVER2_DENSE1_WEIGHTS_PREFIX,
        SUBSOLVER2_DENSE2_WEIGHTS_PREFIX,
        SUBSOLVER2_DENSE3_WEIGHTS_PREFIX);
    if (!load_and_send_vault(g.solver2_weights_gmio, solver2_segments, "solver2_weights_vault")) {
        return -1;
    }


    // // Embed bias updates ------------------------------------------------

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

    // // Solver0 bias updates ------------------------------------------------
   
    if (!load_and_update_ports(SUBSOLVER0_DENSE0_BIAS,
                               SUBSOLVER0_DENSE0_BIAS_SIZE,
                               {&g.solver0_bias0_rtp})) {
        return -1;
    }
    if (!load_and_update_ports(SUBSOLVER0_DENSE1_BIAS,
        SUBSOLVER0_DENSE1_BIAS_SIZE,
        {&g.solver0_bias1_rtp})) {
        return -1;
    }
    if (!load_and_update_ports(SUBSOLVER0_DENSE2_BIAS,
        SUBSOLVER0_DENSE2_BIAS_SIZE,
        {&g.solver0_bias2_rtp})) {
        return -1;
    }
    if (!load_and_update_ports(SUBSOLVER0_DENSE3_BIAS,
        SUBSOLVER0_DENSE3_BIAS_SIZE,
        {&g.solver0_bias3_rtp})) {
        return -1;
    }

    // // Solver1 bias updates ------------------------------------------------
    if (!load_and_update_ports(SUBSOLVER1_DENSE0_BIAS,
        SUBSOLVER0_DENSE0_BIAS_SIZE,
        {&g.solver1_bias0_rtp})) {
        return -1;
    }
    if (!load_and_update_ports(SUBSOLVER1_DENSE1_BIAS,
        SUBSOLVER0_DENSE1_BIAS_SIZE,
        {&g.solver1_bias1_rtp})) {
        return -1;
    }
    if (!load_and_update_ports(SUBSOLVER1_DENSE2_BIAS,
        SUBSOLVER0_DENSE2_BIAS_SIZE,
        {&g.solver1_bias2_rtp})) {
        return -1;
    }
    if (!load_and_update_ports(SUBSOLVER1_DENSE3_BIAS,
        SUBSOLVER0_DENSE3_BIAS_SIZE,
        {&g.solver1_bias3_rtp})) {
        return -1;
    }


    // // Solver2 bias updates ------------------------------------------------

    if (!load_and_update_ports(SUBSOLVER2_DENSE0_BIAS,
        SUBSOLVER0_DENSE0_BIAS_SIZE,
        {&g.solver2_bias0_rtp})) {
    return -1;
    }
    if (!load_and_update_ports(SUBSOLVER2_DENSE1_BIAS,
        SUBSOLVER0_DENSE1_BIAS_SIZE,
        {&g.solver2_bias1_rtp})) {
        return -1;
    }
    if (!load_and_update_ports(SUBSOLVER2_DENSE2_BIAS,
        SUBSOLVER0_DENSE2_BIAS_SIZE,
        {&g.solver2_bias2_rtp})) {
        return -1;
    }
    if (!load_and_update_ports(SUBSOLVER2_DENSE3_BIAS,
        SUBSOLVER0_DENSE3_BIAS_SIZE,
        {&g.solver2_bias3_rtp})) {
        return -1;
    }

// // // Output block updates ---------------------------------------------
    if (!load_and_update_ports(OUTPUT_DENSE0_WEIGHTS,
                               OUTPUT_DENSE0_WEIGHTS_SIZE,
                               {&g.output_matrixA_rtp})) {
        return -1;
    }

    g.run(1);
    g.wait();
    g.end();
    return 0;
}
#endif
