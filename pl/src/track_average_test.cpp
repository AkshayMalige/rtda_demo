#include <iostream>
#include <vector>
#include <cmath>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;

extern "C" void track_average_pl(hls::stream<axis_t>& s, float* mem, int size, int threshold);

static constexpr int VECTOR_SIZE = 128;
static constexpr int TOTAL_FRAMES = 10;
static constexpr int THRESHOLD = 5;
static constexpr int INPUT_SIZE = TOTAL_FRAMES * VECTOR_SIZE;
static constexpr int OUTPUT_FRAMES = TOTAL_FRAMES / THRESHOLD;
static constexpr int OUTPUT_SIZE = OUTPUT_FRAMES * VECTOR_SIZE;

int main() {
    hls::stream<axis_t> s_in;
    std::vector<data_t> input(INPUT_SIZE);

    for (int i = 0; i < INPUT_SIZE; ++i) {
        data_t val = static_cast<data_t>((i % 17) - 8);
        input[i] = val;
        axis_t packet;
        packet.data = val;
        packet.keep = -1;
        packet.last = ((i + 1) % VECTOR_SIZE) == 0;
        s_in.write(packet);
    }

    std::vector<data_t> output(OUTPUT_SIZE, 0.0f);
    track_average_pl(s_in, output.data(), INPUT_SIZE, THRESHOLD);

    bool pass = true;
    for (int frame = 0; frame < OUTPUT_FRAMES; ++frame) {
        for (int elem = 0; elem < VECTOR_SIZE; ++elem) {
            data_t sum = 0.0f;
            for (int sample = 0; sample < THRESHOLD; ++sample) {
                sum += input[(frame * THRESHOLD + sample) * VECTOR_SIZE + elem];
            }
            data_t expected = sum / static_cast<data_t>(THRESHOLD);
            data_t actual = output[frame * VECTOR_SIZE + elem];
            if (std::fabs(actual - expected) > 1e-5f) {
                std::cerr << "Mismatch frame " << frame
                          << " element " << elem
                          << ": expected " << expected
                          << ", got " << actual << std::endl;
                pass = false;
                break;
            }
        }
    }

    if (pass) {
        std::cout << "Test PASSED – averages computed correctly for "
                  << OUTPUT_FRAMES << " frames." << std::endl;
    } else {
        std::cout << "Test FAILED." << std::endl;
    }

    return pass ? 0 : 1;
}
