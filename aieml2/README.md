# AI Engine-ML Graph: `768×128 → 128×128 → 128×128 → 128×128`

This directory contains the **sub‑solver** graph.  It chains one
`768×128` matrix‑vector multiply with three `128×128` layers.  Each layer
consumes inputs and weights from text files defined in
[`common/data_paths.h`](../common/data_paths.h), allowing the location of
those files to be overridden with the `DATA_DIR` environment variable.

## Directory Layout

```
├── graph.cpp    # Instantiates `NeuralNetworkGraph` and runs it for simulation
├── graph.h      # Graph definition and PLIO connections
└── Makefile
```

## Build

Two wrapper targets are provided:

- `make aiesim` – compile and simulate the graph with file-based weights.
- `make hw` – build for hardware. Set `USE_PRELOADED_WEIGHTS` to 1 in
  `common/nn_defs.h` so that weights are supplied by a shared DMA stream.

Both commands write the compiled artefacts to `Work/`. Simulation reads all
inputs from `DATA_DIR` and writes layer outputs back to the same location.

