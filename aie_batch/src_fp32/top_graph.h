#pragma once

#include <adf.h>
#include "graph_plan.h"

#include "dense_bias_relu_graph.h"
#include "roll_concat_batch.h"
#include "track_accum.h"

using namespace adf;

template<
  typename Cfg1,
  typename Cfg2,
  typename Cfg3,
  typename Cfg4,
  typename Cfg5,
  typename Cfg6,
  typename Cfg7,
  typename Cfg8,
  typename Cfg9,
  typename Cfg10,
  typename Cfg11,
  typename Cfg12,
  typename Cfg13,
  typename Cfg14
>
class top_graph : public graph {
public:

  adf::input_port  ifm [1];   // x only; the s{k}_in feeds are now internal (roll kernels)
#ifdef SYSTEM_BUILD
  adf::output_port ofm [1];   // only the event mean leaves the array
#else
  adf::output_port ofm [9];   // [0..7] per-stage debug taps, [8] = event tail
#endif


  adf::input_port wts1
    [Cfg1::CAS_NUM * Cfg1::CAS_LENGTH];
  adf::input_port bias1
    [Cfg1::CAS_NUM];
  adf::input_port wts2
    [Cfg2::CAS_NUM * Cfg2::CAS_LENGTH];
  adf::input_port bias2
    [Cfg2::CAS_NUM];
  adf::input_port wts3
    [Cfg3::CAS_NUM * Cfg3::CAS_LENGTH];
  adf::input_port bias3
    [Cfg3::CAS_NUM];
  adf::input_port wts4
    [Cfg4::CAS_NUM * Cfg4::CAS_LENGTH];
  adf::input_port bias4
    [Cfg4::CAS_NUM];
  adf::input_port wts5
    [Cfg5::CAS_NUM * Cfg5::CAS_LENGTH];
  adf::input_port bias5
    [Cfg5::CAS_NUM];
  adf::input_port wts6
    [Cfg6::CAS_NUM * Cfg6::CAS_LENGTH];
  adf::input_port bias6
    [Cfg6::CAS_NUM];
  adf::input_port wts7
    [Cfg7::CAS_NUM * Cfg7::CAS_LENGTH];
  adf::input_port bias7
    [Cfg7::CAS_NUM];
  adf::input_port wts8
    [Cfg8::CAS_NUM * Cfg8::CAS_LENGTH];
  adf::input_port bias8
    [Cfg8::CAS_NUM];
  adf::input_port wts9
    [Cfg9::CAS_NUM * Cfg9::CAS_LENGTH];
  adf::input_port bias9
    [Cfg9::CAS_NUM];
  adf::input_port wts10
    [Cfg10::CAS_NUM * Cfg10::CAS_LENGTH];
  adf::input_port bias10
    [Cfg10::CAS_NUM];
  adf::input_port wts11
    [Cfg11::CAS_NUM * Cfg11::CAS_LENGTH];
  adf::input_port bias11
    [Cfg11::CAS_NUM];
  adf::input_port wts12
    [Cfg12::CAS_NUM * Cfg12::CAS_LENGTH];
  adf::input_port bias12
    [Cfg12::CAS_NUM];
  adf::input_port wts13
    [Cfg13::CAS_NUM * Cfg13::CAS_LENGTH];
  adf::input_port bias13
    [Cfg13::CAS_NUM];
  adf::input_port wts14
    [Cfg14::CAS_NUM * Cfg14::CAS_LENGTH];
  adf::input_port bias14
    [Cfg14::CAS_NUM];

private:
  dense_bias_relu_graph<Cfg1>
    emb_d0_aie;
  dense_bias_relu_graph<Cfg2>
    emb_d1_aie;
  dense_bias_relu_graph<Cfg3>
    s0_d0_aie;
  dense_bias_relu_graph<Cfg4>
    s0_d1_aie;
  dense_bias_relu_graph<Cfg5>
    s0_d2_aie;
  dense_bias_relu_graph<Cfg6>
    s0_d3_aie;
  dense_bias_relu_graph<Cfg7>
    s1_d0_aie;
  dense_bias_relu_graph<Cfg8>
    s1_d1_aie;
  dense_bias_relu_graph<Cfg9>
    s1_d2_aie;
  dense_bias_relu_graph<Cfg10>
    s1_d3_aie;
  dense_bias_relu_graph<Cfg11>
    s2_d0_aie;
  dense_bias_relu_graph<Cfg12>
    s2_d1_aie;
  dense_bias_relu_graph<Cfg13>
    s2_d2_aie;
  dense_bias_relu_graph<Cfg14>
    s2_d3_aie;

