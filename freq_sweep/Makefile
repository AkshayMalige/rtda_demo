############################################################################
#  How fast can pl_fixed actually run?
#
#  The design ships at 180 MHz (KERNEL_FREQ in ../pl_fixed/Makefile) and is
#  fabric-bound: 94,793 ns/track on the board, which RTL co-simulation matches to
#  0.002%. Clock frequency is the lever on that number. The shipped build closes
#  at WNS 0.000 ns with the kernel at 78.47% LUT.
#
#  TWO CLOCKS, and they were not connected until 2026-08-18
#    ../pl_fixed/Makefile KERNEL_FREQ  ->  v++ --link --clock.defaultFreqHz
#    ../pl_fixed/pl/rtda_split_project.tcl  ->  create_clock -period RTDA_HLS_PERIOD
#  The TCL's period was a hardcoded 6.667 ns, so raising KERNEL_FREQ alone re-timed
#  RTL scheduled for 150 MHz. pl_fixed now derives the period from KERNEL_FREQ, and
#  this flow sets RTDA_HLS_PERIOD per point.
#
#  So raising the clock costs LUT, because HLS pipelines harder to hold the
#  tighter period, and the 2026-08-14 build failed to route at 98.87%. This may
#  well find that the design stops FITTING before it stops CLOSING.
#
#  THE FIRST SWEEP (2026-08-18/19) routed 160, 180 and 190 MHz at WNS 0.000 ns --
#  on the kernel as it was before its event loop (d257669). Its build trees carry
#  no source stamp, so this flow rebuilds rather than recovers them. README.md.
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

# The ladder starts at the shipped frequency, read from ../pl_fixed/Makefile.
FMIN    ?= $(or $(shell awk -F'= *' '/^KERNEL_FREQ/{printf "%g", $$2/1e6; exit}' ../pl_fixed/Makefile 2>/dev/null),180)
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
             $(if $(YES),--yes,) $(if $(PRUNE),--prune,)

.PHONY: all help test dryrun mock smoke sweep report vars clean clean_all

all: help

############################################################################
#  1. Does the parser work?  (no tools, no builds)
############################################################################
# Against the shipped build's reports under ../pl_fixed/_x/<VARIANT>_<TARGET>/
# (180 MHz, linked 2026-08-20). The expected numbers were copied from the report
# text, so none of them is a number this parser produced.
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
	@$(PYTHON) sweep_freq.py $(SWEEP_ARGS) --out $(OUT)/_mock \
	   --root $(ROOT)/_mock --mock --check-isolation --fresh

mock_cliff:
	@MOCK_FMAX_MHZ=240 MOCK_CLIFF_MHZ=185 \
	  $(PYTHON) sweep_freq.py $(SWEEP_ARGS) --out $(OUT)/_mock \
	   --root $(ROOT)/_mock --mock --check-isolation --fresh

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
	@echo "  make sweep FMIN=180 FMAX=220    narrower grid"
	@echo "  make report                     read the last result"
	@echo ""
	@echo "  Builds are KEPT at $(ROOT)/f<MHz>/pl_fixed/ -- add PRUNE=1 to delete them."
	@echo ""
	@echo "  Run test, dryrun and mock first. Together they cost a minute."
	@echo "  Builds go to $(ROOT), never into this repo."
	@echo "  Results land in $(OUT)/ tagged by frequency."
	@echo ""
