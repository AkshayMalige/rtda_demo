# AI Engine-ML Graph: `128×27` Output Head

`aieml3/` implements the final projection layer of the network.  A single
`128×27` matrix‑vector multiply is padded to a `128×32` implementation to
match the AIE vector width.  File names for inputs and outputs are provided
by [`common/data_paths.h`](../common/data_paths.h), and the base directory
can be changed by setting `DATA_DIR`.

## Directory Layout

```
├── graph.cpp    # Instantiates `NeuralNetworkGraph` and runs it for simulation
├── graph.h      # Graph definition and PLIO connections
└── Makefile
```

## Build

Use the convenience targets provided in the `Makefile`:

- `make aiesim` – compile and run simulation with weights loaded from
  files.
- `make hw` – build the graph for hardware. Set `USE_PRELOADED_WEIGHTS` to 1 in
  `common/nn_defs.h` to enable the shared DMA weight stream.

Results are written next to the input files under `DATA_DIR`.

