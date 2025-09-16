# Toolchain and paths
SYSROOT ?= /opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux
CXX     := aarch64-linux-gnu-g++
# Default data directory lives one level above the project root
HOST_EXE     = ../host.exe
# Sources and targets
SRC := host.cpp
OBJ := $(SRC:.cpp=.o)
OUT ?= ../system_host


# Compiler and linker flags
CXXFLAGS ?= -Wall -c -std=c++17 -Wno-int-to-pointer-cast \
        --sysroot=$(SYSROOT) \
        -I$(SYSROOT)/usr/include/xrt \
        -I$(SYSROOT)/usr/include \
        -I./ -I./src/ -I../aie -I$(XILINX_VITIS)/aietools/include 

LDFLAGS ?= --sysroot=$(SYSROOT) \
        -L$(SYSROOT)/usr/lib \
        -lstdc++ -lxrt_coreutil -lxrt_core -lpthread -lgcc -lc -lxilinxopencl -lrt -ldl -lcrypt

.PHONY: all clean

# all: $(OUT)

${HOST_EXE}: ${OBJ}
	${CXX} -o $@ $^ ${LDFLAGS}

%.o: %.cpp
	${CXX} ${CXXFLAGS} -o $@ $<


clean:
	rm -f $(OBJ) $(OUT) *.log .Xil ${HOST_EXE} aie_control_xrt.cpp
	@echo "🧹 Cleaned up build artifacts"
