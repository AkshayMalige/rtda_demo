#include "graph.h"
#include "data_paths.h"
#include "nn_defs10.h"
#include <fstream>
#include <initializer_list>
#include <iostream>
#include <string>
#include <vector>

NeuralNetworkGraph g;

#if defined(__AIESIM__) || defined(__X86SIM__)
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

    // Stage 1 weights and bias updates -----------------------------------
    // if (!load_and_update_ports(EMBED_DENSE0_WEIGHTS,
    //                            EMBED_DENSE0_WEIGHTS_SIZE,
    //                            {&g.embed_matrixA_rtp})) {
    //     return -1;
    // }

    if (!load_and_update_ports(EMBED_DENSE0_BIAS,
                               EMBED_DENSE0_BIAS_SIZE,
                               {&g.embed_bias0_rtp})) {
        return -1;
    }

    // for (int casc_idx = 0; casc_idx < EMBED_DENSE1_CASC_LEN; ++casc_idx) {
    //     const std::string relative_path =
    //         EMBED_DENSE1_WEIGHTS_PREFIX + std::to_string(casc_idx) + ".txt";
    //     const auto weights = load_vector(relative_path, EMBED_DENSE1_WEIGHTS_PART_SIZE);
    //     if (weights.empty()) {
    //         return -1;
    //     }
    //     g.update(g.embed_matrixA1_rtp[casc_idx], weights.data(), EMBED_DENSE1_WEIGHTS_PART_SIZE);
    // }

    if (!load_and_update_ports(EMBED_DENSE1_BIAS,
                               EMBED_DENSE1_BIAS_SIZE,
                               {&g.embed_bias1_rtp})) {
        return -1;
    }

    // // Stage 2 bias updates ------------------------------------------------
    if (!load_and_update_ports(SUBSOLVER0_DENSE0_BIAS,
                               SUBSOLVER0_DENSE0_BIAS_SIZE,
                               {&g.solver_bias0_rtp, &g.solver2_bias0_rtp, &g.solver3_bias0_rtp})) {
        return -1;
    }

    if (!load_and_update_ports(SUBSOLVER0_DENSE1_BIAS,
        SUBSOLVER0_DENSE1_BIAS_SIZE,
        {&g.solver_bias1_rtp, &g.solver2_bias1_rtp, &g.solver3_bias1_rtp})) {
        return -1;
    }

    if (!load_and_update_ports(SUBSOLVER0_DENSE2_BIAS,
        SUBSOLVER0_DENSE2_BIAS_SIZE,
        {&g.solver_bias2_rtp, &g.solver2_bias2_rtp, &g.solver3_bias2_rtp})) {
        return -1;
    }

    if (!load_and_update_ports(SUBSOLVER0_DENSE3_BIAS,
        SUBSOLVER0_DENSE3_BIAS_SIZE,
        {&g.solver_bias3_rtp, &g.solver2_bias3_rtp, &g.solver3_bias3_rtp})) {
        return -1;
    }

    // // Stage 3 weight updates ---------------------------------------------
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

