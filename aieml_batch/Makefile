# ===================================================================
# Batched RTDA MLP on AIE-ML  --  self-contained
# ===================================================================
#
# The AIE graph, its kernels, its packed weights and its ADF testbench
# (app.cpp) are COMMITTED SOURCES in this directory. Building and simulating
# needs only Vitis -- no aie4ml, no ONNX, no Keras.
#
#   make graph      compile the graph for hw       (-> libadf.a)
#   make sim        aiesimulator + crosscheck + report
#   make x86        x86 compile + crosscheck       (fast, ~1 min)
#   make crosscheck compare vs numpy golden + the aieml/ reference
#   make report     II / ns-per-track of the last aie run
#   make help       everything else
#
# Regenerating the graph from ONNX is a separate, optional step that DOES need
# aie4ml -- see `make regen`. You only need it to change the topology, batch
# size, or precision. Day-to-day work never touches it.
#
# NOTE: variables are deliberately NOT named DATA_DIR / PLATFORM. ../set_envs.sh
# exports both, and make's `?=` inherits from the environment, which would
# silently point this build at data/ (int16!) and the 2024.2 platform.

SHELL := /bin/bash

# ==== CONFIG ====
BATCH        ?= 8
SOLVERS      ?= 3
INPUT_DIM    ?= 16
ITERS        ?= 7          # 7 x 8 = 56 slots >= 50 tracks

AIE_VITIS    ?= /tools/Xilinx/2025.2/Vitis
AIE_PLAT_NAME?= xilinx_vek280_base_202520_1
AIE_PLAT     ?= $(AIE_VITIS)/base_platforms/$(AIE_PLAT_NAME)/$(AIE_PLAT_NAME).xpfm
WEIGHTS_DIR  ?= $(CURDIR)/../data_fp32
# Needs numpy and nothing else. Deliberately the miniforge base interpreter,
# which has numpy but CANNOT import aie4ml -- so a green `make sim` is proof the
# runtime path is genuinely independent, not just believed to be.
PYTHON       ?= /home/synthara/miniforge3/bin/python
# Only `regen` and `verify_io` need this one (aie4ml + onnx + keras).
AIE4ML_PY    ?= /home/synthara/miniforge3/envs/envaie2/bin/python

# Extra aiesimulator flags. aieml/Makefile:116 always passes
#   --profile --dump-vcd=foo --output-time-stamp=no
# This project passes NONE by default -- VCD dumping is slow and the file grows
# with the iteration count, which bites on a 50-event run. Turn them on per-run:
#
#   make sim VCD=1              -> foo.vcd  (open in Vitis Analyzer)
#   make sim PROFILE=1          -> profile_funct_*.txt  (per-kernel cycles/duty)
#   make sim VCD=1 PROFILE=1
#   make sim AIESIM_ARGS="--dump-vcd=mine --profile"    (anything else)
#
# NOTE: --output-time-stamp=no is deliberately NOT included. aieml/ passes it,
# but report.py reads the `T <ns>` markers out of the PLIO output files to get
# the II, and that flag suppresses them -- `make report` would go blank.
VCD          ?=
PROFILE      ?=
AIESIM_ARGS  ?= $(if $(VCD),--dump-vcd=$(if $(filter 1,$(VCD)),foo,$(VCD)),) $(if $(PROFILE),--profile,)

APP          := app
LIBADF       := libadf.a
LIBADF_X86   := libadf_x86.a
WORK         := Work
WORK_X86     := Work_x86

export BATCH SOLVERS INPUT_DIM ITERS WEIGHTS_DIR
export RTDA_AIESIM_ARGS := $(strip $(AIESIM_ARGS))
export AIE_PLATFORM := $(AIE_PLAT_NAME)

SRCS       := $(APP).cpp aie.cfg $(shell find src -type f \( -name '*.h' -o -name '*.cpp' \) 2>/dev/null)
KERNEL_INC := $(shell test -d src/kernels && find src/kernels -type d -printf '--include=%p ')
AIE_INCLUDES = --include=src $(KERNEL_INC) $(shell test -d src/weights && echo --include=src/weights)

VPP = source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; v++ --compile --config aie.cfg --mode aie

.PHONY: all graph system_graph rtp compare x86com sim x86 crosscheck crosscheck_ref report analyze \
        x86_events sim_events golden regen verify_io ports vars clean clean_all help

.DEFAULT_GOAL := graph
all: graph

# --- compile ------------------------------------------------------------
graph: $(LIBADF)

