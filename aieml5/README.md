# AI Engine-ML Graph: Full Embed Block Implementation

This directory implements the complete **embed block** of the MLP (Multi-Layer Perceptron)
neural network for the RTDA demo. This is the full embedding layer implementation that
processes 8-element input vectors through a two-layer neural network cascade using
AI Engine packet switching infrastructure.

## Current Status

**Working Implementation**: The neural network graph is fully functional with packet-based
activation flow between dense layers. The implementation uses a **hardcoded approach** in
`graph.h` with direct DSPLib instantiation for maximum stability and performance.

**Recent Changes**:
- Removed unused template-based configuration system (config.hpp, types.hpp, layers.hpp)
- Simplified to single hardcoded graph implementation for reliability
- All neural network stages work correctly with RTP weight loading

## Architecture Overview

This is the **full embed block** implementation with the following architecture:

```
Input (8 floats) → Dense Layer 1 (8×128) → Bias Add → LeakyReLU → Dense Layer 2 (128×128) → Roll+Concat → Output (768 floats)
```

### High-Level Data Flow Diagram

```
    input_data(PLIO)
         |
    [stream_to_packet]
         |
      (packets)
         |
    [pktsplit<1>]
         |
    [packet_to_stream]
         |
      (stream)
         |
    [dense1: 8×128]
         |
     [bias_add]
         |
    [leaky_relu]
         |
[hidden_stream_to_packet]
         |
      (packets)
         |
   [pktsplit<4>] ──┬── [pkt→stream] → [dense2[0]: 128×128] ──┬──
                   ├── [pkt→stream] → [dense2[1]: 128×128] ──┤
                   ├── [pkt→stream] → [dense2[2]: 128×128] ──┤   [roll_concat]
                   └── [pkt→stream] → [dense2[3]: 128×128] ──┘        |
                                                                 output_data(PLIO)
                                                                 (768 floats)
```

### Component Details

- **Input Layer**: 8-element float vector input via `input_data` PLIO
- **Dense 0 ("dense1")**: 8×128 matrix-vector multiplication using DSPLib (`dense8x128`)
- **Bias Addition**: Bias add kernel (`k_bias_add`) adds learned bias values from RTP to dense layer output
- **Activation**: Leaky ReLU kernel (`k_lrelu0`) processes the 128-element hidden layer
- **Hidden Packetization**: `hidden_stream_to_packet_kernel` splits the activation
  stream into `CASCADE_LENGTH` packets (currently 4), with each packet containing
  32 elements (128/4 = 32 elements per cascade branch)
- **Cascade Fan-out**: `pktsplit<CASCADE_LENGTH>` distributes packets to cascade branches
- **Dense 1 ("dense2")**: 4 parallel 128×128 DSPLib matrix-vector kernels (CASCADE_LENGTH=4),
  each processing their portion of the hidden vector to produce final logits
- **Roll+Concat**: Produces 6 cyclic shifts of the dense output (6 × 128 = 768 values)
- **Runtime Parameter Loading**: All dense kernels and the bias add kernel receive
  weights/bias values via RTP ports, enabling dynamic parameter updates without
  graph recompilation

The packet-based hop between the Leaky ReLU and the cascade ensures each branch
receives only the portion of the hidden vector it needs while avoiding wide
fan-out stream connections.

## Directory Layout

