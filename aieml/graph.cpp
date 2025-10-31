// Host app for AIE-only graph (no PL kernels)
// - Loads weights/biases via RTP (xrt::graph::update)
// - Moves activations via GMIO using xrt::aie::bo async()

#include <iostream>
#include <fstream>
#include <string>
#include <stdexcept>
#include <cstdlib>
#include <limits>
#include <iomanip>
#include <cstring>
#include <vector>

#include "xrt/xrt_device.h"
#include "xrt/xrt_graph.h"
#include "xrt/xrt_aie.h"

#include "data_paths.h"
#include "nn_defs10.h"

// Utility: read floats from file into provided array
static void read_floats_array(const std::string& path, float* arr, std::size_t expected_count) {
    std::ifstream file(path);
    if (!file.is_open()) {
        throw std::runtime_error("Could not open file: " + path);
    }
    for (std::size_t i = 0; i < expected_count; ++i) {
        if (!(file >> arr[i])) {
            throw std::runtime_error("File too short or invalid format: " + path);
        }
    }
}

// Utility: join paths
static std::string join(const std::string& base, const std::string& rel) {
    if (base.empty()) return rel;
    if (!base.empty() && base.back() == '/') return base + rel;
    return base + "/" + rel;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cout << "Usage: " << argv[0] << " <a.xclbin>\n";
        return 1;
    }
    const std::string xclbin_path = argv[1];

    // Resolve data base dir
    const char* dd_env = std::getenv("DATA_DIR");
    const std::string data_base = dd_env ? dd_env : "../data";

    try {
        // Open device and xclbin
        xrt::device device(0);
        auto uuid = device.load_xclbin(xclbin_path);
        xrt::graph graph(device, uuid, "g");

        // ---------------- RTP preload via arrays ----------------
        {
            // embed_dense0 weights
            static float emb_w0[HIDDEN_SIZE * INPUT_SIZE];
            read_floats_array(join(data_base, EMBED_DENSE0_WEIGHTS), emb_w0, HIDDEN_SIZE * INPUT_SIZE);
            graph.update("g.embed_matrixA0_rtp", emb_w0);

            // embed_dense1 weights (2 cascades)
            static float emb_w1_p0[OUTPUT_SIZE * HIDDEN_SIZE / EMBED_DENSE1_CASC_LEN];
            static float emb_w1_p1[OUTPUT_SIZE * HIDDEN_SIZE / EMBED_DENSE1_CASC_LEN];
            read_floats_array(join(data_base, std::string(EMBED_DENSE1_WEIGHTS_PREFIX) + "0.txt"), emb_w1_p0,
                              OUTPUT_SIZE * HIDDEN_SIZE / EMBED_DENSE1_CASC_LEN);
            read_floats_array(join(data_base, std::string(EMBED_DENSE1_WEIGHTS_PREFIX) + "1.txt"), emb_w1_p1,
                              OUTPUT_SIZE * HIDDEN_SIZE / EMBED_DENSE1_CASC_LEN);
            graph.update("g.embed_matrixA1_0_rtp", emb_w1_p0);
            graph.update("g.embed_matrixA1_1_rtp", emb_w1_p1);

            // embed biases
            static float emb_b0[EMBED_DENSE0_BIAS_SIZE];
            static float emb_b1[EMBED_DENSE1_BIAS_SIZE];
            read_floats_array(join(data_base, EMBED_DENSE0_BIAS), emb_b0, EMBED_DENSE0_BIAS_SIZE);
            read_floats_array(join(data_base, EMBED_DENSE1_BIAS), emb_b1, EMBED_DENSE1_BIAS_SIZE);
            graph.update("g.embed_bias0_rtp", emb_b0);
            graph.update("g.embed_bias1_rtp", emb_b1);
        }

        // ---------------- GMIO transfers and execution ----------------
        std::ifstream ifs(join(data_base, EMBED_INPUT_DATA));
        if (!ifs.is_open())
            throw std::runtime_error("Failed to open input data file");

        std::vector<float> inputs;
        float val = 0.0f;
        while (ifs >> val) inputs.push_back(val);
        if (inputs.empty() || (inputs.size() % static_cast<std::size_t>(INPUT_SIZE)) != 0U) {
            throw std::runtime_error("Input file size must be a non-zero multiple of INPUT_SIZE");
        }

        const std::size_t run_count = inputs.size() / static_cast<std::size_t>(INPUT_SIZE);
        const std::size_t out_elems = run_count * static_cast<std::size_t>(HIDDEN_SIZE);
        const std::size_t in_bytes = inputs.size() * sizeof(float);
        const std::size_t out_bytes = out_elems * sizeof(float);

        auto in_bo  = xrt::aie::bo(device, in_bytes, xrt::bo::flags::normal, 0);
        auto out_bo = xrt::aie::bo(device, out_bytes, xrt::bo::flags::normal, 0);
        auto in_ptr  = in_bo.map<float*>();
        auto out_ptr = out_bo.map<float*>();
        std::memcpy(in_ptr, inputs.data(), in_bytes);

        in_bo.async("g.embed_input_gmio", XCL_BO_SYNC_BO_GMIO_TO_AIE, in_bytes, 0);
        graph.run(static_cast<int>(run_count));
        auto out_run = out_bo.async("g.embed_output_gmio", XCL_BO_SYNC_BO_AIE_TO_GMIO, out_bytes, 0);
        out_run.wait();
        graph.end();

        const std::string out_path = join(data_base, AIEML10_OUTPUT_FILE);
        std::ofstream ofs(out_path);
        ofs << std::setprecision(std::numeric_limits<float>::max_digits10);
        for (std::size_t i = 0; i < out_elems; ++i) {
            ofs << out_ptr[i] << '\n';
        }
        std::cout << "Wrote " << out_elems << " floats to " << out_path << "\n";
    } catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return 1;
    }
    return 0;
}
