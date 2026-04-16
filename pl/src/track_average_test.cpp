#include <iostream>
#include <vector>
#include <cmath>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <ap_int.h>

// Data type selection via preprocessor
#ifdef USE_INT16
    typedef ap_int<16> data_t;
    typedef int32_t accum_t;
    typedef ap_int<32> stream_t;  // 32-bit stream to match plio_32_bits
    typedef int32_t mem_t;        // 32-bit memory port to avoid cosim issues
    #define DATA_TYPE_NAME "INT16"
#else  // USE_FLOAT32 or default
    typedef float data_t;
    typedef float accum_t;
    typedef float stream_t;
    typedef float mem_t;
    #define DATA_TYPE_NAME "FLOAT32"
#endif

typedef hls::axis<stream_t, 0, 0, 0> axis_t;  // Always 32-bit AXI stream

extern "C" void track_average_pl(hls::stream<axis_t>& s, mem_t* mem, int size, int threshold);

static constexpr int VECTOR_SIZE = 128;
static constexpr int TOTAL_FRAMES = 10;
static constexpr int THRESHOLD = 5;
static constexpr int INPUT_SIZE = TOTAL_FRAMES * VECTOR_SIZE;
static constexpr int OUTPUT_FRAMES = TOTAL_FRAMES / THRESHOLD;
static constexpr int OUTPUT_SIZE = OUTPUT_FRAMES * VECTOR_SIZE;

int main() {
    std::cout << "\n\n=== Testing with " << DATA_TYPE_NAME << " ===" << std::endl;

    hls::stream<axis_t> s_in;
    std::vector<data_t> input(INPUT_SIZE);

    // Generate test input
    for (int i = 0; i < INPUT_SIZE; ++i) {
#ifdef USE_INT16
        // For int16: use values in reasonable range
        data_t val = static_cast<data_t>((i % 17) - 8);
#else
        // For float: use same pattern
        data_t val = static_cast<data_t>((i % 17) - 8);
#endif
        input[i] = val;
        axis_t packet;
#ifdef USE_INT16
        packet.data = static_cast<stream_t>(val);  // Pack int16 into 32-bit stream word
#else
        packet.data = val;
#endif
        packet.keep = -1;
        packet.last = ((i + 1) % VECTOR_SIZE) == 0;
        s_in.write(packet);
    }

    std::vector<mem_t> output(OUTPUT_SIZE, 0);

    track_average_pl(s_in, output.data(), INPUT_SIZE, THRESHOLD);

    // Verify results
    bool pass = true;
    for (int frame = 0; frame < OUTPUT_FRAMES; ++frame) {
        for (int elem = 0; elem < VECTOR_SIZE; ++elem) {
            accum_t sum = 0;
            for (int sample = 0; sample < THRESHOLD; ++sample) {
                sum += static_cast<accum_t>(input[(frame * THRESHOLD + sample) * VECTOR_SIZE + elem]);
            }

#ifdef USE_INT16
            // For int16: integer division; mem stores int16 sign-extended in int32
            int16_t expected = static_cast<int16_t>(sum / THRESHOLD);
            int16_t actual = static_cast<int16_t>(output[frame * VECTOR_SIZE + elem]);
            if (actual != expected) {
                std::cerr << "Mismatch frame " << frame
                          << " element " << elem
                          << ": expected " << expected
                          << ", got " << actual << std::endl;
                pass = false;
                break;
            }
#else
            float expected = sum / static_cast<accum_t>(THRESHOLD);
            float actual = output[frame * VECTOR_SIZE + elem];
            if (std::fabs(actual - expected) > 1e-5f) {
                std::cerr << "Mismatch frame " << frame
                          << " element " << elem
                          << ": expected " << expected
                          << ", got " << actual << std::endl;
                pass = false;
                break;
            }
#endif
        }
        if (!pass) break;
    }

    if (pass) {
        std::cout << "Test PASSED – averages computed correctly for "
                  << OUTPUT_FRAMES << " frames using " << DATA_TYPE_NAME << ".\n\n" << std::endl;
    } else {
        std::cout << "Test FAILED.\n\n" << std::endl;
    }

    return pass ? 0 : 1;
}
