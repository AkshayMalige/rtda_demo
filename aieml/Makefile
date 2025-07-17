#
# Copyright 2024 Synthara AG
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# User-configurable paths
VITIS_PATH ?= /tools/Xilinx/Vitis/2024.2
DSPLIB_PATH ?= /home/synthara/VersalPrjs/Vitis_Libraries/dsp
PLATFORM_PATH ?= $(VITIS_PATH)/base_platforms/xilinx_vek280_base_202420_1/xilinx_vek280_base_202420_1.xpfm

# AI Engine compiler options
AIE_COMPILER_OPTIONS = -v --pl-freq=300 --workdir=./Work

# Consolidated include flags for L1/L2 libraries
AIE_INCLUDE_FLAG = \
	--include="$(DSPLIB_PATH)/L2/include/aie" \
	--include="$(DSPLIB_PATH)/L1/include/aie" \
	--include="$(DSPLIB_PATH)/L1/src/aie" \
	--include="./kernels"	\
	--include="./data"

# Define source files
AIE_GRAPH_SRC = graph.cpp
AIE_GRAPH_HEADER = graph.h
HOST_SRC = host.cpp

# Define output directories
AIE_BUILD_DIR = aie_build
HOST_BUILD_DIR = host_build
EMULATION_EXE = $(HOST_BUILD_DIR)/host.exe
LIB_ADF = $(AIE_BUILD_DIR)/libadf.a

.PHONY: all clean aie aiesim

# Default target
all: $(EMULATION_EXE)

# Rule to build the AI Engine graph
aie: $(LIB_ADF)

$(LIB_ADF): $(AIE_GRAPH_SRC) $(AIE_GRAPH_HEADER)
	@mkdir -p $(AIE_BUILD_DIR)
	aiecompiler $(AIE_COMPILER_OPTIONS) \
		$(AIE_INCLUDE_FLAG) \
		--platform=$(PLATFORM_PATH) \
		$(AIE_GRAPH_SRC)

# Rule to build the host application for simulation
$(EMULATION_EXE): $(HOST_SRC) $(LIB_ADF)
	@mkdir -p $(HOST_BUILD_DIR)
	g++ -std=c++17 $(HOST_SRC) -o $(EMULATION_EXE) \
		--include=$(AIE_BUILD_DIR) \
		--include=$(DSPLIB_PATH)/L2/include \
		--include=$(VITIS_PATH)/aietools/include \
		--include=./src \
		-L$(AIE_BUILD_DIR) -ladf_api_xrt \
		-L$(VITIS_PATH)/aietools/lib/lnx64.o -lxaiengine \
		-L$(DSPLIB_PATH) \
		-Wl,-rpath-link,$(VITIS_PATH)/aietools/lib/lnx64.o

# Rule to run the AI Engine simulator
aiesim: $(EMULATION_EXE)
	./$(EMULATION_EXE)

# Clean rule
clean:
	rm -rf $(AIE_BUILD_DIR) $(HOST_BUILD_DIR) aiesimulator_output *.log .Xil Work outfold
	rm -f data/output_dense1.txt data/output_dense2.txt *.csv *.db *.a