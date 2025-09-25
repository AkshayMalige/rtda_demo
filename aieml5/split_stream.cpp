#include "split_stream.h"

void split_stream_kernel(adf::input_stream<float>* __restrict in,
                         adf::output_stream<float>* __restrict out0,
                         adf::output_stream<float>* __restrict out1) {
  constexpr int total_elems   = HIDDEN_SIZE;
  constexpr int casc_length   = CASCADE_LENGTH;
  constexpr int elems_per_out = total_elems / casc_length;

  static_assert(casc_length == 2, "split_stream_kernel currently supports two cascade stages.");

  for (int i = 0; i < elems_per_out; ++i) {
    writeincr(out0, readincr(in));
  }
  for (int i = 0; i < elems_per_out; ++i) {
    writeincr(out1, readincr(in));
  }
}
