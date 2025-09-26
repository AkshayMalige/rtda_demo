# AI Engine-ML Graph: Packet-Switched Two-Layer Neural Network

This directory implements the AI Engine graph that underpins the RTDA demo's
hidden-layer cascade. It showcases how ADF packet infrastructure can be used to
move activations between kernels while keeping the dense-layer compute blocks on
pure streaming interfaces.

## Architecture Overview

The graph is assembled from the stage descriptors listed in
[`graph/config.hpp`](graph/config.hpp). Each descriptor instantiates one of the
lightweight subgraphs implemented in [`graph/layers.hpp`](graph/layers.hpp):

- **`PacketFanoutStage`** wraps the transport kernels, using the templated
  helpers in [`kernels/transport/packet_helpers.hpp`](kernels/transport/packet_helpers.hpp)
  to emit and consume packet headers while managing TLAST for every branch.
- **`DenseLayer`** embeds the DSPLib matrix-vector graphs, exposes their RTP
  ports, and surfaces metadata (fan-in width, cascade length, weight sources)
  to the host through `DenseStageRuntimeInfo`.
- **`ActivationLayer`** encapsulates activation kernels such as the Leaky ReLU
  implementation in [`kernels/activations/leaky_relu.cpp`](kernels/activations/leaky_relu.cpp).

The dense kernel wrappers live alongside the transport and activation code in
[`kernels/dense`](kernels/dense), which exposes an umbrella
[`all.hpp`](kernels/dense/all.hpp) for graphs that need to include every dense
implementation.

The default configuration builds the following pipeline:

1. **Packet ingress** – a single-branch `PacketFanoutStage` converts the input
   PLIO stream into packets via `packetize_stream<8, 1>()`, then immediately
   depacketizes it for the first dense layer.
2. **Dense 0** – a `DenseLayer` wrapping an 8×128 DSPLib graph consumes the
   depacketized stream.
3. **Activation** – `ActivationLayer<leaky_relu_kernel>` applies the Leaky ReLU.
4. **Hidden fan-out** – `packetize_stream<128, CASCADE_LENGTH>()` slices the
   hidden activations into cascade packets which are depacketized into
   `CASCADE_LENGTH` independent streams.
5. **Dense 1** – another `DenseLayer` feeds the cascaded DSPLib kernels and
   drives the output PLIO.

Because the connections are generated from metadata, adding or reordering
layers only requires updating the configuration table and recompiling.

## Directory Layout

```
├── graph.cpp                        # Instantiates `NeuralNetworkGraph` and loads weights via metadata
├── graph.h                          # Config-driven graph definition and dense-layer inventory
├── graph/                           # Subgraph definitions and configuration tables
│   ├── config.hpp                   # Stage descriptors and dense weight sources
│   ├── layers.hpp                   # Packet/Dense/Activation subgraphs + traits
│   └── types.hpp                    # Shared enum definitions
├── kernels/
│   ├── activations/
│   │   ├── all.hpp
│   │   └── leaky_relu.cpp/h         # Leaky ReLU activation kernel (slope=0.1)
│   ├── dense/
│   │   └── all.hpp                  # Umbrella include for DSPLib dense wrappers
│   └── transport/
│       ├── all.hpp
│       ├── packet_helpers.hpp       # `packetize_stream` / `depacketize_stream` templates
│       ├── stream_to_packet.cpp/h   # Converts input float stream to packets
│       ├── hidden_stream_to_packet.cpp/h
│       └── packet_to_stream.cpp/h   # Converts packets back to streams
├── aie.cfg                          # AI Engine compiler configuration
└── Makefile                         # Build rules with corrected DATA_DIR path
```

## Build

The supplied `Makefile` wraps the standard build flow using `v++` with AI Engine
configuration. From this directory, compile and simulate the graph with:

```bash
make graph TARGET=hw       # Compile AIE graph (default: hw)
make sim                   # Run AI Engine simulation with weight loading
make clean                 # Clean all build artifacts
```

**Note**: The Makefile has been updated to use absolute paths for `DATA_DIR` to fix
weight file resolution issues when `aiesimulator` runs from the `Work/temp/` directory.

