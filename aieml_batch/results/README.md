# hw_emu results — 2026-08-08

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
