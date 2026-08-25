############################################################################
#  The GPU baseline.
#
#  The same network as aie_batch, pl_fixed and cpu, on an NVIDIA card, so the
#  comparison has a fourth point. The GPU is usually on ANOTHER MACHINE, so
#  this flow is built to travel:
#
#      make -C gpu tarball        a ~3.4 MB self-contained bundle
#      make -C gpu check          numerics (works with CPU-only torch)
#      make -C gpu scan_host      the 1..10000 event sweep, needs a GPU
#
#  On the GPU server nothing from this repo is needed except the bundle --
#  no XRT, no Vitis, no CUDA toolkit, no nvcc. Just a CUDA build of torch.
############################################################################

SHELL := /bin/bash

# NOT the absolute miniforge path cpu/Makefile pins: this flow runs on a
# machine that does not have it. RTDA_PYTHON overrides.
PYTHON     ?= $(shell command -v python3 2>/dev/null || echo python)

REPO       := $(CURDIR)/..
RESULTS    := $(REPO)/results/gpu/native
SCAN       := $(CURDIR)/scan_gpu.py
MODEL      := $(CURDIR)/rtda_torch.py

GPU        ?= 3
EVENTS     ?= 40
WARMUP     ?= 3
SCAN_REPS  ?= 5
SCAN_EVENTS?= 1,10,100,1000,10000
VARIANTS   ?= fp32,bf16,tf32
MODES      ?= single,fresh,graph

TARBALL    ?= $(CURDIR)/rtda_gpu.tar.gz
STAGE      := $(CURDIR)/.pkg/rtda_gpu

.PHONY: all check fastsim selftest scan_host scan tarball vars clean clean_all help

all: help

# --------------------------------------------------------------------------
#  Numerics. Run this before believing any timing.
# --------------------------------------------------------------------------
#  Stage 1 (float64 on CPU vs model/rtda_ref.py, expect ~1e-15) needs no GPU
#  and no CUDA -- it runs against a CPU-only torch wheel, which is how the
#  transcription is proven before the bundle ever leaves this machine.
selftest:
	@$(PYTHON) $(MODEL) --self-test --device cpu --dtype fp64 --events $(EVENTS)

check fastsim:
	@$(PYTHON) $(SCAN) --check --check-events $(EVENTS) --gpu $(GPU) \
	    --warmup $(WARMUP) --variants $(VARIANTS)

# --------------------------------------------------------------------------
#  The sweep. Writes results/gpu/native/{scan.csv,scan_meta.txt}.
# --------------------------------------------------------------------------
scan_host scan:
	@mkdir -p $(RESULTS)
	@$(PYTHON) $(SCAN) --outdir $(RESULTS) --gpu $(GPU) \
	    --events $(SCAN_EVENTS) --reps $(SCAN_REPS) \
	    --variants $(VARIANTS) --modes $(MODES) --warmup $(WARMUP)

# --------------------------------------------------------------------------
#  The bundle
# --------------------------------------------------------------------------
#  Exactly what model/weights.py:load() reads, plus embed_input.txt, which
#  synth_tracks() derives the stimulus from -- it must be byte-identical or the
#  regenerated stimulus fails its sha256 check. The 63 MB stimulus itself is
#  NOT shipped: synth_tracks(seed=1234) reproduces it in ~2 s and scan_gpu.py
#  verifies the digest.
tarball: $(MODEL) $(SCAN)
	@rm -rf $(STAGE)
	@mkdir -p $(STAGE)/model/weights_fp32 $(STAGE)/gpu
	@cp $(REPO)/model/__init__.py $(REPO)/model/weights.py \
	    $(REPO)/model/rtda_ref.py $(STAGE)/model/
	@cd $(REPO)/model/weights_fp32 && cp \
	    embed_dense_0_weights.txt embed_dense_0_bias.txt \
	    embed_dense_1_weights_part0.txt embed_dense_1_weights_part1.txt \
	    embed_dense_1_bias.txt output_weights.txt output_bias.txt \
	    embed_input.txt \
	    solver_{0,1,2}_dense_0_weights_part{0,1,2,3}.txt \
	    solver_{0,1,2}_dense_0_bias.txt \
	    solver_{0,1,2}_dense_{1,2,3}_weights_part{0,1}.txt \
	    solver_{0,1,2}_dense_{1,2,3}_bias.txt \
	    $(STAGE)/model/weights_fp32/
	@cp $(MODEL) $(SCAN) $(STAGE)/gpu/
	@cp $(CURDIR)/BUNDLE.md $(STAGE)/README.md
	@printf 'source_git_hash=%s\nbuilt=%s\nhost=%s\n' \
	    "$$(git -C $(REPO) rev-parse --short HEAD 2>/dev/null || echo unknown)" \
	    "$$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$$(hostname)" > $(STAGE)/PROVENANCE.txt
	@tar czf $(TARBALL) -C $(CURDIR)/.pkg rtda_gpu
	@rm -rf $(CURDIR)/.pkg
	@echo ">>> $(TARBALL)  ($$(du -h $(TARBALL) | cut -f1))"
	@echo "    scp it to the GPU server, then follow README.md inside."

vars:
	@echo "PYTHON      = $(PYTHON)"
	@echo "RESULTS     = $(RESULTS)"
	@echo "GPU         = $(GPU)"
	@echo "VARIANTS    = $(VARIANTS)"
	@echo "MODES       = $(MODES)"
	@echo "SCAN_EVENTS = $(SCAN_EVENTS)"
	@echo "SCAN_REPS   = $(SCAN_REPS)"
	@echo "TARBALL     = $(TARBALL)"

clean:
	@rm -rf $(CURDIR)/.pkg $(TARBALL) $(CURDIR)/.cache
	@echo "gpu: removed the bundle, its staging dir and the stimulus cache"

clean_all: clean
	@rm -rf $(RESULTS)
	@echo "gpu: removed $(RESULTS)"

help:
	@echo ""
	@echo "  GPU baseline -- the same network on an NVIDIA card."
	@echo ""
	@echo "    make -C gpu selftest     float64 vs rtda_ref, NO GPU needed  (~5 s)"
	@echo "    make -C gpu tarball      ~3.4 MB bundle for the GPU server"
	@echo "    make -C gpu check        numerics on the GPU               (~30 s)"
	@echo "    make -C gpu scan_host    1..10000 event sweep              (~2 min)"
	@echo ""
	@echo "  Knobs: GPU=3  VARIANTS=fp32,bf16,tf32  MODES=single,fresh,graph"
	@echo "         SCAN_EVENTS=1,10,100,1000,10000  SCAN_REPS=5"
	@echo ""
	@echo "  GPU=3 is a default, not a guess: pick an IDLE card. scan_gpu.py"
	@echo "  refuses a device that is already in use, in both directions --"
	@echo "  a shared card ruins this measurement and someone else's job."
	@echo ""
	@echo "  Results land in results/gpu/native/ and are read by"
	@echo "  analysis/rtda_scan.ipynb section 8."
	@echo ""
