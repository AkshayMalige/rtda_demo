############################################################################
#  Top-level Makefile — AIE graph + PL + Host + Link + Package
#  TARGET    = sw_emu | hw_emu | hw
#  PRECISION = float | int16
#  EMU_PS    = X86 | QEMU (host build mode)
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
# TARGET: x86 | sw_emu | hw_emu | hw
#   x86     - AIE x86 functional simulation (fastest, no PL/host)
#   sw_emu  - software emulation (x86sim AIE + native host)
#   hw_emu  - hardware emulation (cycle-accurate AIE + QEMU host)
#   hw      - full hardware build for VEK280 board
TARGET ?= hw

# PRECISION: float | int16
#   float - 32-bit floating point weights, activations, and output
#   int16 - 16-bit integer weights, activations, and output
#   NOTE: data/ files must contain values matching the chosen precision.
#         Clean and rebuild when switching: make clean_all
PRECISION ?= float

# EMU_PS: X86 | QEMU (auto-set based on TARGET, override if needed)
#   X86  - native x86 host binary (used for sw_emu)
#   QEMU - aarch64 cross-compiled host binary (used for hw_emu/hw)
ifeq ($(TARGET),$(filter $(TARGET),hw_emu hw))
  EMU_PS ?= QEMU
else
  EMU_PS ?= X86
endif

# Map PRECISION to PL DATA_TYPE (internal, no need to set manually)
ifeq ($(PRECISION),int16)
  PL_DATA_TYPE := int16
else
  PL_DATA_TYPE := float
endif
###########################################################################

LINK_CFG  := ./common/linker_aieml.cfg
HLS_KERNELS := track_average
XO_DIR    := pl/ip

######################  Artifacts and directories  #########################
AIE_WORK_DIR_NAME ?= Work
AIE_LIB   := aieml/$(AIE_WORK_DIR_NAME)/libadf.a
PL_XOS    := $(addprefix $(XO_DIR)/,$(addsuffix _hls.xo,$(HLS_KERNELS)))
BUILD_DIR := build_$(TARGET)
XSA       := $(BUILD_DIR)/design_$(TARGET).xsa
PKG_DIR   := package.$(TARGET)
XCLBIN    := $(PKG_DIR)/system_$(TARGET).xclbin
EXEC      := ./host.exe
###########################################################################

#########################  AIE target mapping  #############################
ifeq ($(TARGET),x86)
  AIE_TARGET := x86sim
else ifeq ($(TARGET),x86sim)
  AIE_TARGET := x86sim
else ifeq ($(TARGET),sw_emu)
  AIE_TARGET := x86sim
else
  AIE_TARGET := hw
endif


############################################################################
#  Top-level targets
############################################################################
.PHONY: all aie sim pl host link package run run_emu clean clean_all help print_vars

all: aie host pl link package

# AIE graph build (delegates to aieml/)
aie:
	$(MAKE) -C aieml TARGET=$(AIE_TARGET) PRECISION=$(PRECISION) PLATFORM=$(PLATFORM) WORK_DIR=$(AIE_WORK_DIR_NAME)

pl: $(PL_XOS)
	@echo "PL kernel artifacts ready: $(PL_XOS)"

# Simulation convenience wrapper (AIE-only)
sim:
	@echo "AIE sim with TARGET=$(AIE_TARGET) (from TARGET=$(TARGET))"
	$(MAKE) -C aieml sim TARGET=$(AIE_TARGET) PRECISION=$(PRECISION) PLATFORM=$(PLATFORM) WORK_DIR=$(AIE_WORK_DIR_NAME)

# Build host application (native x86 or cross for QEMU)
host:
	$(MAKE) -C host EMU_PS=$(EMU_PS) PRECISION=$(PRECISION)

$(PL_XOS):
	$(MAKE) -C pl TARGET=$(TARGET) KERNELS="$(HLS_KERNELS)" DATA_TYPE=$(PL_DATA_TYPE)

##############################  Link (XSA)  ################################
$(XSA): $(AIE_LIB) $(PL_XOS) $(LINK_CFG) | $(BUILD_DIR)
	@echo "Linking with:"
	@echo "    PL_XOS   = $(PL_XOS)"
	@echo "    AIE_LIB  = $(AIE_LIB)"
	@echo "    LINK_CFG = $(LINK_CFG)"
	v++ --link -t $(TARGET) --platform $(PLATFORM) --config $(LINK_CFG) \
		$(PL_XOS) $(AIE_LIB) -o $@
	@echo "Linked design: $@"

link: $(XSA)

$(BUILD_DIR):
	@mkdir -p $@

