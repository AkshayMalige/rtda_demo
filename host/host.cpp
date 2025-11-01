#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <stdexcept>
#include <cstdlib>
#include <limits>
#include <iomanip>
#include <cstring>
#include <array>
#include <algorithm>

#include "xrt/xrt_device.h"
#include "xrt/xrt_graph.h"
#include "xrt/xrt_aie.h"

#include "data_paths.h"
#include "nn_defs10.h"

// -----------------------------------------------------------------------------
// Helper to load text file into vector<float>
// -----------------------------------------------------------------------------
static std::vector<float> read_floats(const std::string& path, std::size_t expected_count)
{
    std::ifstream file(path);
    if (!file.is_open())
        throw std::runtime_error("Could not open file: " + path);

    std::vector<float> values;
    values.reserve(expected_count ? expected_count : 1024);

    float v;
    while (file >> v)
        values.push_back(v);

    if (expected_count && values.size() != expected_count)
        throw std::runtime_error("File " + path + " has " + std::to_string(values.size()) +
                                 " elements, expected " + std::to_string(expected_count));
    return values;
}

template<std::size_t N>
static std::array<float, N> read_floats_array(const std::string& path)
{
    auto values = read_floats(path, N);
    std::array<float, N> result{};
    std::copy(values.begin(), values.end(), result.begin());
    return result;
}

static std::string join(const std::string& base, const std::string& rel)
{
    if (base.empty()) return rel;
    return base.back() == '/' ? base + rel : base + "/" + rel;
}

static_assert(SUBSOLVER0_INPUT_SIZE % SUBSOLVER0_INPUT_PARTS == 0,
              "SUBSOLVER0_INPUT_PARTS must divide SUBSOLVER0_INPUT_SIZE");
static_assert(HIDDEN_SIZE % SUBSOLVER0_LAYER_WEIGHTS_PARTS == 0,
              "SUBSOLVER0_LAYER_WEIGHTS_PARTS must divide HIDDEN_SIZE");
static_assert((static_cast<std::size_t>(OUTPUT_SIZE) * HIDDEN_SIZE) % EMBED_DENSE1_CASC_LEN == 0,
              "EMBED_DENSE1_CASC_LEN must divide OUTPUT_SIZE * HIDDEN_SIZE");

constexpr std::size_t EMBED_DENSE0_WEIGHTS_SIZE = static_cast<std::size_t>(HIDDEN_SIZE) * INPUT_SIZE;
constexpr std::size_t EMBED_DENSE1_PART_SIZE =
    (static_cast<std::size_t>(OUTPUT_SIZE) * HIDDEN_SIZE) / EMBED_DENSE1_CASC_LEN;
constexpr std::size_t SOLVER_DENSE0_PART_SIZE =
    static_cast<std::size_t>(HIDDEN_SIZE) * (SUBSOLVER0_INPUT_SIZE / SUBSOLVER0_INPUT_PARTS);
constexpr std::size_t SOLVER_DENSEx_PART_SIZE =
    static_cast<std::size_t>(OUTPUT_SIZE) * (HIDDEN_SIZE / SUBSOLVER0_LAYER_WEIGHTS_PARTS);

