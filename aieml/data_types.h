#pragma once
#include <cstdint>

#define USE_INT16 1

#if USE_INT16
using int16 = int16_t;
using DATA_TYPE = int16;
#else
using DATA_TYPE = float;
#endif
