# -----------------------------------------------------------------------------
# Minimal measurement-only timing constraints for thesis evaluation.
# Spartan-7 project: resource/timing characterization only.
# Not for board bring-up and intentionally no package pin assignments.
# -----------------------------------------------------------------------------

create_clock -name clk -period 12.500 [get_ports clk]
