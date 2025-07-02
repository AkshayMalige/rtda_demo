# AIE-only Makefile for compiling and simulating graph.cpp

# ==== CONFIG ====
PLATFORM ?= xilinx_vek280_base_202420_1
TARGET ?= hw                          # or sw_emu, x86sim
PL_FREQZ ?= 300

GRAPH_SRC := src/graph.cpp
GRAPH_OUT := Work/libadf.a
WORK_DIR := Work
BUILD_DIR := build_$(TARGET)

# Tools
AIECC := aiecompiler
AIESIM := aiesimulator
X86SIM := x86simulator

# AIE Include paths
AIE_INCLUDE_FLAGS := \
	-include="$(XILINX_VITIS)/aietools/include" \
	-include="./src/" \
	-include="./data" \
	-include="./"

# Compiler flags
AIE_FLAGS := --platform $(PLATFORM) $(AIE_INCLUDE_FLAGS) --pl-freq=$(PL_FREQZ)

ifeq ($(TARGET),sw_emu)
	AIE_FLAGS += --target=x86sim -Xpreproc='-DNDEBUG'
else ifeq ($(TARGET),x86sim)
	AIE_FLAGS += --target=x86sim -Xpreproc='-DNDEBUG'
else
	AIE_FLAGS += --target=hw
endif

# ==== RULES ====

.PHONY: all graph sim clean

all: graph

graph: $(BUILD_DIR)/libadf.a

$(BUILD_DIR)/libadf.a: $(GRAPH_SRC)
	@mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR); \
	$(AIECC) $(AIE_FLAGS) ../$(GRAPH_SRC) --workdir=../$(WORK_DIR) 2>&1 | tee aiecompiler.log
	@echo "COMPLETE: AIE graph compiled into $(BUILD_DIR)/libadf.a"

sim:
ifeq ($(TARGET),x86sim)
	@cd $(BUILD_DIR); \
	$(X86SIM) --pkg-dir=../$(WORK_DIR) --i=..; \
	echo "COMPLETE: x86sim simulation finished."
else
	@cd $(BUILD_DIR); \
	$(AIESIM) --pkg-dir=../$(WORK_DIR) --i=.. --profile --dump-vcd=waveform.vcd; \
	echo "COMPLETE: AIE simulation finished."
endif

clean:
	rm -rf $(BUILD_DIR) $(WORK_DIR)
	@echo "CLEANED: Removed build and work directories"