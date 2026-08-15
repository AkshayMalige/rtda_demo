#!/usr/bin/env bash
# ===========================================================================
#  Kill a PL hardware build as soon as it is KNOWN to fail, not 3 hours later.
#
#      tools/watch_pl_build.sh [pl_fixed_dir] [threshold_percent]
#
#  WHY
#  The 2026-08-14 build ran 12 hours and failed in route_design:
#
#      ERROR: [Route 35-2] Design is not legally routed.
#      469480 signals failed to route due to routing congestion.
#
#  It was doomed at 21:46, when Vivado finished synthesising the kernel and
#  wrote a utilization report saying CLB LUTs 519041/520704 = 99.68%. Nobody
#  read it, and the build churned on until 00:41.
#
#  Post-synthesis LUT tracks post-placement LUT closely on this design
#  (99.68% synth -> 98.87% placed), so that report is a sound early verdict.
#  It lands roughly an hour into the vpl stage -- about a third of the way in.
#
#  This polls for it, prints the number, and tells you to stop if it is over
#  threshold. It does NOT kill anything itself: deciding to throw away hours of
#  compute is yours to make, and a watchdog that guesses wrong is worse than no
#  watchdog at all.
#
#  Run it in a second terminal alongside the build.
# ===========================================================================
set -uo pipefail

PL=${1:-pl_fixed}
THRESH=${2:-80}

RPT="$PL/_x/link/vivado/vpl/prj/prj.runs/vitis_design_rtda_split_top_1_0_synth_1/vitis_design_rtda_split_top_1_0_utilization_synth.rpt"
PLACED="$PL/_x/link/vivado/vpl/prj/prj.runs/impl_1/full_util_placed.rpt"

[ -d "$PL" ] || { echo "ERROR: no such directory: $PL"; exit 2; }

echo "watching $PL   (threshold ${THRESH}% LUT)"
echo "  waiting for HLS + Vivado synthesis to produce:"
echo "  ${RPT#$PL/}"
echo

# "CLB LUTs*" in a synth report, "CLB LUTs" post-place; the utilisation percent
# is the last numeric column. Take the first match only -- the report repeats
# the row in its per-hierarchy sections.
lut_pct() {
  # The percent is the LAST populated column, not a fixed field index. Counting
  # to $6 lands on "Available" (520704) and reports it as a percentage -- which
  # is over any threshold, so the check appears to work while being nonsense.
  # Anchor to the end of the row instead: awk splits "|a|b|" into a trailing
  # empty field, so the percent is NF-1.
  awk -F'|' '/^\| *CLB LUTs/ { v=$(NF-1); gsub(/ /,"",v); print v; exit }' "$1" 2>/dev/null
}

seen_synth=0
while true; do
  if [ "$seen_synth" -eq 0 ] && [ -f "$RPT" ]; then
    pct=$(lut_pct "$RPT")
    if [ -n "$pct" ]; then
      seen_synth=1
      echo "[$(date +%H:%M)] post-synthesis CLB LUTs: ${pct}%"
      # bash has no floats; compare in awk
      if awk -v p="$pct" -v t="$THRESH" 'BEGIN{exit !(p>t)}'; then
        echo
        echo "  *** OVER THRESHOLD -- this build will almost certainly fail to route."
        echo "  *** The 12 h build that failed read 99.68% here."
        echo "  *** Stop it now (Ctrl-C the make) rather than waiting for route_design."
        echo
      else
        echo "  under ${THRESH}% -- worth letting placement and routing run."
      fi
    fi
  fi

  if [ -f "$PLACED" ]; then
    pct=$(lut_pct "$PLACED")
    [ -n "$pct" ] && { echo "[$(date +%H:%M)] post-placement CLB LUTs: ${pct}%  (routing next)"; exit 0; }
  fi

  sleep 60
done
