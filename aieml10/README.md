# AIEML10 Graph — Fused Bias + Leaky ReLU

This AI Engine design implements the aieml10 topology. As an optimization, the separate `bias_add` and `leaky_relu` kernels are now fused into a single kernel to save tiles/resources and FIFOs while preserving behavior and interfaces (bias RTPs, shapes, and ordering).

## Runtime Data Movement
Weights are now staged via four “vault” buffers so the host loads them once with GMIO and every graph run reuses the on-array copies:

- `embed_weights_vault` (17 408 floats) holds both embed layer matrices (128×8 and 128×128 split across the cascade).
- Three solver vaults (`solver{0,1,2}_weights_vault`, each 81 920 floats) carry the full dense stacks for their branches (128×256 plus three 128×128 matrices).
- Each vault is populated during `g.init()` using a single GMIO burst, then sliced by the graph into the individual cascade ports.

Biases and the final output matrix continue to use RTP updates because they are small and infrequently changed, while activations still travel over PLIO streams. The table below summarises every host-managed transfer per graph run (sizes are in floats).

| Payload | Source → Destination | Connection Type | Size (floats) |
| --- | --- | --- | --- |
| Input activations (`embed_input.txt`) | Host DDR → `pipeline_in` PLIO → `embed_dense0.inB[0]` | PLIO window | 8 per frame |
| Embed weight vault | Host DDR → `embed_weights_gmio` → `embed_weights_vault` → `{embed_dense0.inA[0], embed_dense1.inA[0..1]}` | GMIO → shared_buffer | 17 408 |
| Solver0 weight vault | Host DDR → `solver0_weights_gmio` → `solver0_weights_vault` → `{solver0_dense{0..3}.inA}` | GMIO → shared_buffer | 81 920 |
| Solver1 weight vault | Host DDR → `solver1_weights_gmio` → `solver1_weights_vault` → `{solver1_dense{0..3}.inA}` | GMIO → shared_buffer | 81 920 |
| Solver2 weight vault | Host DDR → `solver2_weights_gmio` → `solver2_weights_vault` → `{solver2_dense{0..3}.inA}` | GMIO → shared_buffer | 81 920 |
| Embed biases (`EMBED_DENSE{0,1}_BIAS`) | Host DDR → `embed_bias{0,1}_rtp` | RTP (`g.update`) | 2 × 128 |
| Solver0 biases (`SUBSOLVER0_DENSE{0..3}_BIAS`) | Host DDR → `solver0_bias{0..3}_rtp` | RTP (`g.update`) | 4 × 128 |
| Solver1 biases (`SUBSOLVER1_DENSE{0..3}_BIAS`) | Host DDR → `solver1_bias{0..3}_rtp` | RTP (`g.update`) | 4 × 128 |
| Solver2 biases (`SUBSOLVER2_DENSE{0..3}_BIAS`) | Host DDR → `solver2_bias{0..3}_rtp` | RTP (`g.update`) | 4 × 128 |
| Output dense matrix (`OUTPUT_DENSE0_WEIGHTS`) | Host DDR → `output_matrixA_rtp` | RTP (`g.update`) | 4 096 |
| Output activations (`aieml10_output_aie.txt`) | `output_dense0.out[0]` → `pipeline_out` PLIO → Host file | PLIO window | 32 per frame |

**Notes**
- GMIO vault sizes match the concatenated text files. Ordering is preserved (`dense0` parts first, followed by `dense1`, `dense2`, `dense3` parts) so the graph slicing offsets stay aligned.
- Bias RTP updates remain additive: each call pushes 128 floats (the layer width) into the fused bias+activation kernels.
- `g.run(N)` reuses all staged weights; only the PLIO streams and RTP payloads move per run.

## What Changed
- New fused kernel `bias_add_leaky_relu_kernel` performs bias add then leaky ReLU in one pass.
  - Sources: `bias_relu_fused.h`, `bias_relu_fused.cpp`
