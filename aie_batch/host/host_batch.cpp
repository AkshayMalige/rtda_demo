// XRT host for aieml_batch — the batched aie::mmul RTDA MLP.
//
// Differences from host/host.cpp (the aieml/ host):
//   * no PL kernel. track_average_pl is gone: the track average is an AIE kernel
//     now, so there is nothing to xrt::kernel and no stream to drain.
//   * one GMIO in, one GMIO out. The graph takes the padded track block and
//     returns the 128-wide event mean.
//   * 92 RTP ports instead of 47, loaded from binaries produced by
//     aieml_batch/extract_rtp.py. Port names come from the graph metadata, not
//     from a naming rule: the bias port is in[2] on single-kernel layers and
//     in[3] on cascaded ones.
//
// The output dense (128 -> 27) is applied here, exactly as host/host.cpp:394
// does, because on AIE it is an M=1 GEMV and measured 15-19 us per event —
// more than the entire 14-layer pipeline. See aieml_batch/README.md.

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <dirent.h>
#include <unistd.h>
#include <iomanip>
#include <iostream>
#include <limits>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>
#include <chrono>
#include <cstdlib>

#include "xrt/xrt_device.h"
#include "xrt/xrt_graph.h"
#include "xrt/xrt_kernel.h"
#include "experimental/xrt_aie.h"

namespace {

// Geometry — must match the compiled graph (src/parameters.h N_ITER and
// kernels/track_accum/track_accum.h).
constexpr int BATCH      = 8;     // tracks per graph iteration
constexpr int ITER_PER_EVENT  = 7;   // 7 * 8 = 56 slots per event
constexpr int TRACKS_PER_EVENT = 50; // real tracks; the other 6 slots are padding
constexpr int SLOTS_PER_EVENT = ITER_PER_EVENT * BATCH;   // 56
constexpr int IN_DIM     = 16;    // padded embed input width
constexpr int HIDDEN     = 128;   // graph output width (the event mean)
constexpr int OUT_DIM    = 27;    // after the host-side output dense
constexpr int RAW_IN     = 8;     // values per track in embed_input.txt

// MACs per track, summed over the 14 dense layers, so the report can express
// throughput independently of wall clock. 16x128 + 128x128 + 3 x (256x128 +
// 3 x 128x128) -- matches src/parameters.h and aieml_batch/report.py.
constexpr long MACS_PER_TRACK = 264192L;

using clk = std::chrono::steady_clock;
double ms(clk::duration d) { return std::chrono::duration<double, std::milli>(d).count(); }
double us(clk::duration d) { return std::chrono::duration<double, std::micro>(d).count(); }

// MB/s from bytes and a duration; guards the divide so a zero-length phase
// (possible on a fast host) prints 0 rather than inf.
double mbps(std::size_t bytes, clk::duration d)
{
    const double sec = std::chrono::duration<double>(d).count();
    return sec > 0.0 ? (static_cast<double>(bytes) / sec) / 1e6 : 0.0;
}

std::string join(const std::string& base, const std::string& rel)
{
    if (base.empty()) return rel;
    return base.back() == '/' ? base + rel : base + "/" + rel;
}

// --package.sd_dir copies the DIRECTORY, not its contents, so on the SD card the
// payload lands under sd_batch/ rather than at the root. Try both so a bare
// ./host_batch.exe works from /mnt as well as from the build tree.
std::string first_existing(const std::vector<std::string>& cands, const std::string& what)
{
    for (const auto& c : cands) {
        std::ifstream f(c);
        if (f.good()) return c;
    }
    // On a board there is no debugger and a rebuild costs hours, so say
    // everything useful at once: what was wanted, every path tried, where we
    // are, and what is actually here.
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
    msg += "  If the payload is elsewhere, pass it explicitly:\n"
           "    ./host_batch.exe <xclbin> <weights_dir> <sysdata_dir>";
    throw std::runtime_error(msg);
}

std::vector<float> read_text(const std::string& path, std::size_t expect = 0)
{
    std::ifstream f(path);
    if (!f) throw std::runtime_error("cannot open " + path);
    std::vector<float> v;
    float x;
    while (f >> x) v.push_back(x);
    if (expect && v.size() != expect)
        throw std::runtime_error(path + ": expected " + std::to_string(expect) +
                                 " values, got " + std::to_string(v.size()));
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

// xrt::graph::update() forwards sizeof(arg) to the private update_port(), so the
// argument must be a type whose sizeof IS the payload -- a std::vector would send
// 24 bytes (the vector header). Same reason host/host.cpp uses aligned_array.
template<typename T, std::size_t N>
struct alignas(64) aligned_array { T elems[N]; };

// The graph has exactly four RTP element counts (checked against the metadata in
// aieml_batch/extract_rtp.py): 64, 128, 2048 and 4096.
//
// The ELEMENT TYPE is per port, not per build: a bf16 design has uint16 weights
// (raw bf16 bit patterns) and float32 biases side by side, because bias_t stays
// float in both precisions. So the type comes from the manifest, and one binary
// serves fp32 and bf16 without a recompile.
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

void update_rtp(xrt::graph& g, const std::string& port, const std::string& dtype,
                std::size_t n, const std::vector<char>& raw)
{
    if (dtype == "u16")      update_typed<std::uint16_t>(g, port, n, raw);
    else if (dtype == "f32") update_typed<float>(g, port, n, raw);
    else throw std::runtime_error(port + ": unknown RTP dtype '" + dtype + "'");
}

// float32 -> bfloat16, round half to even. Must match aie4ml's weight conversion
// (op_impls/families/matmul/common.py): truncation is 2x the error and biases
// every value toward zero, which does not cancel across a network.
std::uint16_t f32_to_bf16(float f)
{
    std::uint32_t u;
    std::memcpy(&u, &f, sizeof u);
    return static_cast<std::uint16_t>((u + 0x7FFFu + ((u >> 16) & 1u)) >> 16);
}

// sysdata/config.txt, written by extract_rtp.py. Tells the host what the graph
// expects without baking the precision into the binary.
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
        if (is >> b) { e.dtype = a; e.file = b; }   // new 4-column form
        else         { e.dtype = "f32"; e.file = a; }  // legacy 3-column, fp32 only
        out.push_back(e);
    }
    return out;
}

} // namespace

