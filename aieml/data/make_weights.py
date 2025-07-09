#!/usr/bin/env python3
"""
make_weights_single.py
----------------------
Generate a K × M weight matrix and write it to <outfile>.
Arguments
    1) K       : rows    (int > 0)
    2) M       : columns (int > 0)
    3) dtype   : int8 | int16 | float16 | float32
    4) outfile : (optional) path for the weights file
                 default = data/weights.txt
Example
    python make_weights_single.py 128 128 float32         # default name
    python make_weights_single.py 64 256 int16 myW.dat    # custom file
"""

import sys
from pathlib import Path
import numpy as np

# ── Parse CLI arguments ────────────────────────────────────────────────
if not (4 <= len(sys.argv) <= 5):
    sys.exit(__doc__)

K          = int(sys.argv[1])
M          = int(sys.argv[2])
dtype_str  = sys.argv[3].lower()
out_path   = Path(sys.argv[4] if len(sys.argv) == 5 else "data/weights.txt")

dtype_map = {
    "int8":    np.int8,
    "int16":   np.int16,
    "float16": np.float16,
    "float32": np.float32,
}
if dtype_str not in dtype_map:
    sys.exit(f"Unsupported dtype '{dtype_str}'. "
             f"Choose from {', '.join(dtype_map)}")

dtype = dtype_map[dtype_str]

# ── Create fake data ───────────────────────────────────────────────────
rng = np.random.default_rng(0)
if np.issubdtype(dtype, np.integer):
    info = np.iinfo(dtype)
    weights = rng.integers(info.min // 2, info.max // 2, size=(K, M), dtype=dtype)
else:
    weights = rng.uniform(-1.0, 1.0, size=(K, M)).astype(dtype)

# ── Ensure output directory exists ─────────────────────────────────────
out_path.parent.mkdir(parents=True, exist_ok=True)

# ── Dump to text (8 values / line) ─────────────────────────────────────
with out_path.open("w") as f:
    flat = weights.ravel()
    for i in range(0, flat.size, 8):
        f.write(" ".join(str(v) for v in flat[i : i + 8]) + "\n")

print(f"Wrote {K}×{M} {dtype_str} weights to {out_path}")