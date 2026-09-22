"""Paper figures for the Results section. Every value is quoted from a verified source:
   T = analysis/rtda_timing.ipynb outputs (aiesimulator VCD+profile, RTL cosim), 10 events
   S = results/<impl>/hw/scan.csv, primary rows, median of 5
   P = results/<impl>/hw/power_routed.rpt, Vivado vectorless dynamic power
   H = pl_fixed/rtda_split_hls/solution1/syn/report/*_csynth.rpt (180 MHz)
"""
import sys, numpy as np, matplotlib as mpl
mpl.use('Agg'); import matplotlib.pyplot as plt
from pathlib import Path
OUT = Path(__file__).parent
mpl.rcParams.update({
    'figure.facecolor': 'white', 'axes.facecolor': 'white',
    'savefig.facecolor': 'white', 'savefig.dpi': 200, 'figure.dpi': 110,
    'axes.spines.top': False, 'axes.spines.right': False,
    'axes.edgecolor': '#9aa0a6', 'axes.labelcolor': '#202124',
    'axes.titlesize': 11, 'axes.titleweight': 'bold', 'axes.titlelocation': 'left',
    'axes.labelsize': 9.5, 'xtick.labelsize': 9, 'ytick.labelsize': 9,
    'xtick.color': '#5f6368', 'ytick.color': '#5f6368', 'text.color': '#202124',
    'grid.color': '#dadce0', 'grid.linewidth': 0.6, 'axes.grid': True,
    'axes.axisbelow': True, 'lines.linewidth': 2, 'lines.markersize': 6,
    'legend.frameon': False, 'legend.fontsize': 9,
    'figure.constrained_layout.use': True,
})
C = {'fp32': '#1f77b4', 'bf16': '#d62728', 'pl': '#9467bd'}
MUTED = '#5f6368'

# ---- device-only timing (T) -------------------------------------------------
# PL became a DATAFLOW PIPELINE on 2026-09-22 (fb85eab, 666eba8). Until then it
# ran one track through all fourteen dense layers before starting the next, so
# its latency and its throughput were THE SAME NUMBER (4733.1 us) -- that is why
# they were one constant here. They are now different, and the difference is the
# point: a call pays a pipeline fill once (96.8 us, 17,429 cycles) and then
# retires an update every 286.4 us.
#   cosim, 1 event 68,981 cycles / 10 events 532,949 (T, results/pl_fixed/cosim_ev*)
#   -> interval (532,949-68,981)/9 = 51,552 cyc = 286.4 us; latency 68,981 = 383.2 us
THR  = {'fp32': 7 * 4172e-3, 'bf16': 7 * 1650.1e-3, 'pl': 286.4}      # us per update
LAT  = {'fp32': 113.4, 'bf16': 31.2, 'pl': 383.2}                     # us, idle device
POW  = {'fp32': 21.733, 'bf16': 21.860, 'pl': 13.744}                 # W dynamic (P)
NAME = {'fp32': 'AIE-ML fp32', 'bf16': 'AIE-ML bf16', 'pl': 'PL fixed<16,3>'}

def energy():
    fig, ax = plt.subplots(figsize=(5.6, 3.7))
    t = np.logspace(0.3, 4.4, 200)
    for e_mj in (0.1, 1, 10):                             # P = E / t
        ax.plot(t, e_mj * 1e3 / t, ls=':', lw=1, color='#bdc1c6', zorder=1)
        y = 9.2                                             # label along the bottom, clear of the axis
        x = e_mj * 1e3 / y
        if 5 < x < 2.2e3:
            ax.text(x * 1.12, y, f'{e_mj:g} mJ', fontsize=8, color=MUTED, ha='left', va='center')
    for k in ('bf16', 'fp32', 'pl'):
        e_mj = POW[k] * THR[k] / 1e3
        ax.plot(THR[k], POW[k], 'o' if k != 'pl' else 's', ms=9, color=C[k], zorder=3)
        dy = 7 if k != 'fp32' else -13
        ax.annotate(f'{NAME[k]}\n{e_mj:.2g} mJ per update', (THR[k], POW[k]), xytext=(0, dy),
                    textcoords='offset points', ha='center', va='bottom' if dy > 0 else 'top',
                    fontsize=8.5, color=C[k])
    ax.set_xscale('log'); ax.set_yscale('log')
    ax.set_xlim(4, 2.6e3); ax.set_ylim(8, 45)
    ax.set_yticks([10, 15, 20, 30, 40]); ax.get_yaxis().set_major_formatter(mpl.ticker.ScalarFormatter())
    ax.set_xlabel('time per alignment update (µs)')
    ax.set_ylabel('dynamic power (W)')
    ax.set_title('Energy per alignment update')
    fig.savefig(OUT / 'res_energy.png')

