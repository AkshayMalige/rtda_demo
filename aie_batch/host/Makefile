# Host for aieml_batch. Mirrors host/Makefile's flags; differs only in that
# there is no PL kernel to talk to and no PRECISION switch (float32 only).
HOST_EXE   := ../host_batch.exe
HOST_SRC   := host_batch.cpp
HOST_OBJ   := host_batch.o
HOST_DEPS  := $(HOST_OBJ:.o=.d)
HOST_INC   := -I./ -I$(XILINX_VITIS)/aietools/include

# The performance scan host: same graph, same RTP payload, timing instead of
# results. A SEPARATE binary on purpose -- host_batch.exe produces the accuracy
# numbers the README cites, and nothing about a timing experiment should be able
# to change them.
SCAN_EXE   := ../host_scan.exe
SCAN_SRC   := host_scan.cpp
SCAN_OBJ   := host_scan.o
SCAN_DEPS  := $(SCAN_OBJ:.o=.d)

# Which commit produced the scan binary. Recorded in scan_meta.txt, because a
# performance number without the source revision behind it cannot be reproduced
# or defended six months later.
RTDA_GIT_HASH := $(shell git -C .. describe --always --dirty 2>/dev/null || echo unknown)

# EMU_PS: X86 | QEMU  (QEMU = aarch64 cross-compile for hw_emu/hw)
EMU_PS ?= QEMU

ifeq ($(EMU_PS),X86)
  CXX      := g++
  CXXFLAGS += -std=c++17 -g -Wall -c -MMD -MP -fmessage-length=0 ${HOST_INC}
  CXXFLAGS += -I${XILINX_XRT}/include
  LDFLAGS  += -lxrt_coreutil -lpthread -lrt -ldl -lstdc++ -L${XILINX_XRT}/lib
else
  CXXFLAGS += -std=c++17 -g -Wall -c -MMD -MP -fmessage-length=0 ${HOST_INC} \
              --sysroot=${SDKTARGETSYSROOT} -I${SDKTARGETSYSROOT}/usr/include/xrt/
  LDFLAGS  += -lgcc -lc -lxrt_coreutil -lpthread -lrt -ldl -lcrypt -lstdc++ \
              -L${SDKTARGETSYSROOT}/usr/lib/ --sysroot=${SDKTARGETSYSROOT} \
              -L$(XILINX_VITIS)/aietools/lib/aarch64.o
endif

.PHONY: all scan clean

all: $(HOST_EXE)

scan: $(SCAN_EXE)

$(HOST_EXE): $(HOST_OBJ)
	${CXX} -o $@ $^ ${LDFLAGS}

$(SCAN_EXE): $(SCAN_OBJ)
	${CXX} -o $@ $^ ${LDFLAGS}

# Makefile too: the compile flags live here. RTDA_VARIANT is baked into the
# object as a -D, so without this a changed variant never forces a recompile
# and the binary keeps stamping the OLD one into run_info.txt. A board result
# that misreports which build produced it is worse than one with no label.
$(HOST_OBJ): $(HOST_SRC) Makefile
	${CXX} ${CXXFLAGS} -o $@ $<

# The commit hash is a -D, and Make cannot see that a variable changed -- so make
# the value BE a file. The stamp's NAME is the hash, so a new commit is a
# prerequisite that does not exist yet and forces the recompile. Without this the
# binary keeps stamping the old revision into scan_meta.txt, and a performance
# result that misreports what produced it is worse than one carrying no label.
GITHASH_STAMP := .githash.$(RTDA_GIT_HASH)

$(GITHASH_STAMP):
	@rm -f .githash.*
	@touch $@

$(SCAN_OBJ): $(SCAN_SRC) Makefile $(GITHASH_STAMP)
	${CXX} ${CXXFLAGS} -DRTDA_GIT_HASH='"$(RTDA_GIT_HASH)"' -o $@ $<

-include $(HOST_DEPS) $(SCAN_DEPS)

clean:
	rm -f $(HOST_OBJ) $(HOST_DEPS) $(HOST_EXE) \
	      $(SCAN_OBJ) $(SCAN_DEPS) $(SCAN_EXE) .githash.*
