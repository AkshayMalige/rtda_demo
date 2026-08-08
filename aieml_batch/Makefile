# ===================================================================
# Batched RTDA MLP on AIE-ML  --  generate / compile / simulate
# ===================================================================
#
# Unlike aieml/, the graph here is not hand-written: gen_graph.py builds an
# ONNX model from the exported weights and aie4ml lowers every Gemm to an
# aie::mmul kernel, emitting a normal Vitis AIE project (app.cpp, aie.cfg,
# src/). So the flow gains one step up front:   gen -> graph -> sim
#
#   make gen        emit the AIE project sources
#   make graph      compile for hw (aiesimulator / v++ link)
#   make sim        cycle-accurate aiesimulator + verify + report
#   make x86sim     fast functional check vs a Keras reference (seconds)
#   make report     interval / throughput of the last aie run
#   make help       full usage
#
# BATCH is the number of tracks processed per graph iteration. See README.md --
# 8 is the sweet spot, and BATCH=4 costs exactly the same wall time as BATCH=8.
#
# NOTE: variables below are deliberately NOT named DATA_DIR / PLATFORM. Those
# are exported by ../set_envs.sh, and make's `?=` inherits from the environment,
# which would silently point this build at data/ (int16!) and the 2024.2
# platform. The names here cannot collide.

SHELL := /bin/bash

# ==== CONFIG ====
BATCH        ?= 8
SOLVERS      ?= 1
INPUT_DIM    ?= 16
ITERS        ?= 10

# aie4ml + onnx + keras all live in envaie2; envaie has no onnx.
AIE4ML_PY    ?= /home/synthara/miniforge3/envs/envaie2/bin/python
# aie4ml's generated projects target 2025.2; the repo's own aieml/ flow is 2024.2.
AIE_VITIS    ?= /tools/Xilinx/2025.2/Vitis
AIE_PLAT_NAME?= xilinx_vek280_base_202520_1
AIE_PLAT     := $(AIE_VITIS)/base_platforms/$(AIE_PLAT_NAME)/$(AIE_PLAT_NAME).xpfm
# float32 weights. NOT ../data, which is swapped to int16 by hand.
WEIGHTS_DIR  ?= $(CURDIR)/../data_fp32

APP          := app
LIBADF       := libadf.a
LIBADF_X86   := libadf_x86.a
WORK         := Work
WORK_X86     := Work_x86
GEN_STAMP    := .gen.$(BATCH).$(SOLVERS).$(INPUT_DIM).stamp

# gen_graph.py reads these from the environment
export BATCH SOLVERS INPUT_DIM ITERS
export WEIGHTS_DIR
export AIE_PLATFORM := $(AIE_PLAT_NAME)

PY := $(AIE4ML_PY) gen_graph.py --batch $(BATCH) --solvers $(SOLVERS)

AIE_INCLUDES = --include=src \
  $(shell test -d src/kernels && find src/kernels -type d -printf '--include=%p ') \
  $(shell test -d src/weights && echo --include=src/weights)

# aie4ml's model.predict()/build() shell out to `make <target>` inside THIS
# directory (simulation.py:481, model.py:90) using the target names all, x86com,
# x86sim and aiesim. Those four are therefore reserved: they delegate verbatim to
# the Makefile aie4ml generated. The user-facing flow uses distinct names
# (gen / graph / sim / sim_x86) so the two never collide.
AIE4ML_MK := Makefile.aie4ml

.PHONY: all x86com x86sim aiesim compile
all compile x86com x86sim aiesim:
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; $(MAKE) -f $(AIE4ML_MK) $@

.PHONY: help gen graph sim sim_x86 report crosscheck crosscheck_ref analyze vars clean clean_all

.DEFAULT_GOAL := graph

# --- generation ---------------------------------------------------------
gen: $(GEN_STAMP)

$(GEN_STAMP): gen_graph.py
	@test -d "$(WEIGHTS_DIR)" || { echo "ERROR: WEIGHTS_DIR=$(WEIGHTS_DIR) not found"; exit 1; }
	$(PY) gen
	@rm -f .gen.*.stamp && touch $@

# --- compile ------------------------------------------------------------
graph: $(LIBADF)

$(LIBADF): $(GEN_STAMP)
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; \
	  v++ --compile --config aie.cfg --mode aie --target=hw \
	      $(AIE_INCLUDES) --platform=$(AIE_PLAT) $(APP).cpp \
	      --aie.workdir=$(WORK) --aie.output-archive=$(LIBADF) 2>&1 | tee log
	@if grep -q "Compilation Failed" log; then \
	   echo; echo "*** BUILD FAILED ***"; \
	   grep -E "^ERROR: \[aiecompiler" log | sort -u | head -5; \
	   rm -f $(LIBADF); exit 1; fi

