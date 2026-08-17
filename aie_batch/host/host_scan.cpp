// ===========================================================================
//  Performance scan host for the batched aie::mmul RTDA design.
//
//  host_batch.exe answers "is it correct and how fast overall". This answers
//  "where does the time go, and how does it scale". It sweeps event counts with
//  repeats and writes ONLY performance files:
//
//      scan.csv        one row per (event count, launches, repeat)
//      scan_meta.txt   the one-time costs and the provenance
//
//  It deliberately writes NO track_means_all.txt, NO track_mean_128.txt, NO
//  track_out_27.txt and NO run_info.txt. A timing run must not be able to land in
//  results/aie_<p>/hw/ and be read as a result run.
//
//  One binary serves fp32 and bf16, exactly as host_batch.exe does: the input
//  dtype, the precision label and the initiation interval all come from
//  sysdata/config.txt at run time.
//
//  WHAT THIS CAN AND CANNOT SEPARATE
//  There is no honest H2D / D2H split for this design, and pretending otherwise
//  would be the most misleading thing this file could do. host_batch.cpp:367-370
//  says why: input DMA, compute and output DMA overlap because the graph consumes
//  x as it arrives, and waiting on the input transfer before graph.run() deadlocks
//  -- nothing drains the shim DMA until the graph is running. So what is recorded
//  is the decomposition that actually exists:
//
//      us_stage    host-side: build the padded slot layout in the BO, and for
//                  bf16 convert it. Not device time at all.
//      us_h2d      time to ISSUE the two async transfers. Not the transfer.
//      us_kernel   graph.run(n_iter) + graph.wait().
//      us_d2h      out_run.wait() AFTER graph.wait() -- the un-overlapped tail of
//                  the output DMA. The closest thing to a D2H number here.
//      us_execute  the three device phases together, so it stays comparable with
//                  host_batch.exe's us_execute.
//      us_modelled ii_ns * total iterations, from config.txt. us_execute minus
//                  this is the launch and DMA overhead, and watching it fall as
//                  events grow is the amortisation curve.
//
//  THE LAUNCH AXIS
//  ~583 us is paid once per graph.run() regardless of size, which is why one event
//  costs 12.7 us/track and 10,000 tracks cost 0.658. Rather than infer that cost
//  from a curve, this host measures it: `launches` splits the same event count
//  across N graph.run() calls, each with its OWN prepended flush event, each
//  issued at its own offset into the same pair of BOs. launches=1 is exactly what
//  host_batch.exe does, so those rows are directly comparable.
//
//  Environment (all optional -- with none set it runs the full default sweep,
//  bounded by whatever stimulus it finds):
//
//      RTDA_INPUT        stimulus path (default: probes the packaged locations)
//      RTDA_OUTDIR       where to write (default: first writable of . then /tmp)
//      RTDA_SCAN_EVENTS  comma list, default 1,10,100,1000,10000
//                        clipped to what the stimulus can supply
//      RTDA_SCAN_REPS    repeats per point, default 5
//      RTDA_SCAN_SPLITS  comma list of launch counts, default 1,10. A split is
//                        skipped where it does not divide the event count.
//      RTDA_II_NS        override the modelled initiation interval
//
//  SETTING THOSE UNDER QEMU: launch_hw_emu.sh -run-app forwards ARGUMENTS into the
//  guest but not the ENVIRONMENT, and the default sweep in RTL simulation is
//  hours. So any argument containing '=' is applied as an environment assignment
//  before anything is read:
//
//      ./host_scan.exe system_hw_emu.xclbin RTDA_SCAN_REPS=1 RTDA_SCAN_SPLITS=1
//
//  Arguments WITHOUT '=' fill the positional slots in order: xclbin, sysdata.
//
//  NOTE ON DUPLICATION: the RTP loader, the bf16 converter and the config reader
//  below are copies of host_batch.cpp's. They were copied rather than shared
//  because refactoring host_batch.cpp means rebuilding the binary that produced
//  the published accuracy numbers, and this is a performance tool. Both copies
//  read the same manifest written by extract_rtp.py, so a format change breaks
//  both loudly (short read / unexpected RTP length) rather than silently -- but if
//  you touch one, touch the other.
// ===========================================================================

#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <dirent.h>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <unistd.h>
#include <vector>

#include <sys/utsname.h>
#include <time.h>

