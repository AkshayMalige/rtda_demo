#pragma once

#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <utility>
#include <vector>

namespace adf {

struct input_pktstream {
    std::vector<std::uint32_t> words;
    std::size_t                index = 0;

    input_pktstream() = default;
    explicit input_pktstream(std::vector<std::uint32_t> w) : words(std::move(w)) {}
};

struct output_pktstream {
    std::vector<std::uint32_t> words;
    std::vector<bool>          last;
};

template <typename T>
struct output_window {
    std::vector<T> data;
    std::size_t    index = 0;

    output_window() = default;
    explicit output_window(std::size_t n) : data(n) {}
};

template <typename T>
struct input_window {
    std::vector<T> data;
    std::size_t    index = 0;

    input_window() = default;
    explicit input_window(std::vector<T> values) : data(std::move(values)) {}
};

inline std::uint32_t readincr(input_pktstream* s) {
    if (s->index >= s->words.size()) {
        throw std::out_of_range("readincr past end");
    }
    return s->words[s->index++];
}

inline void writeincr(output_pktstream* s, std::uint32_t word, bool last = false) {
    s->words.push_back(word);
    s->last.push_back(last);
}

template <typename T>
inline std::size_t window_size(output_window<T>* w) {
    return w->data.size() * sizeof(T);
}

template <typename T>
inline std::size_t window_size(input_window<T>* w) {
    return w->data.size() * sizeof(T);
}

inline void window_writeincr(output_window<float>* w, float value) {
    if (w->index >= w->data.size()) {
        throw std::out_of_range("window_writeincr past end");
    }
    w->data[w->index++] = value;
}

inline float window_readincr(input_window<float>* w) {
    if (w->index >= w->data.size()) {
        throw std::out_of_range("window_readincr past end");
    }
    return w->data[w->index++];
}

}  // namespace adf
