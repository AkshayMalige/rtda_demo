############################################################################
#  Simplified top-level Makefile matching requested targets
#  Placeholders for host/PL while focusing on AIE build/simulation.
############################################################################

SHELL := /bin/bash

# Basic config
PLATFORM ?= /tools/Xilinx/Vitis/2024.2/base_platforms/xilinx_vek280_base_202420_1/xilinx_vek280_base_202420_1.xpfm
DATA_DIR ?= $(abspath ./data)

.PHONY: all aie host pl system-project link xsa package x86sim hw_emu clean

all: aie

# AIE build (delegate to aieml/ default target)
aie:
	$(MAKE) -C aieml PLATFORM=$(PLATFORM) DATA_DIR=$(DATA_DIR)

# Placeholders (user will add PL kernels and host app later)
host:
	@echo "[placeholder] host build to be added later"

pl:
	@echo "[placeholder] PL kernels build to be added later"

system-project:
	@echo "[placeholder] system project creation to be added later"

link xsa:
	@echo "[placeholder] v++ link/XSA generation to be added later"

package:
	@echo "[placeholder] v++ package (xclbin) to be added later"

# Full-system x86 simulation and HW emulation (needs host later)
x86sim:
	@echo "[placeholder] full-system x86 simulation (host.cpp) to be added later"

hw_emu:
	@echo "[placeholder] full-system HW emulation to be added later"

clean:
	$(MAKE) -C aieml clean || true
	@echo "[placeholder] clean host/PL/system outputs later"
