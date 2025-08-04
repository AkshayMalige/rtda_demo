################################################################################
# Top-level Makefile - orchestrates sub-project builds and higher level targets
################################################################################

# Build configuration
TARGET   ?= hw_emu
PLATFORM ?= xilinx_vek280_base_202420_1

# Config files
LINK_CFG := common/linker.cfg
PACK_CFG := pack.cfg

# Directories and artefacts
PKG_DIR   := pack_out_dir
BUILD_DIR := build

KERNELS   := mm2s leaky_relu leaky_splitter s2mm
XO_FILES  := $(addsuffix _hls.xo,$(addprefix pl/ip/,$(KERNELS)))
AIE_LIB   := aieml/libadf.a
HOST_EXE  := host/system_host
LINK_OUT  := $(BUILD_DIR)/design_$(TARGET).xsa
XCLBIN    := $(PKG_DIR)/system_$(TARGET).xclbin
POST_BOOT := $(PKG_DIR)/post_boot.sh

SUBOPTS   := TARGET=$(TARGET) PLATFORM=$(PLATFORM)

# Use '>' instead of TAB for recipe lines
.RECIPEPREFIX := >

.PHONY: all link package run clean clean_all

all: link

# ------------------------------------------------------------------------------

$(XO_FILES):
> test -f $@ || $(MAKE) -C pl $(SUBOPTS)

$(AIE_LIB):
> test -f $@ || $(MAKE) -C aieml $(SUBOPTS)

$(HOST_EXE):
> test -f $@ || $(MAKE) -C host $(SUBOPTS)

# ------------------------------------------------------------------------------

$(LINK_OUT): $(XO_FILES) $(AIE_LIB)
> mkdir -p $(BUILD_DIR)
> v++ -l -t $(TARGET) --platform $(PLATFORM) --config $(LINK_CFG) \
>     $(XO_FILES) $(AIE_LIB) -o $@

link: $(LINK_OUT)

$(XCLBIN): $(LINK_OUT) $(HOST_EXE) $(AIE_LIB)
> mkdir -p $(PKG_DIR)
> v++ -p -t $(TARGET) --platform $(PLATFORM) --config $(PACK_CFG) \
>     --package.out_dir $(PKG_DIR) --package.sd_file $(HOST_EXE) \
>     $(LINK_OUT) $(AIE_LIB) -o $@

package: $(XCLBIN)

run: $(POST_BOOT)
> cd $(PKG_DIR); ./launch_hw_emu.sh -run-app post_boot.sh

$(POST_BOOT): package
> cat <<'EOT' > $@
> #!/bin/bash
>
> export XILINX_XRT=/usr
>
> ./system_host system_$(TARGET).xclbin
> EOT
> chmod +x $@

# ------------------------------------------------------------------------------

clean:
> rm -rf $(BUILD_DIR) $(PKG_DIR) $(XCLBIN) $(LINK_OUT) *.log

clean_all: clean
> $(MAKE) -C pl clean $(SUBOPTS) || true
> $(MAKE) -C aieml clean $(SUBOPTS) || true
> $(MAKE) -C host clean $(SUBOPTS) || true