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

From the repository root:

```bash
cd aieml3
make graph TARGET=hw       # or TARGET=x86sim
```

## Simulation

Run cycle‑approximate simulation once the build completes:

```bash
make sim TARGET=hw        # uses `aiesimulator`
```

Results are written next to the input files under `DATA_DIR`.

