# Spartan-7 Thesis Measurement Summary

- Target part: `xc7s100fgga676-2`
- Top module: `nn_rgb`
- Implementation status: `Completed through routing (impl_1 route_design complete)`

## Clock Sweep Results

| Step | Period (ns) | Frequency (MHz) | WNS (ns) | TNS (ns) | Met? |
|---|---:|---:|---:|---:|---|
| Original baseline (given) | 13.468 | 74.25 | 1.11 | N/A | Yes |
| Tightened step 1 | 12.500 | 80.0 | 0.856 | 0.000 | Yes |
| Tightened step 2 | 11.765 | 85.0 | 0.632 | 0.000 | Yes |
| Tightened step 3 | 11.236 | 89.0 | 0.176 | 0.000 | Yes |
| Final pushed step (current) | 11.111 | 90.0 | 0.029 | 0.000 | Yes |

## Current Resource Results (Post-Route)

| Metric | Value |
|---|---:|
| LUT | 5060 |
| FF | 1211 |
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

### At tightened step 1: 80.0 MHz
- Samples/s: `(1 sample/cycle) × 80.0e6 cycle/s = 80.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 80.0e6 cycle/s = 80.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 80.0e6 cycle/s = 1.920e9 bits/s`
- Gbps: `1.920e9 / 1e9 = 1.920 Gbps`

### At tightened step 2: 85.0 MHz
- Samples/s: `(1 sample/cycle) × 85.0e6 cycle/s = 85.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 85.0e6 cycle/s = 85.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 85.0e6 cycle/s = 2.040e9 bits/s`
- Gbps: `2.040e9 / 1e9 = 2.040 Gbps`

### At tightened step 3: 89.0 MHz
- Samples/s: `(1 sample/cycle) × 89.0e6 cycle/s = 89.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 89.0e6 cycle/s = 89.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 89.0e6 cycle/s = 2.136e9 bits/s`
- Gbps: `2.136e9 / 1e9 = 2.136 Gbps`

### At final pushed step: 90.0 MHz
- Samples/s: `(1 sample/cycle) × 90.0e6 cycle/s = 90.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 90.0e6 cycle/s = 90.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 90.0e6 cycle/s = 2.160e9 bits/s`
- Gbps: `2.160e9 / 1e9 = 2.160 Gbps`

## Notes

- Thesis measurement flow only (not board deployment constraints).
- Simulation-only files are excluded from synthesis/implementation.
