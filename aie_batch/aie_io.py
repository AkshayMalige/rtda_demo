#!/usr/bin/env python
"""PLIO marshalling for the vendored AIE graph — no aie4ml at runtime.

`app.cpp` is a self-contained ADF testbench: it creates input PLIOs reading
`data/ifm_c<port>.txt`, output PLIOs writing `data/y_p<port>.txt`, loads the
weights from `src/weights/*.h` via RTP, and runs N_ITER iterations. Simulation
therefore needs nothing from Python except writing the input files in the layout
the graph expects and reading the outputs back.

That layout is fully described by `aie_pipeline.json` -> `physical.plan.buffers`,
which is vendored alongside the sources. For each buffer:

  writers[] with source_type == 'plio' and source_endpoint.name == 'ifm'
      -> one graph input port, file data/ifm_c<port>.txt
  readers[] with target_type == 'plio' and target_endpoint.name == 'ofm'
      -> one graph output port, file <sim>simulator_output/data/y_p<port>.txt

Each port carries a `staging` record describing how its file relates to the
logical tensor:

  io_boundary_dimension   full padded tensor extent, innermost-first
  io_tiling_dimension     this port's slice of it
  offset                  where that slice starts

numpy shapes are these reversed (outermost-first), with a leading iteration axis.
A tensor wider than one port is split across several, each writing its own file;
reassembly is the same slicing in reverse.

Verified byte-for-byte against aie4ml's own writer before the dependency was cut
(see `make verify_io`).
"""
from __future__ import annotations

import json
import os
from pathlib import Path
from typing import Dict, List

import numpy as np

HERE = Path(__file__).resolve().parent
# Per-precision: src_<P>/ and aie_pipeline_<P>.json are generated together and
# describe the same graph, so they must never be mixed. The Makefile exports
# RTDA_PIPELINE; the default keeps a bare `python aie_io.py` working.
PLAN = HERE / os.environ.get('RTDA_PIPELINE', 'aie_pipeline_fp32.json')
# Ports wired in by hand after generation (see the file's own comment).
EXTRA = HERE / 'io_extra.json'
# app.cpp creates every PLIO as plio_128_bits.
PLIO_WIDTH_BITS = 128

# The plan records a dtype `format`, not a bit width. Mirrors aie4ml's
# aie_types._FORMAT_WIDTHS so the values-per-line arithmetic matches exactly.
_FORMAT_WIDTHS = {
    'int4': 4, 'uint4': 4, 'int8': 8, 'uint8': 8,
    'int16': 16, 'uint16': 16, 'int32': 32, 'uint32': 32,
    'int64': 64, 'uint64': 64,
    'bfloat16': 16, 'float32': 32, 'fp8_e4m3': 8, 'accfloat': 32,
}
_FLOAT_FORMATS = {'bfloat16', 'float32', 'float', 'fp8_e4m3', 'accfloat'}


