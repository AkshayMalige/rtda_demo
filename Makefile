############################################################################
#  Top-level Makefile — AIE graph + Host + Package
#  TARGET = sw_emu | hw_emu | hw
#  EMU_PS = X86 | QEMU (host build mode)
############################################################################

######################## ▶ User-specific paths ◀ ###########################
XILINX_VITIS   ?= /tools/Xilinx/2025.1/Vitis
PLATFORM       ?= xilinx_vek280_base_202510_1
EDGE_COMMON_SW ?= /home/synthara/versal_common/xilinx-versal-common-v2024.2
IMAGE          ?= $(EDGE_COMMON_SW)/Image
ROOTFS         ?= $(EDGE_COMMON_SW)/rootfs.ext4
PACK_CFG       ?= ./pack.cfg
###########################################################################

##################### Build-time variables / defaults ######################
TARGET ?= hw
# Default host build: native for sw_emu, QEMU for hw_emu/hw
ifeq ($(TARGET),$(filter $(TARGET),hw_emu hw))
  EMU_PS ?= QEMU
else
  EMU_PS ?= X86
endif
###########################################################################

######################  Artifacts and directories  #########################
# Allow overriding the AIE work directory name used under aieml/
AIE_WORK_DIR_NAME ?= Work
AIE_LIB   := aieml/$(AIE_WORK_DIR_NAME)/libadf.a
BUILD_DIR := build_$(TARGET)
XSA       := $(BUILD_DIR)/design_$(TARGET).xsa
PKG_DIR   := package.$(TARGET)
XCLBIN    := $(PKG_DIR)/system_$(TARGET).xclbin
# Host executable is produced at repo root by host/Makefile
EXEC      := ./host.exe
###########################################################################

#########################  AIE target mapping  #############################
# Map top-level TARGET to AIE graph TARGET expected by aieml/Makefile
#  - x86, x86sim, sw_emu  -> x86sim
#  - hw, hw_emu           -> hw
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
.PHONY: all aie sim host link package run run_emu clean clean_all help print_vars

all: aie host link package

# AIE graph build (delegates to aieml/)
aie:
	$(MAKE) -C aieml TARGET=$(AIE_TARGET) PLATFORM=$(PLATFORM) WORK_DIR=$(AIE_WORK_DIR_NAME)

# Simulation convenience wrapper (AIE-only)
sim:
	@echo "▶ AIE sim with TARGET=$(AIE_TARGET) (from TARGET=$(TARGET))"
	$(MAKE) -C aieml sim TARGET=$(AIE_TARGET) PLATFORM=$(PLATFORM) WORK_DIR=$(AIE_WORK_DIR_NAME)

# Build host application (native x86 or cross for QEMU)
host:
	$(MAKE) -C host EMU_PS=$(EMU_PS)

##############################  Link (XSA)  ################################
# Create XSA by linking the AIE graph only
$(XSA): $(AIE_LIB) | $(BUILD_DIR)
	@echo "🔗 Linking (v++) AIE-only system to create XSA: $@"
	v++ -l -t $(TARGET) --platform $(PLATFORM) $(AIE_LIB) -o $@
	@echo "✅ XSA created: $@"

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

# Ensure host app exists before packaging so it's copied to the SD image
$(XCLBIN): $(AIE_LIB) $(XSA) $(EXEC) | $(PKG_DIR)
	@echo "📦 Packaging with:"
	@echo "    AIE_LIB  = $(AIE_LIB)"
	@echo "    XSA      = $(XSA)"
	@echo "    EXEC     = $(EXEC)"
	v++ --package $(PKG_FLAGS) $(PKG_COMMON) \
		$(AIE_LIB) $(XSA) -o $@
	@echo "✅ Packaged design created in $(PKG_DIR)"

$(PKG_DIR):
	@mkdir -p $@

##############################  Run helper  ################################
# Unified emulation run target
run_emu: host package
ifeq ($(TARGET),sw_emu)
  ifeq ($(EMU_PS),X86)
	@echo "▶ Running SW-emulation on x86 …"
	XCL_EMULATION_MODE=sw_emu $(EXEC) $(XCLBIN)
  else
	@echo "▶ Running SW-emulation on QEMU …"
	$(PKG_DIR)/launch_sw_emu.sh -run-app $(EXEC) $(XCLBIN)
  endif
else ifeq ($(TARGET),hw_emu)
	@echo "▶ Running HW-emulation on QEMU …"
	$(PKG_DIR)/launch_hw_emu.sh -run-app $(EXEC) $(XCLBIN)
else
	@echo "▶ Copy '$(PKG_DIR)' to SD-card and boot the VEK280."
endif

# Backwards compatible alias
run: run_emu

print_vars:
	@echo "TARGET     = $(TARGET)"
	@echo "EMU_PS     = $(EMU_PS)"
	@echo "AIE_TARGET = $(AIE_TARGET)"
	@echo "AIE_LIB    = $(AIE_LIB)"
	@echo "XSA        = $(XSA)"
	@echo "EXEC       = $(EXEC)"
	@echo "XCLBIN     = $(XCLBIN)"

################################  Clean  ###################################
clean:
	rm -rf $(PKG_DIR) $(BUILD_DIR) *.xclbin *.xsa *.log

clean_all:
	$(MAKE) -C aieml    clean TARGET=$(AIE_TARGET)
	$(MAKE) -C host     clean
	rm -rf package.* build_* *.xclbin *.xsa *.log

help:
	@echo "Usage:"
	@echo "  make aie TARGET=x86            # Build AIE graph for x86sim"
	@echo "  make aie TARGET=hw             # Build AIE graph for hardware model"
	@echo "  make sim TARGET=x86            # Run AIE x86 simulation"
	@echo "  make sim TARGET=hw             # Run AIE cycle-accurate sim"
	@echo "  make host TARGET=sw_emu        # Build host for native x86"
	@echo "  make host TARGET=hw_emu        # Build host for QEMU/aarch64"
	@echo "  make link TARGET=sw_emu        # Create XSA from AIE graph"
	@echo "  make package TARGET=sw_emu     # Package and generate xclbin"
	@echo "  make run TARGET=sw_emu         # Run SW emulation"
############################################################################
