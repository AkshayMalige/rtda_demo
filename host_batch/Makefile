# Host for aieml_batch. Mirrors host/Makefile's flags; differs only in that
# there is no PL kernel to talk to and no PRECISION switch (float32 only).
HOST_EXE   := ../host_batch.exe
HOST_SRC   := host_batch.cpp
HOST_OBJ   := host_batch.o
HOST_DEPS  := $(HOST_OBJ:.o=.d)
HOST_INC   := -I./ -I../common -I$(XILINX_VITIS)/aietools/include

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

.PHONY: all clean

all: $(HOST_EXE)

$(HOST_EXE): $(HOST_OBJ)
	${CXX} -o $@ $^ ${LDFLAGS}

$(HOST_OBJ): $(HOST_SRC)
	${CXX} ${CXXFLAGS} -o $@ $<

-include $(HOST_DEPS)

clean:
	rm -f $(HOST_OBJ) $(HOST_DEPS) $(HOST_EXE)
