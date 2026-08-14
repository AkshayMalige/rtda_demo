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
typedef nnet::array<rtda_act_t, 128*1> input2_t;
typedef rtda_accum_t s1_d0_curr_accum_t;
typedef nnet::array<rtda_act_t, 128*1> layer3_t;
typedef rtda_weight_t model_default_t;
typedef ap_uint<1> layer3_index;
typedef rtda_accum_t s1_d0_prev_accum_t;
typedef nnet::array<rtda_act_t, 128*1> layer5_t;
typedef ap_uint<1> bias5_t;
typedef ap_uint<1> layer5_index;
typedef nnet::array<rtda_act_t, 128*1> layer7_t;
typedef nnet::array<rtda_act_t, 128*1> layer8_t;
typedef rtda_table_t s1_d0_act_table_t;
typedef rtda_accum_t s1_d1_accum_t;
typedef nnet::array<rtda_act_t, 128*1> layer9_t;
typedef ap_uint<1> layer9_index;
typedef nnet::array<rtda_act_t, 128*1> layer11_t;
typedef rtda_table_t s1_d1_act_table_t;
typedef rtda_accum_t s1_d2_accum_t;
typedef nnet::array<rtda_act_t, 128*1> layer12_t;
typedef ap_uint<1> layer12_index;
typedef nnet::array<rtda_act_t, 128*1> layer14_t;
typedef rtda_table_t s1_d2_act_table_t;
typedef rtda_accum_t s1_d3_accum_t;
typedef nnet::array<rtda_act_t, 128*1> layer15_t;
typedef ap_uint<1> layer15_index;
typedef nnet::array<rtda_act_t, 128*1> result_t;
typedef rtda_table_t s1_d3_act_table_t;

// hls-fpga-machine-learning insert emulator-defines


#endif