#include "xrt/xrt_device.h"
#include "xrt/xrt_graph.h"
#include "xrt/xrt_kernel.h"
#include "experimental/xrt_aie.h"

namespace {

// Geometry -- must match the compiled graph.
constexpr int BATCH            = 8;    // tracks per graph iteration
constexpr int ITER_PER_EVENT   = 7;    // 7 * 8 = 56 slots per event
constexpr int TRACKS_PER_EVENT = 50;   // real tracks; the other 6 slots are padding
constexpr int SLOTS_PER_EVENT  = ITER_PER_EVENT * BATCH;   // 56
constexpr int IN_DIM           = 16;   // padded embed input width
constexpr int HIDDEN           = 128;  // graph output width (the event mean)
constexpr int RAW_IN           = 8;    // values per track in embed_input.txt
constexpr long MACS_PER_TRACK  = 264192L;

using clk = std::chrono::steady_clock;
double us(clk::duration d) { return std::chrono::duration<double, std::micro>(d).count(); }

std::string join(const std::string& base, const std::string& rel)
{
    if (base.empty()) return rel;
    return base.back() == '/' ? base + rel : base + "/" + rel;
}

const char* env_or(const char* k, const char* dflt)
{
    const char* v = std::getenv(k);
    return (v && *v) ? v : dflt;
}

// On a board there is no debugger and a rebuild costs hours, so say everything
// useful at once: what was wanted, every path tried, where we are, what is here.
std::string first_existing(const std::vector<std::string>& cands, const std::string& what)
{
    for (const auto& c : cands) {
        std::ifstream f(c);
        if (f.good()) return c;
    }
    std::string msg = "cannot locate " + what + "\n  tried, in order:\n";
    for (const auto& c : cands) msg += "    " + c + "\n";
    char cwd[4096] = {0};
    if (getcwd(cwd, sizeof cwd)) msg += "  working directory: " + std::string(cwd) + "\n";
    msg += "  what is here:\n";
    if (DIR* d = opendir(".")) {
        int n = 0;
        while (dirent* e = readdir(d)) {
            const std::string nm = e->d_name;
            if (nm == "." || nm == "..") continue;
            msg += "    " + nm + "\n";
            if (++n >= 30) { msg += "    ...\n"; break; }
        }
        closedir(d);
    }
    throw std::runtime_error(msg);
}

// The SD card's FAT partition is frequently mounted read-only, and the scan has
// already run by the time anything is written.
std::string first_writable(const std::vector<std::string>& cands)
{
    for (const auto& c : cands) {
        const std::string probe = c + "/.rtda_write_test";
        std::ofstream f(probe);
        if (f.good()) { f.close(); std::remove(probe.c_str()); return c; }
    }
    return ".";
}

std::vector<float> read_text(const std::string& path)
{
    std::ifstream f(path);
    if (!f) throw std::runtime_error("cannot open " + path);
    std::vector<float> v;
    float x;
    while (f >> x) v.push_back(x);
    return v;
}

std::vector<char> read_bin(const std::string& path, std::size_t n_bytes)
{
    std::ifstream f(path, std::ios::binary);
    if (!f) throw std::runtime_error("cannot open " + path);
    std::vector<char> v(n_bytes);
    f.read(v.data(), static_cast<std::streamsize>(n_bytes));
    if (static_cast<std::size_t>(f.gcount()) != n_bytes)
        throw std::runtime_error(path + ": short read");
    return v;
}

// xrt::graph::update() forwards sizeof(arg) to update_port(), so the argument must
// be a type whose sizeof IS the payload -- a std::vector would send 24 bytes.
template<typename T, std::size_t N>
struct alignas(64) aligned_array { T elems[N]; };

template<typename T, std::size_t N>
void update_n(xrt::graph& g, const std::string& port, const std::vector<char>& raw)
{
    aligned_array<T, N> a{};
    std::memcpy(a.elems, raw.data(), N * sizeof(T));
    g.update(port, a);
}

template<typename T>
void update_typed(xrt::graph& g, const std::string& port, std::size_t n,
                  const std::vector<char>& raw)
{
    switch (n) {
        case   64: update_n<T,   64>(g, port, raw); break;
        case  128: update_n<T,  128>(g, port, raw); break;
        case 2048: update_n<T, 2048>(g, port, raw); break;
        case 4096: update_n<T, 4096>(g, port, raw); break;
        default:
            throw std::runtime_error(port + ": unexpected RTP length " +
                                     std::to_string(n) + " elements; add a case here");
    }
}

// A bf16 design has uint16 weights and float32 biases side by side, so the element
// type is per port and comes from the manifest, not from the build.
void update_rtp(xrt::graph& g, const std::string& port, const std::string& dtype,
                std::size_t n, const std::vector<char>& raw)
{
    if (dtype == "u16")      update_typed<std::uint16_t>(g, port, n, raw);
    else if (dtype == "f32") update_typed<float>(g, port, n, raw);
    else throw std::runtime_error(port + ": unknown RTP dtype '" + dtype + "'");
}

// Round half to even, matching aie4ml's weight conversion. Truncation is 2x the
// error and biases every value toward zero, which does not cancel across a network.
std::uint16_t f32_to_bf16(float f)
{
    std::uint32_t u;
    std::memcpy(&u, &f, sizeof u);
    return static_cast<std::uint16_t>((u + 0x7FFFu + ((u >> 16) & 1u)) >> 16);
}

std::string read_config(const std::string& path, const std::string& key,
                        const std::string& fallback)
{
    std::ifstream f(path);
    if (!f) return fallback;
    std::string line;
    while (std::getline(f, line)) {
        const auto eq = line.find('=');
        if (eq != std::string::npos && line.substr(0, eq) == key)
            return line.substr(eq + 1);
    }
    return fallback;
}

struct RtpEntry { std::string port; std::size_t n; std::string dtype; std::string file; };

std::vector<RtpEntry> read_manifest(const std::string& path)
{
    std::ifstream f(path);
    if (!f) throw std::runtime_error("cannot open " + path);
    std::vector<RtpEntry> out;
    std::string line;
    while (std::getline(f, line)) {
        if (line.empty() || line[0] == '#') continue;
        std::istringstream is(line);
        RtpEntry e;
        std::string a, b;
        if (!(is >> e.port >> e.n >> a)) continue;
        if (is >> b) { e.dtype = a; e.file = b; }        // 4-column form
        else         { e.dtype = "f32"; e.file = a; }    // legacy 3-column, fp32
        out.push_back(e);
    }
    return out;
}

std::vector<long> parse_list(const std::string& s)
{
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

// Every write is checked. A full SD partition once produced 0-byte output files
// while the host reported success.
struct Out {
    std::ofstream f;
    std::string name;
    Out(const std::string& dir, const std::string& n) : name(join(dir, n)) {
        f.open(name);
        if (!f) throw std::runtime_error("cannot open " + name + " for writing");
    }
    // announce=false for the per-point rewrites of scan.csv, which would otherwise
    // print a line for every measured point.
    void done(bool announce = true) {
        f.flush();
        if (!f) throw std::runtime_error("write failed for " + name + " (disk full?)");
        f.close();
        if (f.fail()) throw std::runtime_error("close failed for " + name);
        if (announce) std::cout << "[scan] wrote " << name << std::endl;
    }
};

struct Row {
    long events = 0, tracks = 0, rep = 0, launches = 0, iterations = 0;
    double us_stage = 0, us_h2d = 0, us_kernel = 0, us_d2h = 0, us_execute = 0, us_total = 0;
    double us_modelled = 0;
    long in_bytes = 0, out_bytes = 0;
    double mean_checksum = 0;
    std::string notes;
};

// Arguments of the form KEY=VALUE become environment variables; everything else is
// returned as a positional argument. See the note about QEMU in the header.
std::vector<std::string> absorb_env_args(int argc, char** argv)
{
    std::vector<std::string> positional;
    for (int i = 1; i < argc; i++) {
        const char* eq = std::strchr(argv[i], '=');
        if (eq && eq != argv[i]) {
            const std::string k(argv[i], eq - argv[i]);
            setenv(k.c_str(), eq + 1, 1);
            std::cout << "[scan] " << k << "=" << (eq + 1) << " (from argv)" << std::endl;
        } else {
            positional.push_back(argv[i]);
        }
    }
    return positional;
}

} // namespace

int main(int argc, char** argv)
{
    try {
        const auto pos = absorb_env_args(argc, argv);

        std::string xclbin = !pos.empty() ? pos[0]
                                          : first_existing({"system_hw.xclbin",
                                                            "system_hw_emu.xclbin"},
                                                           "an xclbin");
        const bool is_emu = xclbin.find("hw_emu") != std::string::npos;

        std::string sysdata;
        if (pos.size() > 1) sysdata = pos[1];
        else {
            auto p = first_existing({"sysdata/rtp_manifest.txt",
                                     "sd_batch/sysdata/rtp_manifest.txt"}, "sysdata");
            sysdata = p.substr(0, p.rfind('/'));
        }

        std::string in_file = env_or("RTDA_INPUT", "");
        if (in_file.empty())
            in_file = first_existing({"sd_batch/testdata/embed_input_500000.txt",
                                      "sd_batch/testdata/embed_input_50000.txt",
                                      "testdata/embed_input_500000.txt",
                                      "testdata/embed_input_50000.txt",
                                      "../testdata/embed_input_500000.txt",
                                      "../testdata/embed_input_50000.txt"},
                                     "a stimulus file");

        const std::string outdir = first_writable({env_or("RTDA_OUTDIR", "."), "/tmp"});
        const long reps = std::max(1L, std::atol(env_or("RTDA_SCAN_REPS", "5")));
        std::vector<long> ev_list =
            parse_list(env_or("RTDA_SCAN_EVENTS", "1,10,100,1000,10000"));
        std::vector<long> split_list = parse_list(env_or("RTDA_SCAN_SPLITS", "1,10"));
        if (split_list.empty()) split_list.push_back(1);

        // ---- device + graph, once ------------------------------------------
        const auto t0 = clk::now();
        xrt::device device(0);
        auto uuid = device.load_xclbin(xclbin);
        xrt::graph graph(device, uuid, "dut");
        const double us_open = us(clk::now() - t0);

        // ---- RTP weights, once --------------------------------------------
        const auto t_rtp0 = clk::now();
        const auto manifest = read_manifest(join(sysdata, "rtp_manifest.txt"));
        if (manifest.empty()) throw std::runtime_error("empty RTP manifest");
        std::size_t rtp_bytes = 0;
        for (const auto& e : manifest) {
            const std::size_t esz = (e.dtype == "u16") ? 2u : 4u;
            auto payload = read_bin(join(sysdata, e.file), e.n * esz);
            update_rtp(graph, e.port, e.dtype, e.n, payload);
            rtp_bytes += e.n * esz;
        }
        const double us_rtp = us(clk::now() - t_rtp0);

        const std::string cfg = join(sysdata, "config.txt");
        const std::string precision = read_config(cfg, "precision", "fp32");
        const std::string in_dtype  = read_config(cfg, "input_dtype", "float32");
        const bool in_bf16 = (in_dtype == "bfloat16");
        const std::size_t in_esz = in_bf16 ? 2u : 4u;
        const double ii_ns = std::atof(env_or("RTDA_II_NS",
                                              read_config(cfg, "ii_ns", "0").c_str()));
        const std::string impl = "aie_" + precision;

        // ---- stimulus ------------------------------------------------------
        const auto t_load0 = clk::now();
        auto raw = read_text(in_file);
        const double us_load = us(clk::now() - t_load0);
        const long file_tracks = static_cast<long>(raw.size() / RAW_IN);
        const long max_events = file_tracks / TRACKS_PER_EVENT;
        if (max_events < 1)
            throw std::runtime_error("stimulus has fewer than one complete event");

        // Under emulation, cap the default sweep HARD.
        //
        // sd_stage copies the whole of testdata/ onto the card, hw_emu included,
        // so the 500,000-track stimulus is there and the probe above prefers it.
        // In RTL simulation the 10,000-event point is not slow, it is unbounded --
        // you come back the next morning to a QEMU still running. An explicit
        // RTDA_SCAN_EVENTS overrides this; the cap only replaces the DEFAULT.
        if (is_emu && std::getenv("RTDA_SCAN_EVENTS") == nullptr) {
            ev_list = {1, 2};
            std::cout << "[scan] EMULATION: default sweep capped to 1,2 events.\n"
                         "[scan]   RTL simulation makes the 10,000-event point unbounded.\n"
                         "[scan]   Set RTDA_SCAN_EVENTS=... to override." << std::endl;
        }

        // Clip to what the data supports and drop duplicates: run the largest
        // honest sweep the data allows rather than refusing.
        {
            std::vector<long> keep;
            for (long e : ev_list) keep.push_back(std::min(e, max_events));
            std::sort(keep.begin(), keep.end());
            keep.erase(std::unique(keep.begin(), keep.end()), keep.end());
            ev_list = keep;
        }
        if (ev_list.empty()) throw std::runtime_error("no event counts left to run");

        std::cout << "[scan] xclbin  = " << xclbin << (is_emu ? "  (EMULATION)" : "") << "\n"
                  << "[scan] sysdata = " << sysdata << "  precision=" << precision
                  << "  input_dtype=" << in_dtype << "  ii_ns=" << ii_ns << "\n"
                  << "[scan] RTP     = " << manifest.size() << " ports, "
                  << rtp_bytes / 1024 << " KB in " << (us_rtp / 1e3) << " ms\n"
                  << "[scan] input   = " << in_file << "  (" << file_tracks << " tracks, "
                  << max_events << " events max, read in " << (us_load / 1e6) << " s)\n"
                  << "[scan] events  =";
        for (long e : ev_list) std::cout << ' ' << e;
        std::cout << "   splits =";
        for (long s : split_list) std::cout << ' ' << s;
        std::cout << "   reps=" << reps << "\n[scan] outdir  = " << outdir << std::endl;

        // ---- buffers, once -------------------------------------------------
        // Sized for the largest (events, splits) combination in the sweep. Each
        // launch carries its own flush event, so total iterations grow with the
        // split count: (events + splits) * ITER_PER_EVENT. Allocating once keeps
        // allocator time out of the measurement, and a 36 MB allocation retried at
        // every point is exactly the kind of thing that would show up as a
        // mysterious per-point cost.
        long max_iters = 0;
        for (long ev : ev_list)
            for (long s : split_list)
                if (ev % s == 0) max_iters = std::max(max_iters, (ev + s) * ITER_PER_EVENT);
        const std::size_t max_in_bytes  = (std::size_t)max_iters * BATCH * IN_DIM * in_esz;
        const std::size_t max_out_bytes = (std::size_t)max_iters * HIDDEN * sizeof(float);
        std::cout << "[scan] BOs: in " << max_in_bytes / (1024 * 1024) << " MB, out "
                  << max_out_bytes / (1024 * 1024) << " MB (" << max_iters
                  << " iterations worst case)" << std::endl;

        auto in_bo  = xrt::aie::bo(device, max_in_bytes,  xrt::bo::flags::normal, 0);
        auto out_bo = xrt::aie::bo(device, max_out_bytes, xrt::bo::flags::normal, 0);
        auto* in_f32 = in_bf16 ? nullptr : in_bo.map<float*>();
        auto* in_u16 = in_bf16 ? in_bo.map<std::uint16_t*>() : nullptr;
        const float* out = out_bo.map<float*>();

        std::vector<Row> out_rows;

        // Rewritten after EVERY point rather than once at the end. The 10,000-event
        // point allocates 36 MB BOs on the stock ZOCL CMA pool and is the plausible
        // place for this to die; losing the four points that already succeeded to
        // that would be gratuitous.
        auto write_csv = [&](const std::vector<Row>& rows, bool announce = false) {
          Out o(outdir, "scan.csv");
          o.f << "impl,variant,source,xclbin,stimulus,events,tracks,rep,launches,"
                 "tracks_per_call,us_stage,us_h2d,us_kernel,us_d2h,us_execute,us_total,"
                 "us_call_min,us_call_med,us_call_p95,us_call_max,us_modelled,ii_ns,"
                 "macs_per_track,in_bytes,out_bytes,mean_checksum,mode,notes\n";
          o.f.precision(9);
          for (const Row& r : rows) {
              o.f << impl << ',' << precision << ',' << (is_emu ? "hw_emu" : "hw") << ','
                  << xclbin << ',' << in_file << ','
                  << r.events << ',' << r.tracks << ',' << r.rep << ',' << r.launches << ','
                  // tracks_per_call: the AIE processes BATCH tracks per graph
                  // iteration, which is structural, not a runtime choice like the PL
                  // kernel's n_tracks. Reported so the column means the same thing in
                  // both files: tracks per device invocation.
                  << (r.tracks / r.launches) << ','
                  << r.us_stage << ',' << r.us_h2d << ',' << r.us_kernel << ','
                  << r.us_d2h << ',' << r.us_execute << ',' << r.us_total << ','
                  // us_call_*: the PL host calls the kernel once per event and can
                  // report a distribution. Here one launch covers many events, so
                  // there is no per-call series to summarise -- the launch axis is
                  // the equivalent measurement.
                  << ',' << ',' << ',' << ','
                  << r.us_modelled << ',' << ii_ns << ','
                  << MACS_PER_TRACK << ',' << r.in_bytes << ',' << r.out_bytes << ','
                  << r.mean_checksum << ',' << "gmio" << ',' << r.notes << '\n';
          }
          o.done(announce);
        };

        // Provenance, written BEFORE the first measurement: everything in it is
        // already known, and a scan.csv that survives a failure is useless without
        // the xclbin, the revision and the once-paid costs beside it.
        { Out o(outdir, "scan_meta.txt");
          char stamp[64] = "unknown";
          const time_t now = time(nullptr);
          struct tm tmv;
          if (gmtime_r(&now, &tmv)) strftime(stamp, sizeof stamp, "%Y-%m-%dT%H:%M:%SZ", &tmv);
          struct utsname un;
          const bool have_un = uname(&un) == 0;

          o.f.precision(9);
          o.f << "impl=" << impl << "\n"
              << "variant=" << precision << "\n"
              << "source=" << (is_emu ? "hw_emu" : "hw") << "\n"
              << "xclbin=" << xclbin << "\n"
              << "graph=dut\n"
              << "input_dtype=" << in_dtype << "\n"
              << "ii_ns=" << ii_ns << "\n"
              << "kernel_clock_mhz=\n"          // the AIE array clock, not a PL clock
              << "sysdata=" << sysdata << "\n"
              << "rtp_ports=" << manifest.size() << "\n"
              << "rtp_bytes=" << rtp_bytes << "\n"
              << "stimulus=" << in_file << "\n"
              << "stimulus_tracks=" << file_tracks << "\n"
              << "stimulus_events=" << max_events << "\n"
              << "us_stimulus_read=" << us_load << "\n"
              << "us_xclbin_open=" << us_open << "\n"
              << "us_rtp_load=" << us_rtp << "\n"
              << "reps=" << reps << "\n"
              << "events_list=";
          for (std::size_t i = 0; i < ev_list.size(); i++)
              o.f << (i ? "," : "") << ev_list[i];
          o.f << "\nsplits_list=";
          for (std::size_t i = 0; i < split_list.size(); i++)
              o.f << (i ? "," : "") << split_list[i];
          o.f << "\nmacs_per_track=" << MACS_PER_TRACK << "\n"
              << "git_hash=" << RTDA_GIT_HASH << "\n"
              << "date_utc=" << stamp << "\n"
              << "uname=" << (have_un ? std::string(un.sysname) + " " + un.release + " " + un.machine
                                      : std::string("unknown")) << "\n";
          o.done(); }

        for (long ev_count : ev_list) {
            for (long split : split_list) {
                if (ev_count % split != 0) continue;      // no ragged last launch
                const long ev_per = ev_count / split;
                const long iters_per = (ev_per + 1) * ITER_PER_EVENT;   // +1 flush event
                const long iters_tot = iters_per * split;
                const std::size_t in_bytes_per  =
                    (std::size_t)iters_per * BATCH * IN_DIM * in_esz;
                const std::size_t out_bytes_per =
                    (std::size_t)iters_per * HIDDEN * sizeof(float);

                for (long rep = 0; rep < reps; rep++) {
                    const auto t_all0 = clk::now();

                    // ---- stage -------------------------------------------
                    // Each launch block is: one all-zero flush event, then ev_per
                    // events padded INDIVIDUALLY to 56 slots. Events cannot be
                    // concatenated: the accumulator stops counting at 50 and skips
                    // the rest of the block, so a short block swallows the next
                    // event's first tracks. The flush event exists because
                    // roll_concat_batch's carry is a static initialised at ELF
                    // load, not at graph.run() -- without it the first event of a
                    // warm run differs by ~2.5e-3, and every repeat here is warm.
                    const auto ts0 = clk::now();
                    const std::size_t used_elems =
                        (std::size_t)iters_tot * BATCH * IN_DIM;
                    if (in_bf16) std::memset(in_u16, 0, used_elems * sizeof(std::uint16_t));
                    else         std::memset(in_f32, 0, used_elems * sizeof(float));
                    for (long l = 0; l < split; l++) {
                        const std::size_t block = (std::size_t)l * iters_per * BATCH;
                        for (long e = 0; e < ev_per; e++) {
                            const long g_ev = l * ev_per + e;
                            for (int idx = 0; idx < TRACKS_PER_EVENT; idx++) {
                                const std::size_t slot =
                                    block + (std::size_t)(1 + e) * SLOTS_PER_EVENT + idx;
                                const float* src =
                                    raw.data() + (std::size_t)(g_ev * TRACKS_PER_EVENT + idx) * RAW_IN;
                                for (int k = 0; k < RAW_IN; k++) {
                                    const std::size_t d = slot * IN_DIM + k;
                                    if (in_bf16) in_u16[d] = f32_to_bf16(src[k]);
                                    else         in_f32[d] = src[k];
                                }
                            }
                        }
                    }
                    const double t_stage = us(clk::now() - ts0);

                    // ---- execute -----------------------------------------
                    double t_h2d = 0, t_krn = 0, t_d2h = 0;
                    for (long l = 0; l < split; l++) {
                        const std::size_t in_off  = (std::size_t)l * in_bytes_per;
                        const std::size_t out_off = (std::size_t)l * out_bytes_per;

                        const auto e0 = clk::now();
                        in_bo.async("dut.gmio_x", XCL_BO_SYNC_BO_GMIO_TO_AIE,
                                    in_bytes_per, in_off);
                        auto out_run = out_bo.async("dut.gmio_track",
                                                    XCL_BO_SYNC_BO_AIE_TO_GMIO,
                                                    out_bytes_per, out_off);
                        const auto e1 = clk::now();
                        graph.run(static_cast<int>(iters_per));
                        graph.wait();
                        const auto e2 = clk::now();
                        out_run.wait();
                        const auto e3 = clk::now();

                        t_h2d += us(e1 - e0);
                        t_krn += us(e2 - e1);
                        t_d2h += us(e3 - e2);
                    }
                    const double t_total = us(clk::now() - t_all0);

                    // Smoke value, NOT an accuracy number: the last event's mean
                    // lands in the final frame of the final launch block. If the
                    // graph produced nothing this is 0, which is the one failure a
                    // timing-only run would otherwise report as very fast.
                    double chk = 0;
                    const std::size_t last = (std::size_t)(iters_tot - 1) * HIDDEN;
                    for (int k = 0; k < HIDDEN; k++) chk += out[last + k];

                    Row r;
                    r.events = ev_count;
                    r.tracks = ev_count * TRACKS_PER_EVENT;
                    r.rep = rep;
                    r.launches = split;
                    r.iterations = iters_tot;
                    r.us_stage = t_stage;
                    r.us_h2d = t_h2d;
                    r.us_kernel = t_krn;
                    r.us_d2h = t_d2h;
                    r.us_execute = t_h2d + t_krn + t_d2h;
                    r.us_total = t_total;
                    r.us_modelled = ii_ns * 1e-3 * iters_tot;
                    r.in_bytes = (long)(in_bytes_per * split);
                    r.out_bytes = (long)(out_bytes_per * split);
                    r.mean_checksum = chk;
                    if (chk == 0.0) r.notes = "checksum zero: graph produced no output";
                    out_rows.push_back(r);

                    std::cout << "[scan] " << std::setw(6) << ev_count << " ev  "
                              << std::setw(3) << split << " launch  rep " << rep << "  "
                              << std::fixed << std::setprecision(3)
                              << (r.us_execute / 1e3) << " ms exec, "
                              << (r.us_execute / r.tracks) << " us/track, overhead "
                              << std::setprecision(1)
                              << (r.us_modelled > 0
                                    ? 100.0 * (r.us_execute - r.us_modelled) / r.us_execute
                                    : 0.0)
                              << "%" << std::defaultfloat << std::endl;
                    write_csv(out_rows);
                }
            }
        }

        // Final rewrite: idempotent, announces the file, and covers the case
        // where the sweep produced no points at all.
        write_csv(out_rows, true);

        std::cout << "[scan] " << out_rows.size() << " rows" << std::endl;
        return 0;
    }
    catch (const std::exception& e) {
        std::cerr << "\nERROR: " << e.what() << std::endl;
        return 1;
    }
}