def scaling():
    blocks = np.array([1, 2, 3])
    # AIE latency to the event mean with k solver blocks = E - lag(s2) + lag(s_{k-1})   (T, §2 and §4)
    lat_fp32 = 113.4 - 76.24 + np.array([25.31, 50.83, 76.24])
    lat_bf16 = 31.2 - 16.92 + np.array([5.58, 11.33, 16.92])            # idle array, iteration 0 lags
    # PL, pipelined: adding a solver block adds PIPELINE DEPTH, not interval. The
    # interval is set by the slowest stage -- one 128x128 dense at reuse factor
    # 1024, 1031 cycles/track (H) -- and that does not change when blocks are
    # added, exactly as on the array. So throughput is FLAT and only latency grows.
    # One block's depth, from the per-track intervals in the csynth report (H):
    #   4 dense x 1031 + 1 add 106 + 4 activations x 56 + roll 131 = 4585 cycles
    # = 25.5 us, anchored at 3 blocks on the measured cosim latency 383.2 us (T).
    # (Before pipelining a block cost 4966 cycles/track x 50 tracks = 1.4 ms of
    # BOTH latency and throughput.)
    pl      = LAT['pl'] - (3 - blocks) * 4585 * 5.5556e-3
    thr_pl  = np.full(3, THR['pl'])
    thr_fp32 = np.full(3, THR['fp32']); thr_bf16 = np.full(3, THR['bf16'])
    fig, (a, b) = plt.subplots(1, 2, figsize=(7.2, 3.3), sharey=True)
    for ax, fp, bf, p_, ttl in ((a, lat_fp32, lat_bf16, pl, 'Latency'),
                                (b, thr_fp32, thr_bf16, thr_pl, 'Time per update, steady state')):
        ax.plot(blocks, fp, 'o-', color=C['fp32'], label='AIE-ML fp32')
        ax.plot(blocks, bf, 'o-', color=C['bf16'], label='AIE-ML bf16')
        ax.plot(blocks, p_, 's-', color=C['pl'], label='PL fixed<16,3>')
        ax.set_xticks(blocks); ax.set_xlim(0.7, 3.3); ax.set_yscale('log')
        ax.set_xlabel('solver blocks in the network'); ax.set_title(ttl)
    a.set_ylabel('µs'); a.set_ylim(8, 900)
    a.annotate('+25 µs per block', (2, lat_fp32[1]), xytext=(0, 8), textcoords='offset points', ha='center', fontsize=8.5, color=C['fp32'])
    a.annotate('+6 µs per block (idle)', (2, lat_bf16[1]), xytext=(0, -14), textcoords='offset points', ha='center', fontsize=8.5, color=C['bf16'])
    # 25.5 us, within noise of fp32's 25.3 -- a coincidence, and readers will read
    # it as a copy-paste bug unless the mechanism is named. The array pays cascade
    # lag; the fabric pays pipeline depth.
    a.annotate('+25 µs per block (pipeline depth)', (2, pl[1]), xytext=(0, 8), textcoords='offset points', ha='center', fontsize=8.5, color=C['pl'])
    b.annotate('unchanged', (2, thr_fp32[1]), xytext=(0, 7), textcoords='offset points', ha='center', fontsize=8.5, color=C['fp32'])
    b.annotate('unchanged', (2, thr_bf16[1]), xytext=(0, 7), textcoords='offset points', ha='center', fontsize=8.5, color=C['bf16'])
    b.annotate('unchanged', (2, thr_pl[1]), xytext=(0, 8), textcoords='offset points', ha='center', fontsize=8.5, color=C['pl'])
    b.legend(loc='center right', bbox_to_anchor=(1.0, 0.62))
    fig.savefig(OUT / 'res_scaling.png')

def latthr(cpu8, cpu32):
    fig, ax = plt.subplots(figsize=(6.0, 4.1))
    BOARD_LAT = {'fp32': 550.1, 'bf16': 284.9, 'pl': 427.8}               # S, 1-update call, us_execute
    BOARD_THR = {'fp32': 30.14, 'bf16': 11.93, 'pl': 286.42}               # S, @10,000 updates
    xs = np.logspace(1, 4, 50); ax.plot(xs, 1e6 / xs, ls=':', color='#bdc1c6', lw=1, zorder=1)
    for k in ('fp32', 'bf16', 'pl'):
        d = (LAT[k], 1e6 / THR[k]); h = (BOARD_LAT[k], 1e6 / BOARD_THR[k])
        mk = 's' if k == 'pl' else 'o'
        # PL gets an arrow now too. Before pipelining its device and board points
        # coincided -- latency and throughput were one number -- so there was
        # nothing to draw between them.
        ax.annotate('', xy=h, xytext=d, arrowprops=dict(arrowstyle='->', color=C[k], lw=1, alpha=0.55))
        ax.plot(*h, mk, mfc='white', mec=C[k], mew=1.8, ms=12 if k == 'pl' else 10, zorder=3)
        ax.plot(*d, mk, color=C[k], ms=7, zorder=4)
        off = {'fp32': (0, -15), 'bf16': (0, 9), 'pl': (0, -21)}[k]
        ax.annotate(NAME[k], d, xytext=off, textcoords='offset points', ha='center' if k != 'pl' else 'right', fontsize=8.5, color=C[k])
    for (lat, thr, col, lab, off) in ((510.3, 40.03, cpu8, 'CPU, 8 threads', (-9, -1)), (495.8, 16.31, cpu32, 'CPU, 32 threads', (-9, -1))):
        ax.plot(lat, 1e6 / thr, 'D', color=col, ms=7, zorder=3)
        ax.annotate(lab, (lat, 1e6 / thr), xytext=off, textcoords='offset points', fontsize=8.5,
                    color=col, va='center', ha='right')
    ax.plot([], [], 'o', color='#5f6368', ms=7, label='accelerator alone')
    ax.plot([], [], 'o', mfc='white', mec='#5f6368', mew=1.8, ms=10, label='on the board, host included')
    ax.legend(loc='lower left')
    ax.set_xscale('log'); ax.set_yscale('log'); ax.set_xlim(20, 1.05e3); ax.set_ylim(1.8e3, 1.5e5)
    ax.set_xlabel('latency of one update (µs)  —  lower is better')
    ax.set_ylabel('updates per second  —  higher is better')
    ax.set_title('Latency and throughput')
    fig.savefig(OUT / 'res_latency_throughput.png')

