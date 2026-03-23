# Artix-7 Thesis Measurement Summary

- Target part: `xc7a200tfbg676-2`
- Top module: `nn_rgb`
- Implementation status: `Completed through routing (impl_1 route_design complete), stable timing met at 94.0 MHz`
- Highest tested passing frequency so far: `94.0 MHz`
- Failed exploratory frequency: `95.0 MHz`

## Clock Sweep Results

| Step | Period (ns) | Frequency (MHz) | WNS (ns) | TNS (ns) | Met? |
|---|---:|---:|---:|---:|---|
| Original baseline (given) | 13.468 | 74.25 | 1.98 | N/A | Yes |
| Tightened step 1 | 11.765 | 85.0 | 0.574 | 0.000 | Yes |
| Tightened step 2 | 11.364 | 88.0 | 0.324 | 0.000 | Yes |
| Tightened step 3 | 11.111 | 90.0 | 0.140 | 0.000 | Yes |
| Tightened step 4 | 10.989 | 91.0 | 0.192 | 0.000 | Yes |
| Tightened step 5 | 10.870 | 92.0 | 0.345 | 0.000 | Yes |
| Final stable step (current) | 10.638 | 94.0 | 0.171 | 0.000 | Yes |
| Failed exploratory step | 10.526 | 95.0 | -0.178 | -0.468 | No |

## Current Resource Results (Post-Route at stable 94.0 MHz)

| Metric | Value |
|---|---:|
| LUT | 5085 |
| FF | 1245 |
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

### At tightened step 4: 91.0 MHz
- Samples/s: `(1 sample/cycle) × 91.0e6 cycle/s = 91.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 91.0e6 cycle/s = 91.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 91.0e6 cycle/s = 2.184e9 bits/s`
- Gbps: `2.184e9 / 1e9 = 2.184 Gbps`

### At tightened step 5: 92.0 MHz
- Samples/s: `(1 sample/cycle) × 92.0e6 cycle/s = 92.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 92.0e6 cycle/s = 92.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 92.0e6 cycle/s = 2.208e9 bits/s`
- Gbps: `2.208e9 / 1e9 = 2.208 Gbps`

### At final stable step: 94.0 MHz
- Samples/s: `(1 sample/cycle) × 94.0e6 cycle/s = 94.0e6 samples/s`
- Pixels/s: `(1 pixel/cycle) × 94.0e6 cycle/s = 94.0e6 pixels/s`
- Bits/s: `(24 bits/cycle) × 94.0e6 cycle/s = 2.256e9 bits/s`
- Gbps: `2.256e9 / 1e9 = 2.256 Gbps`

## Interpretation

- 94.0 MHz is the final stable passing frequency used for thesis reporting.
- 95.0 MHz remains a failed exploratory point.
- Practical limit is between 94 and 95 MHz.

## Notes

- Thesis measurement flow only (not board deployment constraints).
- Simulation-only files are excluded from synthesis/implementation.
