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

# cpu is not a build: it is the same network through model/rtda_ref.py on the
# host, so the accelerators have something other than each other to be
# compared against. It needs neither XRT nor Vitis.
VALID_FLOWS := aie_batch pl_fixed cpu
ifeq ($(filter $(FLOW),$(VALID_FLOWS)),)
  $(error FLOW=$(FLOW) is not one of: $(VALID_FLOWS))
endif

# Only aie_batch has a precision axis; passing PRECISION to pl_fixed is a
# no-op rather than an error, so the same command line works for both.
FLOW_ARGS = TARGET=$(TARGET) PRECISION=$(PRECISION)

.PHONY: help golden stimulus selftest fastsim exactsim system run link package repackage \
        report crosscheck clean clean_all vars notebooks collect results check_image \
        scan_host collect_scan

############################################################################
#  Shared, flow-independent
############################################################################

# Stimulus + streaming golden for TRACKS tracks -> testdata/.
# Owned by aie_batch because that is where make_golden.py lives; both flows
# and both notebooks read the result.
golden:
	@$(MAKE) -C aie_batch golden TRACKS=$(TRACKS)

# Stimulus only, no golden -- for the performance scan, which is timing-only.
# Re-checks the seeded prefix chain against every stimulus that still has a
# golden, so those goldens keep describing the first N events of the bigger file.
#
#   make stimulus TRACKS=500000        # 10,000 events, ~65 MB
stimulus:
	@$(MAKE) -C aie_batch stimulus TRACKS=$(TRACKS)

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
#  Results
#
#  Simulation files itself under results/<impl>/sim/. A board or hw_emu run
#  cannot: the host writes into whatever directory it ran in, on the board, so
#  the files have to be carried back by hand.
#
#  Which directory they belong in is NOT recoverable from the files -- an fp32
#  run dropped into results/aie_bf16/hw/ yields a perfectly plausible table in
#  which bf16 looks as accurate as fp32. Hence this target rather than `cp`.
#
#      make collect FROM=/mnt/usb FLOW=aie_batch PRECISION=fp32 TARGET=hw
#      make collect FROM=/mnt/usb FLOW=pl_fixed  TARGET=hw
############################################################################
FROM ?=
ifeq ($(FLOW),aie_batch)
  IMPL := aie_$(PRECISION)
else
  IMPL := $(FLOW)
endif
# The CPU flow has no hw/hw_emu axis -- it lands in results/cpu/native/.
ifeq ($(FLOW),cpu)
  RESULT_DIR := results/cpu/native
else
  RESULT_DIR := results/$(IMPL)/$(TARGET)
endif
RESULT_FILES := track_means_all.txt track_out_27.txt run_info.txt

# Does the packaged image actually contain what the host will open?
#
# A rename on the Makefile side that the host never learned about produced an
# image that aborted on the board after a multi-hour build. Everything about
# that was checkable here in under a second; nothing checked it.
IMG := $(if $(filter pl_fixed,$(FLOW)),pl_fixed/package/ap$(if $(AP_W),$(AP_W),16)_$(if $(AP_I),$(AP_I),3)_$(TARGET),aie_batch/package/$(PRECISION)_$(TARGET))/sd_card.img
check_image:
	@tools/check_image.sh $(IMG) $(FLOW) $(if $(filter pl_fixed,$(FLOW)),-,$(PRECISION)) $(TARGET)

############################################################################
#  The performance scan
#
#  A separate host per flow, a separate pair of output files, and a separate
#  collect target -- deliberately. A timing run writes no track_means_all.txt and
#  no run_info.txt, so it cannot be filed as a result run and cannot be mistaken
#  for one later. `make collect` and `make collect_scan` therefore look for
#  different files and refuse each other's.
#
#      make scan_host FLOW=aie_batch          # seconds; no xclbin rebuild
#      make scan_host FLOW=pl_fixed
#      make collect_scan FROM=/mnt/usb FLOW=pl_fixed TARGET=hw
############################################################################
SCAN_FILES := scan.csv scan_meta.txt

# Builds host_scan.exe only. It talks to the xclbin already on the card, so this
# needs no graph, no HLS, no link and no package.
scan_host:
	@$(MAKE) -C $(FLOW) scan_host $(FLOW_ARGS)

