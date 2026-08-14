############################################################################
#  RTDA -- top-level dispatcher
#
#  Two implementations of the same 14-dense-layer track-alignment MLP live
#  here. Each owns its complete build; this file only routes to it, so that
#  one command vocabulary works for both.
#
#      FLOW=aie_batch   AIE-ML, aie::mmul, 8 tracks per iteration
#                       PRECISION=fp32|bf16
#      FLOW=pl_fixed    PL only, HLS, ap_fixed, no AIE
#                       AP_W / AP_I set the fixed-point format
#
#  Shared, flow-independent:
#      model/      the pinned ONNX, the fp32 weights, the ONE numpy reference
#      testdata/   stimulus + goldens        (make golden)
#      results/    every run's output, per implementation
#      analysis/   the notebooks that compare them
#
#  Quick start:
#      source set_envs.sh
#      make golden TRACKS=50000            # stimulus + reference, once
#      make fastsim FLOW=aie_batch PRECISION=fp32 EVENTS=5
#      make fastsim FLOW=pl_fixed  EVENTS=5
#      make system FLOW=aie_batch PRECISION=bf16 TARGET=hw
#      make help
############################################################################

FLOW      ?= aie_batch
TARGET    ?= hw_emu
PRECISION ?= fp32
EVENTS    ?= 5
TRACKS    ?= 50000

# The reference self-test needs numpy + onnx + onnxruntime. Pinned, and not
# `python3`: set_envs.sh puts PetaLinux's numpy-less interpreter first on PATH,
# so `python model/rtda_ref.py` in a build shell dies with ModuleNotFoundError.
# Every python entry point in this repo goes through a make target for exactly
# this reason.
REF_PY ?= /home/synthara/miniforge3/envs/envaie2/bin/python

VALID_FLOWS := aie_batch pl_fixed
ifeq ($(filter $(FLOW),$(VALID_FLOWS)),)
  $(error FLOW=$(FLOW) is not one of: $(VALID_FLOWS))
endif

# Only aie_batch has a precision axis; passing PRECISION to pl_fixed is a
# no-op rather than an error, so the same command line works for both.
FLOW_ARGS = TARGET=$(TARGET) PRECISION=$(PRECISION)

.PHONY: help golden selftest fastsim exactsim system run link package repackage \
        report crosscheck clean clean_all vars notebooks

############################################################################
#  Shared, flow-independent
############################################################################

# Stimulus + streaming golden for TRACKS tracks -> testdata/.
# Owned by aie_batch because that is where make_golden.py lives; both flows
# and both notebooks read the result.
golden:
	@$(MAKE) -C aie_batch golden TRACKS=$(TRACKS)

# Does the reference model still agree with the pinned ONNX, and does it still
# reproduce the committed goldens? Everything else is measured against this, so
# it is the first thing to run and the first thing to suspect.
selftest:
	@$(REF_PY) model/rtda_ref.py --self-test
	@for g in testdata/golden_*.npz; do \
	    [ -e "$$g" ] && $(REF_PY) model/rtda_ref.py --check-golden $$g; \
	 done; true
	@$(MAKE) --no-print-directory -C pl_fixed check_weights

############################################################################
#  Per-flow -- everything below just forwards
############################################################################

# Functional simulation of EVENTS events -- minutes.
#   aie_batch -> x86simulator      pl_fixed -> the native ap_fixed model
fastsim:
	@$(MAKE) -C $(FLOW) fastsim EVENTS=$(EVENTS) $(FLOW_ARGS)

# Cycle- / RTL-accurate, and much slower. Keep EVENTS small.
#   aie_batch -> aiesimulator      pl_fixed -> RTL co-simulation
exactsim:
	@$(MAKE) -C $(FLOW) exactsim EVENTS=$(EVENTS) $(FLOW_ARGS)

# Full system: xclbin + SD image.
system:
	@$(MAKE) -C $(FLOW) system $(FLOW_ARGS)

run:
	@$(MAKE) -C $(FLOW) run $(FLOW_ARGS)

link package repackage report crosscheck:
	@$(MAKE) -C $(FLOW) $@ $(FLOW_ARGS)

clean:
	@$(MAKE) -C $(FLOW) clean $(FLOW_ARGS)

# Every flow, plus the top-level leftovers a v++ run drops here.
clean_all:
	@$(MAKE) -C aie_batch clean_all
	@$(MAKE) -C pl_fixed  clean_all
	@rm -rf _x .Xil _ide *.xclbin *.xsa *.log emconfig.json

vars:
	@echo "FLOW      = $(FLOW)"
	@echo "TARGET    = $(TARGET)"
	@echo "PRECISION = $(PRECISION)   (aie_batch only)"
	@echo "EVENTS    = $(EVENTS)"
	@echo "TRACKS    = $(TRACKS)      (make golden)"
	@echo
	@$(MAKE) --no-print-directory -C $(FLOW) vars $(FLOW_ARGS)

############################################################################
help:
	@echo ""
	@echo "RTDA -- one network, two implementations"
	@echo "========================================"
	@echo ""
	@echo "  FLOW=aie_batch  AIE-ML aie::mmul, 8 tracks/iteration, PRECISION=fp32|bf16"
	@echo "  FLOW=pl_fixed   PL-only HLS, ap_fixed, no AIE"
	@echo ""
	@echo "Shared:"
	@echo "  make golden TRACKS=50000                stimulus + streaming golden -> testdata/"
	@echo "  make selftest                           reference vs ONNX, goldens, PL weights"
	@echo ""
	@echo "Per flow (add FLOW=... ; defaults shown):"
	@echo "  make fastsim  FLOW=aie_batch PRECISION=fp32 EVENTS=5"
	@echo "                                          functional sim, minutes"
	@echo "  make exactsim FLOW=aie_batch PRECISION=fp32 EVENTS=5"
	@echo "                                          cycle-/RTL-accurate, slow"
	@echo "  make system FLOW=aie_batch PRECISION=bf16 TARGET=hw"
	@echo "                                          xclbin + SD image"
	@echo "  make run    FLOW=pl_fixed  TARGET=hw_emu"
	@echo "                                          build and launch on QEMU"
	@echo ""
	@echo "Analysis:"
	@echo "  jupyter lab analysis/rtda_reference.ipynb   then  analysis/rtda_compare.ipynb"
	@echo ""
	@echo "Utilities:"
	@echo "  make vars FLOW=...      show every resolved variable"
	@echo "  make clean FLOW=...     clean one flow"
	@echo "  make clean_all          clean everything"
	@echo ""
	@echo "Full step-by-step: RUNBOOK.md.  Design and numbers: README.md."
	@echo ""
############################################################################
