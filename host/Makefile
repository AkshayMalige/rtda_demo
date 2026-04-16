HOST_EXE   := ../host.exe
HOST_SRC   := host.cpp
HOST_OBJ   := host.o
HOST_DEPS  := $(HOST_OBJ:.o=.d)
HOST_INC   := -I./ -I../common -I$(XILINX_VITIS)/aietools/include

# EMU_PS: X86 | QEMU
#   X86  - native g++ build (for sw_emu or local testing)
#   QEMU - aarch64 cross-compile using PetaLinux sysroot (for hw_emu/hw)
EMU_PS ?= QEMU

# PRECISION: float | int16
#   float - host reads/writes 32-bit float values for RTP and GMIO
#   int16 - host reads/writes 16-bit integer values (adds -DUSE_INT16)
PRECISION ?= float

ifeq ($(PRECISION),int16)
  PRECISION_FLAGS := -DUSE_INT16
else
  PRECISION_FLAGS :=
endif

ifeq ($(EMU_PS),X86)
  CXX      := g++
  CXXFLAGS += -std=c++17 -g -Wall -c -MMD -MP -fmessage-length=0 ${HOST_INC}
  CXXFLAGS += -I${XILINX_XRT}/include $(PRECISION_FLAGS)
  LDFLAGS  += -lxrt_coreutil -lpthread -lrt -ldl -lstdc++ -L${XILINX_XRT}/lib
else
  # Cross-compile for aarch64 (QEMU)
  CXXFLAGS += -std=c++17 -g -Wall -c -MMD -MP -fmessage-length=0 ${HOST_INC} \
              --sysroot=${SDKTARGETSYSROOT} -I${SDKTARGETSYSROOT}/usr/include/xrt/ \
              $(PRECISION_FLAGS)
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
	rm -rf ${HOST_OBJ} $(HOST_DEPS) .Xil ${HOST_EXE}
