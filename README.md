# Real-Time Detector Alignment (RTDA) -- Versal AIE-ML Demo

Neural network inference pipeline targeting the AMD/Xilinx Versal VEK280. The design runs entirely on the AI Engine ML array with a PL post-processing kernel, supporting both **float32** and **int16** precision at build time.

## Network Architecture

```
Input (8 floats)
  |
  v
Embed: dense0 (8->128) -> bias+leakyReLU -> split -> dense1 (128->128) -> bias+leakyReLU
  |
  v
Solver-0: roll_concat (128->256) -> dense0 -> [bias+ReLU -> split -> denseN] x3
  |
  v
Solver-1: (same structure)
  |
  v
Solver-2: (same structure) -> PLIO stream -> track_average PL kernel -> DDR
```

- 3 chained solver blocks, each with 4 dense layers and fused bias+leaky ReLU (alpha=0.1)
- Roll-concat pairs current frame with previous frame (50-frame window, 3-frame warm-up)
- `track_average` PL kernel averages groups of output frames before writing to DDR

## Prerequisites

- AMD Vitis 2024.2 with AI Engine tools
- XRT runtime and headers
- PetaLinux 2024.2 SDK (for cross-compilation)
- VEK280 base platform (`xilinx_vek280_base_202420_1`)

## Environment Setup

```bash
source set_envs.sh
```

Sets `XILINX_VITIS`, `PLATFORM`, `SYSROOT`, `DATA_DIR`, and cross-compilation toolchain.

## Build Commands

All commands accept `PRECISION=float` (default) or `PRECISION=int16`.

### Quick Reference

```bash
# AIE graph
make aie TARGET=sw_emu PRECISION=float       # x86 functional sim
make aie TARGET=hw  PRECISION=int16       # hardware model
make sim TARGET=sw_emu PRECISION=float       # run x86 simulation

# PL kernels
make pl TARGET=hw_emu PRECISION=float     # synthesize track_average

# Host application
make host TARGET=sw_emu PRECISION=float   # native x86 build
make host TARGET=hw_emu PRECISION=int16   # cross-compile for QEMU/aarch64

# Full system
make all TARGET=hw_emu PRECISION=float    # aie + pl + host + link + package
make run TARGET=sw_emu                    # run emulation

# Utilities
make print_vars TARGET=hw_emu PRECISION=int16
make clean_all
```

### Per-Component

```bash
# AIE only (aieml/)
cd aieml
make graph TARGET=sw_emusim PRECISION=float
make sim   TARGET=sw_emusim
make clean

# PL only (pl/)
cd pl
make sim TARGET=csim DATA_TYPE=float      # C simulation
make sim TARGET=csim DATA_TYPE=int16
make kernels DATA_TYPE=float              # synthesize XO
make clean

# Host only (host/)
cd host
make EMU_PS=X86 PRECISION=float           # native
make EMU_PS=QEMU PRECISION=int16          # aarch64 cross
make clean
```

### System Link, Package, Run

```bash
make link    TARGET=hw_emu                # create XSA
make package TARGET=hw_emu                # generate xclbin
make run     TARGET=hw_emu                # launch HW emulation
```

### Hardware (VEK280)

```bash
make all TARGET=hw PRECISION=float
# Copy package.hw/ to SD card, boot the board, then:
cd /mnt/sd-mmcblk0p1
./host.exe system_hw.xclbin
```

## Precision Switching (float32 / int16)

Controlled by `PRECISION` at the top level, which propagates to all sub-makes:

| Component | Variable | Mechanism |
|-----------|----------|-----------|
| AIE graph | `PRECISION=int16` | Generates `config_gen.h` with `#define USE_INT16`, selects `DATA_TYPE` via `data_types.h` |
| PL kernel | `DATA_TYPE=int16` | Passes `-DUSE_INT16` to HLS; stream widened to 32-bit for PLIO compatibility |
| Host app  | `PRECISION=int16` | Passes `-DUSE_INT16`; reads/writes `int16_t` values for RTP and GMIO |

