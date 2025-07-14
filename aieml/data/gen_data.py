#!/usr/bin/env python3
import numpy as np

# --- CONFIGURATION ---
INPUT_SIZE    = 6
HIDDEN_SIZE   = 128
OUTPUT_SIZE   = 128
SEED          = 42

INPUT_FILE    = "inputs.txt"
WEIGHTS_FILE  = "weights.txt"
OUTPUT_FILE   = "reference_outputs.txt"

# --- GENERATE DUMMY DATA ---
rng    = np.random.default_rng(SEED)
inputs = rng.random(INPUT_SIZE, dtype=np.float32)
W1     = rng.standard_normal((INPUT_SIZE, HIDDEN_SIZE), dtype=np.float32)
W2     = rng.standard_normal((HIDDEN_SIZE, OUTPUT_SIZE), dtype=np.float32)

# --- FORWARD PASS ---
hidden            = inputs @ W1         # shape (128,)
reference_outputs = hidden @ W2         # shape (128,)

# --- WRITE INPUTS ---
with open(INPUT_FILE, "w") as f:
    # one float per line
    for x in inputs:
        f.write(f"{x:.6e}\n")

# --- WRITE WEIGHTS ---
with open(WEIGHTS_FILE, "w") as f:
    f.write("# W1 ({} x {})\n".format(INPUT_SIZE, HIDDEN_SIZE))
    for row in W1:
        f.write(" ".join(f"{w:.6e}" for w in row) + "\n")
    f.write("\n# W2 ({} x {})\n".format(HIDDEN_SIZE, OUTPUT_SIZE))
    for row in W2:
        f.write(" ".join(f"{w:.6e}" for w in row) + "\n")

# --- WRITE REFERENCE OUTPUTS ---
with open(OUTPUT_FILE, "w") as f:
    for y in reference_outputs:
        f.write(f"{y:.6e}\n")

print(f"Written {INPUT_FILE}, {WEIGHTS_FILE}, and {OUTPUT_FILE}")
