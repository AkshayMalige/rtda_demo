##############################################################
# rtda_split_project.tcl — Vitis HLS project for split-kernel RTDA top
# Usage: vitis_hls rtda_split_project.tcl [csim|csynth|cosim|cosim_only|kernels]
#
#   csim       — C simulation (resets project for clean compile)
#   csynth     — C→RTL synthesis (keeps existing project, skips if up-to-date)
#   cosim      — csynth + RTL co-simulation
#   cosim_only — RTL co-simulation only (reuses existing csynth results, saves time)
#   kernels    — csynth + export XO + IP catalog
##############################################################

set PROJ_DIR [file dirname [file normalize [info script]]]
set HLS_DIR  [file join $PROJ_DIR ../../hls_projects]

set NNET_INC  [file join $HLS_DIR split_embed/firmware]
set part_name "xcve2802-vsvh1760-2MP-e-S"
set top_fn    "rtda_split_top"
set prj_name  "rtda_split_hls"

if {[llength $argv] > 0} {
    set command [lindex $argv 0]
} else {
    set command "csim"
}

set cflags "-I${NNET_INC} -std=c++14 -Isrc"

# cosim_only re-opens the existing project without resetting — synthesis results are reused.
# All other commands reset the project so source/config changes are picked up cleanly.
if {$command eq "cosim_only"} {
    open_project ${prj_name}
} else {
    open_project -reset ${prj_name}
}

set_top ${top_fn}

add_files src/rtda_split_top.cpp  -cflags $cflags
add_files src/embed_proxy.cpp     -cflags $cflags
add_files src/solver0_proxy.cpp   -cflags $cflags
add_files src/solver1_proxy.cpp   -cflags $cflags
add_files src/solver2_proxy.cpp   -cflags $cflags
add_files src/output_proxy.cpp    -cflags $cflags

add_files -tb src/rtda_split_tb.cpp -cflags $cflags
add_files -tb weights
add_files -tb [file normalize "$PROJ_DIR/../../data/embed_input.txt"]
add_files -tb [file normalize "$PROJ_DIR/../../punit/outputs/keras_27dim.txt"]
add_files -tb [file normalize "$PROJ_DIR/../../punit/outputs/hls_27dim.txt"]

if {$command eq "cosim_only"} {
    open_solution "solution1"
} else {
    open_solution -flow_target vitis "solution1"
    set_part $part_name
    create_clock -period 5 -name default
    config_compile -name_max_length 80
    set_clock_uncertainty 0.5 default
}

switch $command {
    csim {
        puts "***** C SIMULATION *****"
        csim_design
        puts "***** C SIMULATION DONE *****"
    }
    csynth {
        puts "***** C/RTL SYNTHESIS *****"
        csynth_design
        puts "***** C/RTL SYNTHESIS DONE *****"
    }
    cosim {
        puts "***** C/RTL CO-SIMULATION (with synthesis) *****"
        csynth_design
        cosim_design -rtl verilog -trace_level none -disable_deadlock_detection
        puts "***** CO-SIMULATION DONE *****"
    }
    cosim_only {
        puts "***** C/RTL CO-SIMULATION (reusing existing csynth) *****"
        cosim_design -rtl verilog -trace_level none -disable_deadlock_detection
        puts "***** CO-SIMULATION DONE *****"
    }
    kernels {
        puts "***** EXPORT XO + IP CATALOG *****"
        file mkdir ip
        csynth_design
        export_design -format xo -output ip/rtda_split.xo
        export_design -format ip_catalog -output ip/rtda_split_ip
        puts "***** EXPORT DONE *****"
    }
    default {
        puts "ERROR: unknown command '$command'"
        puts "Usage: vitis_hls rtda_split_project.tcl \[csim|csynth|cosim|cosim_only|kernels\]"
        exit 1
    }
}

close_project
exit
