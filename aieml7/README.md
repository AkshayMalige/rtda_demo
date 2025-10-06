# AI Engine-ML Graph: Four-Layer Neural Network with Roll-Concat

This directory implements a four-layer neural network graph featuring a roll-concat operation and tiled buffering for efficient memory access across a large cascaded matrix multiply.  The project has recently been refactored to stage all dense-layer weights through AI Engine shared buffers before fanning them out into the per-leg local windows that the DSPLib matrix-vector multiply blocks expect.

## Architecture

### Pipeline
1. **`roll_concat`** – Repeats the 128-element input vector six times to create 768 elements and writes the result into a regular buffer that is tiled across the 12 cascaded legs of the first dense layer.
2. **Weight preload** – Three PLIOs (`preload_w768_lo`, `preload_w768_hi`, `preload_w128_all`) stream weight banks into AI Engine shared buffers.  Dedicated copy kernels (`copy768_lo`, `copy768_hi`, `copy128_all`) then fan out the staged data into six local windows per bank, matching the number of cascade legs or matrix partitions.
3. **`dense0`** (768×128, cascade length = 12) – Large matrix-vector multiply that reads its weights from the distributed local windows and its activation input from the shared roll-concat buffer.
4. **`bias_add` → `leaky_relu` → `window_split_128_to_64x2`** – Post-processing for layer 0.
5. **`dense1`** (128×128, cascade length = 2) – Second dense layer, using weights sourced from the `copy128_all` fan-out.
6. **`bias_add` → `leaky_relu` → `window_split_128_to_64x2`** – Post-processing for layer 1.
7. **`dense2`** (128×128, cascade length = 2) – Third dense layer.
8. **`bias_add` → `leaky_relu` → `window_split_128_to_64x2`** – Post-processing for layer 2.
9. **`dense3`** (128×128, cascade length = 2) – Fourth dense layer.
10. **`bias_add` → `leaky_relu`** – Final activation producing the 128-element output.

### Key Features
- **Tiled roll-concat buffer**: The 768-element activation is written once then tiled across the 12 cascade kernels in `dense0`.
- **Weight staging via copy kernels**: All dense-layer weights are streamed in through PLIOs, stored in shared buffers, and redistributed with lightweight copy kernels that keep port pressure low while feeding the DSPLib blocks.
- **Four dense layers with leaky-ReLU activations**: The network transforms the 768-element rolled input down to 128 outputs.
- **Runtime bias updates**: Biases for each dense layer are provided through RTP connections so they can be updated without recompiling the graph.

### Layer Configurations
- **Layer 0**: 768×128 dense layer with 12-way cascade (TP_CASC_LEN_LAYER3=12)
- **Layers 1-3**: 128×128 dense layers with 2-way cascade (TP_CASC_LEN_LAYER2=2)
- **Activation**: Leaky ReLU with slope 0.1
- **Tiling**: `ROLL_CONCAT_TILE_SPAN = 768 / 12 = 64` elements per cascade tile

## Directory Layout

```
├── graph.cpp                       # Instantiates NeuralNetworkGraph
├── graph.h                         # Graph definition with buffered fan-out and RTP connections
├── leaky_relu.cpp/.h               # Leaky ReLU activation kernel
├── bias_add.cpp/.h                 # Bias addition kernel
├── window_split_128_to_64x2.cpp/.h # Window splitter for cascade inputs
├── roll_concat.cpp/.h              # Roll-concat kernel (128→768)
├── copy_to_locals_6.cpp/.h         # Weight fan-out kernels for preload buffers
├── window_split_768_to_*.h         # Additional window split utilities (optional experiments)
├── aie.cfg                         # AIE compiler configuration
└── Makefile                        # Build targets
```

## Build & Simulation

### Compile AI Engine Graph
```bash
cd aieml7
make graph TARGET=hw       # or TARGET=hw_emu
```
This invokes `v++` to produce `Work/libadf.a`.  The command requires a Vitis installation in the environment; if `v++` is unavailable you will see `command not found`.

### Run AI Engine Simulation
```bash
make sim
```

## Data Flow

### Input/Output PLIO
- **Input**: `layer0_in` reads from `../data/tmp_inp768.txt` (128 floats)
- **Output**: `layer_out` writes to `../data/subsolver_0_dense_3_output_aie.txt` (128 floats)

### Runtime Parameters (RTP)
Only the biases are updated at run time via RTP connections in the current configuration:
- `bias_dense0_rtp`: 128-element bias for dense0
- `bias_dense1_rtp`: 128-element bias for dense1
- `bias_dense2_rtp`: 128-element bias for dense2
- `bias_dense3_rtp`: 128-element bias for dense3

The dense-layer weight matrices are streamed through the preload PLIOs and staged in shared buffers before execution begins.

### Processing Pipeline
```
input(128) → roll_concat(128→768) → buffer[768] →
dense0(768×128, casc=12) → bias → leaky_relu → split →
dense1(128×128, casc=2) → bias → leaky_relu → split →
dense2(128×128, casc=2) → bias → leaky_relu → split →
dense3(128×128, casc=2) → bias → leaky_relu → output(128)
```

## Roll-Concat Buffer Tiling

The roll-concat output uses a standard buffer with tiled access:
- **Buffer Size**: 768 floats
- **Number of Consumers**: 12 (cascade kernels in dense0)
- **Tile Size**: 64 floats per consumer
- **Write Access**: Single writer (roll_concat kernel) writes entire 768-element buffer
- **Read Access**: Each of 12 cascade kernels reads its own 64-element tile with stride offset

## Notes
- Test data is generated by `../data/generate_test_data.py`
- This architecture demonstrates efficient buffer usage for large cascaded operations
- Kernel placement can be manually specified via `location<kernel>` directives in graph.h
- This graph serves as the "solver" component tested independently before integration into aieml9
