# Makefile for driving the Vitis HLS project for simulation and packaging.

# --- Configuration ---
HLS_COMMAND := vitis_hls
HLS_SCRIPT  := project.tcl
PROJECT_DIR := leaky_relu_hls
OUTPUT_XO   := ${PROJECT_DIR}.xo

.PHONY: all csim cosim package clean

# Default target runs the full verification and packaging flow
all: csim cosim package

# Target to run C-level simulation (Software Emulation)
csim:
	@echo "▶️  Running C-Simulation..."
	$(HLS_COMMAND) -f $(HLS_SCRIPT) csim

# Target to run C/RTL co-simulation (Hardware Emulation)
cosim:
	@echo "▶️  Running C/RTL Co-simulation..."
	$(HLS_COMMAND) -f $(HLS_SCRIPT) cosim

# Target to synthesize and generate the final IP and .xo files
package:
	@echo "📦 Synthesizing and Packaging IP/.xo..."
	$(HLS_COMMAND) -f $(HLS_SCRIPT) package
	@echo "✅ Output available at ./${OUTPUT_XO}"

# Target to clean up all generated files and directories
clean:
	@echo "🧹 Cleaning up generated files..."
	rm -rf $(PROJECT_DIR) vitis_hls.log ip_catalog/ ${OUTPUT_XO} leakyrelu_output.txt