$(LIBADF): $(SRCS)
	@$(VPP) --target=hw $(AIE_INCLUDES) --platform=$(AIE_PLAT) $(APP).cpp \
	      --aie.workdir=$(WORK) --aie.output-archive=$(LIBADF) 2>&1 | tee log
	@if grep -q "Compilation Failed" log; then \
	   echo; echo "*** BUILD FAILED ***"; \
	   grep -E "^ERROR: \[aiecompiler" log | sort -u | head -5; \
	   rm -f $(LIBADF); exit 1; fi

# System build: GMIO instead of PLIO, and main() becomes the host-side program
# that loads the weights, DMAs the tracks in and the event mean out. Driven from
# the top-level Makefile as `make system AIE_DIR=aieml_batch`.
system_graph:
	@echo ">>> aieml_batch: system build (SYSTEM_BUILD, GMIO, no PL)"
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; \
	  v++ --compile --config aie.cfg --mode aie --target=hw \
	      $(AIE_INCLUDES) --platform=$(AIE_PLAT) $(APP).cpp \
	      --aie.Xpreproc="-DSYSTEM_BUILD" \
	      --aie.workdir=$(WORK) --aie.output-archive=$(LIBADF) 2>&1 | tee log
	@if grep -q "Compilation Failed" log; then \
	   echo; echo "*** SYSTEM BUILD FAILED ***"; \
	   grep -E "^ERROR: \[aiecompiler" log | sort -u | head -5; \
	   rm -f $(LIBADF); exit 1; fi

x86com: $(LIBADF_X86)

$(LIBADF_X86): $(SRCS)
	@$(VPP) --target=x86sim $(AIE_INCLUDES) --platform=$(AIE_PLAT) $(APP).cpp \
	      --aie.workdir=$(WORK_X86) --aie.output-archive=$(LIBADF_X86) 2>&1 | tee log
	@if grep -q "Compilation Failed" log; then \
	   echo; echo "*** X86 BUILD FAILED ***"; rm -f $(LIBADF_X86); exit 1; fi

# --- simulate + check ---------------------------------------------------
# crosscheck writes the PLIO inputs, runs the simulator and compares, all
# through aie_io/run_sim. Plain `python3` is enough -- numpy only.
sim: graph
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; \
	  $(PYTHON) crosscheck.py --sim aie --batch $(BATCH) --solvers $(SOLVERS)
	@$(MAKE) --no-print-directory report

x86: x86com
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; \
	  $(PYTHON) crosscheck.py --sim x86 --batch $(BATCH) --solvers $(SOLVERS)

crosscheck: graph
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; \
	  $(PYTHON) crosscheck.py --sim aie --batch $(BATCH) --solvers $(SOLVERS)

crosscheck_ref:
	@$(PYTHON) crosscheck.py --skip-aie

# --- reference data ------------------------------------------------------
# Stimulus + streaming golden for TRACKS tracks, into ../testdata.
#
# Use this rather than `./make_golden.py`: ../set_envs.sh puts PetaLinux's python
# first on PATH, and that one has no numpy, so both `./make_golden.py` and
# `python make_golden.py` die with ModuleNotFoundError in a build shell. $(PYTHON)
# is pinned to an interpreter that has numpy.
#
#   make golden TRACKS=50000
TRACKS ?= 10000
golden:
	@$(PYTHON) make_golden.py --tracks $(TRACKS) --out ../testdata

# --- multi-event simulation ---------------------------------------------
# `make sim` / `make crosscheck` run exactly ONE event: the graph is compiled
# with N_ITER fixed at 7 and the 50-track reference is a single event. Event
# BOUNDARY behaviour (roll carry crossing events, accumulator reset) therefore
# goes untested -- and that is where the hardware reproducibility bug lived.
#
# EVENTS=N builds a second graph with N_ITER = ITERS*(N+1) (the +1 is the flush
# event, mirroring the host) into its OWN archive and workdir, so the
# single-event build and `make crosscheck` are left completely alone.
#
# FLUSH=1 (default) mirrors the host: one leading all-zero event, discarded.
# FLUSH=0 drops it -- exact in simulation, since a simulator is always cold, and
# 7 iterations cheaper, but then it no longer matches what runs on a board.
# The iteration count and the driver flag must agree, so both come from here.
EVENTS   ?= 2
FLUSH    ?= 1
EV_ITERS  = $(shell echo $$(( $(ITERS) * ($(EVENTS) + $(FLUSH)) )))
EV_OUT   ?= results/sim_events
# EV_TRACKS, not TRACKS: TRACKS belongs to `make golden` and has a default, and a
# defaulted variable in the $(if ...) below would silently force --tracks on every
# simulation run -- which is exactly the bug that made `make x86_events EVENTS=5`
# ask for 10000 tracks in a 5-event build. Leave EV_TRACKS unset to get EVENTS x 50.
EV_ARGS   = --events $(EVENTS) --out $(EV_OUT) $(if $(EV_TRACKS),--tracks $(EV_TRACKS),) \
            $(if $(filter 0,$(FLUSH)),--no-flush,)

