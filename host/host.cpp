#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <stdexcept>
#include "experimental/xrt_kernel.h"
#include "experimental/xrt_graph.h"
#include "experimental/xrt_device.h"
#include "experimental/xrt_bo.h"
#include "data_paths.h"
#include "nn_defs.h"

// ------ Set this to "aieml", "aieml2", or "aieml3" ------
static constexpr const char* kGraphName = "aieml";
// ---------------------------------------------------------

// Load text files containing floats into a vector
static std::vector<float> read_file_to_vector(const std::string& filename, int size) {
    std::vector<float> data;
    data.reserve(size);
    std::ifstream file(filename);
    if (!file.is_open()) {
        throw std::runtime_error("ERROR: Could not open file " + filename);
    }
    float val;
    while (file >> val) { data.push_back(val); }
    file.close();
    if ((int)data.size() != size) {
        throw std::runtime_error("ERROR: File " + filename +
                                 " does not contain the expected " + std::to_string(size) + " elements.");
    }
    return data;
}

struct MM2SInfo { std::string file; int size; std::string kernel; };

struct GraphConfig {
    std::vector<MM2SInfo> mm2s;
    std::vector<std::string> relus;
    std::vector<std::string> splitters;
    std::string s2mm;
    std::string output_file;
    int output_size;
    int relu_size;
};

