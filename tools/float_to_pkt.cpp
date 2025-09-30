#include <cctype>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <iostream>
#include <limits>
#include <string>
#include <string_view>
#include <vector>

namespace {
std::string trim(std::string_view sv) {
  while (!sv.empty() && std::isspace(static_cast<unsigned char>(sv.front()))) {
    sv.remove_prefix(1);
  }
  while (!sv.empty() && std::isspace(static_cast<unsigned char>(sv.back()))) {
    sv.remove_suffix(1);
  }
  return std::string(sv);
}

bool parse_float(const std::string &token, float &value) {
  char *end = nullptr;
  value = std::strtof(token.c_str(), &end);
  if (end == token.c_str()) {
    return false;
  }
  // ensure only trailing whitespace remains
  while (*end) {
    if (!std::isspace(static_cast<unsigned char>(*end))) {
      return false;
    }
    ++end;
  }
  return true;
}

uint32_t float_to_bits(float value) {
  uint32_t bits = 0;
  std::memcpy(&bits, &value, sizeof(bits));
  return bits;
}

void print_usage(const char *prog) {
  std::cerr << "Usage: " << prog
            << " <floats.txt> <output_pkts.txt> <payloads_per_packet> [header0 [header1 ...]]\n"
            << "  - <floats.txt>: ASCII file with one float32 value per line.\n"
            << "  - <output_pkts.txt>: Destination file in input_pktstream text format.\n"
            << "  - <payloads_per_packet>: Number of float words to emit per packet.\n"
            << "  - header values (optional): 32-bit unsigned integers for each packet header.\n"
            << "    If a single header is provided it is reused for all packets; otherwise the\n"
            << "    number of headers must match the number of generated packets.\n";
}
} // namespace

int main(int argc, char **argv) {
  if (argc < 4) {
    print_usage(argv[0]);
    return 1;
  }

  const std::string input_path = argv[1];
  const std::string output_path = argv[2];

  char *end = nullptr;
  long payloads_per_packet = std::strtol(argv[3], &end, 10);
  if (end == argv[3] || payloads_per_packet <= 0 ||
      payloads_per_packet > std::numeric_limits<int>::max()) {
    std::cerr << "Error: invalid payload count '" << argv[3] << "'." << std::endl;
    return 1;
  }

  std::vector<uint32_t> headers;
  for (int i = 4; i < argc; ++i) {
    char *hend = nullptr;
    unsigned long value = std::strtoul(argv[i], &hend, 0);
    if (hend == argv[i] || value > std::numeric_limits<uint32_t>::max()) {
      std::cerr << "Error: invalid header value '" << argv[i] << "'." << std::endl;
      return 1;
    }
    headers.push_back(static_cast<uint32_t>(value));
  }

  std::ifstream fin(input_path);
  if (!fin) {
    std::cerr << "Error: failed to open input file '" << input_path << "'." << std::endl;
    return 1;
  }

  std::vector<float> payloads;
  std::string line;
  while (std::getline(fin, line)) {
    const auto trimmed = trim(line);
    if (trimmed.empty()) {
      continue;
    }
    if (trimmed.rfind("#", 0) == 0) {
      continue; // comment line
    }
    float value = 0.0f;
    if (!parse_float(trimmed, value)) {
      std::cerr << "Error: could not parse float from line: '" << line << "'." << std::endl;
      return 1;
    }
    payloads.push_back(value);
  }

  if (payloads.empty()) {
    std::cerr << "Error: input file did not contain any float values." << std::endl;
    return 1;
  }

  const std::size_t words_per_packet = static_cast<std::size_t>(payloads_per_packet);
  const std::size_t total_packets =
      (payloads.size() + words_per_packet - 1) / words_per_packet;

  if (!headers.empty() && headers.size() != 1 && headers.size() != total_packets) {
    std::cerr << "Error: provided " << headers.size()
              << " headers but need either 1 or " << total_packets << "." << std::endl;
    return 1;
  }

  std::ofstream fout(output_path);
  if (!fout) {
    std::cerr << "Error: failed to create output file '" << output_path << "'." << std::endl;
    return 1;
  }

  std::size_t payload_index = 0;
  for (std::size_t packet = 0; packet < total_packets; ++packet) {
    const uint32_t header_word = headers.empty()
                                     ? 0u
                                     : (headers.size() == 1 ? headers.front()
                                                            : headers[packet]);
    fout << header_word << " 0\n";

    for (std::size_t i = 0; i < words_per_packet && payload_index < payloads.size();
         ++i, ++payload_index) {
      const uint32_t bits = float_to_bits(payloads[payload_index]);
      const bool is_last_in_packet =
          (i == words_per_packet - 1) || (payload_index + 1 == payloads.size()) ||
          ((payload_index + 1) % words_per_packet == 0);
      fout << bits << ' ' << (is_last_in_packet ? 1 : 0) << '\n';
    }
  }

  if (!fout) {
    std::cerr << "Error: failed while writing output file." << std::endl;
    return 1;
  }

  return 0;
}
