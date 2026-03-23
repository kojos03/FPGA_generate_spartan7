# Spartan-7 vs Artix-7 Comparison (Final Timing Push)

| Item | Spartan-7 | Artix-7 |
|---|---|---|
| Target part | `xc7s100fgga676-2` | `xc7a200tfbg676-2` |
| Original baseline clock | 13.468 ns (74.25 MHz) | 13.468 ns (74.25 MHz) |
| Original baseline WNS (given) | 1.11 ns | 1.98 ns |
| Tightened step 1 | 12.500 ns (80.0 MHz) | 11.765 ns (85.0 MHz) |
| Tightened step 1 WNS | 0.856 ns | 0.574 ns |
| Tightened step 2 | 11.765 ns (85.0 MHz) | 11.364 ns (88.0 MHz) |
| Tightened step 2 WNS | 0.632 ns | 0.324 ns |
| Tightened step 3 | 11.236 ns (89.0 MHz) | 11.111 ns (90.0 MHz) |
| Tightened step 3 WNS | 0.176 ns | 0.140 ns |
| Final pushed clock | 11.111 ns (90.0 MHz) | 10.989 ns (91.0 MHz) |
| Final post-route WNS | 0.029 ns | 0.192 ns |
| Final post-route TNS | 0.000 ns | 0.000 ns |
| Final target met? | Yes | Yes |
| Implementation status | Completed through routing | Completed through routing |
| LUT (final) | 5060 | 5066 |
| FF (final) | 1211 | 1243 |
| DSP (final) | 98 | 98 |
| BRAM (final) | 0 | 0 |
| Throughput @74.25 MHz (Gbps) | 1.782 | 1.782 |
| Throughput @step 1 (Gbps) | 1.920 | 2.040 |
| Throughput @step 2 (Gbps) | 2.040 | 2.112 |
| Throughput @step 3 (Gbps) | 2.136 | 2.160 |
| Throughput @final push (Gbps) | 2.160 | 2.184 |

## Throughput Assumption Used

- `samples/cycle = 1`, `pixels/cycle = 1`, `bits/cycle = 24` (steady-state one RGB pixel per clock cycle).
