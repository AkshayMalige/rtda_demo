############################################################################
#  Top-level Makefile — RTDA Split-Kernel system build (PL-only, no AIE)
#
#  COMPONENT-LEVEL TARGETS (standalone, no system TARGET needed):
#    make pl_csim       — PL C simulation (fast functional check)
#    make pl_csynth     — PL C→RTL synthesis (resource + timing reports)
#    make pl_cosim      — PL RTL co-simulation (csynth + cosim)
#    make pl_cosim_only — PL RTL co-sim only (reuse existing csynth)
#    make pl_kernels    — PL csynth + export XO + IP catalog
#    make host_x86      — Host native x86 build (for local testing)
#    make host_aarch64  — Host aarch64 cross-compile (for hw_emu/hw)
#
#  SYSTEM-LEVEL TARGETS (use TARGET=hw_emu|hw):
#    make system TARGET=hw_emu  — Full build: PL + aarch64 host + link + package
#    make system TARGET=hw      — Full hardware build for VEK280
#    make run    TARGET=hw_emu  — Build + run hardware emulation
############################################################################

######################## User-specific paths ###############################
XILINX_VITIS   ?= /tools/Xilinx/2025.1/Vitis
PLATFORM       ?= xilinx_vek280_base_202420_1
EDGE_COMMON_SW ?= /home/synthara/versal_common/xilinx-versal-common-v2024.2
IMAGE          ?= $(EDGE_COMMON_SW)/Image
ROOTFS         ?= $(EDGE_COMMON_SW)/rootfs.ext4
###########################################################################

TARGET   ?= hw_emu
LINK_CFG := link.cfg
DATA_FILES := $(abspath ../data/embed_input.txt) \
              $(abspath ../punit/outputs/keras_27dim.txt)
XO_DIR   := pl/ip
PL_XO    := $(XO_DIR)/rtda_split.xo
BUILD_DIR := build_$(TARGET)
XSA      := $(BUILD_DIR)/design_$(TARGET).xsa
PKG_DIR  := package.$(TARGET)
XCLBIN   := $(PKG_DIR)/system_$(TARGET).xclbin
EXEC     := ./host.exe

.PHONY: all system \
        pl_csim pl_csynth pl_cosim pl_cosim_only pl_kernels \
        host host_x86 host_aarch64 \
        link package run run_emu \
        clean clean_all help print_vars

############################################################################
#  Component targets
############################################################################

pl_csim:
	$(MAKE) -C pl csim

pl_csynth:
	$(MAKE) -C pl csynth

pl_cosim:
	$(MAKE) -C pl cosim

pl_cosim_only:
	$(MAKE) -C pl cosim_only

pl_kernels: $(PL_XO)

$(PL_XO):
	$(MAKE) -C pl kernels

# Default host target: aarch64 cross-compile for hw_emu/hw
host: host_aarch64

host_x86:
	$(MAKE) -C host EMU_PS=X86

host_aarch64:
	$(MAKE) -C host EMU_PS=QEMU

############################################################################
#  System targets
############################################################################

system: pl_kernels host link package

all: system

$(BUILD_DIR):
	@mkdir -p $@

$(XSA): $(PL_XO) $(LINK_CFG) | $(BUILD_DIR)
	v++ --link -t $(TARGET) --platform $(PLATFORM) --config $(LINK_CFG) \
		$(PL_XO) -o $@
	@echo "Linked design: $@"

link: $(XSA)

$(PKG_DIR):
	@mkdir -p $@

ifeq ($(TARGET),hw_emu)
$(XCLBIN): $(XSA) | $(PKG_DIR)
	v++ --package -t hw_emu \
		--platform $(PLATFORM) \
		--package.out_dir $(PKG_DIR) \
		--package.rootfs $(ROOTFS) \
		--package.kernel_image $(IMAGE) \
		--package.sd_file $(EXEC) \
		$(addprefix --package.sd_file ,$(DATA_FILES)) \
		$(XSA) -o $@
	@echo "Packaged design in $(PKG_DIR)"
else
$(XCLBIN): $(XSA) | $(PKG_DIR)
	v++ --package -t hw \
		--platform $(PLATFORM) \
		--package.out_dir $(PKG_DIR) \
		--package.rootfs $(ROOTFS) \
		--package.kernel_image $(IMAGE) \
		--package.boot_mode sd \
		--package.sd_file $(EXEC) \
		$(addprefix --package.sd_file ,$(DATA_FILES)) \
		$(XSA) -o $@
	@echo "Packaged design in $(PKG_DIR)"
endif

package: $(XCLBIN)

run: system run_emu

run_emu:
ifeq ($(TARGET),hw_emu)
	@echo "Running HW-emulation on QEMU..."
	$(PKG_DIR)/launch_hw_emu.sh -run-app $(EXEC) $(XCLBIN)
else
	@echo "TARGET=hw: Copy '$(PKG_DIR)' to SD-card and boot the VEK280."
endif

############################################################################
#  Utilities
############################################################################

print_vars:
	@echo "TARGET   = $(TARGET)"
	@echo "PLATFORM = $(PLATFORM)"
	@echo "PL_XO    = $(PL_XO)"
	@echo "XSA      = $(XSA)"
	@echo "EXEC     = $(EXEC)"
	@echo "XCLBIN   = $(XCLBIN)"

clean:
	$(MAKE) -C pl clean
	rm -rf package.* build_* *.xclbin *.xsa *.log host.exe emconfig.json

clean_all:
	$(MAKE) -C pl clean
	$(MAKE) -C host clean
	rm -rf package.* build_* *.xclbin *.xsa *.log host.exe emconfig.json

help:
	@echo ""
	@echo "=== RTDA Split-Kernel System Build ==="
	@echo ""
	@echo "Component targets (standalone):"
	@echo "  make pl_csim           Run PL C simulation"
	@echo "  make pl_csynth         Run PL C→RTL synthesis"
	@echo "  make pl_cosim          Run PL RTL co-simulation (with csynth)"
	@echo "  make pl_cosim_only     Run PL RTL co-sim only (reuse existing csynth)"
	@echo "  make pl_kernels        Export PL XO (needed for v++ link)"
	@echo "  make host_x86          Build host for native x86"
	@echo "  make host_aarch64      Build host for aarch64 (cross-compile)"
	@echo ""
	@echo "System targets (use TARGET=hw_emu|hw):"
	@echo "  make system TARGET=hw_emu   Full hw_emu build (PL + host + link + package)"
	@echo "  make system TARGET=hw       Full hardware build for VEK280"
	@echo "  make run    TARGET=hw_emu   Build + run hw emulation on QEMU"
	@echo ""
	@echo "Utilities:"
	@echo "  make print_vars TARGET=hw_emu   Show all build variable values"
	@echo "  make clean                       Clean PL + system build artifacts"
	@echo "  make clean_all                   Clean everything including host"
	@echo ""
	@echo "Typical workflows:"
	@echo "  Weights/firmware changed:          make pl_csim"
	@echo "  Firmware regenerated by notebook:  cd pl && make clean && make csim"
	@echo "  Check resource usage:              make pl_csynth"
	@echo "  Prepare for system build:          make pl_kernels"
	@echo "  Full hw_emu system build:          make system TARGET=hw_emu"
	@echo ""
############################################################################
