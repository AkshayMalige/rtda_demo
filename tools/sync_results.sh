#!/usr/bin/env bash
# Copy the analysis artefacts from a build tree into this one.
#
# The notebooks read generated files that no build in THIS tree produced:
# scan results, routed power reports, run_info, and the csynth report the PL
# fabric reference is parsed out of. Everything here is gitignored -- this
# makes the tree RUNNABLE, not authoritative. Nothing it copies is committed.
#
#   tools/sync_results.sh [SRC_TREE]      default: ../../final_rtda/rtda_demo
#
# Safe to re-run; it overwrites. Missing sources are reported, not skipped
# silently -- a stale run_info.txt that quietly survives is exactly the failure
# this script exists to prevent.
set -u

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="${1:-$HERE/../../final_rtda/rtda_demo}"

if [ ! -d "$SRC" ]; then
    echo "ERROR: source tree not found: $SRC" >&2
    exit 1
fi
SRC="$(cd "$SRC" && pwd)"
if [ "$SRC" = "$HERE" ]; then
    echo "ERROR: source and destination are the same tree: $SRC" >&2
    exit 1
fi

echo ">>> sync results"
echo "    from $SRC"
echo "    to   $HERE"
echo

# Files the three notebooks read. Kept as one list so it can be audited
# against the notebooks in one place.
FILES="
results/aie_fp32/hw/power_routed.rpt
results/aie_fp32/hw/scan.csv
results/aie_fp32/hw/scan_meta.txt
results/aie_fp32/hw/run_info.txt
results/aie_fp32/hw/track_means_all.txt
results/aie_fp32/hw/track_out_27.txt
results/aie_bf16/hw/power_routed.rpt
results/aie_bf16/hw/scan.csv
results/aie_bf16/hw/scan_meta.txt
results/aie_bf16/hw/run_info.txt
results/aie_bf16/hw/track_means_all.txt
results/aie_bf16/hw/track_out_27.txt
results/pl_fixed/hw/power_routed.rpt
results/pl_fixed/hw/scan.csv
results/pl_fixed/hw/scan_meta.txt
results/pl_fixed/hw/scan_calls_10000.csv
results/pl_fixed/hw/run_info.txt
results/pl_fixed/hw/track_means_all.txt
results/pl_fixed/hw/track_out_27.txt
results/pl_fixed/sim/run_info.txt
results/pl_fixed/sim/track_means_all.txt
results/pl_fixed/sim/track_out_27.txt
results/pl_fixed/sweep.npz
results/aie_fp32/sim/sim_aie_fp32_5ev_250tr.npz
results/aie_fp32/sim/sim_x86_fp32_5ev_250tr.npz
results/aie_bf16/sim/sim_aie_bf16_5ev_250tr.npz
results/aie_bf16/sim/sim_x86_bf16_5ev_250tr.npz
pl_fixed/rtda_split_hls/solution1/syn/report/rtda_split_top_csynth.rpt
testdata/embed_input_500000.txt
"

n_copy=0; n_same=0; n_miss=0
for f in $FILES; do
    s="$SRC/$f"; d="$HERE/$f"
    if [ ! -e "$s" ]; then
        echo "  MISSING  $f"; n_miss=$((n_miss+1)); continue
    fi
    if cmp -s "$s" "$d" 2>/dev/null; then
        n_same=$((n_same+1)); continue
    fi
    mkdir -p "$(dirname "$d")"
    cp -p "$s" "$d" || { echo "ERROR: copy failed: $f" >&2; exit 1; }
    printf "  copied   %-64s %s\n" "$f" "$(du -h "$d" | cut -f1)"
    n_copy=$((n_copy+1))
done

# The per-event simulator dumps are many small files and change as a set.
for d in results/aie_fp32/sim results/aie_bf16/sim; do
    [ -d "$SRC/$d" ] || continue
    mkdir -p "$HERE/$d"
    cp -p "$SRC"/$d/sim_mean_128_*.txt "$SRC"/$d/sim_input_*.txt "$HERE/$d/" 2>/dev/null
done

echo
echo "    $n_copy copied, $n_same already identical, $n_miss missing"
[ "$n_miss" -gt 0 ] && echo "    (missing files mean that build has not been run in the source tree)"
echo
echo ">>> everything above is gitignored -- 'git status' should still be clean"
exit 0
