# Artix-7 thesis measurement flow
# Usage: <vivado_bin> -mode batch -source run_artix7_measurements.tcl

set proj_dir "C:/Users/OmilosNeonTexn/Desktop/tepak/erevna/FPGA_generate - Copy/vivado_thesis/thesis_ultrascale_1 - artix7"
set proj_name "thesis_ultrascale_1 - artix7"
set proj_file [file join $proj_dir "$proj_name.xpr"]
set report_dir [file join $proj_dir "reports"]
set src_dir [file join $proj_dir "src"]
set constr_file [file join $proj_dir "constraints" "nn_rgb_measurement_only_artix7.xdc"]
set target_part "xc7a200tfbg676-2"

set ordered_sources [list \
  [file join $src_dir "config.vhd"] \
  [file join $src_dir "control.vhd"] \
  [file join $src_dir "multiplier.vhd"] \
  [file join $src_dir "sigmoid_IP.vhd"] \
  [file join $src_dir "neuron.vhd"] \
  [file join $src_dir "sigmoid_lut.vhd"] \
  [file join $src_dir "nn_rgb.vhd"] \
]

proc assert_run_complete {run_name} {
  set status [get_property STATUS [get_runs $run_name]]
  if {![string match "*Complete*" $status]} {
    error "$run_name did not complete successfully. Status: $status"
  }
}

file mkdir $report_dir
cd $proj_dir

if {[file exists $proj_file]} {
  open_project $proj_file
} else {
  create_project $proj_name $proj_dir -part $target_part
}

set_property part $target_part [current_project]
set_property target_language VHDL [current_project]
set_property default_lib xil_defaultlib [current_project]

# Keep only intended hardware sources in synthesis/implementation fileset.
set existing_src_files [get_files -quiet -of_objects [get_filesets sources_1]]
if {[llength $existing_src_files] > 0} {
  remove_files $existing_src_files
}

foreach src_file $ordered_sources {
  if {![file exists $src_file]} {
    error "Missing required source file: $src_file"
  }
  add_files -fileset sources_1 [list $src_file]
}

# Ensure simulation-only files are not part of synth/impl sources.
foreach sim_only [list "tb_nn_rgb.vhd" "sim_nn_rgb.vhd"] {
  foreach added_src [get_files -quiet -of_objects [get_filesets sources_1]] {
    if {[string match "*$sim_only" $added_src]} {
      error "Simulation-only file was added to sources_1: $sim_only"
    }
  }
}

# Replace constraints set with the measurement-only XDC.
set existing_constr_files [get_files -quiet -of_objects [get_filesets constrs_1]]
if {[llength $existing_constr_files] > 0} {
  remove_files $existing_constr_files
}
if {![file exists $constr_file]} {
  error "Missing constraint file: $constr_file"
}
add_files -fileset constrs_1 [list $constr_file]

set_property top nn_rgb [get_filesets sources_1]
update_compile_order -fileset sources_1
report_compile_order -fileset sources_1 -used_in synthesis -file [file join $report_dir "compile_order_synth.rpt"]

# Run from clean state for reproducible thesis measurements.
reset_run synth_1
reset_run impl_1

launch_runs synth_1 -jobs 4
wait_on_run synth_1
assert_run_complete synth_1

open_run synth_1
report_utilization -file [file join $report_dir "utilization_synth.rpt"]
report_timing_summary -max_paths 20 -report_unconstrained -file [file join $report_dir "timing_summary_synth.rpt"]
close_design

launch_runs impl_1 -to_step route_design -jobs 4
wait_on_run impl_1
assert_run_complete impl_1

open_run impl_1
report_utilization -file [file join $report_dir "utilization_impl.rpt"]
report_timing_summary -max_paths 20 -report_unconstrained -warn_on_violation -file [file join $report_dir "timing_summary_impl.rpt"]
report_clocks -file [file join $report_dir "clock_summary_impl.rpt"]
close_design

close_project

puts "Artix-7 measurement flow complete. Reports written under: $report_dir"
