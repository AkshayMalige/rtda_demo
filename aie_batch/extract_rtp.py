#!/usr/bin/env python
"""Extract the graph's RTP payloads to binaries the XRT host can load.

The weights are already packed into aie::mmul tile order inside src/weights/*.h,
which app.cpp pushes with dut.update(). An XRT host (host/host_batch.cpp) cannot
use those headers directly -- they are AIE-targeted -- so this dumps each RTP
port's payload to a little-endian float32 .bin plus a manifest.

The port names come from Work/ps/c_rts/aie_control_config.json, NOT from a rule.
The bias port index is not uniform: in[2] on single-kernel layers, in[3] on
cascaded ones, always on the last kernel of a chain. Deriving that by hand is
exactly the sort of thing that silently loads the wrong weights.

    ./extract_rtp.py [--work Work] [--out sysdata]

Writes sysdata/rtp/<sanitised-port>.bin and sysdata/rtp_manifest.txt with lines
    <port_name> <n_floats> <relative-path>
"""
from __future__ import annotations

import argparse
import collections
import json
import os
import re
import struct
from pathlib import Path

HERE = Path(__file__).resolve().parent

# L<N>Cfg order in parameters.h == graph order.
LAYERS = ['emb_d0', 'emb_d1'] + [f's{s}_d{d}' for s in range(3) for d in range(4)]

# float (fp32 build) or uint16_t (bf16 build -- raw bf16 bit patterns, since C++
# has no bfloat16 literal). Biases stay float in BOTH builds, so a bf16 tree has
# a mix and the element size must be decided per array, not per build.
_ARR = re.compile(r'AIE_BLOCK_QUAL\s+(float|uint16_t)\s+(\w+)\s*\[(\d+)\]\s*=\s*\{(.*?)\};', re.S)
_ESIZE = {'float': 4, 'uint16_t': 2}
_PORT = re.compile(r'dut\.dut\.(\w+?)_aie\.kk\[(\d+)\]\.in\[(\d+)\]')


def parse_arrays(path: Path):
    """name -> (ctype, [values]) for every AIE_BLOCK_QUAL array in a header."""
    out = {}
    for m in _ARR.finditer(path.read_text()):
        ctype, name, n, body = m.group(1), m.group(2), int(m.group(3)), m.group(4)
        raw = [v for v in body.replace('\n', ' ').split(',') if v.strip()]
        if ctype == 'float':
            vals = [float(v.replace('f', '')) for v in raw]
        else:
            vals = [int(v) for v in raw]          # bf16 bit patterns, keep exact
        if len(vals) != n:
            raise ValueError(f'{path.name}: {name} declared [{n}] but parsed {len(vals)}')
        out[name] = (ctype, vals)
    return out


