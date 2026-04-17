#!/usr/bin/env python3
"""
Reads all .txt files from data_fp32/, counts lines in each,
and writes a file with the same name to data/ containing the
same number of random int16 values in range [0, 6]. not tested yet.
"""

import random
from pathlib import Path

SRC_DIR = Path(__file__).parent.parent / "data_fp32"
DST_DIR = Path(__file__).parent

src_files = sorted(SRC_DIR.glob("*.txt"))
if not src_files:
    raise SystemExit(f"No .txt files found in {SRC_DIR}")

for src in src_files:
    lines = src.read_text().splitlines()
    n = len(lines)
    dst = DST_DIR / src.name
    with dst.open("w") as f:
        for _ in range(n):
            f.write(f"{random.randint(0, 6)}\n")
    print(f"{src.name}: {n} values -> {dst}")

print(f"\nDone. {len(src_files)} files written to {DST_DIR}")
