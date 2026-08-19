// ===========================================================================
//  Performance scan host for the PL-only RTDA design.
//
//  host_split.exe answers "is it correct and how fast overall". This answers
//  "where does the time go, and how does it scale". It sweeps event counts with
//  repeats and writes ONLY performance files:
//
//      scan.csv        one row per (event count, repeat, mode)
//      scan_meta.txt   the one-time costs and the provenance
//
//  It deliberately writes NO track_means_all.txt, NO track_out_27.txt and NO
//  run_info.txt. A timing run must not be able to land in results/pl_fixed/hw/
//  and be read as a result run -- the accuracy numbers in the README come from
//  host_split.exe and only from there.
//
//  THE QUESTION THIS EXISTS TO ANSWER
//  results/pl_fixed/hw/run_info.txt reports ms_kernel=5712 for 1000 events, i.e.
//  5.71 ms/event. csynth reports TrackLoop iteration latency 6335 cycles, which
//  at the linked 150 MHz is 42.2 us/track = 2.11 ms/event of fabric. The 2.7x gap
//  sits entirely inside a timer that spans kernel-enqueue AND run.wait(), so
//  per-call driver overhead and slow fabric are indistinguishable in it.
//
//  Two knobs separate them:
//
//    mode=fresh / mode=reuse   host_split.cpp constructs a new xrt::run for every
//                              event. reuse keeps one run object and only calls
//                              start()/wait(). The difference is the part of the
//                              gap that is XRT bookkeeping.
//
//    mode=tpc                  n_tracks is a runtime s_axilite argument and
//                              TrackLoop is `for (j = 0; j < n_tracks; j++)`, so
//                              one call can process 50, 100, 500 or 1000 tracks.
//                              Fitting us_call = fixed + marginal*tracks gives the
//                              per-call cost and the per-track cost SEPARATELY:
//                                marginal ~42 us  -> the gap is per-call overhead
//                                marginal ~114 us -> the fabric really is slower
//                              The 128-wide mean is meaningless for n_tracks != 50
//                              (the accumulator divides by the event size), which
//                              is fine -- these rows are timing only and carry
//                              mode=tpc so the notebook never plots them as event
//                              throughput.
//
//  Environment (all optional -- with none set it runs the full default sweep,
//  bounded by whatever stimulus it finds, because launch_hw_emu.sh -run-app
//  passes neither arguments nor environment into the guest):
//
//      RTDA_INPUT        stimulus path (same search order as host_split)
//      RTDA_OUTDIR       where to write (default: first writable of . then /tmp)
//      RTDA_SCAN_EVENTS  comma list, default 1,10,100,1000,10000
//                        clipped to what the stimulus can supply
//      RTDA_SCAN_REPS    repeats per point, default 5
//      RTDA_SCAN_MODES   fresh,reuse   (default both)
//      RTDA_SCAN_TPC     comma list of tracks-per-call, default 50,100,500,1000
//                        set to "off" to skip -- it is the one experiment here
//                        that drives the kernel outside its tested shape
//      RTDA_SCAN_TPC_CALLS  calls per tpc point, default 20
//      RTDA_WARMUP       kernel warmup argument, default 3 (irrelevant to timing,
//                        recorded so the row says what it ran)
//      RTDA_DUMP_CALLS   =1 also writes scan_calls_<events>.csv for the largest
//                        point: one row per call, for the distribution plot
//
//  SETTING THOSE UNDER QEMU
//  launch_hw_emu.sh -run-app forwards ARGUMENTS into the guest but not the
//  ENVIRONMENT (pl_fixed/Makefile explains why), so under emulation there would be
//  no way to shorten the sweep -- and the default sweep in RTL simulation is
//  hours. So any argument containing '=' is applied as an environment assignment
//  before anything is read:
//
//      ./host_scan.exe system_hw_emu.xclbin RTDA_SCAN_REPS=1 RTDA_SCAN_TPC=off
//
//  The first argument WITHOUT '=' is the xclbin, as before.
// ===========================================================================

#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

#include <sys/utsname.h>
#include <time.h>

#include "xrt/xrt_bo.h"
#include "xrt/xrt_device.h"
#include "xrt/xrt_kernel.h"

