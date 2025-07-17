# ===================================================================
# Makefile for Vitis AIE Graph Compilation & Simulation
# Style adapted from user-provided example.
# ===================================================================

# ==== CONFIG ====
# Target platform for hardware compilation.
PLATFORM     ?= /tools/Xilinx/Vitis/2024.1/base_platforms/xilinx_vek280_es1_base_202410_1/xilinx_vek280_es1_base_202410_1.xpfm

# Target for compilation and simulation. Options: x86sim, hw
TARGET       ?= x86sim

# Frequency for the Programmable Logic (PL) interfaces.
PL_FREQZ     ?= 300

# Path to your Vitis installation.
VITIS_PATH   ?= /tools/Xilinx/Vitis/2024.1

# Path to the Vitis DSP Library.
DSPLIB_PATH  ?= /path/to/your/Vitis_Libraries/dsp


# ==== PROJECT FILES & DIRECTORIES ====
GRAPH_SRC     := graph.cpp
WORK_DIR      := Work
GRAPH_LIB     := $(WORK_DIR)/libadf.a


# ==== TOOLS ====
AIECC        := aiecompiler
AIESIM       := aiesimulator
X86SIM       := x86simulator


# ==== COMPILER FLAGS ====
# Include paths for the AIE compiler.
AIE_INCLUDE_FLAGS := \
	--include="./" \
	--include="$(DSPLIB_PATH)/L2/include/aie" \
	--include="$(DSPLIB_PATH)/L1/include/aie" \
	--include="$(DSPLIB_PATH)/L1/src/aie"

# Full AIE compiler command flags, assembled from variables above.
AIE_FLAGS := \
	--v \
	--platform=$(PLATFORM) \
	--target=$(TARGET) \
	--pl-freq=$(PL_FREQZ) \
	$(AIE_INCLUDE_FLAGS)


# ==== RULES ====

.PHONY: all graph sim clean

# --- Default Target ---
# Builds the graph based on the TARGET variable.
all: graph

# --- AIE Graph Compilation ---
# This rule creates the work directory and compiles the graph.
# The output library (libadf.a) is placed in the WORK_DIR.
graph: $(GRAPH_LIB)

$(GRAPH_LIB): $(GRAPH_SRC) graph.h include.h
	@mkdir -p $(WORK_DIR)
	@echo "--- Compiling AIE Graph for TARGET=$(TARGET) ---"
	$(AIECC) $(AIE_FLAGS) $(GRAPH_SRC) --workdir=$(WORK_DIR) 2>&1 | tee $(WORK_DIR)/aiecompiler.log
	@echo "COMPLETE: AIE graph compiled."

# --- Simulation ---
# This rule depends on the graph being built and then runs the
# appropriate simulator based on the TARGET variable.
sim: graph
ifeq ($(TARGET),x86sim)
	@echo "--- Starting x86 Simulation ---"
	$(X86SIM) --pkg-dir=$(WORK_DIR)
	@echo "COMPLETE: x86sim simulation finished."
else
	@echo "--- Starting Hardware Simulation (aiesimulator) ---"
	$(AIESIM) --pkg-dir=$(WORK_DIR) --profile
	@echo "COMPLETE: Hardware simulation finished."
endif

# --- Clean Target ---
# Removes all generated files and directories.
clean:
	@echo "--- Cleaning Workspace ---"
	rm -rf $(WORK_DIR) .Xil *.log *.csv *.db *.aiecompile_summary
	@echo "CLEANED: Build and work directories removed."