########################  v++ --package flags ##############################
PKG_COMMON = --platform $(PLATFORM) --package.out_dir $(PKG_DIR) \
             --package.defer_aie_run --package.sd_file $(EXEC) \
             --package.sd_dir data

ifeq ($(TARGET),sw_emu)
  ifeq ($(EMU_PS),X86)
    PKG_FLAGS = -t sw_emu
  else
    PKG_FLAGS = -t sw_emu \
      --package.rootfs $(ROOTFS) \
      --package.kernel_image $(IMAGE) \
      --config $(PACK_CFG)
  endif
else ifeq ($(TARGET),hw_emu)
  PKG_FLAGS = -t hw_emu \
      --package.rootfs $(ROOTFS) \
      --package.kernel_image $(IMAGE) \
      --config $(PACK_CFG)
else
  PKG_FLAGS = -t hw \
      --package.rootfs $(ROOTFS) \
      --package.kernel_image $(IMAGE) \
      --package.boot_mode sd \
      --config $(PACK_CFG)
endif

##############################  Package  ###################################
package: $(XCLBIN)

$(XCLBIN): $(AIE_LIB) $(XSA) $(EXEC) | $(PKG_DIR)
	@echo "Packaging with:"
	@echo "    AIE_LIB  = $(AIE_LIB)"
	@echo "    XSA      = $(XSA)"
	@echo "    EXEC     = $(EXEC)"
	v++ --package $(PKG_FLAGS) $(PKG_COMMON) \
		$(AIE_LIB) $(XSA) -o $@
	@echo "Packaged design created in $(PKG_DIR)"

$(PKG_DIR):
	@mkdir -p $@

##############################  Run helper  ################################
run_emu: host package
ifeq ($(TARGET),sw_emu)
  ifeq ($(EMU_PS),X86)
	@echo "Running SW-emulation on x86..."
	XCL_EMULATION_MODE=sw_emu $(EXEC) $(XCLBIN)
  else
	@echo "Running SW-emulation on QEMU..."
	$(PKG_DIR)/launch_sw_emu.sh -run-app $(EXEC) $(XCLBIN)
  endif
else ifeq ($(TARGET),hw_emu)
	@echo "Running HW-emulation on QEMU..."
	$(PKG_DIR)/launch_hw_emu.sh -run-app $(EXEC) $(XCLBIN)
else
	@echo "Copy '$(PKG_DIR)' to SD-card and boot the VEK280."
endif

run: run_emu

print_vars:
	@echo "TARGET       = $(TARGET)"
	@echo "PRECISION    = $(PRECISION)"
	@echo "PL_DATA_TYPE = $(PL_DATA_TYPE)"
	@echo "EMU_PS       = $(EMU_PS)"
	@echo "AIE_TARGET   = $(AIE_TARGET)"
	@echo "AIE_LIB      = $(AIE_LIB)"
	@echo "XSA          = $(XSA)"
	@echo "EXEC         = $(EXEC)"
	@echo "XCLBIN       = $(XCLBIN)"

################################  Clean  ###################################
clean:
	$(MAKE) -C pl clean TARGET=$(TARGET)
	rm -rf $(PKG_DIR) $(BUILD_DIR) *.xclbin *.xsa *.log _x host.exe

clean_all:
	$(MAKE) -C aieml    clean TARGET=$(AIE_TARGET)
	$(MAKE) -C host     clean
	$(MAKE) -C pl       clean TARGET=$(TARGET)
	rm -rf package.* build_* *.xclbin *.xsa *.log

help:
	@echo "Usage:"
	@echo "  make aie TARGET=x86 PRECISION=float     # Build AIE graph for x86sim (float)"
	@echo "  make aie TARGET=x86 PRECISION=int16     # Build AIE graph for x86sim (int16)"
	@echo "  make aie TARGET=hw PRECISION=float      # Build AIE graph for hardware"
	@echo "  make pl TARGET=hw_emu PRECISION=int16   # Build PL HLS kernels"
	@echo "  make sim TARGET=x86 PRECISION=float     # Run AIE x86 simulation"
	@echo "  make host TARGET=sw_emu PRECISION=float # Build host for native x86"
	@echo "  make host TARGET=hw_emu PRECISION=int16 # Build host for QEMU/aarch64"
	@echo "  make link TARGET=hw_emu                 # Create XSA"
	@echo "  make package TARGET=hw_emu              # Package and generate xclbin"
	@echo "  make run TARGET=sw_emu                  # Run SW emulation"
	@echo "  make print_vars                         # Show all build variables"
	@echo "  make clean                              # Clean PL + build artifacts"
	@echo "  make clean_all                          # Clean everything"
############################################################################
