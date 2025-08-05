#!/bin/bash -f
make .//LATEST/MULTI_ARCH/board-versal-pmc-virt.dtb
make .//LATEST/MULTI_ARCH/board-versal-xcve2802-ps-cosim-vitis-virt.dtb
cd LATEST/MULTI_ARCH/
rm -rf *.dtb.cd
rm -rf *.dts*
