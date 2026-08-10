#include "parameters.h"
#include "top_graph.h"

// N_ITER is how many iterations one run of the graph executes. It is NOT
// structural -- nothing in graph_plan.h or top_graph.h depends on it -- but the
// simulation PLIO files must carry exactly this many iterations or the graph
// stalls waiting for data that never arrives, so it is fixed at compile time.
//
// One event is 7 iterations (7 x 8 = 56 slots >= 50 real tracks). Building with
// -DN_ITER_OVERRIDE=<7*N> gives an N-event simulation, which is the only way to
// exercise event-boundary behaviour (the roll carry crossing events, the
// accumulator resetting) without hardware. Driven by `make x86_events EVENTS=N`.
//
// The SYSTEM build does not need this: there the XRT host owns the iteration
// count via graph.run(n_iter) and picks it from the input file at run time.
#ifdef N_ITER_OVERRIDE
#undef N_ITER
#define N_ITER N_ITER_OVERRIDE
#endif

using namespace adf;

extern "C" {
  #include "weights/weights_emb_d0_aie.h"
  #include "weights/bias_emb_d0_aie.h"
  #include "weights/weights_emb_d1_aie.h"
  #include "weights/bias_emb_d1_aie.h"
  #include "weights/weights_s0_d0_aie.h"
  #include "weights/bias_s0_d0_aie.h"
  #include "weights/weights_s0_d1_aie.h"
  #include "weights/bias_s0_d1_aie.h"
  #include "weights/weights_s0_d2_aie.h"
  #include "weights/bias_s0_d2_aie.h"
  #include "weights/weights_s0_d3_aie.h"
  #include "weights/bias_s0_d3_aie.h"
  #include "weights/weights_s1_d0_aie.h"
  #include "weights/bias_s1_d0_aie.h"
  #include "weights/weights_s1_d1_aie.h"
  #include "weights/bias_s1_d1_aie.h"
  #include "weights/weights_s1_d2_aie.h"
  #include "weights/bias_s1_d2_aie.h"
  #include "weights/weights_s1_d3_aie.h"
  #include "weights/bias_s1_d3_aie.h"
  #include "weights/weights_s2_d0_aie.h"
  #include "weights/bias_s2_d0_aie.h"
  #include "weights/weights_s2_d1_aie.h"
  #include "weights/bias_s2_d1_aie.h"
  #include "weights/weights_s2_d2_aie.h"
  #include "weights/bias_s2_d2_aie.h"
  #include "weights/weights_s2_d3_aie.h"
  #include "weights/bias_s2_d3_aie.h"
}

template<typename... Ts> struct type_list {};

class dut_graph : public graph {
public:
  // Simulation drives the graph from PLIO text files (data/ifm_c*.txt, y_p*.txt).
  // The system build has no PL at all: the host DMAs straight into the array over
  // GMIO, which is why linker cfg for this design carries no stream_connect.
#ifdef SYSTEM_BUILD
  input_gmio  gmio_x;        // x       : BATCH x 16 floats per iteration
  output_gmio gmio_track;    // track_out: 128-wide event mean, valid on the last iteration
#else
  input_plio plio_data[1];   // x only -- solver inputs are produced inside the graph
#endif

  input_port wts1[L1Cfg::CAS_NUM * L1Cfg::CAS_LENGTH];
  input_port bias1[L1Cfg::CAS_NUM];
  input_port wts2[L2Cfg::CAS_NUM * L2Cfg::CAS_LENGTH];
  input_port bias2[L2Cfg::CAS_NUM];
  input_port wts3[L3Cfg::CAS_NUM * L3Cfg::CAS_LENGTH];
  input_port bias3[L3Cfg::CAS_NUM];
  input_port wts4[L4Cfg::CAS_NUM * L4Cfg::CAS_LENGTH];
  input_port bias4[L4Cfg::CAS_NUM];
  input_port wts5[L5Cfg::CAS_NUM * L5Cfg::CAS_LENGTH];
  input_port bias5[L5Cfg::CAS_NUM];
  input_port wts6[L6Cfg::CAS_NUM * L6Cfg::CAS_LENGTH];
  input_port bias6[L6Cfg::CAS_NUM];
  input_port wts7[L7Cfg::CAS_NUM * L7Cfg::CAS_LENGTH];
  input_port bias7[L7Cfg::CAS_NUM];
  input_port wts8[L8Cfg::CAS_NUM * L8Cfg::CAS_LENGTH];
  input_port bias8[L8Cfg::CAS_NUM];
  input_port wts9[L9Cfg::CAS_NUM * L9Cfg::CAS_LENGTH];
  input_port bias9[L9Cfg::CAS_NUM];
  input_port wts10[L10Cfg::CAS_NUM * L10Cfg::CAS_LENGTH];
  input_port bias10[L10Cfg::CAS_NUM];
  input_port wts11[L11Cfg::CAS_NUM * L11Cfg::CAS_LENGTH];
  input_port bias11[L11Cfg::CAS_NUM];
  input_port wts12[L12Cfg::CAS_NUM * L12Cfg::CAS_LENGTH];
  input_port bias12[L12Cfg::CAS_NUM];
  input_port wts13[L13Cfg::CAS_NUM * L13Cfg::CAS_LENGTH];
  input_port bias13[L13Cfg::CAS_NUM];
  input_port wts14[L14Cfg::CAS_NUM * L14Cfg::CAS_LENGTH];
  input_port bias14[L14Cfg::CAS_NUM];

#ifndef SYSTEM_BUILD
  output_plio plio_ofm[9];   // [8] = event tail (27 values + pad)
#endif

