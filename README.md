# 🧠 AI Engine-ML Neural Network Pipeline: Dense1 → LeakyReLU → Dense2 → LeakyReLU

This project demonstrates custom low-latency neural network pipelines implemented on the AMD Versal™ VEK280 platform using the AI Engine-ML (AIE‑ML) and Vitis tools. The core model family uses dense layers with leaky ReLU activations, targeting power‑efficient acceleration of small MLP inference tasks. It supports runtime configurability of dimensions and data types (`int8`, `int16`, `float16`, `float32`), with automated test data generation and full simulation support.

The design partitions work across three components of the Versal architecture:

- **AI Engine‑ML graphs** – execute dense layers. The project contains several
  variants:
  - `aieml/` – embedding graph (`dense1 → dense2`).
  - `aieml2/` – sub‑solver graph with four consecutive dense layers.
  - `aieml3/` – output head projecting to 27 classes (padded to 32).
  - `aieml10/` – extended end‑to‑end pipeline: embed (8→128) + leaky ReLU, embed (128→128) + leaky ReLU, a 256‑to‑128 solver chain replicated across branches, and a final (128→32 padded) projection head. See “AIEML10 Details” below.
- **Convenience build targets** – choose a graph at the top level by setting the
  `GRAPH` variable or invoking one of the shortcut targets. For example:

  ```bash
  make aieml2 TARGET=hw_emu
  ```

  Valid graphs are `aieml`, `aieml2`, and `aieml3`.

  Note: `aieml10` is currently a standalone AIE project with its own Makefile and is not wired into the top‑level `GRAPH` flow. Build and simulate it from `aieml10/`.
- **Programmable Logic (PL)** – supplies data‑mover kernels and two leaky ReLU units.
- **Host application** – runs on the processing system and orchestrates data movement and graph execution through XRT.

All build instructions are split into component READMEs:

- [AI Engine‑ML graphs](aieml/README.md) (see also [`aieml2`](aieml2/README.md) and [`aieml3`](aieml3/README.md))
- [Programmable Logic](pl/README.md)
- [Host Application](host/README.md)

For `aieml10`, use the section below until it’s integrated into the top‑level build.

Recent refactoring introduced a shared `common/data_paths.h` header and a `DATA_DIR`
environment variable so the host, PL tests, and AIE graphs can locate generated text
files consistently across components.

---

## 📦 Python Environment Setup

To set up the Python environment for generating test inputs, weights, and golden reference outputs:

```bash
conda env create -f hls_env.yml
conda activate hls_env
```

### Activate hardware toolchain paths:

```bash
source set_envs.sh
```

---

## 🔁 Workflow

1. **Data generation**
   ```bash
   python data/generate_test_data.py --input-dim 6 --hidden-dim 128 --output-dim 128 --dtype float32 --seed 123
   ```
2. **Graph compilation**
   ```bash
   make -C aieml graph
   ```
3. **Kernel build (PL)**
   ```bash
   make -C pl kernels
   ```
4. **Host build**
   ```bash
   make -C host
   ```
5. **System linking and packaging**
   ```bash
   make package
   ```

---

## 🧪 Generate Dummy Test Data & Weights

This command will generate:

- `input_data.txt` for the first dense layer
- `weights_dense1a.txt`, `weights_dense1b.txt`
- `weights_dense2a.txt`, `weights_dense2b.txt`
- `reference_output_data.txt` for validation

```bash
python data/generate_test_data.py --input-dim 6 --hidden-dim 128 --output-dim 128 --dtype float32 --seed 123
```

> ⚙️ All data is dumped into the project-parent `../data/` directory and formatted for `plio` input streams.

---

## ⚙️ Build the AIE Graph: `dense1 → leaky_relu → dense2`

Move into the AIE source directory and compile the graph:

```bash
cd aieml
make graph
```

This generates `Work/libadf.a` for linking with the rest of the system.

---

## ▶️ Simulate the AIE Graph

Run cycle-approximate simulation with profiling and memory tracking enabled:

```bash
cd aieml
make sim
```

Simulation results can be inspected in Vitis Analyzer:

```bash
vitis_analyzer Work/aiesimulator_output/default.aierun_summary
```

