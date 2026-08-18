# Frequency sweep results

Written by `../sweep_freq.py`. Everything here except this file is generated
and gitignored.

- `freq_report.md` — the readable result
- `runs.csv` — one row per frequency, with a `columns=` header
- `state.json` — resume state; delete it to start over
- `f<MHz>/` — that point's archived reports (timing summary, utilization, logs)
  and `point.json`

The reports are copied here **before** the ~3.5 GB build tree is deleted. That
is deliberate: `pl_fixed/reference_may2026/` exists because `make clean` once
removed the only copy of a shipped build's reports.
