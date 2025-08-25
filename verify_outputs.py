#!/usr/bin/env python3
import sys, numpy as np

if len(sys.argv) != 3:
    print("Usage: verify_outputs.py <expected> <actual>")
    sys.exit(1)

expected = np.loadtxt(sys.argv[1])
actual = np.loadtxt(sys.argv[2])

if expected.size != actual.size:
    print(f"ERROR: Size mismatch (expected {expected.size}, got {actual.size})")
    sys.exit(1)

# Order-tolerant comparison
if not np.allclose(np.sort(expected), np.sort(actual), rtol=1e-5, atol=1e-8):
    print("ERROR: Output mismatch")
    sys.exit(1)

print("✅ Output verification passed")
