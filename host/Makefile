# ---- Makefile (drop-in) ----

SYSROOT := /opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux
CXX     := aarch64-linux-gnu-g++

# Include paths (copied from your log)
INC := -I$(SYSROOT)/usr/include/xrt \
       -I$(SYSROOT)/usr/include \
       -I./ -I./src/ -I../common -I/aietools/include -I/include

# Compile flags
CXXFLAGS := -Wall -std=c++17 -Wno-int-to-pointer-cast --sysroot=$(SYSROOT) \
            $(INC) \
            -DDATA_DIR='"/home/synthara/VersalPrjs/LDRD/data"'

# Linker search paths:
#   You had only .../usr/lib; libuuid is in $(SYSROOT)/lib (and sometimes lib64)
LDFLAGS := --sysroot=$(SYSROOT) \
           -L$(SYSROOT)/usr/lib \
           -L$(SYSROOT)/lib \
           -L$(SYSROOT)/lib64 \
           -Wl,--no-as-needed

# Libraries: add -luuid (this is what fixes "uuid_copy ... DSO missing")
LDLIBS := -lxrt_coreutil -lxrt_core -luuid -lpthread

# Targets
all: system_host

system_host: host.o
	$(CXX) $^ $(LDFLAGS) $(LDLIBS) -o $@

host.o: host.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f *.o system_host
