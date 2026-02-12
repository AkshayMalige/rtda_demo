# Makefile for Vitis HLS project management (multi-kernel)

# ===================================================================
# Configuration
# ===================================================================
VITIS_HLS ?= vitis_hls

# List of kernels (add more as needed)
# KERNELS ?= mm2s leaky_relu leaky_splitter s2mm track_average dense_128
KERNELS ?= track_average
# KERNELS :=


IP_DIR   ?= ip
LOG_FILE ?= vitis_hls.log
TARGET ?= hw_emu

# Data type selection: float or int16
DATA_TYPE ?= int16


# ===================================================================
# Rules
# ===================================================================
.PHONY: all
all: kernels	

# --- Build Rule ---
.PHONY: kernels
kernels:
	@echo "--- Building All Kernels with DATA_TYPE=$(DATA_TYPE) ---"
	mkdir -p $(IP_DIR)
	for KERNEL in $(KERNELS); do \
		echo "--- Building $$KERNEL ---"; \
		$(VITIS_HLS) "$${KERNEL}_project.tcl" kernels $(DATA_TYPE); \
	done

# --- Simulation Rule ---
.PHONY: sim
sim:
	@echo "--- Running Simulation for TARGET=$(TARGET) with DATA_TYPE=$(DATA_TYPE) ---"
ifneq ($(filter $(TARGET),hw hw_emu),)
	for KERNEL in $(KERNELS); do \
		echo "--- Running hw/hw_emu co-simulation for $$KERNEL ---"; \
		PATH=/usr/bin:$$PATH $(VITIS_HLS) "$${KERNEL}_project.tcl" cosim $(DATA_TYPE); \
	done
	@echo "COMPLETE: hw emulation finished."
else
	for KERNEL in $(KERNELS); do \
		echo "--- Running C-simulation for $$KERNEL ---"; \
		PATH=/usr/bin:$$PATH $(VITIS_HLS) "$${KERNEL}_project.tcl" csim $(DATA_TYPE); \
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
