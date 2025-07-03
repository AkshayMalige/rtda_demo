# Makefile to perform the linking stage with v++

TARGET ?= hw
PLATFORM ?= xilinx_vek280_base_202420_1
VPP := v++

PL_XO_DIR := ../pl/build_$(TARGET)
AIE_LIB := ../aie/build_$(TARGET)/libadf.a
CONFIG := system.cfg
OUTPUT := design_$(TARGET).xsa

VPP_FLAGS = -I../common/

XO_FILES := $(PL_XO_DIR)/mm2s_8_128.xo \
            $(PL_XO_DIR)/s2mm_32_128.xo \
            $(PL_XO_DIR)/s2mm_16_128.xo

LINK_CMD := $(VPP) --link --target $(TARGET) $(VPP_FLAGS) --platform $(PLATFORM) \
            --config $(CONFIG) $(XO_FILES) $(AIE_LIB) -o $(OUTPUT)

.PHONY: all clean

all: $(OUTPUT)

$(OUTPUT): $(XO_FILES) $(AIE_LIB) $(CONFIG)
	$(LINK_CMD)
	@echo "✅ Linked: $@"

clean:
	rm -rf *.xsa *.xclbin *.log *.jou *.json *.xml binary_container_* *.link_summary .ipcache
	@echo "🧹 Cleaned linking artifacts"
