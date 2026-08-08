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
#include <iomanip>
#include <iostream>
#include <limits>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

#include "xrt/xrt_device.h"
#include "xrt/xrt_graph.h"
#include "xrt/xrt_kernel.h"
#include "experimental/xrt_aie.h"

namespace {

// Geometry — must match the compiled graph (src/parameters.h N_ITER and
// kernels/track_accum/track_accum.h).
constexpr int BATCH      = 8;     // tracks per graph iteration
constexpr int N_ITER     = 7;     // iterations per event: 7 * 8 = 56 slots
constexpr int N_TRACKS   = 50;    // real tracks; the remaining 6 slots are padding
constexpr int IN_DIM     = 16;    // padded embed input width
constexpr int HIDDEN     = 128;   // graph output width (the event mean)
constexpr int OUT_DIM    = 27;    // after the host-side output dense
constexpr int RAW_IN     = 8;     // values per track in embed_input.txt

std::string join(const std::string& base, const std::string& rel)
{
    if (base.empty()) return rel;
    return base.back() == '/' ? base + rel : base + "/" + rel;
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

std::vector<float> read_bin(const std::string& path, std::size_t n_floats)
{
    std::ifstream f(path, std::ios::binary);
    if (!f) throw std::runtime_error("cannot open " + path);
    std::vector<float> v(n_floats);
    f.read(reinterpret_cast<char*>(v.data()), static_cast<std::streamsize>(n_floats * sizeof(float)));
    if (static_cast<std::size_t>(f.gcount()) != n_floats * sizeof(float))
        throw std::runtime_error(path + ": short read");
    return v;
}

// xrt::graph::update() forwards sizeof(arg) to the private update_port(), so the
// argument must be a type whose sizeof IS the payload -- a std::vector would send
// 24 bytes (the vector header). Same reason host/host.cpp uses aligned_array.
template<typename T, std::size_t N>
struct alignas(64) aligned_array { T elems[N]; };

// The graph has exactly four RTP payload sizes (checked against the metadata in
// aieml_batch/extract_rtp.py): 64, 128, 2048 and 4096 floats.
template<std::size_t N>
void update_n(xrt::graph& g, const std::string& port, const std::vector<float>& v)
{
    aligned_array<float, N> a{};
    std::memcpy(a.elems, v.data(), N * sizeof(float));
    g.update(port, a);
}

void update_rtp(xrt::graph& g, const std::string& port, const std::vector<float>& v)
{
    switch (v.size()) {
        case   64: update_n<  64>(g, port, v); break;
        case  128: update_n< 128>(g, port, v); break;
        case 2048: update_n<2048>(g, port, v); break;
        case 4096: update_n<4096>(g, port, v); break;
        default:
            throw std::runtime_error(port + ": unexpected RTP size " +
                                     std::to_string(v.size()) + " floats; add a case here");
    }
}

struct RtpEntry { std::string port; std::size_t n; std::string file; };

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
        if (is >> e.port >> e.n >> e.file) out.push_back(e);
    }
    return out;
}

} // namespace

