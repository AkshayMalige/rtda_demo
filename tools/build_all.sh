#!/usr/bin/env bash
#
# build_all.sh -- every build in this repo, in the one order that works,
#                 unattended, with a log per stage and a summary at the end.
#
#   ./tools/build_all.sh                  # everything: ~12-14 h
#   ./tools/build_all.sh build            # COMPILE ONLY -- no simulator runs
#   ./tools/build_all.sh sim              # run the simulators, build no image
#   ./tools/build_all.sh hw               # just the three hw system builds
#   ./tools/build_all.sh data x86 exact   # a subset, run in the order LISTED BELOW
#                                         #   (not the order you type them)
#   ./tools/build_all.sh -v build         # ... and show every tool's output
#   ./tools/build_all.sh --list           # stages and what they cost
#   ./tools/build_all.sh --dry-run all    # print the commands, run nothing
#
# `build` and `sim` in the WRONG order costs you the AIE graph twice: `make
# system` replaces Work_<P>/ with the GMIO graph, so a later `sim` has to rebuild
# the PLIO one, and vice versa. If you want both, run `all` (or `sim` then
# `build`) rather than `build` then `sim`.
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
#                                 INPUT. A lock refuses a second. This script is
#                                 strictly serial for that reason -- do not add
#                                 `&` or `-j`. (Outputs are per configuration
#                                 since 2026-08-19 and no longer collide.)
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
VERBOSE=0

# stage | description | rough cost
STAGES=(
  "data|stimulus, goldens and the reference self-test|~3 min"
  "x86|x86simulator + the native ap_fixed model (functional)|~5 min"
  "cpu|host-CPU baseline: correctness + the 1..10000 event scan|~1 min"
  "exact|aiesimulator both precisions + PL csim (cycle/RTL accurate)|~50 min"
  "hw_emu|system build, TARGET=hw_emu, all three|~3 h (+5 h first PL csynth)"
  "hw|system build, TARGET=hw, all three -- the SD images|~8 h"
)

usage() {
    echo "usage: $0 [-v|--verbose] [--dry-run] [--list] [all | build | sim | <stage> ...]"
    echo
    printf '  %-8s %-62s %s\n' STAGE WHAT COST
    for s in "${STAGES[@]}"; do
        IFS='|' read -r n d c <<< "$s"
        printf '  %-8s %-62s %s\n' "$n" "$d" "$c"
    done
    echo
    echo "  Shorthands:"
    printf '  %-8s %s\n' "build" "data + hw_emu + hw -- COMPILES ONLY, runs no simulator"
    printf '  %-8s %s\n' "sim"   "x86 + cpu + exact -- runs the simulators, builds no image"
    printf '  %-8s %s\n' "all"   "every stage"
    echo
    echo "  Stages always run in the order above, whatever order you type them."
    echo
    echo "  'build' still includes data: the images package the stimulus, so"
    echo "  testdata/ has to exist before the packaging step runs."
    echo
    echo "  -v shows every tool's output on the terminal as well as in the log."
    echo "  Without it you get one line per step and the output goes to the log"
    echo "  only -- which is what you want for an overnight run. To watch a quiet"
    echo "  run instead of restarting it verbose:"
    echo "      tail -f build_logs/<timestamp>/<stage>.log"
    exit 0
}

WANT=()
for a in "$@"; do
    case "$a" in
        --list|-l|-h|--help) usage ;;
        --dry-run|-n) DRYRUN=1 ;;
        --verbose|-v) VERBOSE=1 ;;
        all) WANT=(data x86 cpu exact hw_emu hw) ;;
        # Compile everything, run nothing. `data` is in here because the images
        # package the stimulus files -- packaging with an empty testdata/ ships a
        # card the hosts cannot read.
        build) WANT+=(data hw_emu hw) ;;
        # The mirror image: run every simulator, build no image.
        sim) WANT+=(x86 cpu exact) ;;
        data|x86|cpu|exact|hw_emu|hw) WANT+=("$a") ;;
        *) echo "unknown argument: $a"; usage ;;
    esac
