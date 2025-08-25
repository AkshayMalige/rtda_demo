#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <map>
#include <stdexcept>

#include "experimental/xrt_device.h"
#include "experimental/xrt_kernel.h"
#include "experimental/xrt_graph.h"
#include "experimental/xrt_bo.h"

#include "data_paths.h"
#include "nn_defs.h"

// Fixed graph name used throughout the host
static constexpr const char* kGraphName = "aieml";

// ---------------------------------------------------------------------------
// Utility to read a text file containing floats into a std::vector
// ---------------------------------------------------------------------------
static std::vector<float> read_file_to_vector(const std::string& filename,
                                              int               size) {
    std::vector<float> data;
    data.reserve(size);

    std::ifstream file(filename);
    if (!file.is_open()) {
        throw std::runtime_error("ERROR: Could not open file " + filename);
    }

    float val;
    while (file >> val) {
        data.push_back(val);
    }
    file.close();

    if ((int)data.size() != size) {
        throw std::runtime_error("ERROR: File " + filename +
                                 " does not contain the expected " +
                                 std::to_string(size) + " elements.");
    }
    return data;
}

// Description of a packet to send through an mm2s kernel
struct PacketSpec {
    std::string file;  // Path to file with float data
    int         size;  // Number of float words in the payload
    int         dest;  // Packet destination ID
};

struct GraphConfig {
    std::vector<PacketSpec> weight_pkts; // Packets for mm2s_pkt_weights
    std::vector<PacketSpec> data_pkts;   // Packets for mm2s_pkt_data
    std::string             s2mm;        // s2mm kernel instance name
    std::string             output_file; // Where to dump host results
    int                     output_size; // Total number of payload words
    int                     out_packets; // Number of packets expected back
};

// Build the configuration for the only supported graph (aieml)
static GraphConfig make_config(const std::string& base_path) {
    GraphConfig cfg;

    // Packets destined for weight and bias legs
    cfg.weight_pkts = {
        {base_path + "/" + EMBED_DENSE0_WEIGHTS, EMBED_DENSE0_WEIGHTS_SIZE, 1},
        {base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + "0.txt",
         EMBED_DENSE1_WEIGHTS_PART_SIZE, 2},
        {base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + "1.txt",
         EMBED_DENSE1_WEIGHTS_PART_SIZE, 3},
        {base_path + "/" + EMBED_DENSE0_BIAS,   EMBED_DENSE0_BIAS_SIZE,   4},
        {base_path + "/" + EMBED_DENSE1_BIAS,   EMBED_DENSE1_BIAS_SIZE,   5},
    };

    // Input activation stream
    cfg.data_pkts = {
        {base_path + "/" + EMBED_INPUT_DATA, EMBED_DENSE0_INPUT_SIZE, 0},
    };

    cfg.s2mm        = "s2mm_pkt_sink";
    cfg.output_file = base_path + "/" + EMBED_HOST_OUTPUT;
    cfg.output_size = EMBED_FINAL_OUTPUT_SIZE;
    cfg.out_packets = 1; // One output packet expected from the graph

    return cfg;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cout << "Usage: " << argv[0] << " <a.xclbin>\n";
        return 1;
    }

    const std::string xclbinFilename = argv[1];
    const std::string base_path = "./data";

    GraphConfig cfg = make_config(base_path);

    try {
        // ------------------------------------------------------------------
        // Load xclbin and obtain device/kernel/graph handles
        // ------------------------------------------------------------------
        xrt::device device(0);
        xrt::xclbin xclbin(xclbinFilename);
        auto        xclbin_uuid = device.load_xclbin(xclbin);

        xrt::kernel mm2s_w_kernel(device, xclbin_uuid, "mm2s_pkt_weights");
        xrt::kernel mm2s_d_kernel(device, xclbin_uuid, "mm2s_pkt_data");
        xrt::kernel s2mm_kernel(device, xclbin_uuid, cfg.s2mm.c_str());
        xrt::graph  aie_graph(device, xclbin_uuid, kGraphName);

        // ------------------------------------------------------------------
        // Allocate buffers for each packet (weights and activations)
        // ------------------------------------------------------------------
        std::vector<xrt::bo> weight_bos;
        for (auto& spec : cfg.weight_pkts) {
            auto data = read_file_to_vector(spec.file, spec.size);
            xrt::bo bo(device, data.size() * sizeof(float),
                       xrt::bo::flags::normal, 0);
            bo.write(data.data());
            bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
            weight_bos.push_back(std::move(bo));
        }

        std::vector<xrt::bo> data_bos;
        for (auto& spec : cfg.data_pkts) {
            auto data = read_file_to_vector(spec.file, spec.size);
            xrt::bo bo(device, data.size() * sizeof(float),
                       xrt::bo::flags::normal, 0);
            bo.write(data.data());
            bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
            data_bos.push_back(std::move(bo));
        }

        int total_output_words = cfg.output_size + (cfg.out_packets * 2);
        xrt::bo output_buf(device, total_output_words * sizeof(float),
                           xrt::bo::flags::normal, 0);

        // ------------------------------------------------------------------
        // Launch consumer kernels and start graph
        // ------------------------------------------------------------------
        auto s2mm_run = xrt::run(s2mm_kernel);
        s2mm_run.set_arg(0, output_buf);
        s2mm_run.set_arg(2, total_output_words);
        s2mm_run.start();

        aie_graph.run(-1); // Start graph (continuous)

        // ------------------------------------------------------------------
        // Send all packets: weights first, then activations
        // ------------------------------------------------------------------
        for (size_t i = 0; i < cfg.weight_pkts.size(); ++i) {
            auto run = xrt::run(mm2s_w_kernel);
            run.set_arg(0, weight_bos[i]);
            run.set_arg(2, cfg.weight_pkts[i].size);
            run.set_arg(3, cfg.weight_pkts[i].dest);
            run.start();
            run.wait();
        }

        for (size_t i = 0; i < cfg.data_pkts.size(); ++i) {
            auto run = xrt::run(mm2s_d_kernel);
            run.set_arg(0, data_bos[i]);
            run.set_arg(2, cfg.data_pkts[i].size);
            run.set_arg(3, cfg.data_pkts[i].dest);
            run.start();
            run.wait();
        }

        // ------------------------------------------------------------------
        // Stop graph and wait for completion
        // ------------------------------------------------------------------
        aie_graph.stop();
        aie_graph.wait();
        s2mm_run.wait();

        // ------------------------------------------------------------------
        // Retrieve results.  Each packet in memory is stored as
        // [dest, size, <payload...>].  Demultiplex by destination so the
        // order of packets on the stream does not matter.
        // ------------------------------------------------------------------
        std::vector<float> host_output(total_output_words);
        output_buf.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        output_buf.read(host_output.data());

        std::map<int, std::vector<float>> outputs;
        size_t idx = 0;
        int    packets_seen = 0;
        while (idx + 1 < host_output.size() && packets_seen < cfg.out_packets) {
            int dest = static_cast<int>(host_output[idx++]);
            int sz   = static_cast<int>(host_output[idx++]);
            if (sz <= 0 || idx + sz > host_output.size()) {
                break; // Malformed packet
            }
            outputs[dest] = std::vector<float>(host_output.begin() + idx,
                                               host_output.begin() + idx + sz);
            idx += sz;
            ++packets_seen;
        }

        std::ofstream out(cfg.output_file);
        for (auto& kv : outputs) {
            for (float v : kv.second) {
                std::cout << v << '\n';
                out << v << '\n';
            }
        }

    } catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}