To invoke the compiler directly:

```bash
v++ -c --mode aie --target hw graph.cpp \
    kernels/transport/stream_to_packet.cpp \
    kernels/transport/hidden_stream_to_packet.cpp \
    kernels/transport/packet_to_stream.cpp \
    kernels/activations/leaky_relu.cpp \
    --platform=${PLATFORM} \
    --work_dir=Work \
    --config=aie.cfg \
    --include="./" \
    --include="../common" \
    --include="../dsp_lib/L1/src/aie" \
    --include="../dsp_lib/L1/include/aie" \
    --include="../dsp_lib/L2/include/aie"
```

Both commands produce `Work/libadf.a` inside this directory.

## Data Flow Walkthrough

1. **Input embedding**: `input_data` PLIO feeds an 8-element float vector into
   the ingress `PacketFanoutStage`, which tags the samples with an ADF packet
   header before immediately depacketizing them for the first dense layer.
2. **Dense 0 → Activation**: The DSPLib dense graph produces a 128-element
   vector that flows through the Leaky ReLU activation subgraph.
3. **Hidden-layer packet hop**: `packetize_stream<128, CASCADE_LENGTH>()`
   consumes the Leaky ReLU output, builds one packet per cascade lane, and marks
   TLAST on the final element in each payload.
4. **Cascade fan-out**: `depacketize_stream<32>()` (32 = 128 / 4) converts each
   packet back into a float stream for the downstream dense cascade.
5. **Output logits**: The cascade of dense kernels writes its accumulated output
   to the shared PLIO `output_data`, producing the inference result.

Throughout the flow the packets exist only on the inter-kernel hop where fan-out
is required, allowing the dense compute kernels to stay on standard stream
interfaces.

## Files and Build Instructions

The PLIO files consumed by the graph reside in the project-parent
[`../data/`](../../data) directory. They are generated by
[`data/generate_test_data.py`](../data/generate_test_data.py).

## Extending the graph

The descriptors in [`graph/config.hpp`](graph/config.hpp) drive both the graph
construction and the runtime weight loading logic. To add another layer or swap
in a custom kernel:

1. **Create or reuse a kernel/subgraph** – place the implementation under
   `kernels/` (adding to the relevant `all.hpp`) or add a new subgraph class to
   `graph/layers.hpp` if a different composition is required. The transport
   helpers in `kernels/transport/packet_helpers.hpp` can be instantiated with a
   single `packetize_stream<FrameElems, Branches>()` or
   `depacketize_stream<FrameElems>()` call to handle packet headers, payload
   loops, and TLAST propagation for you.
2. **Update the stage table** – append or reorder entries in
   `config::kStageDescriptors`, specifying the stage kind, fan-out/cascade
   width, and RTP port count. The compile-time checks in `graph.h` ensure the
   descriptors agree with the instantiated types.
3. **Describe weight sources** – for dense layers, add an entry to
   `config::kDenseWeights` with either a single weight file name or a prefix
   that is expanded per cascade branch. `graph.cpp` will automatically iterate
   the resulting `DenseStageRuntimeInfo` array when loading weights.

### Stage descriptor reference

Each entry in `config::kStageDescriptors` contains:

| Field           | Meaning                                                                 |
| --------------- | ----------------------------------------------------------------------- |
| `kind`          | One of `PacketFanout`, `Dense`, or `Activation`, selecting the subgraph. |
| `name`          | String identifier used when tracing the AI Engine graph build.          |
| `fanout`        | Branch count for packet stages (e.g. hidden-layer fan-out).             |
| `cascade`       | Number of cascaded DSPLib kernels in a dense stage.                     |
| `rtp_ports`     | Count of RTP inputs exposed by the dense layer.                         |
| `frame_elems`   | Payload width for packetization helpers (ignored by dense/activations). |

Only the fields relevant to a particular stage kind are consumed at runtime, but
the compile-time checks expect the metadata to be well-formed so downstream
layers can reason about their fan-in and weight layout.

After editing the configuration, rebuild the graph (`make graph`) to regenerate
the wiring and ensure the metadata stays in sync.
