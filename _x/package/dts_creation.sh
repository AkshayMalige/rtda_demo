#!/bin/bash -f
DTSIDIR="/home/synthara/VersalPrjs/LDRD/rtda_demo/_x/package/qemu_dts_files"
DTBLOG="/home/synthara/VersalPrjs/LDRD/rtda_demo/_x/package/qemu_dts_files/dts_creation.log"
 if [ -d "$DTSIDIR" ]
  then
  cd $DTSIDIR
  cd $DTSIDIR
  export LD_LIBRARY_PATH=$XILINX_VITIS/tps/lnx64/python-3.8.3/lib:$LD_LIBRARY_PATH
  export PATH=$XILINX_VIVADO/bin:$XILINX_VITIS/tps/lnx64/python-3.8.3/bin:$PATH
  export PYTHONPATH=$XILINX_VITIS/tps/lnx64/python-3.8.3/lib/python3.8/site-packages
  rm Makefile
  mv alt_makefile Makefile
  sh vitis_cosim_dts_cre.sh > $DTBLOG
 fi 
