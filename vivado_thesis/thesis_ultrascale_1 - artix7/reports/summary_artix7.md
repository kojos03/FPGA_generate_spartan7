# Artix-7 Thesis Measurement Summary

- Target part: `xc7a200tfbg676-2`
- Top module: `nn_rgb`
- Constraint mode: measurement-only timing (`create_clock -name clk -period 13.468 [get_ports clk]`)
- Flow date: `2026-03-20`

| Metric | Value |
|---|---|
| LUT | 4983 |
| FF | 948 |
| DSP | 98 |
| BRAM | 0 |
| WNS | 1.976 ns |
| TNS | 0.000 ns |
| Estimated Fmax | ~87.02 MHz (`1 / (13.468 ns - 1.976 ns)`) |
| 74.25 MHz met? | Yes |
| Implementation status | Completed through routing (`impl_1` route_design complete) |
| Failure reason (if any) | None for synth/impl measurement flow |

## Notes

- Simulation-only files (`tb_nn_rgb.vhd`, `sim_nn_rgb.vhd`) were excluded from synth/impl sources.
- Compile order was verified in `reports/compile_order_synth.rpt`.
- This setup is for thesis measurement/resource/timing evaluation only, not real board deployment.