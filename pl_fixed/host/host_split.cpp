// ===========================================================================
//  XRT host for the PL-only RTDA design.
//
//  Writes exactly the files the AIE flow's host writes, in the same format:
//
//      track_means_all.txt   "<n_events> 128" header, one row of 128 floats
//                            per event. The PRIMARY output -- the analysis
//                            notebooks apply the 128->27 dense themselves so
//                            that every implementation is compared in one
//                            place, with one copy of that arithmetic.
//      track_out_27.txt      the last event through the on-chip output dense
//      run_info.txt          key=value: format, timing, sizes
//
//  Environment:
//      RTDA_INPUT    stimulus path   (default: searches embed_input_50000.txt,
//                                     testdata/, ../testdata/)
//      RTDA_OUTDIR   where to write   (default: first writable of . then /tmp --
//                                     the card's FAT partition is often ro)
//      RTDA_EVENTS   cap the event count  (default: all of them)
//      RTDA_WARMUP   tracks to skip in the mean (default 3; see below)
//
//  WARMUP is a runtime kernel argument, not a rebuild:
//      3  average tracks 3..49 -- comparable to the ONNX reference, whose
//         circular roll disagrees with a streaming one on exactly the first
//         three tracks of an event.
//      0  average all 50 -- what the AIE hardware produces, since its
//         accumulator cannot skip the contaminated head.
//  Both numbers are wanted, and rebuilding a bitstream to switch is not a
//  reasonable way to get them.
// ===========================================================================

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
#define HIDDEN     128
#define OUT_DIM    27
#define STRIDE     8   // the stimulus has 8 columns per track; 6 are used

using clk = std::chrono::steady_clock;
static double ms(clk::duration d) {
    return std::chrono::duration<double, std::milli>(d).count();
}

static const char* env_or(const char* k, const char* dflt) {
    const char* v = std::getenv(k);
    return (v && *v) ? v : dflt;
}

static bool exists(const std::string& p) { std::ifstream f(p); return f.good(); }

// First path that exists, or "" -- the packaged card puts the stimulus at the
// ROOT, while a build tree has it under testdata/. Defaulting to only one of
// those means the host works in exactly one of the two places.
static std::string first_existing(std::initializer_list<const char*> cands) {
    for (const char* c : cands) if (exists(c)) return c;
    return "";
}

// First directory we can actually create a file in.
//
// The SD card's FAT partition is frequently mounted READ-ONLY. Writing there is
// the default because it is the convenient place, but if it fails the run --
// which by then has already done all the compute -- must not be thrown away.
static std::string first_writable(std::initializer_list<const char*> cands) {
    for (const char* c : cands) {
        const std::string probe = std::string(c) + "/.rtda_write_test";
        std::ofstream f(probe);
        if (f.good()) { f.close(); std::remove(probe.c_str()); return c; }
    }
    return ".";
}

// Every write is checked. A full SD partition once produced three 0-byte
// output files while the AIE host reported success, and cost an hour.
struct Out {
    std::ofstream f;
    std::string name;
    Out(const std::string& dir, const std::string& n) : name(dir + "/" + n) {
        f.open(name);
        if (!f) { std::cerr << "ERROR: cannot open " << name << " for writing\n"; std::exit(1); }
    }
    void done() {
        f.flush();
        if (!f) { std::cerr << "ERROR: write failed for " << name << " (disk full?)\n"; std::exit(1); }
        f.close();
        if (f.fail()) { std::cerr << "ERROR: close failed for " << name << "\n"; std::exit(1); }
        std::cout << "[host] wrote " << name << "\n";
    }
};

