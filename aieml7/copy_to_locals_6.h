#pragma once
#include <adf.h>

using namespace adf;

// Expose the kernels that fan out matrix weights from the preload buffers
// into per-leg local memories.  The implementations live in
// copy_to_locals_6.cpp, so this header remains safe to include from graph
// construction code that is compiled for x86.
extern "C" {

void copy768_lo(input_window<float>*  __restrict in,
                output_window<float>* __restrict o0,
                output_window<float>* __restrict o1,
                output_window<float>* __restrict o2,
                output_window<float>* __restrict o3,
                output_window<float>* __restrict o4,
                output_window<float>* __restrict o5);

void copy768_hi(input_window<float>*  __restrict in,
                output_window<float>* __restrict o0,
                output_window<float>* __restrict o1,
                output_window<float>* __restrict o2,
                output_window<float>* __restrict o3,
                output_window<float>* __restrict o4,
                output_window<float>* __restrict o5);

void copy128_all(input_window<float>*  __restrict in,
                 output_window<float>* __restrict o0,
                 output_window<float>* __restrict o1,
                 output_window<float>* __restrict o2,
                 output_window<float>* __restrict o3,
                 output_window<float>* __restrict o4,
                 output_window<float>* __restrict o5);

}
