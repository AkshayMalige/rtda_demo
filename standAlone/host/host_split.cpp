#include <chrono>
#include <cmath>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "xrt/xrt_bo.h"
#include "xrt/xrt_device.h"
#include "xrt/xrt_kernel.h"

#define N_TRACKS   50
#define INPUT_SIZE 6
#define OUT_DIM    27
#define STRIDE     8   // embed_input.txt: 8 values per track row, first 6 are used

using steady_clock = std::chrono::steady_clock;

static double ms(steady_clock::duration d) {
    return std::chrono::duration<double, std::milli>(d).count();
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <xclbin> [embed_input.txt] [ref_event0.txt]\n";
        std::cerr << "  Data files default to DATA_DIR env var or current directory.\n";
        return 1;
    }

    const char* data_dir_env = std::getenv("DATA_DIR");
    const std::string data_dir = data_dir_env ? data_dir_env : ".";

    const std::string xclbin_path = argv[1];
    const std::string input_path  = (argc > 2) ? argv[2] : data_dir + "/embed_input.txt";
    const std::string ref_path    = (argc > 3) ? argv[3] : data_dir + "/keras_27dim.txt";
    const std::string out_path    = data_dir + "/results.txt";

    // --- Read all input rows from file ---
    std::vector<float> all_raw;
    {
        std::ifstream f(input_path);
        if (!f.is_open()) { std::cerr << "ERROR: cannot open " << input_path << "\n"; return 1; }
        float v;
        while (f >> v) all_raw.push_back(v);
    }

    const int total_rows = (int)all_raw.size() / STRIDE;
    const int n_events   = total_rows / N_TRACKS;

    if (n_events == 0) {
        std::cerr << "ERROR: not enough data for one event. Need " << N_TRACKS * STRIDE
                  << " values, got " << all_raw.size() << "\n";
        return 1;
    }

    std::cout << "[host] xclbin    = " << xclbin_path << "\n";
    std::cout << "[host] input     = " << input_path  << "\n";
    std::cout << "[host] output    = " << out_path    << "\n";
    std::cout << "[host] rows read = " << total_rows  << "  →  "
              << n_events << " event(s) of " << N_TRACKS << " tracks\n";
    if (total_rows % N_TRACKS)
        std::cout << "[host] note: " << total_rows % N_TRACKS
                  << " trailing track(s) ignored (incomplete event)\n";

    const auto t_total_start = steady_clock::now();

    // --- Device + xclbin ---
    std::cout << "[host] Opening device and loading xclbin...\n";
    auto device = xrt::device(0);
    auto uuid   = device.load_xclbin(xclbin_path);
    auto kernel = xrt::kernel(device, uuid, "rtda_split_top");
    std::cout << "[host] Kernel ready.\n";

    // --- Allocate BOs (reused across all events) ---
    auto bo_in  = xrt::bo(device, N_TRACKS * INPUT_SIZE * sizeof(float), kernel.group_id(0));
    auto bo_out = xrt::bo(device, OUT_DIM * sizeof(float),               kernel.group_id(1));
    float* ptr_in  = bo_in.map<float*>();
    float* ptr_out = bo_out.map<float*>();

    // --- Output storage ---
    std::vector<std::vector<float>> results(n_events, std::vector<float>(OUT_DIM));

    // --- Per-event timing accumulators ---
    double total_h2d_ms = 0, total_kernel_ms = 0, total_d2h_ms = 0;

    // --- Event loop ---
    for (int ev = 0; ev < n_events; ev++) {
        // Fill BO from this event's rows
        const float* event_base = all_raw.data() + ev * N_TRACKS * STRIDE;
        for (int j = 0; j < N_TRACKS; j++)
            for (int i = 0; i < INPUT_SIZE; i++)
                ptr_in[j * INPUT_SIZE + i] = event_base[j * STRIDE + i];

        auto t0 = steady_clock::now();
        bo_in.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        auto t1 = steady_clock::now();

        auto run = kernel(bo_in, bo_out, (int)N_TRACKS, (int)1 /*reset*/);
        run.wait();
        auto t2 = steady_clock::now();

        bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        auto t3 = steady_clock::now();

        total_h2d_ms   += ms(t1 - t0);
        total_kernel_ms += ms(t2 - t1);
        total_d2h_ms   += ms(t3 - t2);

        for (int k = 0; k < OUT_DIM; k++)
            results[ev][k] = ptr_out[k];
    }

    const auto t_total_end = steady_clock::now();

    // --- Write all results to file ---
    {
        std::ofstream of(out_path);
        if (!of.is_open()) {
            std::cerr << "ERROR: cannot write " << out_path << "\n";
        } else {
            for (int ev = 0; ev < n_events; ev++) {
                for (int k = 0; k < OUT_DIM; k++)
                    of << results[ev][k] << (k < OUT_DIM - 1 ? " " : "\n");
            }
            std::cout << "[host] wrote " << n_events << " event(s) → " << out_path << "\n";
        }
    }

    // --- Print first event ---
    std::cout << "\n[host] Event 0 — 27-dim output:\n";
    for (int k = 0; k < OUT_DIM; k++)
        printf("  [%2d] %10.6f\n", k, results[0][k]);

    // --- Compare event 0 against reference ---
    std::ifstream ref_f(ref_path);
    if (ref_f.is_open()) {
        float ref[OUT_DIM];
        for (int k = 0; k < OUT_DIM; k++) ref_f >> ref[k];
        float max_diff = 0.f;
        for (int k = 0; k < OUT_DIM; k++)
            max_diff = std::max(max_diff, std::abs(results[0][k] - ref[k]));
        printf("\n[host] max|diff| event 0 vs %s = %.6f  %s\n",
               ref_path.c_str(), max_diff, max_diff < 0.1f ? "PASS" : "FAIL");
    }

    // --- Timing report ---
    const double total_ms = ms(t_total_end - t_total_start);
    printf("\n[host] ===== Execution Report (%d event(s)) =====\n", n_events);
    printf("[host] H->D transfer   : %8.3f ms total  (%6.3f ms/event)\n",
           total_h2d_ms,    total_h2d_ms    / n_events);
    printf("[host] kernel exec     : %8.3f ms total  (%6.3f ms/event)\n",
           total_kernel_ms, total_kernel_ms / n_events);
    printf("[host] D->H transfer   : %8.3f ms total  (%6.3f ms/event)\n",
           total_d2h_ms,    total_d2h_ms    / n_events);
    printf("[host] total (overall) : %8.3f ms         (%6.3f ms/event,  %.1f events/s)\n",
           total_ms, total_ms / n_events, n_events / (total_ms / 1000.0));

    return 0;
}
