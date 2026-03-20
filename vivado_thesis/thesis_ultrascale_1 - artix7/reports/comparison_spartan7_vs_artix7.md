# Spartan-7 vs Artix-7 Comparison (Latest Tightened Step)

| Item | Spartan-7 | Artix-7 |
|---|---|---|
| Target part | `xc7s100fgga676-2` | `xc7a200tfbg676-2` |
| Original baseline clock | 13.468 ns (74.25 MHz) | 13.468 ns (74.25 MHz) |
| Original baseline WNS (given) | 1.11 ns | 1.98 ns |
| Previous tightened clock | 12.500 ns (80.0 MHz) | 11.765 ns (85.0 MHz) |
| Previous tightened WNS | 0.856 ns | 0.574 ns |
| New tightened clock | 11.765 ns (85.0 MHz) | 11.364 ns (88.0 MHz) |
| New post-route WNS | 0.632 ns | 0.324 ns |
| New post-route TNS | 0.000 ns | 0.000 ns |
| New target met? | Yes | Yes |
| LUT (new) | 4989 | 5061 |
| FF (new) | 1013 | 1048 |
| DSP (new) | 98 | 98 |
| BRAM (new) | 0 | 0 |
| Throughput @74.25 MHz (Gbps) | 1.782 | 1.782 |
| Throughput @previous tightened (Gbps) | 1.920 | 2.040 |
| Throughput @new tightened (Gbps) | 2.040 | 2.112 |

## Throughput Assumption Used

- `samples/cycle = 1`, `pixels/cycle = 1`, `bits/cycle = 24` (steady-state one RGB pixel per clock cycle).