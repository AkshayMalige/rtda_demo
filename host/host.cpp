#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <stdexcept>
#include <cstdlib>
#include <cstring>
#include <array>
#include <algorithm>
#include <cinttypes>
#include <chrono>
#include <future>
#include <utility>
#include <limits>

#include "xrt/xrt_device.h"
#include "xrt/xrt_graph.h"
#include "xrt/xrt_aie.h"
#include "xrt/xrt_kernel.h"
#include "xrt/xrt_bo.h"

#include "data_paths.h"
#include "nn_defs10.h"

// Retain C-style array semantics with 64B alignment for RTP DMA (mirrors async_array_rtp tutorial expectations).
template<typename T, std::size_t N>
struct alignas(64) aligned_array {
    T elems[N];

    T* data()
    {
        return elems;
    }

    const T* data() const
    {
        return elems;
    }

    T* begin()
    {
        return elems;
    }

    const T* begin() const
    {
        return elems;
    }

    T* end()
    {
        return elems + N;
    }

    const T* end() const
    {
        return elems + N;
    }

    constexpr std::size_t size() const
    {
        return N;
    }

    T& operator[](std::size_t idx)
    {
        return elems[idx];
    }

    const T& operator[](std::size_t idx) const
    {
        return elems[idx];
    }
};

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
static aligned_array<float, N> read_floats_array(const std::string& path)
{
    auto values = read_floats(path, N);
    aligned_array<float, N> result{};
    std::copy(values.begin(), values.end(), result.begin());
    return result;
}

