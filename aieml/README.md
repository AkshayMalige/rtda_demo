# AI Engine Solver Graph

This directory contains the production AI Engine graph that powers the RTDA demo. The design ingests sequences of particle tracks (treat each track as 128 `float32` features) and processes them through a four-stage inference pipeline made up of an embed block followed by three solver stages. All compute executes inside the AI Engine array; programmable logic is only used for GMIO access and packaging.

---

## Architecture Overview

- **Stage 0 – Embed block**: two dense layers (`embed_dense0`, `embed_dense1`) with fused bias + leaky-ReLU activations and a 128-to-64×2 window splitter. This stage expands raw track features into a 128-wide activation stream.
- **Stages 1–3 – Solver blocks**: each solver stage (`solver0`, `solver1`, `solver2`) starts with the custom `roll_concat` kernel, feeds a 4-way cascaded dense layer followed by three 2-way cascaded dense layers, and applies the same fused activation / splitter pattern between layers.
- **Stage outputs**: solver2 returns a 128-wide activation that is driven directly to `embed_output_gmio`. There is no trailing dense layer; the solver output is the final tensor consumed by the host.
- **Stateful track handling**: `roll_concat` mimics `torch.roll` behaviour over the last 50 valid tracks, zero-padding inactive frames and emitting wrap pairs only when a full 50-track window has been observed.

### Stage Summary

| Stage | Kernels | Frame shape (float32) | Notes |
|-------|---------|-----------------------|-------|
| Embed | `embed_dense0` → `bias_add_leaky_relu` → `window_split_128_to_64x2` → `embed_dense1` → `bias_add_leaky_relu` | `INPUT_SIZE` → 128 | `INPUT_SIZE` defaults to 8 in `nn_defs10.h`; set to 128 for full track feature vectors. Splitter feeds the cascaded matrix multiply. |
| Solver 0 | `roll_concat` → shared buffer → `solver0_dense0` → `bias_add_leaky_relu` → `window_split` → `solver0_dense{1,2,3}` with in-between activation & split | 128 → 256 → 128 | `roll_concat` emits two 128-length windows per valid track; dense0 is 4-way cascaded (128×256). |
| Solver 1 | Same kernel pattern as Solver 0 | 128 → 256 → 128 | Consumes the activated output from solver0. |
| Solver 2 | Same kernel pattern as Solver 0 | 128 → 256 → 128 | Drives `embed_output_gmio` after the final activation. |

All kernels operate on `float32` windows. Shared buffers inside each solver tile the 256-length `roll_concat` output into four 64-element spans that feed the cascaded dense layer inputs.

### Dense Kernel Inventory

| Layer | Template | Rows × Cols | Cascade length | Data type |
|-------|----------|-------------|----------------|-----------|
| `embed_dense0` | `matrix_vector_mul_graph` | 128 × `INPUT_SIZE` | 1 | `float32` |
| `embed_dense1` (parts 0–1) | `matrix_vector_mul_graph` | 128 × 128 | 2 | `float32` |
| `solver{i}_dense0` (i = 0,1,2; parts 0–3) | `matrix_vector_mul_graph` | 128 × 256 | 4 | `float32` |
| `solver{i}_dense1` (i = 0,1,2; parts 0–1) | `matrix_vector_mul_graph` | 128 × 128 | 2 | `float32` |
| `solver{i}_dense2` (i = 0,1,2; parts 0–1) | `matrix_vector_mul_graph` | 128 × 128 | 2 | `float32` |
| `solver{i}_dense3` (i = 0,1,2; parts 0–1) | `matrix_vector_mul_graph` | 128 × 128 | 2 | `float32` |

Each cascade part receives a contiguous stripe of the parent weight matrix. For example, `solver0_dense0_matrixA_rtp[0]` loads the first 128×64 block (8192 floats) of the 128×256 matrix.

### Ports and Data Contracts

| Interface | Direction | Type | Shape / Count | Consumers | Notes |
|-----------|-----------|------|----------------|-----------|-------|
| `embed_input_gmio` | Input | GMIO | `INPUT_SIZE` floats per frame | `embed_dense0.inB[0]` | Host pushes frames with `gm2aie_nb`; zero-padding keeps alignment when inactive tracks are present. |
| `embed_output_gmio` | Output | GMIO | 128 floats per frame | Host | Non-blocking `aie2gm_nb` retrieves solver2 activations. |
| `embed_matrixA0_rtp` | Input | RTP | 128 × `INPUT_SIZE` weights (1024 floats at default settings) | `embed_dense0.matrixA[0]` | Single cascade; load once per run or when updating weights. |
| `embed_matrixA1_{0,1}_rtp` | Input | RTP | 128 × 64 weights per port (8192 floats each) | `embed_dense1.matrixA[{0,1}]` | Two-part cascade. |
| `embed_bias0_rtp`, `embed_bias1_rtp` | Input | RTP | 128 floats each | Corresponding bias kernels | Biases stored as contiguous float arrays. |
| `solver{i}_dense0_matrixA_rtp[0..3]` | Input | RTP | 128 × 64 weights per port (8192 floats) | `solver{i}_dense0.matrixA` | Four-way cascade for each solver. |
| `solver{i}_dense{1,2,3}_matrixA_rtp[0..1]` | Input | RTP | 128 × 64 weights per port (8192 floats) | Subsequent dense layers | Two cascaded portions per layer. |
| `solver{i}_bias{0..3}_rtp` | Input | RTP | 128 floats | Fused bias/activation kernels | One bias vector per dense layer. |
| `solver{i}_roll_buf` | Internal | Shared buffer | 256 floats, split into four 64-float tiles | `solver{i}_dense0` | Implements tile fan-out for cascaded SSR inputs. |

