// ===========================================================================
//  The PL design, bit-accurate, on the host CPU. No Vitis, no board.
//
//  Compiles the SAME kernel sources (rtda_split_top.cpp and the five proxies)
//  with plain g++ against the header-only ap_fixed / hls_stream / nnet_utils.
//  The #pragma HLS lines are ignored, and nothing else differs -- so every
//  number this produces is exactly what the RTL computes.
//
//  WHY IT IS NOT OPTIONAL
//  The design takes ~2 ms of hardware time per event. In hw_emu that is RTL
//  simulation, so 5 events is a reasonable gate and 1000 events is not a thing
//  anyone will wait for. But the comparison against the AIE flow is over 1000
//  events / 50,000 tracks. Without this, the only way to get an ap_fixed
//  number at that scale is to build a bitstream and boot the board.
//
//  Output is deliberately byte-format-identical to what the AIE flow's XRT
//  host writes, so analysis/ reads both with the same loader:
//      track_means_all.txt   "<n_events> 128" header, then one row per event
//      track_out_27.txt      27 floats, last event
//      run_info.txt          key=value
//
//    ./run_model <input.txt> <outdir> [n_events] [warmup]
// ===========================================================================

#include <chrono>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "rtda_split_top.h"

#define STRIDE 8   // the stimulus has 8 columns per track; the model uses 6

int main(int argc, char** argv) {
    if (argc < 3) {
        std::cerr << "usage: " << argv[0]
                  << " <embed_input.txt> <outdir> [n_events] [warmup]\n";
        return 2;
    }
    const std::string in_path = argv[1];
    const std::string outdir = argv[2];
    const int want_events = (argc > 3) ? std::atoi(argv[3]) : 0;   // 0 = all
    const int warmup = (argc > 4) ? std::atoi(argv[4]) : 0;

    std::vector<float> raw;
    {
        std::ifstream f(in_path);
        if (!f) { std::cerr << "ERROR: cannot open " << in_path << "\n"; return 1; }
        float v;
        while (f >> v) raw.push_back(v);
    }
    const int rows = (int)raw.size() / STRIDE;
    int n_events = rows / MAX_TRACKS;
    if (want_events > 0 && want_events < n_events) n_events = want_events;
    if (n_events == 0) {
        std::cerr << "ERROR: need at least " << MAX_TRACKS * STRIDE
                  << " values, got " << raw.size() << "\n";
        return 1;
    }

    std::printf("[native] input   : %s\n", in_path.c_str());
    std::printf("[native] format  : ap_fixed<%d,%d>  weights <%d,%d>  "
                "accum <%d,%d>  alpha %g\n",
                RTDA_W, RTDA_I, RTDA_W, RTDA_WEIGHT_I,
                RTDA_ACC_W, RTDA_ACC_I, (double)RTDA_ALPHA_VALUE);
    std::printf("[native] events  : %d  (%d tracks), warmup=%d -> averaging "
                "tracks %d..%d\n",
                n_events, n_events * MAX_TRACKS, warmup, warmup, MAX_TRACKS - 1);

    std::vector<float> track(MAX_TRACKS * INPUT_SIZE);
    std::vector<float> mean(HIDDEN), out27(OUT_DIM);
    std::vector<std::vector<float>> all_means(n_events,
                                              std::vector<float>(HIDDEN));
    std::vector<float> last27(OUT_DIM);

    const auto t0 = std::chrono::steady_clock::now();
    for (int ev = 0; ev < n_events; ev++) {
        const float* base = raw.data() + (size_t)ev * MAX_TRACKS * STRIDE;
        for (int j = 0; j < MAX_TRACKS; j++)
            for (int i = 0; i < INPUT_SIZE; i++)
                track[j * INPUT_SIZE + i] = base[j * STRIDE + i];

        // reset=true: each event starts from a zero roll history, matching what
        // the XRT host does. The AIE instead carries across events; that shows
        // up only in the first three tracks, which is exactly what warmup skips.
        rtda_split_top(track.data(), mean.data(), out27.data(),
                       MAX_TRACKS, warmup, true);

        all_means[ev].assign(mean.begin(), mean.end());
        if (ev + 1 == n_events) last27.assign(out27.begin(), out27.end());
        if (n_events > 20 && (ev % (n_events / 20) == 0))
            std::printf("\r[native] %5d / %d events", ev, n_events), std::fflush(stdout);
    }
    const auto t1 = std::chrono::steady_clock::now();
    const double secs = std::chrono::duration<double>(t1 - t0).count();
    if (n_events > 20) std::printf("\r");
    std::printf("[native] done in %.1f s (%.2f ms/event)\n",
                secs, 1e3 * secs / n_events);

    // --- write, and CHECK that the writes worked ---------------------------
    // A full SD partition once produced three 0-byte files while the AIE host
    // reported success and cost an hour. Never again silently.
    auto open_out = [&](const std::string& name) {
        auto* f = new std::ofstream(outdir + "/" + name);
        if (!*f) {
            std::cerr << "ERROR: cannot write " << outdir << "/" << name << "\n";
            std::exit(1);
        }
        return f;
    };
    auto close_out = [&](std::ofstream* f, const std::string& name) {
        f->flush();
        if (!*f) {
            std::cerr << "ERROR: write failed for " << name
                      << " (disk full?)\n";
            std::exit(1);
        }
        f->close();
        delete f;
    };

    auto* fm = open_out("track_means_all.txt");
    *fm << n_events << " " << HIDDEN << "\n";
    fm->precision(9);
    *fm << std::scientific;
    for (const auto& row : all_means) {
        for (int k = 0; k < HIDDEN; k++) *fm << row[k] << (k + 1 == HIDDEN ? '\n' : ' ');
    }
    close_out(fm, "track_means_all.txt");

    auto* fo = open_out("track_out_27.txt");
    fo->precision(9);
    *fo << std::scientific;
    for (int k = 0; k < OUT_DIM; k++) *fo << last27[k] << "\n";
    close_out(fo, "track_out_27.txt");

    auto* fi = open_out("run_info.txt");
    *fi << "impl=pl_fixed\n"
        << "source=native\n"
        << "input=" << in_path << "\n"
        << "events=" << n_events << "\n"
        << "tracks=" << (long)n_events * MAX_TRACKS << "\n"
        << "warmup=" << warmup << "\n"
        << "ap_w=" << RTDA_W << "\nap_i=" << RTDA_I << "\n"
        << "ap_weight_i=" << RTDA_WEIGHT_I << "\n"
        << "ap_acc_w=" << RTDA_ACC_W << "\nap_acc_i=" << RTDA_ACC_I << "\n"
        << "leaky_alpha=" << (double)RTDA_ALPHA_VALUE << "\n"
        << "host_seconds=" << secs << "\n";
    close_out(fi, "run_info.txt");

    std::printf("[native] wrote %s/{track_means_all.txt,track_out_27.txt,run_info.txt}\n",
                outdir.c_str());
    return 0;
}
