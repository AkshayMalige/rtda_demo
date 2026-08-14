#ifndef DEFINES_H_
#define DEFINES_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "nnet_utils/nnet_types.h"

// -------------------------------------------------------------------------
// PRECISION: hls4ml generated this file with ap_fixed<16,6> and ap_fixed<32,18>
// written out literally at every one of these typedefs. They now resolve
// through ../../src/rtda_fixed.h, so the whole design's format is one
// build-time knob (AP_W / AP_I) and cannot drift between blocks.
// Nothing else about this file changed.
// -------------------------------------------------------------------------
#include "rtda_fixed.h"

#include <array>
#include <cstddef>
#include <cstdio>
#include <tuple>
#include <tuple>


// hls-fpga-machine-learning insert numbers

// hls-fpga-machine-learning insert layer-precision
typedef nnet::array<rtda_act_t, 128*1> input_t;
typedef rtda_accum_t out_dense_accum_t;
typedef nnet::array<rtda_out_t, 27*1> result_t;
typedef rtda_weight_t model_default_t;
typedef ap_uint<1> layer2_index;

// hls-fpga-machine-learning insert emulator-defines


#endif