# --- simulate -----------------------------------------------------------
# Both sim targets drive the simulator through aie4ml so the outputs are
# checked against a Keras reference rather than eyeballed.
sim: graph
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; $(PY) verify --sim aie
	@$(MAKE) --no-print-directory report

sim_x86: $(LIBADF_X86)
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; $(PY) verify --sim x86

$(LIBADF_X86): $(GEN_STAMP)
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; $(MAKE) -f $(AIE4ML_MK) x86com

report:
	@$(PY) report

# Three-way check on the real 50-track stimulus:
#   numpy golden vs data_fp32/aieml10_output_aie.txt   (validates the reference)
#   numpy golden vs this graph's AIE simulation        (validates the new design)
# Tracks 0-2 are excluded: roll_concat's zero-initialised history plus a 4-track
# receptive field contaminates them (WARMUP = 3).
crosscheck: graph
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; \
	  $(AIE4ML_PY) crosscheck.py --sim aie --batch $(BATCH) --solvers $(SOLVERS)

crosscheck_ref:
	@$(AIE4ML_PY) crosscheck.py --skip-aie

analyze:
	@source $(AIE_VITIS)/settings64.sh >/dev/null 2>&1; \
	  vitis_analyzer aiesimulator_output/default.aierun_summary

# --- utilities ----------------------------------------------------------
vars:
	@echo "BATCH         = $(BATCH)   (tracks per graph iteration)"
	@echo "SOLVERS       = $(SOLVERS)"
	@echo "INPUT_DIM     = $(INPUT_DIM)   (16 keeps buffer_x contiguous)"
	@echo "ITERS         = $(ITERS)"
	@echo "WEIGHTS_DIR   = $(WEIGHTS_DIR)"
	@echo "AIE_PLAT      = $(AIE_PLAT)"
	@echo "AIE_VITIS     = $(AIE_VITIS)"
	@echo "AIE4ML_PY     = $(AIE4ML_PY)"

clean:
	rm -rf $(WORK) $(WORK_X86) $(LIBADF) $(LIBADF_X86) log log.* .Xil .crashReporter
	rm -rf aiesimulator_output* x86simulator_output* aiesimulator*.log x86simulator*.log
	rm -rf Map_Report.csv sol.db diag_report.log *.vcd trdata.aiesim pl_sample_count*
	rm -rf qemu_rp.log temp .AIE_SIM_CMD_LINE_OPTIONS
	rm -f .gen.*.stamp stamp_*.marker

clean_all: clean
	rm -rf src app.cpp aie.cfg Makefile.aie4ml aie_pipeline.json data throughput_info.json

help:
	@echo "Batched RTDA MLP on AIE-ML (aie4ml -> aie::mmul)"
	@echo
	@echo "  make gen      BATCH=8   generate AIE project sources from data_fp32/"
	@echo "  make graph    BATCH=8   compile for hw"
	@echo "  make sim      BATCH=8   aiesimulator + verify + report"
	@echo "  (all/x86com/x86sim/aiesim are reserved for aie4ml -- do not rename)"
	@echo "  make sim_x86  BATCH=8   fast functional check (seconds)"
	@echo "  make report   BATCH=8   II and ns/track of the last aie run"
	@echo "  make crosscheck         vs numpy golden + data_fp32 reference (skips warm-up tracks 0-2)"
	@echo "  make crosscheck_ref     validate the reference file only, no build"
	@echo "  make analyze            open Vitis Analyzer"
	@echo "  make vars               show resolved settings"
	@echo "  make clean / clean_all"
	@echo
	@echo "Knobs: BATCH SOLVERS INPUT_DIM ITERS WEIGHTS_DIR AIE4ML_PY AIE_VITIS"
	@echo
	@echo "Measured (embed + solver-0, float32, Vitis 2025.2):"
	@echo "  BATCH=4    II 3726.4 ns -> 931.6 ns/track   same II as 8, half of it wasted"
	@echo "  BATCH=8    II 3726.4 ns -> 465.8 ns/track   sweet spot"
	@echo "  BATCH=16   II 7405.6 ns -> 462.9 ns/track   only 0.6% better"
	@echo "  BATCH=32/56 do not build (chess-backend spill-size bug)"
	@echo
	@echo "Why 8: the float32 aie::mmul microtile is M=4, and aie4ml pads the"
	@echo "batch axis to 2*M = 8. Fewer than 8 tracks leaves M lanes computing"
	@echo "padding; more than 8 just issues more already-full instructions."
	@echo
	@echo "See README.md for the philosophy, GEMM_FEASIBILITY.md for the study."
