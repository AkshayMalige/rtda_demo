############################################################################
#  The CPU baseline.
#
#  The same network as aie_batch and pl_fixed, run through model/rtda_ref.py
#  on the host, so the two accelerators have something other than each other
#  to be measured against.
#
#  This is the one flow in the repo that needs neither XRT nor Vitis nor a
#  card. It runs in a bare shell in under a minute.
#
#      make -C cpu check                  correctness, ~10 s
#      make -C cpu scan_host              the 1..10000 event sweep, ~40 s
#
#  or through the root dispatcher:
#
#      make fastsim   FLOW=cpu
#      make scan_host FLOW=cpu
############################################################################

SHELL := /bin/bash

# Pinned, and not `python3`. set_envs.sh puts PetaLinux's numpy-less
# interpreter first on PATH, and it also exports CXX/CC pointing at the
# aarch64 cross compiler -- neither of which belongs anywhere near a host
# measurement. Same pin aie_batch and pl_fixed use.
PYTHON     ?= /home/synthara/miniforge3/bin/python

REPO       := $(CURDIR)/..
RESULTS    := $(REPO)/results/cpu/native
SCAN       := $(CURDIR)/scan_cpu.py

# 500000 tracks = 10000 events, the same stimulus both XRT scan hosts used.
# Family B (synthesised, seed 1234) -- do NOT substitute a Family A file, they
# are one real event repeated and every event would score identically.
STIMULUS   ?= $(REPO)/testdata/embed_input_500000.txt

EVENTS     ?= 200
WARMUP     ?= 3
DTYPE      ?= fp32
SCAN_REPS  ?= 5
SCAN_EVENTS?= 1,10,100,1000,10000
SCAN_THREADS ?= 1,2,4,8,16,32

.PHONY: all check fastsim scan_host scan vars clean clean_all help

all: help

# --------------------------------------------------------------------------
#  Correctness. Run this before believing any timing.
# --------------------------------------------------------------------------
#  Asserts the two properties the whole baseline rests on -- that splitting the
#  run into chunks is bit-identical to not splitting it, and that adding
#  threads changes nothing -- then prices fp32 against fp64.
check fastsim: $(STIMULUS)
	@$(PYTHON) $(SCAN) --check --check-events $(EVENTS) \
	    --stimulus $(STIMULUS) --warmup $(WARMUP)

# --------------------------------------------------------------------------
#  The sweep. Writes results/cpu/native/{scan.csv,scan_meta.txt}.
# --------------------------------------------------------------------------
scan_host scan: $(STIMULUS)
	@mkdir -p $(RESULTS)
	@$(PYTHON) $(SCAN) --stimulus $(STIMULUS) --outdir $(RESULTS) \
	    --events $(SCAN_EVENTS) --threads $(SCAN_THREADS) \
	    --reps $(SCAN_REPS) --dtype $(DTYPE) --warmup $(WARMUP)

$(STIMULUS):
	@echo "ERROR: $(STIMULUS) is missing."
	@echo "  generate it:  make stimulus TRACKS=500000"
	@echo "  or copy it:   tools/sync_results.sh"
	@exit 1

vars:
	@echo "PYTHON       = $(PYTHON)"
	@echo "STIMULUS     = $(STIMULUS)"
	@echo "RESULTS      = $(RESULTS)"
	@echo "DTYPE        = $(DTYPE)"
	@echo "WARMUP       = $(WARMUP)"
	@echo "SCAN_EVENTS  = $(SCAN_EVENTS)"
	@echo "SCAN_THREADS = $(SCAN_THREADS)"
	@echo "SCAN_REPS    = $(SCAN_REPS)"

# There is nothing to build, so there is nothing to clean but the results --
# and those are deleted only when asked for explicitly.
clean:
	@echo "cpu: nothing to clean (no build artefacts). "
	@echo "     'make -C cpu clean_all' also removes $(RESULTS)."

clean_all:
	@rm -rf $(RESULTS)
	@echo "cpu: removed $(RESULTS)"

help:
	@echo ""
	@echo "  CPU baseline -- the same network on the host, no card needed."
	@echo ""
	@echo "    make -C cpu check        correctness + the fp32 price   (~10 s)"
	@echo "    make -C cpu scan_host    1..10000 event sweep           (~40 s)"
	@echo "    make -C cpu vars"
	@echo ""
	@echo "  Knobs: DTYPE=fp32|fp64  WARMUP=3  SCAN_THREADS=1,2,4,8,16,32"
	@echo "         SCAN_EVENTS=1,10,100,1000,10000  SCAN_REPS=5"
	@echo ""
	@echo "  Results land in results/cpu/native/ and are read by"
	@echo "  analysis/rtda_scan.ipynb section 9."
	@echo ""
