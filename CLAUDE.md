# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

RTDA (Real-Time Data Analysis) demo targeting the AMD/Xilinx Versal VEK280 platform. It implements a neural network inference pipeline using the AI Engine ML (AIE-ML) array for matrix-vector operations, with PL (Programmable Logic) kernels for data movement and post-processing.

The network architecture: an **embedding block** (2 dense layers) feeds into **3 chained solver blocks** (each with 4 dense layers). Every dense layer is followed by a fused bias+leaky-ReLU activation. Solver inputs are constructed via a roll-concat operation that doubles the vector width before entering the first dense layer.

The project supports dual precision: `float` (32-bit) and `int16` (16-bit quantized), controlled at build time.

## Environment Setup

```bash
source set_envs.sh
```

This sources XRT, Vitis 2024.2, PetaLinux, and the aarch64 cross-compilation sysroot. Sets `PLATFORM`, `SYSROOT`, `IMAGE`, `ROOTFS`, and `DATA_DIR`.

## Build Commands

All builds are driven from the **top-level Makefile**. There are two categories of targets:

### Component-Level Targets (standalone, no system TARGET needed)

```bash
# --- AIE Graph ---
make aie_x86sim  PRECISION=float   # Compile AIE graph for x86 simulation
make aie_hw      PRECISION=float   # Compile AIE graph for hw (aiesimulator / v++ link)
make aie_sim_x86 PRECISION=float   # Compile + run x86simulator (fast functional)
make aie_sim_hw  PRECISION=float   # Compile + run aiesimulator (cycle-accurate)

# --- PL Kernels ---
make pl_build    PRECISION=float   # Synthesize + export XO files
make pl_csim     PRECISION=float   # Run C-simulation
make pl_cosim    PRECISION=float   # Run RTL co-simulation

# --- Host Application ---
make host_x86     PRECISION=float  # Build for native x86 execution
make host_aarch64 PRECISION=float  # Build for aarch64 (cross-compile)
```

### System-Level Targets (use TARGET=hw_emu|hw)

AIE-ML on VEK280 does not support `sw_emu` at the system level. For fast AIE-only testing, use `make aie_sim_x86`.

```bash
make system TARGET=hw_emu  PRECISION=float  # Full build: hw AIE + PL + aarch64 host + link + package
make system TARGET=hw      PRECISION=float  # Full build: hw AIE + PL + aarch64 host + link + package
make run    TARGET=hw_emu  PRECISION=float  # Build + run hw emulation
```

### Utilities

```bash
make sim                          # Quick AIE sim (alias for aie_sim_x86)
make print_vars TARGET=hw_emu    # Show all build variable values
make clean                        # Clean PL + system build artifacts
make clean_all                    # Clean everything (AIE + PL + Host + system)
make help                         # Show full usage guide
```

### Target Mapping

The top-level Makefile translates system TARGET into component-specific values:

| System TARGET | AIE TARGET | Host EMU_PS | v++ link/package |
|---------------|-----------|-------------|------------------|
| `hw_emu`      | `hw`      | `QEMU`      | `-t hw_emu`      |
| `hw`          | `hw`      | `QEMU`      | `-t hw`          |

`PRECISION` (float/int16) is passed consistently to all sub-builds. It generates `config_gen.h` which toggles `USE_INT16`, selecting `DATA_TYPE` as either `float` or `int16_t` via `aieml/data_types.h`.

### Sub-Makefile Direct Use

The sub-Makefiles can still be invoked directly if needed:

```bash
# AIE (aieml/Makefile) — TARGET: x86sim | hw
cd aieml && make graph TARGET=x86sim PRECISION=float
cd aieml && make sim   TARGET=x86sim

# PL (pl/Makefile) — TARGET for sim: csim | hw_emu
cd pl && make kernels DATA_TYPE=float
cd pl && make sim TARGET=csim DATA_TYPE=float

# Host (host/Makefile) — EMU_PS: X86 | QEMU
cd host && make EMU_PS=X86 PRECISION=float
```

Each PL kernel has a TCL script (`<kernel>_project.tcl`) that drives Vitis HLS.

## Architecture

### Key directories

- **aieml/** - AIE-ML graph definition and custom kernels. `graph.h` defines `NeuralNetworkGraph` using DSP library `matrix_vector_mul_graph` for dense layers. `graph.cpp` is the simulation testbench that loads weights/biases via GMIO and runs inference.
- **common/** - Shared headers: `nn_defs10.h` (layer sizes, cascade lengths), `data_paths.h` (weight/bias file paths), `linker_aieml.cfg` (PL-AIE stream connectivity).
- **pl/** - Vitis HLS kernels for data movement (mm2s, s2mm) and processing (leaky_relu, leaky_splitter, track_average). Source in `pl/src/`.
- **data/** - Pre-exported weight/bias text files. Partitioned weights use `_partN.txt` naming.
- **dsp_lib/** - Vitis DSP Library (L1/L2) providing `matrix_vector_mul_graph` and FFT/FIR primitives.

### Data flow

1. Host sends input vectors (8 elements) via GMIO to AIE
2. Embed block: dense0 (8->128) -> bias+ReLU -> split (128->64x2) -> dense1 (128->128) -> bias+ReLU
3. Solver blocks (x3): roll_concat (128->256, via shared_buffer with tiling) -> dense0 (256->128) -> [bias+ReLU -> split -> denseN -> bias+ReLU] x3
4. Final output (128 elements) exits via GMIO or PL PLIO stream to `track_average_pl`

### int16 quantization details

When `PRECISION=int16`, `GRAPH_INPUT_SIZE` is padded from 8 to 16 elements (256-bit AIE vector alignment). Weight matrices and input vectors are zero-padded accordingly in the testbench (`pad_matrix_rows`, `pad_transaction_stream` from `utils.hpp`).

### Cascade and partitioning

Dense layers use cascade chains for parallelism. Weights are split across cascade tiles:
- embed_dense0: 1 cascade tile
- embed_dense1: 2 cascade tiles
- solver_dense0: 4 cascade tiles (256-wide input)
- solver_dense1/2/3: 2 cascade tiles each

### PL-AIE connectivity

`common/linker_aieml.cfg` wires the AIE PLIO output to `track_average_pl`'s AXI stream input. The PL kernel accumulates frames and writes averaged results to DDR.