done
[ ${#WANT[@]} -eq 0 ] && WANT=(data x86 cpu exact hw_emu hw)

# Deduplicate and put into canonical order. `build build x86` is harmless -- each
# stage runs once regardless -- but without this the banner would count seven
# stages and announce "STAGE 1/7" for a run of four.
_dedup=()
for canon in data x86 cpu exact hw_emu hw; do
    for w in "${WANT[@]}"; do
        [ "$w" = "$canon" ] && { _dedup+=("$canon"); break; }
    done
done
WANT=("${_dedup[@]}")

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
T_START=$(date +%s)
STAGE_N=0
STAGE_TOTAL=${#WANT[@]}

# Colour only when stdout is a terminal. A 13-hour run gets piped to tee or read
# back from the output file as often as it gets watched live, and escape codes in
# a file are worse than no colour.
if [ -t 1 ]; then
    C_BAN=$'\033[1;36m'; C_OK=$'\033[1;32m'; C_BAD=$'\033[1;31m'
    C_DIM=$'\033[2m';    C_OFF=$'\033[0m'
else
    C_BAN=''; C_OK=''; C_BAD=''; C_DIM=''; C_OFF=''
fi

BAR='══════════════════════════════════════════════════════════════════════════'

# The stage banner. Deliberately loud: this is the thing you scroll back looking
# for at 2 a.m. when one of eleven steps failed and you need to know which phase
# it died in.
banner() {                                # banner <stage> <description>
    local st="$1" desc="$2" now el
    STAGE_N=$((STAGE_N + 1))
    now=$(date +%H:%M:%S)
    el=$(( ($(date +%s) - T_START) / 60 ))
    printf '\n%s%s%s\n' "$C_BAN" "$BAR" "$C_OFF"
    printf '%s  STAGE %d/%d  ·  %s%s\n' "$C_BAN" "$STAGE_N" "$STAGE_TOTAL" \
           "$(echo "$st" | tr '[:lower:]' '[:upper:]')" "$C_OFF"
    printf '%s  %s%s\n' "$C_BAN" "$desc" "$C_OFF"
    printf '%s  started %s  ·  %dh%02dm into the run%s\n' \
           "$C_DIM" "$now" $((el / 60)) $((el % 60)) "$C_OFF"
    printf '%s%s%s\n' "$C_BAN" "$BAR" "$C_OFF"
}

# Look up a stage's description from the table at the top, so the banner and
# --list cannot drift apart.
desc_of() {
    for s in "${STAGES[@]}"; do
        IFS='|' read -r n d c <<< "$s"
        [ "$n" = "$1" ] && { echo "$d  ($c)"; return; }
    done
    echo "$1"
}

run() {                                   # run <name> <log> <command...>
    local name="$1" log="$2"; shift 2
    if [ $DRYRUN -eq 1 ]; then
        printf '  %-42s %s\n' "$name" "$*"
        return 0
    fi
    local t0 t1 rc
    t0=$(date +%s)
    if [ $VERBOSE -eq 1 ]; then
        # Everything on the terminal AND in the log. The step header gets its own
        # line here: a trailing prefix followed by 40,000 lines of aiecompiler
        # output is worse than no prefix at all.
        printf '\n%s%s  >>> %s%s\n' "$C_BAN" "$(date +%H:%M:%S)" "$name" "$C_OFF"
        "$@" 2>&1 | tee -a "$LOGDIR/$log"
        rc=${PIPESTATUS[0]}               # tee's status is not the build's
    else
        printf '%s  >>> %-40s ' "$(date +%H:%M:%S)" "$name"
        "$@" >> "$LOGDIR/$log" 2>&1
        rc=$?
    fi
    t1=$(date +%s)
    local mins=$(( (t1 - t0) / 60 )) secs=$(( (t1 - t0) % 60 ))
    [ $VERBOSE -eq 1 ] && printf '%s  <<< %-40s ' "$(date +%H:%M:%S)" "$name"
    if [ $rc -eq 0 ]; then
        printf '%sok%s    %3dm%02ds\n' "$C_OK" "$C_OFF" "$mins" "$secs"
        RESULTS+=("PASS|$name|${mins}m${secs}s|$log")
    else
        printf '%sFAIL%s  %3dm%02ds  (rc=%d, see %s)\n' "$C_BAD" "$C_OFF" "$mins" "$secs" "$rc" "$log"
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
    banner data "$(desc_of data)"
    run "golden 50,000 tracks"        data.log make golden   TRACKS=50000
    run "stimulus 500,000 tracks"     data.log make stimulus TRACKS=500000
    run "selftest (ref vs ONNX)"      data.log make selftest
fi

# ---- 1. x86 / native ------------------------------------------------------
if wanted x86; then
    banner x86 "$(desc_of x86)"
    run "x86sim aie fp32"             x86.log make fastsim FLOW=aie_batch PRECISION=fp32 EVENTS=5
    run "x86sim aie bf16"             x86.log make fastsim FLOW=aie_batch PRECISION=bf16 EVENTS=5
    run "pl sweep (format ranking)"   x86.log make -C pl_fixed sweep EVENTS=20
    run "pl native model, 1000 ev"    x86.log make fastsim FLOW=pl_fixed EVENTS=1000
fi

# ---- 1b. the host-CPU baseline --------------------------------------------
# Needs no card, no XRT and no Vitis, and it is the only stage that can run
# while a hardware build is going -- though it should not, because it measures
# the machine it runs on.
if wanted cpu; then
    banner cpu "$(desc_of cpu)"
    run "cpu correctness (chunk+threads)" cpu.log make fastsim FLOW=cpu EVENTS=200
    run "cpu scan 1..10000 events"        cpu.log make scan_host FLOW=cpu
fi

# ---- 2. cycle / RTL accurate ----------------------------------------------
# Strictly serial. See the lock note at the top.
if wanted exact; then
    banner exact "$(desc_of exact)"
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
    banner hw_emu "$(desc_of hw_emu)"
    run "system pl_fixed  hw_emu"     hw_emu.log make system FLOW=pl_fixed              TARGET=hw_emu
    run "system aie fp32  hw_emu"     hw_emu.log make system FLOW=aie_batch PRECISION=fp32 TARGET=hw_emu
    run "system aie bf16  hw_emu"     hw_emu.log make system FLOW=aie_batch PRECISION=bf16 TARGET=hw_emu
fi

# ---- 4. hw system builds --------------------------------------------------
if wanted hw; then
    banner hw "$(desc_of hw)"
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
