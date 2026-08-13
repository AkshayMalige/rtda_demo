############################################################################
#  Top-level Makefile — AIE graph + PL + Host + Link + Package
#
#  COMPONENT-LEVEL TARGETS (standalone, no system TARGET needed):
#    make aie_x86sim   — Compile AIE graph for x86 simulation
#    make aie_hw       — Compile AIE graph for hardware / aiesimulator
#    make aie_sim_x86  — Compile + run x86simulator (fast functional)
#    make aie_sim_hw   — Compile + run aiesimulator (cycle-accurate)
#    make pl_build     — PL kernel synthesis + export XO
#    make pl_csim      — PL kernel C-simulation
#    make pl_cosim     — PL kernel RTL co-simulation
#    make host_x86     — Host native x86 build (for local testing only)
#    make host_aarch64 — Host aarch64 cross-compile (for hw_emu/hw)
#
#  SYSTEM-LEVEL TARGETS (use TARGET=hw_emu|hw):
#    make system TARGET=hw_emu  — Full build: hw AIE + PL + aarch64 host + link + package
#    make system TARGET=hw      — Full build: hw AIE + PL + aarch64 host + link + package
#    make run    TARGET=hw_emu  — Build + run hardware emulation
#
#  VARIABLES:
#    PRECISION = float | int16
############################################################################

######################## User-specific paths ###############################
XILINX_VITIS   ?= /tools/Xilinx/2025.1/Vitis
PLATFORM       ?= xilinx_vek280_base_202420_1
EDGE_COMMON_SW ?= /home/synthara/versal_common/xilinx-versal-common-v2024.2
IMAGE          ?= $(EDGE_COMMON_SW)/Image
ROOTFS         ?= $(EDGE_COMMON_SW)/rootfs.ext4
PACK_CFG       ?= ./pack.cfg
###########################################################################

##################### Build-time variables / defaults ######################
# PRECISION: float | int16
PRECISION ?= float

# TARGET: hw_emu | hw  (only used by system-level targets)
#   hw_emu - hardware emulation (cycle-accurate AIE + QEMU host)
#   hw     - full hardware build for VEK280 board
TARGET ?= hw_emu

# Map PRECISION to PL DATA_TYPE
ifeq ($(PRECISION),int16)
  PL_DATA_TYPE := int16
else
  PL_DATA_TYPE := float
endif
###########################################################################

######################## Internal paths & artifacts ########################
# AIE_DIR selects which AIE design to build into the system.
#   aieml        hand-written GEMV graph, 1 track/iteration, needs the PL
#                track_average kernel  (LINK_CFG = linker_aieml.cfg)
#   aieml_batch  batched aie::mmul graph, 8 tracks/iteration, track average in
#                AIE, no PL at all     (LINK_CFG = linker_batch.cfg)
AIE_DIR   ?= aieml
ifeq ($(AIE_DIR),aieml_batch)
  LINK_CFG  := ./common/linker_batch.cfg
else
  LINK_CFG  := ./common/linker_aieml.cfg
endif
HLS_KERNELS := track_average
# The batched design has no PL at all: the track average is an AIE kernel now.
# This must come AFTER the line above, which would otherwise clobber it, and
# BEFORE PL_XOS is computed from it.
ifeq ($(AIE_DIR),aieml_batch)
  HLS_KERNELS :=
endif
XO_DIR    := pl/ip

AIE_WORK_DIR_NAME ?= Work
# The two designs differ in where the archive lands: aieml/ emits it INSIDE the
# workdir, aieml_batch/ at the project root (Work/ is only the build scratch).
ifeq ($(AIE_DIR),aieml_batch)
  # Precision-suffixed, matching aieml_batch/Makefile's LIBADF. A bare libadf.a
  # here silently linked a STALE archive from an earlier build: the xclbin then
  # carried the fp32 graph while sysdata carried bf16 weights, and the first
  # symptom was on the board --
  #   adf::graph::update parameter size 4096 bytes is inconsistent with
  #   RTP port dut.dut.emb_d0_aie.kk[0].in[1] size 8192 bytes
  # 8192 = 2048 x 4 (fp32 port), 4096 = 2048 x 2 (bf16 payload).
  AIE_LIB := $(AIE_DIR)/libadf_$(PRECISION).a