def batch():
    """Time per update against updates per host call (S, primary rows, median of 5), with the
    array's continuously-fed rate (T) as a floor. Busy fraction = device time / call time, where a
    call of N updates occupies the array for N*7*II + latency (the host prepends a flush update)."""
    n = np.array([1, 10, 100, 1000, 10000])
    board = {'fp32': [550.07, 80.89, 33.86, 30.67, 30.14],
             'bf16': [284.94, 54.41, 15.83, 12.18, 11.93],
             'pl':   [427.79, 300.97, 287.95, 286.61, 286.42]}
    cpu8 = [510.26, 322.69, 155.61, 48.34, 40.03]
    CPU = '#37a05f'
    fig, ax = plt.subplots(figsize=(6.0, 4.0))
    for k in ('pl', 'fp32', 'bf16'):
        ax.plot(n, board[k], 's-' if k == 'pl' else 'o-', color=C[k], zorder=3)
    ax.plot(n, cpu8, 'D--', color=CPU, ms=5, lw=1.8, zorder=2)
    # A floor for all three now. The PL only acquired one when it was pipelined:
    # a serial design has no steady-state rate distinct from its latency, so there
    # was no line to draw.
    for k in ('fp32', 'bf16', 'pl'):                  # stop short of the direct labels
        ax.plot([0.8, 1e4], [THR[k]] * 2, color=C[k], ls=':', lw=1.4, zorder=1)
    ax.text(1.15, THR['fp32'] * 0.80, 'fp32, streamed from the PL', color=C['fp32'], fontsize=8.3, va='top')
    ax.text(1.15, THR['bf16'] * 0.80, 'bf16, streamed from the PL', color=C['bf16'], fontsize=8.3, va='top')
    ax.text(1.15, THR['pl'] * 0.80, 'PL, pipelined fabric', color=C['pl'], fontsize=8.3, va='top')
    for k, lab, dy in (('pl', 'PL fixed<16,3>', 0), ('fp32', 'AIE-ML fp32', 5), ('bf16', 'AIE-ML bf16', -2)):
        ax.annotate(lab, (n[-1], board[k][-1]), xytext=(7, dy), textcoords='offset points', color=C[k], fontsize=8.6, va='center')
    ax.annotate('CPU, 8 threads', (n[-1], cpu8[-1]), xytext=(7, 4), textcoords='offset points', color=CPU, fontsize=8.6, va='center')
    busy1 = (7 * 1.6501e-3 * 1e3 * 1 + LAT['bf16']) / board['bf16'][0]
    busyN = (THR['bf16'] * 10000 + LAT['bf16']) / (board['bf16'][-1] * 10000)
    arrow = dict(arrowstyle='->', color=C['bf16'], lw=0.9, shrinkA=2, shrinkB=5)
    ax.annotate(f'array computing for {busy1:.0%}\nof a one-update call', xy=(1, board['bf16'][0]),
                xytext=(1.9, 800), arrowprops=arrow, color=C['bf16'], fontsize=8.3, va='center')
    ax.annotate(f'{busyN:.0%} of a\n10,000-update call', xy=(n[-1], board['bf16'][-1]),
                xytext=(1300, 19.5), arrowprops=arrow, color=C['bf16'], fontsize=8.3, ha='center', va='center')
    ax.set_xscale('log'); ax.set_yscale('log'); ax.set_xlim(0.8, 1.6e4); ax.set_ylim(7, 1.2e3)
    ax.set_xlabel('alignment updates passed to the device per host call')
    ax.set_ylabel('time per update (µs)')
    ax.set_title('Keeping the array busy')
    fig.savefig(OUT / 'res_batch.png')
    print(f'bf16 busy: {busy1:.1%} at 1 update/call, {busyN:.1%} at 10,000')


if __name__ == '__main__':
    which = sys.argv[1:] or ['energy', 'scaling']
    if 'energy' in which:  energy()
    if 'scaling' in which: scaling()
    if 'batch' in which:   batch()
    if 'latthr' in which:  latthr(*which[which.index('latthr') + 1:which.index('latthr') + 3])
    print('wrote', sorted(p.name for p in OUT.glob('*.png')))