x86_events:
	@echo ">>> x86 build: $(EVENTS) event(s) + 1 flush = $(EV_ITERS) iterations"
	@$(VPP) --target=x86sim $(AIE_INCLUDES) --platform=$(AIE_PLAT) $(APP).cpp \
	      --aie.Xpreproc="-DN_ITER_OVERRIDE=$(EV_ITERS)" \
	      --aie.workdir=Work_x86_ev$(EVENTS) \
	      --aie.output-archive=libadf_x86_ev$(EVENTS).a 2>&1 | tee log.x86_ev$(EVENTS)
	@if grep -q "Compilation Failed" log.x86_ev$(EVENTS); then \
	   echo; echo "*** BUILD FAILED ***"; \
	   grep -E "^ERROR: \[aiecompiler" log.x86_ev$(EVENTS) | sort -u | head -5; exit 1; fi
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; set -o pipefail; \
	  RTDA_N_ITER=$(EV_ITERS) $(PYTHON) sim_events.py --sim x86 $(EV_ARGS) \
	    2>&1 | tee -a log.x86_ev$(EVENTS)

# Cycle-accurate, and MUCH slower than x86 -- keep EVENTS small (2-3).
sim_events:
	@echo ">>> aie build: $(EVENTS) event(s) + 1 flush = $(EV_ITERS) iterations"
	@$(VPP) --target=hw $(AIE_INCLUDES) --platform=$(AIE_PLAT) $(APP).cpp \
	      --aie.Xpreproc="-DN_ITER_OVERRIDE=$(EV_ITERS)" \
	      --aie.workdir=Work_ev$(EVENTS) \
	      --aie.output-archive=libadf_ev$(EVENTS).a 2>&1 | tee log.aie_ev$(EVENTS)
	@if grep -q "Compilation Failed" log.aie_ev$(EVENTS); then \
	   echo; echo "*** BUILD FAILED ***"; \
	   grep -E "^ERROR: \[aiecompiler" log.aie_ev$(EVENTS) | sort -u | head -5; exit 1; fi
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; set -o pipefail; \
	  RTDA_N_ITER=$(EV_ITERS) $(PYTHON) sim_events.py --sim aie $(EV_ARGS) \
	    2>&1 | tee -a log.aie_ev$(EVENTS)

# Cross-check a hardware run's track_mean_128.txt against every reference.
# MEAN=<path> to point at a fresh run; defaults to the captured hw_emu result.
MEAN ?= results/hw_emu_track_mean_128.txt
compare:
	@$(PYTHON) compare_hw.py $(MEAN) --sim x86

report:
	@$(PYTHON) report.py --batch $(BATCH) --iters $(ITERS)

ports:
	@$(PYTHON) run_sim.py ports

analyze:
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; \
	  vitis_analyzer aiesimulator_output/default.aierun_summary

# --- optional: regenerate the graph from ONNX (needs aie4ml) -------------
regen:
	@echo "Regenerating src/ from ONNX via aie4ml -- this OVERWRITES committed sources."
	@echo "  BATCH=$(BATCH) SOLVERS=$(SOLVERS) INPUT_DIM=$(INPUT_DIM) ITERS=$(ITERS)"
	@$(AIE4ML_PY) gen_graph.py --batch $(BATCH) --solvers $(SOLVERS) gen
	@echo
	@echo "Now run 'make verify_io' to confirm aie_io still matches, then rebuild."

verify_io:
	@$(AIE4ML_PY) verify_io.py

# Dump the 92 RTP payloads (~1 MB) for the XRT host. Port names are read from
# Work/ps/c_rts/aie_control_config.json, so `make system_graph` must run first.
rtp: sysdata/rtp_manifest.txt

