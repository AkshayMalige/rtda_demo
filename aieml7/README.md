# AI Engine-ML Graph: Four-Layer Neural Network with Roll-Concat Splitter

This directory implements a four-layer neural network graph that expands a 128-element activation to 768 elements, stages it in an AI Engine IO buffer, and distributes the data to a 12-way cascaded dense layer through a dedicated window-splitting kernel.  All dense-layer weights stream in via PLIOs and are buffered locally before being consumed by the DSPLib matrix-vector multiply (MVM) primitives that form each dense layer.

## Architecture

### Pipeline
1. **`roll_concat`** – Repeats the 128-element input vector six times to create 768 elements and writes the result into an IO buffer.
2. **`window_split_768_to_64x12`** – Consumes the 768-sample window and emits twelve 64-element windows, one per cascade leg of the first dense layer.
3. **`dense0`** (768×128, cascade length = 12) – Large matrix-vector multiply that reads its weights from per-leg buffers and its activation input from the splitter kernel.
4. **`bias_add` → `leaky_relu` → `window_split_128_to_64x2`** – Post-processing for layer 0.
5. **`dense1`** (128×128, cascade length = 2) – Second dense layer, using weights streamed from PLIO-staged buffers.
6. **`bias_add` → `leaky_relu` → `window_split_128_to_64x2`** – Post-processing for layer 1.
7. **`dense2`** (128×128, cascade length = 2) – Third dense layer.
8. **`bias_add` → `leaky_relu` → `window_split_128_to_64x2`** – Post-processing for layer 2.
9. **`dense3`** (128×128, cascade length = 2) – Fourth dense layer.
10. **`bias_add` → `leaky_relu`** – Final activation producing the 128-element output.

### Key Features
- **Roll-concat splitter kernel**: The 768-element activation is written once, then `window_split_768_to_64x12` slices it into twelve contiguous 64-element windows for the cascaded dense layer.
- **Weight staging via IO buffers**: All dense-layer weights are streamed in through PLIOs and stored in per-leg IO buffers before feeding the DSPLib blocks.
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
├── graph.h                         # Graph definition with roll-concat splitter and RTP connections
├── leaky_relu.cpp/.h               # Leaky ReLU activation kernel
├── bias_add.cpp/.h                 # Bias addition kernel
├── window_split_128_to_64x2.cpp/.h # Window splitter for cascade inputs
├── roll_concat.cpp/.h              # Roll-concat kernel (128→768)
├── copy_to_locals_6.cpp/.h         # Legacy weight fan-out kernels (not used in current graph)
├── window_split_768_to_64x12.cpp/.h# Twelve-way roll-concat splitter kernel
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

The dense-layer weight matrices are streamed through the preload PLIOs and staged in IO buffers before execution begins.

### Processing Pipeline
```
input(128) → roll_concat(128→768) → IO buffer[768] → window_split_768_to_64x12 →
dense0(768×128, casc=12) → bias → leaky_relu → window_split_128_to_64x2 →
dense1(128×128, casc=2) → bias → leaky_relu → split →
dense2(128×128, casc=2) → bias → leaky_relu → split →
dense3(128×128, casc=2) → bias → leaky_relu → output(128)
```

## Roll-Concat IO Buffer and Splitter

The roll-concat output is staged once, then broadcast via a splitter kernel:
- **Buffer Size**: 768 floats stored in an IO buffer
- **Splitter**: `window_split_768_to_64x12` reads the full window and writes twelve 64-float windows
- **Consumers**: Each of the 12 cascade kernels in `dense0` receives a dedicated 64-element window from the splitter

## Notes
- Test data is generated by `../data/generate_test_data.py`
- This architecture demonstrates a dedicated splitter to feed large cascaded operations without shared-buffer tiling
- Kernel placement can be manually specified via `location<kernel>` directives in graph.h
- This graph serves as the "solver" component tested independently before integration into aieml9
