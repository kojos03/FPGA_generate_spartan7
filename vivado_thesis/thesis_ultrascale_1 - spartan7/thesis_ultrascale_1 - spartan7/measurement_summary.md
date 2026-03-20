# Spartan-7 Thesis Measurement Summary

- Target part: `xc7s100fgga676-2`
- Top module: `nn_rgb`
- Original clock: `13.468 ns` (`74.25 MHz`)
- Original WNS (given baseline): `1.11 ns`
- Estimated Tmin from original WNS: `13.468 - 1.11 = 12.358 ns`
- Estimated Fmax from original WNS: `1 / 12.358e-9 = 80.919 MHz` (approx.)
- Tighter tested clock: `12.500 ns` (`80.0 MHz`)
- New constraint met?: `Yes`

| Metric | Value |
|---|---|
| New post-route WNS | 0.856 ns |
| New post-route TNS | 0.000 ns |
| LUT | 4988 |
| FF | 948 |
| DSP | 98 |
| BRAM | 0 |
| Implementation status | Completed through routing (`impl_1` route_design complete) |

## Throughput Assumptions

- Steady-state streaming operation.
- One RGB pixel is processed per clock cycle (`pixels/cycle = samples/cycle = 1`, `bits/cycle = 24`).
- The design is pipelined, but steady-state throughput remains one pixel per cycle.

## Throughput Formula

`Throughput = (Data Bits or Samples / Clock Cycles) × Clock Frequency`

## Throughput at Original Clock (74.25 MHz)

- Samples/s: `(1 sample/cycle) × 74.25e6 cycle/s = 74.25e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 74.25e6 cycle/s = 74.25e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 74.25e6 cycle/s = 1.782e9 bits/s`
- Gbps: `1.782e9 / 1e9 = 1.782 Gbps`

## Throughput at Tighter Tested Clock (80.0 MHz)

- Samples/s: `(1 sample/cycle) × 80.0e6 cycle/s = 80.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 80.0e6 cycle/s = 80.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 80.0e6 cycle/s = 1.920e9 bits/s`
- Gbps: `1.920e9 / 1e9 = 1.920 Gbps`

## Notes

- This setup is for thesis resource/timing/throughput measurement only (not board deployment constraints).
- Simulation-only files are not used in synthesis/implementation in this flow.