  // Batched roll-concat, one per solver: turns the previous stage's
  // [TRACKS][128] block into the [TRACKS][256] the solver's dense0 expects.
  // Replaces the external s{k}_in graph inputs.
  adf::kernel roll0, roll1, roll2;

  // Track average + output dense, once per 50-track event.
  adf::kernel accum;

  adf::shared_buffer<float> buffer_x;
  adf::shared_buffer<float> buffer_r_e0;
  adf::shared_buffer<float> buffer_s0_in;
  adf::shared_buffer<float> buffer_r_s0_0;
  adf::shared_buffer<float> buffer_r_s0_1;
  adf::shared_buffer<float> buffer_r_s0_2;
  adf::shared_buffer<float> buffer_s1_in;
  adf::shared_buffer<float> buffer_r_s1_0;
  adf::shared_buffer<float> buffer_r_s1_1;
  adf::shared_buffer<float> buffer_r_s1_2;
  adf::shared_buffer<float> buffer_s2_in;
  adf::shared_buffer<float> buffer_r_s2_0;
  adf::shared_buffer<float> buffer_r_s2_1;
  adf::shared_buffer<float> buffer_r_s2_2;
  adf::shared_buffer<float> buffer_emb_out;
  adf::shared_buffer<float> buffer_s0_out;
  adf::shared_buffer<float> buffer_s1_out;
  adf::shared_buffer<float> buffer_s2_out;

  friend struct graph_plan<
    Cfg1,
    Cfg2,
    Cfg3,
    Cfg4,
    Cfg5,
    Cfg6,
    Cfg7,
    Cfg8,
    Cfg9,
    Cfg10,
    Cfg11,
    Cfg12,
    Cfg13,
    Cfg14
  >;

public:
  top_graph() {
    // Create the roll kernels before graph_plan wires them up.
    static_assert(Cfg3::padded_independent_extent == RCB_TRACKS,
                  "roll kernel is fixed at RCB_TRACKS; regenerate it if BATCH changes");
    roll0 = adf::kernel::create(roll_concat_batch);
    roll1 = adf::kernel::create(roll_concat_batch);
    roll2 = adf::kernel::create(roll_concat_batch);
    accum = adf::kernel::create(track_accum);
    adf::source(accum) = "kernels/track_accum/track_accum.cpp";
    adf::runtime<ratio>(accum) = 0.9;
    for (auto* k : {&roll0, &roll1, &roll2}) {
      adf::source(*k) = "kernels/roll_concat_batch/roll_concat_batch.cpp";
      // Pure data movement, but it sits on the critical path between stages;
      // give it a whole tile rather than let the mapper share one.
      adf::runtime<ratio>(*k) = 0.9;
    }

    graph_plan<
      Cfg1,
      Cfg2,
      Cfg3,
      Cfg4,
      Cfg5,
      Cfg6,
      Cfg7,
      Cfg8,
      Cfg9,
      Cfg10,
      Cfg11,
      Cfg12,
      Cfg13,
      Cfg14
    >::configure(*this);

    for (int ch = 0; ch < Cfg1::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg1::CAS_LENGTH; ++col) {
        int idx = ch * Cfg1::CAS_LENGTH + col;
        connect<>(
          wts1[idx],
          emb_d0_aie.wts[idx]
        );
      }

      connect<>(
        bias1[ch],
        emb_d0_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg2::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg2::CAS_LENGTH; ++col) {
        int idx = ch * Cfg2::CAS_LENGTH + col;
        connect<>(
          wts2[idx],
          emb_d1_aie.wts[idx]
        );
      }

      connect<>(
        bias2[ch],
        emb_d1_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg3::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg3::CAS_LENGTH; ++col) {
        int idx = ch * Cfg3::CAS_LENGTH + col;
        connect<>(
          wts3[idx],
          s0_d0_aie.wts[idx]
        );
      }

      connect<>(
        bias3[ch],
        s0_d0_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg4::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg4::CAS_LENGTH; ++col) {
        int idx = ch * Cfg4::CAS_LENGTH + col;
        connect<>(
          wts4[idx],
          s0_d1_aie.wts[idx]
        );
      }

      connect<>(
        bias4[ch],
        s0_d1_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg5::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg5::CAS_LENGTH; ++col) {
        int idx = ch * Cfg5::CAS_LENGTH + col;
        connect<>(
          wts5[idx],
          s0_d2_aie.wts[idx]
        );
      }

      connect<>(
        bias5[ch],
        s0_d2_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg6::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg6::CAS_LENGTH; ++col) {
        int idx = ch * Cfg6::CAS_LENGTH + col;
        connect<>(
          wts6[idx],
          s0_d3_aie.wts[idx]
        );
      }

      connect<>(
        bias6[ch],
        s0_d3_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg7::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg7::CAS_LENGTH; ++col) {
        int idx = ch * Cfg7::CAS_LENGTH + col;
        connect<>(
          wts7[idx],
          s1_d0_aie.wts[idx]
        );
      }

      connect<>(
        bias7[ch],
        s1_d0_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg8::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg8::CAS_LENGTH; ++col) {
        int idx = ch * Cfg8::CAS_LENGTH + col;
        connect<>(
          wts8[idx],
          s1_d1_aie.wts[idx]
        );
      }

      connect<>(
        bias8[ch],
        s1_d1_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg9::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg9::CAS_LENGTH; ++col) {
        int idx = ch * Cfg9::CAS_LENGTH + col;
        connect<>(
          wts9[idx],
          s1_d2_aie.wts[idx]
        );
      }

      connect<>(
        bias9[ch],
        s1_d2_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg10::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg10::CAS_LENGTH; ++col) {
        int idx = ch * Cfg10::CAS_LENGTH + col;
        connect<>(
          wts10[idx],
          s1_d3_aie.wts[idx]
        );
      }

      connect<>(
        bias10[ch],
        s1_d3_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg11::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg11::CAS_LENGTH; ++col) {
        int idx = ch * Cfg11::CAS_LENGTH + col;
        connect<>(
          wts11[idx],
          s2_d0_aie.wts[idx]
        );
      }

      connect<>(
        bias11[ch],
        s2_d0_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg12::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg12::CAS_LENGTH; ++col) {
        int idx = ch * Cfg12::CAS_LENGTH + col;
        connect<>(
          wts12[idx],
          s2_d1_aie.wts[idx]
        );
      }

      connect<>(
        bias12[ch],
        s2_d1_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg13::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg13::CAS_LENGTH; ++col) {
        int idx = ch * Cfg13::CAS_LENGTH + col;
        connect<>(
          wts13[idx],
          s2_d2_aie.wts[idx]
        );
      }

      connect<>(
        bias13[ch],
        s2_d2_aie.bias[ch]
      );
    }
    for (int ch = 0; ch < Cfg14::CAS_NUM; ++ch) {
      for (int col = 0; col < Cfg14::CAS_LENGTH; ++col) {
        int idx = ch * Cfg14::CAS_LENGTH + col;
        connect<>(
          wts14[idx],
          s2_d3_aie.wts[idx]
        );
      }

      connect<>(
        bias14[ch],
        s2_d3_aie.bias[ch]
      );
    }

