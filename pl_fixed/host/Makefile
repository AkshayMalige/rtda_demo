HOST_EXE := ../host.exe
HOST_SRC := host_split.cpp
HOST_OBJ := host_split.o
HOST_DEP := host_split.d

# EMU_PS: X86 | QEMU
#   X86  - native g++ build (for local testing, x86 hw_emu with XRT)
#   QEMU - aarch64 cross-compile using PetaLinux sysroot (for hw_emu/hw on VEK280)
EMU_PS ?= QEMU

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

.PHONY: all clean

all: $(HOST_EXE)

$(HOST_EXE): $(HOST_OBJ)
	$(CXX) -o $@ $^ $(LDFLAGS)

$(HOST_OBJ): $(HOST_SRC)
	$(CXX) $(CXXFLAGS) -o $@ $<

-include $(HOST_DEP)

clean:
	rm -rf $(HOST_OBJ) $(HOST_DEP) .Xil $(HOST_EXE)
