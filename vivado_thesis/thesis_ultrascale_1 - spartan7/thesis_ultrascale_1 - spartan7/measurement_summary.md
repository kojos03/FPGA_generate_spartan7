# Spartan-7 Thesis Measurement Summary

- Target part: `xc7s100fgga676-2`
- Constraint mode: minimal measurement-only timing (`create_clock` on `clk`, 74.25 MHz)
- Flow date: `2026-03-19`

| Metric | Value |
|---|---|
| LUT | 4962 |
| FF | 478 |
| DSP | 71 |
| BRAM | 0 |
| WNS | -17.348 ns |
| TNS | -4222.226 ns |
| Estimated Fmax | ~32.45 MHz (`1 / (13.468 ns + 17.348 ns)`) |
| 74.25 MHz met? | No |

## Notes

- Implementation completed through routing (no bitstream generation in this measurement flow).
- Unconstrained-path check was included via `report_timing_summary -report_unconstrained`.
- No unconstrained internal endpoints were reported; missing I/O delay constraints remain expected for this minimal setup.