else
  AIE_LIB := $(AIE_DIR)/$(AIE_WORK_DIR_NAME)/libadf.a
endif
PL_XOS    := $(addprefix $(XO_DIR)/,$(addsuffix _hls.xo,$(HLS_KERNELS)))
BUILD_DIR := build_$(TARGET)
XSA       := $(BUILD_DIR)/design_$(TARGET).xsa
PKG_DIR   := package.$(TARGET)
XCLBIN    := $(PKG_DIR)/system_$(TARGET).xclbin
ifeq ($(AIE_DIR),aieml_batch)
  EXEC     := ./host_batch.exe
  # The batch host needs the fp32 weights AND the extracted RTP payloads on the
  # SD image. SD_STAGE is assembled by the `sd_stage` target below.
  SD_STAGE := ./sd_batch
else
  EXEC     := ./host.exe
  SD_STAGE := ./data
endif
###########################################################################

############################################################################
#  Phony targets
############################################################################
.PHONY: repackage all system aie aie_x86sim aie_hw aie_sim_x86 aie_sim_hw sim \
        pl pl_build pl_csim pl_cosim \
        host host_x86 host_aarch64 \
        link package run run_emu \
        clean clean_all help print_vars

############################################################################
#  COMPONENT-LEVEL TARGETS  (standalone, no system TARGET needed)
############################################################################

# --- AIE graph compilation ---
aie_x86sim:
	$(MAKE) -C aieml graph TARGET=x86sim PRECISION=$(PRECISION) PLATFORM=$(PLATFORM) WORK_DIR=$(AIE_WORK_DIR_NAME)

aie_hw:
	$(MAKE) -C aieml graph TARGET=hw PRECISION=$(PRECISION) PLATFORM=$(PLATFORM) WORK_DIR=$(AIE_WORK_DIR_NAME)

# --- AIE simulation (compile + run) ---
aie_sim_x86: aie_x86sim
	$(MAKE) -C aieml sim TARGET=x86sim PRECISION=$(PRECISION) PLATFORM=$(PLATFORM) WORK_DIR=$(AIE_WORK_DIR_NAME)

aie_sim_hw: aie_hw
	$(MAKE) -C aieml sim TARGET=hw PRECISION=$(PRECISION) PLATFORM=$(PLATFORM) WORK_DIR=$(AIE_WORK_DIR_NAME)

# --- PL kernel synthesis (export XO for v++ link) ---
pl_build:
	$(MAKE) -C pl kernels DATA_TYPE=$(PL_DATA_TYPE)

# --- PL simulation ---
pl_csim:
	$(MAKE) -C pl sim TARGET=csim DATA_TYPE=$(PL_DATA_TYPE)

pl_cosim:
	$(MAKE) -C pl sim TARGET=hw_emu DATA_TYPE=$(PL_DATA_TYPE)

# --- Host builds ---
host_x86:
	$(MAKE) -C host EMU_PS=X86 PRECISION=$(PRECISION)

host_aarch64:
	$(MAKE) -C host EMU_PS=QEMU PRECISION=$(PRECISION)


############################################################################
#  SYSTEM-LEVEL TARGETS  (use TARGET=hw_emu|hw)
#  AIE-ML on VEK280 does not support sw_emu at the system level.
#  For fast AIE-only testing, use: make aie_sim_x86
############################################################################

# Full system build: aie + pl + host + link + package
system: aie pl host link package

# Legacy alias
all: system

# --- AIE (always compiled with --target hw for system builds) ---
# aieml_batch has its own self-contained Makefile and needs SYSTEM_BUILD, which
# swaps its PLIO simulation ports for GMIO and compiles the host-side main().
aie:
ifeq ($(AIE_DIR),aieml_batch)
	@echo ">>> aieml_batch system graph on the SYSTEM toolchain, not its own default."
	@echo "    The rest of the flow (platform, rootfs, sysroot, XRT) is 2024.2, so the"
	@echo "    graph must be too -- a 2025.2 libadf.a will not link against a 2024.2 XSA."
	# Do NOT pass WORK here. aieml_batch derives it as Work_$(PRECISION); forcing the
	# shared AIE_WORK_DIR_NAME built the graph into Work/ while `make rtp` (below)
	# looked in Work_$(PRECISION) -- hence
	#   ERROR: Work_bf16/ps/c_rts/aie_control_config.json missing
	# and it also made the two precisions overwrite each other's system build.
	$(MAKE) -C aieml_batch system_graph PRECISION=$(PRECISION) \
	    AIE_VITIS=$(XILINX_VITIS) AIE_PLAT="$(PLATFORM)"
