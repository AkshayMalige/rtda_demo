# ===================================================================
# Makefile for Vitis AIE Graph Compilation & Simulation (aieml10)
# ===================================================================

SHELL := /bin/bash

# ==== CONFIG ====
PLATFORM     ?= /tools/Xilinx/Vitis/2024.2/base_platforms/xilinx_vek280_base_202420_1/xilinx_vek280_base_202420_1.xpfm
TARGET       ?= hw

# Data directory (override from top-level)
DATA_DIR    ?= ../data
DATA_DIR := $(abspath $(DATA_DIR))

# Vitis installs
VITIS_PATH   ?= /tools/Xilinx/Vitis/2024.2

# DSP library path (edit if needed)
DSPLIB_PATH  ?= ../dsp_lib

# ==== PROJECT FILES & DIRECTORIES ====
GRAPH_SRC     := graph.cpp
WORK_DIR      := Work
GRAPH_LIB     := $(WORK_DIR)/libadf.a
AIE_CFG       := aie.cfg
KERNEL_SRCS   := \
	bias_relu_fused.cpp \
	window_split_128_to_64x2.cpp \
	roll_concat.cpp
KERNEL_HDRS   := $(KERNEL_SRCS:.cpp=.h)

# ==== TOOLS ====
VPP          := v++
AIESIM       := aiesimulator
 
# Extra args for aiesimulator (e.g., --trace)
AIESIM_ARGS  ?=

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
	--config=$(AIE_CFG) \
	$(AIE_INCLUDE_FLAGS)

.PHONY: all graph sim clean

all: graph

graph: $(GRAPH_LIB)

$(GRAPH_LIB): $(GRAPH_SRC) $(KERNEL_SRCS) $(KERNEL_HDRS) graph.h ../common/data_paths.h nn_defs10.h $(AIE_CFG)
	@mkdir -p $(WORK_DIR)
	@echo "--- Compiling AIEML10 AIE Graph for TARGET=$(TARGET) ---"
	@echo "INFO: Using Vitis DSP Library Path: $(DSPLIB_PATH)"
	@if [ ! -d "$(DSPLIB_PATH)" ]; then \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		echo "!!! ERROR: Directory not found: '$(DSPLIB_PATH)'"; \
		echo "!!! Please set the DSPLIB_PATH variable in your Makefile correctly."; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		exit 1; \
	fi
	@set -o pipefail; \
	$(VPP) $(VPP_FLAGS) $(GRAPH_SRC) $(KERNEL_SRCS) 2>&1 | tee $(WORK_DIR)/vpp_aie.log
	@echo "COMPLETE: AIE graph compiled."

sim: graph
	@echo "--- Starting AIEML10 AI Engine simulation (aiesimulator) ---"
	# Write simulator outputs under Work/ to keep artifacts together
	DATA_DIR=$(abspath $(DATA_DIR)) $(AIESIM) --pkg-dir=$(WORK_DIR) \
		--output-dir=$(WORK_DIR)/aiesimulator_output \
		--profile --online -wdb -text --output-time-stamp=no $(AIESIM_ARGS)
	@echo "COMPLETE: AI Engine simulation finished."

.PHONY: sim-trace vcd

# Enable timeline trace in aiesimulator
sim-trace:
	$(MAKE) sim AIESIM_ARGS="--trace"

# Convert the latest WDB to a VCD using wdb2vcd (Vivado/XSIM tool)
vcd:
	@WDB=$$(ls -1t function_wdb_dir/*.wdb 2>/dev/null | head -n1); \
	if [ -z "$$WDB" ]; then \
	  WDB=$$(ls -1t $(WORK_DIR)/function_wdb_dir/*.wdb 2>/dev/null | head -n1); \
	fi; \
	if [ -z "$$WDB" ]; then \
	  echo "No WDB found. Run 'make sim' first."; exit 1; \
	fi; \
	if command -v wdb2vcd >/dev/null 2>&1; then \
	  OUT=aiesim.vcd; echo "Converting $$WDB -> $$OUT"; wdb2vcd "$$WDB" "$$OUT"; \
	else \
	  echo "wdb2vcd not found on PATH. Try Vivado's bin or open WDB in Vivado Wave."; exit 1; \
	fi

clean:
	@echo "--- Cleaning Workspace ---"
	rm -rf $(WORK_DIR) .Xil *.log *.csv *.db *.aiecompile_summary \
		aiesimulator_output $(WORK_DIR)/aiesimulator_output \
		build_hw trdata.aiesim function_wdb_dir $(WORK_DIR)/function_wdb_dir\
		pl_sample* *.a .AIE_SIM_CMD_LINE_OPTIONS ISS_RPC_SERVER_PORT \
		*.json *.vcd *.wcfg *.wdb
	@echo "CLEANED: Build and work directories removed."
