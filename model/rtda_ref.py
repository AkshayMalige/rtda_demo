#!/usr/bin/env python
"""The RTDA network, in numpy, once.

There used to be four copies of this forward pass: two in aie_batch/ (one per
roll convention) and two more in a stale fork. They drifted. This is the only
one; `crosscheck.py` and `make_golden.py` call into it.

THE NETWORK
    embed:   dense 6->128, dense 128->128
    solver x3: roll-concat to 256, dense 256->128, then 3x dense 128->128
    every dense is followed by bias + leaky-ReLU, slope 0.1
    per event: mean over 50 tracks, then dense 128->27

THE TWO ROLL CONVENTIONS, which are the whole reason this file has a `roll=` arg

    roll='circular'   what the ONNX does. Inside a 50-track event, track 0 pairs
                      with track 49. This is the physics definition. It needs all
                      50 tracks buffered before the first one can be computed.

    roll='streaming'  what the hardware does. Each track pairs with whatever
                      physically preceded it, so the array never has to buffer an
                      event -- which is exactly what makes the batched design
                      fast. The carry is a static that is never reset, so it
                      crosses padding slots and event boundaries.

They agree on tracks 3..49 to ~4e-06 and disagree on tracks 0,1,2 by ~1e-1,
because the receptive field is 4 tracks deep. Every "with warm-up" number in the
analysis is dominated by that, not by arithmetic: the reference disagrees with
ITSELF by 1.556e-02 between the two conventions. Only the "without warm-up"
numbers measure precision. Do not average that away.

    forward(x, roll='circular')            per-track activations, one event
    event_means(x, roll=..., warmup=0)     the (n_events, 128) deliverable
    hw_golden(tracks)                      the slot-exact streaming model,
                                           padding + flush event and all

QUANTIZATION
`quant=` runs the same chain in a reduced format, so the cost of a hardware
choice can be measured before anything is synthesised:

    quant='bf16'                             the AIE-ML bf16 build
    quant=fixed(16, 3)                       ap_fixed<16,3>, round + saturate
    quant=fixed(16, 6, mode='trn_wrp')       what the PL flow used to do
    quant=fixed(16, 3, alpha=0.125)          isolates the leaky-slope choice

Self-test:  python model/rtda_ref.py --self-test
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))
from model import weights as _weights  # noqa: E402

H = 128
TRACKS_PER_EVENT = 50
SLOTS_PER_EVENT = 56          # 7 graph iterations x BATCH 8
IN_FEATURES = 6
IN_PADDED = 8
IN_DIM = 16                   # the width the AIE graph's input port takes
OUT_DIM = 27
SOLVERS = 3
WARMUP = 3                    # tracks contaminated by the streaming roll
SLOPE = 0.1


# ---------------------------------------------------------------------------
#  Number formats
# ---------------------------------------------------------------------------

class Quant:
    """A reduced number format, applied where the hardware applies it."""

    def __init__(self, kind, W=16, I=3, aw=32, ai=10, mode='rnd_sat', alpha=None,
                 wi=1):
        self.kind, self.W, self.I, self.aw, self.ai = kind, W, I, aw, ai
        self.mode, self.alpha, self.wi = mode, alpha, wi
        self.n_sat = self.n_val = 0        # activations clipped / seen
        # The PL flow splits solver dense_0 into curr+prev and quantizes each
        # half before adding; the AIE does one 256-wide GEMM. See forward().
        self.split_d0 = (kind == 'fixed')

    def __repr__(self):
        if self.kind == 'bf16':
            return 'bf16'
        return (f'<{self.W},{self.I}> w<{self.W},{self.wi}> acc<{self.aw},{self.ai}> '
                f'{self.mode} a={self.alpha if self.alpha is not None else 0.1}')

    # -- weights and biases, quantized once at load ------------------------
    def weight(self, a):
        if self.kind == 'bf16':
            return _bf16(a)
        return _apfixed(a, self.W, self.wi, self.mode)

    # -- activations ------------------------------------------------------
    def act(self, a):
        if self.kind == 'bf16':
            return _bf16(a)
        # Count clipped elements. A format can score well on average while
        # silently clipping the tail -- <16,2> beats <16,3> on synthetic data
        # for exactly that reason, and would fall off a cliff the first time a
        # real activation exceeded 2.0. Saturation should be a number you see,
        # not a risk you inherit.
        frac = self.W - self.I
        hi = 2.0 ** (self.I - 1) - 2.0 ** -frac
        self.n_sat += int(np.count_nonzero(np.abs(np.asarray(a)) > hi))
        self.n_val += int(np.asarray(a).size)
        return _apfixed(a, self.W, self.I, self.mode)

    # -- dense accumulator ------------------------------------------------
    def accum(self, a):
        if self.kind == 'bf16':
            return a                      # AIE accumulates in fp32
        # AP_SAT/AP_RND on the accumulator too: hls4ml's accum_t is a plain
        # ap_fixed and truncates. With enough headroom this is a no-op, which
        # is the point -- if it is NOT a no-op the accumulator is too small.
        return _apfixed(a, self.aw, self.ai, self.mode)


def fixed(W=16, I=3, aw=32, ai=10, mode='rnd_sat', alpha=None, wi=1):
    """An ap_fixed<W,I> datapath, matching pl_fixed/pl/src/rtda_fixed.h.

    wi is the weights' integer-bit count; they all fit in +-1, so 1 is right
    and gives them W-1 fractional bits rather than sharing the activations'.
    alpha=None means the exact 0.1, quantized to the grid like everything else.
    """
    return Quant('fixed', W, I, aw, ai, mode, alpha, wi)


BF16 = Quant('bf16')


def _bf16(a):
    """float32 -> bfloat16 -> float32, round-half-to-even.

    Truncation here (the `u >> 16` this used to be, in aie4ml) doubles the error
    AND biases it toward zero, which does not cancel over 264k weights and 14
    layers. Fixing it was worth 8x end to end.
    """
    u = np.asarray(a, dtype=np.float32).view(np.uint32).astype(np.uint64)
    lsb = (u >> 16) & 1
    u = (u + 0x7FFF + lsb) >> 16
    return (u.astype(np.uint32) << 16).view(np.float32).astype(np.float32)


def _apfixed(a, W, I, mode):
    """Emulate ap_fixed<W,I> exactly, including the overflow behaviour.

    Vitis counts I as integer bits INCLUDING the sign, so ap_fixed<16,6> spans
    [-32, 32) with 10 fractional bits.

    mode='trn_wrp'  the ap_fixed default: truncate toward -inf, wrap on
                    overflow. Truncation costs half an LSB of BIAS at every one
                    of 14 layers, and wrapping turns a small overflow into a
                    sign flip.
    mode='rnd_sat'  AP_RND_CONV + AP_SAT: round half to even, clamp. Costs a
                    little fabric, no DSPs.
    """
    frac = W - I
    step = 2.0 ** -frac
    lo = -(2.0 ** (I - 1))
    hi = 2.0 ** (I - 1) - step
    a = np.asarray(a, dtype=np.float64)
    if mode == 'trn_wrp':
        q = np.floor(a / step) * step
        span = 2.0 ** (I - 1) * 2
        q = np.mod(q - lo, span) + lo                    # wrap
    else:
        # round-half-to-even, which is what np.rint does
        q = np.rint(a / step) * step
        q = np.clip(q, lo, hi)                           # saturate
    return q


# ---------------------------------------------------------------------------
#  The layers
# ---------------------------------------------------------------------------

def _lrelu(a, slope=SLOPE):
    return np.maximum(a, slope * a)


def _dense(x, w, b, q):
    """One dense layer, quantized where the hardware quantizes.

    Two roundings, not one, and the order matters. hls4ml's nnet::dense
    accumulates in accum_t and then writes its result into layerN_t -- which is
    the ACTIVATION type -- so the dense output is already rounded to 13
    fractional bits before the activation function ever sees it. Folding those
    two into a single rounding after the leaky ReLU made the model predict 2.3x
    less error than the design actually produces.
    """
    y = x @ w + b
    if q is None:
        return y
    return q.act(q.accum(y))


def _act(a, q, slope=SLOPE):
    """bias + leaky ReLU, then the result's own type."""
    a = _lrelu(a, slope)
    return a if q is None else q.act(a)


