# TCL script to rerun synthesis and implementation for Spartan 7 project

# Open the project
open_project thesis_ultrascale_1 - spartan7.xpr

# Reset synthesis run
reset_run synth_1

# Reset implementation run
reset_run impl_1

# Launch synthesis
launch_runs synth_1 -jobs 4

# Wait for synthesis to complete
wait_on_run synth_1

# Launch implementation
launch_runs impl_1 -jobs 4

# Wait for implementation to complete
wait_on_run impl_1

# Generate reports
open_run impl_1
report_utilization -file utilization_report.txt
report_timing -file timing_report.txt
report_power -file power_report.txt

# Close project
close_project