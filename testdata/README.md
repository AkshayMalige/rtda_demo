# Multi-event test inputs

Each file repeats the real 50-track event from `data_fp32/embed_input.txt`, so
every event is identical and all per-event means must come out the same. That
makes them a correctness check as well as a throughput sweep.

    embed_input_100.txt    100 tracks =   2 events
    embed_input_500.txt    500 tracks =  10 events
    embed_input_5000.txt  5000 tracks = 100 events

Staged onto the SD image by the top-level `sd_stage` target. On the board:

    cp sd_batch/testdata/embed_input_5000.txt sd_batch/data_fp32/embed_input.txt
    ./host_batch.exe

The point is the `launch/DMA overhead` line: ~620 us is paid once per graph.run(),
so it dominates a 50-track event (95%) and fades at 5000 tracks (~18%).
