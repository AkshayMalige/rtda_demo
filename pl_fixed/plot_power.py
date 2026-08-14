"""
Power comparison: AIE design vs PL standalone
Two subplots — one per rail type — both designs overlaid on each.
Exact CSV column names shown in subplot titles.
"""

import csv
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from datetime import datetime

# ── file paths ────────────────────────────────────────────────────────────────
AIE_CSV = "aie_float_20sec_3194.csv"
PL_CSV  = "standAlone_20sec_3194evts.csv"
OUT_PNG = "power_comparison.png"

# ── columns to plot ───────────────────────────────────────────────────────────
COL_SOC    = "system-VCC_SOC-Power"   # AIE array + NoC rail
COL_VCCINT = "PLD-VCCINT-Power"       # PL fabric rail

# ── colours ───────────────────────────────────────────────────────────────────
C_AIE = "#D94F2B"   # orange-red  → AIE design
C_PL  = "#2874C8"   # blue        → PL standalone

# ── loader ────────────────────────────────────────────────────────────────────
def load(path, *cols):
    with open(path) as f:
        rows = list(csv.DictReader(f))
    t0 = datetime.fromisoformat(rows[0]["Timestamp"])
    t  = [(datetime.fromisoformat(r["Timestamp"]) - t0).total_seconds() for r in rows]
    return t, {c: [float(r[c]) for r in rows] for c in cols}

aie_t, aie = load(AIE_CSV, COL_SOC, COL_VCCINT)
pl_t,  pl  = load(PL_CSV,  COL_SOC, COL_VCCINT)

# ── figure: 2 rows ────────────────────────────────────────────────────────────
fig, (ax_soc, ax_vcc) = plt.subplots(2, 1, figsize=(11, 7))
fig.suptitle("RTDA Inference Power: AIE Design vs PL Standalone",
             fontsize=13, fontweight="bold")

def add_series(ax, t, vals, color, label):
    mu = sum(vals) / len(vals)
    ax.plot(t, vals, color=color, lw=2.0, label=f"{label}  (mean {mu:.2f} W)", zorder=3)
    ax.axhline(mu, color=color, lw=1.0, ls="--", alpha=0.6)

# ── top subplot: VCC_SOC ─────────────────────────────────────────────────────
add_series(ax_soc, aie_t, aie[COL_SOC], C_AIE, "AIE design")
add_series(ax_soc, pl_t,  pl[COL_SOC],  C_PL,  "PL standalone")

ax_soc.set_title(f'Rail: "{COL_SOC}"  —  AI Engine array + NoC', fontsize=10, loc="left")
ax_soc.set_ylabel("Power  (W)", fontsize=10)
ax_soc.set_xlabel("Time  (s)",  fontsize=10)
ymax = max(max(aie[COL_SOC]), max(pl[COL_SOC]))
ax_soc.set_ylim(0, ymax * 1.25)
ax_soc.set_xlim(0, max(aie_t[-1], pl_t[-1]))
ax_soc.legend(fontsize=9, framealpha=0.9)
ax_soc.grid(True, alpha=0.3)
ax_soc.yaxis.set_minor_locator(ticker.MultipleLocator(0.25))
ax_soc.grid(True, which="minor", alpha=0.12)

# ── bottom subplot: VCCINT ───────────────────────────────────────────────────
add_series(ax_vcc, aie_t, aie[COL_VCCINT], C_AIE, "AIE design")
add_series(ax_vcc, pl_t,  pl[COL_VCCINT],  C_PL,  "PL standalone")

# annotate the spike
spike_t   = aie_t[aie[COL_VCCINT].index(max(aie[COL_VCCINT]))]
spike_val = max(aie[COL_VCCINT])
ax_vcc.annotate(f"spike {spike_val:.1f} W",
                xy=(spike_t, spike_val),
                xytext=(spike_t + 1.2, spike_val - 0.8),
                arrowprops=dict(arrowstyle="->", color=C_AIE, lw=1.2),
                fontsize=8.5, color=C_AIE)

ax_vcc.set_title(f'Rail: "{COL_VCCINT}"  —  PL fabric (CLBs, DSPs, BRAMs)', fontsize=10, loc="left")
ax_vcc.set_ylabel("Power  (W)", fontsize=10)
ax_vcc.set_xlabel("Time  (s)",  fontsize=10)
ymax = max(max(aie[COL_VCCINT]), max(pl[COL_VCCINT]))
ax_vcc.set_ylim(0, ymax * 1.15)
ax_vcc.set_xlim(0, max(aie_t[-1], pl_t[-1]))
ax_vcc.legend(fontsize=9, framealpha=0.9)
ax_vcc.grid(True, alpha=0.3)
ax_vcc.yaxis.set_minor_locator(ticker.MultipleLocator(0.5))
ax_vcc.grid(True, which="minor", alpha=0.12)

plt.tight_layout()
plt.savefig(OUT_PNG, dpi=150, bbox_inches="tight")
print(f"Saved: {OUT_PNG}")

# ── console summary ───────────────────────────────────────────────────────────
print()
print(f"{'Design':<16} {'Column':<30} {'Min':>7} {'Mean':>7} {'Max':>7}  W")
print("-" * 68)
for label, vals, col in [
    ("AIE design",    aie[COL_SOC],    COL_SOC),
    ("PL standalone", pl[COL_SOC],     COL_SOC),
    ("AIE design",    aie[COL_VCCINT], COL_VCCINT),
    ("PL standalone", pl[COL_VCCINT],  COL_VCCINT),
]:
    mu = sum(vals) / len(vals)
    print(f"{label:<16} {col:<30} {min(vals):>7.3f} {mu:>7.3f} {max(vals):>7.3f}")
