# Makefile to compile host.cpp for PetaLinux sysroot using aarch64-linux-gnu-g++

# Paths
SYSROOT := /opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux
CXX := aarch64-linux-gnu-g++

# Sources and targets
SRC := host.cpp
OBJ := host.o
OUT := system_host

# Compiler and linker flags
CXXFLAGS := -Wall -c -std=c++17 -Wno-int-to-pointer-cast \
  --sysroot=$(SYSROOT) \
  -I$(SYSROOT)/usr/include/xrt \
  -I$(SYSROOT)/usr/include \
  -I./ -I./src/ -I/aietools/include -I/include

LDFLAGS := --sysroot=$(SYSROOT) \
  -L$(SYSROOT)/usr/lib \
  -lstdc++ -lxrt_coreutil -lxrt_core -lpthread

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
