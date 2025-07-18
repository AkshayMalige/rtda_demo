# Makefile for Vitis HLS project management

# ===================================================================
# Configuration
# ===================================================================
# Tool executable
VITIS_HLS := vitis_hls

# Tcl script for the project
HLS_SCRIPT := project.tcl

# Project-specific names
KERNEL_NAME := leaky_relu
PROJECT_DIR := $(KERNEL_NAME)_hls
IP_DIR := ip
LOG_FILE := vitis_hls.log

# Simulation target (sw_emu or hw_emu or hw)
TARGET ?= hw


# ===================================================================
# Rules
# ===================================================================
# Default target
.PHONY: all
all: kernels

# --- Build Rule ---
# Creates the kernel XO and IP catalog by running synthesis once.
.PHONY: kernels
kernels:
	@echo "--- Building Kernels: Synthesizing and Exporting XO and IP ---"
	mkdir -p $(IP_DIR)
	$(VITIS_HLS) $(HLS_SCRIPT) kernels

# --- Simulation Rule ---
# Runs C-simulation for sw_emu or C/RTL Co-simulation for hw.
.PHONY: sim
sim:
	@echo "--- Running Simulation for TARGET=$(TARGET) ---"
ifneq ($(filter $(TARGET),hw hw_emu),)
	$(VITIS_HLS) $(HLS_SCRIPT) cosim
	@echo "COMPLETE: c-simulation finished."
else
	$(VITIS_HLS) $(HLS_SCRIPT) csim
	@echo "COMPLETE: hw emulation finished."
endif

# --- Clean Rule ---
# Removes all generated directories and log files.
.PHONY: clean
clean:
	@echo "--- Cleaning all generated files ---"
	rm -rf $(PROJECT_DIR) $(IP_DIR) $(LOG_FILE) *.log *.jou