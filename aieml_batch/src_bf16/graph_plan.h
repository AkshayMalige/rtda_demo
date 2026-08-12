#pragma once

// The per-stage debug taps (buffer_*_out -> ofm[0..7]) exist only for the PLIO
// simulation build, which drains them to text files. In SYSTEM_BUILD only the
// event mean leaves the array, so the taps are removed entirely -- leaving them
// connected to nothing deadlocks the graph: the buffer is still written each
// iteration but never read, so the producing stage blocks forever.
#ifdef SYSTEM_BUILD
  #define N_STAGE_RD 1
  #define EXTRA_RD   0
  #define TAIL_OFM   0
#else
  #define N_STAGE_RD 3
  #define EXTRA_RD   2
  #define TAIL_OFM   8
#endif

#include <adf.h>
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
struct graph_plan {
  template<typename GraphT>
  static void configure(GraphT& self) {
    self.buffer_x = adf::shared_buffer<bfloat16>::create(
      { 16, 8 },
      1,
      1
    );
    num_buffers(self.buffer_x) = 2;

    connect<>(self.ifm[0], self.buffer_x.in[0]);
    write_access(self.buffer_x.in[0]) = adf::tiling({
  .buffer_dimension = { 16, 8 },
  .tiling_dimension = { 16, 8 },
  .offset           = { 0, 0 }
});
    read_access(self.buffer_x.out[0]) = adf::tiling({
  .buffer_dimension = { 16, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=2 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 16, 8 }
});
    connect<>(self.buffer_x.out[0], self.emb_d0_aie.in1[0]);
    self.buffer_r_e0 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      1,
      2
    );
    num_buffers(self.buffer_r_e0) = 2;

