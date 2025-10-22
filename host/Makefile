# Makefile to build host app for AI Engine-only graph (no PL kernels)

# Inputs from top-level
TARGET ?= sw_emu
EMU_PS ?= X86

# Default data directory (top-level exports this already)
DATA_DIR ?= $(abspath ../../data)
export DATA_DIR

# Cross sysroot for QEMU/board builds
SYSROOT ?= /opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux

# Select compiler per emulation mode
ifeq ($(EMU_PS),X86)
  HOST_NATIVE := 1
else
  HOST_NATIVE := 0
endif

# Sanitize environment contamination from cross toolchains when building natively
ifeq ($(HOST_NATIVE),1)
  ifneq ($(strip $(OECORE_TARGET_SYSROOT)),)
    $(warning Detected Petalinux SDK environment (OECORE_TARGET_SYSROOT=$(OECORE_TARGET_SYSROOT)) while EMU_PS=X86; using native toolchain)
  endif
  ifneq ($(findstring aarch64,$(CXX)),)
    $(warning CXX appears to be cross-compiler '$(CXX)'; overriding to native g++)
  endif
  override CXX := g++
  # Ignore any inherited SYSROOT for native build
  ifneq ($(strip $(SYSROOT)),)
    $(warning Ignoring SYSROOT='$(SYSROOT)' for native build (EMU_PS=X86))
  endif
  override SYSROOT :=
else
  override CXX := aarch64-linux-gnu-g++
endif

SRC := host.cpp
OBJ := $(SRC:.cpp=.o)
OUT ?= system_host

COMMON_INC := -I./ -I../common -I../aieml

ifeq ($(HOST_NATIVE),1)
  # Native (x86) build uses XRT from the host install
  XRT_ROOT ?= $(XILINX_XRT)
  ifeq ($(strip $(XRT_ROOT)),)
    XRT_ROOT := /opt/xilinx/xrt
  endif
  override CXXFLAGS := -Wall -Wextra -O2 -std=c++17 -c \
                       -I$(XRT_ROOT)/include \
                       $(COMMON_INC) \
                       -DDATA_DIR='"$(DATA_DIR)"'
  override LDFLAGS  := -L$(XRT_ROOT)/lib -Wl,-rpath,$(XRT_ROOT)/lib \
                       -lxrt_coreutil -lxrt_core -lpthread
else
  override CXXFLAGS := -Wall -Wextra -O2 -std=c++17 -c \
                       --sysroot=$(SYSROOT) \
                       -I$(SYSROOT)/usr/include/xrt -I$(SYSROOT)/usr/include \
                       $(COMMON_INC) \
                       -DDATA_DIR='"$(DATA_DIR)"'
  override LDFLAGS  := --sysroot=$(SYSROOT) -L$(SYSROOT)/usr/lib \
                       -lxrt_coreutil -lxrt_core -lpthread
endif

.PHONY: all clean

all: $(OUT)

$(OBJ): $(SRC)
	$(CXX) $(CXXFLAGS) -o $@ $<

$(OUT): $(OBJ)
	$(CXX) $^ $(LDFLAGS) -o $@
	@echo "✅ Built host executable: $(OUT)"

clean:
	rm -f $(OBJ) $(OUT) *.log
	@echo "🧹 Cleaned up build artifacts"