  top_graph<L1Cfg, L2Cfg, L3Cfg, L4Cfg, L5Cfg, L6Cfg, L7Cfg, L8Cfg, L9Cfg, L10Cfg, L11Cfg, L12Cfg, L13Cfg, L14Cfg> dut;

  dut_graph() {
#ifdef SYSTEM_BUILD
    // 64-byte bursts, 256 MB/s -- same figures aieml/graph.h uses for activations.
    gmio_x     = input_gmio::create("gmio_x", 64, 256);
    gmio_track = output_gmio::create("gmio_track", 64, 256);
    connect<>(gmio_x.out[0], dut.ifm[0]);
    connect<>(dut.ofm[0], gmio_track.in[0]);   // the only output in SYSTEM_BUILD
#else
    for (int col = 0; col < 1; ++col) {
      plio_data[col] = input_plio::create(
        "PLIO_ifm_" + std::to_string(col),
        plio_128_bits,
        "data/ifm_c" + std::to_string(col) + ".txt"
      );
      connect<>(plio_data[col].out[0], dut.ifm[col]);
    }
#endif

    for (int chain = 0; chain < L1Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L1Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L1Cfg::CAS_LENGTH + col;
        connect<>( wts1[idx], dut.wts1[idx]);
      }

      connect<>( bias1[chain], dut.bias1[chain]);
    }
    for (int chain = 0; chain < L2Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L2Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L2Cfg::CAS_LENGTH + col;
        connect<>( wts2[idx], dut.wts2[idx]);
      }

      connect<>( bias2[chain], dut.bias2[chain]);
    }
    for (int chain = 0; chain < L3Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L3Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L3Cfg::CAS_LENGTH + col;
        connect<>( wts3[idx], dut.wts3[idx]);
      }

      connect<>( bias3[chain], dut.bias3[chain]);
    }
    for (int chain = 0; chain < L4Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L4Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L4Cfg::CAS_LENGTH + col;
        connect<>( wts4[idx], dut.wts4[idx]);
      }

      connect<>( bias4[chain], dut.bias4[chain]);
    }
    for (int chain = 0; chain < L5Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L5Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L5Cfg::CAS_LENGTH + col;
        connect<>( wts5[idx], dut.wts5[idx]);
      }

      connect<>( bias5[chain], dut.bias5[chain]);
    }
    for (int chain = 0; chain < L6Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L6Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L6Cfg::CAS_LENGTH + col;
        connect<>( wts6[idx], dut.wts6[idx]);
      }

      connect<>( bias6[chain], dut.bias6[chain]);
    }
    for (int chain = 0; chain < L7Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L7Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L7Cfg::CAS_LENGTH + col;
        connect<>( wts7[idx], dut.wts7[idx]);
      }

      connect<>( bias7[chain], dut.bias7[chain]);
    }
    for (int chain = 0; chain < L8Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L8Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L8Cfg::CAS_LENGTH + col;
        connect<>( wts8[idx], dut.wts8[idx]);
      }

      connect<>( bias8[chain], dut.bias8[chain]);
    }
    for (int chain = 0; chain < L9Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L9Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L9Cfg::CAS_LENGTH + col;
        connect<>( wts9[idx], dut.wts9[idx]);
      }

      connect<>( bias9[chain], dut.bias9[chain]);
    }
    for (int chain = 0; chain < L10Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L10Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L10Cfg::CAS_LENGTH + col;
        connect<>( wts10[idx], dut.wts10[idx]);
      }

      connect<>( bias10[chain], dut.bias10[chain]);
    }
    for (int chain = 0; chain < L11Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L11Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L11Cfg::CAS_LENGTH + col;
        connect<>( wts11[idx], dut.wts11[idx]);
      }

      connect<>( bias11[chain], dut.bias11[chain]);
    }
    for (int chain = 0; chain < L12Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L12Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L12Cfg::CAS_LENGTH + col;
        connect<>( wts12[idx], dut.wts12[idx]);
      }

      connect<>( bias12[chain], dut.bias12[chain]);
    }
    for (int chain = 0; chain < L13Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L13Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L13Cfg::CAS_LENGTH + col;
        connect<>( wts13[idx], dut.wts13[idx]);
      }

      connect<>( bias13[chain], dut.bias13[chain]);
    }
    for (int chain = 0; chain < L14Cfg::CAS_NUM; ++chain) {
      for (int col = 0; col < L14Cfg::CAS_LENGTH; ++col) {
        int idx = chain * L14Cfg::CAS_LENGTH + col;
        connect<>( wts14[idx], dut.wts14[idx]);
      }

      connect<>( bias14[chain], dut.bias14[chain]);
    }

