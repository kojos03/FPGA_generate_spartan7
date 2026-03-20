# Spartan-7 vs Artix-7 Comparison (Tighter Tested Clocks)

| Item | Spartan-7 | Artix-7 |
|---|---|---|
| Target part | `xc7s100fgga676-2` | `xc7a200tfbg676-2` |
| Original clock | 13.468 ns (74.25 MHz) | 13.468 ns (74.25 MHz) |
| Original WNS (given) | 1.11 ns | 1.98 ns |
| Estimated Fmax from original WNS | 80.919 MHz | 87.047 MHz |
| Tighter tested clock | 12.500 ns (80.0 MHz) | 11.765 ns (85.0 MHz) |
| New post-route WNS | 0.856 ns | 0.574 ns |
| New post-route TNS | 0.000 ns | 0.000 ns |
| Tighter tested clock met? | Yes | Yes |
| LUT | 4988 | 4985 |
| FF | 948 | 948 |
| DSP | 98 | 98 |
| BRAM | 0 | 0 |
| Implementation status | Route complete | Route complete |
| Throughput @74.25 MHz (samples/s) | 74.25e6 | 74.25e6 |
| Throughput @74.25 MHz (pixels/s) | 74.25e6 | 74.25e6 |
| Throughput @74.25 MHz (bits/s) | 1.782e9 | 1.782e9 |
| Throughput @74.25 MHz (Gbps) | 1.782 | 1.782 |
| Throughput @tighter clock (samples/s) | 80.0e6 | 85.0e6 |
| Throughput @tighter clock (pixels/s) | 80.0e6 | 85.0e6 |
| Throughput @tighter clock (bits/s) | 1.920e9 | 2.040e9 |
| Throughput @tighter clock (Gbps) | 1.920 | 2.040 |

## Throughput Assumption Used for Both

- `samples/cycle = 1`, `pixels/cycle = 1`, `bits/cycle = 24` (one RGB pixel per cycle, steady state).