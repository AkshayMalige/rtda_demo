#!/usr/bin/env python3
"""Split a flat text file into multiple parts for AIE cascade inputs.

The script can be used to split weights, activations or bias vectors when a
cascade of length >1 is used in the AIE graph.  It reads a whitespace separated
text file, divides it evenly according to the cascade length and writes the
parts back out as separate files.
"""

import argparse
from pathlib import Path
import numpy as np

DTYPE_MAP = {
    "int8":   np.int8,
    "int16":  np.int16,
    "float16": np.float16,
    "float32": np.float32,
}
FMT_MAP = {
    "int8":   "%d",
    "int16":  "%d",
    "float16": "%.6f",
    "float32": "%.6f",
}

def split_file(file_path: Path, cascade_len: int, dtype: str, out_dir: Path, prefix: str | None = None):
    """Split the contents of *file_path* into *cascade_len* pieces.

    Args:
        file_path: Path to the text file containing numeric data.
        cascade_len: Number of pieces to split into. Size must divide the
            number of values in the file.
        dtype: Data type of the values (key of DTYPE_MAP).
        out_dir: Directory in which output files are written.
        prefix: Optional prefix for output filenames. Defaults to the stem of
            *file_path*.
    """
    data = np.loadtxt(file_path, dtype=DTYPE_MAP[dtype])
    total_elems = data.size
    if total_elems % cascade_len != 0:
        raise ValueError("Data length must be divisible by cascade_len")
    split_size = total_elems // cascade_len

    if prefix is None:
        prefix = file_path.stem

    out_dir.mkdir(parents=True, exist_ok=True)

    for i in range(cascade_len):
        part = data[i * split_size : (i + 1) * split_size]
        out_path = out_dir / f"{prefix}_part{i}.txt"
        np.savetxt(out_path, part, fmt=FMT_MAP[dtype])

    print(f"Saved {cascade_len} parts to {out_dir}/ with prefix '{prefix}_part*.txt'")


def main():
    parser = argparse.ArgumentParser(description="Split data file for AIE cascade")
    parser.add_argument("file", type=Path, help="Path to input data/weights/bias file")
    parser.add_argument("--cascade-len", type=int, required=True, help="Cascade length")
    parser.add_argument("--dtype", type=str, default="float32", choices=DTYPE_MAP.keys(),
                        help="Data type stored in the file")
    parser.add_argument("--out-dir", type=Path, default=Path("."), help="Directory for output files")
    parser.add_argument("--prefix", type=str, default=None, help="Prefix for output files")
    args = parser.parse_args()

    split_file(args.file, args.cascade_len, args.dtype, args.out_dir, args.prefix)


if __name__ == "__main__":
    main()
