#include <iostream>
#include <fstream>
#include <vector>
#include "experimental/xrt_kernel.h"
#include "experimental/xrt_graph.h"
#include "experimental/xrt_device.h"
#include "experimental/xrt_bo.h"
#include "data_paths.h"

// --- Define sizes for all data buffers based on the graph architecture ---

// dense8x128 layer
#define DENSE1_INPUT_SIZE   8
#define DENSE1_WEIGHTS_SIZE (128 * 8)

// dense128x128 layer (split into 2 cascades)
#define DENSE2_WEIGHTS_SIZE_PART (128 * 128 / 2)
#define FINAL_OUTPUT_SIZE   128

// Helper function to read a file into a vector
std::vector<float> read_file_to_vector(const std::string& filename, int size) {
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
    if (data.size() != size) {
        throw std::runtime_error("ERROR: File " + filename + " does not contain the expected " + std::to_string(size) + " elements.");
    }
    return data;
}

int main(int argc, char** argv) {
    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <a.xclbin>" << std::endl;
        return 1;
    }

    std::string xclbinFilename = argv[1];

    // --- Build file paths from a single configurable base directory ---
    std::string base_path = DATA_DIR;
    std::string inputDataFile      = base_path + "/" + INPUT_DATA_FILE;
    std::string weights1File       = base_path + "/" + WEIGHTS_DENSE1_FILE;
    std::string weights2_part0File = base_path + "/" + WEIGHTS_DENSE2_PREFIX + "0.txt";
    std::string weights2_part1File = base_path + "/" + WEIGHTS_DENSE2_PREFIX + "1.txt";

    try {
        xrt::device device(0);
        xrt::xclbin xclbin(xclbinFilename);
        auto xclbin_uuid = device.load_xclbin(xclbin);

        // --- 1. Read all input files from hardcoded paths ---
        auto input_data = read_file_to_vector(inputDataFile, DENSE1_INPUT_SIZE);
        auto weights1_data = read_file_to_vector(weights1File, DENSE1_WEIGHTS_SIZE);
        auto weights2_part0_data = read_file_to_vector(weights2_part0File, DENSE2_WEIGHTS_SIZE_PART);
        auto weights2_part1_data = read_file_to_vector(weights2_part1File, DENSE2_WEIGHTS_SIZE_PART);

        // --- 2. Allocate all device buffers (inputs and output) ---
        xrt::bo input_buf = xrt::bo(device, input_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo weights1_buf = xrt::bo(device, weights1_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo weights2_part0_buf = xrt::bo(device, weights2_part0_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo weights2_part1_buf = xrt::bo(device, weights2_part1_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo output_buf = xrt::bo(device, FINAL_OUTPUT_SIZE * sizeof(float), xrt::bo::flags::normal, 0);

        // Write input data to device buffers
        input_buf.write(input_data.data());
        weights1_buf.write(weights1_data.data());
        weights2_part0_buf.write(weights2_part0_data.data());
        weights2_part1_buf.write(weights2_part1_data.data());
        input_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        weights1_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        weights2_part0_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        weights2_part1_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);

        // --- 3. Get Handles to all components using instance names from linker.cfg ---
        xrt::kernel mm2s_data = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_din}");
        xrt::kernel mm2s_weights1 = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_weights1}");
        xrt::kernel mm2s_weights2_0 = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_weights2_0}");
        xrt::kernel mm2s_weights2_1 = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_weights2_1}");
        xrt::kernel relu = xrt::kernel(device, xclbin_uuid, "leaky_relu_pl:{relu}");
        xrt::kernel splitter = xrt::kernel(device, xclbin_uuid, "leaky_splitter_pl:{splitter}");
        xrt::kernel s2mm = xrt::kernel(device, xclbin_uuid, "s2mm_pl:{s2mm_out}");
        xrt::graph aie_graph = xrt::graph(device, xclbin_uuid, "g");

        // --- 4. Start all CONSUMER kernels FIRST ---
        // These kernels wait for data: s2mm, relu, splitter.
        auto s2mm_run = xrt::run(s2mm);
        s2mm_run.set_arg(1, output_buf); // Assumes s2mm has mem pointer at arg 1
        s2mm_run.set_arg(2, FINAL_OUTPUT_SIZE);
        s2mm_run.start();

        auto relu_run = xrt::run(relu);
        relu_run.start();

        auto splitter_run = xrt::run(splitter);
        splitter_run.start();

        // --- 5. Start the AIE graph ---
        aie_graph.run(); // Run the graph for one full iteration

        // --- 6. Start all PRODUCER kernels LAST ---
        // These kernels generate data: all mm2s instances.  void mm2s_pl(float* mem, hls::stream<axis_t> &s, int size) {

        auto mm2s_weights1_run = xrt::run(mm2s_weights1);
        mm2s_weights1_run.set_arg(0, weights1_buf);
        mm2s_weights1_run.set_arg(2, DENSE1_WEIGHTS_SIZE);
        mm2s_weights1_run.start();

        auto mm2s_weights2_0_run = xrt::run(mm2s_weights2_0);
        mm2s_weights2_0_run.set_arg(0, weights2_part0_buf);
        mm2s_weights2_0_run.set_arg(2, DENSE2_WEIGHTS_SIZE_PART);
        mm2s_weights2_0_run.start();

        auto mm2s_weights2_1_run = xrt::run(mm2s_weights2_1);
        mm2s_weights2_1_run.set_arg(0, weights2_part1_buf);
        mm2s_weights2_1_run.set_arg(2, DENSE2_WEIGHTS_SIZE_PART);
        mm2s_weights2_1_run.start();
        
        // Start the main data kernel last to kick off the whole process
        auto mm2s_data_run = xrt::run(mm2s_data);
        mm2s_data_run.set_arg(0, input_buf);
        mm2s_data_run.set_arg(2, DENSE1_INPUT_SIZE);
        mm2s_data_run.start();

        // --- 7. Wait for the entire pipeline to complete ---
        // We only need to wait for the final kernel in the chain (s2mm)
        // and the input kernels to finish sending their data.
        std::cout << "Waiting for kernels to complete..." << std::endl;
        mm2s_data_run.wait();
        s2mm_run.wait();
        std::cout << "Execution finished." << std::endl;

        // --- 8. Read back and verify results ---
        std::cout << "Reading output data from device..." << std::endl;
        std::vector<float> host_output_data(FINAL_OUTPUT_SIZE);
        output_buf.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        output_buf.read(host_output_data.data());

        // Print first few values for verification
        std::cout << "Verification: First 5 output values:" << std::endl;
        for (int i = 0; i < FINAL_OUTPUT_SIZE; ++i) {
            std::cout << host_output_data[i] << std::endl;
        }

    } catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}
