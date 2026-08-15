# The PL build that routed

Utilization reports lifted out of `pl_fixed/_x/` (2026-05-18), the last
`rtda_split_top` build that got all the way through `route_design` and produced
a bitstream. Copied here because `make -C pl_fixed clean` deletes `_x/`, and
this is the only known-good reference point the project has.

|                | 2026-05-18 (routed) | 2026-08-14 (failed) |
| -------------- | ------------------- | ------------------- |
| CLB LUTs       | **224,344 (43.08%)**| **513,603 (98.87%)**|
| CLB Registers  | 482,297 (46.31%)    | 562,277 (54.09%)    |
| Block RAM Tile | 150 (25.00%)        | 235 (39.17%)        |
| DSP            | 80.56%              | 80.56%              |
| URAM           | 0                   | 0                   |

Same kernel, same top, **identical DSP** — so the multipliers did not change.
LUTs grew by 289,259.

The August build placed successfully and met timing (WNS +0.213 ns). It died in
routing: congestion level 6, 469,480 signals unrouted. At 98.87% LUT there was
no fabric left to run wires through.

## Where the 289k went

The realignment between these two builds moved the leaky ReLU slope from 0.125
(a bare `x >> 3`) to the network's actual 0.1, computed as shifts and adds to
avoid spending DSPs. That is correct arithmetic -- 0.125 is 25% off the trained
slope at all 14 layers, and measures 33x worse -- but the shift-add chain was
built as **128 parallel combinational lanes per layer**: 24,706 LUT of
`Expression`, latency 0, fourteen times over.

The fix is not to go back to 0.125. It is to stop building 128 lanes for a
layer whose dense feeder has an II of 256. See `RTDA_LEAKY_LANES` in
`../pl/src/rtda_leaky.h`.

## Reproducing the old configuration

`make system FLOW=pl_fixed TARGET=hw ALPHA125=1` is close to this build's
arithmetic. Use it only as a fallback for getting *a* bitstream onto silicon --
its accuracy is 33x worse and it should not become the default again.
