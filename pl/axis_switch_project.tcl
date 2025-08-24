# ===================================================================
# Vitis HLS Project TCL Script for 'axis_switch'
# ===================================================================

# --- Step 1: User Configuration ---
set kernel_name "axis_switch"
set part_name   "xcve2802-vsvh1760-2MP-e-S"

# --- Step 2: Automatic Naming ---
set project_name "${kernel_name}_hls"
set top_function "${kernel_name}_pl"
set kernel_file  "src/${kernel_name}_pl.cpp"
set tb_file      "src/${kernel_name}_test.cpp"

# --- Step 3: Command Handling ---
if {$argc > 0} {
    set command [lindex $argv 0]
} else {
    puts "ERROR: Please provide a command."
    puts "Usage: vitis_hls -f project.tcl <command>"
    exit 1
}

# --- Step 4: Project and Solution Setup ---
open_project $project_name
set_top $top_function

add_files $kernel_file
add_files -tb $tb_file

open_solution -flow_target vitis "solution1"

set_part ${part_name}
create_clock -period 3.33 -name default

# --- Step 5: Execute Command ---
switch $command {
    "csim" { csim_design }
    "csynth" { csynth_design }
    "cosim" {
        csynth_design
        cosim_design -rtl verilog -trace_level all
    }
    "export_ip" {
        csynth_design
        export_design -format ip_catalog -output ./ip/${project_name}_ip
    }
    "export_xo" {
        csynth_design
        export_design -format xo -output ./ip/${project_name}.xo
    }
    "kernels" {
        csynth_design
        export_design -format xo -output ./ip/${project_name}.xo
        export_design -format ip_catalog -output ./ip/${project_name}_ip
    }
    default { puts "ERROR: Unknown command '$command'." }
}

close_project
exit