sysdata/rtp_manifest.txt: $(wildcard src/weights/*.h) extract_rtp.py
	@test -f Work/ps/c_rts/aie_control_config.json || { \
	   echo "ERROR: Work/ps/c_rts/aie_control_config.json missing - run 'make system_graph' first"; exit 1; }
	@$(PYTHON) extract_rtp.py

# --- utilities ----------------------------------------------------------
vars:
	@echo "BATCH        = $(BATCH)   (tracks per graph iteration)"
	@echo "SOLVERS      = $(SOLVERS)"
	@echo "ITERS        = $(ITERS)   (must equal N_ITER in src/parameters.h)"
	@echo "INPUT_DIM    = $(INPUT_DIM)   (16 keeps buffer_x contiguous)"
	@echo "WEIGHTS_DIR  = $(WEIGHTS_DIR)"
	@echo "AIE_PLAT     = $(AIE_PLAT)"
	@echo "PYTHON       = $(PYTHON)"
	@echo "               numpy: $(shell $(PYTHON) -c 'import numpy;print(numpy.__version__)' 2>/dev/null || echo MISSING)   aie4ml: $(shell $(PYTHON) -c 'import aie4ml' 2>/dev/null && echo present || echo absent-by-design)"
	@echo "AIE4ML_PY    = $(AIE4ML_PY)   (regen / verify_io only)"
	@echo "N_ITER in src/parameters.h = $(shell grep -h '^#define N_ITER' src/parameters.h 2>/dev/null | awk '{print $$3}')"

clean:
	rm -rf $(WORK) $(WORK_X86) $(LIBADF) $(LIBADF_X86) log log.* .Xil .crashReporter
	rm -rf Work_ev* Work_x86_ev* libadf_ev*.a libadf_x86_ev*.a
	rm -rf aiesimulator_output* x86simulator_output* aiesimulator*.log x86simulator*.log
	rm -rf Map_Report.csv sol.db diag_report.log *.vcd trdata.aiesim pl_sample_count*
	rm -rf qemu_rp.log temp .AIE_SIM_CMD_LINE_OPTIONS .io_check_* data
	rm -f stamp_*.marker .gen.*.stamp

# NOTE: does NOT remove src/, app.cpp, aie.cfg or aie_pipeline.json -- those are
# committed sources now, not build products. Use `make regen` to rebuild them.
clean_all: clean
	rm -rf throughput_info.json AIECompiler.log AIESimulator.log

help:
	@echo "Batched RTDA MLP on AIE-ML -- self-contained (aie::mmul, batch $(BATCH))"
	@echo
	@echo "  make graph              compile for hw"
	@echo "  make sim                aiesimulator + crosscheck + report"
	@echo "  make x86                x86 compile + crosscheck (fast)"
	@echo "  make crosscheck         vs numpy golden + data_fp32 reference"
	@echo "  make crosscheck_ref     validate the reference file only, no build"
	@echo "  make x86_events EVENTS=N   simulate N events (x86), dump results to $(EV_OUT)"
	@echo "  make sim_events EVENTS=N   same on aiesimulator (cycle-accurate, slow)"
	@echo "                             knobs: EVENTS FLUSH TRACKS EV_OUT"
	@echo "  make compare MEAN=x.txt compare a hardware run vs all references"
	@echo "  make report             II and ns/track of the last aie run"
	@echo "  make ports              show the PLIO layout"
	@echo "  make sim VCD=1          also dump foo.vcd  (aieml/ does this by default)"
	@echo "  make sim PROFILE=1      also dump profile_funct_*.txt (per-kernel cycles)"
	@echo "  make analyze            open Vitis Analyzer"
	@echo "  make vars / clean / clean_all"
	@echo
	@echo "  make system_graph       GMIO build for the full system (no PL)"
	@echo "  make rtp                dump the 92 RTP payloads for the XRT host"
	@echo "  make regen              regenerate src/ from ONNX  (needs aie4ml)"
	@echo "  make verify_io          prove aie_io still matches aie4ml (needs aie4ml)"
	@echo
	@echo "Knobs: BATCH SOLVERS ITERS INPUT_DIM WEIGHTS_DIR AIE_VITIS PYTHON"
	@echo
	@echo "Measured (full 14-layer model, float32, leaky ReLU 0.1, Vitis 2025.2):"
	@echo "  BATCH=8   II 4161 ns / iteration -> 520.1 ns per SLOT"
	@echo "            7 iterations per 50-track event -> 582.6 ns per REAL track"
	@echo "            vs aieml/ 17,770 ns/track = 30.5x"
	@echo "  silicon   595.6 ns/track marginal (2.2% off the model), 803 GOP/s at 10k"
	@echo "  matches data_fp32/aieml10_output_aie.txt to 4.0e-06 (tracks 3..49)"
	@echo
	@echo "Why 8: the float32 aie::mmul microtile is M=4 and the batch axis pads"
	@echo "to 2*M = 8. Fewer wastes M lanes; more just issues more full instructions."
	@echo
	@echo "See README.md for the philosophy, ../GEMM_FEASIBILITY.md for the study."