#define N_TRACKS   50
#define INPUT_SIZE 6
#define HIDDEN     128
#define OUT_DIM    27
#define STRIDE     8            // the stimulus has 8 columns per track; 6 are used
#define MACS_PER_TRACK 264192L  // 14 dense layers; same figure the AIE host uses

using clk = std::chrono::steady_clock;
static double us(clk::duration d) {
    return std::chrono::duration<double, std::micro>(d).count();
}

static const char* env_or(const char* k, const char* dflt) {
    const char* v = std::getenv(k);
    return (v && *v) ? v : dflt;
}

static bool exists(const std::string& p) { std::ifstream f(p); return f.good(); }

static std::string first_existing(std::initializer_list<const char*> cands) {
    for (const char* c : cands) if (exists(c)) return c;
    return "";
}

// The SD card's FAT partition is frequently mounted read-only. Falling back
// rather than failing matters more here than usual: the scan is the expensive
// part and it has already run by the time anything is written.
static std::string first_writable(std::initializer_list<const char*> cands) {
    for (const char* c : cands) {
        const std::string probe = std::string(c) + "/.rtda_write_test";
        std::ofstream f(probe);
        if (f.good()) { f.close(); std::remove(probe.c_str()); return c; }
    }
    return ".";
}

// Every write is checked -- a full SD partition once produced 0-byte output files
// while the host reported success.
struct Out {
    std::ofstream f;
    std::string name;
    Out(const std::string& dir, const std::string& n) : name(dir + "/" + n) {
        f.open(name);
        if (!f) { std::cerr << "ERROR: cannot open " << name << " for writing\n"; std::exit(1); }
    }
    // announce=false for the per-point rewrites of scan.csv, which would otherwise
    // print a line for every measured point.
    void done(bool announce = true) {
        f.flush();
        if (!f) { std::cerr << "ERROR: write failed for " << name << " (disk full?)\n"; std::exit(1); }
        f.close();
        if (f.fail()) { std::cerr << "ERROR: close failed for " << name << "\n"; std::exit(1); }
        if (announce) std::cout << "[scan] wrote " << name << "\n";
    }
};

static std::vector<long> parse_list(const std::string& s) {
    std::vector<long> v;
    std::size_t i = 0;
    while (i < s.size()) {
        std::size_t j = s.find(',', i);
        if (j == std::string::npos) j = s.size();
        const std::string tok = s.substr(i, j - i);
        if (!tok.empty()) {
            const long n = std::atol(tok.c_str());
            if (n > 0) v.push_back(n);
        }
        i = j + 1;
    }
    return v;
}

// Sorted-in-place; min / median / p95 / max of a per-call series.
struct Stats { double mn, med, p95, mx; };
static Stats stats_of(std::vector<double> v) {
    std::sort(v.begin(), v.end());
    const std::size_t n = v.size();
    Stats s;
    s.mn  = v.front();
    s.mx  = v.back();
    s.med = (n % 2) ? v[n / 2] : 0.5 * (v[n / 2 - 1] + v[n / 2]);
    s.p95 = v[(std::size_t)(0.95 * (n - 1))];
    return s;
}

// One measured point. Fields left at NaN are written as empty CSV cells, which is
// what the notebook reads as "this implementation cannot measure that".
struct Row {
    long events = 0, tracks = 0, rep = 0, launches = 0, tracks_per_call = 0;
    double us_stage = 0, us_h2d = 0, us_kernel = 0, us_d2h = 0, us_execute = 0, us_total = 0;
    Stats call{0, 0, 0, 0};
    long in_bytes = 0, out_bytes = 0;
    double mean_checksum = 0;
    std::string mode, notes;
};

// Arguments of the form KEY=VALUE become environment variables; everything else
// is returned as a positional argument. See the note about QEMU in the header.
static std::vector<std::string> absorb_env_args(int argc, char* argv[]) {
    std::vector<std::string> positional;
    for (int i = 1; i < argc; i++) {
        const char* eq = std::strchr(argv[i], '=');
        if (eq && eq != argv[i]) {
            const std::string k(argv[i], eq - argv[i]);
            setenv(k.c_str(), eq + 1, 1);
            std::cout << "[scan] " << k << "=" << (eq + 1) << " (from argv)\n";
        } else {
            positional.push_back(argv[i]);
        }
    }
    return positional;
}