    connect<>(self.emb_d0_aie.out1[0], self.buffer_r_e0.in[0]);
    write_access(self.buffer_r_e0.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=32 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_e0.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_e0.out[0], self.emb_d1_aie.in1[0]);
    read_access(self.buffer_r_e0.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_e0.out[1], self.emb_d1_aie.in1[1]);
    self.buffer_s0_in = adf::shared_buffer<bfloat16>::create(
      { 256, 8 },
      1,
      4
    );
    num_buffers(self.buffer_s0_in) = 2;
    adf::dimensions(self.roll0.in[0])  = { 128 * 8 };
    adf::dimensions(self.roll0.out[0]) = { 256 * 8 };
    connect<>(self.roll0.out[0], self.buffer_s0_in.in[0]);
    write_access(self.buffer_s0_in.in[0]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 256, 8 },
  .offset           = { 0, 0 }
});

    read_access(self.buffer_s0_in.out[0]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s0_in.out[0], self.s0_d0_aie.in1[0]);
    read_access(self.buffer_s0_in.out[1]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s0_in.out[1], self.s0_d0_aie.in1[1]);
    read_access(self.buffer_s0_in.out[2]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 128, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s0_in.out[2], self.s0_d0_aie.in1[2]);
    read_access(self.buffer_s0_in.out[3]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 192, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s0_in.out[3], self.s0_d0_aie.in1[3]);
    self.buffer_r_s0_0 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      2
    );
    num_buffers(self.buffer_r_s0_0) = 2;

    connect<>(self.s0_d0_aie.out1[0], self.buffer_r_s0_0.in[0]);
    write_access(self.buffer_r_s0_0.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s0_d0_aie.out1[1], self.buffer_r_s0_0.in[1]);
    write_access(self.buffer_r_s0_0.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_s0_0.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s0_0.out[0], self.s0_d1_aie.in1[0]);
    read_access(self.buffer_r_s0_0.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s0_0.out[1], self.s0_d1_aie.in1[1]);
    self.buffer_r_s0_1 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      2
    );
    num_buffers(self.buffer_r_s0_1) = 2;

    connect<>(self.s0_d1_aie.out1[0], self.buffer_r_s0_1.in[0]);
    write_access(self.buffer_r_s0_1.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s0_d1_aie.out1[1], self.buffer_r_s0_1.in[1]);
    write_access(self.buffer_r_s0_1.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_s0_1.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s0_1.out[0], self.s0_d2_aie.in1[0]);
    read_access(self.buffer_r_s0_1.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s0_1.out[1], self.s0_d2_aie.in1[1]);
    self.buffer_r_s0_2 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      2
    );
    num_buffers(self.buffer_r_s0_2) = 2;

    connect<>(self.s0_d2_aie.out1[0], self.buffer_r_s0_2.in[0]);
    write_access(self.buffer_r_s0_2.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s0_d2_aie.out1[1], self.buffer_r_s0_2.in[1]);
    write_access(self.buffer_r_s0_2.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_s0_2.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s0_2.out[0], self.s0_d3_aie.in1[0]);
    read_access(self.buffer_r_s0_2.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s0_2.out[1], self.s0_d3_aie.in1[1]);
    self.buffer_s1_in = adf::shared_buffer<bfloat16>::create(
      { 256, 8 },
      1,
      4
    );
    num_buffers(self.buffer_s1_in) = 2;
    adf::dimensions(self.roll1.in[0])  = { 128 * 8 };
    adf::dimensions(self.roll1.out[0]) = { 256 * 8 };
    connect<>(self.roll1.out[0], self.buffer_s1_in.in[0]);
    write_access(self.buffer_s1_in.in[0]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 256, 8 },
  .offset           = { 0, 0 }
});

    read_access(self.buffer_s1_in.out[0]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s1_in.out[0], self.s1_d0_aie.in1[0]);
    read_access(self.buffer_s1_in.out[1]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s1_in.out[1], self.s1_d0_aie.in1[1]);
    read_access(self.buffer_s1_in.out[2]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 128, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s1_in.out[2], self.s1_d0_aie.in1[2]);
    read_access(self.buffer_s1_in.out[3]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 192, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s1_in.out[3], self.s1_d0_aie.in1[3]);
    self.buffer_r_s1_0 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      2
    );
    num_buffers(self.buffer_r_s1_0) = 2;

    connect<>(self.s1_d0_aie.out1[0], self.buffer_r_s1_0.in[0]);
    write_access(self.buffer_r_s1_0.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s1_d0_aie.out1[1], self.buffer_r_s1_0.in[1]);
    write_access(self.buffer_r_s1_0.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_s1_0.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s1_0.out[0], self.s1_d1_aie.in1[0]);
    read_access(self.buffer_r_s1_0.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s1_0.out[1], self.s1_d1_aie.in1[1]);
    self.buffer_r_s1_1 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      2
    );
    num_buffers(self.buffer_r_s1_1) = 2;

    connect<>(self.s1_d1_aie.out1[0], self.buffer_r_s1_1.in[0]);
    write_access(self.buffer_r_s1_1.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s1_d1_aie.out1[1], self.buffer_r_s1_1.in[1]);
    write_access(self.buffer_r_s1_1.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_s1_1.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s1_1.out[0], self.s1_d2_aie.in1[0]);
    read_access(self.buffer_r_s1_1.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s1_1.out[1], self.s1_d2_aie.in1[1]);
    self.buffer_r_s1_2 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      2
    );
    num_buffers(self.buffer_r_s1_2) = 2;

    connect<>(self.s1_d2_aie.out1[0], self.buffer_r_s1_2.in[0]);
    write_access(self.buffer_r_s1_2.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s1_d2_aie.out1[1], self.buffer_r_s1_2.in[1]);
    write_access(self.buffer_r_s1_2.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_s1_2.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s1_2.out[0], self.s1_d3_aie.in1[0]);
    read_access(self.buffer_r_s1_2.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s1_2.out[1], self.s1_d3_aie.in1[1]);
    self.buffer_s2_in = adf::shared_buffer<bfloat16>::create(
      { 256, 8 },
      1,
      4
    );
    num_buffers(self.buffer_s2_in) = 2;
    adf::dimensions(self.roll2.in[0])  = { 128 * 8 };
    adf::dimensions(self.roll2.out[0]) = { 256 * 8 };
    connect<>(self.roll2.out[0], self.buffer_s2_in.in[0]);
    write_access(self.buffer_s2_in.in[0]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 256, 8 },
  .offset           = { 0, 0 }
});

    read_access(self.buffer_s2_in.out[0]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s2_in.out[0], self.s2_d0_aie.in1[0]);
    read_access(self.buffer_s2_in.out[1]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s2_in.out[1], self.s2_d0_aie.in1[1]);
    read_access(self.buffer_s2_in.out[2]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 128, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s2_in.out[2], self.s2_d0_aie.in1[2]);
    read_access(self.buffer_s2_in.out[3]) = adf::tiling({
  .buffer_dimension = { 256, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 192, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 256, 8 }
});
    connect<>(self.buffer_s2_in.out[3], self.s2_d0_aie.in1[3]);
    self.buffer_r_s2_0 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      2
    );
    num_buffers(self.buffer_r_s2_0) = 2;

    connect<>(self.s2_d0_aie.out1[0], self.buffer_r_s2_0.in[0]);
    write_access(self.buffer_r_s2_0.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s2_d0_aie.out1[1], self.buffer_r_s2_0.in[1]);
    write_access(self.buffer_r_s2_0.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_s2_0.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s2_0.out[0], self.s2_d1_aie.in1[0]);
    read_access(self.buffer_r_s2_0.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s2_0.out[1], self.s2_d1_aie.in1[1]);
    self.buffer_r_s2_1 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      2
    );
    num_buffers(self.buffer_r_s2_1) = 2;

    connect<>(self.s2_d1_aie.out1[0], self.buffer_r_s2_1.in[0]);
    write_access(self.buffer_r_s2_1.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s2_d1_aie.out1[1], self.buffer_r_s2_1.in[1]);
    write_access(self.buffer_r_s2_1.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_s2_1.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s2_1.out[0], self.s2_d2_aie.in1[0]);
    read_access(self.buffer_r_s2_1.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s2_1.out[1], self.s2_d2_aie.in1[1]);
    self.buffer_r_s2_2 = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      2
    );
    num_buffers(self.buffer_r_s2_2) = 2;

    connect<>(self.s2_d2_aie.out1[0], self.buffer_r_s2_2.in[0]);
    write_access(self.buffer_r_s2_2.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s2_d2_aie.out1[1], self.buffer_r_s2_2.in[1]);
    write_access(self.buffer_r_s2_2.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    read_access(self.buffer_r_s2_2.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s2_2.out[0], self.s2_d3_aie.in1[0]);
    read_access(self.buffer_r_s2_2.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 8, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=8, .wrap=8 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_r_s2_2.out[1], self.s2_d3_aie.in1[1]);
    self.buffer_emb_out = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      N_STAGE_RD
    );
    num_buffers(self.buffer_emb_out) = 2;

    connect<>(self.emb_d1_aie.out1[0], self.buffer_emb_out.in[0]);
    write_access(self.buffer_emb_out.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.emb_d1_aie.out1[1], self.buffer_emb_out.in[1]);
    write_access(self.buffer_emb_out.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
#ifndef SYSTEM_BUILD
    read_access(self.buffer_emb_out.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 64, 8 },
  .offset           = { 0, 0 }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_emb_out.out[0], self.ofm[0]);