else
	$(MAKE) -C aieml graph TARGET=hw PRECISION=$(PRECISION) PLATFORM=$(PLATFORM) WORK_DIR=$(AIE_WORK_DIR_NAME)
endif

# Let the AIE archive be built on demand. Without this, `make link` or
# `make package` on their own fail with "No rule to make target .../libadf.a"
# and only `make system` works, because it happens to run `aie` first.
$(AIE_LIB):
	$(MAKE) aie AIE_DIR=$(AIE_DIR) TARGET=$(TARGET) PRECISION=$(PRECISION)

# --- PL XO build (for system linking) ---
pl: $(PL_XOS)
	@echo "PL kernel artifacts ready: $(PL_XOS)"

$(PL_XOS):
	$(MAKE) -C pl kernels DATA_TYPE=$(PL_DATA_TYPE)

# --- Host (always cross-compiled for system builds) ---
# aieml_batch has its own host: no PL kernel, GMIO in/out, 92 RTP ports.
host:
ifeq ($(AIE_DIR),aieml_batch)
	$(MAKE) -C host_batch EMU_PS=$(EMU_PS)
	$(MAKE) -C aieml_batch rtp PRECISION=$(PRECISION)   # 92 RTP payloads + config.txt
else
	$(MAKE) -C host EMU_PS=QEMU PRECISION=$(PRECISION)
endif

# --- AIE simulation convenience (defaults to fast x86) ---
sim: aie_sim_x86

##############################  Link (XSA)  ################################
$(XSA): $(AIE_LIB) $(PL_XOS) $(LINK_CFG) | $(BUILD_DIR)
	@echo "Linking with:"
	@echo "    PL_XOS   = $(PL_XOS)"
	@echo "    AIE_LIB  = $(AIE_LIB)"
	@echo "    LINK_CFG = $(LINK_CFG)"
	@echo "    TARGET   = $(TARGET)"
	v++ --link -t $(TARGET) --platform $(PLATFORM) --save-temps --config $(LINK_CFG) \
		$(PL_XOS) $(AIE_LIB) -o $@
	@echo "Linked design: $@"

link: $(XSA)

$(BUILD_DIR):
	@mkdir -p $@

##############################  Package  ###################################
sd_stage:
ifeq ($(AIE_DIR),aieml_batch)
	@rm -rf $(SD_STAGE) && mkdir -p $(SD_STAGE)
	@cp -r data_fp32 $(SD_STAGE)/
	@cp -r aieml_batch/sysdata_$(PRECISION) $(SD_STAGE)/sysdata
	@cp -r testdata $(SD_STAGE)/   # multi-event inputs + goldens; see testdata/README.md
	@echo "SD staging ready: $(SD_STAGE) (data_fp32 + sysdata)"
endif

package: sd_stage $(XCLBIN)

# The SD staging directory's CONTENTS are not prerequisites of $(XCLBIN), so
# changing what goes on the card (adding testdata, swapping weights) does not
# trigger a repackage on its own. Use this to force one.
repackage:
	@rm -f $(XCLBIN)
	@$(MAKE) package TARGET=$(TARGET) AIE_DIR=$(AIE_DIR)

ifeq ($(TARGET),hw_emu)
$(XCLBIN): $(AIE_LIB) $(XSA) $(EXEC) | $(PKG_DIR)
	@echo "Packaging for hw_emu..."
	v++ --package -t hw_emu \
		--platform $(PLATFORM) \
		--package.out_dir $(PKG_DIR) \
		--package.defer_aie_run \
		--package.rootfs $(ROOTFS) \
		--package.kernel_image $(IMAGE) \
		--package.sd_file $(EXEC) \
		--package.sd_dir $(SD_STAGE) \
		--config $(PACK_CFG) \
		$(AIE_LIB) $(XSA) -o $@
	@echo "Packaged design created in $(PKG_DIR)"
