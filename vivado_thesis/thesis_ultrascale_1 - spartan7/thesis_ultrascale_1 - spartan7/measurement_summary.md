# Spartan-7 Thesis Measurement Summary

- Target part: `xc7s100fgga676-2`
- Project folder: `vivado_thesis/thesis_ultrascale_1 - spartan7/thesis_ultrascale_1 - spartan7`
- Flow run date: `2026-03-19`

## Post-Edit Implementation Results (measurement-only constraints)

Source reports (all inside this folder):
- `reports/utilization_impl.rpt`
- `reports/timing_summary_impl.rpt`
- `reports/clock_summary_impl.rpt`

| Metric | Value |
|---|---|
| LUT | 4962 |
| FF | 478 |
| DSP | 71 |
| BRAM | 0 |
| WNS | -17.348 ns |
| TNS | -4222.226 ns |
| Estimated Fmax | ~32.45 MHz (from `1 / (13.468 ns + 17.348 ns)`) |
| Implementation status | Routed successfully (`impl_1` complete) |
| Failure reason (if any) | Timing not met at 74.25 MHz target clock (`clk_in`), large setup violations remain |

## Notes

- This project is now self-contained for Spartan-7 under this folder (local VHDL copies + local XDC).
- XDC is for thesis measurement only and not for real board bring-up.
- Input/output delay constraints are intentionally not defined yet because board-level interfaces are not finalized.
