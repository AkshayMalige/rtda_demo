.PHONY: all  i0_wrap_matrix_vector_mul.rule i1_wrap_matrix_vector_mul.rule i2_wrap_matrix_vector_mul.rule i3_wrap_matrix_vector_mul.rule i4_wrap_matrix_vector_mul.rule i5_wrap_matrix_vector_mul.rule i6_wrap_matrix_vector_mul.rule i7_wrap_matrix_vector_mul.rule i8_wrap_matrix_vector_mul.rule i9_wrap_matrix_vector_mul.rule i10_wrap_matrix_vector_mul.rule i11_wrap_matrix_vector_mul.rule i14_window_split_768_to_512_256.rule i15_window_split_512_to_256x2.rule i16_window_split_256_to_128x2.rule i19_window_split_128_to_64x2.rule clean

ifeq ($(XILINX_VITIS_AIETOOLS),)
XILINX_VITIS_AIETOOLS:=${XILINX_VITIS}/aietools
endif
ifeq ($(CARDANO_AIE_ARCH_MODEL_DIR),)
CARDANO_AIE_ARCH_MODEL_DIR := ${XILINX_VITIS_AIETOOLS}/data/aie_ml/lib
endif
XCHESSCC := xchesscc -aiearch aie-ml

INCLUDE_PATH := -I ../../.. -I ${XILINX_VITIS_AIETOOLS}/include -I /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7 -I /home/synthara/VersalPrjs/LDRD/rtda_demo/common -I /home/synthara/VersalPrjs/LDRD/rtda_demo/dsp_lib/L1/src/aie -I /home/synthara/VersalPrjs/LDRD/rtda_demo/dsp_lib/L1/include/aie -I /home/synthara/VersalPrjs/LDRD/rtda_demo/dsp_lib/L2/include/aie -I ${CARDANO_AIE_ARCH_MODEL_DIR}/runtime_cxx/libcxx-lite/include -I ${CARDANO_AIE_ARCH_MODEL_DIR}/runtime_cxx/libs/libcxx-9.0.0/include-lite -I ${CARDANO_AIE_ARCH_MODEL_DIR}/runtime/include

all:  i0_wrap_matrix_vector_mul.rule i1_wrap_matrix_vector_mul.rule i2_wrap_matrix_vector_mul.rule i3_wrap_matrix_vector_mul.rule i4_wrap_matrix_vector_mul.rule i5_wrap_matrix_vector_mul.rule i6_wrap_matrix_vector_mul.rule i7_wrap_matrix_vector_mul.rule i8_wrap_matrix_vector_mul.rule i9_wrap_matrix_vector_mul.rule i10_wrap_matrix_vector_mul.rule i11_wrap_matrix_vector_mul.rule i14_window_split_768_to_512_256.rule i15_window_split_512_to_256x2.rule i16_window_split_256_to_128x2.rule i19_window_split_128_to_64x2.rule

i0_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i0_wrap_matrix_vector_mul.cpp -o i0_wrap_matrix_vector_mul.ll

i1_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i1_wrap_matrix_vector_mul.cpp -o i1_wrap_matrix_vector_mul.ll

i2_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i2_wrap_matrix_vector_mul.cpp -o i2_wrap_matrix_vector_mul.ll

i3_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i3_wrap_matrix_vector_mul.cpp -o i3_wrap_matrix_vector_mul.ll

i4_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i4_wrap_matrix_vector_mul.cpp -o i4_wrap_matrix_vector_mul.ll

i5_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i5_wrap_matrix_vector_mul.cpp -o i5_wrap_matrix_vector_mul.ll

i6_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i6_wrap_matrix_vector_mul.cpp -o i6_wrap_matrix_vector_mul.ll

i7_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i7_wrap_matrix_vector_mul.cpp -o i7_wrap_matrix_vector_mul.ll

i8_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i8_wrap_matrix_vector_mul.cpp -o i8_wrap_matrix_vector_mul.ll

i9_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i9_wrap_matrix_vector_mul.cpp -o i9_wrap_matrix_vector_mul.ll

i10_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i10_wrap_matrix_vector_mul.cpp -o i10_wrap_matrix_vector_mul.ll

i11_wrap_matrix_vector_mul.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i11_wrap_matrix_vector_mul.cpp -o i11_wrap_matrix_vector_mul.ll

i14_window_split_768_to_512_256.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/window_split_768_to_512_256.cpp -o i14_window_split_768_to_512_256.ll

i15_window_split_512_to_256x2.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/window_split_512_to_256x2.cpp -o i15_window_split_512_to_256x2.ll

i16_window_split_256_to_128x2.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/window_split_256_to_128x2.cpp -o i16_window_split_256_to_128x2.ll

i19_window_split_128_to_64x2.rule:
	${XCHESSCC} +f +s -p me -P ${CARDANO_AIE_ARCH_MODEL_DIR} +Wllvm,-O2,-fno-jump-tables,-fno-discard-value-names,-mllvm,-chess-collapse-struct-types-during-linking=0,-Xclang,-chess-only-info-critical-passes,-g -D__AIENGINE__ -D__AIE_ARCH__=20 -D__LOCK_FENCE_MODE__=2 -DAIE_OPTION_SCALAR_FLOAT_ON_VECTOR -DAIE2_FP32_EMULATION_ACCURACY_FAST ${INCLUDE_PATH} /home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/window_split_128_to_64x2.cpp -o i19_window_split_128_to_64x2.ll

clean:
	rm -rf  i0_wrap_matrix_vector_mul.ll i1_wrap_matrix_vector_mul.ll i2_wrap_matrix_vector_mul.ll i3_wrap_matrix_vector_mul.ll i4_wrap_matrix_vector_mul.ll i5_wrap_matrix_vector_mul.ll i6_wrap_matrix_vector_mul.ll i7_wrap_matrix_vector_mul.ll i8_wrap_matrix_vector_mul.ll i9_wrap_matrix_vector_mul.ll i10_wrap_matrix_vector_mul.ll i11_wrap_matrix_vector_mul.ll i14_window_split_768_to_512_256.ll i15_window_split_512_to_256x2.ll i16_window_split_256_to_128x2.ll i19_window_split_128_to_64x2.ll