int main(int argc, char* argv[]) {

    // argv[1] optional: match host_batch.exe, which autodetects. A TARGET=hw
    // build packages system_hw.xclbin, hw_emu packages system_hw_emu.xclbin.
    std::string xclbin = (argc > 1) ? argv[1]
                                    : first_existing({"system_hw.xclbin",
                                                      "system_hw_emu.xclbin"});
    if (xclbin.empty()) {
        std::cerr << "ERROR: no xclbin given and none found here.\n"
                     "       tried system_hw.xclbin, system_hw_emu.xclbin\n"
                     "       usage: " << argv[0] << " [xclbin]\n";
        return 1;
    }
    const bool is_emu = xclbin.find("hw_emu") != std::string::npos;
    std::string in_path = env_or("RTDA_INPUT", "");
    if (in_path.empty())
        in_path = first_existing({"embed_input_50000.txt",              // as packaged
                                  // hw_emu packages a 2-event stimulus instead:
                                  // RTDA_EVENTS cannot be set inside QEMU, so the
                                  // file is what caps the run. Listed after the
                                  // full one, so an SD card carrying both still
                                  // does the real thing.
                                  "embed_input_100.txt",
                                  "testdata/embed_input_50000.txt",     // build tree
                                  "../testdata/embed_input_50000.txt"});
    if (in_path.empty()) {
        std::cerr << "ERROR: no stimulus found. Tried embed_input_50000.txt,\n"
                     "       testdata/ and ../testdata/. Set RTDA_INPUT=<path>.\n";
        return 1;
    }
    const char* outdir_env = std::getenv("RTDA_OUTDIR");
    const std::string outdir = (outdir_env && *outdir_env)
                             ? std::string(outdir_env)
                             : first_writable({".", "/tmp"});
    const int cap = std::atoi(env_or("RTDA_EVENTS", "0"));
    const int warmup = std::atoi(env_or("RTDA_WARMUP", "3"));

    std::vector<float> raw;
    {
        std::ifstream f(in_path);
        if (!f) { std::cerr << "ERROR: cannot open " << in_path << "\n"; return 1; }
        float v;
        while (f >> v) raw.push_back(v);
    }
    const int rows = (int)raw.size() / STRIDE;
    int n_events = rows / N_TRACKS;
    if (cap > 0 && cap < n_events) n_events = cap;
    if (n_events == 0) {
        std::cerr << "ERROR: need " << N_TRACKS * STRIDE << " values for one event, got "
                  << raw.size() << "\n";
        return 1;
    }

    std::cout << "[host] xclbin = " << xclbin << "\n"
              << "[host] input  = " << in_path << "\n"
              << "[host] events = " << n_events << " (" << (long)n_events * N_TRACKS
              << " tracks), warmup=" << warmup << "\n";
    if (rows % N_TRACKS)
        std::cout << "[host] note: " << rows % N_TRACKS
                  << " trailing track(s) ignored (incomplete event)\n";

    auto device = xrt::device(0);
    auto uuid = device.load_xclbin(xclbin);
    auto kernel = xrt::kernel(device, uuid, "rtda_split_top");

    // ONE buffer per direction, sized for the WHOLE run, and one kernel start
    // for all of it -- the same shape as the AIE flow's single graph.run().
    // The kernel loops over events internally (pl/src/rtda_split_top.h).
    auto bo_in = xrt::bo(device, (size_t)n_events * N_TRACKS * INPUT_SIZE * sizeof(float),
                         kernel.group_id(0));
    auto bo_mean = xrt::bo(device, (size_t)n_events * HIDDEN * sizeof(float),
                           kernel.group_id(1));
    auto bo_out = xrt::bo(device, (size_t)n_events * OUT_DIM * sizeof(float),
                          kernel.group_id(2));
    float* p_in = bo_in.map<float*>();
    float* p_mean = bo_mean.map<float*>();
    float* p_out = bo_out.map<float*>();

    std::vector<std::vector<float>> means(n_events, std::vector<float>(HIDDEN));
    std::vector<float> last27(OUT_DIM);
    double t_h2d = 0, t_krn = 0, t_d2h = 0;

    const auto t_start = clk::now();

    // Stage every event first. This is host memcpy, not device time, and it is
    // outside the H2D/kernel/D2H accounting below for the same reason it always
    // was -- run_info.txt's ms_total still covers it.
    for (int ev = 0; ev < n_events; ev++) {
        const float* base = raw.data() + (size_t)ev * N_TRACKS * STRIDE;
        float* dst = p_in + (size_t)ev * N_TRACKS * INPUT_SIZE;
        for (int j = 0; j < N_TRACKS; j++)
            for (int i = 0; i < INPUT_SIZE; i++)
                dst[j * INPUT_SIZE + i] = base[j * STRIDE + i];
    }

    auto t0 = clk::now();
    bo_in.sync(XCL_BO_SYNC_BO_TO_DEVICE);
    auto t1 = clk::now();
    // reset=1: each event starts from a zero roll history, so events are
    // independent and reproducible regardless of what ran before. The kernel
    // now applies this per event rather than getting it from a fresh call.
    auto run = kernel(bo_in, bo_mean, bo_out,
                      (int)n_events, (int)N_TRACKS, (int)warmup, (int)1);
    run.wait();
    auto t2 = clk::now();
    bo_mean.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    auto t3 = clk::now();

    t_h2d = ms(t1 - t0); t_krn = ms(t2 - t1); t_d2h = ms(t3 - t2);
    for (int ev = 0; ev < n_events; ev++)
        means[ev].assign(p_mean + (size_t)ev * HIDDEN,
                         p_mean + (size_t)(ev + 1) * HIDDEN);
    last27.assign(p_out + (size_t)(n_events - 1) * OUT_DIM,
                  p_out + (size_t)n_events * OUT_DIM);

    const double total = ms(clk::now() - t_start);

    const long n_tracks = (long)n_events * N_TRACKS;
    std::cout << "[host] " << n_events << " events in " << total << " ms\n"
              << "[host]   H2D " << t_h2d << " ms, kernel " << t_krn
              << " ms, D2H " << t_d2h << " ms\n"
              << "[host]   " << (1e3 * total / n_tracks) << " us/track, "
              << (total / n_events) << " ms/event\n";

    { Out o(outdir, "track_means_all.txt");
      o.f << n_events << " " << HIDDEN << "\n";
      o.f.precision(9); o.f << std::scientific;
      for (const auto& r : means)
          for (int k = 0; k < HIDDEN; k++) o.f << r[k] << (k + 1 == HIDDEN ? '\n' : ' ');
      o.done(); }

    { Out o(outdir, "track_out_27.txt");
      o.f.precision(9); o.f << std::scientific;
      for (int k = 0; k < OUT_DIM; k++) o.f << last27[k] << "\n";
      o.done(); }

    { Out o(outdir, "run_info.txt");
      o.f << "impl=pl_fixed\n"
          << "source=" << (is_emu ? "hw_emu" : "hw") << "\n"
          // Which fixed-point build was this? One string from the Makefile --
          // not the HLS headers, which the XRT host has no business including.
          // A result file copied off the board still says what produced it.
          << "variant=" << RTDA_VARIANT << "\n"
          << "xclbin=" << xclbin << "\n"
          << "input=" << in_path << "\n"
          << "events=" << n_events << "\n"
          << "tracks=" << n_tracks << "\n"
          << "warmup=" << warmup << "\n"
          << "ms_total=" << total << "\n"
          << "ms_kernel=" << t_krn << "\n"
          << "ms_h2d=" << t_h2d << "\n"
          << "ms_d2h=" << t_d2h << "\n"
          << "us_per_track=" << (1e3 * total / n_tracks) << "\n"
          << "ms_per_event=" << (total / n_events) << "\n";
      o.done(); }

    return 0;
}
