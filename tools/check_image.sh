#!/usr/bin/env bash
# ===========================================================================
#  Pre-flight check on a packaged SD image -- no board, no root, no flashing.
#
#      tools/check_image.sh <sd_card.img> aie_batch <fp32|bf16> <hw|hw_emu>
#      tools/check_image.sh <sd_card.img> pl_fixed  -           <hw|hw_emu>
#
#  WHY THIS EXISTS
#  The restructure renamed three build outputs and nothing noticed until a
#  board run aborted after a multi-hour build:
#
#      Makefile produced          host looked for
#      system.xclbin              system_hw.xclbin
#      fp32/  (sd_dir basename)    sd_batch/
#      weights_fp32/               data_fp32/
#
#  Every one of those is checkable on the build machine in under a second.
#  This script asserts that every path the host will open is present and
#  non-empty, and that the image's own config.txt agrees with the precision
#  you think you built.
#
#  HOW IT READS THE IMAGE
#  Partition 1 is FAT32 at a fixed offset (2048 sectors x 512 = 1048576), and
#  mtools can read a filesystem at an offset with img@@offset -- so no loop
#  device and no sudo. mcopy/mdir come from the PetaLinux sysroot, which
#  `source set_envs.sh` already puts on PATH.
# ===========================================================================
set -uo pipefail

IMG=${1:?usage: check_image.sh <sd_card.img> <aie_batch|pl_fixed> <precision|-> <hw|hw_emu>}
FLOW=${2:?}
PREC=${3:-}
TARGET=${4:-hw}

P1_OFFSET=1048576          # partition 1 starts at sector 2048
FAIL=0

command -v mdir >/dev/null 2>&1 || {
  echo "ERROR: mtools (mdir/mcopy) not on PATH."
  echo "       source set_envs.sh first -- it adds the PetaLinux sysroot."
  exit 2
}
[ -f "$IMG" ] || { echo "ERROR: no such image: $IMG"; exit 2; }

D="$IMG@@$P1_OFFSET"

say()  { printf '  %-52s %s\n' "$1" "$2"; }
bad()  { FAIL=$((FAIL+1)); }

# Present AND non-empty, and actually READABLE.
#
# Size comes from streaming the file out with `mcopy ... -` and counting bytes,
# not from parsing mdir's columns -- mdir's output has several numbers per line
# (size, date, free space) and picking the wrong one gives every file the same
# plausible-looking size, which is worse than no check at all. Streaming also
# proves the file can be read, not merely that a directory entry exists.
need() {
  local path="$1" sz
  if [ "${2:-file}" = dir ]; then
    if mdir -i "$D" "::/$path" >/dev/null 2>&1; then say "$path" "ok (dir)"
    else say "$path" "MISSING"; bad; fi
    return
  fi
  sz=$(mcopy -i "$D" "::/$path" - 2>/dev/null | wc -c)
  if [ "${sz:-0}" -eq 0 ]; then
    if mdir -i "$D" "::/$path" >/dev/null 2>&1; then say "$path" "EMPTY (0 bytes)"
    else say "$path" "MISSING"; fi
    bad
  else
    say "$path" "ok  $(numfmt --to=iec --suffix=B "$sz" 2>/dev/null || echo "$sz bytes")"
  fi
}

# Any one of the listed paths is acceptable -- mirrors the host's search order.
need_any() {
  local p sz
  for p in "$@"; do
    sz=$(mcopy -i "$D" "::/$p" - 2>/dev/null | wc -c)
    [ "${sz:-0}" -gt 0 ] && { say "$p" "ok  $(numfmt --to=iec --suffix=B "$sz" 2>/dev/null || echo "$sz bytes")"; return; }
  done
  say "$1" "MISSING (tried: $*)"; bad
}

echo
echo "checking $IMG"
echo "  flow=$FLOW precision=${PREC:--} target=$TARGET"
echo

# --- shared boot payload ---------------------------------------------------
need "BOOT.BIN"
need "Image"
need "boot.scr"

XCLBIN="system_${TARGET}.xclbin"
need "$XCLBIN"

if [ "$FLOW" = pl_fixed ]; then
  need "host_split.exe"
  need "embed_input_50000.txt"
else
  need "host_batch.exe"
  # host_batch searches sd_batch/<...>; the basename of --package.sd_dir is
  # what lands here, which is exactly what broke.
  need "sd_batch"                              dir
  need "sd_batch/sysdata/rtp_manifest.txt"
  need "sd_batch/sysdata/config.txt"
  # The host searches weights_fp32/ first, then the legacy data_fp32/ name, so
  # accept either -- a card flashed before the rename must still validate.
  for f in embed_input.txt output_weights.txt output_bias.txt; do
    need_any "sd_batch/weights_fp32/$f" "sd_batch/data_fp32/$f"
  done
  need "sd_batch/testdata/embed_input_50000.txt"
  need "sd_batch/testdata/golden_50000.txt"

  # --- the mismatched-pair trap ------------------------------------------
  # An xclbin built for one precision with the other precision's RTP payloads
  # fails on the board with
  #   adf::graph::update parameter size 4096 bytes is inconsistent with ... 8192
  # Guarded until now only by a human remembering to `cat` config.txt.
  if [ -n "$PREC" ] && [ "$PREC" != "-" ]; then
    tmp=$(mktemp -d)
    if mcopy -i "$D" "::/sd_batch/sysdata/config.txt" "$tmp/config.txt" 2>/dev/null; then
      got=$(sed -n 's/^precision=//p' "$tmp/config.txt" | tr -d '\r')
      if [ "$got" = "$PREC" ]; then
        say "config.txt precision=$got" "ok  matches PRECISION=$PREC"
      else
        say "config.txt precision=${got:-<none>}" "MISMATCH -- you asked for $PREC"
        echo "        The xclbin and the RTP payloads on this card are a"
        echo "        MISMATCHED PAIR. On the board this fails with"
        echo "        'parameter size ... is inconsistent with ... size ...'."
        bad
      fi
    else
      say "config.txt" "UNREADABLE"; bad
    fi
    rm -rf "$tmp"
  fi
fi

echo
if [ "$FAIL" -eq 0 ]; then
  echo "  PASS -- every path the host opens is present on the image."
  exit 0
fi
echo "  FAIL -- $FAIL problem(s). This image will not run on the board."
echo "  Re-stage and repackage (minutes, no graph rebuild, no relink):"
if [ "$FLOW" = pl_fixed ]; then
  echo "      make -C pl_fixed package TARGET=$TARGET"
else
  echo "      make -C aie_batch repackage PRECISION=$PREC TARGET=$TARGET"
fi
exit 1
