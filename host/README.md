# Host Application

The host binary configures the AI Engine graph, streams input tracks via GMIO, and captures the solver output. It loads weight/bias tensors from `DATA_DIR`, updates the graph’s RTP ports, then performs non-blocking GMIO transfers to/from device memory.

---

## Usage

- Command: `./host.exe <system_*.xclbin>`
- Data root: `DATA_DIR` environment variable (defaults to `./data`).
- Hardware example (VEK280 SD card): `./host.exe system_hw.xclbin`

References:
- Graph name: `g` (instantiated by xrt::graph).
- Source: `host/host.cpp:1` and `host/Makefile:1`.

---

## What The Host Does

- Loads the XCLBIN onto device 0 and opens graph `g`.
- Loads and validates all layer weights/biases from `DATA_DIR`.
- Updates graph RTP ports with those buffers.
- Reads input vectors `embed_input.txt` and verifies the length is a multiple of `INPUT_SIZE`.
- Allocates two XRT AI Engine BOs for GMIO transfers and binds them to the graph’s GMIO endpoints.
- Runs the graph for `run_count = len(inputs) / INPUT_SIZE` frames.
- Writes `run_count * 128` output floats to `aieml10_output_aie.txt`.

Key code paths:
- Argument parsing and `DATA_DIR`: `host/host.cpp:62`.
- RTP updates for embed: `host/host.cpp:76`–`host/host.cpp:96`.
- RTP updates for solvers: `host/host.cpp:104`–`host/host.cpp:157`.
- GMIO and run: `host/host.cpp:169`–`host/host.cpp:203`.

---

## Data Contracts (Shapes, Types)

All tensors are `float32` and sizes are derived from `common/nn_defs10.h`.

- Input frames: `INPUT_SIZE` floats (defaults to 8; set to 128 for full track feature vectors).
- Output frames: `HIDDEN_SIZE` floats (128). Host writes `run_count * 128` values.

Weights and biases per layer:
- Embed
  - `embed_dense_0_weights.txt`: 128 × `INPUT_SIZE` floats.
  - `embed_dense_1_weights_part0.txt`: 128 × 64 floats.
  - `embed_dense_1_weights_part1.txt`: 128 × 64 floats.
  - `embed_dense_0_bias.txt`: 128 floats.
  - `embed_dense_1_bias.txt`: 128 floats.
- Solver i (i = 0,1,2)
  - `solver_i_dense_0_weights_part{0..3}.txt`: 128 × 64 floats each.
  - `solver_i_dense_{1,2,3}_weights_part{0..1}.txt`: 128 × 64 floats each.
  - `solver_i_dense_{0,1,2,3}_bias.txt`: 128 floats each.

Input/Output files:
- Input: `embed_input.txt` — size must be multiple of `INPUT_SIZE`.
- Output (AIE simulation): `aieml10_output_aie.txt` written by the PLIO sink when running x86 or hardware simulation.

File constants are declared in `common/data_paths.h` and consumed by both the host and AIE sim wrapper.

---

## GMIO Input Transfer (`gm2aie_nb`)

- The host binds an XRT BO to the GMIO endpoint `g.embed_input_gmio` using `xrt::aie::bo::async`.
- This mirrors the AI Engine graph API call `input_gmio::gm2aie_nb`.
- Data size: `inputs.size() * sizeof(float)`.
- Ordering: the host enqueues input, starts `graph.run(run_count)`, waits for completion, then calls `graph.end()`. Output remains in PL via `embed_output_plio`.

---

## Build Instructions

From the repo root (recommended):
- `make host TARGET=sw_emu` — native x86 build.
- `make host TARGET=hw_emu` — cross-compile for QEMU/aarch64.
- `make host TARGET=hw` — cross-compile for deployment on the board (aarch64).

Standalone from `host/` (advanced):
- Native x86: `make EMU_PS=X86` (requires `XILINX_XRT` and `XILINX_VITIS` set).
- QEMU/aarch64: `make EMU_PS=QEMU` (requires `SDKTARGETSYSROOT` and Vitis AIE libs in sysroot).

Outputs:
- Executable at repo root: `host.exe` (copied into package SD).

---

## Running on the VEK280 Evaluation Board

1. Build and package the hardware design from the repo root: `make package TARGET=hw`.
2. Copy the contents of `package.hw/` to the bootable SD card (preserve folder structure).
3. Boot the Versal VEK280 from that SD card.
4. On the target prompt, mount the SD card (usually `/mnt/sd-mmcblk0p1`) and run:

   ```bash
   cd /mnt/sd-mmcblk0p1
   export DATA_DIR=/mnt/sd-mmcblk0p1/data           # optional override
   ./host.exe system_hw.xclbin
   ```

5. Solver activations stream into PL via `embed_output_plio`; no host-side GMIO read is performed.

This sequence has been validated end-to-end on the Versal VEK280 Evaluation Board using the 2025.1 toolchain.

---

## Prerequisites

- XRT runtime and headers (`XILINX_XRT`) matching the platform.
- Vitis 2025.1 AI Engine tools (`XILINX_VITIS`).
- Valid platform XCLBIN created and packaged from repo root (`make package`).
- Dataset directory with the required tensor files (see Data Contracts) or set `DATA_DIR` accordingly.

Optional convenience:
- `make run TARGET=sw_emu|hw_emu` from the repo root handles packaging, emulation launch, and passes the correct XCLBIN path to `host.exe`.

---

## Error Handling & Diagnostics

- File size mismatches throw exceptions with the expected/actual count.
- Input size must be a multiple of `INPUT_SIZE` or execution aborts.
- All errors are reported on stderr with `ERROR: <message>` and cause a non-zero exit.

---

## Notes on roll_concat and Framing

- The AIE graph uses a stateful `roll_concat` kernel to pair the current 128-length activation with the previous one, counting only non-zero (valid) frames, and inserting a wrap pair every 50 valid tracks. The host does not manage this state; it simply feeds consecutive frames. On cold-start or when zero frames are present in the input, the kernel pads outputs with zeros, ensuring deterministic behaviour.