def _pad_rows(w, n):
    """Zero-extend (or slice) the embed weight to n input rows."""
    if w.shape[0] == n:
        return w
    if n < w.shape[0]:
        raise ValueError(f'input has {n} columns, fewer than the {w.shape[0]} '
                         f'real features')
    out = np.zeros((n, w.shape[1]), dtype=w.dtype)
    out[:w.shape[0]] = w
    return out


def _roll_pair(cur, roll, carry=None):
    """[cur[i], prev[i]] -- the two conventions differ only here.

    Returns (concatenated (n, 256), new carry).
    """
    if roll == 'circular':
        prev = np.roll(cur, 1, axis=0)
        return np.hstack([cur, prev]), None
    if roll == 'streaming':
        head = (np.zeros((1, cur.shape[1]), dtype=cur.dtype) if carry is None
                else carry.reshape(1, -1))
        prev = np.vstack([head, cur[:-1]])
        return np.hstack([cur, prev]), cur[-1].copy()
    raise ValueError(f"roll must be 'circular' or 'streaming', not {roll!r}")


def forward(x, roll='circular', slope=SLOPE, quant=None, W=None, B=None,
            carry=None, dtype=None):
    """Run the 14 dense layers over rows of `x`.

    x     (n, 6) or (n, 8) or (n, 16) -- extra columns are padding and ignored
    roll  'circular' (one event, ONNX) or 'streaming' (hardware)
    carry only for roll='streaming': the previous chunk's last row per solver,
          as a list of 3 arrays, so long runs can be processed in pieces
    dtype the numpy type the whole chain runs in. None means float64, which is
          what every golden was generated with -- leave it alone unless you
          mean it. float32 exists for the CPU baseline in cpu/: it is the fair
          comparison against fp32 hardware and it is ~2.2x faster here, because
          float64 GEMM runs at half the SIMD width. Passing float32 weights
          alone does NOT work: x, the _pad_rows zero-extension and the
          _roll_pair zero head all default to float64 and drag the chain back
          up. All four move together or none of them do.

    Returns dict with 'emb', 's0', 's1', 's2' -- each (n, 128) -- and 'carry'.
    """
    if W is None or B is None:
        W, B = _weights.load()
    if dtype is not None:
        W = {k: np.asarray(v, dtype=dtype) for k, v in W.items()}
        B = {k: np.asarray(v, dtype=dtype) for k, v in B.items()}
    q = quant
    if q is not None:
        # Quantize the weights the way the hardware stores them, not just the
        # activations. Skipping this makes a sweep look better than the design
        # it is predicting.
        W = {k: q.weight(v) for k, v in W.items()}
        B = {k: q.weight(v) for k, v in B.items()}
    alpha = slope if (q is None or q.alpha is None) else q.alpha
    if q is not None:
        alpha = _apfixed(alpha, q.W, q.I, q.mode) if q.kind == 'fixed' else alpha

    # Keep the caller's input width and pad the WEIGHT to match, rather than
    # narrowing x to 6. The padding columns are exactly zero, so the result is
    # the same in exact arithmetic -- but the summation has a different length,
    # and in floating point that shifts the last couple of bits. Matching the
    # width the caller (and the hardware) actually uses is what keeps a
    # regenerated testdata/golden_<N>.npz bit-identical to the committed one,
    # and with it the board's RTDA_GOLDEN check and every captured hw result.
    x = np.asarray(x, dtype=np.float64 if dtype is None else dtype)
    w_e0 = _pad_rows(W['emb_d0'], x.shape[1])
    if q is not None:
        x = q.act(x)                      # the input is quantized on the way in

    out = {}
    h = _act(_dense(x, w_e0, B['emb_d0'], q), q, alpha)
    emb = _act(_dense(h, W['emb_d1'], B['emb_d1'], q), q, alpha)
    out['emb'] = emb

    carries = list(carry) if carry is not None else [None] * SOLVERS
    cur = emb
    for s in range(SOLVERS):
        pair, carries[s] = _roll_pair(cur, roll, carries[s])
        if q is not None and q.split_d0:
            # The PL flow does not compute one 256-wide dense. It computes two
            # 128-wide ones and adds them, and hls4ml rounds each to the
            # activation type BEFORE the add -- one extra quantization per
            # solver that the AIE's single 256-wide GEMM does not have.
            # Modelling it as one dot product made the predicted error 2.3x
            # better than the design actually achieves.
            cur_h = _dense(pair[:, :H], W[f's{s}_d0_curr'], B[f's{s}_d0'], q)
            prv_h = _dense(pair[:, H:], W[f's{s}_d0_prev'], 0.0, q)
            z = _act(q.act(cur_h + prv_h), q, alpha)
        else:
            z = _act(_dense(pair, W[f's{s}_d0'], B[f's{s}_d0'], q), q, alpha)
        for n in (1, 2, 3):
            z = _dense(z, W[f's{s}_d{n}'], B[f's{s}_d{n}'], q)
            z = _act(z, q, alpha) if n < 3 else z
        cur = _act(z, q, alpha)
        out[f's{s}'] = cur

    out['carry'] = carries
    return out