collect_scan:
	@test -n "$(FROM)" || { echo "ERROR: FROM=<dir> is required, e.g."; \
	  echo "  make collect_scan FROM=/mnt/usb FLOW=aie_batch PRECISION=bf16 TARGET=hw"; exit 1; }
	@test "$(TARGET)" = hw -o "$(TARGET)" = hw_emu || { \
	  echo "ERROR: TARGET must be hw or hw_emu (got '$(TARGET)')"; exit 1; }
	@for f in $(SCAN_FILES); do \
	   test -s "$(FROM)/$$f" || { echo "ERROR: $(FROM)/$$f missing or empty."; \
	     echo "       Both of $(SCAN_FILES) must be present: scan.csv without its"; \
	     echo "       meta has no xclbin, no revision and no one-time costs, which"; \
	     echo "       makes the numbers in it unattributable."; exit 1; }; \
	 done
	@mkdir -p $(RESULT_DIR)
	@cp $(addprefix $(FROM)/,$(SCAN_FILES)) $(RESULT_DIR)/
	@for f in $(FROM)/scan_calls_*.csv; do \
	   [ -e "$$f" ] && cp "$$f" $(RESULT_DIR)/ || true; done
	@echo ">>> $(FROM)  ->  $(RESULT_DIR)/"
	@cd $(RESULT_DIR) && printf '    %-22s %8s bytes  %s measured rows\n' \
	   scan.csv $$(stat -c %s scan.csv) $$(($$(wc -l < scan.csv) - 1)) && \
	 printf '    %-22s %8s bytes\n' scan_meta.txt $$(stat -c %s scan_meta.txt)
	@echo "    scan_meta says:"
	@sed -n 's/^/      /p' $(RESULT_DIR)/scan_meta.txt | head -8
	@echo
	@echo "    A scan.csv whose impl does not match $(IMPL) is in the wrong"
	@echo "    directory -- the notebook trusts the path, not the file."
	@awk -F, 'NR==2 {print "    impl in file: " $$1 "   destination: $(IMPL)"}' \
	    $(RESULT_DIR)/scan.csv

collect:
	@test -n "$(FROM)" || { echo "ERROR: FROM=<dir> is required, e.g."; \
	  echo "  make collect FROM=/mnt/usb FLOW=aie_batch PRECISION=fp32 TARGET=hw"; exit 1; }
	@test "$(TARGET)" = hw -o "$(TARGET)" = hw_emu || { \
	  echo "ERROR: TARGET must be hw or hw_emu (got '$(TARGET)')"; exit 1; }
	@for f in $(RESULT_FILES); do \
	   test -s "$(FROM)/$$f" || { echo "ERROR: $(FROM)/$$f missing or empty."; \
	     echo "       All of $(RESULT_FILES) must be present -- a partial copy is"; \
	     echo "       how a truncated run gets mistaken for a good one."; exit 1; }; \
	 done
	@mkdir -p $(RESULT_DIR)
	@cp $(addprefix $(FROM)/,$(RESULT_FILES)) $(RESULT_DIR)/
	@echo ">>> $(FROM)  ->  $(RESULT_DIR)/"
	@cd $(RESULT_DIR) && for f in $(RESULT_FILES); do \
	   printf '    %-22s %8s bytes\n' $$f $$(stat -c %s $$f); done
	@echo "    run_info says:"
	@sed -n 's/^/      /p' $(RESULT_DIR)/run_info.txt | head -8

# Everything currently on disk, so a missing or misfiled run is visible.
results:
	@for d in results/*/; do \
	   impl=$$(basename $$d); \
	   for t in sim hw_emu hw; do \
	     if [ -f "$$d$$t/run_info.txt" ]; then \
	       ev=$$(sed -n 's/^events=//p' $$d$$t/run_info.txt); \
	       wu=$$(sed -n 's/^warmup=//p' $$d$$t/run_info.txt); \
	       src=$$(sed -n 's/^source=//p' $$d$$t/run_info.txt); \
	       printf '  %-12s %-7s %6s events  warmup=%-6s %s\n' "$$impl" "$$t" "$$ev" "$${wu:-0 (implied)}" "$$src"; \
	     elif ls $$d$$t/*.npz >/dev/null 2>&1; then \
	       for n in $$d$$t/*.npz; do printf '  %-12s %-7s %s\n' "$$impl" "$$t" "$$(basename $$n)"; done; \
	     fi; \
	   done; \
	 done
	@echo
	@echo "  (simulation is written automatically; hw/hw_emu must be copied --"
	@echo "   see 'Where results go' in RUNBOOK.md, or use 'make collect')"

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
	@echo "Performance scan (timing only; needs no xclbin rebuild):"
	@echo "  make stimulus TRACKS=500000              10,000 events of stimulus, no golden"
	@echo "  make scan_host FLOW=aie_batch            build host_scan.exe (seconds)"
	@echo "  make scan_host FLOW=pl_fixed"
	@echo "  make collect_scan FROM=/mnt/usb FLOW=... TARGET=hw"
	@echo "                                          file scan.csv + scan_meta.txt"
	@echo "  jupyter lab analysis/rtda_scan.ipynb        the plots and the report"
	@echo ""
	@echo "Results:"
	@echo "  make check_image FLOW=... PRECISION=... TARGET=hw"
	@echo "                                          verify an SD image before flashing"
	@echo "  make results                            what is on disk right now"
	@echo "  make collect FROM=/mnt/usb FLOW=... TARGET=hw"
	@echo "                                          file a board run (sim self-files)"
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
