# How fast can pl_fixed actually run?

The design ships at **180 MHz** (`KERNEL_FREQ` in `../pl_fixed/Makefile`) and is
fabric-bound: **94,793 ns/track** on the board, which RTL co-simulation matches to
0.002%. Raising the clock is the lever on that number. The shipped build closes at
**WNS 0.000 ns** with the kernel at **78.47% LUT**, and the sweep starts from it.

## What the first sweep found

Run 2026-08-18/19, when the design still shipped at 150 MHz. Every point re-ran HLS
at its own period and then linked at it.

| f (MHz) | verdict | WNS (ns) | kernel LUT |
|---:|---|---:|---:|
| 160 | PASS | 0.000 | 76.80% |
| 170 | no readable timing report | — | 78.73% |
| 180 | PASS | 0.000 | 79.10% |
| 190 | PASS | 0.000 | 79.47% |
| 200 | interrupted in synthesis | — | — |

That is what moved the default to 180 MHz (`beb3ffe`). **Those points were built
before the kernel gained its event loop** (`d257669`, one kernel call for every
event), so they describe a different kernel from the one that ships now. Its
180 MHz build reads 78.47% LUT rather than 79.10%, for example. The old build
trees carry no source stamp, so the next sweep rebuilds them instead of recovering
them (see *Isolation*). `results/freq_report.md` from that run was last written at
170 MHz and does not list the later points; the per-point `results/f<MHz>/point.json`
files do.

## The thing nobody had noticed

There are **two clocks**, and they were never connected:

| knob | where | reaches |
|---|---|---|
| `KERNEL_FREQ` | `../pl_fixed/Makefile:41` | `v++ --link --clock.defaultFreqHz` |
| `create_clock -period` | `../pl_fixed/pl/rtda_split_project.tcl:94` | Vitis HLS scheduling |

The second was hardcoded at 6.667 ns until 2026-08-18. So raising `KERNEL_FREQ`
alone just re-timed RTL that HLS had scheduled for 150 MHz — and the 150 MHz build
closed at **WNS +0.050 ns**, 0.75% of the period, leaving nothing to re-time into.

The TCL now reads `RTDA_HLS_PERIOD` (default 5.5556 ns, i.e. 180 MHz), and
`pl_fixed/Makefile` derives it from `KERNEL_FREQ`, so a normal build keeps the two
together. This flow sets `RTDA_HLS_PERIOD` per point.

**That means raising the clock costs LUT** — HLS pipelines harder to hold the
tighter period. The shipped design is at 78.47%, and the 2026-08-14 build failed
to route at 98.87% with congestion level 6. This may well find the design stops
**fitting** before it stops **closing**. `make mock_cliff` rehearses that case.

**Where the ladder starts, and what `ns/track` means.** The grid starts at the
shipped `KERNEL_FREQ`, whose reports are on disk and seed the first point. The
`ns/track` column is a projection, `csynth TrackLoop cycles / f`, with the cycle
count read from *each point's own* csynth report (it barely moves: 17,062 at
160 MHz, 17,077 at 180 and 190). At 180 MHz RTL co-simulation measures 17,039
cycles and the board agrees with cosim, so the projection is a close upper bound —
but a faster point is measured only once it has run on the board.

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

- **`make test`** runs the parsers against the shipped 180 MHz build's reports,
  `../pl_fixed/_x/ap16_3_hw/reports/`. It must reproduce WNS 0.000 ns, 180.000 MHz,
  LUT 407,628 / 78.47%, DSP 289 / 22.03% and the kernel clock
  `clkout1_primitive_1` — numbers copied from the report text, not from the parser.
  It reads the same reports in both layouts (`_x/<VARIANT>_<TARGET>/` since
  2026-08-20, `_x/` before). Then 6 deliberately broken reports (truncated, empty,
  missing, binary garbage, unrouted, OOM) must each give a classified verdict and
  never a traceback.
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
deliberately **not** copied: a copied `.xo` was scheduled for whatever
`KERNEL_FREQ` built it.

Each point directory is stamped with `SOURCES.sha256`, a hash of everything it was
built from. A finished tree is recovered after an interruption **only if its stamp
matches the current sources**; otherwise it is moved aside to
`f<MHz>.stale-<time>/` (never deleted) and rebuilt from clean. Before stamping, a
tree from an older kernel would have been recovered as if it were current, and a
point rebuilt into an old tree could have been judged by the previous build's
reports.

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