All RTP ports accept `float32` payloads. The naming scheme for the data files is centralised in `../common/data_paths.h` and is automatically honoured by the host when it populates each port.

### Custom Kernels

- **`bias_add_leaky_relu_kernel`** (`bias_relu_fused.cpp`): Adds the supplied bias vector to every activation window, applies a leaky-ReLU (slope = 0.1), and zeroes any padded tail beyond `HIDDEN_SIZE`.
- **`window_split_128_to_64x2`**: Reads a 128-element window and emits two 64-element halves so cascaded dense layers receive disjoint tiles.
- **`roll_concat_kernel`**: Maintains a two-frame circular buffer plus a snapshot of the first valid frame in the current 50-track window. The kernel:
  - Outputs zeros until the first non-zero frame arrives (ensures deterministic cold-start).
  - Treats frames where every sample is exactly zero as padding and does not increment the 50-track counter.
  - Emits `[current, previous]` concatenations (256 floats) for normal frames.
  - After every 50 valid tracks, emits a wrap pair `[first_snapshot, last_frame]`, emulating `torch.roll` semantics but with explicit zero padding instead of implicit wrap-around beyond 50 tracks.

---

## Runtime Behaviour and Host Integration

- The host application (`../host/host.cpp`) allocates GMIO buffers with `adf::GMIO::malloc`, loads weight and bias tensors from `DATA_DIR`, and streams them into RTP ports before starting the graph.
- Input frames are transferred with `embed_input_gmio.gm2aie_nb`, while outputs use `embed_output_gmio.aie2gm_nb`. These non-blocking calls let the graph fill FIFOs while the host prepares subsequent transfers.
- After `g.run(<frame_count>)`, the host waits on the GMIO transactions and writes the 128-wide solver output vectors to `aieml10_output_aie.txt`.
- Layout hints in `graph_layout.hpp` set runtime ratios for activation and splitter kernels, nudging the placer for balanced tile utilisation without over-constraining physical placement.

---

## Build and Run

### Prerequisites

- AMD Vitis 2025.1 (or the platform specified in the repository root `Makefile`), including the Versal AI Engine compiler.
- DSP Library checkout available at `../dsp_lib` or exported via `DSPLIB_PATH`.
- Conda toolchain from the repository root:  
  ```bash
  conda env create -f hls_env.yml
  conda activate hls_env
  ```
- Board / platform environment:  
  ```bash
  source set_envs.sh
  ```
- Optional dataset override: `export DATA_DIR=$PWD/data_custom`.

### Command Reference

| Command | Scope | Purpose | Key Outputs |
|---------|-------|---------|-------------|
| `make aie TARGET=hw_emu` | Repo root | Compile the AI Engine graph (calls `aieml/Makefile` with `TARGET=hw`). | `aieml/Work/libadf.a` |
| `make sim TARGET=hw_emu` | Repo root | Launch AIE simulation (x86sim for `sw_emu`, cycle-accurate for `hw`/`hw_emu`). | `aieml/Work/aiesimulator_output/` |
| `make host TARGET=hw_emu` | Repo root | Build the XRT host application (native or aarch64 per `EMU_PS`). | `host.exe` |
| `make package TARGET=hw_emu` | Repo root | Link, create XSA, and package the design with the host binary. | `package.hw_emu/system_hw_emu.xclbin` |
| `make run TARGET=hw_emu` | Repo root | Run emulation (invokes `launch_hw_emu.sh` for hardware emulation). | Host console logs |
| `make -C aieml sim TARGET=x86sim` | `aieml/` | Run standalone x86 simulation of the graph. | `aieml/Work/x86simulator_output/` |
| `make -C aieml sim TARGET=hw` | `aieml/` | Run `aiesimulator` with waveform dumps for hardware timing. | `aieml/Work/aiesimulator_output/` |
| `make -C pl kernels KERNELS="mm2s s2mm"` | `pl/` | (Optional) build selected HLS kernels if a PL data mover is required. | `pl/ip/*.xo` |

Use `make clean_all` at the root to purge AI Engine workspaces, host binaries, and packaging artifacts between experiments.

---

## Data and Layer Assets

- Default tensor files reside in `../data` and are addressed through `../common/data_paths.h`.
- Partitions for cascaded layers follow the naming convention `<stage>_<dense idx>_weights_part{N}.txt` (e.g. `solver_1_dense_2_weights_part1.txt`). Each file contains exactly the number of floats the matching RTP port expects.
- To regenerate synthetic inputs, weights, and goldens:
  ```bash
  python data/generate_test_data.py \
    --input-dim 128 --hidden-dim 128 --output-dim 128 --dtype float32
  ```
  Align the script arguments with the constants in `nn_defs10.h` after any architecture change.

---

## Extending the Graph

- Adjust `INPUT_SIZE`, `HIDDEN_SIZE`, or solver dimensions in `nn_defs10.h`, regenerate tensors, and update `data_paths.h` if new files are introduced.
- When adding kernels, declare them in `graph.h`, wire them in `graph.cpp`, and update `graph_layout.hpp` if additional placement hints are required.
- Inspect performance with `vitis_analyzer Work/aiesimulator_output/default.aierun_summary` after hardware-targeted simulations to validate throughput and GMIO utilisation.

This README is the authoritative reference for the AI Engine graph; consult the root `README`/`Makefile` for host packaging details and the `pl/` directory if programmable logic kernels are reintroduced.
