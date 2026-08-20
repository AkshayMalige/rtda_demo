############################################################################
#  RTDA on the PL only -- HLS, ap_fixed, no AIE.
#
#  Same network and the SAME WEIGHTS as aie_batch/ (both read
#  ../model/weights_fp32/, verified identical to 5e-09), so the two are
#  directly comparable and the only difference is the arithmetic.
#
#  FOUR WAYS TO RUN IT, cheapest first:
#
#    make sweep              numpy screening over ap_fixed formats.  ~1 min
#                            Picks (W, I) before any tool runs.
#    make fastsim EVENTS=N   the real kernel sources compiled with g++.
#                            Bit-accurate, ~90 ms/event, so 1000 events is
#                            90 s. THIS is how the 50,000-track comparison
#                            against the AIE gets made -- see below.
#    make exactsim           Vitis RTL co-simulation. Cycle-accurate, slow.
#    make system TARGET=hw   bitstream + SD image for the board.
#
#  WHY `fastsim` IS NOT OPTIONAL
#  The design takes ~2 ms of hardware time per event. hw_emu simulates that
#  in RTL, which makes it a 5-event tool and not a 1000-event one. Without a
#  native bit-accurate runner the only way to get an ap_fixed number at the
#  scale the AIE flow is measured at would be to build a bitstream and boot
#  the board.
#
#  PRECISION is a build-time knob, not a source edit:
#    make fastsim AP_W=18 AP_I=3        make csynth AP_W=16 AP_I=2
#    make fastsim ALPHA125=1            the legacy 0.125 leaky slope
############################################################################

SHELL := /bin/bash

######################## Toolchain / platform ##############################
# set_envs.sh exports PLATFORM (a full .xpfm path), IMAGE and ROOTFS; `?=`
# picks those up and the literals below are only a fallback.
XILINX_VITIS   ?= /tools/Xilinx/Vitis/2024.2
PLATFORM       ?= xilinx_vek280_base_202420_1
EDGE_COMMON_SW ?= /home/synthara/versal_common/xilinx-versal-common-v2024.2
IMAGE          ?= $(EDGE_COMMON_SW)/Image
ROOTFS         ?= $(EDGE_COMMON_SW)/rootfs.ext4
# 180 MHz. ONE knob: this drives BOTH the v++ link (--clock.defaultFreqHz)
# and the Vitis HLS schedule (RTDA_HLS_PERIOD -> create_clock in
# pl/rtda_split_project.tcl). Keeping them separate is exactly how the design
# came to be SCHEDULED for 150 MHz while the link was told something else --
# see ../freq_sweep/README.md. Raising this costs LUT, because HLS pipelines
# harder to hold the tighter period.
KERNEL_FREQ    ?= 180000000
# The HLS period in ns, derived so the two cannot drift. An explicit
# RTDA_HLS_PERIOD in the environment still wins -- that is how freq_sweep
# walks the HLS clock independently of the link.
# $(strip ...): a line continuation inside $(if ...) leaves a leading space in
# the expansion, and the value goes to the TCL as a quoted string.
HLS_PERIOD_NS  ?= $(strip $(if $(RTDA_HLS_PERIOD),$(RTDA_HLS_PERIOD),\
                  $(shell awk 'BEGIN{printf "%.4f", 1000000000.0/$(KERNEL_FREQ)}')))
VITIS_HLS      ?= vitis_hls
# numpy only; see aie_batch/Makefile for why this is pinned and not `python3`.
PYTHON         ?= /home/synthara/miniforge3/bin/python

######################## Design configuration ##############################
TARGET   ?= hw_emu
EVENTS   ?= 5
# tracks 3..49. See pl/src/rtda_split_top.h for why this is a runtime argument
# and what WARMUP=0 gives you instead.
WARMUP   ?= 3
# hw_emu simulates the RTL, so an event costs minutes rather than microseconds
# and the 1000-event stimulus is not a run anyone would finish. EVENTS does NOT
# cap it: the host takes its event count from RTDA_EVENTS, and no environment
# variable survives the trip into QEMU -- `launch_hw_emu.sh -run-app` starts the
# binary on the emulated system with its own environment. The cap therefore has
# to BE the stimulus file, which the host sizes itself from.
#
# 100 tracks = 2 events, which is the smallest run that still crosses an event
# boundary and so still exercises the accumulator reset and the roll carry.
ifeq ($(TARGET),hw_emu)
STIMULUS ?= ../testdata/embed_input_100.txt
else
STIMULUS ?= ../testdata/embed_input_50000.txt
endif

