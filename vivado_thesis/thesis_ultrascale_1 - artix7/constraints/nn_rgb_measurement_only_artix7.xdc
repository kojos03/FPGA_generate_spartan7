# -----------------------------------------------------------------------------
# Thesis measurement-only constraints for Artix-7 resource/timing evaluation.
# Target part: xc7a200tfbg676-2
# This file is NOT for real hardware deployment or board bring-up.
# -----------------------------------------------------------------------------

# Primary pixel-processing clock (92.0 MHz exploratory thesis target)
create_clock -name clk -period 10.870 [get_ports clk]
