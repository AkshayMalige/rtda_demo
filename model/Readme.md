# Data generation for model

This directory contains utilities for exporting values from the reduced-order detector model used by the AIE demo.

## Dump model values

Run the provided script to extract real weights, biases and reference activations from the ONNX submodules. The files are written into the repository's `data/` directory and padded/split to match the AIE graph configuration.

```bash
python dump_vals.py --data-root <path_to_dataset> --submodule-dir <path_to_submodule_onnx>
```

By default the script dumps inputs, layer outputs, transposed/split weights and biases for the first (`dense8x128`) and second (`dense128x128`) dense layers. Adjust options via `-h` for different locations or precisions.