else
$(XCLBIN): $(AIE_LIB) $(XSA) $(EXEC) | $(PKG_DIR)
	@echo "Packaging for hw..."
	v++ --package -t hw \
		--platform $(PLATFORM) \
		--package.out_dir $(PKG_DIR) \
		--package.defer_aie_run \
		--package.rootfs $(ROOTFS) \
		--package.kernel_image $(IMAGE) \
		--package.boot_mode sd \
		--package.sd_file $(EXEC) \
		--package.sd_dir $(SD_STAGE) \
		--config $(PACK_CFG) \
		$(AIE_LIB) $(XSA) -o $@
	@echo "Packaged design created in $(PKG_DIR)"
endif

$(PKG_DIR):
	@mkdir -p $@

##############################  Run  #######################################
run: system run_emu

run_emu:
ifeq ($(TARGET),hw_emu)
	@echo "Running HW-emulation on QEMU..."
	$(PKG_DIR)/launch_hw_emu.sh -run-app $(EXEC) $(XCLBIN)
else
	@echo "TARGET=hw: Copy '$(PKG_DIR)' to SD-card and boot the VEK280."
endif

##############################  Debug  #####################################
print_vars:
	@echo "TARGET       = $(TARGET)"
	@echo "PRECISION    = $(PRECISION)"
	@echo "PL_DATA_TYPE = $(PL_DATA_TYPE)"
	@echo "AIE_LIB      = $(AIE_LIB)"
	@echo "PL_XOS       = $(PL_XOS)"
	@echo "XSA          = $(XSA)"
	@echo "EXEC         = $(EXEC)"
	@echo "XCLBIN       = $(XCLBIN)"

################################  Clean  ###################################
clean:
	$(MAKE) -C pl clean
	rm -rf package.* build_* *.xclbin *.xsa *.log _x host.exe emconfig.json

# clean_all follows AIE_DIR: cleaning the aieml/ tree while building aieml_batch
# leaves stale artifacts in the design you are actually working on, which is the
# opposite of what "clean build" is for.
clean_all:
ifeq ($(AIE_DIR),aieml_batch)
	$(MAKE) -C aieml_batch clean
	$(MAKE) -C host_batch  clean
else
	$(MAKE) -C aieml clean
	$(MAKE) -C host  clean
endif
	$(MAKE) -C pl    clean
	rm -rf package.* build_* *.xclbin *.xsa *.log _x emconfig.json
	rm -rf host.exe host_batch.exe $(SD_STAGE)

################################  Help  ####################################
help:
	@echo ""
	@echo "=== COMPONENT-LEVEL TARGETS (standalone) ==="
	@echo ""
	@echo "  AIE Graph:"
	@echo "    make aie_x86sim  PRECISION=float   Compile AIE graph for x86 simulation"
	@echo "    make aie_hw      PRECISION=float   Compile AIE graph for hw (aiesimulator / v++ link)"
	@echo "    make aie_sim_x86 PRECISION=float   Compile + run x86simulator (fast functional)"
	@echo "    make aie_sim_hw  PRECISION=float   Compile + run aiesimulator (cycle-accurate)"
	@echo ""
	@echo "  PL Kernels:"
	@echo "    make pl_build    PRECISION=float   Synthesize + export XO files"
	@echo "    make pl_csim     PRECISION=float   Run C-simulation"
	@echo "    make pl_cosim    PRECISION=float   Run RTL co-simulation"
	@echo ""
	@echo "  Host Application:"
	@echo "    make host_x86     PRECISION=float   Build for native x86 (local testing only)"
	@echo "    make host_aarch64 PRECISION=float   Build for aarch64 (cross-compile)"
	@echo ""
	@echo "=== SYSTEM-LEVEL TARGETS (use TARGET=hw_emu|hw) ==="
	@echo ""
	@echo "    make system TARGET=hw_emu  PRECISION=float   Full hw_emu build"
	@echo "    make system TARGET=hw      PRECISION=float   Full hardware build"
	@echo "    make run    TARGET=hw_emu  PRECISION=float   Build + run hw emulation"
	@echo ""
	@echo "=== UTILITIES ==="
	@echo ""
	@echo "    make sim                            Quick AIE sim (alias for aie_sim_x86)"
	@echo "    make print_vars TARGET=hw_emu       Show all build variable values"
	@echo "    make clean                          Clean PL + system build artifacts"
	@echo "    make clean_all                      Clean everything (AIE + PL + Host + system)"
	@echo ""
############################################################################