# STIMULUS is for RUNS ON A CARD (or QEMU pretending to be one), and only those.
# Every SIMULATION target -- fastsim, validate, csim, cosim -- uses SIM_STIMULUS
# instead, because none of them is a card and none should inherit the hw_emu cap.
#
# They used to use $(STIMULUS), which defaults to the 100-track hw_emu file, and
# that file is testdata Family A: ONE REAL EVENT REPEATED. The reference every
# comparison here uses is Family B (synthesised, seed 1234), so event 0 agreed
# EXACTLY and event 1 could not -- a clean 2.07e-02 that reads like a
# fixed-point bug and is not one. See testdata/README.md for the two families.
#
# `make csim` was fixed this way already; fastsim and validate were left behind
# and shipped the 2.07e-02 into results/pl_fixed/sim and into both notebooks.
SIM_STIMULUS ?= ../testdata/embed_input_50000.txt

# The fixed-point format. Defaults live in pl/src/rtda_fixed.h; anything set
# here overrides them for both the native model and synthesis, so the two can
# never disagree about what was built.
AP_W     ?=
AP_I     ?=
ALPHA125 ?=
AP_DEFS  := $(if $(AP_W),-DRTDA_W=$(AP_W),) $(if $(AP_I),-DRTDA_I=$(AP_I),) \
            $(if $(ALPHA125),-DRTDA_ALPHA_125,)
# The tag every result is filed under, so two formats cannot overwrite
# each other's numbers.
VARIANT  := ap$(if $(AP_W),$(AP_W),16)_$(if $(AP_I),$(AP_I),3)$(if $(ALPHA125),_a125,)

RESULTS  := ../results/pl_fixed

######################## Paths #############################################
XO_DIR    := pl/ip
PL_XO     := $(XO_DIR)/rtda_split.xo
STAMP     := $(VARIANT)_$(TARGET)
BUILD_DIR := build/$(STAMP)
PKG_DIR   := package/$(STAMP)
XSA       := $(BUILD_DIR)/design.xsa
# system_hw.xclbin / system_hw_emu.xclbin, matching aie_batch and what
# host_split.exe autodetects when given no argument.
XCLBIN    := $(PKG_DIR)/system_$(TARGET).xclbin
EXEC      := ./host_split.exe
LINK_CFG  := link.cfg

HLS_INC   := $(XILINX_VITIS)/include
SRC       := pl/src
KSRCS     := $(SRC)/rtda_split_top.cpp $(SRC)/embed_proxy.cpp \
             $(SRC)/solver0_proxy.cpp $(SRC)/solver1_proxy.cpp \
             $(SRC)/solver2_proxy.cpp $(SRC)/output_proxy.cpp
KHDRS     := $(SRC)/rtda_split_top.h $(SRC)/rtda_fixed.h $(SRC)/rtda_leaky.h
NATIVE    := native/rtda_native_$(VARIANT)

.PHONY: all weights sweep fastsim exactsim validate native \
        csim csynth cosim cosim_only kernels host host_x86 host_aarch64 \
        system link package repackage run clean clean_all help vars

all: help

############################################################################
#  Weights -- generated, never hand-edited
############################################################################
# pl/weights/*.txt used to be 36 symlinks into the untracked hls_projects/
# tree. They now come from ../model/weights_fp32/, the same directory the AIE
# graph and the reference model read.
weights:
	@$(PYTHON) gen_weights.py

check_weights:
	@$(PYTHON) gen_weights.py --check

############################################################################
#  1. Screening: which ap_fixed format?
############################################################################
sweep:
	@$(PYTHON) sweep.py --events $(EVENTS) --warmup $(WARMUP)

