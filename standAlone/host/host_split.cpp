#include <chrono>
#include <cmath>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

#include "xrt/xrt_bo.h"
#include "xrt/xrt_device.h"
#include "xrt/xrt_kernel.h"

#define N_TRACKS   50
#define INPUT_SIZE 6
#define OUT_DIM    27
#define STRIDE     8   // embed_input.txt has 8 values per track; first 6 are used

using steady_clock = std::chrono::steady_clock;

static double ms(steady_clock::duration d) {
    return std::chrono::duration<double, std::milli>(d).count();
}

static bool read_floats(const std::string& path, float* buf, int n) {
    std::ifstream f(path);
    if (!f.is_open()) { std::cerr << "ERROR: cannot open " << path << "\n"; return false; }
    for (int i = 0; i < n; i++) {
        if (!(f >> buf[i])) {
            std::cerr << "ERROR: short read from " << path
                      << " (got " << i << " of " << n << ")\n";
            return false;
        }
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <xclbin> [embed_input.txt] [ref.txt]\n";
        std::cerr << "  Data files default to DATA_DIR env var (default: /mnt)\n";
        return 1;
    }

    // On Versal hw_emu/hw the SD card is mounted at /mnt.
    // Override with DATA_DIR env var or argv.
    const char* data_dir_env = std::getenv("DATA_DIR");
    const std::string data_dir = data_dir_env ? data_dir_env : "/mnt";

    const std::string xclbin_path = argv[1];
    const std::string input_path  = (argc > 2) ? argv[2] : data_dir + "/embed_input.txt";
    const std::string ref_path    = (argc > 3) ? argv[3] : data_dir + "/keras_27dim.txt";

    std::cout << "[host] xclbin    = " << xclbin_path  << "\n";
    std::cout << "[host] input     = " << input_path   << "\n";
    std::cout << "[host] reference = " << ref_path     << "\n";

    const auto t_total_start = steady_clock::now();

    // --- Device + xclbin ---
    std::cout << "[host] Opening device(0)...\n";
    auto device = xrt::device(0);
    std::cout << "[host] Loading xclbin...\n";
    auto uuid   = device.load_xclbin(xclbin_path);
    auto kernel = xrt::kernel(device, uuid, "rtda_split_top");
    std::cout << "[host] Kernel ready.\n";

    // --- Read input ---
    float raw[N_TRACKS * STRIDE];
    if (!read_floats(input_path, raw, N_TRACKS * STRIDE)) return 1;

    // --- Allocate BOs ---
    // bo_in:  50 tracks × 6 floats → gmem0
    // bo_out: 27 floats            → gmem1
    auto bo_in  = xrt::bo(device, N_TRACKS * INPUT_SIZE * sizeof(float), kernel.group_id(0));
    auto bo_out = xrt::bo(device, OUT_DIM * sizeof(float),               kernel.group_id(1));

    float* ptr_in = bo_in.map<float*>();
    for (int j = 0; j < N_TRACKS; j++)
        for (int i = 0; i < INPUT_SIZE; i++)
            ptr_in[j * INPUT_SIZE + i] = raw[j * STRIDE + i];

    // --- H→D transfer ---
    const auto t_h2d_start = steady_clock::now();
    bo_in.sync(XCL_BO_SYNC_BO_TO_DEVICE);
    const auto t_h2d_end = steady_clock::now();

    // --- Kernel execution ---
    std::cout << "[host] Running rtda_split_top (N_TRACKS=" << N_TRACKS << ")...\n";
    const auto t_kernel_start = steady_clock::now();
    auto run = kernel(bo_in, bo_out, (int)N_TRACKS, (int)1 /*reset*/);
    run.wait();
    const auto t_kernel_end = steady_clock::now();
    std::cout << "[host] Kernel done.\n";

    // --- D→H transfer ---
    const auto t_d2h_start = steady_clock::now();
    bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    const auto t_d2h_end = steady_clock::now();

    const float* result = bo_out.map<float*>();
    const auto t_total_end = steady_clock::now();

    // --- Print result ---
    std::cout << "\n[host] 27-dim output:\n";
    for (int k = 0; k < OUT_DIM; k++)
        printf("  [%2d] %10.6f\n", k, result[k]);

    // --- Compare against reference ---
    std::ifstream ref_f(ref_path);
    if (ref_f.is_open()) {
        float ref[OUT_DIM];
        for (int k = 0; k < OUT_DIM; k++) ref_f >> ref[k];
        float max_diff = 0.f;
        for (int k = 0; k < OUT_DIM; k++)
            max_diff = std::max(max_diff, std::abs(result[k] - ref[k]));
        printf("\n[host] max|diff| vs %s = %.6f\n", ref_path.c_str(), max_diff);
        printf("[host] %s\n", max_diff < 0.1f ? "PASS" : "FAIL");
    } else {
        printf("\n[host] (reference file not found: %s)\n", ref_path.c_str());
    }

    // --- Timing report ---
    printf("\n[host] ===== Execution Report =====\n");
    printf("[host] H->D transfer   : %8.3f ms\n", ms(t_h2d_end    - t_h2d_start));
    printf("[host] kernel exec     : %8.3f ms\n", ms(t_kernel_end  - t_kernel_start));
    printf("[host] D->H transfer   : %8.3f ms\n", ms(t_d2h_end    - t_d2h_start));
    printf("[host] total (overall) : %8.3f ms\n", ms(t_total_end   - t_total_start));

    return 0;
}
