# Toolchain and paths
SYSROOT ?= /opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux
CXX     := aarch64-linux-gnu-g++
# Default data directory lives one level above the project root
HOST_EXE     = ../host.exe
HOST_OBJ   = aie_control_xrt.o host.o
AIE_CTRL_CPP = ../Work/ps/c_rts/aie_control_xrt.cpp
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
	-lstdc++ -lxrt_coreutil -lxrt_core -lpthread -ladf_api_xrt -lgcc -lc -lxilinxopencl -lrt -ldl -lcrypt -L$(XILINX_VITIS)/aietools/lib/aarch64.o

.PHONY: all clean

# all: $(OUT)

${HOST_EXE}: ${HOST_OBJ}
	${CXX} -o $@ $^ ${LDFLAGS}

%.o: %.cpp
	${CXX} ${CXXFLAGS} -o $@ $<


aie_control_xrt.cpp: ${AIE_CTRL_CPP}
	cp -f ${AIE_CTRL_CPP} .

clean:
	rm -f $(OBJ) $(OUT) *.log ${HOST_OBJ} .Xil ${HOST_EXE} aie_control_xrt.cpp
	@echo "🧹 Cleaned up build artifacts"
