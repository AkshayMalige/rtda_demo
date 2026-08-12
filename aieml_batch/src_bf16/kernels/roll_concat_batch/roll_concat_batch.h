#pragma once
#include <adf.h>
#include <aie_api/aie.hpp>

// ---------------------------------------------------------------------------
// Batched roll-concat.
//
// aieml/roll_concat.cpp does this one track at a time with a static history
// buffer. Here a whole block of TRACKS tracks is resident, so the "previous
// track" is simply the row above -- a register-level offset, not data movement.
// Only the first row of a block needs anything remembered: the last row of the
// block before it, carried in a TRACKS-independent FEAT-wide static.
//
//   out[t][0     .. FEAT-1  ] = in[t]            current track
//   out[t][FEAT  .. 2*FEAT-1] = in[t-1]          previous track
//                               (t == 0 -> carry from the previous block)
//
// The buffer layout is [track][feature]: an ADF tiling descriptor lists
// dimensions innermost-first, so buffer_dimension {FEAT, TRACKS} means feature
// varies fastest and linear index = track*FEAT + feature.
//
// DIFFERENCE FROM THE REFERENCE, deliberate: the model's roll is *circular*
// over a 50-track event -- track 0 pairs with track 49. A streaming graph
// cannot do that without buffering the whole event, so track 0 of the first
// block pairs with zeros instead. That perturbs track 0 only, which is already
// excluded by WARMUP = 3 (the network's receptive field is 4 tracks deep, so
// the reference's first three outputs are contaminated anyway).
// ---------------------------------------------------------------------------
// Not a template: aiecompiler emits its own wrapper that explicitly instantiates
// the kernel, which collides with an explicit instantiation here
// ("duplicate explicit instantiation"). The graph only ever needs one shape.
constexpr int RCB_TRACKS = 8;    // BATCH
constexpr int RCB_FEAT   = 128;  // HIDDEN_SIZE

void roll_concat_batch(adf::input_buffer<bfloat16>& __restrict in,
                       adf::output_buffer<bfloat16>& __restrict out);