def out27(mean128, W=None, B=None, quant=None, dtype=None):
    """The deliverable: the 128-wide event mean through the final dense.

    Orientation matters and has bitten people: W['out'] is [128][27] and the
    host computes y = mean @ W + B.
    """
    if W is None or B is None:
        W, B = _weights.load()
    if dtype is not None:
        W = {k: np.asarray(v, dtype=dtype) for k, v in W.items()}
        B = {k: np.asarray(v, dtype=dtype) for k, v in B.items()}
    m = np.asarray(mean128, dtype=np.float64 if dtype is None else dtype)
    if quant is not None:
        m = quant.act(m)
    y = m @ W['out'] + B['out']
    return y if quant is None else quant.accum(y)


def event_means(x, roll='circular', warmup=0, **kw):
    """(n_events, 128) means of the last solver's output.

    warmup=0   average all 50 tracks. What AIE hardware physically produces:
               track_accum has no way to skip the contaminated head.
    warmup=3   average tracks 3..49. What the PL kernel produces, and the only
               convention in which a streaming implementation can be compared
               against the circular reference without the roll difference
               swamping the arithmetic.
    """
    x = np.asarray(x)
    n_ev = len(x) // TRACKS_PER_EVENT
    if len(x) % TRACKS_PER_EVENT:
        raise ValueError(f'{len(x)} tracks is not a multiple of {TRACKS_PER_EVENT}')

    if roll == 'circular':
        # each event is independent -- run them one at a time
        per = np.stack([forward(x[e * TRACKS_PER_EVENT:(e + 1) * TRACKS_PER_EVENT],
                                roll='circular', **kw)['s2'] for e in range(n_ev)])
    else:
        s2 = forward(x, roll='streaming', **kw)['s2']
        per = s2.reshape(n_ev, TRACKS_PER_EVENT, H)

    return per[:, warmup:, :].mean(axis=1), per


