# -----------------------------------------------------------------------------
# Thesis measurement-only constraints for Artix-7 resource/timing evaluation.
# Target part: xc7a200tfbg676-2
# This file is NOT for real hardware deployment or board bring-up.
# -----------------------------------------------------------------------------

# Primary pixel-processing clock (85.0 MHz tighter tested thesis target)
create_clock -name clk -period 11.765 [get_ports clk]