############################################################################
#  2. The bit-accurate native model -- the workhorse
############################################################################
# The same kernel sources, compiled with g++ against the header-only
# ap_fixed / hls_stream / nnet_utils. #pragma HLS is ignored; nothing else
# differs, so the numbers are the RTL's numbers.
#
# WEIGHTS_DIR is baked in as an absolute path: nnet::load_weights_from_txt
# resolves "weights/<name>.txt" against the CWD, and a runner that only works
# from one directory is a trap.
native: $(NATIVE)

$(NATIVE): native/run_model.cpp $(KSRCS) $(KHDRS) | weights
	@mkdir -p native
	@echo ">>> g++ native model  $(VARIANT)"
	@g++ -O2 -std=c++14 -Wno-unknown-pragmas -Wno-unused-label $(AP_DEFS) \
	    -DWEIGHTS_DIR='"$(CURDIR)/pl/weights"' \
	    -I $(SRC) -I pl/firmware -I $(HLS_INC) \
	    native/run_model.cpp $(KSRCS) -o $@

# SIM_STIMULUS, not STIMULUS: this is a native g++ run with no card and no
# QEMU in it, and compare.py scores it against synth_tracks() -- the Family B
# stream. Feeding it the Family A hw_emu file compares one event's answer
# against another event's question.
fastsim: $(NATIVE)
	@mkdir -p $(RESULTS)/sim
	@$(NATIVE) $(SIM_STIMULUS) $(RESULTS)/sim $(EVENTS) $(WARMUP)
	@$(PYTHON) compare.py --dir $(RESULTS)/sim --events $(EVENTS) --warmup $(WARMUP)

# Does the numpy screening model actually predict the real datapath?
validate: $(NATIVE)
	@mkdir -p $(RESULTS)/sim
	@$(NATIVE) $(SIM_STIMULUS) $(RESULTS)/sim $(EVENTS) $(WARMUP) >/dev/null
	@$(PYTHON) compare.py --dir $(RESULTS)/sim --events $(EVENTS) \
	    --warmup $(WARMUP) --vs-model

############################################################################
#  3. Vitis HLS
############################################################################
# SAFE_PATH: the PetaLinux sysroot puts a make on PATH that needs GLIBC_2.38,
# ahead of /usr/bin/make. Vitis HLS's post-check compilation then fails on
# Ubuntu 22.04.
SAFE_PATH := /usr/bin:/usr/local/bin:$(PATH)
# csim and cosim are TARGET-AGNOSTIC -- they simulate the kernel, not a card --
# and so they use SIM_STIMULUS, defined with STIMULUS at the top of this file.

HLS_ENV   := RTDA_AP_DEFS="$(AP_DEFS)" \
             RTDA_STIMULUS="$(abspath $(SIM_STIMULUS))" \
             RTDA_TB_REFERENCE="$(CURDIR)/native/tb_means.txt" \
             RTDA_WEIGHTS_DIR="$(CURDIR)/pl/weights" \
             RTDA_HLS_PERIOD="$(HLS_PERIOD_NS)" \
             RTDA_EVENTS=$(EVENTS) RTDA_WARMUP=$(WARMUP)

# csim compares against the native model, so build that reference first --
# it can then never be stale with respect to the format being synthesised.
# The reference has to match the stimulus AND the event count the testbench will
# use. Depending on $(NATIVE) alone meant a reference built earlier -- for a
# different EVENTS, or from a different stimulus -- was silently reused, and csim
# then reported a "mismatch" that was entirely the reference being stale. Make
# cannot see that a variable changed, so the value becomes a file name.
TB_STAMP := native/.tb.$(EVENTS)ev.$(WARMUP)wu.$(VARIANT).$(notdir $(SIM_STIMULUS))

$(TB_STAMP):
	@mkdir -p native
	@rm -f native/.tb.* native/tb_means.txt
	@touch $@

native/tb_means.txt: $(NATIVE) $(SIM_STIMULUS) $(TB_STAMP)
	@$(NATIVE) $(SIM_STIMULUS) native $(EVENTS) $(WARMUP) >/dev/null
	@mv native/track_means_all.txt native/tb_means.txt
	@rm -f native/track_out_27.txt native/run_info.txt
	@echo ">>> csim reference: native/tb_means.txt ($(EVENTS) events, $(VARIANT))"

