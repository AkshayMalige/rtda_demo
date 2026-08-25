# results/cpu/native/

The CPU baseline's scan output. Written by `make -C cpu scan_host`
(`cpu/scan_cpu.py`), read by `analysis/rtda_scan.ipynb` §9.

| file | content |
|---|---|
| `scan.csv` | the same 28-column schema both XRT scan hosts emit |
| `scan_meta.txt` | `key=value`: dtype, warmup, chunk size, thread list, CPU model, numpy/BLAS build, git hash |

`native` rather than `hw`/`hw_emu` because there is no device: this flow has no
target axis. `impl=cpu`, `mode=single`, and the thread count rides in
`variant` (`fp32_t1` … `fp32_t32`).

Everything here is generated and gitignored (`.gitignore: results/**`). See
`cpu/README.md` for what the numbers include and — more importantly — what
they do not.
