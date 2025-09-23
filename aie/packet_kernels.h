#pragma once

#include <adf.h>
#include <cstdint>

#include "nn_defs.h"

constexpr uint8_t PACKET_TYPE_DATA = 0;
constexpr uint8_t PACKET_TYPE_TLAST = 2;

constexpr uint8_t PACKET_ID_D1_WEIGHTS = 0;
constexpr uint8_t PACKET_ID_D2A_WEIGHTS = 1;
constexpr uint8_t PACKET_ID_D2B_WEIGHTS = 2;
constexpr uint8_t PACKET_ID_D1_INPUT   = 3;
constexpr uint8_t PACKET_ID_D2A_INPUT  = 4;
constexpr uint8_t PACKET_ID_D2B_INPUT  = 5;

constexpr uint8_t PACKET_ID_D1_OUTPUT = 10;
constexpr uint8_t PACKET_ID_D2_OUTPUT = 11;

constexpr uint16_t D1_WEIGHTS_WORDS = EMBED_DENSE0_WEIGHTS_SIZE;
constexpr uint16_t D2_WEIGHTS_PART_WORDS = EMBED_DENSE1_WEIGHTS_PART_SIZE;
constexpr uint16_t D1_INPUT_WORDS = EMBED_DENSE0_INPUT_SIZE;
constexpr uint16_t D2_INPUT_PART_WORDS = HIDDEN_SIZE / CASCADE_LENGTH;
constexpr uint16_t DENSE_OUTPUT_WORDS = OUTPUT_SIZE;

void multi_packet_to_float_converter(
    input_pktstream* in0, input_pktstream* in1, input_pktstream* in2,
    input_pktstream* in3, input_pktstream* in4, input_pktstream* in5,
    output_window<float>* d1_wt,
    output_window<float>* d2a_wt,
    output_window<float>* d2b_wt,
    output_window<float>* d1_x,
    output_window<float>* d2a_x,
    output_window<float>* d2b_x);

void multi_float_to_packet_converter(
    input_window<float>* d1_y,
    input_window<float>* d2_y,
    output_pktstream* out0,
    output_pktstream* out1);

