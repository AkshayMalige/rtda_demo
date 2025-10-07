# AIEML9 Placement Strategy

The tile map is driven entirely from `graph_layout.hpp`. The helper utilities use a
small number of base coordinates so that cascaded kernels land on contiguous tiles
without hand editing individual locations when the cascade length changes.

## Formulas in use

- **Linear cascades** – `place_linear` assigns the `i`-th kernel in a cascade to
  `tile(base_col + i, row)`. Increasing the cascade length automatically walks
  across the same row.
- **Branch offsets** – the duplicated solver branch reuses exactly the same
  structure but starts at `base_col = 24` (vs. 10 for the first branch). Shifting
  the branch is a matter of changing this single constant.
- **Post-processing kernels** – activations/bias/split kernels sit one row below
  the dense operators that feed them (rows 3–5). Adding another layer means
  appending an entry to the stage array with the desired row.
- **Shim bindings** – host PLIOs are parameterised via `AIEML9_INPUT_SHIM` and
  `AIEML9_OUTPUT_SHIM` from `common/nn_defs.h` to keep board assignments visible.

## How to extend

1. Add the new dense layer to `graph.h` and create its kernel(s).
2. Append a placement record (or reuse `place_linear`) in `graph_layout.hpp`.
   The helper makes it easy to reuse the existing column stride logic instead of
   hard-coding coordinates.
3. If the runtime estimate differs, drop another entry into the `runtime_specs`
   array. The rest of the constructor stays untouched.

With this structure the mapping logic lives in one place and is driven by small
constants, so scaling the graph is mainly bookkeeping rather than tile-by-tile
editing.
