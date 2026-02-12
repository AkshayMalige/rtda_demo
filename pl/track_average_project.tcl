# ===================================================================
# Vitis HLS Project TCL Script for 'track_average'
# ===================================================================

# --- Step 1: User Configuration ---
set kernel_name "track_average"
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
    puts "Usage: vitis_hls -f project.tcl <command> [data_type]"
    exit 1
}

# Data type configuration (default to float)
if {$argc > 1} {
    set data_type [lindex $argv 1]
} else {
    set data_type "float"
}

# Set compiler flags based on data type
if {$data_type == "int16"} {
    set cflags "-DUSE_INT16"
    puts "### Using INT16 data type ###"
} else {
    set cflags "-DUSE_FLOAT32"
    puts "### Using FLOAT32 data type ###"
}

# --- Step 4: Project and Solution Setup ---
open_project $project_name
set_top $top_function

add_files $kernel_file -cflags $cflags
add_files -tb $tb_file -cflags $cflags

open_solution -flow_target vitis "solution1"

set_part ${part_name}
create_clock -period 3.33 -name default

# --- Step 5: Execute Command ---
switch $command {
    "csim" {
        puts "### Running C Simulation... ###"
        csim_design
    }
    "csynth" {
        puts "### Running C Synthesis... ###"
        csynth_design
    }
    "cosim" {
        puts "### Running Synthesis and Co-simulation... ###"
        csynth_design
        cosim_design -rtl verilog -trace_level none -disable_deadlock_detection
    }
    "export_ip" {
        puts "### Running Synthesis and Exporting IP... ###"
        csynth_design
        export_design -format ip_catalog -output ./ip/${project_name}_ip
    }
    "export_xo" {
        puts "### Running Synthesis and Exporting XO... ###"
        csynth_design
        export_design -format xo -output ./ip/${project_name}.xo
    }
    "kernels" {
        puts "### Running Synthesis... ###"
        csynth_design
        puts "### Exporting XO and IP Catalog... ###"
        export_design -format xo -output ./ip/${project_name}.xo
        export_design -format ip_catalog -output ./ip/${project_name}_ip
    }
    default {
        puts "ERROR: Unknown command '$command'."
    }
}

close_project
exit