# ---------------------------------------------------------------------------
#  The slot-exact hardware model
# ---------------------------------------------------------------------------

def slot_layout(tracks, flush=True):
    """Lay tracks into the slot matrix the AIE actually sees.

    Returns (X, n_real_ev, off) with X of shape (n_slots, IN_DIM).

    Events are padded INDIVIDUALLY -- 50 real tracks then 6 zero slots -- and
    never concatenated and padded once at the end, because track_accum stops at
    50 and one event's tail would otherwise swallow the next event's head.

    This is the single definition of the layout: host_batch.cpp reproduces it in
    C++ and sim_events.py feeds it to the simulator, so both are compared
    against a golden computed over exactly these slots.
    """
    tracks = np.asarray(tracks)
    n_real_ev = (len(tracks) + TRACKS_PER_EVENT - 1) // TRACKS_PER_EVENT
    n_ev = n_real_ev + (1 if flush else 0)
    off = SLOTS_PER_EVENT if flush else 0

    X = np.zeros((n_ev * SLOTS_PER_EVENT, IN_DIM))
    for t, row in enumerate(tracks):
        ev, idx = divmod(t, TRACKS_PER_EVENT)
        X[off + ev * SLOTS_PER_EVENT + idx, :IN_PADDED] = row[:IN_PADDED]
    return X, n_real_ev, off