static GraphConfig make_config(const std::string& graph, const std::string& base_path) {
    if (graph == "aieml") {
        GraphConfig cfg;
        cfg.mm2s = {
            {base_path + "/" + EMBED_DENSE0_WEIGHTS, EMBED_DENSE0_WEIGHTS_SIZE, "mm2s_pl:{mm2s_weights1}"},
            {base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + "0.txt", EMBED_DENSE1_WEIGHTS_PART_SIZE, "mm2s_pl:{mm2s_weights2_0}"},
            {base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + "1.txt", EMBED_DENSE1_WEIGHTS_PART_SIZE, "mm2s_pl:{mm2s_weights2_1}"},
            {base_path + "/" + EMBED_DENSE0_BIAS, EMBED_DENSE0_BIAS_SIZE, "mm2s_pl:{mm2s_bias1}"},
            {base_path + "/" + EMBED_DENSE1_BIAS, EMBED_DENSE1_BIAS_SIZE, "mm2s_pl:{mm2s_bias2}"},
            {base_path + "/" + EMBED_INPUT_DATA, EMBED_DENSE0_INPUT_SIZE, "mm2s_pl:{mm2s_din}"},
        };
        cfg.relus = {"leaky_relu_pl:{relu}", "leaky_relu_pl:{relu2}"};
        cfg.splitters = {"leaky_splitter_pl:{splitter}"};
        cfg.s2mm = "s2mm_pl:{s2mm_out}";
        cfg.output_file = base_path + "/" + EMBED_HOST_OUTPUT;
        cfg.output_size = EMBED_FINAL_OUTPUT_SIZE;
        cfg.relu_size = HIDDEN_SIZE;
        return cfg;
    } else if (graph == "aieml2") {
        GraphConfig cfg;
        // Layer 0 weights
        for (int i = 0; i < SUBSOLVER0_INPUT_PARTS; ++i) {
            cfg.mm2s.push_back({base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(i) + ".txt",
                                SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE,
                                "mm2s_pl:{layer0_weights_" + std::to_string(i) + "}"});
        }
        // Layer 1-3 weights
        for (int i = 0; i < SUBSOLVER0_LAYER_WEIGHTS_PARTS; ++i) {
            cfg.mm2s.push_back({base_path + "/" + SUBSOLVER0_DENSE1_WEIGHTS_PREFIX + std::to_string(i) + ".txt",
                                SUBSOLVER0_LAYER_WEIGHTS_PART_SIZE,
                                "mm2s_pl:{layer1_weights_" + std::to_string(i) + "}"});
        }
        for (int i = 0; i < SUBSOLVER0_LAYER_WEIGHTS_PARTS; ++i) {
            cfg.mm2s.push_back({base_path + "/" + SUBSOLVER0_DENSE2_WEIGHTS_PREFIX + std::to_string(i) + ".txt",
                                SUBSOLVER0_LAYER_WEIGHTS_PART_SIZE,
                                "mm2s_pl:{layer2_weights_" + std::to_string(i) + "}"});
        }
        for (int i = 0; i < SUBSOLVER0_LAYER_WEIGHTS_PARTS; ++i) {
            cfg.mm2s.push_back({base_path + "/" + SUBSOLVER0_DENSE3_WEIGHTS_PREFIX + std::to_string(i) + ".txt",
                                SUBSOLVER0_LAYER_WEIGHTS_PART_SIZE,
                                "mm2s_pl:{layer3_weights_" + std::to_string(i) + "}"});
        }
        // Biases
        std::vector<std::string> bias_files = {SUBSOLVER0_DENSE0_BIAS, SUBSOLVER0_DENSE1_BIAS,
                                               SUBSOLVER0_DENSE2_BIAS, SUBSOLVER0_DENSE3_BIAS};
        for (int i = 0; i < 4; ++i) {
            cfg.mm2s.push_back({base_path + "/" + bias_files[i],
                                SUBSOLVER0_LAYER_BIAS_SIZE,
                                "mm2s_pl:{bias" + std::to_string(i) + "}"});
        }
        // Inputs for layer 0
        for (int i = 0; i < SUBSOLVER0_INPUT_PARTS; ++i) {
            cfg.mm2s.push_back({base_path + "/" + SUBSOLVER0_INPUT_DATA_PREFIX + std::to_string(i) + ".txt",
                                SUBSOLVER0_INPUT_PART_SIZE,
                                "mm2s_pl:{layer0_in_" + std::to_string(i) + "}"});
        }
        cfg.relus = {"leaky_relu_pl:{relu0}", "leaky_relu_pl:{relu1}", "leaky_relu_pl:{relu2}", "leaky_relu_pl:{relu3}"};
        cfg.splitters = {"leaky_splitter_pl:{split0}", "leaky_splitter_pl:{split1}", "leaky_splitter_pl:{split2}"};
        cfg.s2mm = "s2mm_pl:{s2mm_out}";
        cfg.output_file = base_path + "/" + SUBSOLVER0_HOST_OUTPUT;
        cfg.output_size = SUBSOLVER0_FINAL_OUTPUT_SIZE;
        cfg.relu_size = HIDDEN_SIZE;
        return cfg;
    } else if (graph == "aieml3") {
        GraphConfig cfg;
        cfg.mm2s = {
            {base_path + "/" + OUTPUT_DENSE0_WEIGHTS, OUTPUT_DENSE0_WEIGHTS_SIZE, "mm2s_pl:{mm2s_weights}"},
            {base_path + "/" + OUTPUT_DENSE0_BIAS,    OUTPUT_DENSE0_BIAS_SIZE,    "mm2s_pl:{mm2s_bias}"},
            {base_path + "/" + OUTPUT_INPUT_DATA,     OUTPUT_DENSE0_INPUT_SIZE,   "mm2s_pl:{mm2s_din}"},
        };
        cfg.relus = {"leaky_relu_pl:{relu}"};
        cfg.splitters = {};
        cfg.s2mm = "s2mm_pl:{s2mm_out}";
        cfg.output_file = base_path + "/" + OUTPUT_HOST_OUTPUT;
        cfg.output_size = OUTPUT_FINAL_OUTPUT_SIZE;
        cfg.relu_size = OUTPUT_DENSE0_OUT_PAD;
        return cfg;
    } else {
        throw std::runtime_error("Unknown graph selection: " + graph);
    }
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cout << "Usage: " << argv[0] << " <a.xclbin>\n";
        return 1;
    }

    const std::string xclbinFilename = argv[1];
    const std::string base_path = "./data";

    // Use the single variable above instead of a command-line option
    GraphConfig cfg = make_config(kGraphName, base_path);

    try {
        xrt::device device(0);
        xrt::xclbin xclbin(xclbinFilename);
        auto xclbin_uuid = device.load_xclbin(xclbin);

        // Load inputs/weights/biases into device buffers
        std::vector<xrt::bo> mm2s_bos;
        mm2s_bos.reserve(cfg.mm2s.size());
        for (auto& spec : cfg.mm2s) {
            auto data = read_file_to_vector(spec.file, spec.size);
            xrt::bo bo(device, data.size() * sizeof(float), xrt::bo::flags::normal, 0);
            bo.write(data.data());
            bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
            mm2s_bos.push_back(std::move(bo));
        }
        xrt::bo output_buf(device, cfg.output_size * sizeof(float), xrt::bo::flags::normal, 0);

        // Acquire kernel and graph handles
        std::vector<xrt::kernel> mm2s_kernels;
        for (auto& spec : cfg.mm2s) {
            mm2s_kernels.emplace_back(device, xclbin_uuid, spec.kernel.c_str());
        }
        std::vector<xrt::kernel> relu_kernels;
        for (auto& name : cfg.relus) {
            relu_kernels.emplace_back(device, xclbin_uuid, name.c_str());
        }
        std::vector<xrt::kernel> split_kernels;
        for (auto& name : cfg.splitters) {
            split_kernels.emplace_back(device, xclbin_uuid, name.c_str());
        }
        xrt::kernel s2mm_kernel(device, xclbin_uuid, cfg.s2mm.c_str());
        xrt::graph  aie_graph(device, xclbin_uuid, "g");

        // Start consumer kernels
        auto s2mm_run = xrt::run(s2mm_kernel);
        s2mm_run.set_arg(1, output_buf);
        s2mm_run.set_arg(2, cfg.output_size);
        s2mm_run.start();

        std::vector<xrt::run> relu_runs;
        for (auto& k : relu_kernels) {
            auto r = xrt::run(k);
            r.set_arg(3, cfg.relu_size);
            r.start();
            relu_runs.push_back(std::move(r));
        }
        std::vector<xrt::run> split_runs;
        for (auto& k : split_kernels) { auto r = xrt::run(k); r.start(); split_runs.push_back(std::move(r)); }

        // Run AIE graph
        aie_graph.run(1);

        // Start producers
        std::vector<xrt::run> mm2s_runs;
        for (size_t i = 0; i < mm2s_kernels.size(); ++i) {
            auto run = xrt::run(mm2s_kernels[i]);
            run.set_arg(0, mm2s_bos[i]);
            run.set_arg(2, cfg.mm2s[i].size);
            run.start();
            mm2s_runs.push_back(std::move(run));
        }

        for (auto& r : mm2s_runs) r.wait();
        aie_graph.wait();
        s2mm_run.wait();

        // Retrieve results
        std::vector<float> host_output_data(cfg.output_size);
        output_buf.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        output_buf.read(host_output_data.data());

        std::ofstream out(cfg.output_file);
        for (int i = 0; i < cfg.output_size; ++i) {
            std::cout << host_output_data[i] << '\n';
            out << host_output_data[i] << '\n';
        }
    } catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return 1;
    }
    return 0;
}