#endif
#ifndef SYSTEM_BUILD
    read_access(self.buffer_emb_out.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 64, 8 },
  .offset           = { 64, 0 }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_emb_out.out[1], self.ofm[1]);
#endif
    self.buffer_s0_out = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      N_STAGE_RD
    );
    num_buffers(self.buffer_s0_out) = 2;

    connect<>(self.s0_d3_aie.out1[0], self.buffer_s0_out.in[0]);
    write_access(self.buffer_s0_out.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s0_d3_aie.out1[1], self.buffer_s0_out.in[1]);
    write_access(self.buffer_s0_out.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
#ifndef SYSTEM_BUILD
    read_access(self.buffer_s0_out.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 64, 8 },
  .offset           = { 0, 0 }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_s0_out.out[0], self.ofm[2]);
#endif
#ifndef SYSTEM_BUILD
    read_access(self.buffer_s0_out.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 64, 8 },
  .offset           = { 64, 0 }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_s0_out.out[1], self.ofm[3]);
#endif
    self.buffer_s1_out = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      N_STAGE_RD
    );
    num_buffers(self.buffer_s1_out) = 2;

    connect<>(self.s1_d3_aie.out1[0], self.buffer_s1_out.in[0]);
    write_access(self.buffer_s1_out.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s1_d3_aie.out1[1], self.buffer_s1_out.in[1]);
    write_access(self.buffer_s1_out.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
#ifndef SYSTEM_BUILD
    read_access(self.buffer_s1_out.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 64, 8 },
  .offset           = { 0, 0 }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_s1_out.out[0], self.ofm[4]);
