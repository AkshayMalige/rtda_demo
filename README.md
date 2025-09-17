# Packet Stream AIE Reference Design

This repository demonstrates how to connect multiple AI Engine graphs using packet stream send and receive interfaces. The goal is to provide a reference for integrating three graphs, **aieml**, **aieml2**, and **aieml3**, in the main branch of the project.

The example graph in [aie/graph.h](aie/graph.h) instantiates four processing kernels. A `pktsplit` block acts as a packet receiver that routes an incoming stream to each kernel, and a `pktmerge` block collects their packetized outputs before forwarding them.

## Build and simulate

A `Makefile` is provided with targets for building and running the AI Engine design. Common commands include:

- `make aie` – compile the AI Engine graph.
- `make aiesim` – run an AI Engine simulation.
- `make` – build the full hardware emulation package.

Tool paths at the top of the `Makefile` may need adjustment for a local Vitis installation.

## Extending to multiple graphs

Using the packet receiver (`pktsplit`) and packet sender (`pktmerge`) pattern shown here, the graphs **aieml**, **aieml2**, and **aieml3** can be stitched together through packet streams. Each graph sends packetized data, which is split, processed, and merged, enabling scalable graph compositions in the main branch.

### Packet sender connections

The `packet_sender` in this reference design fans out its output to two destinations. One path connects to a PLIO inside an AI Engine tile, supplying weights and runtime data directly to the kernels. The second path exits the AI Engine to the programmable logic, where external logic such as a `leaky_relu` bias stream in the main branch can consume the same packets. This dual-output arrangement forms the border between the AI Engine graph and the surrounding PL system, allowing shared data distribution to both internal tiles and PL-side modules.

## Host execution

The provided host application streams floating-point payloads into six PLIO channels (four AI Engine interfaces plus two PL paths) and verifies that the returned data matches bit-for-bit. Each channel expects `packet_num * PACKET_LEN` floats; by default the design sets `packet_num = 2` and `PACKET_LEN = 8`, so 16 values per channel and 96 values total. The file `data/embed_input.txt` supplies sample stimulus data and may contain one value per line or any whitespace-separated list of numbers. When exactly `packet_num * PACKET_LEN` values are provided, the host duplicates the payload across all six channels before checking the responses. Supplying `channel_count * packet_num * PACKET_LEN` values (96 by default) allows distinct data to be exercised on each interface if desired.

