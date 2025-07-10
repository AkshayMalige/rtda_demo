# 🧠 AI Engine-ML Neural Network Pipeline: Dense1 → LeakyReLU → Dense2

This project demonstrates a custom low-latency neural network pipeline implemented on the AMD Versal™ VEK280 platform using the AI Engine-ML (AIE-ML) and Vitis tools. The core model consists of two dense layers with a leaky ReLU activation in between, targeting power-efficient acceleration of small MLP inference tasks. It supports runtime configurability of dimensions and data types (`int8`, `int16`, `float16`, `float32`), with automated test data generation and full simulation support.

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

## 🧪 Generate Dummy Test Data & Weights

This command will generate:

- `input_data.txt` for the first dense layer
- `weights_dense1a.txt`, `weights_dense1b.txt`
- `weights_dense2a.txt`, `weights_dense2b.txt`
- `reference_output_data.txt` for validation

```bash
python generate_test_data.py --input-dim 6 --hidden-dim 128 --output-dim 128 --dtype float32 --seed 123
```

> ⚙️ All data is dumped into the `./aieml/data/` directory and formatted for `plio` input streams.

---

## ⚙️ Build the AIE Graph: `dense1 → leaky_relu → dense2`

Move into the AIE source directory and compile the graph:

```bash
cd aieml
v++ --compile --mode aie --target hw ./main.cpp --part=xcve2802-vsvh1760-2MP-e-S -I./data -I./kernels
```

This will compile the AI Engine graph and produce:

```
libadf.a
```

---

## ▶️ Simulate the AIE Graph

Run cycle-approximate simulation with profiling and memory tracking enabled:

```bash
aiesimulator --profile --pkg-dir=Work --dump-vcd=foo --enable-memory-check
```

You can then open the results in Vitis Analyzer:

```bash
vitis_analyzer Work/aiesimulator_output/default.aierun_summary
```

> 💡 Use this to inspect PLIO transactions, kernel traces, and memory usage to verify correctness and debug stalls.

---

## 📁 Directory Structure Overview

Your project will be organized as follows:

```bash
├── aieml/
│   ├── data/                 # Generated input, weights, and golden output
│   ├── kernels/              # AIE kernel implementations (dense1, dense2, leaky_relu)
│   ├── main.cpp              # Graph definition and PLIO connections
│   ├── Makefile
├── host/                     # (Optional) Host application sources
│   └── Makefile
├── hw_link/                  # System configuration for linking
│   └── system.cfg
├── hls_env.yml               # Conda environment definition
├── generate_test_data.py     # Dummy data generator
├── set_envs.sh               # Vitis and XRT environment setup
└── Makefile
```

---

## 🚧 Notes & WIP

- This design assumes full window-based streaming between kernels using PLIO.
- `dense2` expects the output from `leaky_relu` in full windows — ensure the dummy data generator creates enough input samples.
- Current focus is on validating functional correctness before host-integration or hardware execution.