#ifndef SYSTEM_BUILD
    for (int ch = 0; ch < 9; ++ch) {
      plio_ofm[ch] = output_plio::create(
        "PLIO_ofm_" + std::to_string(ch),
        plio_128_bits,
        "data/y_p" + std::to_string(ch) + ".txt"
      );
      connect<>(dut.ofm[ch], plio_ofm[ch].in[0]);
    }
#endif
  }
};

dut_graph dut;

#if defined(__AIESIM__) || defined(__X86SIM__) || defined(SYSTEM_BUILD)
#ifdef SYSTEM_BUILD
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <vector>
// Event geometry. Must match the compiled graph: N_ITER * TA_TRACKS slots cover
// TA_EVENT real tracks, the rest are padding (see kernels/track_accum).
static constexpr int SYS_BATCH   = 8;
static constexpr int SYS_IN_DIM  = 16;   // padded embed input width
static constexpr int SYS_TRACKS  = 50;   // real tracks per event
static constexpr int SYS_OUT_W   = 128;  // graph emits the 128-wide event mean
#endif

// No argc/argv: the ADF frontend rejects them on main(). Paths come from the
// environment instead, with defaults that work from the project directory.
int main() {
  dut.init();


  for (int ch = 0; ch < L1Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L1Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L1Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts1[idx],
        weights_emb_d0_aie[ch][col],
        L1Cfg::IN_FEAT_SLICE * L1Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L1Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias1[ch],
      bias_emb_d0_aie[ch],
      128
    );
  }


  for (int ch = 0; ch < L2Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L2Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L2Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts2[idx],
        weights_emb_d1_aie[ch][col],
        L2Cfg::IN_FEAT_SLICE * L2Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L2Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias2[ch],
      bias_emb_d1_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L3Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L3Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L3Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts3[idx],
        weights_s0_d0_aie[ch][col],
        L3Cfg::IN_FEAT_SLICE * L3Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L3Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias3[ch],
      bias_s0_d0_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L4Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L4Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L4Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts4[idx],
        weights_s0_d1_aie[ch][col],
        L4Cfg::IN_FEAT_SLICE * L4Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L4Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias4[ch],
      bias_s0_d1_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L5Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L5Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L5Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts5[idx],
        weights_s0_d2_aie[ch][col],
        L5Cfg::IN_FEAT_SLICE * L5Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L5Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias5[ch],
      bias_s0_d2_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L6Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L6Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L6Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts6[idx],
        weights_s0_d3_aie[ch][col],
        L6Cfg::IN_FEAT_SLICE * L6Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L6Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias6[ch],
      bias_s0_d3_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L7Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L7Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L7Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts7[idx],
        weights_s1_d0_aie[ch][col],
        L7Cfg::IN_FEAT_SLICE * L7Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L7Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias7[ch],
      bias_s1_d0_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L8Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L8Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L8Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts8[idx],
        weights_s1_d1_aie[ch][col],
        L8Cfg::IN_FEAT_SLICE * L8Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L8Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias8[ch],
      bias_s1_d1_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L9Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L9Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L9Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts9[idx],
        weights_s1_d2_aie[ch][col],
        L9Cfg::IN_FEAT_SLICE * L9Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L9Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias9[ch],
      bias_s1_d2_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L10Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L10Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L10Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts10[idx],
        weights_s1_d3_aie[ch][col],
        L10Cfg::IN_FEAT_SLICE * L10Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L10Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias10[ch],
      bias_s1_d3_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L11Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L11Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L11Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts11[idx],
        weights_s2_d0_aie[ch][col],
        L11Cfg::IN_FEAT_SLICE * L11Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L11Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias11[ch],
      bias_s2_d0_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L12Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L12Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L12Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts12[idx],
        weights_s2_d1_aie[ch][col],
        L12Cfg::IN_FEAT_SLICE * L12Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L12Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias12[ch],
      bias_s2_d1_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L13Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L13Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L13Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts13[idx],
        weights_s2_d2_aie[ch][col],
        L13Cfg::IN_FEAT_SLICE * L13Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L13Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias13[ch],
      bias_s2_d2_aie[ch],
      64
    );
  }


  for (int ch = 0; ch < L14Cfg::CAS_NUM; ++ch) {
    for (int col = 0; col < L14Cfg::CAS_LENGTH; ++col) {
      int idx = ch * L14Cfg::CAS_LENGTH + col;
      dut.update(
        dut.wts14[idx],
        weights_s2_d3_aie[ch][col],
        L14Cfg::IN_FEAT_SLICE * L14Cfg::OUT_FEAT_SLICE
      );
    }
  }




  for (int ch = 0; ch < L14Cfg::CAS_NUM; ++ch) {
    dut.update(
      dut.bias14[ch],
      bias_s2_d3_aie[ch],
      64
    );
  }


