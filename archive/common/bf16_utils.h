#pragma once
#include <cstdint>
#include <cmath>
#include <cstring>

// Host-side bfloat16 utilities.
// We use uint16_t to store bfloat16 data.

inline uint16_t float_to_bfloat16(float f) {
    uint32_t x;
    std::memcpy(&x, &f, sizeof(float));
    // Round-to-nearest-even or simple truncation?
    // Bfloat16 is often just the top 16 bits.
    // A common rounding strategy: add 0x8000 to the lower 16 bits and check for overflow.
    // But for simplicity and standard truncation behavior often used:
    // return static_cast<uint16_t>(x >> 16);
    
    // Better rounding:
    if (std::isnan(f)) return 0x7FC0; // Quiet NaN
    
    uint32_t lsb = (x >> 16) & 1;
    uint32_t rounding_bias = 0x7FFF + lsb;
    x += rounding_bias;
    return static_cast<uint16_t>(x >> 16);
}

inline float bfloat16_to_float(uint16_t bf) {
    uint32_t x = static_cast<uint32_t>(bf) << 16;
    float f;
    std::memcpy(&f, &x, sizeof(float));
    return f;
}
