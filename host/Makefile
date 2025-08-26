# Simple Makefile to build host.cpp

# Toolchain and paths
SYSROOT ?= /opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux
CXX     := aarch64-linux-gnu-g++
# Default data directory lives one level above the project root
DATA_DIR ?= $(abspath ../../data)
export DATA_DIR

# Sources and targets
SRC := host.cpp
OUT ?= system_host

# Compiler and linker flags
CXXFLAGS ?= -Wall -std=c++17 -Wno-int-to-pointer-cast \
        --sysroot=$(SYSROOT) \
        -I$(SYSROOT)/usr/include/xrt \
        -I$(SYSROOT)/usr/include \
        -I./ -I../common -I/aietools/include -I/include \
        -DDATA_DIR='"$(DATA_DIR)"'

LDFLAGS ?= --sysroot=$(SYSROOT) \
        -L$(SYSROOT)/usr/lib \
        -lstdc++ -lxrt_coreutil -lxrt_core -lpthread

.PHONY: all clean

all: $(OUT)

$(OUT): $(SRC)
	$(CXX) $(CXXFLAGS) $< $(LDFLAGS) -o $@
	@echo "✅ Built host executable: $(OUT)"

clean:
	rm -f $(OUT) *.log
	@echo "🧹 Cleaned up build artifacts"
