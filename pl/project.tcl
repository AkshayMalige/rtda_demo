# ============================================
# Vitis HLS Project TCL Script (Final Version)
# ============================================

# Project Setup
set base_dir [file normalize "../"]
set project_name "leaky_relu_hls"
set top_function "leaky_relu_pl"

# Create Project
open_project $project_name
set_top $top_function

# Optional: Interface Flag Handling
if {[info exists ::env(INTERFACE)] && $::env(INTERFACE) eq "1"} {
    set extra_cflags "-DINTERFACE=1"
} else {
    set extra_cflags "-DINTERFACE=0"
}

# Add Kernel Source File
add_files leaky_relu_hls.cpp -cflags $extra_cflags
add_files -tb leaky_relu_test.cpp


# Solution Setup
open_solution "solution1"
set_part {xcve2802-vsvh1760-2MP-e-S}
create_clock -period 3.33 -name default

# Run Synthesis and Export
csynth_design
export_design -format xo -output ./ip/${project_name}.xo
export_design -format ip_catalog -output ./ip/${project_name}_ip

# Clean Exit
close_project