csim: weights native/tb_means.txt
	@PATH=$(SAFE_PATH) $(HLS_ENV) $(VITIS_HLS) pl/rtda_split_project.tcl csim

csynth cosim cosim_only kernels: weights
	@PATH=$(SAFE_PATH) $(HLS_ENV) $(VITIS_HLS) pl/rtda_split_project.tcl $@

exactsim: native/tb_means.txt
	@PATH=$(SAFE_PATH) $(HLS_ENV) $(VITIS_HLS) pl/rtda_split_project.tcl cosim

############################################################################
#  4. System build
############################################################################
host: host_aarch64
host_x86:
	@$(MAKE) -C host EMU_PS=X86 RTDA_VARIANT=$(VARIANT)
host_aarch64:
	@$(MAKE) -C host EMU_PS=QEMU RTDA_VARIANT=$(VARIANT)

# See the note on the same rule in aie_batch/Makefile: without prerequisites an
# existing host_split.exe is never rebuilt, and `package` puts a stale binary on
# the card after a multi-hour synthesis.
$(EXEC): host/host_split.cpp host/Makefile
	@$(MAKE) -C host EMU_PS=QEMU RTDA_VARIANT=$(VARIANT)

# The performance scan host. Independent of the whole build: it talks to the
# xclbin that is already on the card, so `make scan_host` is seconds and needs no
# HLS, no link and no package. That is the point -- with csynth at ~5 h, a scan
# must never be a reason to rebuild a bitstream.
SCAN_EXEC := ./host_scan.exe

.PHONY: scan_host
scan_host: $(SCAN_EXEC)

$(SCAN_EXEC): host/host_scan.cpp host/Makefile
	@$(MAKE) -C host scan EMU_PS=QEMU RTDA_VARIANT=$(VARIANT)

# A wrapper so the scan is CONTROLLABLE under QEMU.
#
# `launch_emulator -run-app` takes exactly ONE value -- "Specify the application
# to run" -- so extra tokens are rejected outright ("unrecognized arguments").
# And no environment survives into the guest. Between them there is no way to
# shorten the sweep from outside, and the DEFAULT sweep in RTL simulation is
# hours. So the settings are baked into a one-line script that goes on the card
# and IS the application:
#
#   make run_scan TARGET=hw_emu SCAN_REPS=1 SCAN_TPC=off
#
# On real hardware none of this is needed -- there you have a shell.
SCAN_LAUNCH  := scan_hw_emu.sh
SCAN_EVENTS  ?=
SCAN_REPS    ?= 1
SCAN_MODES   ?= fresh,reuse
SCAN_TPC     ?= off

$(SCAN_LAUNCH): Makefile
	@printf '#!/bin/sh\n# generated by pl_fixed/Makefile -- do not edit\n' > $@
	@printf 'exec ./host_scan.exe%s%s%s%s\n' \
	  '$(if $(SCAN_EVENTS), RTDA_SCAN_EVENTS=$(SCAN_EVENTS),)' \
	  ' RTDA_SCAN_REPS=$(SCAN_REPS)' \
	  ' RTDA_SCAN_MODES=$(SCAN_MODES)' \
	  ' RTDA_SCAN_TPC=$(SCAN_TPC)' >> $@
	@chmod +x $@
	@echo ">>> $@:  $$(tail -1 $@)"

.PHONY: run_scan
run_scan: $(SCAN_LAUNCH)
ifeq ($(TARGET),hw_emu)
	@cmp -s $(SCAN_LAUNCH) $(PKG_DIR)/sd_card/$(SCAN_LAUNCH) || { \
	  echo "ERROR: the $(SCAN_LAUNCH) in the image is missing or stale, so the run"; \
	  echo "       would silently use the PREVIOUS sweep settings. Repackage:"; \
	  echo "       make package TARGET=hw_emu   (38 s -- no HLS, no link)"; exit 1; }
	$(PKG_DIR)/launch_hw_emu.sh -run-app ./$(SCAN_LAUNCH)