When switching precision, you must:
1. Replace the `data/` weight and bias files with values in the target format (floats for float32, integers for int16)
2. Clean and rebuild: `make clean_all && make all TARGET=... PRECISION=...`

### int16 Alignment

For int16, the AIE vector width is 256 bits = 16 elements. `INPUT_SIZE` (8) is padded to `GRAPH_INPUT_SIZE` (16) with zeros. Weight matrices are zero-padded to match. This is handled automatically in the AIE testbench (`graph.cpp`) and host (`host.cpp`).

## Repository Structure

```
Makefile                      Top-level build orchestrator
pack.cfg                      Vitis packaging config
set_envs.sh                   Environment setup script
aieml/
  graph.h                     AIE-ML graph: all kernels, ports, connections
  graph.cpp                   Simulation testbench (GMIO input, PLIO output)
  graph_layout.hpp            Tile placement and runtime ratios
  data_types.h                DATA_TYPE selection (float/int16) via config_gen.h
  bias_relu_fused.cpp         Fused bias + leaky ReLU kernel (vectorized)
  window_split_128_to_64x2.cpp  128->64x2 window splitter
  roll_concat.cpp             Stateful frame pairing kernel (3 instances)
  utils.hpp                   File I/O, padding helpers
  Makefile                    AIE compile/sim targets
common/
  nn_defs10.h                 Network dimensions, cascade lengths, constants
  data_paths.h                Weight/bias/output file name macros
  linker_aieml.cfg            v++ linker: AIE PLIO -> track_average PL
pl/
  src/track_average_pl.cpp    PL kernel: stream averaging (float32/int16)
  src/track_average_test.cpp  HLS C-simulation testbench
  track_average_project.tcl   Vitis HLS project script
  Makefile                    PL synthesis/sim targets
host/
  host.cpp                    XRT host: weight loading, GMIO, graph control
  Makefile                    Host build (native x86 or aarch64 cross)
data/
  embed_input.txt             Input frames (run_count x INPUT_SIZE)
  embed_dense_*               Embed layer weights and biases
  solver_{0,1,2}_dense_*      Solver layer weights and biases (partitioned)
  aieml10_output_aie.txt      AIE simulation output
  host_output.txt             track_average output
```

## Key Parameters (common/nn_defs10.h)

| Parameter | Value | Description |
|-----------|-------|-------------|
| `INPUT_SIZE` | 8 | Features per input track |
| `HIDDEN_SIZE` | 128 | Hidden layer width |
| `OUTPUT_SIZE` | 128 | Output vector width |
| `LEAKY_SLOPE` | 0.1 | Leaky ReLU negative slope |
| `TRACK_AVERAGE_THRESHOLD` | 50 | Frames averaged by track_average PL |
| `ROLL_CONC_SUBSET_SIZE` | 2 | Roll-concat doubles width (128->256) |
| `EMBED_DENSE0_CASC_LEN` | 1 | Cascade tiles for embed dense0 |
| `EMBED_DENSE1_CASC_LEN` | 2 | Cascade tiles for embed dense1 |
| `SUBSOLVER0_INPUT_PARTS` | 4 | Cascade tiles for solver dense0 (256-wide) |
| `SUBSOLVER0_LAYER_WEIGHTS_PARTS` | 2 | Cascade tiles for solver dense1/2/3 |

## Ports and Interfaces

- **Input GMIO:** `g.embed_input_gmio` -- host sends input frames via DMA
- **Output PLIO:** `embed_output` -- streams solver-2 output to `track_average` PL kernel
- **RTP ports:** Async parameter updates for all weight matrices and bias vectors
- **PL AXI stream:** 32-bit wide (both float and int16 modes); `track_average` writes averaged results to DDR via AXI master

## Data Files

Weight files use partitioned naming: `solver_0_dense_0_weights_part{0,1,2,3}.txt` for the 4-way cascaded dense0, `solver_0_dense_1_weights_part{0,1}.txt` for 2-way dense1/2/3.

For float32: files contain decimal float values. For int16: files must contain integer values.

All file paths are defined as macros in `common/data_paths.h` and referenced by both the AIE testbench and host application.