class Port:
    """One PLIO port's view of a logical tensor."""

    __slots__ = ('direction', 'port', 'tensor', 'staging', 'width', 'is_float', 'frac')

    def __init__(self, direction, port, tensor, staging, dtype):
        self.direction = direction
        self.port = int(port)
        self.tensor = tensor
        self.staging = staging
        fmt = str(dtype.get('format', '')).lower()
        if fmt not in _FORMAT_WIDTHS:
            raise ValueError(f'{tensor}: unknown dtype format {fmt!r}')
        self.width = _FORMAT_WIDTHS[fmt]
        self.is_float = fmt in _FLOAT_FORMATS
        self.frac = int(dtype.get('frac', 0) or 0)

    @property
    def rank(self):
        return len(self.staging['io_boundary_dimension'])

    @property
    def boundary(self):
        return [int(x) for x in self.staging['io_boundary_dimension']]

    @property
    def tiling(self):
        return [int(x) for x in self.staging['io_tiling_dimension']]

    @property
    def offset(self):
        return [int(x) for x in self.staging['offset']]

    @property
    def np_boundary(self):
        return tuple(self.boundary[::-1])

    @property
    def np_tile(self):
        return tuple(self.tiling[::-1])

    @property
    def vals_per_line(self):
        return max(1, PLIO_WIDTH_BITS // self.width)

    def _slices(self):
        """(src_from_tensor, dst_into_tile) slice tuples, leading iteration axis kept whole."""
        rank = self.rank
        a = [slice(None)] * (rank + 1)
        b = [slice(None)] * (rank + 1)
        for d in range(rank):
            axis = rank - d
            start, size, bound = self.offset[d], self.tiling[d], self.boundary[d]
            take = min(size, max(0, bound - start))
            a[axis] = slice(start, start + take)
            b[axis] = slice(0, take)
        return tuple(a), tuple(b)


def load_ports(plan_path: Path = PLAN):
    """Parse aie_pipeline.json into {'inputs': {...}, 'outputs': {...}} of Port lists."""
    plan = json.loads(Path(plan_path).read_text())['physical']['plan']
    inputs: Dict[str, List[Port]] = {}
    outputs: Dict[str, List[Port]] = {}

    for buf in plan['buffers']:
        tensor = buf['tensor']
        for w in buf.get('writers', []):
            ep = w.get('source_endpoint') or {}
            if w.get('source_type') == 'plio' and ep.get('name') == 'ifm':
                inputs.setdefault(tensor, []).append(
                    Port('input', ep['port'], tensor, w['staging'], w['dtype']))
        for r in buf.get('readers', []):
            ep = r.get('target_endpoint') or {}
            if r.get('target_type') == 'plio' and ep.get('name') == 'ofm':
                outputs.setdefault(tensor, []).append(
                    Port('output', ep['port'], tensor, r['staging'], r['dtype']))

    # Merge any hand-added ports. aie_pipeline.json is generated and only
    # describes what aie4ml built; Phase 3 added kernels and ports by hand.
    if EXTRA.exists():
        extra = json.loads(EXTRA.read_text())
        for direction, bucket in (('inputs', inputs), ('outputs', outputs)):
            for e in extra.get(direction, []):
                bucket.setdefault(e['tensor'], []).append(
                    Port(direction[:-1], e['port'], e['tensor'], e['staging'], e['dtype']))

    for d in (inputs, outputs):
        for t in d:
            d[t].sort(key=lambda p: p.port)
    return {'inputs': inputs, 'outputs': outputs}


def _fmt(values, per_line, is_float):
    out, n = [], len(values)
    for i in range(0, n, per_line):
        chunk = values[i:i + per_line]
        out.append(' '.join(f'{float(v):e}' if is_float else str(int(v)) for v in chunk))
    return '\n'.join(out) + '\n'


def write_inputs(feed: Dict[str, np.ndarray], ports, out_dir: Path, iterations: int):
    """Write data/ifm_c<port>.txt for every graph input.

    feed values may be (batch, ...) -- broadcast to every iteration -- or
    (iterations, batch, ...) to drive each iteration separately.
    """
    data_dir = Path(out_dir) / 'data'
    data_dir.mkdir(parents=True, exist_ok=True)

    for tensor, plist in ports['inputs'].items():
        if tensor not in feed:
            raise KeyError(f'{tensor}: missing from feed (have {sorted(feed)})')
        expected = plist[0].np_boundary
        arr = np.asarray(feed[tensor])

        if arr.shape == expected:
            arr = np.repeat(arr[None, ...], iterations, axis=0)
        elif arr.ndim == len(expected) + 1 and arr.shape[1:] == expected:
            if arr.shape[0] == 1:
                arr = np.repeat(arr, iterations, axis=0)
            elif arr.shape[0] != iterations:
                raise ValueError(f'{tensor}: got {arr.shape[0]} iterations, expected {iterations}')
        else:
            raise ValueError(f'{tensor}: expected {expected} or ({iterations}, *{expected}), '
                             f'got {tuple(arr.shape)}')

        for p in plist:
            tile = np.zeros((arr.shape[0], *p.np_tile), dtype=np.float64)
            src, dst = p._slices()
            tile[dst] = arr[src]
            if not p.is_float and p.frac:
                tile = np.rint(tile * (1 << p.frac))
            (data_dir / f'ifm_c{p.port}.txt').write_text(
                _fmt(tile.flatten(order='C'), p.vals_per_line, p.is_float))


def read_outputs(ports, out_dir: Path, sim: str = 'aie') -> Dict[str, np.ndarray]:
    """Read <sim>simulator_output/data/y_p<port>.txt back into logical tensors."""
    data_dir = Path(out_dir) / f'{sim}simulator_output' / 'data'
    result: Dict[str, np.ndarray] = {}

    for tensor, plist in ports['outputs'].items():
        acc = None
        for p in plist:
            path = data_dir / f'y_p{p.port}.txt'
            if not path.exists():
                raise FileNotFoundError(f'Expected simulator output {path} not found. '
                                        f'Did the {sim} simulation run?')
            # Streams may carry TLAST / "T <a> <b>" markers; drop them.
            toks, clean, i = path.read_text().split(), [], 0
            while i < len(toks):
                t = toks[i]
                if t.upper() == 'TLAST':
                    i += 1; continue
                if t.upper() == 'T' and i + 2 < len(toks):
                    i += 3; continue
                clean.append(t); i += 1

            vals = np.array([float(x) for x in clean], dtype=np.float64)
            per_iter = int(np.prod(p.np_tile, dtype=np.int64))
            iters = vals.size // per_iter
            tile = vals[:iters * per_iter].reshape(iters, *p.np_tile)
            if not p.is_float and p.frac:
                tile = tile / float(1 << p.frac)

            if acc is None:
                acc = np.zeros((iters, *p.np_boundary), dtype=np.float64)
            src, dst = p._slices()
            acc[src] = tile[dst]
        result[tensor] = acc
    return result


if __name__ == '__main__':
    ports = load_ports()
    for d in ('inputs', 'outputs'):
        print(f'{d}:')
        for t, pl in ports[d].items():
            print(f'  {t:10s} boundary={pl[0].np_boundary} '
                  f'ports={[p.port for p in pl]} tile={pl[0].np_tile} '
                  f'{"float" if pl[0].is_float else "int"}{pl[0].width}')
