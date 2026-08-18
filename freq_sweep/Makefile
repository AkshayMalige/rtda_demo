############################################################################
#  How fast can pl_fixed actually run?
#
#  The design ships at 150 MHz and is fabric-bound: 114,538 ns/track measured
#  against a 42,233 ns/track csynth floor. Clock frequency is the one untried
#  lever on that number, and nobody knows how much headroom there is.
#
#  TWO CLOCKS, and they were never connected
#    ../pl_fixed/Makefile KERNEL_FREQ  ->  v++ --link --clock.defaultFreqHz
#    ../pl_fixed/pl/rtda_split_project.tcl  ->  create_clock -period 6.667
#  Raising the first alone re-times RTL that HLS scheduled for 150 MHz, and the
#  shipped build closes at WNS +0.050 ns -- 0.75% of the period. There is
#  nothing to re-time into. This flow drives BOTH, via RTDA_HLS_PERIOD.
#
#  So raising the clock costs LUT, because HLS pipelines harder to hold the
#  tighter period. The shipped design sits at 75.95% and the 2026-08-14 build
#  failed to route at 98.87%. This may well find that the design stops FITTING
#  before it stops CLOSING.
#
#  FOUR WAYS TO RUN IT, cheapest first:
#
#    make test       parsers vs the REAL reports on disk.        ~2 s
#    make dryrun     every command, every path. Runs nothing.    ~1 s
#    make mock       the whole search against fake tools.        ~1 min
#    make smoke      is the injected HLS period accepted?        ~2 min, real tools
#    make sweep      the real thing.                             ~4 h per point
#
#  Run test + dryrun + mock before sweep. They cost a minute between them and
#  they are the difference between a bug found now and a bug found after a
#  build tree has been churning for four hours.
############################################################################
SHELL := /bin/bash

# numpy is not needed here, but the pin is: set_envs.sh puts PetaLinux's
# python first on PATH and it cannot import pathlib's friends cleanly.
# See ../pl_fixed/Makefile for the same pin and the same reason.
PYTHON  ?= /home/synthara/miniforge3/bin/python

FMIN    ?= 150
FMAX    ?= 250
STEP    ?= 10
YES     ?=
ROOT    ?= /home/synthara/VersalPrjs/LDRD/freq_sweep_work
OUT     ?= results
# The PASS bar. Slack is recorded as measured either way; this only chooses
# which word lands in the verdict column, so it can be moved when READING the
# table instead of being baked into a build that took four hours.
WNS     ?= 0.0

SWEEP_ARGS = --fmin $(FMIN) --fmax $(FMAX) --step $(STEP) \
             --root $(ROOT) --out $(OUT) --wns-threshold $(WNS) \
             $(if $(YES),--yes,)

.PHONY: all help test dryrun mock smoke sweep report vars clean clean_all

all: help

############################################################################
#  1. Does the parser work?  (no tools, no builds)
############################################################################
# Against ../pl_fixed/_x/reports/, which is the shipped 150 MHz build. If the
# parser reproduces the numbers already in ../README.md then it is right, and
# none of them is a number invented here.
test:
	@$(PYTHON) tests/test_reports.py

############################################################################
#  2. What exactly would run?
############################################################################
dryrun:
	@$(PYTHON) sweep_freq.py $(SWEEP_ARGS) --dry-run

############################################################################
#  3. Does the SEARCH work?  (fake tools, real parsers)
############################################################################
# mock_tools/ rewrites the real reports rather than inventing files, so this
# exercises the same parsers on the same shapes. MOCK_FMAX_MHZ and
# MOCK_CLIFF_MHZ set where the pretend device stops closing and stops fitting,
# so the search can be rehearsed against several shapes of reality --
# including the awkward one where routing dies before timing does.
mock:
	@rm -rf $(OUT)/state.json
	@$(PYTHON) sweep_freq.py $(SWEEP_ARGS) --mock --check-isolation --fresh

mock_cliff:
	@rm -rf $(OUT)/state.json
	@MOCK_FMAX_MHZ=240 MOCK_CLIFF_MHZ=185 \
	  $(PYTHON) sweep_freq.py $(SWEEP_ARGS) --mock --check-isolation --fresh

############################################################################
#  4. The one thing a mock cannot prove
############################################################################
# That Vitis HLS actually accepts the period we inject. create_clock runs in
# the first seconds, long before the ~100 min synthesizability check, so this
# starts a real csynth, greps the log, and kills it.
smoke:
	@$(PYTHON) smoke_period.py $(if $(YES),--yes,)

############################################################################
#  5. The real sweep
############################################################################
sweep:
	@$(PYTHON) sweep_freq.py $(SWEEP_ARGS)

report:
	@cat $(OUT)/freq_report.md

vars:
	@echo "FMIN    = $(FMIN)        FMAX = $(FMAX)     STEP = $(STEP)"
	@echo "ROOT    = $(ROOT)"
	@echo "OUT     = $(OUT)"
	@echo "WNS     = $(WNS)        (PASS bar; slack is recorded regardless)"
	@echo "PYTHON  = $(PYTHON)"

clean:
	@rm -rf $(OUT)/logs $(OUT)/state.json
	@echo ">>> cleared logs and resume state; results kept"

clean_all: clean
	@rm -rf $(OUT)/f* $(OUT)/runs.csv $(OUT)/freq_report.md $(ROOT)
	@echo ">>> cleared results and $(ROOT)"

help:
	@echo ""
	@echo "How fast can pl_fixed run?  --  kernel-frequency sweep"
	@echo "======================================================================"
	@echo ""
	@echo "  make test                       parsers vs the real reports   ~2 s"
	@echo "  make dryrun                     every command, runs nothing   ~1 s"
	@echo "  make mock                       whole search, fake tools      ~1 min"
	@echo "  make mock_cliff                 ... where routing dies first  ~1 min"
	@echo "  make smoke                      real HLS accepts the period?  ~2 min"
	@echo ""
	@echo "  make sweep                      shows the plan, builds nothing"
	@echo "  make sweep YES=1                THE REAL RUN   ~4 h per step, serial"
	@echo "  make sweep FMIN=150 FMAX=200    narrower grid"
	@echo "  make report                     read the last result"
	@echo ""
	@echo "  Run test, dryrun and mock first. Together they cost a minute."
	@echo "  Builds go to $(ROOT), never into this repo."
	@echo "  Results land in $(OUT)/ tagged by frequency."
	@echo ""
