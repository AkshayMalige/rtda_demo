# 🧠 AI Engine-ML Neural Network Pipeline: Dense1 → LeakyReLU → Dense2 → LeakyReLU

This project demonstrates a custom low-latency neural network pipeline implemented on the AMD Versal™ VEK280 platform using the AI Engine-ML (AIE-ML) and Vitis tools. The core model consists of two dense layers with leaky ReLU activations after each layer, targeting power-efficient acceleration of small MLP inference tasks. It supports runtime configurability of dimensions and data types (`int8`, `int16`, `float16`, `float32`), with automated test data generation and full simulation support.

> **Note**: source `set_envs.sh` first.
The design partitions work across three components of the Versal architecture:

- **AI Engine‑ML graphs** – execute dense layers. The project now contains three
  variants:
  - `aieml/` – embedding graph (`dense1 → dense2`).
  - `aieml2/` – sub‑solver graph with four consecutive dense layers.
  - `aieml3/` – output head projecting to 27 classes (padded to 32).
- **Convenience build targets** – choose a graph at the top level by setting the
  `GRAPH` variable or invoking one of the shortcut targets. For example:

  ```bash
  make aieml2 TARGET=hw_emu
  ```

  Valid graphs are `aieml`, `aieml2`, and `aieml3`.
- **Programmable Logic (PL)** – supplies data‑mover kernels and two leaky ReLU units.
- **Host application** – runs on the processing system and orchestrates data movement and graph execution through XRT.

All build instructions are split into component READMEs:

- [AI Engine‑ML graphs](aieml/README.md) (see also [`aieml2`](aieml2/README.md) and [`aieml3`](aieml3/README.md))
- [Programmable Logic](pl/README.md)
- [Host Application](host/README.md)

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
   The build also exports packet-switch packet IDs to `export/generated/packet_ids.h`
   for inclusion by the PL and other components.
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

6. **Run the host application**
   Pass the generated `xclbin` to the host executable (path will vary with build target, e.g. hardware emulation shown below):
   ```bash
   ./host/system_host system_project/_x.hw_emu/system.xclbin
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

## 📁 Directory Structure Overview

Your project is organized as follows:

```bash
├── aieml/
│   ├── Makefile
│   ├── README.md
│   ├── graph.cpp
│   └── graph.h
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