    emb_d0_aie.place_graph(
      Cfg1::col_placement,
      Cfg1::row_placement
    );
    emb_d1_aie.place_graph(
      Cfg2::col_placement,
      Cfg2::row_placement
    );
    s0_d0_aie.place_graph(
      Cfg3::col_placement,
      Cfg3::row_placement
    );
    s0_d1_aie.place_graph(
      Cfg4::col_placement,
      Cfg4::row_placement
    );
    s0_d2_aie.place_graph(
      Cfg5::col_placement,
      Cfg5::row_placement
    );
    s0_d3_aie.place_graph(
      Cfg6::col_placement,
      Cfg6::row_placement
    );
    s1_d0_aie.place_graph(
      Cfg7::col_placement,
      Cfg7::row_placement
    );
    s1_d1_aie.place_graph(
      Cfg8::col_placement,
      Cfg8::row_placement
    );
    s1_d2_aie.place_graph(
      Cfg9::col_placement,
      Cfg9::row_placement
    );
    s1_d3_aie.place_graph(
      Cfg10::col_placement,
      Cfg10::row_placement
    );
    s2_d0_aie.place_graph(
      Cfg11::col_placement,
      Cfg11::row_placement
    );
    s2_d1_aie.place_graph(
      Cfg12::col_placement,
      Cfg12::row_placement
    );
    s2_d2_aie.place_graph(
      Cfg13::col_placement,
      Cfg13::row_placement
    );
    s2_d3_aie.place_graph(
      Cfg14::col_placement,
      Cfg14::row_placement
    );
  }
};