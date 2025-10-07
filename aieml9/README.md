# AIEML9 Combined Graph

`aieml9` stitches together the three existing AI Engine stages (`aieml6`,
`aieml7`, and `aieml8`) into a single graph. The embedded feature extractor,
solver stack, and output projection now execute as a single compilation unit so
that `make graph` builds and simulates the whole network in one go.

## Layer Stack

### Stage 0 – Top-level shims
- `pipeline_in` (`aieml9_in`) streams a single 8-float feature vector from `data/embed_input.txt` through shim tile 6.
- `pipeline_out` (`aieml9_out`) captures the final 32-float projection at shim tile 27, writing `data/aieml9_output_aie.txt`.
- All weight/bias files live under `DATA_DIR`; runtime parameter (`update`) calls in `graph.cpp` push them into the design before `g.run(1)`.

### Stage 1 – Embedding front end (`aieml6` content)
- `dense8x128` performs the 8×128 projection using a single matrix-vector kernel; weights come from `embed_dense_0_weights.txt` via RTP port `embed_matrixA_rtp`.
- `bias_add` (`embed_bias0`) and `leaky_relu` (`embed_relu0`) add the learned offset and apply the shared leaky slope (`LEAKY_SLOPE = 0.1`).
- `window_split_128_to_64x2` halves the 128-wide activation into two 64-element legs so the two-lane cascade in `dense128x128_stage1` can run in parallel.
- `dense128x128_stage1` (cascade length = 2) consumes the split stream; each lane receives its own weight partition (`embed_dense_1_weights_part[0|1].txt`). The layer is followed by another bias+LeakyReLU pair (`embed_bias1`, `embed_relu1`).
- The stage produces a 128-wide activation window every frame, which feeds Stage 2.

### Stage 2 – Solver core (`aieml7` content)
- `roll_concat_kernel` materialises six rolled copies of the 128-element vector and concatenates them, yielding 768 floats. Two identical outputs feed separate shared buffers so the downstream 12-wide cascade can read without contention.
- `solver_roll_buf_a/b` expose tiling slices of the 768-vector to the 12 cascaded matrix-vector engines inside `dense768x128`. Each lane reads a 64-element stride (768 / 12) from the shared buffer.
- `dense768x128` ingests 12 weight partitions (`solver_0_dense_0_weights_part*.txt`) via PLIOs. The result goes through bias (`solver_bias0`), leaky ReLU (`solver_relu0`), and a 128→64+64 splitter (`solver_split0`).
- Three stacked residual-sized layers reuse the pattern:
  - `dense128x128_stage2` ×3 operate with cascade length 2. Each layer consumes both legs of the previous splitter, loads two weight parts (`solver_0_dense_[1|2|3]_weights_part[0|1].txt`), then pushes through bias, leaky ReLU, and another splitter (`solver_split[1|2]`) to feed the next dense block.
- After `solver_relu3`, the solver emits a refreshed 128-element activation window.

### Stage 3 – Output projection (`aieml8` content)
- `dense128x32` maps the solver output onto 32 logits (padded to match the AI Engine vector width). Its weights come from `output_dense_0_weights.txt` over RTP `output_matrixA_rtp`.
- The 32-float window is forwarded directly to `pipeline_out`, completing the graph.

## Data Movement & Connections
- All dense layers operate on `window<512>` (128×4 byte) buffers between kernels, keeping scheduling simple and FIFO depths short (8 entries for cascaded legs).
- Matrix weights for the embedding and output stages arrive over RTP ports so they can be updated at runtime without recompilation; solver weights stay memory-mapped PLIO streams to avoid large RTP transfers (12 + 6 + 6 + 6 files).
- The dedicated `roll_concat` shared buffers provide deterministic fan-out for the 12 cascaded solver lanes: the first buffer feeds lanes 0–5, the second feeds lanes 6–11, each with matching tiling offsets.
- Every bias kernel reuses the same `bias_add.cpp` implementation; LeakyReLU kernels share `leaky_relu.cpp`, ensuring identical activation behaviour across stages.
- The graph expects the same dataset as the decomposed projects; set `DATA_DIR` if the files live elsewhere (defaults to `../data`).

## Build

```bash
make graph
```

Run `make aieml9 TARGET=hw_emu` to integrate with the project-wide build, or `make -C aieml9 sim` for cycle-accurate AI Engine simulation. The packaged result places the final activations in `data/aieml9_output_aie.txt`.
