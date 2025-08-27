# Makefile for Vitis HLS project management (multi-kernel)

# ===================================================================
# Configuration
# ===================================================================
VITIS_HLS ?= vitis_hls

# Resolve data directory to an absolute path so simulations can locate input
# files regardless of the working directory used by Vitis HLS.
DATA_DIR ?= $(abspath ../data)
export DATA_DIR

# List of kernels (add more as needed)
KERNELS ?= s2mm switch_mm2s demux_8
# KERNELS := demux_8


IP_DIR   ?= ip
LOG_FILE ?= vitis_hls.log
TARGET ?= hw_emu


# ===================================================================
# Rules
# ===================================================================
.PHONY: all
all: kernels	

# --- Build Rule ---
.PHONY: kernels
kernels:
	@echo "--- Building All Kernels ---"
	mkdir -p $(IP_DIR)
	for KERNEL in $(KERNELS); do \
		echo "--- Building $$KERNEL ---"; \
		$(VITIS_HLS) "$${KERNEL}_project.tcl" kernels; \
	done

# --- Simulation Rule ---
.PHONY: sim
sim:
	@echo "--- Running Simulation for TARGET=$(TARGET) ---"
	@echo "DATA_DIR=$(DATA_DIR)"
ifneq ($(filter $(TARGET),hw hw_emu),)
	for KERNEL in $(KERNELS); do \
		echo "--- Running hw/hw_emu co-simulation for $$KERNEL ---"; \
		$(VITIS_HLS) "$${KERNEL}_project.tcl" cosim; \
	done
	@echo "COMPLETE: hw emulation finished."
else
	for KERNEL in $(KERNELS); do \
		echo "--- Running C-simulation for $$KERNEL ---"; \
		$(VITIS_HLS) "$${KERNEL}_project.tcl" csim; \
	done
	@echo "COMPLETE: c-simulation finished."
endif

# --- Clean Rule ---
.PHONY: clean
clean:
	@echo "--- Cleaning all generated files ---"
	for KERNEL in $(KERNELS); do \
		rm -rf "$${KERNEL}_hls"; \
	done
	        rm -rf $(IP_DIR) $(LOG_FILE) *.log *.jou