template<std::size_t N>
static void load_rtp(xrt::graph& graph, const std::string& port, const std::string& path)
{
    auto payload = read_floats_array<N>(path);
    graph.update(port, payload);
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

using steady_clock = std::chrono::steady_clock;

struct host_timings {
    steady_clock::duration total{};
    steady_clock::duration weight_load{};
    steady_clock::duration input_transfer{};
    steady_clock::duration graph_exec{};
};

static double duration_ms(steady_clock::duration duration)
{
    return std::chrono::duration<double, std::milli>(duration).count();
}

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
    constexpr unsigned HOST_DEBUG_GMIO_BURST = 64U; // mirror graph's burst size for alignment checks

    std::cout << "[host] xclbin=" << xclbin_path
              << ", DATA_DIR=" << data_base << std::endl;

    host_timings timings{};
    const auto total_start = steady_clock::now();

    try {
        std::cout << "[host] Opening device(0)..." << std::endl;
        xrt::device device(0);
        std::cout << "[host] Loading xclbin..." << std::endl;
        auto uuid = device.load_xclbin(xclbin_path);
        std::cout << "[host] Opening graph 'g'..." << std::endl;
        xrt::graph graph(device, uuid, "g");
        std::cout << "[host] Graph opened." << std::endl;
        std::cout << "[host] Opening track_average kernel..." << std::endl;
        xrt::kernel track_average_kernel(device, uuid, "track_average_pl:{track_average}");
        std::cout << "[host] track_average kernel ready." << std::endl;

        const auto weight_load_start = steady_clock::now();

        // ---------------- Embed weights / biases ----------------
        {
            std::cout << "[host] Loading embed weights/bias..." << std::endl;
            load_rtp<EMBED_DENSE0_WEIGHTS_SIZE>(
                graph, "g.embed_matrixA0_rtp", join(data_base, EMBED_DENSE0_WEIGHTS));

            load_rtp<EMBED_DENSE1_PART_SIZE>(
                graph,
                "g.embed_matrixA1_0_rtp",
                join(data_base, std::string(EMBED_DENSE1_WEIGHTS_PREFIX) + "0.txt"));
            load_rtp<EMBED_DENSE1_PART_SIZE>(
                graph,
                "g.embed_matrixA1_1_rtp",
                join(data_base, std::string(EMBED_DENSE1_WEIGHTS_PREFIX) + "1.txt"));

            load_rtp<static_cast<std::size_t>(EMBED_DENSE0_BIAS_SIZE)>(
                graph, "g.embed_bias0_rtp", join(data_base, EMBED_DENSE0_BIAS));
            load_rtp<static_cast<std::size_t>(EMBED_DENSE1_BIAS_SIZE)>(
                graph, "g.embed_bias1_rtp", join(data_base, EMBED_DENSE1_BIAS));
            std::cout << "[host] Embed weights/bias loaded." << std::endl;
        }

        // ---------------- Solver branches ----------------
        auto load_solver_branch = [&](int idx) {
            std::cout << "[host] Loading solver branch " << idx << "..." << std::endl;
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
                const std::string port =
                    "g.solver" + std::to_string(idx) + "_dense0_matrixA_rtp[" + std::to_string(p) + "]";
                const std::string file = join(data_base, std::string(d0p) + std::to_string(p) + ".txt");
                load_rtp<SOLVER_DENSE0_PART_SIZE>(graph, port, file);
            }
            for (int p = 0; p < SUBSOLVER0_LAYER_WEIGHTS_PARTS; ++p) {
                const std::string p_suffix = std::to_string(p) + ".txt";
                load_rtp<SOLVER_DENSEx_PART_SIZE>(
                    graph,
                    "g.solver" + std::to_string(idx) + "_dense1_matrixA_rtp[" + std::to_string(p) + "]",
                    join(data_base, std::string(d1p) + p_suffix));
                load_rtp<SOLVER_DENSEx_PART_SIZE>(
                    graph,
                    "g.solver" + std::to_string(idx) + "_dense2_matrixA_rtp[" + std::to_string(p) + "]",
                    join(data_base, std::string(d2p) + p_suffix));
                load_rtp<SOLVER_DENSEx_PART_SIZE>(
                    graph,
                    "g.solver" + std::to_string(idx) + "_dense3_matrixA_rtp[" + std::to_string(p) + "]",
                    join(data_base, std::string(d3p) + p_suffix));
            }

            load_rtp<static_cast<std::size_t>(SUBSOLVER0_DENSE0_BIAS_SIZE)>(
                graph, "g.solver" + std::to_string(idx) + "_bias0_rtp", join(data_base, b0p));
            load_rtp<static_cast<std::size_t>(SUBSOLVER0_DENSE1_BIAS_SIZE)>(
                graph, "g.solver" + std::to_string(idx) + "_bias1_rtp", join(data_base, b1p));
            load_rtp<static_cast<std::size_t>(SUBSOLVER0_DENSE2_BIAS_SIZE)>(
                graph, "g.solver" + std::to_string(idx) + "_bias2_rtp", join(data_base, b2p));
            load_rtp<static_cast<std::size_t>(SUBSOLVER0_DENSE3_BIAS_SIZE)>(
                graph, "g.solver" + std::to_string(idx) + "_bias3_rtp", join(data_base, b3p));
            std::cout << "[host] Solver branch " << idx << " loaded." << std::endl;
        };

        load_solver_branch(0);
        load_solver_branch(1);
        load_solver_branch(2);

        timings.weight_load = steady_clock::now() - weight_load_start;

        // ---------------- Output weights ----------------
        // {
        //     auto out_w = read_floats_array<static_cast<std::size_t>(OUTPUT_DENSE0_WEIGHTS_SIZE)>(
        //         join(data_base, OUTPUT_DENSE0_WEIGHTS));
        //     graph.update("g.output_matrixA_rtp", out_w);
        // }

        // ---------------- GMIO transfers ----------------
        std::cout << "[host] Reading inputs..." << std::endl;
        auto inputs = read_floats(join(data_base, EMBED_INPUT_DATA), 0U);
        if (inputs.empty() || inputs.size() % INPUT_SIZE != 0)
            throw std::runtime_error("Input size must be a multiple of INPUT_SIZE");

        std::size_t run_count = inputs.size() / INPUT_SIZE;
        std::size_t in_bytes  = inputs.size() * sizeof(float);

        auto align_info = [&](std::size_t n) { return n % HOST_DEBUG_GMIO_BURST; };
        std::cout << "[host] input elements=" << inputs.size()
                  << ", run_count=" << run_count
                  << ", in_bytes=" << in_bytes << " (mod64=" << align_info(in_bytes) << ")"
                  << std::endl;

        const std::size_t total_stream_elems =
            run_count * static_cast<std::size_t>(HIDDEN_SIZE);
        if (total_stream_elems == 0U) {
            throw std::runtime_error("Graph configuration produced zero output elements.");
        }
        if (total_stream_elems > static_cast<std::size_t>(std::numeric_limits<int>::max())) {
            throw std::runtime_error("Track-average stream length exceeds int32 capacity.");
        }

        const int track_threshold = TRACK_AVERAGE_THRESHOLD;
        if (run_count < static_cast<std::size_t>(track_threshold)) {
            throw std::runtime_error("run_count must be at least TRACK_AVERAGE_THRESHOLD.");
        }
        const std::size_t track_windows =
            run_count / static_cast<std::size_t>(track_threshold);
        if (track_windows == 0U) {
            throw std::runtime_error("Track-average threshold exceeds available frames.");
        }
        const std::size_t track_output_elements =
            track_windows * static_cast<std::size_t>(HIDDEN_SIZE);
        const std::size_t track_output_bytes = track_output_elements * sizeof(float);
        std::cout << "[host] track_average config: threshold=" << track_threshold
                  << ", windows=" << track_windows
                  << ", stream_elements=" << total_stream_elems << std::endl;
        if (run_count % static_cast<std::size_t>(track_threshold) != 0U) {
            std::cout << "[host] track_average warning: run_count (" << run_count
                      << ") not divisible by threshold (" << track_threshold
                      << "); dropping "
                      << (run_count % static_cast<std::size_t>(track_threshold))
                      << " frame(s)." << std::endl;
        }

        std::vector<float> track_output(track_output_elements, 0.0f);
        xrt::bo track_out_bo(device, track_output_bytes, xrt::bo::flags::normal, 0);
        xrt::run track_run = xrt::run(track_average_kernel);
        track_run.set_arg(1, track_out_bo);
        track_run.set_arg(2, static_cast<int>(total_stream_elems));
        track_run.set_arg(3, track_threshold);
        const std::string track_output_path = join(data_base, EMBED_HOST_OUTPUT);

        std::cout << "[host] Allocating input BO..." << std::endl;
        auto in_bo  = xrt::aie::bo(device, in_bytes,  xrt::bo::flags::normal, 0);
        std::cout << "[host] Mapping input BO..." << std::endl;
        auto in_ptr  = in_bo.map<float*>();
        std::cout << "[host] Mapped: in_ptr=" << static_cast<const void*>(in_ptr) << std::endl;

        std::future<steady_clock::time_point> input_transfer_done;

        std::cout << "[host] memcpy -> in_ptr (" << in_bytes << " bytes)..." << std::endl;
        const auto input_transfer_start = steady_clock::now();
        std::memcpy(in_ptr, inputs.data(), in_bytes);
        std::cout << "[host] memcpy done." << std::endl;

        std::cout << "[host] Enqueue input GMIO async..." << std::endl;
        auto in_job = in_bo.async("g.embed_input_gmio", XCL_BO_SYNC_BO_GMIO_TO_AIE, in_bytes, 0);
        input_transfer_done = std::async(
            std::launch::async,
            [job = std::move(in_job)]() mutable {
                job.wait();
                return steady_clock::now();
            });

        std::cout << "[host] Starting track_average kernel..." << std::endl;
        track_run.start();

        std::cout << "[host] graph.run(" << run_count << ")..." << std::endl;
        const auto graph_exec_start = steady_clock::now();
        graph.run(static_cast<int>(run_count));
        graph.wait();
        track_run.wait();
        graph.end();
        const auto graph_exec_end = steady_clock::now();
        timings.graph_exec = graph_exec_end - graph_exec_start;

        const auto input_transfer_end = input_transfer_done.get();
        timings.input_transfer = input_transfer_end - input_transfer_start;

        std::cout << "[host] graph ended." << std::endl;

        track_out_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        track_out_bo.read(track_output.data());
        std::ofstream track_file(track_output_path);
        if (!track_file.is_open()) {
            throw std::runtime_error("Unable to open track-average output file: " + track_output_path);
        }
        for (std::size_t idx = 0; idx < track_output_elements; ++idx) {
            // std::cout << track_output[idx] << '\n';
            track_file << track_output[idx] << '\n';
        }
        track_file.close();
        std::cout << "[host] track_average captured "
                  << track_windows << " frame(s), "
                  << track_output_elements << " element(s) -> "
                  << track_output_path << std::endl;

        timings.total = steady_clock::now() - total_start;

        std::cout << "\n[host] ===== Execution Report =====" << std::endl;
        std::cout << "[host] weights/bias transfer : " << duration_ms(timings.weight_load) << " ms" << std::endl;
        std::cout << "[host] input transfer        : " << duration_ms(timings.input_transfer) << " ms" << std::endl;
        std::cout << "[host] graph exec (total)    : " << duration_ms(timings.graph_exec) << " ms" << std::endl;
        if (run_count) {
            const double run_count_d = static_cast<double>(run_count);
            std::cout << "[host] graph exec per input  : "
                      << duration_ms(timings.graph_exec) / run_count_d << " ms" << std::endl;
            std::cout << "[host] host total per input  : "
                      << duration_ms(timings.total) / run_count_d << " ms" << std::endl;
        }
        std::cout << "[host] host total (overall)  : " << duration_ms(timings.total) << " ms" << std::endl;
    }
    catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return 1;
    }
    return 0;
}
