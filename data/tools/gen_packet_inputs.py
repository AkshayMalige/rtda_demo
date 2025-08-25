#!/usr/bin/env python3
"""Generate packetized stream input files for AIE simulation.

Reads a JSON packet plan mapping destination leg IDs to a list of payload
arrays.  Each payload becomes a packet in the generated text stream.  Output
format per line is::

    <packet_id> <word> <tlast>

where ``tlast`` is ``1`` for the final word of each packet and ``0``
otherwise.

Example plan::

    {
      "0": [[1, 2, 3], [4, 5]],
      "1": [[6], [7, 8, 9]]
    }

Usage::

    ./gen_packet_inputs.py plan.json out.txt
"""
import argparse
import json
from pathlib import Path
from typing import List, Dict, Any


def generate_stream(plan: Dict[str, List[List[Any]]], out_path: Path) -> None:
    """Write a packetized text stream described by *plan* to *out_path*.

    Parameters
    ----------
    plan : dict
        Mapping of packet destination IDs (as strings or ints) to a list of
        payload lists.  Each payload list contains words to be streamed.
    out_path : Path
        Path of the file to write.
    """
    with out_path.open("w") as out_file:
        for leg, payloads in plan.items():
            pkt_id = int(leg)
            for payload in payloads:
                for idx, word in enumerate(payload):
                    tlast = 1 if idx == len(payload) - 1 else 0
                    out_file.write(f"{pkt_id} {word} {tlast}\n")


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate packetized AIE input streams")
    parser.add_argument("plan", type=Path, help="JSON packet plan {leg_id: [payloads...]}")
    parser.add_argument("out", type=Path, help="Output text file")
    args = parser.parse_args()

    with args.plan.open() as f:
        plan = json.load(f)

    generate_stream(plan, args.out)


if __name__ == "__main__":
    main()
