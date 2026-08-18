# How fast can pl_fixed actually run?

The design ships at **150 MHz** and is fabric-bound. Raising the clock is the
one untried lever on its 114,538 ns/track.

## The thing nobody had noticed

There are **two clocks**, and they were never connected:

| knob | where | reaches |
|---|---|---|
| `KERNEL_FREQ` | `../pl_fixed/Makefile:41` | `v++ --link --clock.defaultFreqHz` |
| `create_clock -period` | `../pl_fixed/pl/rtda_split_project.tcl:94` | Vitis HLS scheduling |

The second was hardcoded at 6.667 ns. So raising `KERNEL_FREQ` alone just
re-times RTL that HLS scheduled for 150 MHz — and the shipped build closes at
**WNS +0.050 ns**, 0.75% of the period. There is nothing to re-time into.

This flow drives both, through `RTDA_HLS_PERIOD` (added to the TCL in the same
`env_or` idiom it already used for five other settings; the default is 6.667,
so a build that does not set it is unchanged).

**That means raising the clock costs LUT** — HLS pipelines harder to hold the
tighter period. The shipped design is at 75.95%, and the 2026-08-14 build failed
to route at 98.87% with congestion level 6. This may well find the design stops
**fitting** before it stops **closing**. `make mock_cliff` rehearses that case.

## How it searches

A ladder: try each frequency in turn, lowest first, and **stop at the first
failure**. csynth (~2 h) runs first; the link (~2 h) only if csynth succeeded, so
a frequency HLS cannot schedule is rejected at half price. Serial, one build at
a time. The result is an unbroken chain of PASSes up to the first FAIL.

## Running it

```bash
source ../set_envs.sh

make test        # parsers vs the REAL reports on disk        ~2 s
make dryrun      # every command and path, runs nothing       ~1 s
make mock        # the whole ladder against fake tools        ~3 s
make smoke YES=1 # does real HLS accept the period?           ~2 min

make sweep YES=1 # the real run.  ~4 h per step, serial
```

`make sweep` without `YES=1` stops after preflight. Real builds only happen when
asked for — a mistyped command must not start a four-hour csynth.

## Why you can trust it before spending a build

- **`make test`** runs the parsers against `../pl_fixed/_x/reports/`, the shipped
  150 MHz build. It must reproduce WNS +0.050 ns, 150.000 MHz, LUT 394,548 /
  75.95%, DSP 289 / 22.03% — the numbers already in `../README.md`, read by a
  human from those same files. Then 6 deliberately broken reports (truncated,
  empty, missing, binary garbage, unrouted, OOM) must each give a classified
  verdict and never a traceback.
- **`make mock`** puts fake `vitis_hls`/`v++` on PATH that **rewrite the real
  reports** rather than inventing files, so the same parsers see the same shapes.
  It runs the entire ladder, harvest, prune and resume in seconds, and asserts
  that nothing under `../pl_fixed/` changed (6798 files, size+mtime).

## Isolation

Every Vivado and HLS output path in `pl_fixed` is CWD-relative and unstamped —
`_x/`, `pl/ip/rtda_split.xo`, `rtda_split_hls/` (which does `open_project -reset`,
i.e. deletes the tree), `.Xil/`, `.ipcache/`, the logs. So each frequency gets its
own copy of the sources under `$ROOT` (default
`/home/synthara/VersalPrjs/LDRD/freq_sweep_work`), outside the repo. `pl/ip/` is
deliberately **not** copied: a copied `.xo` is a 150 MHz `.xo`.

~3.5 GB per point while building, pruned to ~40 MB of reports afterwards.
`--package` is never run — you only need an SD image for the winner.

## Results

`results/freq_report.md`, `results/runs.csv`, and `results/f<MHz>/` holding that
point's reports. Reports are copied out **before** the build tree is deleted:
`RESOURCES.md` exists partly because `make clean` once ate the only copy of a
shipped build's reports.

## What it does not tell you

- Whether the faster bitstream is **correct on the board**. Same RTL semantics,
  but only a real run against the golden proves it.
- Power, which rises with frequency.
- Seed variance. Place and route is heuristic, so a single FAIL is evidence, not
  proof. Re-run the boundary point if the answer matters.
