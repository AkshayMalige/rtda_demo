# Results

## Hardware (VEK280, TARGET=hw) — 2026-08-09

Track-count sweep, all events in a single `graph.run()`:

| tracks | events | per track | total execute |
|---:|---:|---:|---:|
| 50 | 1 | 12.700 us | 635 us |
| 500 | 10 | 1.800 us | 900 us |
| 5000 | 100 | **0.696 us** | 3480 us |

A least-squares fit gives

    total = 609.4 us (fixed) + 574.2 ns x tracks

and the three points reproduce to <0.5%. Two conclusions:

**1. The marginal cost is 574.2 ns/track against a cycle-accurate prediction of
582.6 ns/track -- 1.4% agreement.** aiesimulator, hw_emu and silicon all agree; the
AIE does exactly what the model said.

**2. The 12.7 us/track at 50 tracks was never the array.** It is 609 us of fixed
per-`graph.run()` cost (XRT/driver round-trip, GMIO arming) spread over too few
tracks. At 50 tracks the array is busy 4.5% of the time; at 5000 it is 82%.

Sustained throughput at 5000 tracks: **759 GOP/s**.
Versus `aieml/` at 17,770 ns/track: **25.5x measured, 30.9x on the marginal rate.**

The fixed cost is host-side and cannot be reduced by the AIE design. For a
latency-bound single-event workload it dominates and would need separate work
(persistent graph, GMIO ping-pong without re-arming, or a PL-side feeder).

Reproduce:

    RTDA_INPUT=sd_batch/testdata/embed_input_5000.txt ./host_batch.exe

## hw_emu — 2026-08-08

Captured from a full `TARGET=hw_emu AIE_DIR=aieml_batch` run on QEMU: AIE graph +
XRT host, no PL kernels.

    hw_emu_track_mean_128.txt   the 128-wide event mean straight out of the AIE
    hw_emu_track_out_27.txt     after the host-side output dense (128 -> 27)

## Validation

| comparison | max abs diff |
|---|---:|
| hw_emu vs the x86/aie **simulation** | **8.4e-07** |
| hw_emu vs `data_fp32/aieml10_output_aie.txt` (mean over 50) | 5.0e-03 |
| **simulation** vs the same reference | 5.0e-03 |

The last two being identical is the point: hardware emulation introduces nothing.
The 5.0e-03 is entirely the warm-up convention — tracks 0-2 use the zero-pad roll
rather than the circular one, and those three are inside the 50-track average
(3 x ~0.21 / 50 gives up to 1.3e-02, so 5.0e-03 sits inside it). On tracks 3..49
the AIE agrees with the reference to 7.4e-06.

`aieml/` does not perform the circular wrap either on a single 50-track run, so
closing this gap would make the batched design diverge from the reference rather
than converge on it.

## Run log highlights

    [host] loading 92 RTP ports...
    [host] RTP loaded: 1039 KB
    [host] running graph: 7 iterations x 8 tracks (50 real + 6 padding)
    [host] event mean in frame 6 of 7        <- 50 counted, 6 padding dropped
    [host] done

Reproduce:

    make system TARGET=hw_emu AIE_DIR=aieml_batch
    cd package.hw_emu && ./launch_hw_emu.sh
    # in the guest: sudo su; mount /dev/mmcblk0p1 /mnt; cd /mnt; ./host_batch.exe
