# Artix-7 Thesis Measurement Summary

- Target part: `xc7a200tfbg676-2`
- Top module: `nn_rgb`
- Implementation status: `Completed through routing (impl_1 route_design complete)`

## Clock Sweep Results

| Step | Period (ns) | Frequency (MHz) | WNS (ns) | TNS (ns) | Met? |
|---|---:|---:|---:|---:|---|
| Original baseline (given) | 13.468 | 74.25 | 1.98 | N/A | Yes |
| Tightened step 1 | 11.765 | 85.0 | 0.574 | 0.000 | Yes |
| Tightened step 2 | 11.364 | 88.0 | 0.324 | 0.000 | Yes |
| Tightened step 3 | 11.111 | 90.0 | 0.140 | 0.000 | Yes |
| Final pushed step (current) | 10.989 | 91.0 | 0.192 | 0.000 | Yes |

## Current Resource Results (Post-Route)

| Metric | Value |
|---|---:|
| LUT | 5066 |
| FF | 1243 |
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

### At tightened step 1: 85.0 MHz
- Samples/s: `(1 sample/cycle) × 85.0e6 cycle/s = 85.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 85.0e6 cycle/s = 85.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 85.0e6 cycle/s = 2.040e9 bits/s`
- Gbps: `2.040e9 / 1e9 = 2.040 Gbps`

### At tightened step 2: 88.0 MHz
- Samples/s: `(1 sample/cycle) × 88.0e6 cycle/s = 88.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 88.0e6 cycle/s = 88.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 88.0e6 cycle/s = 2.112e9 bits/s`
- Gbps: `2.112e9 / 1e9 = 2.112 Gbps`

### At tightened step 3: 90.0 MHz
- Samples/s: `(1 sample/cycle) × 90.0e6 cycle/s = 90.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 90.0e6 cycle/s = 90.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 90.0e6 cycle/s = 2.160e9 bits/s`
- Gbps: `2.160e9 / 1e9 = 2.160 Gbps`

### At final pushed step: 91.0 MHz
- Samples/s: `(1 sample/cycle) × 91.0e6 cycle/s = 91.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 91.0e6 cycle/s = 91.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 91.0e6 cycle/s = 2.184e9 bits/s`
- Gbps: `2.184e9 / 1e9 = 2.184 Gbps`

## Notes

- Thesis measurement flow only (not board deployment constraints).
- Simulation-only files are excluded from synthesis/implementation.