```
├── graph.cpp                        # Instantiates `NeuralNetworkGraph` with RTP weight loading
├── graph.h                          # Main graph definition with hardcoded 4-way cascade workflow
├── kernels/                         # All kernel implementations in single directory
│   ├── stream_to_packet.cpp/h           # Converts input float stream to packets
│   ├── hidden_stream_to_packet.cpp/h    # Splits hidden activations into cascade packets
│   ├── packet_to_stream.cpp/h           # Converts packets back to streams for dense layers
│   ├── bias_add.cpp/h                   # Bias addition kernel (adds RTP bias values to dense layer output)
│   ├── leaky_relu.cpp/h                 # Leaky ReLU activation kernel (slope=0.1)
│   ├── roll_concat.cpp/h                # Produces 6 cyclic shifts of the dense output
│   ├── all.hpp                          # Dense layer includes
│   ├── activations_all.hpp              # Activation layer includes
│   └── transport_all.hpp                # Transport layer includes
├── split_stream.cpp/h               # Stream splitting utilities (deprecated)
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
    kernels/stream_to_packet.cpp kernels/hidden_stream_to_packet.cpp \
    kernels/packet_to_stream.cpp kernels/leaky_relu.cpp kernels/roll_concat.cpp \
    kernels/bias_add.cpp \
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

## Detailed Architecture Diagrams

### Packet Flow Architecture

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                          EMBED BLOCK FULL IMPLEMENTATION                        │
├─────────────────────────────────────────────────────────────────────────────────┤
│  Input: 8 floats                                           Output: 768 floats   │
│                                                                                 │
│  ┌─────────────┐    ┌────────────────┐    ┌─────────────┐                     │
│  │ input_data  │───▶│stream_to_packet│───▶│ pktsplit<1> │                     │
│  │   (PLIO)    │    │    kernel      │    │             │                     │
│  └─────────────┘    └────────────────┘    └──────┬──────┘                     │
│                                                   │                            │
│  ┌─────────────┐    ┌────────────────┐           │                            │
│  │packet_to_   │◀───│     packets     │◀──────────┘                            │
│  │stream kernel│    │                 │                                        │
│  └──────┬──────┘    └────────────────┘                                        │
│         │                                                                      │
│  ┌──────▼──────┐    ┌────────────────┐    ┌─────────────┐                     │
│  │   dense1    │───▶│   bias_add     │───▶│ leaky_relu  │                     │
│  │  (8×128)    │    │   kernel       │    │   kernel    │                     │
│  │  DSPLib     │    │     +RTP       │    │ (slope=0.1) │                     │
│  └─────────────┘    └────────────────┘    └──────┬──────┘                     │
│                                                   │                            │
│  ┌─────────────┐    ┌────────────────┐           │                            │
│  │hidden_stream│◀───│ 128 activations │◀──────────┘                            │
│  │_to_packet   │    │                 │                                        │
│  │  kernel     │    │                 │                                        │
│  └──────┬──────┘    └────────────────┘                                        │
│         │                                                                      │
│  ┌──────▼──────┐                                                               │
│  │ pktsplit<4> │                                                               │
│  │             │                                                               │
│  └─┬─┬─┬─┬─────┘                                                               │
│    │ │ │ │                                                                     │
│    │ │ │ └─────┐                                                               │
│    │ │ └───────┼─────┐                                                         │
│    │ └─────────┼─────┼─────┐                                                   │
│    └───────────┼─────┼─────┼─────┐                                             │
│                │     │     │     │                                             │
│  ┌─────────────▼┐  ┌─▼───┐ ┌─▼───┐ ┌─▼─────────────┐                           │
│  │pkt_to_stream ││  │p2s ││ │p2s ││ │pkt_to_stream  │                           │
│  │_hidden[0]    ││  │[1] ││ │[2] ││ │_hidden[3]     │                           │
│  └─────────┬────┘│  └─┬──┘│ └─┬──┘│ └─┬─────────────┘                           │
│            │     │    │   │   │   │   │                                         │
│  ┌─────────▼────┐│  ┌─▼───▼┐ ┌▼───▼┐ ┌▼─────────────┐                           │
│  │   dense2[0]  ││  │d2[1]││ │d2[2]││ │   dense2[3]  │                           │
│  │  (128×128)   ││  │     ││ │     ││ │  (128×128)   │                           │
│  │   DSPLib     ││  │     ││ │     ││ │   DSPLib     │                           │
│  │    +RTP      ││  │ +RTP││ │+RTP ││ │    +RTP      │                           │
│  └─────────┬────┘│  └─┬───┘│ └┬────┘│ └┬─────────────┘                           │
│            │     │    │    │  │     │  │                                         │
│            └─────┼────┼────┼──┘     │  │                                         │
│                  │    │    │        │  │                                         │
│  ┌─────────────────────▼────▼────────▼──▼─────────────┐                         │
│  │              roll_concat kernel                    │                         │
│  │     (produces 6 cyclic shifts: 6×128=768)         │                         │
│  └─────────────────────┬───────────────────────────────┘                         │
│                        │                                                         │
│  ┌─────────────────────▼───────────────────────────────┐                         │
│  │                 output_data                         │                         │
│  │                   (PLIO)                            │                         │
│  │               768 float values                      │                         │
│  └─────────────────────────────────────────────────────┘                         │
└─────────────────────────────────────────────────────────────────────────────────┘
```

## Data Flow Walkthrough

1. **Input embedding**: `input_data` PLIO feeds an 8-element float vector into
   `stream_to_packet_kernel`, which tags the samples with an ADF packet header.
2. **Packet routing**: A single-input `pktsplit` forwards the dense0 packet to
   `packet_to_stream_kernel`, where it becomes a float stream and enters the
   first dense layer (`dense1`).
3. **First dense layer**: 8×128 matrix-vector multiplication produces 128 hidden features
4. **Bias addition**: The DSPLib dense kernel output flows through `k_bias_add`,
   which adds learned bias values loaded via RTP from `data/embed_dense_0_bias.txt`.
5. **Hidden activation**: The biased 128-element vector flows through `k_lrelu0`
   for Leaky ReLU activation (slope=0.1).
6. **Hidden-layer packet hop**: `hidden_stream_to_packet_kernel` consumes the
   Leaky ReLU output, builds 4 packets (one per cascade lane), and marks TLAST
   on the final element.
7. **Cascade fan-out**: `pktsplit<4>` inspects each packet's ID and forwards it
   to the matching `packet_to_stream_hidden_kernel` instance, which converts the
   payload back into a float stream for the downstream dense kernel (`dense2.inB[i]`).
8. **Second dense layer**: 4 parallel 128×128 matrix-vector kernels process their portion
   of the hidden vector, each producing 128-element outputs.
9. **Roll-and-concatenate**: The cascade of dense kernels feeds `roll_concat_kernel`,
   which emits six cyclically shifted copies (6 × 128 = 768 values) onto the
   `output_data` PLIO for downstream processing.

Throughout the flow the packets exist only on the inter-kernel hop where fan-out
is required, allowing the dense compute kernels to stay on standard stream
interfaces.

## Bias Addition Kernel Details

The `bias_add` kernel implements element-wise addition of learned bias values to the
dense layer output before activation. Key implementation details:

- **Interface**: Takes input stream from `dense1.out[0]`, bias values via RTP parameter,
  and outputs biased results to `k_lrelu0.in[0]`
- **RTP Parameter**: Receives 128 float bias values via `bias_dense0_rtp` port using
  array parameter signature `const float (&bias)[HIDDEN_SIZE]`
- **Data Loading**: Bias values loaded from `data/embed_dense_0_bias.txt` in `graph.cpp`
- **Vectorization**: Processes data in 16-element chunks using `v16float` vectors
- **Stream Flow**: `dense1 → k_bias_add → k_lrelu0 → hidden_stream_to_packet`

The kernel enables runtime bias updates without graph recompilation, supporting
dynamic neural network parameter adjustment during execution.

## Files and Build Instructions

The PLIO files consumed by the graph reside in the project-parent
[`../data/`](../../data) directory. They are generated by
[`data/generate_test_data.py`](../data/generate_test_data.py).
