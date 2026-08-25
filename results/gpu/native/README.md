# results/gpu/native/

The GPU baseline's scan output. Written by `gpu/scan_gpu.py` **on the GPU
server**, carried back, and filed with:

```bash
make collect_scan FLOW=gpu FROM=<dir>
```

Read by `analysis/rtda_scan.ipynb` §8.

| file | content |
|---|---|
| `scan.csv` | the same 28-column schema every other scan writes |
| `scan_meta.txt` | `key=value`: GPU model and index, driver, CUDA, torch, SM clock vs max, power limit, TF32 flags, variants, modes, stimulus sha256 |

`native` rather than `hw`/`hw_emu` because there is no bitstream and no target
axis. `impl=gpu`, `variant=fp32|bf16|tf32`, `mode=single|fresh|graph`.

**Only `mode=single` is comparable** to the other implementations — one
transfer, one forward, one transfer back for the whole run. `fresh` and `graph`
are diagnostics, the same way `pl_fixed`'s `reuse` and `tpc` rows are.

Two things are different here from every other flow:

- **`us_h2d` and `us_d2h` are real.** A GPU is a card on PCIe, like the VEK280.
  Every other non-PL row in this repo writes 0.0 there.
- **`variant=tf32` is not a design choice.** It is float32 storage with
  ~10-bit-mantissa matmuls — what "fp32" silently becomes on this hardware if
  the torch backend flags are left at their defaults. It is measured so that is
  visible rather than surprising.

Rows produced by `scan_gpu.py --allow-cpu` are stamped `SMOKE TEST ON HOST CPU`
in `notes`, and the notebook refuses them. That flag exists to exercise the
harness on a machine with no card; it never produces a usable number.

Everything here except this README is generated and gitignored.