> 💡 Use this to inspect PLIO transactions, kernel traces, and memory usage to verify correctness and debug stalls.

---

## AIEML10 Details

- Graph path: `aieml10/`
- Output file: `../data/aieml10_output_aie.txt` (default `DATA_DIR`)
- AIE target: `hw` by default (set `TARGET=x86sim` for x86 AIE compile)

Architecture
- Embed stage: `dense 8×128` → bias add → `leaky_relu` → `dense 128×128` (2‑way cascade) → bias add → `leaky_relu`.
- Solver stage: roll‑concat expands to 256; a `256×128` dense (4‑way cascaded inputs) feeds three successive `128×128` dense layers, each separated by bias add, `leaky_relu`, and a 128→64×2 split feeding dual inputs. This chain is replicated into additional branches to increase compute depth (see `aieml10/graph.h`).
- Output head: `128→32` (padded) projection using a matrix reload RTP.

Build and simulate
- Activate toolchain: `source set_envs.sh` and Conda as in Setup below.
- Optional dataset override: `export DATA_DIR=$PWD/data_casc8`
- Compile graph: `make -C aieml10 graph TARGET=hw`
- Simulate: `make -C aieml10 sim`

Data files (placeholders)
- Input: `embed_input.txt`
- Embed weights (PLIO‑fed):
  - `embed_dense_0_weights.txt`
  - `embed_dense_1_weights_part0.txt`, `embed_dense_1_weights_part1.txt`
- Embed bias (RTP):
  - `embed_dense_0_bias.txt`
  - `embed_dense_1_bias.txt`
- Solver weights (PLIO‑fed):
  - `solver_0_dense_0_weights_part0.txt` … `part3.txt` (4 parts)
  - `solver_0_dense_1_weights_part0.txt`, `part1.txt` (2 parts)
  - `solver_0_dense_2_weights_part0.txt`, `part1.txt` (2 parts)
  - `solver_0_dense_3_weights_part0.txt`, `part1.txt` (2 parts)
- Solver bias (RTP, applied to all branches):
  - `solver_0_dense_0_bias.txt`
  - `solver_0_dense_1_bias.txt`
  - `solver_0_dense_2_bias.txt`
  - `solver_0_dense_3_bias.txt`
- Output head weights (RTP):
  - `output_dense_0_weights.txt`

Notes
- The `.txt` weights and bias files listed here are placeholders used for simulation bring‑up. Replace them with correct artifacts when available; file names must match those in `common/data_paths.h`.
- `DATA_DIR` defaults to `../data` for all components; override with `export DATA_DIR=/path/to/your/data` to point at alternate datasets.
- Simulation loads biases and the final output matrix via RTP at runtime (`aieml10/graph.cpp`), while most intermediate weights are streamed via PLIO from `DATA_DIR`.

---

## 📁 Directory Structure Overview

Your project is organized as follows:

```bash
├── aieml/
│   ├── Makefile
│   ├── README.md
│   ├── graph.cpp
│   └── graph.h
├── aieml10/                 # Standalone AIE graph (see section above)
│   ├── Makefile
│   ├── graph.cpp
│   ├── graph.h
│   ├── graph_layout.hpp
│   ├── nn_defs10.h
│   └── kernels: leaky_relu, bias_add, split, roll_concat
├── ../data/                  # Generated input, weights, and reference output
├── pl/                       # Programmable logic (HLS) kernels
│   ├── Makefile
│   └── README.md
├── host/                     # Host application sources
│   ├── Makefile
│   └── README.md
├── common/                   # Shared headers and configuration
│   └── nn_defs.h            # Neural network constants
├── model/                    # Python models and utilities
├── hls_env.yml               # Conda environment definition
├── pack.cfg                  # Packaging configuration
├── set_envs.sh               # Vitis and XRT environment setup
├── system_project.yaml       # System project description
└── Makefile                  # Top-level build orchestrator
```

---

## 🚧 Notes & WIP

- This design assumes full window-based streaming between kernels using PLIO.
- `dense2` expects the output from `leaky_relu` in full windows — ensure the dummy data generator creates enough input samples.
- Current focus is on validating functional correctness before host-integration or hardware execution.