else
	@echo "TARGET=hw: on the board, with a real shell, run host_scan.exe directly:"
	@echo "  RTDA_INPUT=/mnt/usb/embed_input_500000.txt ./host_scan.exe"
	@echo "See the performance scan section of ../RUNBOOK.md."
endif

$(BUILD_DIR) $(PKG_DIR):
	@mkdir -p $@

$(XSA): $(PL_XO) $(LINK_CFG) | $(BUILD_DIR)
	@command -v v++ >/dev/null || { echo "ERROR: v++ not on PATH -- source ../set_envs.sh"; exit 1; }
	v++ --link -t $(TARGET) --save-temps --platform $(PLATFORM) \
	    --temp_dir _x/$(STAMP) \
	    --config $(LINK_CFG) --clock.defaultFreqHz $(KERNEL_FREQ) \
	    $(PL_XO) -o $@

link: $(XSA)

# Everything HLS compiles into the .xo. Without these the rule fires only when
# the file is absent, so editing rtda_leaky.h and rebuilding would package an
# xclbin built from the OLD kernel and report it as new -- silently wrong, which
# is worse than slow. (The same shape of bug shipped a stale host_batch.exe onto
# an SD card; see the note on $(EXEC) in aie_batch/Makefile.)
PL_KERNEL_SRC := $(wildcard pl/src/*.cpp) $(wildcard pl/src/*.h) \
                 $(wildcard pl/firmware/*/*.h) $(wildcard pl/firmware/*/*.cpp) \
                 $(wildcard pl/firmware/nnet_utils/*.h) pl/rtda_split_project.tcl

$(PL_XO): $(PL_KERNEL_SRC)
	@$(MAKE) --no-print-directory kernels

# The board needs the stimulus. Unlike the AIE flow there is no sysdata to
# stage: the weights are compiled into the bitstream.
# What goes on the card besides the two hosts.
#
# BOTH stimulus files, not just $(STIMULUS): the accuracy host wants the 50,000
# track file it has a golden for, and the scan host wants the 500,000 track one.
# Packaging only one meant the hw card could do accuracy or performance but not
# both without a rebuild -- and which one you got depended on a variable set hours
# earlier. The 65 MB is free next to a 3.2 GB image.
#
# SCAN_STIMULUS is skipped if it has not been generated (make stimulus
# TRACKS=500000), so a tree that only ever does accuracy still packages.
SCAN_STIMULUS := ../testdata/embed_input_500000.txt
SD_FILES := $(abspath $(STIMULUS)) \
            $(if $(wildcard $(SCAN_STIMULUS)),$(abspath $(SCAN_STIMULUS)),) \
            $(abspath $(SCAN_LAUNCH))

$(XCLBIN): $(XSA) $(EXEC) $(SCAN_EXEC) $(SCAN_LAUNCH) | $(PKG_DIR)
	v++ --package -t $(TARGET) \
	    --platform $(PLATFORM) \
	    --package.out_dir $(PKG_DIR) \
	    --package.rootfs $(ROOTFS) \
	    --package.kernel_image $(IMAGE) \
	    $(if $(filter hw,$(TARGET)),--package.boot_mode sd,) \
	    --package.sd_file $(EXEC) \
	    --package.sd_file $(SCAN_EXEC) \
	    $(addprefix --package.sd_file ,$(SD_FILES)) \
	    $(XSA) -o $@

package: $(XCLBIN)

# Force the package step to re-run without touching synthesis or the link.
# Mirrors aie_batch's target of the same name: the packaged CONTENTS (host
# binaries, stimulus) are not prerequisites of $(XCLBIN), so adding a file to the
# card is invisible to make.
repackage:
	@rm -f $(XCLBIN)
	@$(MAKE) --no-print-directory package TARGET=$(TARGET) STIMULUS=$(STIMULUS)

# $(PL_XO), NOT `kernels`. `kernels` is .PHONY, so listing it here re-ran the
# whole 3 h HLS synthesis on every `make system` even when the .xo was present
# and current -- which is what a TARGET=hw_emu run after a finished TARGET=hw
# build does, for an artifact that is target-agnostic and already on disk.
system: $(PL_XO) host link package
	@echo
	@echo ">>> SD image ready: $(PKG_DIR)/sd_card.img   ($(VARIANT), $(TARGET))"

run: system
ifeq ($(TARGET),hw_emu)
	@echo ">>> hw_emu on QEMU -- $(shell expr $$(wc -l < $(STIMULUS)) / 8 / 50 2>/dev/null) events"
	@echo ">>> from $(STIMULUS). EVENTS= does NOT apply here: the host reads"
	@echo ">>>   RTDA_EVENTS, which cannot be set inside QEMU, so the file is the cap."
	@echo ">>> QEMU takes a few minutes to boot. If it drops to a shell prompt,"
	@echo ">>>   see RUNBOOK.md -- mount the card and run ./host_split.exe there."
	# NO $(XCLBIN) argument. It is a path on THIS machine
	# (package/ap16_3_hw_emu/system_hw_emu.xclbin) and -run-app hands its
	# arguments to the binary running on the EMULATED system, where the xclbin
	# sits at the root of the mounted card and that path does not exist. The
	# host autodetects system_hw_emu.xclbin in its working directory, so the
	# argument was never needed and could only ever be wrong.
	$(PKG_DIR)/launch_hw_emu.sh -run-app $(EXEC)
else
	@echo "TARGET=hw: write $(PKG_DIR)/sd_card.img to the SD card and boot the VEK280."
	@echo "See ../RUNBOOK.md for the on-board commands."
endif

############################################################################
vars:
	@echo "TARGET   = $(TARGET)"
	@echo "VARIANT  = $(VARIANT)   (AP_W=$(AP_W) AP_I=$(AP_I) ALPHA125=$(ALPHA125))"
	@echo "AP_DEFS  = $(AP_DEFS)   (empty => the defaults in $(SRC)/rtda_fixed.h)"
	@echo "EVENTS   = $(EVENTS)    WARMUP = $(WARMUP)"
	@echo "STIMULUS = $(STIMULUS)      (runs on a card / QEMU)"
	@echo "SIM_STIMULUS = $(SIM_STIMULUS)   (fastsim, validate, csim, cosim)"
	@echo "RESULTS  = $(RESULTS)"
	@echo "XSA      = $(XSA)"
	@echo "XCLBIN   = $(XCLBIN)"
	@echo "PLATFORM = $(PLATFORM)"

clean:
	@$(MAKE) -C pl clean 2>/dev/null || true
	rm -rf build package native/rtda_native_* native/tb_means.txt _x .Xil *.log *.jou
	rm -rf rtda_split_hls pl/rtda_split_hls   # vitis_hls puts it in the CWD
	rm -f $(EXEC) $(SCAN_EXEC)
	@$(MAKE) -C host clean

clean_all: clean
	@$(MAKE) -C host clean 2>/dev/null || true
	rm -rf rtda_split_hls pl/rtda_split_hls pl/ip

help:
	@echo ""
	@echo "RTDA, PL only (HLS, ap_fixed) -- same network and weights as aie_batch/"
	@echo "======================================================================"
	@echo ""
	@echo "  make sweep    EVENTS=20        which ap_fixed format?  (numpy, ~1 min)"
	@echo "  make fastsim  EVENTS=1000      bit-accurate native run  (~90 ms/event)"
	@echo "  make validate EVENTS=20        native vs the numpy screening model"
	@echo "  make csim     EVENTS=5         Vitis C simulation"
	@echo "  make exactsim                  RTL co-simulation (slow)"
	@echo "  make csynth                    synthesis: resources and timing"
	@echo "  make system TARGET=hw_emu|hw   bitstream + SD image"
	@echo "  make run    TARGET=hw_emu      ... and launch it on QEMU"
	@echo ""
	@echo "  Precision knobs (default <16,3>, alpha 0.1, see pl/src/rtda_fixed.h):"
	@echo "    AP_W=18 AP_I=3               wider word"
	@echo "    ALPHA125=1                   the legacy 0.125 leaky slope"
	@echo "  Results are filed under $(RESULTS)/ tagged '$(VARIANT)'."
	@echo ""
	@echo "  make weights                   regenerate pl/weights from ../model"
	@echo "  make check_weights             ... or just verify them"
	@echo "  make vars / clean / clean_all"
	@echo ""
############################################################################
