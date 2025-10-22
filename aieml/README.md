# AIEML10 Graph — New Design Overview

This design builds a 5‑stage dense network on AI Engine with fused bias + leaky‑ReLU activations, GMIO for bulk I/O, and RTP for per‑layer parameters. All weights and biases are provided per layer at runtime via distinct RTP ports, so you can swap in real, different weights/biases for every layer without changing the graph.

Key sources: `graph.h`, `graph.cpp`, `bias_relu_fused.cpp`, `roll_concat.cpp`.

## Model Stitching
- Embed stage:
  - `embed_dense0` 128×8 → fused `bias_add_leaky_relu` → `window_split_128_to_64x2` →
  - `embed_dense1` 128×128 (2‑way cascade reload) → fused `bias_add_leaky_relu`.
- Three solver stages, chained: `solver0` → `solver1` → `solver2`.
  - Each stage expands 128→256 using `roll_concat`, then runs four layers:
    - `dense0` 128×256 → fused `bias+leaky_relu` → split(64/64) →
    - `dense1` 128×128 (2 parts) → fused → split →
    - `dense2` 128×128 (2 parts) → fused → split →
    - `dense3` 128×128 (2 parts) → fused.
  - The output of `solver{i}.dense3` feeds the next stage’s `roll_concat`.
- Output stage:
  - `output_dense0` 32×128 → GMIO out.

All dense layers use matrix reload (RTP) for weights; every fused activation uses an RTP for its bias. Activations move between kernels as AIE windows, not over PLIO.

## Ports, Supply, and Sizes
Sizes are in floats. Per‑frame payloads are shown for activations.

| Name | Direction | Supply | Size | Notes |
| --- | --- | --- | ---: | --- |
| `embed_input_gmio` | In (GMIO) | GMIO burst | 8 per frame | Input vectors (`EMBED_INPUT_DATA`). |
| `embed_matrixA0_rtp` | In (RTP) | RTP (g.update) | 128×8 = 1 024 | `embed_dense0` weights. |
| `embed_bias0_rtp` | In (RTP) | RTP (g.update) | 128 | Bias for `embed_dense0`. |
| `embed_matrixA1_0_rtp` | In (RTP) | RTP (g.update) | 16 384/2 = 8 192 | `embed_dense1` weights part 0. |
| `embed_matrixA1_1_rtp` | In (RTP) | RTP (g.update) | 8 192 | `embed_dense1` weights part 1. |
| `embed_bias1_rtp` | In (RTP) | RTP (g.update) | 128 | Bias for `embed_dense1`. |
| `solver0_dense0_matrixA_rtp[0..3]` | In (RTP) | RTP (g.update) | 4×8 192 | `dense0` weights split 4 ways (total 32 768). |
| `solver0_dense{1,2,3}_matrixA_rtp[0..1]` | In (RTP) | RTP (g.update) | 3×(2×8 192) | Each 128×128 split 2 ways (total 3×16 384). |
| `solver0_bias{0..3}_rtp` | In (RTP) | RTP (g.update) | 4×128 | Bias per layer. |
| `solver1_dense0_matrixA_rtp[0..3]` | In (RTP) | RTP (g.update) | 4×8 192 | Same shape as solver0; separate ports. |
| `solver1_dense{1,2,3}_matrixA_rtp[0..1]` | In (RTP) | RTP (g.update) | 3×(2×8 192) | Separate ports. |
| `solver1_bias{0..3}_rtp` | In (RTP) | RTP (g.update) | 4×128 | Separate ports. |
| `solver2_dense0_matrixA_rtp[0..3]` | In (RTP) | RTP (g.update) | 4×8 192 | Same shape; separate ports. |
| `solver2_dense{1,2,3}_matrixA_rtp[0..1]` | In (RTP) | RTP (g.update) | 3×(2×8 192) | Separate ports. |
| `solver2_bias{0..3}_rtp` | In (RTP) | RTP (g.update) | 4×128 | Separate ports. |
| `output_matrixA_rtp` | In (RTP) | RTP (g.update) | 32×128 = 4 096 | Output layer weights. |
| `embed_output_gmio` | Out (GMIO) | GMIO burst | 32 per frame | Final output vectors. |

