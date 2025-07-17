# ==============================================
#   Makefile: AIE Graph + Host Compilation
# ==============================================

# ==== CONFIG ====
PLATFORM    ?= xilinx_vek280_base_202420_1
TARGET      ?= hw                # Options: hw or x86sim
PL_FREQZ    ?= 300

GRAPH_SRC   := graph.cpp
HOST_SRC    := host.cpp

BUILD_DIR   := build_$(TARGET)
WORK_DIR    := Work

LIB_ADF     := $(BUILD_DIR)/libadf.a
HOST_EXE    := $(BUILD_DIR)/host.exe

# Tools
AIECC       := aiecompiler
AIESIM      := aiesimulator
X86SIM      := x86simulator
CXX         := g++

VITIS_PATH  ?= /tools/Xilinx/Vitis/2024.2
DSPLIB_PATH ?= /home/synthara/VersalPrjs/Vitis_Libraries/dsp

# AIE Includes
AIE_INCLUDE_FLAGS := \
	--include="$(DSPLIB_PATH)/L2/include/aie" \
	--include="$(DSPLIB_PATH)/L1/include/aie" \
	--include="$(DSPLIB_PATH)/L1/src/aie" \
	--include="./kernels" \
	--include="./data"

# AIE Compiler Flags
AIE_FLAGS := --platform=$(PLATFORM) $(AIE_INCLUDE_FLAGS) --pl-freq=$(PL_FREQZ)
ifeq ($(TARGET),x86sim)
	AIE_FLAGS += --target=x86sim
else
	AIE_FLAGS += --target=hw
endif

AIE_FLAGS += -D__AIESIM__

# Host Includes (for matrix_vector_mul_graph.hpp visibility)
HOST_INCLUDE_FLAGS := \
	-I$(WORK_DIR) \
	-I$(VITIS_PATH)/aietools/include/aie \
	-I$(DSPLIB_PATH)/L2/include/aie \
	-I$(DSPLIB_PATH)/L1/include/aie \
	-I$(DSPLIB_PATH)/L1/src/aie \
	-I/opt/xilinx/xrt/include

# ==== RULES ====

.PHONY: all graph host sim clean

all: graph host

# -------- AIE Graph Compilation --------
graph: $(LIB_ADF)

$(LIB_ADF): $(GRAPH_SRC)
	@mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR); \
	$(AIECC) $(AIE_FLAGS) ../$(GRAPH_SRC) --workdir=../$(WORK_DIR) 2>&1 | tee aiecompiler.log
	@echo "COMPLETE: AIE Graph compiled → $(LIB_ADF)"

# -------- Host Application Compilation --------
host: $(HOST_EXE)

$(HOST_EXE): $(HOST_SRC) $(LIB_ADF)
	@mkdir -p $(BUILD_DIR)
	$(CXX) -std=c++17 $(HOST_SRC) -o $(HOST_EXE) \
		$(HOST_INCLUDE_FLAGS) \
		-L$(VITIS_PATH)/aietools/lib/lnx64.o -lxaiengine \
		-Wl,-rpath-link,$(VITIS_PATH)/aietools/lib/lnx64.o
	@echo "COMPLETE: Host application built → $(HOST_EXE)"

# -------- Simulation --------
sim:
ifeq ($(TARGET),x86sim)
	cd $(BUILD_DIR); $(X86SIM) --pkg-dir=../$(WORK_DIR) --i=..; \
	echo "COMPLETE: x86sim simulation finished."
else
	cd $(BUILD_DIR); $(AIESIM) --pkg-dir=../$(WORK_DIR) --i=.. --profile --dump-vcd=waveform.vcd; \
	echo "COMPLETE: AIE hardware simulation finished."
endif

# -------- Clean --------
clean:
	rm -rf $(BUILD_DIR) $(WORK_DIR) .Xil
	rm -f *.log *.a *.csv *.db
	@echo "CLEANED: Build + Work directories removed."