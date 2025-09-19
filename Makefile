
#Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
#SPDX-License-Identifier: MIT
XILINX_VITIS   ?= /tools/Xilinx/Vitis/2024.2
EDGE_COMMON_SW ?= /home/synthara/versal_common/xilinx-versal-common-v2024.2
IMAGE          ?= $(EDGE_COMMON_SW)/Image
ROOTFS         ?= $(EDGE_COMMON_SW)/rootfs.ext4

TARGET   = hw_emu
ARCH = aie-ml

SDKTARGETSYSROOT ?= /opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux
CXX     := aarch64-linux-gnu-g++


PLATFORM  ?= /tools/Xilinx/Vitis/2024.2/base_platforms/xilinx_vek280_base_202420_1/xilinx_vek280_base_202420_1.xpfm


XSA   = aie_base_graph_${TARGET}.xsa
HOST_EXE = host.exe

DSPLIB_PATH  ?= /home/synthara/VersalPrjs/Vitis_Libraries/dsp
AIE_INCLUDE_FLAGS := \
	--include="./" \
	--include="../common" \
	--include="$(DSPLIB_PATH)/L1/src/aie" \
	--include="$(DSPLIB_PATH)/L1/include/aie" \
	--include="$(DSPLIB_PATH)/L2/include/aie"

GRAPH    = aie/graph.cpp
LIBADF  = libadf.a
AIE_CFG       := aie/aie.cfg
AIE_CMPL_CMD = v++ -c --mode aie --platform=${PLATFORM} --include="./aie" --config=$(AIE_CFG) --work_dir=./Work ${GRAPH} 2>&1 | tee log.txt
AIE_SIM_CMD = aiesimulator --pkg-dir=./Work
EMU_CMD = ./launch_hw_emu.sh

##########################################################################################################################################################
### DO NOT MODIFY BELOW THIS LINE UNLESS NECESSARY
################################################################################################################################################


XOS      = $(subst .cpp,.xo,$(wildcard pl/*.cpp)) 
VCC      = v++
VPP_SPEC =system.cfg
VPP_FLAGS=--save-temps --verbose --config ${VPP_SPEC}  
LDCLFLAGS=

.PHONY: clean

###
# Guarding Checks. Do not modify.
###
check_defined = \
	$(strip $(foreach 1,$1, \
		$(call __check_defined,$1,$(strip $(value 2)))))

__check_defined = \
	$(if $(value $1),, \
		$(error Undefined $1$(if $2, ($2))))

guard-PLATFORM_REPO_PATHS:
	$(call check_defined, PLATFORM, Set your where you downloaded xilinx_vck190_base_202510_1)

guard-ROOTFS:
	$(call check_defined, ROOTFS, Set to: xilinx-versal-common-v2025.1/rootfs.ext4)

guard-IMAGE:
	$(call check_defined, IMAGE, Set to: xilinx-versal-common-v2025.1/Image)

guard-CXX:
	$(call check_defined, CXX, Run: xilinx-versal-common-v2025.1/environment-setup-cortexa72-cortexa53-amd-linux)

guard-SDKTARGETSYSROOT:
	$(call check_defined, SDKTARGETSYSROOT, Run: xilinx-versal-common-v2025.1/environment-setup-cortexa72-cortexa53-amd-linux)
###

all: ${XSA} ${HOST_EXE} package
run: all run_hw_emu
sd_card: all

aie: guard-PLATFORM_REPO_PATHS ${LIBADF}
${LIBADF}: ${GRAPH} common/nn_defs.h common/data_paths.h $(AIE_CFG)
	${AIE_CMPL_CMD}

aiesim: ${LIBADF}
	${AIE_SIM_CMD}

xsa: guard-PLATFORM_REPO_PATHS ${XSA}
${XSA}: ${LIBADF} ${VPP_SPEC} ${XOS} 
	${VCC} -g -l --platform ${PLATFORM} ${XOS} ${LIBADF}  \
	       -t ${TARGET} ${VPP_FLAGS} -o $@

kernels: guard-PLATFORM_REPO_PATHS ${XOS}
${XOS}: 
	$(MAKE) -C pl/ PLATFORM=${PLATFORM}
	
host: guard-CXX guard-SDKTARGETSYSROOT ${HOST_EXE}
${HOST_EXE}: sw/*.cpp
	$(MAKE) -C sw/

package: guard-ROOTFS guard-IMAGE guard-PLATFORM_REPO_PATHS package_${TARGET}
package_${TARGET}: ${LIBADF} ${XSA} ${HOST_EXE} 
	${VCC} -p -t ${TARGET} -f ${PLATFORM} \
		--package.rootfs ${ROOTFS} \
		--package.kernel_image ${IMAGE} \
		--package.boot_mode=sd \
		--package.image_format=ext4 \
		--package.defer_aie_run \
		--package.sd_file embedded_exec.sh \
		--package.sd_dir data \
		--package.sd_file ${HOST_EXE} ${XSA} ${LIBADF} 

run_hw_emu: launch_hw_emu.sh
launch_hw_emu.sh: package_hw_emu
	$(EMU_CMD)

clean:
	rm -rf _x v++_* ${XOS} ${OS} ${LIBADF} *.o.* *.o *.xpe *.xo.* \
	       aie_base*.xclbin* *.xsa *.log *.jou *.BIN *.bin *.bif qemu* *.wcfg *.wdb *.img pmc_args.txt log.txt xnwOut Work Map_Report.csv \
	       ilpProblem* sol.db drivers .Xil aiesimu* x86simu* $(PKG_DIR) build_* *.xclbin *.xsa *.log \
		    sd_card launch_hw_emu.sh *.link_summary *.package_summary _x .Xil _ide sim cfg emu_qemu_scripts

	$(MAKE) -C pl clean
	$(MAKE) -C sw clean