// -----------------------------------------------------------------------------
// main()
// -----------------------------------------------------------------------------
int main(int argc, char** argv)
{
    if (argc < 2) {
        std::cout << "Usage: " << argv[0] << " <a.xclbin>\n";
        return 1;
    }

    const std::string xclbin_path = argv[1];
    const std::string data_base = std::getenv("DATA_DIR") ? std::getenv("DATA_DIR") : "./data";

    try {
        xrt::device device(0);
        auto uuid = device.load_xclbin(xclbin_path);
        xrt::graph graph(device, uuid, "g");

        // ---------------- Embed weights / biases ----------------
        {
            auto w0 = read_floats_array<EMBED_DENSE0_WEIGHTS_SIZE>(
                join(data_base, EMBED_DENSE0_WEIGHTS));
            graph.update("g.embed_matrixA0_rtp", w0);

            auto w1_p0 = read_floats_array<EMBED_DENSE1_PART_SIZE>(
                join(data_base, std::string(EMBED_DENSE1_WEIGHTS_PREFIX) + "0.txt"));
            auto w1_p1 = read_floats_array<EMBED_DENSE1_PART_SIZE>(
                join(data_base, std::string(EMBED_DENSE1_WEIGHTS_PREFIX) + "1.txt"));
            graph.update("g.embed_matrixA1_0_rtp", w1_p0);
            graph.update("g.embed_matrixA1_1_rtp", w1_p1);

            auto b0 = read_floats_array<static_cast<std::size_t>(EMBED_DENSE0_BIAS_SIZE)>(
                join(data_base, EMBED_DENSE0_BIAS));
            auto b1 = read_floats_array<static_cast<std::size_t>(EMBED_DENSE1_BIAS_SIZE)>(
                join(data_base, EMBED_DENSE1_BIAS));
            graph.update("g.embed_bias0_rtp", b0);
            graph.update("g.embed_bias1_rtp", b1);
        }

        // ---------------- Solver branches ----------------
        auto load_solver_branch = [&](int idx) {
            const char* d0p = idx == 0 ? SUBSOLVER0_DENSE0_WEIGHTS_PREFIX
                                       : (idx == 1 ? SUBSOLVER1_DENSE0_WEIGHTS_PREFIX
                                                   : SUBSOLVER2_DENSE0_WEIGHTS_PREFIX);
            const char* d1p = idx == 0 ? SUBSOLVER0_DENSE1_WEIGHTS_PREFIX
                                       : (idx == 1 ? SUBSOLVER1_DENSE1_WEIGHTS_PREFIX
                                                   : SUBSOLVER2_DENSE1_WEIGHTS_PREFIX);
            const char* d2p = idx == 0 ? SUBSOLVER0_DENSE2_WEIGHTS_PREFIX
                                       : (idx == 1 ? SUBSOLVER1_DENSE2_WEIGHTS_PREFIX
                                                   : SUBSOLVER2_DENSE2_WEIGHTS_PREFIX);
            const char* d3p = idx == 0 ? SUBSOLVER0_DENSE3_WEIGHTS_PREFIX
                                       : (idx == 1 ? SUBSOLVER1_DENSE3_WEIGHTS_PREFIX
                                                   : SUBSOLVER2_DENSE3_WEIGHTS_PREFIX);

            const char* b0p = idx == 0 ? SUBSOLVER0_DENSE0_BIAS
                                       : (idx == 1 ? SUBSOLVER1_DENSE0_BIAS : SUBSOLVER2_DENSE0_BIAS);
            const char* b1p = idx == 0 ? SUBSOLVER0_DENSE1_BIAS
                                       : (idx == 1 ? SUBSOLVER1_DENSE1_BIAS : SUBSOLVER2_DENSE1_BIAS);
            const char* b2p = idx == 0 ? SUBSOLVER0_DENSE2_BIAS
                                       : (idx == 1 ? SUBSOLVER1_DENSE2_BIAS : SUBSOLVER2_DENSE2_BIAS);
            const char* b3p = idx == 0 ? SUBSOLVER0_DENSE3_BIAS
                                       : (idx == 1 ? SUBSOLVER1_DENSE3_BIAS : SUBSOLVER2_DENSE3_BIAS);

            for (int p = 0; p < SUBSOLVER0_INPUT_PARTS; ++p) {
                auto vals = read_floats_array<SOLVER_DENSE0_PART_SIZE>(
                    join(data_base, std::string(d0p) + std::to_string(p) + ".txt"));
                graph.update("g.solver" + std::to_string(idx) + "_dense0_matrixA_rtp[" + std::to_string(p) + "]",
                             vals);
            }
            for (int p = 0; p < SUBSOLVER0_LAYER_WEIGHTS_PARTS; ++p) {
                auto v1 = read_floats_array<SOLVER_DENSEx_PART_SIZE>(
                    join(data_base, std::string(d1p) + std::to_string(p) + ".txt"));
                auto v2 = read_floats_array<SOLVER_DENSEx_PART_SIZE>(
                    join(data_base, std::string(d2p) + std::to_string(p) + ".txt"));
                auto v3 = read_floats_array<SOLVER_DENSEx_PART_SIZE>(
                    join(data_base, std::string(d3p) + std::to_string(p) + ".txt"));
                graph.update("g.solver" + std::to_string(idx) + "_dense1_matrixA_rtp[" + std::to_string(p) + "]",
                             v1);
                graph.update("g.solver" + std::to_string(idx) + "_dense2_matrixA_rtp[" + std::to_string(p) + "]",
                             v2);
                graph.update("g.solver" + std::to_string(idx) + "_dense3_matrixA_rtp[" + std::to_string(p) + "]",
                             v3);
            }

            auto b0 = read_floats_array<static_cast<std::size_t>(SUBSOLVER0_DENSE0_BIAS_SIZE)>(
                join(data_base, b0p));
            auto b1 = read_floats_array<static_cast<std::size_t>(SUBSOLVER0_DENSE1_BIAS_SIZE)>(
                join(data_base, b1p));
            auto b2 = read_floats_array<static_cast<std::size_t>(SUBSOLVER0_DENSE2_BIAS_SIZE)>(
                join(data_base, b2p));
            auto b3 = read_floats_array<static_cast<std::size_t>(SUBSOLVER0_DENSE3_BIAS_SIZE)>(
                join(data_base, b3p));
            graph.update("g.solver" + std::to_string(idx) + "_bias0_rtp", b0);
            graph.update("g.solver" + std::to_string(idx) + "_bias1_rtp", b1);
            graph.update("g.solver" + std::to_string(idx) + "_bias2_rtp", b2);
            graph.update("g.solver" + std::to_string(idx) + "_bias3_rtp", b3);
        };

        load_solver_branch(0);
        load_solver_branch(1);
        load_solver_branch(2);

        // ---------------- Output weights ----------------
        // {
        //     auto out_w = read_floats_array<static_cast<std::size_t>(OUTPUT_DENSE0_WEIGHTS_SIZE)>(
        //         join(data_base, OUTPUT_DENSE0_WEIGHTS));
        //     graph.update("g.output_matrixA_rtp", out_w);
        // }

        // ---------------- GMIO transfers ----------------
        auto inputs = read_floats(join(data_base, EMBED_INPUT_DATA), 0U);
        if (inputs.empty() || inputs.size() % INPUT_SIZE != 0)
            throw std::runtime_error("Input size must be a multiple of INPUT_SIZE");

        std::size_t run_count = inputs.size() / INPUT_SIZE;
        // std::size_t out_elems = run_count * OUTPUT_DENSE0_OUT_PAD;
        std::size_t out_elems = run_count * HIDDEN_SIZE;
        std::size_t in_bytes  = inputs.size() * sizeof(float);
        std::size_t out_bytes = out_elems * sizeof(float);

        auto in_bo  = xrt::aie::bo(device, in_bytes,  xrt::bo::flags::normal, 0);
        auto out_bo = xrt::aie::bo(device, out_bytes, xrt::bo::flags::normal, 0);
        auto in_ptr  = in_bo.map<float*>();
        auto out_ptr = out_bo.map<float*>();

        std::memcpy(in_ptr, inputs.data(), in_bytes);

        in_bo.async("g.embed_input_gmio", XCL_BO_SYNC_BO_GMIO_TO_AIE, in_bytes, 0);
        graph.run(static_cast<int>(run_count));
        auto out_run = out_bo.async("g.embed_output_gmio", XCL_BO_SYNC_BO_AIE_TO_GMIO, out_bytes, 0);
        out_run.wait();
        graph.end();

        std::ofstream ofs(join(data_base, AIEML10_OUTPUT_FILE));
        ofs << std::setprecision(std::numeric_limits<float>::max_digits10);
        for (std::size_t i = 0; i < out_elems; ++i)
            ofs << out_ptr[i] << '\n';

        std::cout << "Wrote " << out_elems << " floats to " << AIEML10_OUTPUT_FILE << std::endl;
    }
    catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return 1;
    }
    return 0;
}
