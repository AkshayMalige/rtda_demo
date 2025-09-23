#include "graph.h"
#include "data_paths.h"

#include <array>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

NeuralNetworkGraph g;

#if defined(__AIESIM__) || defined(__X86SIM__)
namespace {

bool load_vector_from_file(const std::string& path, std::vector<float>& values,
                           std::size_t expected_count) {
    std::ifstream input(path);
    if (!input) {
        std::cerr << "ERROR: unable to open " << path << " for reading." << std::endl;
        return false;
    }

    values.clear();
    if (expected_count != 0U) {
        values.reserve(expected_count);
    }

    float value = 0.0f;
    while (input >> value) {
        values.push_back(value);
    }

    if (expected_count != 0U && values.size() != expected_count) {
        std::cerr << "ERROR: unexpected element count in " << path << " (got "
                  << values.size() << ", expected " << expected_count << ")." << std::endl;
        return false;
    }

    return true;
}

bool write_vector_to_file(const std::string& path, const std::vector<float>& values) {
    std::ofstream output(path);
    if (!output) {
        std::cerr << "ERROR: unable to open " << path << " for writing." << std::endl;
        return false;
    }

    output.setf(std::ios::fixed);
    output << std::setprecision(6);

    for (std::size_t i = 0; i < values.size(); ++i) {
        output << values[i];
        if (i + 1 < values.size()) {
            output << '\n';
        }
    }

    return true;
}

std::string make_data_path(const std::string& base_dir, const std::string& file_name) {
    if (base_dir.empty()) {
        return file_name;
    }
    if (base_dir.back() == '/') {
        return base_dir + file_name;
    }
    return base_dir + '/' + file_name;
}

} // namespace

int main() {
    std::string base_dir = DATA_DIR;
    const std::size_t layer1_input_part_size = HIDDEN_SIZE / TP_CASC_LEN_LAYER2;

    std::vector<float> layer0_in_values;
    std::vector<float> layer0_weight_values;
    std::array<std::vector<float>, TP_CASC_LEN_LAYER2> layer1_in_values;
    std::array<std::vector<float>, TP_CASC_LEN_LAYER2> layer1_weight_values;

    if (!load_vector_from_file(make_data_path(base_dir, EMBED_INPUT_DATA), layer0_in_values,
                               EMBED_DENSE0_INPUT_SIZE)) {
        return 1;
    }
    if (!load_vector_from_file(make_data_path(base_dir, EMBED_DENSE0_WEIGHTS),
                               layer0_weight_values, EMBED_DENSE0_WEIGHTS_SIZE)) {
        return 1;
    }

    for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        const std::string input_file =
            std::string(EMBED_LEAKYRELU0_OUTPUT_PREFIX) + std::to_string(i) + ".txt";
        const std::string weight_file =
            std::string(EMBED_DENSE1_WEIGHTS_PREFIX) + std::to_string(i) + ".txt";

        if (!load_vector_from_file(make_data_path(base_dir, input_file), layer1_in_values[i],
                                   layer1_input_part_size)) {
            return 1;
        }
        if (!load_vector_from_file(make_data_path(base_dir, weight_file),
                                   layer1_weight_values[i],
                                   EMBED_DENSE1_WEIGHTS_PART_SIZE)) {
            return 1;
        }
    }

    std::vector<float> layer0_out_values(HIDDEN_SIZE);
    std::vector<float> layer1_out_values(OUTPUT_SIZE);

    g.init();

    adf::event::handle h_layer0_in = g.layer0_in.gm2aie_nb(
        layer0_in_values.data(), layer0_in_values.size() * sizeof(float));
    adf::event::handle h_layer0_weights = g.layer0_weights.gm2aie_nb(
        layer0_weight_values.data(), layer0_weight_values.size() * sizeof(float));

    std::array<adf::event::handle, TP_CASC_LEN_LAYER2> h_layer1_in;
    std::array<adf::event::handle, TP_CASC_LEN_LAYER2> h_layer1_weights;
    for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        h_layer1_in[i] = g.layer1_in[i].gm2aie_nb(
            layer1_in_values[i].data(), layer1_in_values[i].size() * sizeof(float));
        h_layer1_weights[i] = g.layer1_weights[i].gm2aie_nb(
            layer1_weight_values[i].data(), layer1_weight_values[i].size() * sizeof(float));
    }

    adf::event::handle h_layer0_out =
        g.layer0_out.aie2gm_nb(layer0_out_values.data(),
                               layer0_out_values.size() * sizeof(float));
    adf::event::handle h_layer1_out =
        g.layer1_out.aie2gm_nb(layer1_out_values.data(),
                               layer1_out_values.size() * sizeof(float));

    g.run(1);
    g.wait();

    adf::event::wait(h_layer0_in);
    adf::event::wait(h_layer0_weights);
    for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        adf::event::wait(h_layer1_in[i]);
        adf::event::wait(h_layer1_weights[i]);
    }
    adf::event::wait(h_layer0_out);
    adf::event::wait(h_layer1_out);

    g.end();

    if (!write_vector_to_file(make_data_path(base_dir, EMBED_DENSE0_OUTPUT), layer0_out_values)) {
        return 1;
    }
    if (!write_vector_to_file(make_data_path(base_dir, EMBED_DENSE1_OUTPUT), layer1_out_values)) {
        return 1;
    }

    return 0;
}
#endif
