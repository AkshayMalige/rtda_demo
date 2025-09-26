#include <iostream>
#include <fstream>
#include <vector>
#include <random>
#include <cstdint>
#include <cstring>
#include <string>

enum PacketType : uint32_t {
    PKT_TYPE_HEADER = 0, // header/meta word
    PKT_TYPE_DATA   = 1, // (not used; payload are raw float words)
    PKT_TYPE_TLAST  = 2  // TLAST marker
};

// Odd parity bit for bits[30:0]; returns 1 if we must set bit31 to make total odd
static inline uint32_t odd_parity31(uint32_t x) {
    x &= 0x7FFFFFFFu;          // keep bits 0..30
    // XOR-fold to 4 bits
    x ^= x >> 16;
    x ^= x >> 8;
    x ^= x >> 4;
    x &= 0xFu;
    // parity table for 4 bits (0 → even, 1 → odd)
    static const int parity4[16] = {0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0};
    int even_par = (parity4[x] == 0);
    return even_par ? 1u : 0u; // we need bit31 = 1 if lower bits are even
}

// Build a 32-bit “header-style” word with fields per your contract:
// [7:0]  = packet_id
// [11:8] = 0
// [14:12]= pkt_type
// [27:16]= payload_len (words) — optional; we populate for HEADER, 0 for TLAST
// [31]   = odd parity of bits[30:0]
static inline uint32_t make_pkt_word(uint32_t packet_id,
                                     PacketType pkt_type,
                                     uint32_t payload_len_words) {
    uint32_t w = 0;
    w |= (packet_id & 0xFFu) << 0;            // [7:0]
    // [11:8] = 0
    w |= (static_cast<uint32_t>(pkt_type) & 0x7u) << 12;  // [14:12]
    w |= (payload_len_words & 0x0FFFu) << 16; // [27:16] (up to 4095 words)
    // compute & set parity in bit 31
    w |= (odd_parity31(w) & 0x1u) << 31;
    return w;
}

// reinterpret float32 bits as uint32_t
static inline uint32_t f32_as_u32(float f) {
    static_assert(sizeof(float) == 4, "float must be 32-bit");
    uint32_t u;
    std::memcpy(&u, &f, 4);
    return u;
}

int main(int argc, char** argv) {
    // -----------------------------
    // CLI: only optional <output_file>; default: "test.txt"
    // -----------------------------
    std::string out_path = "test.txt";
    if (argc >= 2) out_path = argv[1];

    // -----------------------------
    // Hard-coded payload sizes per Packet ID (0..5).
    // Set any entry to <=0 to skip emitting that packet ID.
    // Example: PID 1 -> 10 words; PID 2 -> 100 words; others -> 25 words.
    // -----------------------------
    const int DEFAULT_WORDS = 25;
    int payload_per_pid[6] = {
        1024,  // PID 0
        8912,             // PID 1
        8912,            // PID 2
        8,  // PID 3
        64,  // PID 4
        64   // PID 5
    };

    // RNG for random float payloads (-1.0 .. +1.0)
    std::random_device rd;
    std::mt19937 rng(rd());
    std::uniform_real_distribution<float> dist(-1.0f, 1.0f);

    std::ofstream ofs(out_path);
    if (!ofs) {
        std::cerr << "ERROR: cannot open output file: " << out_path << "\n";
        return 1;
    }

    // For each Packet ID, emit: HEADER → payload[0..N-2] → TLAST → payload[N-1]
    for (uint32_t pid = 0; pid <= 5; ++pid) {
        int N = payload_per_pid[pid];
        if (N <= 0) continue;

        // Header word: set payload length to N (words)
        uint32_t header = make_pkt_word(pid, PKT_TYPE_HEADER, static_cast<uint32_t>(N));
        ofs << header << "\n";

        // Generate payload words (random float32 bit patterns), printed as decimal uint32_t
        std::vector<uint32_t> payload;
        payload.reserve(N);
        for (int i = 0; i < N; ++i) {
            float f = dist(rng);
            payload.push_back(f32_as_u32(f));
        }

        if (N >= 2) {
            for (int i = 0; i < N - 1; ++i) ofs << payload[i] << "\n";
            // TLAST marker: PacketType=TLAST, payload_len field = 0
            uint32_t tlast = make_pkt_word(pid, PKT_TYPE_TLAST, 0);
            ofs << tlast << "\n";
            ofs << payload[N - 1] << "\n";
        } else {
            // N == 1: TLAST then the only payload word
            uint32_t tlast = make_pkt_word(pid, PKT_TYPE_TLAST, 0);
            ofs << tlast << "\n";
            ofs << payload[0] << "\n";
        }
    }

    ofs.close();
    std::cerr << "Wrote file: " << out_path << "\n";
    return 0;
}
