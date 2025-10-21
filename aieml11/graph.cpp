#include "graph.h"

#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <limits>
#include <string>
#include <vector>

NeuralNetworkGraph g;

constexpr int ITERATION = 2;
constexpr std::size_t INPUT_ELEMENTS_PER_ITERATION = static_cast<std::size_t>(INPUT_SIZE);
constexpr std::size_t OUTPUT_ELEMENTS_PER_ITERATION = static_cast<std::size_t>(HIDDEN_SIZE);
constexpr std::size_t TOTAL_INPUT_ELEMENT_COUNT =
    static_cast<std::size_t>(ITERATION) * INPUT_ELEMENTS_PER_ITERATION;
constexpr std::size_t TOTAL_OUTPUT_ELEMENT_COUNT =
    static_cast<std::size_t>(ITERATION) * OUTPUT_ELEMENTS_PER_ITERATION;
constexpr std::size_t INPUT_TRANSACTION_BYTES = TOTAL_INPUT_ELEMENT_COUNT * sizeof(float);
constexpr std::size_t OUTPUT_TRANSACTION_BYTES = TOTAL_OUTPUT_ELEMENT_COUNT * sizeof(float);

#if defined(__AIESIM__) || defined(__X86SIM__)
namespace {

std::vector<float> load_values(const std::string& path) {
    std::ifstream file(path);
    if (!file.is_open()) {
        std::cerr << "Error: Could not open file '" << path << "'" << std::endl;
        return {};
    }

    std::vector<float> values;
    float value = 0.0f;
    while (file >> value) {
        values.push_back(value);
    }
    return values;
}

bool write_values(const std::string& path, const float* values, std::size_t count) {
    std::ofstream file(path);
    if (!file.is_open()) {
        std::cerr << "Error: Could not open output file '" << path << "'" << std::endl;
        return false;
    }
    file << std::setprecision(std::numeric_limits<float>::max_digits10);
    for (std::size_t index = 0; index < count; ++index) {
        file << values[index] << '\n';
    }
    return true;
}

} // namespace

int main() {
    g.init();

    const std::string base_path = std::string(DATA_DIR) + "/";
    const std::string weights_path = base_path + EMBED_DENSE0_WEIGHTS;
    const std::string input_path = base_path + EMBED_INPUT_DATA;
    const std::string output_path = base_path + "aieml11_output_aie.txt";

    const auto weight_values = load_values(weights_path);
    if (weight_values.size() != static_cast<std::size_t>(EMBED_DENSE0_WEIGHTS_SIZE)) {
        std::cerr << "Error: Expected " << EMBED_DENSE0_WEIGHTS_SIZE << " values from '" << weights_path
                  << "', got " << weight_values.size() << std::endl;
        g.end();
        return 1;
    }
    g.update(g.embed_matrixA0_rtp, weight_values.data(), weight_values.size());

    const auto input_values = load_values(input_path);
    if (input_values.size() != TOTAL_INPUT_ELEMENT_COUNT) {
        std::cerr << "Error: Expected " << TOTAL_INPUT_ELEMENT_COUNT << " values from '" << input_path
                  << "', got " << input_values.size() << std::endl;
        g.end();
        return 1;
    }

    float* din_array = static_cast<float*>(adf::GMIO::malloc(INPUT_TRANSACTION_BYTES));
    float* dout_array = static_cast<float*>(adf::GMIO::malloc(OUTPUT_TRANSACTION_BYTES));
    if (din_array == nullptr || dout_array == nullptr) {
        std::cerr << "Error: GMIO::malloc failed" << std::endl;
        if (din_array != nullptr) {
            adf::GMIO::free(din_array);
        }
        if (dout_array != nullptr) {
            adf::GMIO::free(dout_array);
        }
        g.end();
        return 1;
    }

    std::memcpy(din_array, input_values.data(), INPUT_TRANSACTION_BYTES);

    auto gm2aie_status = g.gmioIn.gm2aie_nb(din_array, INPUT_TRANSACTION_BYTES);
    auto aie2gm_status = g.gmioOut.aie2gm_nb(dout_array, OUTPUT_TRANSACTION_BYTES);
    if (gm2aie_status != adf::return_code::ok || aie2gm_status != adf::return_code::ok) {
        std::cerr << "Error: GMIO transaction setup failed" << std::endl;
        adf::GMIO::free(din_array);
        adf::GMIO::free(dout_array);
        g.end();
        return 1;
    }

    g.run(ITERATION);
    g.wait();
    g.gmioIn.wait();
    g.gmioOut.wait();

    if (!write_values(output_path, dout_array, TOTAL_OUTPUT_ELEMENT_COUNT)) {
        adf::GMIO::free(din_array);
        adf::GMIO::free(dout_array);
        g.end();
        return 1;
    }

    adf::GMIO::free(din_array);
    adf::GMIO::free(dout_array);

    g.end();
    return 0;
}
#endif
