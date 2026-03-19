# -----------------------------------------------------------------------------
# nn_rgb_measurement_only_spartan7.xdc
# -----------------------------------------------------------------------------
# Thesis measurement constraints for Spartan-7 (xc7s100fgga676-2) only.
# This file is intentionally NOT a real board bring-up XDC.
# Pin locations below are legal dummy/package pins so synthesis/implementation
# can complete for resource/timing measurements before final board constraints.
# -----------------------------------------------------------------------------

# 74.25 MHz pixel clock target (T = 13.468 ns)
create_clock -name clk_in -period 13.468 [get_ports {clk}]

# Apply a single safe default standard for this measurement-only setup.
set_property IOSTANDARD LVCMOS18 [get_ports {*}]

# Inputs
set_property PACKAGE_PIN AB21 [get_ports {clk}]
set_property PACKAGE_PIN AD21 [get_ports {reset_n}]
set_property PACKAGE_PIN AB26 [get_ports {enable_in[0]}]
set_property PACKAGE_PIN AF24 [get_ports {enable_in[1]}]
set_property PACKAGE_PIN M26  [get_ports {enable_in[2]}]
set_property PACKAGE_PIN AC21 [get_ports {vs_in}]
set_property PACKAGE_PIN AE22 [get_ports {hs_in}]
set_property PACKAGE_PIN AA19 [get_ports {de_in}]

set_property PACKAGE_PIN AD20 [get_ports {r_in[0]}]
set_property PACKAGE_PIN AD19 [get_ports {r_in[1]}]
set_property PACKAGE_PIN AC19 [get_ports {r_in[2]}]
set_property PACKAGE_PIN AF19 [get_ports {r_in[3]}]
set_property PACKAGE_PIN AE18 [get_ports {r_in[4]}]
set_property PACKAGE_PIN AF20 [get_ports {r_in[5]}]
set_property PACKAGE_PIN AE20 [get_ports {r_in[6]}]
set_property PACKAGE_PIN AB19 [get_ports {r_in[7]}]

set_property PACKAGE_PIN AC16 [get_ports {g_in[0]}]
set_property PACKAGE_PIN AF18 [get_ports {g_in[1]}]
set_property PACKAGE_PIN AF17 [get_ports {g_in[2]}]
set_property PACKAGE_PIN AC17 [get_ports {g_in[3]}]
set_property PACKAGE_PIN AB17 [get_ports {g_in[4]}]
set_property PACKAGE_PIN AD18 [get_ports {g_in[5]}]
set_property PACKAGE_PIN AC18 [get_ports {g_in[6]}]
set_property PACKAGE_PIN AE21 [get_ports {g_in[7]}]

set_property PACKAGE_PIN AE17 [get_ports {b_in[0]}]
set_property PACKAGE_PIN AF15 [get_ports {b_in[1]}]
set_property PACKAGE_PIN AE15 [get_ports {b_in[2]}]
set_property PACKAGE_PIN AE16 [get_ports {b_in[3]}]
set_property PACKAGE_PIN AD15 [get_ports {b_in[4]}]
set_property PACKAGE_PIN AA18 [get_ports {b_in[5]}]
set_property PACKAGE_PIN AA17 [get_ports {b_in[6]}]
set_property PACKAGE_PIN AD16 [get_ports {b_in[7]}]

# Outputs
set_property PACKAGE_PIN W26 [get_ports {vs_out}]
set_property PACKAGE_PIN Y25 [get_ports {hs_out}]
set_property PACKAGE_PIN Y26 [get_ports {de_out}]

set_property PACKAGE_PIN AF25 [get_ports {r_out[0]}]
set_property PACKAGE_PIN AE25 [get_ports {r_out[1]}]
set_property PACKAGE_PIN AC24 [get_ports {r_out[2]}]
set_property PACKAGE_PIN AC23 [get_ports {r_out[3]}]
set_property PACKAGE_PIN AD25 [get_ports {r_out[4]}]
set_property PACKAGE_PIN AD24 [get_ports {r_out[5]}]
set_property PACKAGE_PIN AE26 [get_ports {r_out[6]}]
set_property PACKAGE_PIN AD26 [get_ports {r_out[7]}]

set_property PACKAGE_PIN AC22 [get_ports {g_out[0]}]
set_property PACKAGE_PIN AB22 [get_ports {g_out[1]}]
set_property PACKAGE_PIN AB20 [get_ports {g_out[2]}]
set_property PACKAGE_PIN AA20 [get_ports {g_out[3]}]
set_property PACKAGE_PIN AF23 [get_ports {g_out[4]}]
set_property PACKAGE_PIN AF22 [get_ports {g_out[5]}]
set_property PACKAGE_PIN AE23 [get_ports {g_out[6]}]
set_property PACKAGE_PIN AD23 [get_ports {g_out[7]}]

set_property PACKAGE_PIN Y20  [get_ports {b_out[0]}]
set_property PACKAGE_PIN Y22  [get_ports {b_out[1]}]
set_property PACKAGE_PIN Y21  [get_ports {b_out[2]}]
set_property PACKAGE_PIN AA23 [get_ports {b_out[3]}]
set_property PACKAGE_PIN AA22 [get_ports {b_out[4]}]
set_property PACKAGE_PIN AA25 [get_ports {b_out[5]}]
set_property PACKAGE_PIN AA24 [get_ports {b_out[6]}]
set_property PACKAGE_PIN Y23  [get_ports {b_out[7]}]

set_property PACKAGE_PIN W23 [get_ports {clk_o}]
set_property PACKAGE_PIN AB25 [get_ports {led[0]}]
set_property PACKAGE_PIN AB24 [get_ports {led[1]}]
set_property PACKAGE_PIN AC26 [get_ports {led[2]}]

# Keep moderate output drive/slew for measurement-only implementation runs.
set_property DRIVE 12 [get_ports {vs_out hs_out de_out clk_o led[*] r_out[*] g_out[*] b_out[*]}]
set_property SLEW SLOW [get_ports {vs_out hs_out de_out clk_o led[*] r_out[*] g_out[*] b_out[*]}]
