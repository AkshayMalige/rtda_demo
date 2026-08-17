#!/usr/bin/env bash
#
# build_all.sh -- every build in this repo, in the one order that works,
#                 unattended, with a log per stage and a summary at the end.
#
#   ./tools/build_all.sh                  # everything: ~12-14 h
#   ./tools/build_all.sh x86              # just the fast functional sims
#   ./tools/build_all.sh hw               # just the three hw system builds
#   ./tools/build_all.sh data x86 exact   # a subset, run in the order LISTED BELOW
#                                         #   (not the order you type them)
#   ./tools/build_all.sh --list           # stages and what they cost
#   ./tools/build_all.sh --dry-run all    # print the commands, run nothing
#
# BUILDS ONLY. It does not run QEMU and it does not touch the board: those need
# a person, and an eight-hour build should not be waiting on one. After this
# finishes you have three sd_card.img files and every simulation result.
#
# ---------------------------------------------------------------------------
# THE ORDER IS NOT A PREFERENCE
#
#   simulation BEFORE system      `make system FLOW=aie_batch` rebuilds Work_<P>/
#                                 as the GMIO system graph, which has no PLIO
#                                 debug taps. Run it first and the aiesimulator
#                                 stages can no longer run.
#   one AIE simulation at a time  every run in aie_batch/ shares data/ for PLIO
#                                 input and <sim>simulator_output/ for output.
#                                 A lock refuses a second. This script is
#                                 strictly serial for that reason -- do not add
#                                 `&` or `-j`.
#   pl_fixed hw_emu BEFORE hw     both consume pl/ip/rtda_split.xo and building
#                                 it is the ~5 h csynth. Doing hw_emu first means
#                                 hw reuses it.
#
# A stage that fails does NOT stop the others -- an overnight run should come
# back with nine results and one failure, not one failure. The summary says
# which, and every stage keeps its own log.
# ---------------------------------------------------------------------------

set -u -o pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO"

STAMP="$(date +%Y%m%d_%H%M%S)"
LOGDIR="$REPO/build_logs/$STAMP"
LOCK="$REPO/.build_all.lock"
DRYRUN=0

# stage | description | rough cost
STAGES=(
  "data|stimulus, goldens and the reference self-test|~3 min"
  "x86|x86simulator + the native ap_fixed model (functional)|~5 min"
  "exact|aiesimulator both precisions + PL csim (cycle/RTL accurate)|~50 min"
  "hw_emu|system build, TARGET=hw_emu, all three|~3 h (+5 h first PL csynth)"
  "hw|system build, TARGET=hw, all three -- the SD images|~8 h"
)

usage() {
    echo "usage: $0 [--dry-run] [--list] [all | <stage> ...]"
    echo
    printf '  %-8s %-62s %s\n' STAGE WHAT COST
    for s in "${STAGES[@]}"; do
        IFS='|' read -r n d c <<< "$s"
        printf '  %-8s %-62s %s\n' "$n" "$d" "$c"
    done
    echo
    echo "  Stages always run in the order above, whatever order you type them."
    exit 0
}

WANT=()
for a in "$@"; do
    case "$a" in
        --list|-l|-h|--help) usage ;;
        --dry-run|-n) DRYRUN=1 ;;
        all) WANT=(data x86 exact hw_emu hw) ;;
        data|x86|exact|hw_emu|hw) WANT+=("$a") ;;
        *) echo "unknown argument: $a"; usage ;;
    esac