- Graph updates replaced every bias→relu pair with a single fused kernel:
  - Embed stage: `embed_bias_relu0`, `embed_bias_relu1` replace `embed_bias{0,1}` + `embed_relu{0,1}`
    - `graph.h:309–315` wires `embed_dense0 → embed_bias_relu0 → embed_split0`
    - `graph.h:330–341` wires `embed_dense1 → embed_bias_relu1 → solver0_rollconcat`
  - Solver stage (branch 1): `solver0_bias_relu{0..3}` replace `solver_bias{0..3}` + `solver_relu{0..3}`
    - `graph.h` wires `solver0_dense{0..3} → solver0_bias_relu{0..3}` and into the existing splits
    - `graph.h` sends `solver0_bias_relu3` output to `solver1_rollconcat`
  - Solver stage (branch 2): `solver1_bias_relu{0..3}` similarly replace bias+relu
    - `graph.h:457–469` feed split chains
  - Solver stage (branch 3): `solver2_bias_relu{0..3}` similarly replace bias+relu
    - `graph.h:522–544` feed split chains and final output

No tensor sizes, file names, or RTP port names changed. All bias RTP updates in `graph.cpp` remain valid and continue to drive the fused kernels.

## Kernel Runtime Ratios
Runtime budget hints are updated to account for fusion (bias + relu):
- `embed_bias_relu{0,1}`: `2.0` (≈1.0 + 1.0)
- `solver0_bias_relu{0..3}`, `solver1_bias_relu{0..3}`, `solver2_bias_relu{0..3}`: `0.95` each (≈0.45 + 0.5)
- `solver0_split{0..2}`, `solver1_split{0..2}`, `solver2_split{0..2}` unchanged: `0.65`
- `solver0_rollconcat`, `solver1_rollconcat`, `solver2_rollconcat` unchanged: `1.0`
  - See `graph_layout.hpp` for the runtime updates.

## Build and Simulate
- Configure environment (example):
  - `conda env create -f hls_env.yml && conda activate hls_env`
  - `source set_envs.sh`
  - Optional: `export DATA_DIR=$PWD/../data` (defaults already set in Makefile)
- Build AIE graph (TARGET can be `hw_emu` or `hw`):
  - `make graph TARGET=hw_emu`
- Run AI Engine simulation:
  - `make sim TARGET=x86sim` or `make sim TARGET=hw_emu`

## Profile, Trace, and Waveforms
- Profile summary and timelines:
  - Simulation already enables profiling (`--profile --online -text`).
  - Open the run in Analyzer: `vitis_analyzer Work/aiesimulator_output/default.aierun_summary`.
  - Explore Summary, Graph, and Timeline panes to spot hotspots and stalls.
- Enable event trace timeline in sim:
  - `make sim-trace` (adds `--trace` to aiesimulator) for richer timeline events.
- Waveforms (WDB/VCD):
  - The sim produces WDB waveforms (`-wdb`). Open them in Vivado/XSIM Wave, or convert to VCD:
    - `make vcd` (uses `wdb2vcd` if present) → generates `aiesim.vcd`.
    - If `wdb2vcd` isn’t on PATH, use the Vivado `wdb2vcd` binary or open the WDB directly in Vivado.

## Post‑Run Checklist (VCD/Wave)
- Dataflow and windowing: verify `connect<window<...>>` boundaries are respected and no dropped frames.
- Backpressure: ensure stream valid/ready handshakes are sustained; watch for prolonged deassertions.
- Core/DMA cadence: minimal idle between frames; DMA bursts align with window sizes.
- Buffers/locks: shared buffer tiling shows no long lock holds or misordered tiles.
- Throughput/latency: end‑to‑end latency for `g.run(1)` meets expectations and is stable between runs.
- Correctness: compare `data/aieml10_output_aie.txt` to goldens.

## Data and Parameters
- Bias RTPs are loaded in `graph.cpp` during simulation init and continue to target the fused kernels’ bias ports.
- If you change tensor sizes, update `common/nn_defs.h` equivalents in this design (`../common/nn_defs10.h`) and regenerate data under `data/` using the repository’s Python tools.

## Files of Interest
- Fused kernel: `bias_relu_fused.h`, `bias_relu_fused.cpp`
- Graph wiring: `graph.h:196–216`, `graph.h:286–291`, `graph.h:309–341`, `graph.h:381–418`, `graph.h:515–544`
- Runtime ratios: `graph_layout.hpp`
- Build rules: `Makefile`
