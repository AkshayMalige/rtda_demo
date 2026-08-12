#pragma once
#include <adf.h>
#include <aie_api/aie.hpp>

// ---------------------------------------------------------------------------
// Event tail: track average + output dense.  Replaces pl/track_average_pl.
//
// The model ends (confirmed against punit/.../model_full.onnx's topology) with
//     ... -> LeakyRelu -> ReduceMean(over the track axis) -> Gemm(128->27)
// `aieml/` does the ReduceMean in PL and the Gemm on the host, because it only
// ever has one track in flight. Batched, both fit naturally in one AIE kernel.
//
// COUNTING, not zero-reliance. An event is TA_EVENT (50) tracks but the graph
// runs ceil(50/8) = 7 iterations of 8 = 56 slots, so 6 slots are padding. Those
// slots are NOT harmless: every dense layer has a bias, so a zero input track
// still produces a sizeable output (measured: |max| 0.13 against 0.49 for a real
// track). Summing all 56 and dividing by 50 would shift every element of the
// mean by ~6.6% of signal. So the kernel counts and stops at 50 -- the same
// guard pl/track_average_pl.cpp has as `window_count == threshold`.
//
// LIMITATION: it counts SLOTS CONSUMED, not real tracks -- it cannot tell the
// two apart, because by the time a zero-input slot reaches here it carries a
// bias-determined activation like any other. The count is only equivalent to
// "real tracks" because the host fills the FIRST 50 slots of each event with
// real tracks and pads the last 6.
//
// So EVERY EVENT MUST CARRY EXACTLY 50 REAL TRACKS. A short final event (a
// track count that is not a multiple of 50) makes this sum 50 slots of which
// only the first few are real, and the mean is wrong -- measured 8.0e-02 for an
// event with 20 real tracks, which is large but still plausible-looking. The
// host warns; sim_events.py --tracks warns. Fixing it properly needs the real
// count delivered per event (an RTP, or a sentinel slot), which is a design
// change, not a tweak.
//
// RATE. ADF buffer rates are static: a kernel wired to an output must write on
// every iteration. It emits ZEROS until the event completes and the mean on the
// completing iteration. Emitting zeros rather than a partial sum means the
// consumer does not need to know that 7 is the magic number -- it can sum all
// frames, or take the nonzero one, and stays correct if ITERS changes.
// ---------------------------------------------------------------------------
constexpr int TA_TRACKS = 8;    // BATCH: tracks per iteration
constexpr int TA_FEAT   = 128;  // HIDDEN_SIZE
constexpr int TA_EVENT  = 50;   // TRACK_AVERAGE_THRESHOLD (common/nn_defs10.h:41)

// Apply the 128->27 output dense here, or emit the 128-wide mean and let the
// host do it (which is what aieml/ does today, host/host.cpp:394).
//
// OFF by default. The dense operates on a SINGLE averaged vector, so it is an
// M=1 GEMV -- exactly the shape this project exists to avoid on AIE-ML. It is
// 3,456 MACs (0.03% of an event) but measured at 15-19 us however it is written,
// against 4.2 us for the whole 14-layer pipeline. On the host it is free.
#ifndef TA_OUTPUT_DENSE
#define TA_OUTPUT_DENSE 0
#endif

void track_accum(adf::input_buffer<float>& __restrict in,
                 adf::output_buffer<float>& __restrict out);
