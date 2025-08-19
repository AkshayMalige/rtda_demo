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

From the repository root, compile the graph:

```bash
cd aieml2
make graph TARGET=hw       # or TARGET=x86sim
```

## Simulation

After a successful build, run cycle‑approximate simulation:

```bash
make sim TARGET=hw        # uses `aiesimulator`
```

Simulation reads all inputs from `DATA_DIR` and writes layer outputs back to
the same location.

