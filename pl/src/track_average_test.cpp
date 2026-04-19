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

    for (int i = 0; i < INPUT_SIZE; ++i) {
        input[i] = static_cast<data_t>((i % 17) - 8);
    }

#ifdef USE_INT16
    // AIE-ML packs 2 int16 into each 32-bit beat (low half = N, high half = N+1).
    // Mirror that here so the kernel's int16 path is exercised the way hardware drives it.
    for (int b = 0; b < INPUT_SIZE / 2; ++b) {
        axis_t packet;
        stream_t word = 0;
        word.range(15, 0)  = input[2 * b];
        word.range(31, 16) = input[2 * b + 1];
        packet.data = word;
        packet.keep = -1;
        packet.last = ((2 * b + 2) % VECTOR_SIZE) == 0;
        s_in.write(packet);
    }
#else
    // float32: one element per 32-bit beat.
    for (int i = 0; i < INPUT_SIZE; ++i) {
        axis_t packet;
        packet.data = input[i];
        packet.keep = -1;
        packet.last = ((i + 1) % VECTOR_SIZE) == 0;
        s_in.write(packet);
    }
#endif

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
