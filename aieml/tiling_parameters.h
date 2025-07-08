#pragma once

#include "system_settings.h"// Base tile sizes
#define TILE_WIDTH 1
#define TILE_HEIGHT 1

// Vectorization width (used in dense + relu kernels)
#define VEC_WIDTH 16
#define VEC_WIDTH_D1 16
#define VEC_WIDTH_D2 2


// Safety checks (optional in kernels)
static_assert(HIDDEN_SIZE % VEC_WIDTH == 0, "HIDDEN_SIZE must be divisible by VEC_WIDTH");