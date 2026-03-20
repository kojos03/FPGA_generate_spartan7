# Artix-7 Thesis Measurement Summary

- Target part: `xc7a200tfbg676-2`
- Top module: `nn_rgb`
- Implementation status: `Completed through routing (impl_1 route_design complete)`

## Clock Sweep Results

| Step | Period (ns) | Frequency (MHz) | WNS (ns) | TNS (ns) | Met? |
|---|---:|---:|---:|---:|---|
| Original baseline (given) | 13.468 | 74.25 | 1.98 | N/A | Yes |
| Previous tightened test | 11.765 | 85.0 | 0.574 | 0.000 | Yes |
| New tightened test (current) | 11.364 | 88.0 | 0.324 | 0.000 | Yes |

## Current Resource Results (Post-Route)

| Metric | Value |
|---|---:|
| LUT | 5061 |
| FF | 1048 |
| DSP | 98 |
| BRAM | 0 |

## Throughput Assumptions

- Steady-state streaming operation.
- `samples/cycle = 1`
- `pixels/cycle = 1`
- `bits/cycle = 24` (one RGB pixel per cycle)

## Throughput Formula

`Throughput = (Data Bits or Samples / Clock Cycles) × Clock Frequency`

## Throughput Calculations

### At original 74.25 MHz
- Samples/s: `(1 sample/cycle) × 74.25e6 cycle/s = 74.25e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 74.25e6 cycle/s = 74.25e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 74.25e6 cycle/s = 1.782e9 bits/s`
- Gbps: `1.782e9 / 1e9 = 1.782 Gbps`

### At previous tightened 85.0 MHz
- Samples/s: `(1 sample/cycle) × 85.0e6 cycle/s = 85.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 85.0e6 cycle/s = 85.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 85.0e6 cycle/s = 2.040e9 bits/s`
- Gbps: `2.040e9 / 1e9 = 2.040 Gbps`

### At new tightened 88.0 MHz
- Samples/s: `(1 sample/cycle) × 88.0e6 cycle/s = 88.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 88.0e6 cycle/s = 88.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 88.0e6 cycle/s = 2.112e9 bits/s`
- Gbps: `2.112e9 / 1e9 = 2.112 Gbps`

## Notes

- Thesis measurement flow only (not board deployment constraints).
- Simulation-only files are excluded from synthesis/implementation.