Internal activation streams (AIE windows):
- 128‑wide windows between dense → fused bias+relu, and fused → split.
- 64‑wide windows from each split to subsequent dual‑input dense (SSR=2).
- 256‑wide tiles written/read via `shared_buffer` around each `roll_concat` to feed 4‑way SSR dense0.

Port definitions: see `graph.h:90`, `graph.h:97`, `graph.h:101`, `graph.h:107`, `graph.h:131`, `graph.h:154`, `graph.h:178`.

## Per‑Layer Weights and Biases
- Every layer has its own RTP port(s). `graph.cpp` loads each from a separate file declared in `../common/data_paths.h`.
- Today, the solver branches reuse the same file prefixes as placeholders. When you have real weights per layer/branch, set unique prefixes:
  - Edit `SUBSOLVER{1,2}_DENSE{0..3}_WEIGHTS_PREFIX` and `SUBSOLVER{1,2}_DENSE{0..3}_BIAS` in `../common/data_paths.h`.
  - Provide per‑part files where required (e.g., `_part0.txt`, `_part1.txt`, `_part2.txt`, `_part3.txt`).
- No PLIO is used for parameters; all matrices/biases are updated with `g.update(port, data, count)`.

## Data Files and Shapes
Default file names live in `../common/data_paths.h` and are read from `DATA_DIR` (defaults to `../data`). The key shapes are:
- Embed: `embed_dense_0_weights.txt` (1 024), `embed_dense_1_weights_part{0,1}.txt` (8 192 each), `embed_dense_{0,1}_bias.txt` (128).
- Solver branches 0/1/2:
  - `solver_X_dense_0_weights_part{0..3}.txt` (8 192 each),
  - `solver_X_dense_{1,2,3}_weights_part{0,1}.txt` (8 192 each),
  - `solver_X_dense_{0,1,2,3}_bias.txt` (128 each), where X ∈ {0,1,2}.
- Output: `output_dense_0_weights.txt` (4 096).
- I/O: `embed_input.txt` (multiple of 8), `aieml10_output_aie.txt` (multiple of 32).

## Build and Run
- Prereqs:
  - `conda env create -f hls_env.yml && conda activate hls_env`
  - `source set_envs.sh` (sets `PLATFORM` and tool paths)
  - Optional data override: `export DATA_DIR=$PWD/../data`
  - DSP library path: ensure `../dsp_lib` exists, or set `DSPLIB_PATH=/path/to/vitis_dsp`.
- Key variables (from `Makefile`):
  - `TARGET` = `x86sim` or `hw` (default `hw`)
  - `PLATFORM` = board `.xpfm` (from `set_envs.sh`)
  - `PL_FREQZ` = PL interface MHz (default `300`)
  - `DSPLIB_PATH` = Vitis DSP library root (default `../dsp_lib`)
- Build the AIE graph:
  - `make graph TARGET=hw`         # hardware‑model compile
  - `make graph TARGET=x86sim`     # x86 functional model
- Run simulation:
  - x86 model: `make sim TARGET=x86sim`
    - Outputs under `x86simulator_output/`.
  - AIE cycle sim: `make sim TARGET=hw`
    - Creates `aiesimulator_output/` and `Work/aiesimulator_output/` and writes `foo.vcd` waves.
- Clean:
  - `make clean` to remove `Work/`, sim outputs, logs, and VCDs.

Notes:
- The compiler produces `Work/libadf.a` and logs to `Work/aiecompiler.log`.
- `PLATFORM` must be valid; if unset, source `../set_envs.sh`.
- If `DSPLIB_PATH` is missing, the build stops with a helpful error (see `aieml/Makefile:64`).

## Profiling and Waves
- Analyzer: `vitis_analyzer Work/aiesimulator_output/default.aierun_summary`
- Waves: `foo.vcd` is generated by `aiesimulator` via `--dump-vcd=foo`.

## File Pointers
- Port and wiring: `graph.h:197`, `graph.h:204`, `graph.h:213`, `graph.h:217`, `graph.h:222`, `graph.h:231`, `graph.h:269`, `graph.h:336`, `graph.h:402`, `graph.h:426`.
- Runtime hints: `graph_layout.hpp`
- Host parameter loads and GMIO transfers: `graph.cpp:180`, `graph.cpp:212`, `graph.cpp:300`, `graph.cpp:339`.
