#include <iostream>
#include <fstream>
#include <vector>
// #include <adf/adf_api/XRTConfig.h>
#include "graph.h" // Includes the graph definition

// Helper function to load float data from a text file
std::vector<float> load_data_from_file(const std::string& filename, int count) {
    std::vector<float> data;
    data.reserve(count);
    std::ifstream file(filename);
    if (!file.is_open()) {
        std::cerr << "Error: Could not open file " << filename << std::endl;
        exit(1);
    }
    float val;
    while (file >> val && data.size() < count) {
        data.push_back(val);
    }
    // If file has fewer values than expected, pad with zeros
    while (data.size() < count) {
        data.push_back(0.0f);
    }
    file.close();
    return data;
}

int main(int argc, char** argv) {
    std::cout << "------------------------------------------------" << std::endl;
    std::cout << "Starting Two-Layer Dense Network AIE Simulation" << std::endl;
    std::cout << "------------------------------------------------" << std::endl;

    // Instantiate the graph
    NeuralNetworkGraph myGraph;

    // --- Load Weights ---
    std::cout << "Loading weights for Dense Layer 1..." << std::endl;
    // auto weights1 = load_data_from_file("data/weights_dense1.txt", DENSE1_M * DENSE1_N);

    std::cout << "Loading weights for Dense Layer 2..." << std::endl;
    // auto weights2 = load_data_from_file("data/weights_dense2.txt", DENSE2_M * DENSE2_N);

    // --- Graph Initialization and Execution ---
    myGraph.init();
    std::cout << "Graph initialized." << std::endl;

    // --- Corrected RTP Update ---
    // The RTP update string must match the hierarchical name of the port in the graph.
    // Since the weights port is named 'inA', we use "denseLayer1.inA".
    // myGraph.update("denseLayer1.inA", weights1.data(), weights1.size());
    // std::cout << "Dense Layer 1 weights updated via RTP to port 'inA'." << std::endl;
    
    // myGraph.update("denseLayer2.inA", weights2.data(), weights2.size());
    // std::cout << "Dense Layer 2 weights updated via RTP to port 'inA'." << std::endl;

    // Run the graph for a single transaction
    std::cout << "Running graph for 1 iteration..." << std::endl;
    myGraph.run();
    std::cout << "Graph run complete." << std::endl;

    // End the simulation
    myGraph.end();
    std::cout << "Graph execution ended." << std::endl;

    std::cout << "------------------------------------------------" << std::endl;
    std::cout << "Simulation finished successfully." << std::endl;
    std::cout << "Output for dense layer 1 written to: data/output_data1.txt" << std::endl;
    std::cout << "Output for dense layer 2 written to: data/output_data2.txt" << std::endl;
    std::cout << "------------------------------------------------" << std::endl;

    return 0;
}
