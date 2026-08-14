VITIS_HLS ?= vitis_hls
IP_DIR    ?= ip

# PetaLinux sysroot injects its own make (requires GLIBC_2.38) ahead of /usr/bin/make.
# Force system make first so Vitis HLS post-check compilation works on Ubuntu 22.04.
SAFE_PATH := /usr/bin:/usr/local/bin:$(PATH)

.PHONY: csim csynth cosim cosim_only kernels clean help

csim:
	PATH=$(SAFE_PATH) $(VITIS_HLS) rtda_split_project.tcl csim

csynth:
	PATH=$(SAFE_PATH) $(VITIS_HLS) rtda_split_project.tcl csynth

cosim:
	PATH=$(SAFE_PATH) $(VITIS_HLS) rtda_split_project.tcl cosim

cosim_only:
	PATH=$(SAFE_PATH) $(VITIS_HLS) rtda_split_project.tcl cosim_only

kernels:
	mkdir -p $(IP_DIR)
	PATH=$(SAFE_PATH) $(VITIS_HLS) rtda_split_project.tcl kernels

clean:
	rm -rf rtda_split_hls $(IP_DIR) *.log *.jou

help:
	@echo ""
	@echo "RTDA Split-Kernel HLS (pl/ sub-build)"
	@echo "======================================="
	@echo ""
	@echo "Targets:"
	@echo "  csim       C simulation — fast functional check, verifies vs hls_27dim.txt"
	@echo "  csynth     C→RTL synthesis — generates Verilog + resource/timing reports"
	@echo "  cosim      csynth + RTL co-simulation"
	@echo "  cosim_only RTL co-simulation only (reuses existing csynth, saves time)"
	@echo "  kernels    csynth + export XO + IP catalog (writes to ip/)"
	@echo "  clean      Remove HLS project dir, ip/, logs"
	@echo ""
	@echo "Invoke directly from pl/ or via top-level: make pl_csim, make pl_kernels, etc."
	@echo ""
	@echo "Note: /usr/bin is prepended to PATH to avoid PetaLinux sysroot make"
	@echo "      shadowing system make (GLIBC_2.38 mismatch on Ubuntu 22.04)."
	@echo ""
