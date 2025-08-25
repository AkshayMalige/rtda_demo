#!/usr/bin/env bash

# Ensure XILINX_VITIS points to a 2024.2 installation
if [[ -z "${XILINX_VITIS}" || "${XILINX_VITIS}" != *2024.2* ]]; then
  echo "ERROR: XILINX_VITIS must reference Vitis 2024.2" >&2
  return 1 2>/dev/null || exit 1
fi

# Ensure platform repo paths are provided
if [[ -z "${PLATFORM_REPO_PATHS}" ]]; then
  echo "ERROR: PLATFORM_REPO_PATHS is not set" >&2
  return 1 2>/dev/null || exit 1
fi

# Locate a VEK280 base platform
IFS=':' read -r -a repo_paths <<< "${PLATFORM_REPO_PATHS}"
PLATFORM=""
for p in "${repo_paths[@]}"; do
  [[ -d "$p" ]] || continue
  candidate=$(find "$p" -maxdepth 5 -type f -name "*vek280*base*.xpfm" | grep -E "2024\\.2|202420" | head -n 1)
  if [[ -n "$candidate" ]]; then
    PLATFORM="$candidate"
    break
  fi
done

if [[ -z "$PLATFORM" ]]; then
  echo "ERROR: Could not locate a VEK280 base platform in PLATFORM_REPO_PATHS" >&2
  return 1 2>/dev/null || exit 1
fi
export PLATFORM

# Set default target
export TARGET="${TARGET:-hw_emu}"