#endif
#ifndef SYSTEM_BUILD
    read_access(self.buffer_s1_out.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 64, 8 },
  .offset           = { 64, 0 }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_s1_out.out[1], self.ofm[5]);
#endif
    self.buffer_s2_out = adf::shared_buffer<bfloat16>::create(
      { 128, 8 },
      2,
      N_STAGE_RD
    );
    num_buffers(self.buffer_s2_out) = 2;

    connect<>(self.s2_d3_aie.out1[0], self.buffer_s2_out.in[0]);
    write_access(self.buffer_s2_out.in[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 0, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
    connect<>(self.s2_d3_aie.out1[1], self.buffer_s2_out.in[1]);
    write_access(self.buffer_s2_out.in[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 4, 4 },
  .offset           = { 64, 0 }
    , .tile_traversal = {
{ .dimension=0, .stride=4, .wrap=16 },
{ .dimension=1, .stride=4, .wrap=2 }
    }
});
#ifndef SYSTEM_BUILD
    read_access(self.buffer_s2_out.out[0]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 64, 8 },
  .offset           = { 0, 0 }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_s2_out.out[0], self.ofm[6]);
#endif
#ifndef SYSTEM_BUILD
    read_access(self.buffer_s2_out.out[1]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 64, 8 },
  .offset           = { 64, 0 }
    , .boundary_dimension = { 128, 8 }
});
    connect<>(self.buffer_s2_out.out[1], self.ofm[7]);
#endif




    // ---- event tail: track average + output dense --------------------
    // Reads the final stage's [128,8] block; emits 32 floats (27 real, padded)
    // once per 50-track event and zeros on the other iterations.
    connect<>(self.buffer_s2_out.out[EXTRA_RD], self.accum.in[0]);
    read_access(self.buffer_s2_out.out[EXTRA_RD]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 128, 8 },
  .offset           = { 0, 0 }
});
    adf::dimensions(self.accum.in[0])  = { 128 * 8 };
    adf::dimensions(self.accum.out[0]) = { 128 };
    connect<>(self.accum.out[0], self.ofm[TAIL_OFM]);

    // ---- batched roll-concat wiring ----------------------------------
    // Placed last: these reference buffer_emb_out / buffer_s{0,1}_out,
    // which are created further down in this function.
    // --- batched roll-concat: buffer_emb_out [128,8] -> buffer_s0_in [256,8] ---
    // Replaces the four ifm feeds this buffer used to have. The kernel reads the
    // whole previous-stage block and emits [current | previous-track].
    connect<>(self.buffer_emb_out.out[EXTRA_RD], self.roll0.in[0]);
    read_access(self.buffer_emb_out.out[EXTRA_RD]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 128, 8 },
  .offset           = { 0, 0 }
});
    // --- batched roll-concat: buffer_s0_out [128,8] -> buffer_s1_in [256,8] ---
    // Replaces the four ifm feeds this buffer used to have. The kernel reads the
    // whole previous-stage block and emits [current | previous-track].
    connect<>(self.buffer_s0_out.out[EXTRA_RD], self.roll1.in[0]);
    read_access(self.buffer_s0_out.out[EXTRA_RD]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 128, 8 },
  .offset           = { 0, 0 }
});
    // --- batched roll-concat: buffer_s1_out [128,8] -> buffer_s2_in [256,8] ---
    // Replaces the four ifm feeds this buffer used to have. The kernel reads the
    // whole previous-stage block and emits [current | previous-track].
    connect<>(self.buffer_s1_out.out[EXTRA_RD], self.roll2.in[0]);
    read_access(self.buffer_s1_out.out[EXTRA_RD]) = adf::tiling({
  .buffer_dimension = { 128, 8 },
  .tiling_dimension = { 128, 8 },
  .offset           = { 0, 0 }
});

  }
};