#ifdef SYSTEM_BUILD
  // ---- inputs: 50 real tracks, zero-padded to N_ITER * SYS_BATCH slots ----
  const char* in_path  = std::getenv("RTDA_INPUT");
  const char* out_path = std::getenv("RTDA_OUTPUT");
  if (!in_path)  in_path  = "embed_input.txt";
  if (!out_path) out_path = "track_mean_aie.txt";

  const int slots = N_ITER * SYS_BATCH;
  std::vector<float> host_in(static_cast<size_t>(slots) * SYS_IN_DIM, 0.0f);
  if (FILE* f = std::fopen(in_path, "r")) {
    // embed_input.txt is 8 values per track; the graph takes SYS_IN_DIM wide
    // with the tail zero-filled (see gen_graph.py INPUT_DIM).
    for (int t = 0; t < SYS_TRACKS; ++t)
      for (int k = 0; k < 8; ++k)
        if (std::fscanf(f, "%f", &host_in[(size_t)t * SYS_IN_DIM + k]) != 1) { t = SYS_TRACKS; break; }
    std::fclose(f);
  } else {
    std::fprintf(stderr, "[aie] cannot open %s\n", in_path); dut.end(); return 1;
  }

  const size_t in_bytes  = host_in.size() * sizeof(float);
  const size_t out_bytes = (size_t)N_ITER * SYS_OUT_W * sizeof(float);
  float* gin  = static_cast<float*>(adf::GMIO::malloc(in_bytes));
  float* gout = static_cast<float*>(adf::GMIO::malloc(out_bytes));
  if (!gin || !gout) { std::fprintf(stderr, "[aie] GMIO::malloc failed\n"); dut.end(); return 1; }
  std::memcpy(gin, host_in.data(), in_bytes);

  dut.gmio_x.gm2aie_nb(gin, in_bytes);
  dut.gmio_track.aie2gm_nb(gout, out_bytes);
  dut.run(N_ITER);
  dut.gmio_x.wait();
  dut.gmio_track.wait();

  // The accumulator emits zeros until the event completes, so the last frame
  // carries the mean. Take the last non-zero frame rather than assuming index 6.
  int best = N_ITER - 1;
  for (int i = N_ITER - 1; i >= 0; --i) {
    float m = 0.0f;
    for (int j = 0; j < SYS_OUT_W; ++j) { float v = gout[(size_t)i*SYS_OUT_W+j]; m = v < 0 ? (-v > m ? -v : m) : (v > m ? v : m); }
    if (m > 0.0f) { best = i; break; }
  }
  if (FILE* f = std::fopen(out_path, "w")) {
    for (int j = 0; j < SYS_OUT_W; ++j) std::fprintf(f, "%.9e\n", gout[(size_t)best*SYS_OUT_W + j]);
    std::fclose(f);
    std::printf("[aie] event mean (frame %d of %d) -> %s\n", best, N_ITER, out_path);
  }
  adf::GMIO::free(gin);
  adf::GMIO::free(gout);
#else
  dut.run(N_ITER);
#endif
  dut.end();
  return 0;
}
#endif