def layer_cfg(params: Path):
    """L<N>Cfg -> (cas_length, cas_num), in declaration order."""
    txt = params.read_text()
    pairs = re.findall(r'CAS_LENGTH\s*=\s*(\d+);\s*static constexpr int CAS_NUM\s*=\s*(\d+)', txt)
    return [(int(a), int(b)) for a, b in pairs]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--work', default=os.environ.get('RTDA_WORK', 'Work_fp32'))
    ap.add_argument('--src',  default=os.environ.get('RTDA_SRC', 'src_fp32'))
    ap.add_argument('--out', default='sysdata')
    a = ap.parse_args()

    meta = json.loads((HERE / a.work / 'ps/c_rts/aie_control_config.json').read_text())
    rtps = meta['aie_metadata']['RTPs']
    rtps = list(rtps.values()) if isinstance(rtps, dict) else rtps

    # group ports by layer: in[1] = weights, anything else = bias
    wts_ports = collections.defaultdict(list)
    bias_ports = collections.defaultdict(list)
    for e in rtps:
        m = _PORT.match(e['port_name'])
        if not m:
            raise ValueError(f'unrecognised RTP port name: {e["port_name"]}')
        lay, kk, idx = m.group(1), int(m.group(2)), int(m.group(3))
        (wts_ports if idx == 1 else bias_ports)[lay].append((kk, e))
    for d in (wts_ports, bias_ports):
        for lay in d:
            d[lay].sort(key=lambda t: t[0])

    cfgs = layer_cfg(HERE / a.src / 'parameters.h')
    if len(cfgs) != len(LAYERS):
        raise ValueError(f'{len(cfgs)} layer configs but {len(LAYERS)} layer names')

    outdir = HERE / a.out
    (outdir / 'rtp').mkdir(parents=True, exist_ok=True)
    manifest, total = [], 0

    for lay, (cas_len, cas_num) in zip(LAYERS, cfgs):
        w = parse_arrays(HERE / a.src / 'weights' / f'weights_{lay}_aie.h')
        b = parse_arrays(HERE / a.src / 'weights' / f'bias_{lay}_aie.h')

        for kk, port in wts_ports[lay]:
            ch, col = divmod(kk, cas_len)
            key = f'weights_{lay}_aie_{ch}_{col}'
            ctype, vals = w[key]
            nbytes = len(vals) * _ESIZE[ctype]
            if nbytes != port['number_of_bytes']:
                raise ValueError(f'{port["port_name"]}: expects {port["number_of_bytes"]}B, '
                                 f'{key} is {len(vals)} x {ctype} = {nbytes}B')
            manifest.append(write_bin(outdir, port['port_name'], ctype, vals))
            total += nbytes

        for n, (kk, port) in enumerate(bias_ports[lay]):
            key = f'bias_{lay}_aie_{n}'
            ctype, vals = b[key]
            nbytes = len(vals) * _ESIZE[ctype]
            if nbytes != port['number_of_bytes']:
                raise ValueError(f'{port["port_name"]}: expects {port["number_of_bytes"]}B, '
                                 f'{key} is {len(vals)} x {ctype} = {nbytes}B')
            manifest.append(write_bin(outdir, port['port_name'], ctype, vals))
            total += nbytes

    if len(manifest) != len(rtps):
        raise ValueError(f'wrote {len(manifest)} payloads but the graph has {len(rtps)} RTP ports')

    # The dtype column is what lets ONE host binary serve both precisions: a bf16
    # tree has u16 weights and f32 biases side by side, so the type cannot be
    # inferred from the build, only from the entry.
    (outdir / 'rtp_manifest.txt').write_text(
        '# <port_name> <n_elems> <dtype> <path>   -- generated by extract_rtp.py\n'
        + ''.join(f'{p} {n} {d} {f}\n' for p, n, d, f in manifest))
    (outdir / 'config.txt').write_text(
        f'precision={os.environ.get("RTDA_PRECISION", "fp32")}\n'
        f'input_dtype={"bfloat16" if any(d == "u16" for _, _, d, _ in manifest) else "float32"}\n'
        f'output_dtype=float32\n'
        # Measured II per iteration for this precision (aiesimulator, `make report`).
        # The host uses it for its overhead line; wrong here only mis-labels a report,
        # it does not affect the run.
        f'ii_ns={ {"fp32": 4161.0, "bf16": 1033.0}.get(os.environ.get("RTDA_PRECISION", "fp32"), 4161.0) }\n')
    print(f'  {len(manifest)} RTP payloads, {total/1024:.0f} KB -> {outdir}/')
    print(f'  manifest: {outdir}/rtp_manifest.txt   config: {outdir}/config.txt')


def write_bin(outdir: Path, port: str, ctype: str, vals):
    safe = re.sub(r'[^A-Za-z0-9]+', '_', port).strip('_')
    rel = f'rtp/{safe}.bin'
    fmt, tag = ('<%dH' % len(vals), 'u16') if ctype == 'uint16_t' else ('<%df' % len(vals), 'f32')
    (outdir / rel).write_bytes(struct.pack(fmt, *vals))
    return port, len(vals), tag, rel


if __name__ == '__main__':
    main()
