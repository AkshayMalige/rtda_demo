# host_split.exe, not host.exe: ../Makefile packages $(EXEC) = ./host_split.exe
# and RUNBOOK/check_image both name it. A mismatch here fails the PACKAGE step,
# i.e. after the ~6 h synthesis and link have already run.
HOST_EXE := ../host_split.exe
HOST_SRC := host_split.cpp
HOST_OBJ := host_split.o
HOST_DEP := host_split.d

# The performance scan host. A SEPARATE binary on purpose: host_split.exe
# produces the accuracy numbers the README cites, and nothing about a timing
# experiment should be able to change them.
SCAN_EXE := ../host_scan.exe
SCAN_SRC := host_scan.cpp
SCAN_OBJ := host_scan.o
SCAN_DEP := host_scan.d

# EMU_PS: X86 | QEMU
#   X86  - native g++ build (for local testing, x86 hw_emu with XRT)
#   QEMU - aarch64 cross-compile using PetaLinux sysroot (for hw_emu/hw on VEK280)
EMU_PS ?= QEMU

# Stamped into run_info.txt so a result copied off the board says which
# fixed-point build produced it. Passed down by ../Makefile.
RTDA_VARIANT ?= unknown

ifeq ($(EMU_PS),X86)
  CXX      := g++
  CXXFLAGS := -std=c++17 -g -Wall -c -MMD -MP -I${XILINX_XRT}/include
  LDFLAGS  := -lxrt_coreutil -lpthread -lrt -ldl -lstdc++ -L${XILINX_XRT}/lib
else
  CXX      := aarch64-linux-gnu-g++
  CXXFLAGS := -std=c++17 -g -Wall -c -MMD -MP \
              --sysroot=${SDKTARGETSYSROOT} \
              -I${SDKTARGETSYSROOT}/usr/include/xrt/
  LDFLAGS  := -lgcc -lc -lxrt_coreutil -lpthread -lrt -ldl -lcrypt -lstdc++ \
              -L${SDKTARGETSYSROOT}/usr/lib/ \
              --sysroot=${SDKTARGETSYSROOT}
endif

# After the block above, which assigns CXXFLAGS with := and would drop this.
CXXFLAGS += -DRTDA_VARIANT='"$(RTDA_VARIANT)"'

# Which commit produced the scan binary. Recorded in scan_meta.txt, because a
# performance number without the source revision behind it cannot be reproduced
# or defended six months later.
RTDA_GIT_HASH := $(shell git -C .. describe --always --dirty 2>/dev/null || echo unknown)

.PHONY: all scan clean

all: $(HOST_EXE)

scan: $(SCAN_EXE)

$(HOST_EXE): $(HOST_OBJ)
	$(CXX) -o $@ $^ $(LDFLAGS)

$(SCAN_EXE): $(SCAN_OBJ)
	$(CXX) -o $@ $^ $(LDFLAGS)

# RTDA_VARIANT is baked into the object as a -D. Depending on Makefile catches
# somebody EDITING the flags, but not the ordinary case: the same Makefile run
# with a different AP_W/AP_I. Make compares file timestamps and cannot see that
# a variable changed, so the stale .o was reused and the binary kept stamping
# the old variant into run_info.txt -- which is how the board wrote
# `variant=unknown` under a build that was very much ap16_3. A result that
# misreports what produced it is worse than one carrying no label at all.
#
# So make the value BE a file: the stamp's NAME is the variant, and a different
# variant is therefore a prerequisite that does not exist yet.
VARIANT_STAMP := .variant.$(RTDA_VARIANT)

$(VARIANT_STAMP):
	@rm -f .variant.*
	@touch $@

$(HOST_OBJ): $(HOST_SRC) Makefile $(VARIANT_STAMP)
	$(CXX) $(CXXFLAGS) -o $@ $<

# Same trick for the commit hash, for the same reason: a new commit is a changed
# -D that Make cannot see, and a scan_meta.txt naming the wrong revision is worse
# than one naming none.
GITHASH_STAMP := .githash.$(RTDA_GIT_HASH)

$(GITHASH_STAMP):
	@rm -f .githash.*
	@touch $@

$(SCAN_OBJ): $(SCAN_SRC) Makefile $(VARIANT_STAMP) $(GITHASH_STAMP)
	$(CXX) $(CXXFLAGS) -DRTDA_GIT_HASH='"$(RTDA_GIT_HASH)"' -o $@ $<

-include $(HOST_DEP) $(SCAN_DEP)

clean:
	rm -rf $(HOST_OBJ) $(HOST_DEP) $(SCAN_OBJ) $(SCAN_DEP) .Xil \
	       $(HOST_EXE) $(SCAN_EXE) .variant.* .githash.*