int main(int argc, char** argv)
{
    try {
        const std::string xclbin   = (argc > 1) ? argv[1] : "system_hw_emu.xclbin";
        const std::string data_dir = (argc > 2) ? argv[2] : "data_fp32";
        const std::string sysdata  = (argc > 3) ? argv[3] : "sysdata";
        const std::string out_path = (argc > 4) ? argv[4] : "track_out_27.txt";

        std::cout << "[host] xclbin=" << xclbin << " data=" << data_dir
                  << " sysdata=" << sysdata << std::endl;

        xrt::device device(0);
        auto uuid = device.load_xclbin(xclbin);
        xrt::graph graph(device, uuid, "dut");

        // ---- RTP weights: 92 ports, ~1 MB ----------------------------------
        const auto manifest = read_manifest(join(sysdata, "rtp_manifest.txt"));
        if (manifest.empty()) throw std::runtime_error("empty RTP manifest");
        std::cout << "[host] loading " << manifest.size() << " RTP ports..." << std::endl;
        std::size_t rtp_floats = 0;
        for (const auto& e : manifest) {
            auto payload = read_bin(join(sysdata, e.file), e.n);
            update_rtp(graph, e.port, payload);
            rtp_floats += e.n;
        }
        std::cout << "[host] RTP loaded: " << rtp_floats * sizeof(float) / 1024 << " KB" << std::endl;

        // ---- input: 50 real tracks, zero-padded to N_ITER*BATCH slots -------
        auto raw = read_text(join(data_dir, "embed_input.txt"));
        if (raw.size() < static_cast<std::size_t>(N_TRACKS) * RAW_IN)
            throw std::runtime_error("embed_input.txt has fewer than 50 tracks");

        const std::size_t slots    = static_cast<std::size_t>(N_ITER) * BATCH;
        const std::size_t in_elems = slots * IN_DIM;
        const std::size_t in_bytes = in_elems * sizeof(float);
        // Padding slots are zeros here, but note they are NOT ignored downstream
        // by virtue of being zero: every dense layer has a bias, so a zero track
        // still produces a sizeable activation. The AIE accumulator drops them by
        // COUNTING to 50 (kernels/track_accum), not by relying on zeros.
        std::vector<float> host_in(in_elems, 0.0f);
        for (int t = 0; t < N_TRACKS; ++t)
            for (int k = 0; k < RAW_IN; ++k)
                host_in[static_cast<std::size_t>(t) * IN_DIM + k] = raw[static_cast<std::size_t>(t) * RAW_IN + k];

        const std::size_t out_elems = static_cast<std::size_t>(N_ITER) * HIDDEN;
        const std::size_t out_bytes = out_elems * sizeof(float);

        auto in_bo  = xrt::aie::bo(device, in_bytes,  xrt::bo::flags::normal, 0);
        auto out_bo = xrt::aie::bo(device, out_bytes, xrt::bo::flags::normal, 0);
        std::memcpy(in_bo.map<float*>(), host_in.data(), in_bytes);

        std::cout << "[host] running graph: " << N_ITER << " iterations x "
                  << BATCH << " tracks (" << N_TRACKS << " real + "
                  << (slots - N_TRACKS) << " padding)" << std::endl;

        in_bo.async("dut.gmio_x",     XCL_BO_SYNC_BO_GMIO_TO_AIE, in_bytes,  0);
        auto out_run = out_bo.async("dut.gmio_track", XCL_BO_SYNC_BO_AIE_TO_GMIO, out_bytes, 0);

        graph.run(N_ITER);
        graph.wait();
        out_run.wait();

        const float* out = out_bo.map<float*>();

        // ---- pick the completed event -------------------------------------
        // The accumulator emits zeros until the 50th real track lands, so the
        // last non-zero frame is the event mean. Searching for it (rather than
        // assuming index N_ITER-1) keeps this correct if N_ITER changes.
        int frame = -1;
        for (int i = N_ITER - 1; i >= 0; --i) {
            float m = 0.0f;
            for (int j = 0; j < HIDDEN; ++j)
                m = std::max(m, std::fabs(out[static_cast<std::size_t>(i) * HIDDEN + j]));
            if (m > 0.0f) { frame = i; break; }
        }
        if (frame < 0) throw std::runtime_error("all output frames are zero - graph produced nothing");
        std::cout << "[host] event mean in frame " << frame << " of " << N_ITER << std::endl;
        const float* mean = out + static_cast<std::size_t>(frame) * HIDDEN;

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
        std::ofstream fm("track_mean_128.txt");
        fm << std::setprecision(std::numeric_limits<float>::max_digits10);
        for (int j = 0; j < HIDDEN; ++j) fm << mean[j] << '\n';
        fm.close();
        std::cout << "[host] wrote 128-wide event mean -> track_mean_128.txt" << std::endl;

        graph.end();
        std::cout << "[host] done" << std::endl;
    }
    catch (const std::exception& e) {
        std::cerr << "[host] ERROR: " << e.what() << std::endl;
        return 1;
    }
    return 0;
}
