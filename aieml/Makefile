# ===================================================================
# Makefile for Vitis AIE Graph Compilation & Simulation
# ===================================================================


# Target for compilation and simulation. Options: x86sim, hw
TARGET       ?= hw

# Precision toggle: float (default) or int16
PRECISION    ?= float

# Frequency for the Programmable Logic (PL) interfaces.
PL_FREQZ     ?= 300

DSPLIB_PATH  ?= ../dsp_lib


# ==== PROJECT FILES & DIRECTORIES ====
GRAPH_SRC     := graph.cpp
WORK_DIR      ?= Work
GRAPH_LIB     := $(WORK_DIR)/libadf.a
# KERNEL_SRCS   := \
# 	bias_relu_fused.cpp \
# 	window_split_128_to_64x2.cpp \
# 	roll_concat.cpp \
# 	split_16_to_8x2.cpp
# KERNEL_HDRS   := $(KERNEL_SRCS:.cpp=.h)
KERNEL_SRCS   := bias_relu_fused.cpp
KERNEL_HDRS   := $(KERNEL_SRCS:.cpp=.h)

# ==== TOOLS ====
AIECC        := aiecompiler
AIESIM       := aiesimulator
X86SIM       := x86simulator


# ==== COMPILER FLAGS ====
# Include paths for the AIE compiler.
AIE_INCLUDE_FLAGS := \
	--include="./" \
	--include="../common" \
	--include="$(DSPLIB_PATH)/L1/src/aie" \
	--include="$(DSPLIB_PATH)/L1/include/aie" \
	--include="$(DSPLIB_PATH)/L2/include/aie"

# Full AIE compiler command flags, assembled from variables above.
AIE_FLAGS := \
	--v \
	--platform=$(PLATFORM) \
	--target=$(TARGET) \
	--pl-freq=$(PL_FREQZ) \
	$(AIE_INCLUDE_FLAGS)


# ==== RULES ====

.PHONY: all graph sim clean force_config

# --- Default Target ---
all: graph

# --- AIE Graph Compilation ---
graph: $(GRAPH_LIB)

# --- Configuration Generation ---
# Robustly generate config header based on PRECISION variable
config_gen.h: force_config
	@echo "#pragma once" > config_gen.h.tmp
ifeq ($(PRECISION),int16)
	@echo "#define USE_INT16 1" >> config_gen.h.tmp
else
	@echo "// USE_INT16 not defined" >> config_gen.h.tmp
endif
	@if [ ! -f config_gen.h ] || ! cmp -s config_gen.h config_gen.h.tmp; then \
		mv config_gen.h.tmp config_gen.h; \
		echo "--- config_gen.h updated for PRECISION=$(PRECISION) ---"; \
	else \
		rm config_gen.h.tmp; \
	fi

.PHONY: force_config

# $(GRAPH_LIB): $(GRAPH_SRC) $(KERNEL_SRCS) $(KERNEL_HDRS) graph.h ../common/data_paths.h ../common/nn_defs10.h
$(GRAPH_LIB): config_gen.h $(GRAPH_SRC) $(KERNEL_SRCS) $(KERNEL_HDRS) graph.h utils.hpp data_types.h ../common/data_paths.h ../common/nn_defs10.h
	@mkdir -p $(WORK_DIR)
	@echo "--- Compiling AIE Graph for TARGET=$(TARGET) PRECISION=$(PRECISION) ---"
	@echo "INFO: Using Vitis DSP Library Path: $(DSPLIB_PATH)"
	@if [ ! -d "$(DSPLIB_PATH)" ]; then \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		echo "!!! ERROR: Directory not found: '$(DSPLIB_PATH)'"; \
		echo "!!! Please set the DSPLIB_PATH variable in your Makefile correctly."; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		exit 1; \
	fi
	$(AIECC) $(AIE_FLAGS) $(GRAPH_SRC) --workdir=$(WORK_DIR) 2>&1 | tee $(WORK_DIR)/aiecompiler.log
	@# aiecompiler drops libadf.a in CWD; relocate to $(WORK_DIR)
	@if [ -f libadf.a ]; then \
		echo "mv libadf.a -> $(GRAPH_LIB)"; \
		mv -f libadf.a $(GRAPH_LIB); \
	fi


# --- Simulation ---
sim: graph
ifeq ($(TARGET),x86sim)
	@echo "--- Starting x86 Simulation ---"
	$(X86SIM) --pkg-dir=$(WORK_DIR)
	@echo "COMPLETE: x86sim simulation finished."
else
	@echo "--- Starting Hardware Simulation (aiesimulator) ---"
	$(AIESIM) --pkg-dir=$(WORK_DIR) --profile --dump-vcd=foo --output-time-stamp=no
	@echo "COMPLETE: Hardware simulation finished."
endif

# --- Clean Target ---
# clean:
# 	@echo "--- Cleaning Workspace ---"
# 	rm -rf $(WORK_DIR) .Xil *.log *.csv *.db *.aiecompile_summary aiesimulator_output build_hw build_x86sim x86simulator_output pl_sample* *.a .AIE_SIM_CMD_LINE_OPTIONS ISS_RPC_SERVER_PORT *.json *.vcd
# 	@echo "CLEANED: Build and work directories removed."
clean:
	@echo "--- Cleaning Workspace ---"
	rm -rf $(WORK_DIR) .Xil *.log *.csv *.db *.aiecompile_summary \
		aiesimulator_output x86simulator_output $(WORK_DIR)/aiesimulator_output \
		build_hw trdata.aiesim function_wdb_dir $(WORK_DIR)/function_wdb_dir\
		pl_sample* *.a .AIE_SIM_CMD_LINE_OPTIONS ISS_RPC_SERVER_PORT *.jou\
		*.json *.vcd *.wcfg *.wdb config_gen.h
	@echo "CLEANED: Build and work directories removed."