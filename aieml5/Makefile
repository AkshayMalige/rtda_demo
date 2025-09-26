# ===================================================================
# Makefile for Vitis AIE Graph Compilation & Simulation
# ===================================================================

SHELL := /bin/bash

# ==== CONFIG ====
# Target platform for hardware compilation.
PLATFORM     ?= /tools/Xilinx/Vitis/2024.2/base_platforms/xilinx_vek280_base_202420_1/xilinx_vek280_base_202420_1.xpfm

# Target for compilation. Options: hw, hw_emu
TARGET       ?= hw

# Location of input/weight files used by PLIO connections (override from top-level)
# Defaults to the data directory in the parent rtda_demo directory
DATA_DIR    ?= ../data
DATA_DIR := $(abspath $(DATA_DIR))

# Path to your Vitis installation.
VITIS_PATH   ?= /tools/Xilinx/Vitis/2024.2

# ##########################################################################
# ##########################################################################
#
#   >>> IMPORTANT: YOU MUST EDIT THIS LINE <<<
#   Set this variable to the correct path for the Vitis_Libraries on your system.
#   Example: DSPLIB_PATH  ?= /home/user/vitis/Vitis_Libraries/dsp
#
# ##########################################################################
DSPLIB_PATH  ?= ../dsp_lib


# ==== PROJECT FILES & DIRECTORIES ====
GRAPH_SRC     := graph.cpp
WORK_DIR      := Work
GRAPH_LIB     := $(WORK_DIR)/libadf.a
AIE_CFG       := aie.cfg


# ==== TOOLS ====
VPP          := v++
AIESIM       := aiesimulator


# ==== COMPILER FLAGS ====
# Include paths for the AIE compiler.
AIE_INCLUDE_FLAGS := \
	--include="./" \
	--include="../common" \
	--include="$(DSPLIB_PATH)/L1/src/aie" \
	--include="$(DSPLIB_PATH)/L1/include/aie" \
	--include="$(DSPLIB_PATH)/L2/include/aie"

# Full v++ command flags, assembled from variables above.
VPP_FLAGS := \
	-c \
	--mode aie \
	--target=$(TARGET) \
	--platform=$(PLATFORM) \
	--work_dir=$(WORK_DIR) \
	--config=$(AIE_CFG) \
	$(AIE_INCLUDE_FLAGS)


# ==== RULES ====

.PHONY: all graph sim clean

# --- Default Target ---
all: graph

# --- AIE Graph Compilation ---
graph: $(GRAPH_LIB)

$(GRAPH_LIB): $(GRAPH_SRC) stream_to_packet.cpp hidden_stream_to_packet.cpp packet_to_stream.cpp graph.h leaky_relu.h leaky_relu.cpp hidden_stream_to_packet.h stream_to_packet.h packet_to_stream.h ../common/nn_defs.h ../common/data_paths.h $(AIE_CFG)
	@mkdir -p $(WORK_DIR)
	@echo "--- Compiling AIE Graph for TARGET=$(TARGET) ---"
	@echo "INFO: Using Vitis DSP Library Path: $(DSPLIB_PATH)"
	@if [ ! -d "$(DSPLIB_PATH)" ]; then \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		echo "!!! ERROR: Directory not found: '$(DSPLIB_PATH)'"; \
		echo "!!! Please set the DSPLIB_PATH variable in your Makefile correctly."; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		exit 1; \
	fi
	@set -o pipefail; \
        $(VPP) $(VPP_FLAGS) $(GRAPH_SRC) stream_to_packet.cpp hidden_stream_to_packet.cpp packet_to_stream.cpp 2>&1 | tee $(WORK_DIR)/vpp_aie.log
	@echo "COMPLETE: AIE graph compiled."

# --- Simulation ---
sim: graph
	@echo "--- Starting AI Engine simulation (aiesimulator) ---"
	DATA_DIR=$(abspath $(DATA_DIR)) $(AIESIM) --pkg-dir=$(WORK_DIR) --profile --dump-vcd=foo --output-time-stamp=no
	@echo "COMPLETE: AI Engine simulation finished."

# --- Clean Target ---
clean:
	@echo "--- Cleaning Workspace ---"
	rm -rf $(WORK_DIR) .Xil *.log *.csv *.db *.aiecompile_summary \
	       aiesimulator_output build_hw \
	       pl_sample* *.a .AIE_SIM_CMD_LINE_OPTIONS ISS_RPC_SERVER_PORT \
	       *.json *.vcd
	@echo "CLEANED: Build and work directories removed."