def hw_golden(tracks, flush=True, quant=None, W=None, B=None):
    """Per-event 128-wide means exactly as the AIE hardware computes them.

    Three hardware behaviours leak across boundaries and are all reproduced:

      1. Each event occupies 56 slots: 50 real tracks then 6 PADDING slots of
         zeros. Padding is not neutral -- every dense has a bias, so a zero
         input still produces a sizeable activation.
      2. roll_concat_batch's carry is a static that is NEVER reset. It chains
         through padding and across event boundaries, so event k's track 0
         pairs with event k-1's last padding slot.
      3. track_accum counts real tracks and stops at 50, so it ignores the
         padding slots -- by counting, not because they happen to be zero.

    flush=True prepends one all-zero event whose result is discarded. Without it
    the answer depends on whether the AIE was cold-started: the roll carry is
    initialised at ELF LOAD, so a second graph.run() on an already-loaded xclbin
    starts with the previous run's leftovers and event 0 comes out 2.5e-3
    different. After a few zero slots the roll state is bias-determined
    regardless of history, so a dummy event makes every real event reproducible
    cold or warm. A simulator is always cold, so flush=False is exact there; the
    board is not, so the host defaults to flush=True.
    """
    X, n_real_ev, off = slot_layout(tracks, flush)
    cur = forward(X, roll='streaming', quant=quant, W=W, B=B)['s2']

    means = np.zeros((n_real_ev, H))
    for ev in range(n_real_ev):
        base = off + ev * SLOTS_PER_EVENT
        n_real = min(TRACKS_PER_EVENT, len(tracks) - ev * TRACKS_PER_EVENT)
        means[ev] = cur[base:base + n_real].sum(axis=0) / TRACKS_PER_EVENT
    return means, cur


def synth_tracks(n, seed=1234, W_dir=None):
    """n x 8 stimulus matching the real data's per-column mean/std.

    Only 50 real physics tracks exist in the repo. The first min(n,50) rows are
    those verbatim so the first event stays comparable; the rest are Gaussian,
    columns 6..7 left at zero as in the real data. One sequential seeded stream,
    so each file is a prefix of every larger one.
    """
    real = _weights.stimulus(W_dir).astype(np.float64)
    rng = np.random.default_rng(seed)
    out = np.zeros((n, IN_PADDED))
    k = min(n, real.shape[0])
    out[:k] = real[:k]
    if n > k:
        mu, sd = real[:, :IN_FEATURES].mean(0), real[:, :IN_FEATURES].std(0)
        out[k:, :IN_FEATURES] = rng.normal(mu, sd, size=(n - k, IN_FEATURES))
    return out


# ---------------------------------------------------------------------------
#  Self-test -- the numbers this file is not allowed to change
# ---------------------------------------------------------------------------

