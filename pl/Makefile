# Makefile for building PL kernels with v++ into a build.<target> folder

PLATFORM ?= xilinx_vek280_base_202420_1
TARGET ?= hw
PL_FREQZ ?= 300
VPP := v++

BUILD_DIR := build_$(TARGET)
SRC_DIR := .
KERNEL_LIST := leaky_relu_pl

VPP_FLAGS := -t $(TARGET) --platform $(PLATFORM) --kernel_frequency $(PL_FREQZ) --save-temps -g

# Auto-generate source and output paths
KERNEL_CPP := $(addprefix $(SRC_DIR)/, $(addsuffix .cpp, $(KERNEL_LIST)))
KERNEL_XO  := $(addprefix $(BUILD_DIR)/, $(addsuffix .xo, $(KERNEL_LIST)))

.PHONY: all clean kernels

all: kernels

kernels: $(KERNEL_XO)
	@echo "✅ All PL kernels built in $(BUILD_DIR)"

# Pattern rule to compile each .cpp into .xo in the build dir
$(BUILD_DIR)/%.xo: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(VPP) $(VPP_FLAGS) -k $* -c -o $@ $<

# Ensure build dir exists
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR) *.log *.jou .Xil/ _x/ *.compile_summary
	@echo "🧹 Cleaned PL kernel build outputs"