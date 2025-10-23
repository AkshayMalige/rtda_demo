HOST_EXE   := ../host.exe
HOST_SRC   := host.cpp
HOST_OBJ   := host.o
HOST_INC   := -I./ -I../common -I../aieml -I$(XILINX_VITIS)/aietools/include

# EMU_PS = X86 (native) | QEMU (aarch64 sysroot)
EMU_PS ?= X86

ifeq ($(EMU_PS),X86)
  CXX      ?= g++
  CXXFLAGS += -std=c++17 -g -Wall -c -fmessage-length=0 ${HOST_INC}
  CXXFLAGS += -I${XILINX_XRT}/include
  LDFLAGS  += -lxrt_coreutil -lpthread -lrt -ldl -lstdc++ -L${XILINX_XRT}/lib
else
  # Cross-compile for aarch64 (QEMU)
  CXXFLAGS += -std=c++17 -g -Wall -c -fmessage-length=0 ${HOST_INC} \
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

clean:
	rm -rf ${HOST_OBJ} .Xil ${HOST_EXE}
