# Spartan-7 thesis measurement flow
# Usage: vivado -mode batch -source run_spartan7_measurements.tcl

set proj_dir [file normalize [file dirname [info script]]]
set proj_file [file join $proj_dir "thesis_ultrascale_1 - spartan7.xpr"]
set report_dir [file join $proj_dir "reports"]

file mkdir $report_dir
cd $proj_dir

proc assert_run_complete {run_name} {
  set status [get_property STATUS [get_runs $run_name]]
  if {![string match "*Complete*" $status]} {
    error "$run_name did not complete successfully. Status: $status"
  }
}

open_project $proj_file
update_compile_order -fileset sources_1

# Clean previous run state so measurements are reproducible.
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
report_clock_utilization -file [file join $report_dir "clock_utilization_impl.rpt"]
close_design

close_project
puts "Measurement flow complete. Reports written under: $report_dir"