done
[ ${#WANT[@]} -eq 0 ] && WANT=(data x86 exact hw_emu hw)

wanted() { for w in "${WANT[@]}"; do [ "$w" = "$1" ] && return 0; done; return 1; }

# ---- environment ----------------------------------------------------------
# set_envs.sh is sourced HERE rather than assumed: the whole point is that this
# runs from a bare shell, and half these targets fail in confusing ways without
# it (v++ not found, or worse, PetaLinux's numpy-less python answering to
# `python`).
# shellcheck disable=SC1091
source ./set_envs.sh >/dev/null 2>&1 || { echo "ERROR: cannot source set_envs.sh"; exit 1; }
command -v v++ >/dev/null || { echo "ERROR: v++ not on PATH after set_envs.sh"; exit 1; }

# ---- one at a time --------------------------------------------------------
# Not politeness: two of these scripts running at once would have two
# aiesimulator runs fighting over aie_batch/data/, and the failure looks like a
# numerical bug rather than a collision.
if [ -e "$LOCK" ] && kill -0 "$(cat "$LOCK" 2>/dev/null)" 2>/dev/null; then
    echo "ERROR: build_all.sh is already running as PID $(cat "$LOCK")."
    echo "       AIE simulations share aie_batch/data/; wait for it."
    exit 1
fi
[ $DRYRUN -eq 0 ] && { echo $$ > "$LOCK"; trap 'rm -f "$LOCK"' EXIT; }

mkdir -p "$LOGDIR"
RESULTS=()

run() {                                   # run <name> <log> <command...>
    local name="$1" log="$2"; shift 2
    if [ $DRYRUN -eq 1 ]; then
        printf '  %-42s %s\n' "$name" "$*"
        return 0
    fi
    local t0 t1 rc
    t0=$(date +%s)
    printf '%s  >>> %-40s ' "$(date +%H:%M:%S)" "$name"
    "$@" >> "$LOGDIR/$log" 2>&1
    rc=$?
    t1=$(date +%s)
    local mins=$(( (t1 - t0) / 60 )) secs=$(( (t1 - t0) % 60 ))
    if [ $rc -eq 0 ]; then
        printf 'ok    %3dm%02ds\n' "$mins" "$secs"
        RESULTS+=("PASS|$name|${mins}m${secs}s|$log")
    else
        printf 'FAIL  %3dm%02ds  (rc=%d, see %s)\n' "$mins" "$secs" "$rc" "$log"
        RESULTS+=("FAIL|$name|${mins}m${secs}s|$log")
    fi
    return 0                              # never abort the remaining stages
}

echo "=========================================================================="
echo " RTDA build_all   $STAMP"
echo " repo   : $REPO"
echo " stages : ${WANT[*]}"
echo " logs   : $LOGDIR"
[ $DRYRUN -eq 1 ] && echo " DRY RUN -- nothing will be executed"
echo "=========================================================================="

# ---- 0. data --------------------------------------------------------------
if wanted data; then
    echo "--- data ---------------------------------------------------------------"
    run "golden 50,000 tracks"        data.log make golden   TRACKS=50000
    run "stimulus 500,000 tracks"     data.log make stimulus TRACKS=500000
    run "selftest (ref vs ONNX)"      data.log make selftest
fi

# ---- 1. x86 / native ------------------------------------------------------
if wanted x86; then
    echo "--- x86 ----------------------------------------------------------------"
    run "x86sim aie fp32"             x86.log make fastsim FLOW=aie_batch PRECISION=fp32 EVENTS=5
    run "x86sim aie bf16"             x86.log make fastsim FLOW=aie_batch PRECISION=bf16 EVENTS=5
    run "pl sweep (format ranking)"   x86.log make -C pl_fixed sweep EVENTS=20
    run "pl native model, 1000 ev"    x86.log make fastsim FLOW=pl_fixed EVENTS=1000
fi

# ---- 2. cycle / RTL accurate ----------------------------------------------
# Strictly serial. See the lock note at the top.
if wanted exact; then
    echo "--- exact --------------------------------------------------------------"
    run "aiesimulator fp32"           exact.log make exactsim FLOW=aie_batch PRECISION=fp32 EVENTS=5
    run "report fp32 (II)"            exact.log make -C aie_batch report PRECISION=fp32
    run "aiesimulator bf16"           exact.log make exactsim FLOW=aie_batch PRECISION=bf16 EVENTS=5
    run "report bf16 (II)"            exact.log make -C aie_batch report PRECISION=bf16
    run "pl csim vs native model"     exact.log make -C pl_fixed csim EVENTS=3
fi

# ---- 3. hw_emu system builds ----------------------------------------------
# pl_fixed FIRST: it is the one that pays the csynth, and everything after it
# reuses the .xo. If it fails, the two AIE builds still happen.
if wanted hw_emu; then
    echo "--- hw_emu -------------------------------------------------------------"
    run "system pl_fixed  hw_emu"     hw_emu.log make system FLOW=pl_fixed              TARGET=hw_emu
    run "system aie fp32  hw_emu"     hw_emu.log make system FLOW=aie_batch PRECISION=fp32 TARGET=hw_emu
    run "system aie bf16  hw_emu"     hw_emu.log make system FLOW=aie_batch PRECISION=bf16 TARGET=hw_emu
fi

# ---- 4. hw system builds --------------------------------------------------
if wanted hw; then
    echo "--- hw -----------------------------------------------------------------"
    run "system aie fp32  hw"         hw.log make system FLOW=aie_batch PRECISION=fp32 TARGET=hw
    run "system aie bf16  hw"         hw.log make system FLOW=aie_batch PRECISION=bf16 TARGET=hw
    run "system pl_fixed  hw"         hw.log make system FLOW=pl_fixed              TARGET=hw
    run "check_image aie fp32"        hw.log make check_image FLOW=aie_batch PRECISION=fp32 TARGET=hw
    run "check_image aie bf16"        hw.log make check_image FLOW=aie_batch PRECISION=bf16 TARGET=hw
    run "check_image pl_fixed"        hw.log make check_image FLOW=pl_fixed              TARGET=hw
fi

[ $DRYRUN -eq 1 ] && exit 0

# ---- summary --------------------------------------------------------------
echo
echo "=========================================================================="
echo " SUMMARY   $STAMP -> $(date +%Y%m%d_%H%M%S)"
echo "=========================================================================="
fails=0
for r in "${RESULTS[@]}"; do
    IFS='|' read -r st name dur log <<< "$r"
    printf ' %-4s  %-40s %8s   %s\n' "$st" "$name" "$dur" "$log"
    [ "$st" = FAIL ] && fails=$((fails + 1))
done

echo
echo " SD images:"
found=0
for img in aie_batch/package/*/sd_card.img pl_fixed/package/*/sd_card.img; do
    [ -e "$img" ] || continue
    printf '   %-46s %6.2f GB   %s\n' "$img" \
        "$(echo "scale=2; $(stat -c %s "$img")/1000000000" | bc)" \
        "$(date -r "$img" '+%Y-%m-%d %H:%M')"
    found=1
done
[ $found -eq 0 ] && echo "   (none -- the hw/hw_emu stages did not produce an image)"

echo
echo " Simulation results:"
find results -name '*.npz' -newermt "@$(date -d "$(echo "$STAMP" | sed 's/_/ /;s/\(..\)\(..\)\(..\)$/\1:\2:\3/')" +%s 2>/dev/null || echo 0)" 2>/dev/null \
    | sort | sed 's/^/   /' || true
[ -f results/pl_fixed/sim/run_info.txt ] && echo "   results/pl_fixed/sim/run_info.txt"

echo
echo " Logs: $LOGDIR"
if [ $fails -gt 0 ]; then
    echo " $fails stage(s) FAILED -- the rest completed."
    exit 1
fi
echo " All stages passed."
echo
echo " Next, and these need a person:"
echo "   make run FLOW=aie_batch PRECISION=fp32 TARGET=hw_emu    # QEMU"
echo "   flash the sd_card.img files above, then RUNBOOK.md step 7"
exit 0