int main(int argc, char** argv)
{
    try {
        // Default to whichever xclbin is actually on the card: a TARGET=hw build
        // produces system_hw.xclbin, hw_emu produces system_hw_emu.xclbin.
        std::string xclbin;
        if (argc > 1) xclbin = argv[1];
        else          xclbin = first_existing({"system_hw.xclbin", "system_hw_emu.xclbin"},
                                              "an xclbin");
        const bool is_emu = xclbin.find("hw_emu") != std::string::npos;
        // Probe for the data next to the exe and under sd_batch/ (the packaged layout).
        std::string data_dir, sysdata;
        if (argc > 2) data_dir = argv[2];
        else {
            // weights_fp32 is the current name (model/weights_fp32 in the repo);
            // data_fp32 is what cards flashed before the rename carry. Both are
            // accepted so an existing card keeps working.
            auto p = first_existing({"weights_fp32/embed_input.txt",
                                     "sd_batch/weights_fp32/embed_input.txt",
                                     "data_fp32/embed_input.txt",
                                     "sd_batch/data_fp32/embed_input.txt"},
                                    "the weight directory");
            data_dir = p.substr(0, p.rfind('/'));
        }
        if (argc > 3) sysdata = argv[3];
        else {
            auto p = first_existing({"sysdata/rtp_manifest.txt",
                                     "sd_batch/sysdata/rtp_manifest.txt"}, "sysdata");
            sysdata = p.substr(0, p.rfind('/'));
        }
        const std::string out_path = (argc > 4) ? argv[4] : "track_out_27.txt";

        std::cout << "[host] xclbin=" << xclbin << " data=" << data_dir
                  << " sysdata=" << sysdata << std::endl;

        const auto t_start = clk::now();
        xrt::device device(0);
        auto uuid = device.load_xclbin(xclbin);
        xrt::graph graph(device, uuid, "dut");
        const auto t_xclbin = clk::now();

        // ---- RTP weights: 92 ports, ~1 MB ----------------------------------
        const auto manifest = read_manifest(join(sysdata, "rtp_manifest.txt"));
        if (manifest.empty()) throw std::runtime_error("empty RTP manifest");
        std::cout << "[host] loading " << manifest.size() << " RTP ports..." << std::endl;
        std::size_t rtp_bytes = 0;
        for (const auto& e : manifest) {
            const std::size_t esz = (e.dtype == "u16") ? 2u : 4u;
            auto payload = read_bin(join(sysdata, e.file), e.n * esz);
            update_rtp(graph, e.port, e.dtype, e.n, payload);
            rtp_bytes += e.n * esz;
        }
        const auto t_rtp = clk::now();
        std::cout << "[host] RTP loaded: " << rtp_bytes / 1024 << " KB" << std::endl;

        // ---- input: 50 real tracks, zero-padded to N_ITER*BATCH slots -------
        // Input file: RTDA_INPUT overrides, so a different track count can be run
        // without copying over the one on the card (the SD partition is often
        // mounted read-only, and a failed cp is silent).
        const char* env_in = std::getenv("RTDA_INPUT");
        const std::string in_file = env_in ? std::string(env_in)
                                           : join(data_dir, "embed_input.txt");
        std::cout << "[host] input file: " << in_file << std::endl;
        auto raw = read_text(in_file);
        const int file_tracks = static_cast<int>(raw.size() / RAW_IN);
        if (file_tracks < 1) throw std::runtime_error("embed_input.txt has no complete tracks");

        // One event is TRACKS_PER_EVENT tracks laid out in SLOTS_PER_EVENT slots.
        // Events must be padded INDIVIDUALLY, not concatenated: the accumulator
        // stops at 50 and skips the rest of that block, so a short final block of
        // one event would swallow the first tracks of the next.
        const int n_events = (file_tracks + TRACKS_PER_EVENT - 1) / TRACKS_PER_EVENT;

        // track_accum counts SLOTS, not real tracks -- it cannot tell them apart,
        // because a zero-input slot still carries a bias-determined activation by
        // the time it reaches the accumulator. The count only means "real tracks"
        // because the first 50 slots of a full event are real. A short final event
        // therefore averages its few real tracks together with padding activations
        // and comes out wrong (measured 8.0e-02 for a 20-track event) -- wrong, but
        // plausible-looking, so say so loudly rather than let it pass.
        if (file_tracks % TRACKS_PER_EVENT != 0)
            std::cout << "[host] WARNING: " << file_tracks << " tracks is not a multiple of "
                      << TRACKS_PER_EVENT << ". The last event has only "
                      << (file_tracks % TRACKS_PER_EVENT) << " real tracks and its mean will be "
                      << "WRONG (it averages padding activations too). Every other event is fine."
                      << std::endl;

        // Prepend one all-zero "flush" event whose result is discarded.
        // roll_concat_batch's carry is a static initialised at ELF LOAD, not at
        // graph.run(). A second run on an already-downloaded xclbin therefore
        // starts with the previous run's leftover carry and event 0 comes out
        // ~2.5e-3 different -- results depend on whether the board was cold.
        // A few zero slots drive the roll state to a bias-determined value
        // regardless of history, so the real events become reproducible either
        // way. RTDA_NO_FLUSH=1 disables it (only correct from a cold start).
        const bool flush   = std::getenv("RTDA_NO_FLUSH") == nullptr;
        const int lead_ev  = flush ? 1 : 0;
        const int n_iter   = (n_events + lead_ev) * ITER_PER_EVENT;
        std::cout << "[host] input: " << file_tracks << " tracks -> " << n_events
                  << " event(s), " << n_iter << " iterations" << std::endl;

        // The graph's input is float32 or bfloat16 depending on how it was built;
        // the OUTPUT is float32 either way (track_accum accumulates and emits in
        // float -- see aieml_batch/src_*/kernels/track_accum).
        const std::string in_dtype =
            read_config(join(sysdata, "config.txt"), "input_dtype", "float32");
        const bool in_bf16 = (in_dtype == "bfloat16");
        const std::size_t in_esz = in_bf16 ? 2u : 4u;
        std::cout << "[host] graph input dtype: " << in_dtype << std::endl;

        const std::size_t slots    = static_cast<std::size_t>(n_iter) * BATCH;
        const std::size_t in_elems = slots * IN_DIM;
        const std::size_t in_bytes = in_elems * in_esz;
        // Padding slots are zeros here, but note they are NOT ignored downstream
        // by virtue of being zero: every dense layer has a bias, so a zero track
        // still produces a sizeable activation. The AIE accumulator drops them by
        // COUNTING to 50 (kernels/track_accum), not by relying on zeros.
        std::vector<float> host_in(in_elems, 0.0f);
        for (int t = 0; t < file_tracks; ++t) {
            const int ev = t / TRACKS_PER_EVENT, idx = t % TRACKS_PER_EVENT;
            const std::size_t slot =
                static_cast<std::size_t>(ev + lead_ev) * SLOTS_PER_EVENT + idx;
            for (int k = 0; k < RAW_IN; ++k)
                host_in[slot * IN_DIM + k] = raw[static_cast<std::size_t>(t) * RAW_IN + k];
        }

        const std::size_t out_elems = static_cast<std::size_t>(n_iter) * HIDDEN;
        const std::size_t out_bytes = out_elems * sizeof(float);

        auto in_bo  = xrt::aie::bo(device, in_bytes,  xrt::bo::flags::normal, 0);
        auto out_bo = xrt::aie::bo(device, out_bytes, xrt::bo::flags::normal, 0);
        if (in_bf16) {
            auto* dst = in_bo.map<std::uint16_t*>();
            for (std::size_t i = 0; i < in_elems; ++i) dst[i] = f32_to_bf16(host_in[i]);
        } else {
            std::memcpy(in_bo.map<float*>(), host_in.data(), in_bytes);
        }

        std::cout << "[host] running graph: " << n_iter << " iterations x "
                  << BATCH << " tracks (" << file_tracks << " real + "
                  << (slots - file_tracks) << " padding"
                  << (flush ? ", incl. 1 flush event" : "") << ")" << std::endl;

        // Input DMA, compute and output DMA overlap by design -- the graph
        // consumes x as it arrives -- so they are timed as one phase. Waiting on
        // the input transfer before graph.run() would deadlock: nothing is
        // draining the shim DMA until the graph is running.
        const auto t_exec0 = clk::now();
        in_bo.async("dut.gmio_x",     XCL_BO_SYNC_BO_GMIO_TO_AIE, in_bytes,  0);
        auto out_run = out_bo.async("dut.gmio_track", XCL_BO_SYNC_BO_AIE_TO_GMIO, out_bytes, 0);

        graph.run(n_iter);
        graph.wait();
        out_run.wait();
        const auto t_exec = clk::now();

        const float* out = out_bo.map<float*>();

        // ---- pick the completed event -------------------------------------
        // The accumulator emits zeros until the 50th real track lands, so the
        // last non-zero frame is the event mean. Searching for it (rather than
        // assuming index N_ITER-1) keeps this correct if N_ITER changes.
        std::vector<int> frames;
        for (int i = 0; i < n_iter; ++i) {
            float m = 0.0f;
            for (int j = 0; j < HIDDEN; ++j)
                m = std::max(m, std::fabs(out[static_cast<std::size_t>(i) * HIDDEN + j]));
            if (m > 0.0f) frames.push_back(i);
        }
        if (frames.empty()) throw std::runtime_error("all output frames are zero - graph produced nothing");
        if (flush && !frames.empty()) {
            frames.erase(frames.begin());        // discard the flush event
            std::cout << "[host] (flush event discarded; RTDA_NO_FLUSH=1 to disable)" << std::endl;
        }
        std::cout << "[host] event means in frame(s):";
        for (int f : frames) std::cout << ' ' << f;
        std::cout << "  of " << n_iter << "   (expect " << n_events << ", at 6,13,20,...)" << std::endl;
        if (static_cast<int>(frames.size()) != n_events)
            std::cout << "[host] WARNING: " << frames.size() << " means for " << n_events
                      << " events - the accumulator is not resetting as expected" << std::endl;
        const float* mean = out + static_cast<std::size_t>(frames.back()) * HIDDEN;

        // ---- output dense on the host (as host/host.cpp:394) ----------------
        auto W = read_text(join(data_dir, "output_weights.txt"),
                           static_cast<std::size_t>(HIDDEN) * OUT_DIM);
        auto B = read_text(join(data_dir, "output_bias.txt"), OUT_DIM);

        std::vector<float> y(OUT_DIM);
        for (int j = 0; j < OUT_DIM; ++j) {
            float acc = B[static_cast<std::size_t>(j)];
            for (int k = 0; k < HIDDEN; ++k)
                acc += mean[k] * W[static_cast<std::size_t>(k) * OUT_DIM + j];
            y[static_cast<std::size_t>(j)] = acc;
        }

        std::ofstream fo(out_path);
        fo << std::setprecision(std::numeric_limits<float>::max_digits10);
        for (int j = 0; j < OUT_DIM; ++j) fo << y[static_cast<std::size_t>(j)] << '\n';
        fo.close();
        std::cout << "[host] wrote " << OUT_DIM << " values -> " << out_path << std::endl;

        // also dump the raw mean, so the 128-wide result can be compared directly
        // ---- on-board verification against a golden, if one is supplied -----
        // RTDA_GOLDEN=<file> where the file is "n_events n_cols" then one row of
        // n_cols floats per event. Avoids copying hundreds of result files off
        // the board just to diff them.
        if (const char* gpath = std::getenv("RTDA_GOLDEN")) {
            std::ifstream gf(gpath);
            if (!gf) {
                std::cout << "[host] WARNING: cannot open golden " << gpath << std::endl;
            } else {
                std::size_t g_ev = 0, g_cols = 0;
                gf >> g_ev >> g_cols;
                if (g_cols != static_cast<std::size_t>(HIDDEN)) {
                    std::cout << "[host] WARNING: golden has " << g_cols
                              << " columns, expected " << HIDDEN << std::endl;
                } else {
                    const std::size_t n_cmp = std::min(g_ev, frames.size());
                    double worst = 0.0; std::size_t worst_ev = 0, bad = 0;
                    std::vector<float> row(HIDDEN);
                    for (std::size_t e = 0; e < g_ev; ++e) {
                        for (int j = 0; j < HIDDEN; ++j) gf >> row[j];
                        if (e >= n_cmp) continue;
                        const float* m = out + static_cast<std::size_t>(frames[e]) * HIDDEN;
                        double mx = 0.0;
                        for (int j = 0; j < HIDDEN; ++j)
                            mx = std::max(mx, static_cast<double>(std::fabs(m[j] - row[j])));
                        if (mx > worst) { worst = mx; worst_ev = e; }
                        if (mx > 1e-4) ++bad;
                    }
                    std::cout << "\n[host] ===== Verification vs " << gpath << " =====\n"
                              << "  events compared : " << n_cmp << " of " << g_ev << "\n"
                              << "  worst event     : " << worst_ev << "   max|diff| = " << worst << "\n"
                              << "  over 1e-4       : " << bad << "\n"
                              << (bad == 0 ? "  PASS\n" : "  FAIL\n");
                }
            }
        }

        // track_mean_128.txt keeps the LAST event (so single-event runs and the
        // existing compare tooling are unchanged); per-event files alongside it.
        std::ofstream fm("track_mean_128.txt");
        fm << std::setprecision(std::numeric_limits<float>::max_digits10);
        for (int j = 0; j < HIDDEN; ++j) fm << mean[j] << '\n';
        fm.close();
        std::cout << "[host] wrote 128-wide event mean -> track_mean_128.txt" << std::endl;
        // ---- ALL events, one file -------------------------------------------
        // A 50,000-track run is 1000 events. Writing 1000 files and then getting
        // them off an SD card is miserable, so pack them into a single file in
        // EXACTLY the layout the goldens use (testdata/golden_<N>.txt):
        //
        //     <n_events> <n_cols>
        //     <n_cols floats>          one line per event
        //
        // so the same parser reads a golden, a measured run, or either side of a
        // comparison. numpy: np.loadtxt(f, skiprows=1) gives (n_events, 128).
        {
            std::ofstream fa("track_means_all.txt");
            fa << std::setprecision(std::numeric_limits<float>::max_digits10);
            fa << frames.size() << ' ' << HIDDEN << '\n';
            for (std::size_t e = 0; e < frames.size(); ++e) {
                const float* m = out + static_cast<std::size_t>(frames[e]) * HIDDEN;
                for (int j = 0; j < HIDDEN; ++j) fa << m[j] << (j + 1 == HIDDEN ? '\n' : ' ');
            }
        }
        std::cout << "[host] wrote " << frames.size()
                  << " event mean(s) -> track_means_all.txt  (single file, "
                  << (frames.size() * HIDDEN * 14 + 16) / 1024 << " KB approx)" << std::endl;

        // Per-event files remain opt-in, for tooling that wants them separately.
        if (frames.size() > 1 && std::getenv("RTDA_DUMP_EVENTS")) {
            for (std::size_t e = 0; e < frames.size(); ++e) {
                const std::string fn = "track_mean_128_ev" + std::to_string(e) + ".txt";
                std::ofstream fe(fn);
                fe << std::setprecision(std::numeric_limits<float>::max_digits10);
                const float* m = out + static_cast<std::size_t>(frames[e]) * HIDDEN;
                for (int j = 0; j < HIDDEN; ++j) fe << m[j] << '\n';
            }
            std::cout << "[host] also wrote " << frames.size()
                      << " per-event files -> track_mean_128_ev*.txt" << std::endl;
        }
        const auto t_end = clk::now();

        // ---- size + timing report ------------------------------------------
        const long macs_total = MACS_PER_TRACK * file_tracks;   // over ALL tracks
        std::cout
          << "\n[host] ===== Size report =====\n"
          << "  RTP weights        : " << manifest.size() << " ports, "
          << rtp_bytes / 1024.0 << " KB\n"
          << "  Events             : " << n_events << " x " << TRACKS_PER_EVENT
          << " tracks (" << file_tracks << " real)\n"
          << "  Input  (x)         : " << slots << " slots x " << IN_DIM << " floats = "
          << in_bytes / 1024.0 << " KB   (" << file_tracks << " real + "
          << (slots - file_tracks) << " padding)\n"
          << "  Output             : " << n_iter << " frames x " << HIDDEN << " floats = "
          << out_bytes / 1024.0 << " KB   (" << n_events << " carry a result)\n"
          << "  Model              : 14 dense layers, " << MACS_PER_TRACK << " MACs/track\n"
          << "                       " << MACS_PER_TRACK * TRACKS_PER_EVENT / 1e6
          << " MMAC/event, " << macs_total / 1e6 << " MMAC total ("
          << 2 * macs_total / 1e6 << " MOP)\n";

        std::cout
          << "\n[host] ===== Timing =====\n"
          << "  xclbin load + graph open : " << ms(t_xclbin - t_start) << " ms\n"
          << "  RTP load (" << manifest.size() << " ports)     : " << ms(t_rtp - t_xclbin)
          << " ms   (" << mbps(rtp_bytes, t_rtp - t_xclbin) << " MB/s)\n"
          << "  execute (DMA + graph)    : " << ms(t_exec - t_exec0) << " ms\n"
          << "  output dense + write     : " << ms(t_end - t_exec) << " ms\n"
          << "  TOTAL                    : " << ms(t_end - t_start) << " ms\n";

        const auto exec = t_exec - t_exec0;
        std::cout
          << "\n  per event              : " << ms(exec) / n_events << " ms\n"
          << "  per track              : " << us(exec) / file_tracks << " us\n"
          << "  effective throughput   : "
          << (2.0 * macs_total) / (std::chrono::duration<double>(exec).count()) / 1e9 << " GOP/s\n";

        // II is a property of the BUILD, not of the host: 4161 ns/iteration for fp32,
        // 1033 ns for bf16 (aiesimulator, `make report`). Hard-coding fp32 made the
        // "launch/DMA overhead" line below meaningless for a bf16 image -- it reported
        // the fp32 model against a 4x faster array. sysdata/config.txt carries it;
        // RTDA_II_NS overrides for a one-off.
        double ii_ns = 4161.0;
        {
            const std::string s = read_config(join(sysdata, "config.txt"), "ii_ns", "");
            if (!s.empty()) ii_ns = std::atof(s.c_str());
            if (const char* e = std::getenv("RTDA_II_NS")) ii_ns = std::atof(e);
        }
        const double aie_us = ii_ns * 1e-3 * n_iter;
        const double exec_us = us(exec);
        std::cout
          << "\n  AIE compute (modelled) : " << aie_us << " us   (II " << ii_ns << " ns x "
          << n_iter << " iterations)\n"
          << "  measured execute       : " << exec_us << " us\n"
          << "  launch/DMA overhead    : " << (exec_us - aie_us) << " us  ("
          << (exec_us > 0 ? 100.0 * (exec_us - aie_us) / exec_us : 0.0) << "% of execute)\n"
          << "     -> run more events per launch to amortise this\n";

        // ---- the same numbers, machine-readable -----------------------------
        // The report above is for a human; this is for the notebook's timing
        // section. key=value, one per line, so it parses with a two-line split
        // and never needs the prose format kept stable.
        {
            std::ofstream fr("run_info.txt");
            fr << std::setprecision(9);
            fr << "xclbin="        << xclbin           << '\n'
               << "emulation="     << (is_emu ? 1 : 0) << '\n'
               << "input="         << in_file          << '\n'
               << "tracks="        << file_tracks      << '\n'
               << "events="        << n_events         << '\n'
               << "tracks_per_event=" << TRACKS_PER_EVENT << '\n'
               // Always 0: track_accum sums every slot of the event and has no
               // way to skip the contaminated warm-up head, so this mean is
               // over all 50 tracks. Written explicitly because the analysis
               // chooses which reference to compare against from this key, and
               // an absent key is one more thing a reader has to already know.
               // The PL flow takes warmup as a runtime argument and writes 3.
               << "warmup="        << 0                << '\n'
               << "impl=aie\n"
               << "iterations="    << n_iter           << '\n'
               << "flush_event="   << (flush ? 1 : 0)  << '\n'
               << "rtp_ports="     << manifest.size()  << '\n'
               << "rtp_bytes="     << rtp_bytes        << '\n'
               << "in_bytes="      << in_bytes         << '\n'
               << "out_bytes="     << out_bytes        << '\n'
               << "macs_per_track=" << MACS_PER_TRACK  << '\n'
               << "us_xclbin_open=" << us(t_xclbin - t_start)  << '\n'
               << "us_rtp_load="    << us(t_rtp - t_xclbin)    << '\n'
               << "us_execute="     << us(exec)                << '\n'
               << "us_post="        << us(t_end - t_exec)      << '\n'
               << "us_total="       << us(t_end - t_start)     << '\n'
               << "us_per_track="   << us(exec) / file_tracks  << '\n'
               << "gops="           << (2.0 * macs_total)
                                       / std::chrono::duration<double>(exec).count() / 1e9 << '\n'
               << "us_aie_modelled=" << aie_us << '\n'
               << "ii_ns="           << ii_ns  << '\n';
        }
        std::cout << "\n[host] wrote run_info.txt  (machine-readable timing/size)\n";

        if (is_emu) std::cout <<
          "\n  NOTE: under hw_emu these are EMULATION wall-clock times (QEMU PS +\n"
          "  SystemC AIE model) and say nothing about silicon speed. The cycle-\n"
          "  accurate figure for this graph is II = 4161 ns for 7 iterations,\n"
          "  i.e. 582.6 ns per real track (aieml_batch: make report). Only a\n"
          "  TARGET=hw run on the board gives meaningful wall-clock numbers.\n";
        else std::cout <<
          "\n  (TARGET=hw build: these are real wall-clock times.)\n";

        graph.end();
        std::cout << "[host] done" << std::endl;
    }
    catch (const std::exception& e) {
        std::cerr << "[host] ERROR: " << e.what() << std::endl;
        return 1;
    }
    return 0;
}
