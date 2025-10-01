# ===================================================================
# Makefile for Vitis AIE Graph Compilation & Simulation
# ===================================================================

SHELL := /bin/bash

# ==== CONFIG ====
PLATFORM     ?= /tools/Xilinx/Vitis/2024.2/base_platforms/xilinx_vek280_base_202420_1/xilinx_vek280_base_202420_1.xpfm
TARGET       ?= hw
DATA_DIR    ?= ../data
DATA_DIR := $(abspath $(DATA_DIR))
VITIS_PATH   ?= /tools/Xilinx/Vitis/2024.2
DSPLIB_PATH  ?= ../dsp_lib

# ==== PROJECT FILES & DIRECTORIES ====
GRAPH_SRC     := graph.cpp
WORK_DIR      := Work
GRAPH_LIB     := $(WORK_DIR)/libadf.a
AIE_CFG       := aie.cfg
KERNEL_SRCS   := \
        leaky_relu.cpp \
        window_split_128_to_64x2.cpp \
        roll_concat.cpp \
        bias_add.cpp
KERNEL_HDRS   := $(KERNEL_SRCS:.cpp=.h)

# ==== TOOLS ====
VPP          := v++
AIESIM       := aiesimulator

# ==== COMPILER FLAGS ====
AIE_INCLUDE_FLAGS := \
        --include="./" \
        --include="../common" \
        --include="$(DSPLIB_PATH)/L1/src/aie" \
        --include="$(DSPLIB_PATH)/L1/include/aie" \
        --include="$(DSPLIB_PATH)/L2/include/aie"

VPP_FLAGS := \
        -c \
        --mode aie \
        --target=$(TARGET) \
        --platform=$(PLATFORM) \
        --work_dir=$(WORK_DIR) \
        $(AIE_INCLUDE_FLAGS)

.PHONY: all graph sim clean

all: graph

graph: $(GRAPH_LIB)

$(GRAPH_LIB): $(GRAPH_SRC) $(KERNEL_SRCS) $(KERNEL_HDRS) graph.h ../common/nn_defs.h ../common/data_paths.h $(AIE_CFG)
	@mkdir -p $(WORK_DIR)
	@echo "--- Compiling AIE Graph for TARGET=$(TARGET) ---"
	@echo "INFO: Using Vitis DSP Library Path: $(DSPLIB_PATH)"
	@if [ ! -d "$(DSPLIB_PATH)" ]; then \
		@echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		@echo "!!! ERROR: Directory not found: '$(DSPLIB_PATH)'"; \
		@echo "!!! Please set the DSPLIB_PATH variable in your Makefile correctly."; \
		@echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		@exit 1; \
	fi
	@set -o pipefail; \
$(VPP) $(VPP_FLAGS) $(GRAPH_SRC) $(KERNEL_SRCS) 2>&1 | tee $(WORK_DIR)/vpp_aie.log
	@echo "COMPLETE: AIE graph compiled."

sim: graph
	@echo "--- Starting AI Engine simulation (aiesimulator) ---"
	DATA_DIR=$(abspath $(DATA_DIR)) $(AIESIM) --pkg-dir=$(WORK_DIR) --profile --dump-vcd=foo --output-time-stamp=no
	@echo "COMPLETE: AI Engine simulation finished."

clean:
	@echo "--- Cleaning Workspace ---"
	rm -rf $(WORK_DIR) .Xil *.log *.csv *.db *.aiecompile_summary \
	aiesimulator_output build_hw \
	pl_sample* *.a .AIE_SIM_CMD_LINE_OPTIONS ISS_RPC_SERVER_PORT \
	*.json *.vcd
	@echo "CLEANED: Build and work directories removed."