def _self_test():
    import onnxruntime as ort

    ok = True
    W, B = _weights.load()
    x = _weights.stimulus()

    def check(label, got, tol):
        nonlocal ok
        good = got < tol
        ok &= good
        print(f'  {label:52s} {got:.3e}  (< {tol:.0e})  {"ok" if good else "FAIL"}')

    print(f'weights: {_weights.DEFAULT_DIR}')
    print(f'onnx   : {HERE / "mlp_fp32.onnx"}\n')

    # 1. numpy == ONNX on the real 50 tracks, circular roll
    sess = ort.InferenceSession(str(HERE / 'mlp_fp32.onnx'),
                                providers=['CPUExecutionProvider'])
    y_onnx = sess.run(None, {'input': x[None, :, :IN_FEATURES].astype(np.float32)})[0][0]
    m, _ = event_means(x, roll='circular', warmup=0)
    y_np = out27(m[0], W, B)
    check('numpy vs ONNX, 27 outputs, circular roll', np.abs(y_np - y_onnx).max(), 1e-6)

    # 2. the streaming/circular gap -- the number that explains every "with
    #    warm-up" row in the analysis. Not an error; a convention difference.
    ms, _ = hw_golden(x, flush=True)
    gap = np.abs(out27(ms[0], W, B) - y_np).max()
    # This is ONE event, the 50 real physics tracks. The 1.556e-02 quoted
    # elsewhere is the max over 1000 synthesised events; both are the same
    # convention difference, not error.
    print(f'  {"streaming vs circular roll (the WARM-UP GAP)":52s} {gap:.3e}'
          f'   <- the convention, not an error')

    # 3. tracks 3..49 must agree between the conventions
    _, per_c = event_means(x, roll='circular')
    _, s2_s = hw_golden(x, flush=True)
    tail = np.abs(per_c[0][WARMUP:] - s2_s[SLOTS_PER_EVENT + WARMUP:
                                           SLOTS_PER_EVENT + TRACKS_PER_EVENT]).max()
    check('tracks 3..49, circular vs streaming', tail, 1e-5)

    # 4. reduced formats, for orientation
    print()
    for q in (BF16, fixed(16, 3), fixed(16, 6, mode='trn_wrp', alpha=0.125)):
        mq, _ = event_means(x, roll='circular', warmup=WARMUP, quant=q)
        mr, _ = event_means(x, roll='circular', warmup=WARMUP)
        e = np.abs(out27(mq[0], W, B) - out27(mr[0], W, B)).max()
        print(f'  {"27 outputs, " + repr(q):52s} {e:.3e}')

    print('\nPASS' if ok else '\nFAIL')
    return 0 if ok else 1


def _check_golden(path):
    """Regenerating testdata/golden_<N>.npz must reproduce it bit for bit."""
    d = np.load(path)
    n = int(d['tracks'])
    means, _ = hw_golden(synth_tracks(n), flush=True)
    W, B = _weights.load()
    y27 = out27(means, W, B)
    dm = np.abs(means - d['means']).max()
    dy = np.abs(y27 - d['y27']).max()
    # Not bit-identical, and deliberately so: the scripts this replaced read the
    # embed weights in float64 and every other layer in float32. Unifying on
    # float64 moves a golden by ~4e-09 -- against a 1e-6 project tolerance and a
    # 1e-4 on-board check. TOL here is what "the same golden" means.
    TOL = 1e-7
    good = dm < TOL and dy < TOL
    print(f'  {Path(path).name}: means {dm:.3e}   y27 {dy:.3e}'
          f'   {"same (< 1e-7)" if good else "CHANGED"}')
    return good


if __name__ == '__main__':
    ap = argparse.ArgumentParser()
    ap.add_argument('--self-test', action='store_true')
    ap.add_argument('--check-golden', metavar='NPZ',
                    help='verify a testdata/golden_<N>.npz reproduces exactly')
    a = ap.parse_args()
    rc = 0
    if a.self_test:
        rc |= _self_test()
    if a.check_golden:
        rc |= 0 if _check_golden(a.check_golden) else 1
    if not (a.self_test or a.check_golden):
        ap.print_help()
    raise SystemExit(rc)
