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
KERNEL_FREQ    ?= 150000000
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
        system link package run clean clean_all help vars

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

fastsim: $(NATIVE)
	@mkdir -p $(RESULTS)/sim
	@$(NATIVE) $(STIMULUS) $(RESULTS)/sim $(EVENTS) $(WARMUP)
	@$(PYTHON) compare.py --dir $(RESULTS)/sim --events $(EVENTS) --warmup $(WARMUP)

# Does the numpy screening model actually predict the real datapath?
validate: $(NATIVE)
	@mkdir -p $(RESULTS)/sim
	@$(NATIVE) $(STIMULUS) $(RESULTS)/sim $(EVENTS) $(WARMUP) >/dev/null
	@$(PYTHON) compare.py --dir $(RESULTS)/sim --events $(EVENTS) \
	    --warmup $(WARMUP) --vs-model

############################################################################
#  3. Vitis HLS
############################################################################
# SAFE_PATH: the PetaLinux sysroot puts a make on PATH that needs GLIBC_2.38,
# ahead of /usr/bin/make. Vitis HLS's post-check compilation then fails on
# Ubuntu 22.04.
SAFE_PATH := /usr/bin:/usr/local/bin:$(PATH)
HLS_ENV   := RTDA_AP_DEFS="$(AP_DEFS)" \
             RTDA_STIMULUS="$(abspath $(STIMULUS))" \
             RTDA_TB_REFERENCE="$(CURDIR)/native/tb_means.txt" \
             RTDA_WEIGHTS_DIR="$(CURDIR)/pl/weights" \
             RTDA_EVENTS=$(EVENTS) RTDA_WARMUP=$(WARMUP)

# csim compares against the native model, so build that reference first --
# it can then never be stale with respect to the format being synthesised.
native/tb_means.txt: $(NATIVE)
	@$(NATIVE) $(STIMULUS) native $(EVENTS) $(WARMUP) >/dev/null
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

$(BUILD_DIR) $(PKG_DIR):
	@mkdir -p $@

$(XSA): $(PL_XO) $(LINK_CFG) | $(BUILD_DIR)
	@command -v v++ >/dev/null || { echo "ERROR: v++ not on PATH -- source ../set_envs.sh"; exit 1; }
	v++ --link -t $(TARGET) --save-temps --platform $(PLATFORM) \
	    --config $(LINK_CFG) --clock.defaultFreqHz $(KERNEL_FREQ) \
	    $(PL_XO) -o $@

link: $(XSA)

$(PL_XO):
	@$(MAKE) --no-print-directory kernels

# The board needs the stimulus. Unlike the AIE flow there is no sysdata to
# stage: the weights are compiled into the bitstream.
SD_FILES := $(abspath $(STIMULUS))

$(XCLBIN): $(XSA) $(EXEC) | $(PKG_DIR)
	v++ --package -t $(TARGET) \
	    --platform $(PLATFORM) \
	    --package.out_dir $(PKG_DIR) \
	    --package.rootfs $(ROOTFS) \
	    --package.kernel_image $(IMAGE) \
	    $(if $(filter hw,$(TARGET)),--package.boot_mode sd,) \
	    --package.sd_file $(EXEC) \
	    $(addprefix --package.sd_file ,$(SD_FILES)) \
	    $(XSA) -o $@

package: $(XCLBIN)

system: kernels host link package
	@echo
	@echo ">>> SD image ready: $(PKG_DIR)/sd_card.img   ($(VARIANT), $(TARGET))"

run: system
ifeq ($(TARGET),hw_emu)
	@echo ">>> hw_emu on QEMU -- $(shell expr $$(wc -l < $(STIMULUS)) / 8 / 50 2>/dev/null) events"
	@echo ">>> from $(STIMULUS). EVENTS= does NOT apply here: the host reads"
	@echo ">>>   RTDA_EVENTS, which cannot be set inside QEMU, so the file is the cap."
	$(PKG_DIR)/launch_hw_emu.sh -run-app $(EXEC) $(XCLBIN)
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
	@echo "STIMULUS = $(STIMULUS)"
	@echo "RESULTS  = $(RESULTS)"
	@echo "XSA      = $(XSA)"
	@echo "XCLBIN   = $(XCLBIN)"
	@echo "PLATFORM = $(PLATFORM)"

clean:
	@$(MAKE) -C pl clean 2>/dev/null || true
	rm -rf build package native/rtda_native_* native/tb_means.txt _x .Xil *.log *.jou
	rm -rf rtda_split_hls pl/rtda_split_hls   # vitis_hls puts it in the CWD
	rm -f $(EXEC)

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
