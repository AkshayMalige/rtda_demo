#!/bin/bash

echo "🔧 Setting up environment for Versal VEK280..."

# === Source Xilinx Runtime (XRT) ===
echo "📦 Sourcing XRT..."
source /opt/xilinx/xrt/setup.sh

# === Set and Source Vitis environment ===
echo "📦 Setting and sourcing Vitis 2025.1..."
# export XILINX_VITIS=/tools/Xilinx/2025.1/Vitis
export XILINX_VITIS=/tools/Xilinx/Vitis/2024.2

source ${XILINX_VITIS}/settings64.sh

# === Source PetaLinux environment ===
echo "📦 Sourcing PetaLinux 2024.2..."
source /tools/Xilinx/PetaLinux/settings.sh

# === Unset conflicting LD_LIBRARY_PATH ===
echo "🧹 Unsetting LD_LIBRARY_PATH to avoid conflicts..."
unset LD_LIBRARY_PATH

# === Set up cross-compilation environment ===
echo "🔁 Setting up cross-compilation environment..."
source /opt/petalinux/2024.2/environment-setup-cortexa72-cortexa53-xilinx-linux

# === Set environment variables for system image ===
export EDGE_COMMON_SW=/home/synthara/versal_common/xilinx-versal-common-v2024.2
export IMAGE=${EDGE_COMMON_SW}/Image
export ROOTFS=${EDGE_COMMON_SW}/rootfs.ext4
export SYSROOT=/opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux

# === Set Vitis platform path ===
export PLATFORM=${XILINX_VITIS}/base_platforms/xilinx_vek280_base_202420_1/xilinx_vek280_base_202420_1.xpfm
export DATA_DIR=/home/synthara/VersalPrjs/LDRD/rtda_demo/data

export XILINX_VITIS_DATA_DIR=/home/synthara/VersalPrjs/LDRD/rtda_demo/.vitis_data

echo ""
echo "🔍 Environment summary:"
echo "  XILINX_VITIS  = $XILINX_VITIS"
echo "  PLATFORM      = $PLATFORM"
echo "  SYSROOT       = $SYSROOT"
echo "  EDGE_COMMON_SW= $EDGE_COMMON_SW"
echo "  IMAGE         = $IMAGE"
echo "  ROOTFS        = $ROOTFS"
echo ""
echo "✅ Versal VEK280 environment setup complete."