int main(int argc, char* argv[]) {

    const auto pos = absorb_env_args(argc, argv);

    std::string xclbin = !pos.empty() ? pos[0]
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
        in_path = first_existing({"embed_input_500000.txt",    // the scan stimulus
                                  "embed_input_50000.txt",     // as packaged
                                  "embed_input_100.txt",       // hw_emu package
                                  "testdata/embed_input_500000.txt",
                                  "testdata/embed_input_50000.txt",
                                  "../testdata/embed_input_500000.txt",
                                  "../testdata/embed_input_50000.txt"});
    if (in_path.empty()) {
        std::cerr << "ERROR: no stimulus found. Tried embed_input_500000.txt,\n"
                     "       embed_input_50000.txt, testdata/ and ../testdata/.\n"
                     "       Set RTDA_INPUT=<path>.\n";
        return 1;
    }
    const std::string outdir = first_writable({env_or("RTDA_OUTDIR", "."), "/tmp"});
    const int warmup = std::atoi(env_or("RTDA_WARMUP", "3"));
    const long reps  = std::max(1L, std::atol(env_or("RTDA_SCAN_REPS", "5")));
    const bool dump_calls = std::atoi(env_or("RTDA_DUMP_CALLS", "0")) != 0;

    std::vector<long> ev_list = parse_list(env_or("RTDA_SCAN_EVENTS", "1,10,100,1000,10000"));
    const std::string modes_s = env_or("RTDA_SCAN_MODES", "fresh,reuse,single");
    const bool do_fresh = modes_s.find("fresh") != std::string::npos;
    const bool do_reuse = modes_s.find("reuse") != std::string::npos;
    // "single" is the one-call form: every event staged, ONE sync, ONE kernel
    // start. Added ALONGSIDE fresh/reuse rather than replacing them -- the
    // existing rows stay comparable and the difference between the two shapes
    // becomes a measured number instead of a claim.
    const bool do_single = modes_s.find("single") != std::string::npos;

    const std::string tpc_s = env_or("RTDA_SCAN_TPC", "50,100,500,1000");
    std::vector<long> tpc_list = (tpc_s == "off" || tpc_s == "0")
                               ? std::vector<long>() : parse_list(tpc_s);
    const long tpc_calls = std::max(1L, std::atol(env_or("RTDA_SCAN_TPC_CALLS", "20")));

    // ---- stimulus ---------------------------------------------------------
    // 500,000 tracks is 4 million values through operator>>. Timed and reported
    // rather than hidden: on the board it is seconds, and it is not the design's.
    const auto t_load0 = clk::now();
    std::vector<float> raw;
    {
        std::ifstream f(in_path);
        if (!f) { std::cerr << "ERROR: cannot open " << in_path << "\n"; return 1; }
        float v;
        while (f >> v) raw.push_back(v);
    }
    const double us_load = us(clk::now() - t_load0);

    const long rows = (long)raw.size() / STRIDE;
    const long max_events = rows / N_TRACKS;
    if (max_events == 0) {
        std::cerr << "ERROR: need " << N_TRACKS * STRIDE << " values for one event, got "
                  << raw.size() << "\n";
        return 1;
    }

    // Under emulation, cap the default sweep HARD.
    //
    // The hw_emu image carries the 500,000-track stimulus (the hw card needs it,
    // and one packaging list serves both), and the probe above prefers it. In RTL
    // simulation a single event is seconds to minutes, so the default 10,000-event
    // point is not slow, it is unbounded -- you come back the next morning to a
    // QEMU still running. An explicit RTDA_SCAN_EVENTS overrides this; the cap
    // only replaces the DEFAULT.
    if (is_emu && std::getenv("RTDA_SCAN_EVENTS") == nullptr) {
        ev_list = {1, 2};
        std::cout << "[scan] EMULATION: default sweep capped to 1,2 events.\n"
                     "[scan]   RTL simulation makes the 10,000-event point unbounded.\n"
                     "[scan]   Set RTDA_SCAN_EVENTS=... to override.\n";
    }

    // Clip, then drop duplicates. With a 2-event stimulus the default sweep
    // collapses to {1,2}, which is exactly what should happen: the host runs the
    // biggest honest sweep the data allows rather than refusing.
    {
        std::vector<long> keep;
        for (long e : ev_list) keep.push_back(std::min(e, max_events));
        std::sort(keep.begin(), keep.end());
        keep.erase(std::unique(keep.begin(), keep.end()), keep.end());
        ev_list = keep;
    }
    const long ev_max = ev_list.empty() ? 0 : ev_list.back();

    long tpc_max = N_TRACKS;
    for (long t : tpc_list) tpc_max = std::max(tpc_max, t);
    if (tpc_max > rows) {                     // a tiny stimulus cannot feed a big call
        std::vector<long> keep;
        for (long t : tpc_list) if (t <= rows) keep.push_back(t);
        tpc_list = keep;
        tpc_max = N_TRACKS;
        for (long t : tpc_list) tpc_max = std::max(tpc_max, t);
    }

    std::cout << "[scan] xclbin  = " << xclbin << (is_emu ? "  (EMULATION)" : "") << "\n"
              << "[scan] input   = " << in_path << "  (" << rows << " tracks, "
              << max_events << " events max, read in " << (us_load / 1e6) << " s)\n"
              << "[scan] events  =";
    for (long e : ev_list) std::cout << ' ' << e;
    std::cout << "   reps=" << reps << "  modes=" << modes_s << "\n"
              << "[scan] tpc     =";
    if (tpc_list.empty()) std::cout << " (skipped)";
    else for (long t : tpc_list) std::cout << ' ' << t;
    std::cout << "\n[scan] outdir  = " << outdir << "\n";

    // ---- device -----------------------------------------------------------
    const auto t_dev0 = clk::now();
    auto device = xrt::device(0);
    auto uuid = device.load_xclbin(xclbin);
    auto kernel = xrt::kernel(device, uuid, "rtda_split_top");
    const double us_open = us(clk::now() - t_dev0);
    std::cout << "[scan] xclbin open + kernel: " << (us_open / 1e3) << " ms\n";

    // One allocation for the whole scan, sized for the largest call. The kernel
    // reads only what its arguments ask for, so an oversized input BO changes
    // nothing for the 50-track points -- and reallocating per point would put
    // allocator time inside the measurement.
    //
    // mode=single hands the kernel every event at once, so the input has to hold
    // ev_max*50 tracks and the outputs ev_max results, not one event's worth.
    const long ev_max_alloc = ev_list.empty() ? 1 : *std::max_element(ev_list.begin(), ev_list.end());
    const size_t in_tracks = (size_t)std::max(tpc_max, ev_max_alloc * N_TRACKS);
    auto bo_in = xrt::bo(device, in_tracks * INPUT_SIZE * sizeof(float), kernel.group_id(0));
    auto bo_mean = xrt::bo(device, (size_t)ev_max_alloc * HIDDEN * sizeof(float), kernel.group_id(1));
    auto bo_out = xrt::bo(device, (size_t)ev_max_alloc * OUT_DIM * sizeof(float), kernel.group_id(2));
    float* p_in = bo_in.map<float*>();
    float* p_mean = bo_mean.map<float*>();
    float* p_out = bo_out.map<float*>();
    (void)p_out;

    std::vector<Row> out_rows;
    std::vector<double> dump_series;      // per-call kernel us of the largest point
    long dump_events = 0;

    // Rewritten after EVERY point, not once at the end. The tracks-per-call sweep
    // drives the kernel outside the 50-track shape and is the one thing here that
    // could hang; writing only at exit would take the whole event sweep down with
    // it, after ten minutes of board time. A few hundred rows costs nothing.
    auto write_csv = [&](const std::vector<Row>& rows, bool announce = false) {
        Out o(outdir, "scan.csv");
        o.f << "impl,variant,source,xclbin,stimulus,events,tracks,rep,launches,"
               "tracks_per_call,us_stage,us_h2d,us_kernel,us_d2h,us_execute,us_total,"
               "us_call_min,us_call_med,us_call_p95,us_call_max,us_modelled,ii_ns,"
               "macs_per_track,in_bytes,out_bytes,mean_checksum,mode,notes\n";
        o.f.precision(9);
        for (const Row& r : rows) {
            o.f << "pl_fixed," << RTDA_VARIANT << ',' << (is_emu ? "hw_emu" : "hw")
                << ',' << xclbin << ',' << in_path << ','
                << r.events << ',' << r.tracks << ',' << r.rep << ',' << r.launches << ','
                << r.tracks_per_call << ','
                << r.us_stage << ',' << r.us_h2d << ',' << r.us_kernel << ','
                << r.us_d2h << ',' << r.us_execute << ',' << r.us_total << ','
                << r.call.mn << ',' << r.call.med << ',' << r.call.p95 << ',' << r.call.mx << ','
                // us_modelled and ii_ns are AIE concepts: they come from the AIE
                // graph's measured initiation interval. The PL fabric estimate is a
                // csynth number the host has no access to, so it stays empty here
                // and the notebook applies it from one place.
                << ',' << ','
                << MACS_PER_TRACK << ',' << r.in_bytes << ',' << r.out_bytes << ','
                << r.mean_checksum << ',' << r.mode << ',' << r.notes << '\n';
        }
        o.done(announce);
    };

    // Provenance, written BEFORE the first measurement. Everything in it is already
    // known, and a scan.csv that survives a hang is useless without the xclbin, the
    // revision and the once-paid costs beside it.
    { Out o(outdir, "scan_meta.txt");
      char stamp[64] = "unknown";
      const time_t now = time(nullptr);
      struct tm tmv;
      if (gmtime_r(&now, &tmv)) strftime(stamp, sizeof stamp, "%Y-%m-%dT%H:%M:%SZ", &tmv);
      struct utsname un;
      const bool have_un = uname(&un) == 0;

      o.f.precision(9);
      o.f << "impl=pl_fixed\n"
          << "variant=" << RTDA_VARIANT << "\n"
          << "source=" << (is_emu ? "hw_emu" : "hw") << "\n"
          << "xclbin=" << xclbin << "\n"
          << "kernel=rtda_split_top\n"
          // Read off the xclbin with `xclbinutil --info`, not asserted here: the
          // tracks_per_call fit is only interpretable against a known clock, and a
          // host-side constant would be a guess that survives a relink.
          << "kernel_clock_mhz=\n"
          << "stimulus=" << in_path << "\n"
          << "stimulus_tracks=" << rows << "\n"
          << "stimulus_events=" << max_events << "\n"
          << "us_stimulus_read=" << us_load << "\n"
          << "us_xclbin_open=" << us_open << "\n"
          << "us_rtp_load=\n"                    // AIE-only concept
          << "warmup=" << warmup << "\n"
          << "reps=" << reps << "\n"
          << "modes=" << modes_s << "\n"
          << "events_list=";
      for (std::size_t i = 0; i < ev_list.size(); i++)
          o.f << (i ? "," : "") << ev_list[i];
      o.f << "\ntpc_list=";
      for (std::size_t i = 0; i < tpc_list.size(); i++)
          o.f << (i ? "," : "") << tpc_list[i];
      o.f << "\ntpc_calls=" << tpc_calls << "\n"
          << "git_hash=" << RTDA_GIT_HASH << "\n"
          << "date_utc=" << stamp << "\n"
          << "uname=" << (have_un ? std::string(un.sysname) + " " + un.release + " " + un.machine
                                  : std::string("unknown")) << "\n";
      o.done(); }

    // ---- the event sweep --------------------------------------------------
    // One xrt::run held outside the loop for mode=reuse. Arguments are identical
    // every call (only the BO CONTENTS change), so set_arg happens once and the
    // per-call cost is start()+wait() and nothing else.
    for (long ev_count : ev_list) {
        for (int mi = 0; mi < 3; mi++) {
            const bool reuse  = (mi == 1);
            const bool single = (mi == 2);
            if (mi == 0 && !do_fresh)  continue;
            if (reuse  && !do_reuse)   continue;
            if (single && !do_single)  continue;

            for (long rep = 0; rep < reps; rep++) {
                double t_stage = 0, t_h2d = 0, t_krn = 0, t_d2h = 0;
                std::vector<double> series;
                series.reserve(ev_count);

                xrt::run r;
                if (reuse) {
                    r = xrt::run(kernel);
                    r.set_arg(0, bo_in);
                    r.set_arg(1, bo_mean);
                    r.set_arg(2, bo_out);
                    r.set_arg(3, (int)1);          // n_events: one per call here
                    r.set_arg(4, (int)N_TRACKS);   // tracks_per_event
                    r.set_arg(5, (int)warmup);
                    r.set_arg(6, (int)1);          // reset
                }

                const auto t_all0 = clk::now();
                if (single) {
                    // Every event staged, ONE sync, ONE kernel start. The whole
                    // point of this mode: the same shape as the AIE flow's
                    // single graph.run().
                    const auto ts0 = clk::now();
                    for (long ev = 0; ev < ev_count; ev++) {
                        const float* base = raw.data() + (size_t)ev * N_TRACKS * STRIDE;
                        float* dst = p_in + (size_t)ev * N_TRACKS * INPUT_SIZE;
                        for (int j = 0; j < N_TRACKS; j++)
                            for (int i = 0; i < INPUT_SIZE; i++)
                                dst[j * INPUT_SIZE + i] = base[j * STRIDE + i];
                    }
                    const auto t0 = clk::now();
                    bo_in.sync(XCL_BO_SYNC_BO_TO_DEVICE);
                    const auto t1 = clk::now();
                    auto run = kernel(bo_in, bo_mean, bo_out,
                                      (int)ev_count, (int)N_TRACKS, (int)warmup, (int)1);
                    run.wait();
                    const auto t2 = clk::now();
                    bo_mean.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
                    bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
                    const auto t3 = clk::now();

                    t_stage = us(t0 - ts0);
                    t_h2d   = us(t1 - t0);
                    t_krn   = us(t2 - t1);
                    t_d2h   = us(t3 - t2);
                    series.push_back(us(t2 - t1));   // one call, so one sample
                } else {
                    for (long ev = 0; ev < ev_count; ev++) {
                        const auto ts0 = clk::now();
                        const float* base = raw.data() + (size_t)ev * N_TRACKS * STRIDE;
                        for (int j = 0; j < N_TRACKS; j++)
                            for (int i = 0; i < INPUT_SIZE; i++)
                                p_in[j * INPUT_SIZE + i] = base[j * STRIDE + i];
                        const auto t0 = clk::now();
                        bo_in.sync(XCL_BO_SYNC_BO_TO_DEVICE);
                        const auto t1 = clk::now();
                        if (reuse) {
                            r.start();
                            r.wait();
                        } else {
                            // reset=1: every event starts from a zero roll history, so
                            // events are independent of what ran before. Same call
                            // host_split.cpp makes, so the numbers are comparable.
                            auto run = kernel(bo_in, bo_mean, bo_out,
                                              (int)1, (int)N_TRACKS, (int)warmup, (int)1);
                            run.wait();
                        }
                        const auto t2 = clk::now();
                        bo_mean.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
                        bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
                        const auto t3 = clk::now();

                        t_stage += us(t0 - ts0);
                        t_h2d   += us(t1 - t0);
                        t_krn   += us(t2 - t1);
                        t_d2h   += us(t3 - t2);
                        series.push_back(us(t2 - t1));
                    }
                }
                const double t_total = us(clk::now() - t_all0);

                // Cheap smoke value. NOT an accuracy number -- it exists so that
                // "the kernel returned zeros" cannot be read as a very fast run.
                // The LAST event's mean, in both shapes. Per-event calls leave it
                // at offset 0 because every call overwrites the same 128 floats;
                // the single call leaves all ev_count of them side by side, so
                // reading offset 0 there would checksum the FIRST event and the
                // two modes would disagree for no reason.
                const float* chk_row = single ? p_mean + (size_t)(ev_count - 1) * HIDDEN
                                              : p_mean;
                double chk = 0;
                for (int k = 0; k < HIDDEN; k++) chk += chk_row[k];

                Row row;
                row.events = ev_count;
                row.tracks = ev_count * N_TRACKS;
                row.rep = rep;
                row.launches = single ? 1 : ev_count;
                row.tracks_per_call = single ? ev_count * N_TRACKS : N_TRACKS;
                row.us_stage = t_stage;
                row.us_h2d = t_h2d;
                row.us_kernel = t_krn;
                row.us_d2h = t_d2h;
                row.us_execute = t_h2d + t_krn + t_d2h;
                row.us_total = t_total;
                row.call = stats_of(series);
                row.in_bytes = ev_count * N_TRACKS * INPUT_SIZE * (long)sizeof(float);
                row.out_bytes = ev_count * (HIDDEN + OUT_DIM) * (long)sizeof(float);
                row.mean_checksum = chk;
                row.mode = single ? "single" : (reuse ? "reuse" : "fresh");
                out_rows.push_back(row);

                std::cout << "[scan] " << std::setw(6) << ev_count << " ev  "
                          << std::setw(5) << row.mode << "  rep " << rep << "  "
                          << std::fixed << std::setprecision(1)
                          << (t_total / 1e3) << " ms total, "
                          << std::setprecision(3) << (t_total / row.tracks) << " us/track, "
                          << "call med " << row.call.med << " us\n" << std::defaultfloat;

                if (ev_count == ev_max && rep == 0 && mi == 0) {   // fresh only
                    dump_series = series;
                    dump_events = ev_count;
                }
                write_csv(out_rows);
            }
        }
    }

    // ---- tracks-per-call sweep -------------------------------------------
    // Last, deliberately: it is the only part that drives the kernel outside the
    // 50-track shape everything else has exercised, so the event sweep is already
    // recorded by the time it runs.
    for (long tpc : tpc_list) {
        std::vector<double> series;
        series.reserve(tpc_calls);
        double t_stage = 0, t_h2d = 0, t_krn = 0, t_d2h = 0;

        const auto t_all0 = clk::now();
        for (long c = 0; c < tpc_calls; c++) {
            const auto ts0 = clk::now();
            for (long j = 0; j < tpc; j++)
                for (int i = 0; i < INPUT_SIZE; i++)
                    p_in[j * INPUT_SIZE + i] = raw[(size_t)j * STRIDE + i];
            const auto t0 = clk::now();
            bo_in.sync(XCL_BO_SYNC_BO_TO_DEVICE);
            const auto t1 = clk::now();
            // n_events=1: this mode deliberately drives ONE call over `tpc`
            // tracks, producing a single mean. It is a timing probe, not an
            // event sweep -- hence events=0 on the row it writes.
            auto run = kernel(bo_in, bo_mean, bo_out,
                              (int)1, (int)tpc, (int)warmup, (int)1);
            run.wait();
            const auto t2 = clk::now();
            bo_mean.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
            bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
            const auto t3 = clk::now();
            t_stage += us(t0 - ts0);
            t_h2d   += us(t1 - t0);
            t_krn   += us(t2 - t1);
            t_d2h   += us(t3 - t2);
            series.push_back(us(t2 - t1));
        }
        const double t_total = us(clk::now() - t_all0);

        double chk = 0;
        for (int k = 0; k < HIDDEN; k++) chk += p_mean[k];

        Row row;
        row.events = 0;                  // not events -- see notes
        row.tracks = tpc_calls * tpc;
        row.rep = 0;
        row.launches = tpc_calls;
        row.tracks_per_call = tpc;
        row.us_stage = t_stage;
        row.us_h2d = t_h2d;
        row.us_kernel = t_krn;
        row.us_d2h = t_d2h;
        row.us_execute = t_h2d + t_krn + t_d2h;
        row.us_total = t_total;
        row.call = stats_of(series);
        row.in_bytes = tpc_calls * tpc * INPUT_SIZE * (long)sizeof(float);
        row.out_bytes = tpc_calls * (HIDDEN + OUT_DIM) * (long)sizeof(float);
        row.mean_checksum = chk;
        row.mode = "tpc";
        row.notes = "timing only: the 128-wide mean is not an event mean at this track count";
        out_rows.push_back(row);

        std::cout << "[scan] tpc " << std::setw(5) << tpc << "  " << tpc_calls
                  << " calls  call med " << std::fixed << std::setprecision(1)
                  << row.call.med << " us  -> " << std::setprecision(2)
                  << (row.call.med / tpc) << " us/track\n" << std::defaultfloat;
        write_csv(out_rows);
    }

    write_csv(out_rows, true);   // idempotent; also covers the no-points-at-all case

    if (dump_calls && !dump_series.empty()) {
        Out o(outdir, "scan_calls_" + std::to_string(dump_events) + ".csv");
        o.f << "impl,events,mode,call,us_kernel\n";
        o.f.precision(9);
        for (std::size_t i = 0; i < dump_series.size(); i++)
            o.f << "pl_fixed," << dump_events << ",fresh," << i << ',' << dump_series[i] << '\n';
        o.done();
    }

    std::cout << "[scan] " << out_rows.size() << " rows\n";
    return 0;
}
