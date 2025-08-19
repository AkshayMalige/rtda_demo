#!/usr/bin/env python3
"""Split a bias, input vector, or weight matrix along the K dimension
into contiguous blocks for AIE cascade inputs.

Works with:
  - 1D bias / input vectors (length K)
  - 2D weight matrices (shape M x K)

Usage examples:

Bias / input vector (K=128, cascade=2 → 2 parts of length 64):
    ./split_cascade_fixed.py bias_dense2.txt \
        --cascade-len 2 \
        --dtype float32 \
        --out-dir split_bias

Weight matrix (flat file, specify shape):
    ./split_cascade_fixed.py weights_dense2.txt \
        --cascade-len 2 \
        --dtype float32 \
        --shape 128x128 \
        --out-dir split_w

Weight matrix (already formatted with whitespace-separated rows):
    ./split_cascade_fixed.py weights_dense2.txt \
        --cascade-len 2 \
        --dtype float32 \
        --out-dir split_w
"""

import argparse
from pathlib import Path
import numpy as np
from typing import Optional

DTYPE_MAP = {
    "int8": np.int8,
    "int16": np.int16,
    "float16": np.float16,
    "float32": np.float32,
}
FMT_MAP = {
    "int8": "%d",
    "int16": "%d",
    "float16": "%.6f",
    "float32": "%.6f",
}

def split_file(file_path: Path,
               cascade_len: int,
               dtype: str,
               out_dir: Path,
               prefix: Optional[str] = None,
               shape: Optional[str] = None):
    """Split file into cascade_len parts along the last dimension (K)."""
    data = np.loadtxt(file_path, dtype=DTYPE_MAP[dtype])

    if shape:
        m_str, k_str = shape.lower().split("x")
        M, K = int(m_str), int(k_str)
        data = data.reshape(M, K)

    if data.ndim == 1:
        # 1D bias / input vector
        total_elems = data.size
        if total_elems % cascade_len != 0:
            raise ValueError("Length must be divisible by cascade_len")
        split_size = total_elems // cascade_len
        parts = [data[i * split_size:(i + 1) * split_size] for i in range(cascade_len)]
    elif data.ndim == 2:
        # 2D weight matrix M x K → split along K
        M, K = data.shape
        if K % cascade_len != 0:
            raise ValueError("K must be divisible by cascade_len")
        split_k = K // cascade_len
        parts = [data[:, i * split_k:(i + 1) * split_k] for i in range(cascade_len)]
    else:
        raise ValueError("Only 1D or 2D arrays are supported")

    if prefix is None:
        prefix = file_path.stem

    out_dir.mkdir(parents=True, exist_ok=True)

    for i, part in enumerate(parts):
        out_path = out_dir / f"{prefix}_part{i}.txt"
        np.savetxt(out_path, part, fmt=FMT_MAP[dtype])

    print(f"Saved {cascade_len} parts to {out_dir}/ with prefix '{prefix}_part*.txt'")

def main():
    parser = argparse.ArgumentParser(description="Split vector/matrix for AIE cascade along K dimension")
    parser.add_argument("file", type=Path, help="Path to input data/weights/bias file")
    parser.add_argument("--cascade-len", type=int, required=True, help="Cascade length")
    parser.add_argument("--dtype", type=str, default="float32", choices=DTYPE_MAP.keys(),
                        help="Data type stored in the file")
    parser.add_argument("--out-dir", type=Path, default=Path("."), help="Directory for output files")
    parser.add_argument("--prefix", type=str, default=None, help="Prefix for output files")
    parser.add_argument("--shape", type=str, default=None,
                        help="Optional shape MxK if file is flat (e.g., '128x128')")
    args = parser.parse_args()

    split_file(args.file, args.cascade_len, args.dtype, args.out_dir, args.prefix, args.shape)

if __name__ == "__main__":
    main()
