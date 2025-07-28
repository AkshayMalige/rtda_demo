#include <iostream>
#include <fstream>
#include <cstring>

#include "experimental/xrt_kernel.h"
#include "experimental/xrt_graph.h"
#include "experimental/xrt_device.h"

int main(int argc, char** argv) {
    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <aie.xclbin>" << std::endl;
        return 1;
    }

    std::string xclbinFilename = argv[1];

    try {
        std::cout << "Opening device 0..." << std::endl;
        xrt::device device(0);

        std::cout << "Loading xclbin: " << xclbinFilename << std::endl;
        xrt::xclbin xclbin(xclbinFilename);
        auto xclbin_uuid = device.load_xclbin(xclbin);

        std::cout << "Initializing graph instance..." << std::endl;
        xrt::graph cghdl = xrt::graph(device, xclbin_uuid, "graph_instance");
        
        std::cout << "Initializing PL kernels..." << std::endl;
        // xrt::kernel leaky_relu = xrt::kernel(device, xclbin_uuid, "leaky_relu_pl");
        // auto pl_run = leaky_relu.run();

        std::cout << "Starting AIEML graph..." << std::endl;
        cghdl.run();  // Starts the graph (returns void)

        std::cout << "Graph running... press Ctrl+C to terminate." << std::endl;


        // // Keep the process alive to avoid exiting
        // while (true) {
        //     sleep(1);
        // }

        std::cout << "Execution finished." << std::endl;

    } catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}