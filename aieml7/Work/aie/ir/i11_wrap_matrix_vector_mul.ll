; ModuleID = 'i11_wrap_matrix_vector_mul.ll'
source_filename = "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i11_wrap_matrix_vector_mul.cpp"
target datalayout = "e-i8:8:8-i16:16:16-i32:32:32-i64:32:32-f32:32:32-f64:32:32-p:32:32:32:32:8-s0:256:256-a0:8:8-S256-n32:64-P1-p0:20:32:32:32:8-p1:20:32:32:32:8-p2:20:32:32:32:8-p3:20:32:32:32:8-p4:20:32:32:32:8-p5:20:32:32:32:8-p6:20:32:32:32:8-p7:20:32:32:32:8-p8:20:32:32:32:8-p9:20:32:32:32:8-p10:20:32:32:32:8-p11:20:32:32:32:8-p12:20:32:32:32:8-p13:20:32:32:32:8-p14:20:32:32:32:8-p15:20:32:32:32:8"
target triple = "pdarch-unknown-unknown-elf"

%"class.xf::dsp::aie::blas::matrix_vector_mul::matrix_vector_mul" = type { %"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass" }
%"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass" = type { ptr }
%class.anon = type { i8 }
%class.anon.6 = type { i8 }
%"struct.aie::detail::utils::iteration_dim" = type { i8 }
%"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" = type { ptr, ptr, ptr, ptr, ptr }
%"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" = type { ptr, ptr, ptr, ptr }
%"struct.adf::detail::io_buffer_base" = type { ptr }
%"class.aie::vector" = type { %"class.aie::detail::vector_base" }
%"class.aie::detail::vector_base" = type { %struct.v8float }
%struct.v8float = type { %struct.ipd.custom_type.v64int4.v64int4 }
%struct.ipd.custom_type.v64int4.v64int4 = type { i256 }
%"class.aie::accum" = type { %"class.aie::detail::accum_base" }
%"class.aie::detail::accum_base" = type { %struct.v8accfloat }
%struct.v8accfloat = type { %struct.ipd.custom_type.v8acc32.v8acc32 }
%struct.ipd.custom_type.v8acc32.v8acc32 = type { i256 }
%"class.aie::vector_elem_ref" = type { ptr, i32 }
%"struct.aie::unary_op" = type { %"struct.aie::unary_op_common" }
%"struct.aie::unary_op_common" = type { %"class.aie::accum" }
%"class.aie::tile" = type { i8 }
%"class.aie::detail::tile" = type { i8 }
%"class.aie::vector.0" = type { %"class.aie::detail::vector_base.1" }
%"class.aie::detail::vector_base.1" = type { %struct.v16float }
%struct.v16float = type { %struct.ipd.custom_type.v128int4.v128int4 }
%struct.ipd.custom_type.v128int4.v128int4 = type { i512 }
%struct.v16int32 = type { %struct.ipd.custom_type.v128int4.v128int4 }
%"struct.aie::unary_op.2" = type { %"struct.aie::unary_op_common.3" }
%"struct.aie::unary_op_common.3" = type { %"class.aie::vector_elem_ref" }
%"struct.aie::unary_op.4" = type { %"struct.aie::unary_op_common.5" }
%"struct.aie::unary_op_common.5" = type { %"class.aie::vector" }
%"class.aie::vector_elem_const_ref" = type { ptr, i32 }
%class.anon.8 = type { ptr, ptr, ptr, ptr, ptr }
%"class.aie::accum.9" = type { %"class.aie::detail::accum_base.10" }
%"class.aie::detail::accum_base.10" = type { %struct.v16accfloat }
%struct.v16accfloat = type { %struct.ipd.custom_type.v16acc32.v16acc32 }
%struct.ipd.custom_type.v16acc32.v16acc32 = type { i512 }
%struct.v32bfloat16 = type { %struct.ipd.custom_type.v128int4.v128int4 }
%struct.v16bfloat16 = type { %struct.ipd.custom_type.v64int4.v64int4 }
%struct.v32uint16 = type { %struct.ipd.custom_type.v128int4.v128int4 }
%struct.ipd.custom_type.uint4_t.uint4_t = type { i4 }
%struct.ipd.custom_type.uint5_t.uint5_t = type { i5 }
%struct.ipd.custom_type.uint1_t.uint1_t = type { i1 }

$_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev = comdat any

$_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEC2Ev = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE = comdat any

$_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv = comdat any

$_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv = comdat any

$_ZN3aie6vectorIfLj8EEC2Ev = comdat any

$_ZN3aie5accumI8accfloatLj8EEC2Ev = comdat any

$_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv = comdat any

$_ZN3aie5accumI8accfloatLj8EEC2IfEERKNS_6vectorIT_Lj8EEEi = comdat any

$_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_ = comdat any

$_ZN3aie6vectorIfLj8EEixEj = comdat any

$_Z9writeincrI8accfloatLj8EEvP14output_cascadeIT_vERKN3aie5accumIS2_XT0_EEE = comdat any

$_ZN3aie4tile7currentEv = comdat any

$_ZN3aie4tile12set_roundingENS_13rounding_modeE = comdat any

$_ZN3aie6detail4tile7currentEv = comdat any

$_ZN3aie4tileC2ERKNS_6detail4tileE = comdat any

$_ZN3aie6detail4tileC2Ev = comdat any

$_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE = comdat any

$_Z7set_rndj = comdat any

$_ZN3aie4tile14set_saturationENS_15saturation_modeE = comdat any

$_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE = comdat any

$_Z11set_satmodej = comdat any

$_ZN3aie6detail11vector_baseIfLj8EEC2Ev = comdat any

$_ZN3aie6detail14vector_storageIfLj8EE5undefEv = comdat any

$_Z13undef_v8floatv = comdat any

$_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv = comdat any

$_Z16undef_v8accfloatv = comdat any

$_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv = comdat any

$_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv = comdat any

$_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv = comdat any

$_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj = comdat any

$_ZN3aie6vectorIfLj16EEC2Ev = comdat any

$_Z26broadcast_zero_to_v16floatv = comdat any

$_ZN3aie6vectorIfLj16EEC2E8v16float = comdat any

$_ZN3aie6detail14vector_storageIfLj16EE5undefEv = comdat any

$_Z14undef_v16floatv = comdat any

$_Z13broadcast_s32i = comdat any

$_ZN8v16floatC2E8v16int32 = comdat any

$_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj = comdat any

$_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE = comdat any

$_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj = comdat any

$_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float = comdat any

$_Z15extract_v8float8v16floati = comdat any

$_ZN12me_primitive6ext_xlE8v16float = comdat any

$_ZN12me_primitive6ext_xhE8v16float = comdat any

$_ZN3aie5accumI8accfloatLj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE16from_vector_signIfEEvRKNS_6vectorIT_Lj8EEEbi = comdat any

$_ZZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_upsIfLj8EEEDavENKUlRKT_T0_T1_E_clINS_6vectorIfLj8EEEibEEDaS7_S8_S9_ = comdat any

$_ZNK3aie6vectorIfLj8EEcv7v8floatEv = comdat any

$_ZN10v8accfloatC2E7v8float = comdat any

$_ZNK3aie6vectorIfLj8EE9to_nativeEv = comdat any

$_ZNK3aie6detail11vector_baseIfLj8EE9to_nativeEv = comdat any

$_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_ = comdat any

$_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_ = comdat any

$_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_ = comdat any

$_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_ = comdat any

$_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_ = comdat any

$_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_ = comdat any

$_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_ = comdat any

$_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev = comdat any

$_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE = comdat any

$_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_ = comdat any

$_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev = comdat any

$_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_ = comdat any

$_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev = comdat any

$_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_ = comdat any

$_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv = comdat any

$_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ = comdat any

$_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf = comdat any

$_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_ = comdat any

$_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_ = comdat any

$_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_ = comdat any

$_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_ = comdat any

$_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_ = comdat any

$_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_ = comdat any

$_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj = comdat any

$_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv = comdat any

$_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj = comdat any

$_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat = comdat any

$_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE = comdat any

$_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj = comdat any

$_Z11mac_elem_168v16floatS_11v16accfloat = comdat any

$_ZNK3aie6vectorIfLj16EEcv8v16floatEv = comdat any

$_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv = comdat any

$_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii = comdat any

$_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii = comdat any

$_Z29broadcast_zero_to_v32bfloat16v = comdat any

$_Z28broadcast_one_to_v32bfloat16v = comdat any

$_Z6insert11v32bfloat16i11v16bfloat16 = comdat any

$_Z14to_v16bfloat1611v16accfloat = comdat any

$_ZN11v16accfloatC2E8v16float = comdat any

$_Z13msc_elem_16_211v32bfloat16S_11v16accfloat = comdat any

$_Z21addmac_elem_16_2_conf11v32bfloat16S_11v16accfloatS0_iiii = comdat any

$_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii = comdat any

$_Z18mul_elem_16_2_conf11v32bfloat16S_i = comdat any

$_Z13broadcast_u16t = comdat any

$_ZN11v32bfloat16C2E9v32uint16 = comdat any

$_ZN12me_primitive6upd_xlE11v32bfloat1611v16bfloat16 = comdat any

$_ZN12me_primitive6upd_xhE11v32bfloat1611v16bfloat16 = comdat any

$_ZN12me_primitive3srsE11v16accfloat7uint4_t7uint5_t = comdat any

$_Z7get_rndv = comdat any

$_ZN7uint4_tC2Ej = comdat any

$_Z14get_fp2bf_maskv = comdat any

$_ZN7uint5_tC2Ej = comdat any

$_ZNK7uint5_tcvjEv = comdat any

$_ZN9me_detail15compute_controlEiiiiiiiiiii = comdat any

$_ZN12me_primitive10mac16_confE11v32bfloat16S0_11v16accfloati7uint1_t7uint5_t = comdat any

$_ZN7uint1_tC2Ei = comdat any

$_Z17get_fpmulmac_maskv = comdat any

$_ZN12me_primitive13addmac16_confE11v32bfloat16S0_11v16accfloatS1_i7uint1_t7uint5_t = comdat any

$_ZN12me_primitive10mul16_confE11v32bfloat16S0_i7uint1_t7uint5_t = comdat any

$_ZNK3aie6vectorIfLj16EE9to_nativeEv = comdat any

$_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv = comdat any

$_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv = comdat any

$_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj = comdat any

$_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj = comdat any

$_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE = comdat any

$_ZN3aie6detail11vector_baseIfLj16EEC2Ev = comdat any

$_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj = comdat any

$_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float = comdat any

$_Z12set_v16floati7v8float = comdat any

$_ZN12me_primitive6set_xlE7v8float = comdat any

$_ZN12me_primitive6set_xhE7v8float = comdat any

$_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv = comdat any

$_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv = comdat any

$_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv = comdat any

$_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev = comdat any

$_Z6concat10v8accfloatS_ = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat = comdat any

$_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv = comdat any

$_Z17undef_v16accfloatv = comdat any

$_ZN12me_primitive12concat_bm_amE10v8accfloatS0_ = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE = comdat any

$_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj = comdat any

$_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat = comdat any

$_Z18extract_v8accfloat11v16accfloati = comdat any

$_ZN12me_primitive6ext_blE11v16accfloat = comdat any

$_ZN12me_primitive6ext_bhE11v16accfloat = comdat any

$_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf = comdat any

$_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf = comdat any

$_Z21broadcast_to_v16floatf = comdat any

$_ZNK3aie21vector_elem_const_refIfLj8EE3getEv = comdat any

$_ZNK3aie6vectorIfLj8EE3getEj = comdat any

$_ZNK3aie6detail11vector_baseIfLj8EE3getEj = comdat any

$_Z12extract_elem8v16floati = comdat any

$_ZN12me_primitive9ext_elem_E8v16floatii = comdat any

$_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_ = comdat any

$_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_ = comdat any

$_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_ = comdat any

$_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_ = comdat any

$_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_ = comdat any

$_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_ = comdat any

$_ZN3aie6vectorIfLj8EE8elem_refEj = comdat any

$_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj = comdat any

$_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE = comdat any

$_Z7put_mcd11v16accfloat = comdat any

$_Z7put_mcd11v16accfloati = comdat any

$_Z7put_mcd8v16acc32i = comdat any

$_ZN8v16acc32C2E11v16accfloat = comdat any

$_ZN12me_primitive9mcd_writeE8v16acc327uint1_t = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEC2Ev = comdat any

@i11 = dso_local global %"class.xf::dsp::aie::blas::matrix_vector_mul::matrix_vector_mul" zeroinitializer, align 4, !dbg !0
@_ZN12me_primitive11control_rndE = external dso_local global i32, align 4
@_ZN12me_primitive11control_satE = external dso_local global i32, align 4
@__const._ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE16from_vector_signIfEEvRKNS_6vectorIT_Lj8EEEbi.fn = private unnamed_addr constant %class.anon undef, align 1
@__const._ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_.mul_op = private unnamed_addr constant %class.anon.6 undef, align 1
@__const._ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_.it = private unnamed_addr constant %"struct.aie::detail::utils::iteration_dim" undef, align 1
@llvm.global_ctors = appending global [1 x { i32, ptr addrspace(1), ptr }] [{ i32, ptr addrspace(1), ptr } { i32 65535, ptr addrspace(1) @_GLOBAL__sub_I_i11_wrap_matrix_vector_mul.cpp, ptr null }]

; Function Attrs: mustprogress noinline nounwind
define weak_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE(ptr nonnull align 4 dereferenceable(4) %this, ptr nonnull align 4 dereferenceable(32768) %inMatrixA, ptr chesscopy noalias nonnull align 4 dereferenceable(8) %inWindowB, ptr %outCascade) addrspace(1) #0 comdat align 2 !dbg !1500 !noalias !1509 {
entry:
  %this.addr = alloca ptr, align 4
  %inMatrixA.addr = alloca ptr, align 4
  %inWindowB.addr = alloca ptr, align 4
  %outCascade.addr = alloca ptr, align 4
  %inInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %agg.tmp = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %agg.tmp4 = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512, !noalias !1516
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1502, metadata !DIExpression()), !dbg !1520
  store ptr %inMatrixA, ptr %inMatrixA.addr, align 4, !tbaa !1512, !noalias !1516
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inMatrixA.addr, metadata !1504, metadata !DIExpression()), !dbg !1521
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inWindowB.addr, i32 0, metadata !1522), !noalias !1516
  store ptr %inWindowB, ptr %inWindowB.addr, align 4, !tbaa !1512, !noalias !1516
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inWindowB.addr, metadata !1505, metadata !DIExpression()), !dbg !1523
  store ptr %outCascade, ptr %outCascade.addr, align 4, !tbaa !1512, !noalias !1516
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outCascade.addr, metadata !1506, metadata !DIExpression()), !dbg !1524
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1516
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" undef, ptr %inInterface, align 4, !dbg !1525, !noalias !1516
  call addrspace(1) void @llvm.lifetime.start.p0(i64 20, ptr %inInterface) #20, !dbg !1525, !noalias !1516
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !1507, metadata !DIExpression()), !dbg !1526
  %1 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inInterface, i32 0, metadata !1527), !dbg !1525, !noalias !1516
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(20) %inInterface) #21, !dbg !1526, !noalias !1516
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" undef, ptr %outInterface, align 4, !dbg !1528, !noalias !1516
  call addrspace(1) void @llvm.lifetime.start.p0(i64 16, ptr %outInterface) #20, !dbg !1528, !noalias !1516
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !1508, metadata !DIExpression()), !dbg !1529
  %2 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1530), !dbg !1528, !noalias !1516
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(16) %outInterface) #21, !dbg !1529, !noalias !1516
  %3 = load ptr, ptr %inWindowB.addr, align 4, !dbg !1531, !tbaa !1512, !noalias !1516
  %call = call addrspace(1) ptr @_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv(ptr nonnull align 4 dereferenceable(8) %3) #22, !dbg !1532, !noalias !1516
  %inWindowB2 = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 1, !dbg !1533
  store ptr %call, ptr %inWindowB2, align 4, !dbg !1534, !tbaa !1535, !noalias !1516
  %4 = load ptr, ptr %outCascade.addr, align 4, !dbg !1537, !tbaa !1512, !noalias !1516
  %outCascade3 = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %outInterface, i32 0, i32 3, !dbg !1538
  store ptr %4, ptr %outCascade3, align 4, !dbg !1539, !tbaa !1540, !noalias !1516
  %5 = load ptr, ptr %inMatrixA.addr, align 4, !dbg !1542, !tbaa !1512, !noalias !1516
  %arraydecay = getelementptr inbounds [8192 x float], ptr %5, i32 0, i32 0, !dbg !1542
  %m_inMatrixPtr = getelementptr inbounds %"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass", ptr %this1, i32 0, i32 0, !dbg !1543
  store ptr %arraydecay, ptr %m_inMatrixPtr, align 4, !dbg !1544, !tbaa !1545, !noalias !1516
  %6 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %inInterface, ptr %1, metadata !1547, metadata !1527), !dbg !1548
  %7 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %6, align 4, !dbg !1548, !tbaa !1549, !noalias !1516
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" %7, ptr %agg.tmp, align 4, !dbg !1548, !tbaa !1549, !noalias !1516
  %8 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %outInterface, ptr %2, metadata !1550, metadata !1530), !dbg !1551
  %9 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %8, align 4, !dbg !1551, !tbaa !1552, !noalias !1516
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %9, ptr %agg.tmp4, align 4, !dbg !1551, !tbaa !1552, !noalias !1516
  %10 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %agg.tmp4, ptr null, metadata !1550, metadata !1509), !dbg !1553
  %11 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %10, align 4, !dbg !1553, !tbaa !1552, !noalias !1516
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this1, ptr %agg.tmp, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %11) #22, !dbg !1553, !noalias !1516
  call addrspace(1) void @llvm.lifetime.end.p0(i64 16, ptr %outInterface) #20, !dbg !1554
  call addrspace(1) void @llvm.lifetime.end.p0(i64 20, ptr %inInterface) #20, !dbg !1554
  ret void, !dbg !1554
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) addrspace(1) #1

; Function Attrs: nounwind willreturn memory(inaccessiblemem: readwrite)
declare ptr @llvm.noalias.decl.p0.p0.i32(ptr, i32, metadata) addrspace(1) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) addrspace(1) #3

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(20) %this) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !1555 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1561, metadata !DIExpression()), !dbg !1563
  %this1 = load ptr, ptr %this.addr, align 4
  %inCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %this1, i32 0, i32 4, !dbg !1564
  store ptr null, ptr %inCascade, align 4, !dbg !1564, !tbaa !1565
  ret void, !dbg !1566
}

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(16) %this) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !1567 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1573, metadata !DIExpression()), !dbg !1575
  %this1 = load ptr, ptr %this.addr, align 4
  %outCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %this1, i32 0, i32 3, !dbg !1576
  store ptr null, ptr %outCascade, align 4, !dbg !1576, !tbaa !1540
  ret void, !dbg !1577
}

; Function Attrs: inlinehint mustprogress nounwind
define linkonce_odr dso_local ptr @_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #5 comdat align 2 !dbg !1578 !noalias !1590 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512, !noalias !1590
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1588, metadata !DIExpression()), !dbg !1593
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1590
  %_base = getelementptr inbounds %"struct.adf::detail::io_buffer_base", ptr %this1, i32 0, i32 0, !dbg !1594
  %0 = load ptr, ptr %_base, align 4, !dbg !1594, !tbaa !1596, !noalias !1590
  %1 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %0, ptr null, ptr %_base, i32 0, metadata !1590), !dbg !1594, !tbaa !1596, !noalias !1590
  ret ptr %1, !dbg !1598
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this, ptr %inInterface, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce) addrspace(1) #6 comdat align 2 !dbg !1599 !noalias !1604 {
entry:
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %this.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %agg.tmp2 = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce, ptr %outInterface, align 4, !noalias !1607
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512, !noalias !1607
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1601, metadata !DIExpression()), !dbg !1609
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !1602, metadata !DIExpression()), !dbg !1610
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1611), !noalias !1607
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !1603, metadata !DIExpression()), !dbg !1612
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1607
  %1 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %inInterface, ptr null, metadata !1547, metadata !1604), !dbg !1613
  %2 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %1, align 4, !dbg !1613, !tbaa !1549, !noalias !1607
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" %2, ptr %agg.tmp, align 4, !dbg !1613, !tbaa !1549, !noalias !1607
  %3 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %outInterface, ptr %0, metadata !1550, metadata !1611), !dbg !1614
  %4 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %3, align 4, !dbg !1614, !tbaa !1552, !noalias !1607
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %4, ptr %agg.tmp2, align 4, !dbg !1614, !tbaa !1552, !noalias !1607
  %5 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %agg.tmp2, ptr null, metadata !1550, metadata !1604), !dbg !1615
  %6 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %5, align 4, !dbg !1615, !tbaa !1552, !noalias !1607
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this1, ptr %agg.tmp, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %6) #22, !dbg !1615, !noalias !1607
  ret void, !dbg !1616
}

; Function Attrs: nounwind willreturn memory(none)
declare ptr @llvm.noalias.copy.guard.p0.p0(ptr, ptr, metadata, metadata) addrspace(1) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) addrspace(1) #3

; Function Attrs: nounwind
define internal void @__cxx_global_var_init() addrspace(1) #8 !dbg !1617 {
entry:
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEC2Ev(ptr nonnull align 4 dereferenceable(4) @i11) #22, !dbg !1618
  ret void, !dbg !1618
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEC2Ev(ptr nonnull align 4 dereferenceable(4) %this) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !1619 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1621, metadata !DIExpression()), !dbg !1622
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEC2Ev(ptr nonnull align 4 dereferenceable(4) %this1) #22, !dbg !1623
  ret void, !dbg !1624
}

; Function Attrs: mustprogress nounwind
define dso_local ptr @_Z8i11_userv() addrspace(1) #9 !dbg !1625 {
entry:
  ret ptr @i11, !dbg !1628
}

; Function Attrs: nounwind speculatable willreturn memory(argmem: readwrite)
declare ptr @llvm.noalias.p0.p0.p0.i32(ptr, ptr, ptr, i32, metadata) addrspace(1) #10

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this, ptr %inInterface, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce) addrspace(1) #6 comdat align 2 !dbg !1629 !noalias !1634 {
entry:
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %this.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %agg.tmp2 = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce, ptr %outInterface, align 4, !noalias !1637
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512, !noalias !1637
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1631, metadata !DIExpression()), !dbg !1639
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !1632, metadata !DIExpression()), !dbg !1640
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1641), !noalias !1637
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !1633, metadata !DIExpression()), !dbg !1642
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1637
  %1 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %inInterface, ptr null, metadata !1547, metadata !1634), !dbg !1643
  %2 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %1, align 4, !dbg !1643, !tbaa !1549, !noalias !1637
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" %2, ptr %agg.tmp, align 4, !dbg !1643, !tbaa !1549, !noalias !1637
  %3 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %outInterface, ptr %0, metadata !1550, metadata !1641), !dbg !1646
  %4 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %3, align 4, !dbg !1646, !tbaa !1552, !noalias !1637
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %4, ptr %agg.tmp2, align 4, !dbg !1646, !tbaa !1552, !noalias !1637
  %5 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %agg.tmp2, ptr null, metadata !1550, metadata !1634), !dbg !1647
  %6 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %5, align 4, !dbg !1647, !tbaa !1552, !noalias !1637
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this1, ptr %agg.tmp, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %6) #22, !dbg !1647, !noalias !1637
  ret void, !dbg !1648
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this, ptr %inInterface, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce) addrspace(1) #6 comdat align 2 !dbg !84 !noalias !1649 {
entry:
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %this.addr = alloca ptr, align 4
  %dataA = alloca %"class.aie::vector", align 32
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %inPtrA = alloca ptr, align 4
  %dataB = alloca %"class.aie::vector", align 32
  %custom_type.tmp2 = alloca %"class.aie::vector", align 32
  %inPtrB = alloca ptr, align 4
  %acc = alloca %"class.aie::accum", align 32
  %custom_type.tmp3 = alloca %"class.aie::accum", align 32
  %blankVect = alloca %"class.aie::vector", align 32
  %outVect = alloca %"class.aie::vector", align 32
  %custom_type.tmp4 = alloca %"class.aie::vector", align 32
  %inMatrixBuff = alloca ptr, align 4
  %inMatrixPtrRtp = alloca ptr, align 4
  %matrixPtr = alloca ptr, align 4
  %matrixStartPtr = alloca ptr, align 4
  %vectorStartPtr = alloca ptr, align 4
  %outPtr = alloca ptr, align 4
  %frame = alloca i32, align 4
  %cleanup.dest.slot = alloca i32, align 4
  %idx = alloca i32, align 4
  %tmp = alloca %"class.aie::accum", align 32
  %vecInB = alloca i32, align 4
  %jdx = alloca i32, align 4
  %agg.tmp = alloca %"class.aie::vector_elem_ref", align 4
  %agg.tmp24 = alloca %"class.aie::accum", align 32
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce, ptr %outInterface, align 4, !noalias !1652
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !179, metadata !DIExpression()), !dbg !1662
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !181, metadata !DIExpression()), !dbg !1663
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1664), !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !182, metadata !DIExpression()), !dbg !1665
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1652
  call addrspace(1) void @_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv() #22, !dbg !1666, !noalias !1652
  call addrspace(1) void @_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv() #22, !dbg !1667, !noalias !1652
  store %"class.aie::vector" undef, ptr %dataA, align 32, !dbg !1668, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %dataA) #20, !dbg !1668, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %dataA, metadata !183, metadata !DIExpression()), !dbg !1669
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #22, !dbg !1669, !noalias !1652
  %1 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !1669, !tbaa !1670, !noalias !1652
  store %"class.aie::vector" %1, ptr %dataA, align 32, !dbg !1669, !tbaa !1670, !noalias !1652
  store ptr undef, ptr %inPtrA, align 4, !dbg !1674, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inPtrA) #20, !dbg !1674, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inPtrA, metadata !184, metadata !DIExpression()), !dbg !1675
  %2 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inPtrA, i32 0, metadata !1676), !dbg !1674, !noalias !1652
  store %"class.aie::vector" undef, ptr %dataB, align 32, !dbg !1677, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %dataB) #20, !dbg !1677, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %dataB, metadata !186, metadata !DIExpression()), !dbg !1678
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp2) #22, !dbg !1678, !noalias !1652
  %3 = load %"class.aie::vector", ptr %custom_type.tmp2, align 32, !dbg !1678, !tbaa !1670, !noalias !1652
  store %"class.aie::vector" %3, ptr %dataB, align 32, !dbg !1678, !tbaa !1670, !noalias !1652
  store ptr undef, ptr %inPtrB, align 4, !dbg !1679, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inPtrB) #20, !dbg !1679, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inPtrB, metadata !369, metadata !DIExpression()), !dbg !1680
  %4 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inPtrB, i32 0, metadata !1681), !dbg !1679, !noalias !1652
  store %"class.aie::accum" undef, ptr %acc, align 32, !dbg !1682, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %acc) #20, !dbg !1682, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !372, metadata !DIExpression()), !dbg !1683
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp3) #22, !dbg !1683, !noalias !1652
  %5 = load %"class.aie::accum", ptr %custom_type.tmp3, align 32, !dbg !1683, !tbaa !1684, !noalias !1652
  store %"class.aie::accum" %5, ptr %acc, align 32, !dbg !1683, !tbaa !1684, !noalias !1652
  store %"class.aie::vector" undef, ptr %blankVect, align 32, !dbg !1688, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %blankVect) #20, !dbg !1688, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %blankVect, metadata !460, metadata !DIExpression()), !dbg !1689
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv() #22, !dbg !1690, !noalias !1652
  %6 = getelementptr inbounds %"class.aie::vector", ptr %blankVect, i32 0, i32 0, !dbg !1690
  %7 = extractvalue %"class.aie::vector" %call, 0, !dbg !1690
  store %"class.aie::detail::vector_base" %7, ptr %6, align 32, !dbg !1690, !noalias !1652
  store %"class.aie::vector" undef, ptr %outVect, align 32, !dbg !1691, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %outVect) #20, !dbg !1691, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outVect, metadata !462, metadata !DIExpression()), !dbg !1692
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp4) #22, !dbg !1692, !noalias !1652
  %8 = load %"class.aie::vector", ptr %custom_type.tmp4, align 32, !dbg !1692, !tbaa !1670, !noalias !1652
  store %"class.aie::vector" %8, ptr %outVect, align 32, !dbg !1692, !tbaa !1670, !noalias !1652
  store ptr undef, ptr %inMatrixBuff, align 4, !dbg !1693, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inMatrixBuff) #20, !dbg !1693, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inMatrixBuff, metadata !463, metadata !DIExpression()), !dbg !1694
  %9 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inMatrixBuff, i32 0, metadata !1695), !dbg !1693, !noalias !1652
  %inWindowA = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 0, !dbg !1696
  %10 = load ptr, ptr %inWindowA, align 4, !dbg !1696, !tbaa !1697, !noalias !1652
  %11 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %10, ptr null, ptr %inWindowA, i32 0, metadata !1649), !dbg !1696, !tbaa !1697, !noalias !1652
  %12 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %11), !dbg !1694
  store ptr %12, ptr %inMatrixBuff, align 4, !dbg !1694, !tbaa !1512, !noalias !1652
  store ptr undef, ptr %inMatrixPtrRtp, align 4, !dbg !1698, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inMatrixPtrRtp) #20, !dbg !1698, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inMatrixPtrRtp, metadata !464, metadata !DIExpression()), !dbg !1699
  %13 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inMatrixPtrRtp, i32 0, metadata !1700), !dbg !1698, !noalias !1652
  %m_inMatrixPtr = getelementptr inbounds %"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass", ptr %this1, i32 0, i32 0, !dbg !1701
  %14 = load ptr, ptr %m_inMatrixPtr, align 4, !dbg !1701, !tbaa !1545, !noalias !1652
  %15 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %14, ptr null, ptr %m_inMatrixPtr, i32 0, metadata !1649), !dbg !1701, !tbaa !1545, !noalias !1652
  %16 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %15), !dbg !1699
  store ptr %16, ptr %inMatrixPtrRtp, align 4, !dbg !1699, !tbaa !1512, !noalias !1652
  store ptr undef, ptr %matrixPtr, align 4, !dbg !1702, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %matrixPtr) #20, !dbg !1702, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %matrixPtr, metadata !465, metadata !DIExpression()), !dbg !1703
  %17 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %matrixPtr, i32 0, metadata !1704), !dbg !1702, !noalias !1652
  %18 = load ptr, ptr %inMatrixPtrRtp, align 4, !dbg !1705, !tbaa !1512, !noalias !1652
  %19 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %18, ptr %13, ptr %inMatrixPtrRtp, i32 0, metadata !1700), !dbg !1705, !tbaa !1512, !noalias !1652
  %20 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %19), !dbg !1703
  store ptr %20, ptr %matrixPtr, align 4, !dbg !1703, !tbaa !1512, !noalias !1652
  store ptr undef, ptr %matrixStartPtr, align 4, !dbg !1706, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %matrixStartPtr) #20, !dbg !1706, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %matrixStartPtr, metadata !466, metadata !DIExpression()), !dbg !1707
  %21 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %matrixStartPtr, i32 0, metadata !1708), !dbg !1706, !noalias !1652
  %22 = load ptr, ptr %matrixPtr, align 4, !dbg !1709, !tbaa !1512, !noalias !1652
  %23 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %22, ptr %17, ptr %matrixPtr, i32 0, metadata !1704), !dbg !1709, !tbaa !1512, !noalias !1652
  %24 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %23), !dbg !1707
  store ptr %24, ptr %matrixStartPtr, align 4, !dbg !1707, !tbaa !1512, !noalias !1652
  store ptr undef, ptr %vectorStartPtr, align 4, !dbg !1710, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %vectorStartPtr) #20, !dbg !1710, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %vectorStartPtr, metadata !467, metadata !DIExpression()), !dbg !1711
  %25 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %vectorStartPtr, i32 0, metadata !1712), !dbg !1710, !noalias !1652
  %inWindowB = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 1, !dbg !1713
  %26 = load ptr, ptr %inWindowB, align 4, !dbg !1713, !tbaa !1535, !noalias !1652
  %27 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %26, ptr null, ptr %inWindowB, i32 0, metadata !1649), !dbg !1713, !tbaa !1535, !noalias !1652
  %28 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %27), !dbg !1711
  store ptr %28, ptr %vectorStartPtr, align 4, !dbg !1711, !tbaa !1512, !noalias !1652
  store ptr undef, ptr %outPtr, align 4, !dbg !1714, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %outPtr) #20, !dbg !1714, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outPtr, metadata !468, metadata !DIExpression()), !dbg !1715
  %29 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outPtr, i32 0, metadata !1716), !dbg !1714, !noalias !1652
  %outWindow = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %outInterface, i32 0, i32 0, !dbg !1717
  %30 = load ptr, ptr %outWindow, align 4, !dbg !1717, !tbaa !1718, !noalias !1652
  %31 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %30, ptr %0, ptr %outWindow, i32 0, metadata !1664), !dbg !1717, !tbaa !1718, !noalias !1652
  %32 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %31), !dbg !1715
  store ptr %32, ptr %outPtr, align 4, !dbg !1715, !tbaa !1512, !noalias !1652
  store i32 undef, ptr %frame, align 4, !dbg !1719, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %frame) #20, !dbg !1719, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %frame, metadata !472, metadata !DIExpression()), !dbg !1720
  store i32 0, ptr %frame, align 4, !dbg !1720, !tbaa !1721, !noalias !1652
  br label %for.cond, !dbg !1719

for.cond:                                         ; preds = %for.inc31, %entry
  %33 = load i32, ptr %frame, align 4, !dbg !1723, !tbaa !1721, !noalias !1652
  %cmp = icmp ult i32 %33, 1, !dbg !1724
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !1725

for.cond.cleanup:                                 ; preds = %for.cond
  store i32 2, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %frame) #20, !dbg !1726, !noalias !1652
  br label %for.end33

for.body:                                         ; preds = %for.cond
  store i32 undef, ptr %idx, align 4, !dbg !1727, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %idx) #20, !dbg !1727, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx, metadata !474, metadata !DIExpression()), !dbg !1728
  store i32 0, ptr %idx, align 4, !dbg !1728, !tbaa !1721, !noalias !1652
  br label %for.pre_assume, !dbg !1727

for.pre_assume:                                   ; preds = %for.body
  %34 = load i32, ptr %idx, align 4, !dbg !1729, !tbaa !1721, !noalias !1652
  %cmp7 = icmp slt i32 %34, 16, !dbg !1730
  call addrspace(1) void @llvm.assume(i1 %cmp7), !dbg !1731, !noalias !1652
  br label %for.body9, !dbg !1731

for.cond5:                                        ; preds = %for.inc28
  %35 = load i32, ptr %idx, align 4, !dbg !1729, !tbaa !1721, !noalias !1652
  %cmp6 = icmp slt i32 %35, 16, !dbg !1730
  br i1 %cmp6, label %for.body9, label %for.cond.cleanup8, !dbg !1731, !llvm.loop !1732

for.cond.cleanup8:                                ; preds = %for.cond5
  store i32 5, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %idx) #20, !dbg !1739, !noalias !1652
  br label %for.end30

for.body9:                                        ; preds = %for.cond5, %for.pre_assume
  %36 = load ptr, ptr %matrixStartPtr, align 4, !dbg !1740, !tbaa !1512, !noalias !1652
  %37 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %36, ptr %21, ptr %matrixStartPtr, i32 0, metadata !1708), !dbg !1740, !tbaa !1512, !noalias !1652
  %38 = load i32, ptr %frame, align 4, !dbg !1741, !tbaa !1721, !noalias !1652
  %mul = mul nsw i32 %38, 1024, !dbg !1742
  %add.ptr = getelementptr inbounds %"class.aie::vector", ptr %37, i32 %mul, !dbg !1743
  %39 = load i32, ptr %idx, align 4, !dbg !1744, !tbaa !1721, !noalias !1652
  %add.ptr10 = getelementptr inbounds %"class.aie::vector", ptr %add.ptr, i32 %39, !dbg !1745
  store ptr %add.ptr10, ptr %inPtrA, align 4, !dbg !1746, !tbaa !1512, !noalias !1652
  %40 = load ptr, ptr %vectorStartPtr, align 4, !dbg !1747, !tbaa !1512, !noalias !1652
  %41 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %40, ptr %25, ptr %vectorStartPtr, i32 0, metadata !1712), !dbg !1747, !tbaa !1512, !noalias !1652
  %42 = load i32, ptr %frame, align 4, !dbg !1748, !tbaa !1721, !noalias !1652
  %mul11 = mul nsw i32 %42, 8, !dbg !1749
  %add.ptr12 = getelementptr inbounds %"class.aie::vector", ptr %41, i32 %mul11, !dbg !1750
  store ptr %add.ptr12, ptr %inPtrB, align 4, !dbg !1751, !tbaa !1512, !noalias !1652
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2IfEERKNS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %tmp, ptr nonnull align 32 dereferenceable(32) %blankVect, i32 0) #22, !dbg !1752, !noalias !1652
  %43 = load %"class.aie::accum", ptr %tmp, align 32, !dbg !1755, !tbaa !1684, !noalias !1652
  store %"class.aie::accum" %43, ptr %acc, align 32, !dbg !1755, !tbaa !1684, !noalias !1652
  store i32 undef, ptr %vecInB, align 4, !dbg !1756, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %vecInB) #20, !dbg !1756, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %vecInB, metadata !478, metadata !DIExpression()), !dbg !1757
  store i32 0, ptr %vecInB, align 4, !dbg !1757, !tbaa !1721, !noalias !1652
  br label %for.cond13, !dbg !1756

for.cond13:                                       ; preds = %for.inc25, %for.body9
  %44 = load i32, ptr %vecInB, align 4, !dbg !1758, !tbaa !1721, !noalias !1652
  %cmp14 = icmp slt i32 %44, 8, !dbg !1759
  br i1 %cmp14, label %for.body16, label %for.cond.cleanup15, !dbg !1760

for.cond.cleanup15:                               ; preds = %for.cond13
  store i32 8, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %vecInB) #20, !dbg !1761, !noalias !1652
  br label %for.end27

for.body16:                                       ; preds = %for.cond13
  %45 = load ptr, ptr %inPtrB, align 4, !dbg !1762, !tbaa !1512, !noalias !1652
  %46 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %45, ptr %4, ptr %inPtrB, i32 0, metadata !1681), !dbg !1762, !tbaa !1512, !noalias !1652
  %incdec.ptr = getelementptr inbounds %"class.aie::vector", ptr %46, i32 1, !dbg !1762
  store ptr %incdec.ptr, ptr %inPtrB, align 4, !dbg !1762, !tbaa !1512, !noalias !1652
  %47 = load %"class.aie::vector", ptr %46, align 32, !dbg !1763, !tbaa !1670, !noalias !1652
  store %"class.aie::vector" %47, ptr %dataB, align 32, !dbg !1763, !tbaa !1670, !noalias !1652
  store i32 undef, ptr %jdx, align 4, !dbg !1764, !noalias !1652
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %jdx) #20, !dbg !1764, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %jdx, metadata !482, metadata !DIExpression()), !dbg !1765
  store i32 0, ptr %jdx, align 4, !dbg !1765, !tbaa !1721, !noalias !1652
  br label %for.cond17, !dbg !1764

for.cond17:                                       ; preds = %for.inc, %for.body16
  %48 = load i32, ptr %jdx, align 4, !dbg !1766, !tbaa !1721, !noalias !1652
  %cmp18 = icmp slt i32 %48, 8, !dbg !1768
  br i1 %cmp18, label %for.body20, label %for.cond.cleanup19, !dbg !1769

for.cond.cleanup19:                               ; preds = %for.cond17
  store i32 11, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %jdx) #20, !dbg !1770, !noalias !1652
  br label %for.end

for.body20:                                       ; preds = %for.cond17
  %49 = load ptr, ptr %inPtrA, align 4, !dbg !1771, !tbaa !1512, !noalias !1652
  %50 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %49, ptr %2, ptr %inPtrA, i32 0, metadata !1676), !dbg !1771, !tbaa !1512, !noalias !1652
  %51 = load %"class.aie::vector", ptr %50, align 32, !dbg !1773, !tbaa !1670, !noalias !1652
  store %"class.aie::vector" %51, ptr %dataA, align 32, !dbg !1773, !tbaa !1670, !noalias !1652
  %52 = load ptr, ptr %inPtrA, align 4, !dbg !1774, !tbaa !1512, !noalias !1652
  %53 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %52, ptr %2, ptr %inPtrA, i32 0, metadata !1676), !dbg !1774, !tbaa !1512, !noalias !1652
  %add.ptr21 = getelementptr inbounds %"class.aie::vector", ptr %53, i32 16, !dbg !1774
  store ptr %add.ptr21, ptr %inPtrA, align 4, !dbg !1774, !tbaa !1512, !noalias !1652
  %54 = load i32, ptr %jdx, align 4, !dbg !1775, !tbaa !1721, !noalias !1652
  %call22 = call addrspace(1) %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EEixEj(ptr nonnull align 32 dereferenceable(32) %dataB, i32 %54) #22, !dbg !1778, !noalias !1652
  %55 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %agg.tmp, i32 0, i32 0, !dbg !1778
  %56 = extractvalue %"class.aie::vector_elem_ref" %call22, 0, !dbg !1778
  store ptr %56, ptr %55, align 4, !dbg !1778, !noalias !1652
  %57 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %agg.tmp, i32 0, i32 1, !dbg !1778
  %58 = extractvalue %"class.aie::vector_elem_ref" %call22, 1, !dbg !1778
  store i32 %58, ptr %57, align 4, !dbg !1778, !noalias !1652
  %59 = load %"class.aie::vector_elem_ref", ptr %agg.tmp, align 4, !dbg !1779, !tbaa !1780, !noalias !1652
  %call23 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"class.aie::vector_elem_ref" %59, ptr nonnull align 32 dereferenceable(32) %dataA) #22, !dbg !1779, !noalias !1652
  %60 = getelementptr inbounds %"class.aie::accum", ptr %agg.tmp24, i32 0, i32 0, !dbg !1779
  %61 = extractvalue %"class.aie::accum" %call23, 0, !dbg !1779
  store %"class.aie::detail::accum_base" %61, ptr %60, align 32, !dbg !1779, !noalias !1652
  %62 = load %"class.aie::accum", ptr %agg.tmp24, align 32, !dbg !1782, !tbaa !1684, !noalias !1652
  store %"class.aie::accum" %62, ptr %acc, align 32, !dbg !1782, !tbaa !1684, !noalias !1652
  br label %for.inc, !dbg !1783

for.inc:                                          ; preds = %for.body20
  %63 = load i32, ptr %jdx, align 4, !dbg !1784, !tbaa !1721, !noalias !1652
  %inc = add nsw i32 %63, 1, !dbg !1784
  store i32 %inc, ptr %jdx, align 4, !dbg !1784, !tbaa !1721, !noalias !1652
  br label %for.cond17, !dbg !1770, !llvm.loop !1785

for.end:                                          ; preds = %for.cond.cleanup19
  br label %for.inc25, !dbg !1788

for.inc25:                                        ; preds = %for.end
  %64 = load i32, ptr %vecInB, align 4, !dbg !1789, !tbaa !1721, !noalias !1652
  %inc26 = add nsw i32 %64, 1, !dbg !1789
  store i32 %inc26, ptr %vecInB, align 4, !dbg !1789, !tbaa !1721, !noalias !1652
  br label %for.cond13, !dbg !1761, !llvm.loop !1790

for.end27:                                        ; preds = %for.cond.cleanup15
  %outCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %outInterface, i32 0, i32 3, !dbg !1792
  %65 = load ptr, ptr %outCascade, align 4, !dbg !1792, !tbaa !1540, !noalias !1652
  call addrspace(1) void @_Z9writeincrI8accfloatLj8EEvP14output_cascadeIT_vERKN3aie5accumIS2_XT0_EEE(ptr %65, ptr nonnull align 32 dereferenceable(32) %acc) #22, !dbg !1795, !noalias !1652
  br label %for.inc28, !dbg !1796

for.inc28:                                        ; preds = %for.end27
  %66 = load i32, ptr %idx, align 4, !dbg !1797, !tbaa !1721, !noalias !1652
  %inc29 = add nsw i32 %66, 1, !dbg !1797
  store i32 %inc29, ptr %idx, align 4, !dbg !1797, !tbaa !1721, !noalias !1652
  br label %for.cond5, !dbg !1739, !llvm.loop !1732

for.end30:                                        ; preds = %for.cond.cleanup8
  br label %for.inc31, !dbg !1798

for.inc31:                                        ; preds = %for.end30
  %67 = load i32, ptr %frame, align 4, !dbg !1799, !tbaa !1721, !noalias !1652
  %inc32 = add nsw i32 %67, 1, !dbg !1799
  store i32 %inc32, ptr %frame, align 4, !dbg !1799, !tbaa !1721, !noalias !1652
  br label %for.cond, !dbg !1726, !llvm.loop !1800

for.end33:                                        ; preds = %for.cond.cleanup
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %outPtr) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %vectorStartPtr) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %matrixStartPtr) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %matrixPtr) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inMatrixPtrRtp) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inMatrixBuff) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %outVect) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %blankVect) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %acc) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inPtrB) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %dataB) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inPtrA) #20, !dbg !1802
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %dataA) #20, !dbg !1802
  ret void, !dbg !1802
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv() addrspace(1) #6 comdat !dbg !1803 {
entry:
  call addrspace(1) void @_ZN3aieL12set_roundingENS_13rounding_modeE(i32 0) #22, !dbg !1807
  ret void, !dbg !1810
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv() addrspace(1) #6 comdat !dbg !1811 {
entry:
  call addrspace(1) void @_ZN3aieL14set_saturationENS_15saturation_modeE(i32 0) #22, !dbg !1814
  ret void, !dbg !1817
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1818 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1820, metadata !DIExpression()), !dbg !1822
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this1) #22, !dbg !1823
  ret void, !dbg !1824
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1825 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1827, metadata !DIExpression()), !dbg !1829
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this1) #22, !dbg !1830
  ret void, !dbg !1831
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv() addrspace(1) #6 comdat !dbg !1832 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv() #22, !dbg !1835
  %0 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !1835
  %1 = extractvalue %"class.aie::vector" %call, 0, !dbg !1835
  store %"class.aie::detail::vector_base" %1, ptr %0, align 32, !dbg !1835
  %2 = load %"class.aie::vector", ptr %retval, align 32, !dbg !1836
  ret %"class.aie::vector" %2, !dbg !1836
}

; Function Attrs: nocse nounwind willreturn memory(none)
declare ptr @llvm.chess.copy.p0(ptr) addrspace(1) #12

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) addrspace(1) #13

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj8EEC2IfEERKNS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %v, i32 %shift) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1837 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %shift.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1843, metadata !DIExpression()), !dbg !1846
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !1844, metadata !DIExpression()), !dbg !1847
  store i32 %shift, ptr %shift.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %shift.addr, metadata !1845, metadata !DIExpression()), !dbg !1848
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this1) #22, !dbg !1849
  %0 = load ptr, ptr %v.addr, align 4, !dbg !1850, !tbaa !1512
  %1 = load i32, ptr %shift.addr, align 4, !dbg !1852, !tbaa !1721
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %this1, ptr nonnull align 32 dereferenceable(32) %0, i32 %1) #22, !dbg !1853
  ret void, !dbg !1854
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"class.aie::vector_elem_ref" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !1855 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"class.aie::vector_elem_ref", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %ref.tmp = alloca %"struct.aie::unary_op", align 32
  %agg.tmp = alloca %"class.aie::vector_elem_ref", align 4
  store %"class.aie::vector_elem_ref" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !1862, metadata !DIExpression()), !dbg !1869
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !1863, metadata !DIExpression()), !dbg !1870
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !1864, metadata !DIExpression()), !dbg !1871
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #20, !dbg !1872
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !1875, !tbaa !1512
  %call = call addrspace(1) %"struct.aie::unary_op" @_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_(ptr nonnull align 32 dereferenceable(32) %0) #22, !dbg !1872
  %1 = getelementptr inbounds %"struct.aie::unary_op", ptr %ref.tmp, i32 0, i32 0, !dbg !1872
  %2 = extractvalue %"struct.aie::unary_op" %call, 0, !dbg !1872
  store %"struct.aie::unary_op_common" %2, ptr %1, align 32, !dbg !1872
  %3 = load %"class.aie::vector_elem_ref", ptr %a, align 4, !dbg !1876, !tbaa !1780
  store %"class.aie::vector_elem_ref" %3, ptr %agg.tmp, align 4, !dbg !1876, !tbaa !1780
  %4 = load ptr, ptr %v.addr, align 4, !dbg !1877, !tbaa !1512
  %5 = load %"class.aie::vector_elem_ref", ptr %agg.tmp, align 4, !dbg !1878, !tbaa !1780
  %call1 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %ref.tmp, %"class.aie::vector_elem_ref" %5, ptr nonnull align 32 dereferenceable(32) %4) #22, !dbg !1878
  %6 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !1878
  %7 = extractvalue %"class.aie::accum" %call1, 0, !dbg !1878
  store %"class.aie::detail::accum_base" %7, ptr %6, align 32, !dbg !1878
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #20, !dbg !1879
  %8 = load %"class.aie::accum", ptr %retval, align 32, !dbg !1879
  ret %"class.aie::accum" %8, !dbg !1879
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EEixEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !1880 {
entry:
  %retval = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1882, metadata !DIExpression()), !dbg !1884
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !1883, metadata !DIExpression()), !dbg !1885
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !1886

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !1887, !tbaa !1721
  %cmp = icmp ult i32 %0, 8, !dbg !1887
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !1887
  br i1 %1, label %if.then, label %if.else, !dbg !1890

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !1891

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !1893, !tbaa !1721
  %cmp3 = icmp ult i32 %2, 8, !dbg !1893
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !1893
  br i1 %3, label %if.end, label %if.then4, !dbg !1896

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !1897), !dbg !1893
  br label %if.end, !dbg !1893

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !1896

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !1891

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !1898, !tbaa !1721
  %cmp5 = icmp ult i32 %4, 8, !dbg !1898
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !1898
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !1890

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !1900, !tbaa !1721
  %call = call addrspace(1) %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EE8elem_refEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %5) #22, !dbg !1901
  %6 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %retval, i32 0, i32 0, !dbg !1901
  %7 = extractvalue %"class.aie::vector_elem_ref" %call, 0, !dbg !1901
  store ptr %7, ptr %6, align 4, !dbg !1901
  %8 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %retval, i32 0, i32 1, !dbg !1901
  %9 = extractvalue %"class.aie::vector_elem_ref" %call, 1, !dbg !1901
  store i32 %9, ptr %8, align 4, !dbg !1901
  %10 = load %"class.aie::vector_elem_ref", ptr %retval, align 4, !dbg !1902
  ret %"class.aie::vector_elem_ref" %10, !dbg !1902
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z9writeincrI8accfloatLj8EEvP14output_cascadeIT_vERKN3aie5accumIS2_XT0_EEE(ptr %w, ptr nonnull align 32 dereferenceable(32) %value) addrspace(1) #6 comdat !dbg !1903 {
entry:
  %w.addr = alloca ptr, align 4
  %value.addr = alloca ptr, align 4
  store ptr %w, ptr %w.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w.addr, metadata !1908, metadata !DIExpression()), !dbg !1912
  store ptr %value, ptr %value.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %value.addr, metadata !1909, metadata !DIExpression()), !dbg !1913
  %0 = load ptr, ptr %w.addr, align 4, !dbg !1914, !tbaa !1512
  %1 = load ptr, ptr %value.addr, align 4, !dbg !1915, !tbaa !1512
  %2 = load %"class.aie::accum", ptr %1, align 32, !dbg !1916, !tbaa !1684
  call addrspace(1) void @_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE(ptr %0, %"class.aie::accum" %2) #22, !dbg !1916
  ret void, !dbg !1917
}

; Function Attrs: alwaysinline mustprogress nounwind
define internal void @_ZN3aieL12set_roundingENS_13rounding_modeE(i32 %m) addrspace(1) #6 !dbg !1918 {
entry:
  %m.addr = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::tile", align 1
  %undef.agg.tmp = alloca %"class.aie::tile", align 1
  store i32 %m, ptr %m.addr, align 4, !tbaa !1923
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %m.addr, metadata !1922, metadata !DIExpression()), !dbg !1925
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %ref.tmp) #20, !dbg !1926
  call addrspace(1) void @_ZN3aie4tile7currentEv() #22, !dbg !1926
  %0 = load i32, ptr %m.addr, align 4, !dbg !1927, !tbaa !1923
  call addrspace(1) void @_ZN3aie4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %ref.tmp, i32 %0) #22, !dbg !1928
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %ref.tmp) #20, !dbg !1926
  ret void, !dbg !1929
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie4tile7currentEv() addrspace(1) #6 comdat align 2 !dbg !1930 {
entry:
  %retval = alloca %"class.aie::tile", align 1
  %ref.tmp = alloca %"class.aie::detail::tile", align 1
  %undef.agg.tmp = alloca %"class.aie::detail::tile", align 1
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %ref.tmp) #20, !dbg !1931
  call addrspace(1) void @_ZN3aie6detail4tile7currentEv() #22, !dbg !1931
  call addrspace(1) void @_ZN3aie4tileC2ERKNS_6detail4tileE(ptr nonnull align 1 dereferenceable(1) %retval, ptr nonnull align 1 dereferenceable(1) %ref.tmp) #22, !dbg !1931
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %ref.tmp) #20, !dbg !1932
  ret void, !dbg !1932
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !1933 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1935, metadata !DIExpression()), !dbg !1938
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !1923
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !1937, metadata !DIExpression()), !dbg !1939
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !1940, !tbaa !1923
  call addrspace(1) void @_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %this1, i32 %0) #22, !dbg !1941
  ret void, !dbg !1942
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tile7currentEv() addrspace(1) #6 comdat align 2 !dbg !1943 {
entry:
  %retval = alloca %"class.aie::detail::tile", align 1
  call addrspace(1) void @_ZN3aie6detail4tileC2Ev(ptr nonnull align 1 dereferenceable(1) %retval) #22, !dbg !1944
  ret void, !dbg !1945
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN3aie4tileC2ERKNS_6detail4tileE(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 1 dereferenceable(1) %t) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !1946 {
entry:
  %this.addr = alloca ptr, align 4
  %t.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1948, metadata !DIExpression()), !dbg !1950
  store ptr %t, ptr %t.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %t.addr, metadata !1949, metadata !DIExpression()), !dbg !1951
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %t.addr, align 4, !dbg !1952, !tbaa !1512
  ret void, !dbg !1953
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tileC2Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1954 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1956, metadata !DIExpression()), !dbg !1958
  %this1 = load ptr, ptr %this.addr, align 4
  ret void, !dbg !1959
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !1960 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1962, metadata !DIExpression()), !dbg !1964
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !1923
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !1963, metadata !DIExpression()), !dbg !1965
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !1966, !tbaa !1923
  call addrspace(1) void @_Z7set_rndj(i32 %0) #22, !dbg !1967
  ret void, !dbg !1968
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z7set_rndj(i32 %val) addrspace(1) #6 comdat {
entry:
  %val.addr = alloca i32, align 4
  store i32 %val, ptr %val.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %val.addr, align 4, !tbaa !1721
  store i32 %0, ptr @_ZN12me_primitive11control_rndE, align 4, !tbaa !1721
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define internal void @_ZN3aieL14set_saturationENS_15saturation_modeE(i32 %m) addrspace(1) #6 !dbg !1969 {
entry:
  %m.addr = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::tile", align 1
  %undef.agg.tmp = alloca %"class.aie::tile", align 1
  store i32 %m, ptr %m.addr, align 4, !tbaa !1974
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %m.addr, metadata !1973, metadata !DIExpression()), !dbg !1976
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %ref.tmp) #20, !dbg !1977
  call addrspace(1) void @_ZN3aie4tile7currentEv() #22, !dbg !1977
  %0 = load i32, ptr %m.addr, align 4, !dbg !1978, !tbaa !1974
  call addrspace(1) void @_ZN3aie4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %ref.tmp, i32 %0) #22, !dbg !1979
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %ref.tmp) #20, !dbg !1977
  ret void, !dbg !1980
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !1981 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1983, metadata !DIExpression()), !dbg !1985
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !1974
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !1984, metadata !DIExpression()), !dbg !1986
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !1987, !tbaa !1974
  call addrspace(1) void @_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %this1, i32 %0) #22, !dbg !1988
  ret void, !dbg !1989
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !1990 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1992, metadata !DIExpression()), !dbg !1994
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !1974
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !1993, metadata !DIExpression()), !dbg !1995
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !1996, !tbaa !1974
  call addrspace(1) void @_Z11set_satmodej(i32 %0) #22, !dbg !1997
  ret void, !dbg !1998
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z11set_satmodej(i32 %val) addrspace(1) #6 comdat {
entry:
  %val.addr = alloca i32, align 4
  store i32 %val, ptr %val.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %val.addr, align 4, !tbaa !1721
  store i32 %0, ptr @_ZN12me_primitive11control_satE, align 4, !tbaa !1721
  ret void
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1999 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2001, metadata !DIExpression()), !dbg !2003
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !2004
  %call = call addrspace(1) %struct.v8float @_ZN3aie6detail14vector_storageIfLj8EE5undefEv() #22, !dbg !2005
  %0 = getelementptr inbounds %struct.v8float, ptr %data, i32 0, i32 0, !dbg !2005
  %1 = extractvalue %struct.v8float %call, 0, !dbg !2005
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32, !dbg !2005
  ret void, !dbg !2006
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_ZN3aie6detail14vector_storageIfLj8EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !2007 {
entry:
  %retval = alloca %struct.v8float, align 32
  %call = call addrspace(1) %struct.v8float @_Z13undef_v8floatv() #22, !dbg !2008
  %0 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0, !dbg !2008
  %1 = extractvalue %struct.v8float %call, 0, !dbg !2008
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32, !dbg !2008
  %2 = load %struct.v8float, ptr %retval, align 32, !dbg !2009
  ret %struct.v8float %2, !dbg !2009
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_Z13undef_v8floatv() addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8float, align 32
  %call = call x86_regcallcc addrspace(1) %struct.v8float @__regcall3__chessintr_v8float_undef_v8float() #23
  %0 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0
  %1 = extractvalue %struct.v8float %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32
  %2 = load %struct.v8float, ptr %retval, align 32
  ret %struct.v8float %2
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8float @__regcall3__chessintr_v8float_undef_v8float() addrspace(1) #14

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !2010 {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %call = call addrspace(1) %struct.v8accfloat @_Z16undef_v8accfloatv() #22, !dbg !2011
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0, !dbg !2011
  %1 = extractvalue %struct.v8accfloat %call, 0, !dbg !2011
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32, !dbg !2011
  %2 = load %struct.v8accfloat, ptr %retval, align 32, !dbg !2012
  ret %struct.v8accfloat %2, !dbg !2012
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_Z16undef_v8accfloatv() addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %call = call x86_regcallcc addrspace(1) %struct.v8accfloat @__regcall3__chessintr_v8accfloat_undef_v8accfloat() #23
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0
  %1 = extractvalue %struct.v8accfloat %call, 0
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32
  %2 = load %struct.v8accfloat, ptr %retval, align 32
  ret %struct.v8accfloat %2
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8accfloat @__regcall3__chessintr_v8accfloat_undef_v8accfloat() addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv() addrspace(1) #6 comdat align 2 !dbg !2013 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv() #22, !dbg !2023
  %0 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !2023
  %1 = extractvalue %"class.aie::vector" %call, 0, !dbg !2023
  store %"class.aie::detail::vector_base" %1, ptr %0, align 32, !dbg !2023
  %2 = load %"class.aie::vector", ptr %retval, align 32, !dbg !2025
  ret %"class.aie::vector" %2, !dbg !2025
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv() addrspace(1) #6 comdat align 2 !dbg !2026 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %native_zeros_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::vector.0", align 32
  %agg.tmp = alloca %"class.aie::vector", align 32
  store i32 undef, ptr %native_zeros_elems, align 4, !dbg !2037
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_zeros_elems) #20, !dbg !2037
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_zeros_elems, metadata !2035, metadata !DIExpression()), !dbg !2038
  store i32 16, ptr %native_zeros_elems, align 4, !dbg !2038, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2036, metadata !DIExpression()), !dbg !2039
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #22, !dbg !2039
  %0 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !2039, !tbaa !1670
  store %"class.aie::vector" %0, ptr %retval, align 32, !dbg !2039, !tbaa !1670
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #20, !dbg !2040
  %call = call addrspace(1) %"class.aie::vector.0" @_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv() #22, !dbg !2040
  %1 = getelementptr inbounds %"class.aie::vector.0", ptr %ref.tmp, i32 0, i32 0, !dbg !2040
  %2 = extractvalue %"class.aie::vector.0" %call, 0, !dbg !2040
  store %"class.aie::detail::vector_base.1" %2, ptr %1, align 32, !dbg !2040
  %call1 = call addrspace(1) %"class.aie::vector" @_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %ref.tmp, i32 0) #22, !dbg !2043
  %3 = getelementptr inbounds %"class.aie::vector", ptr %agg.tmp, i32 0, i32 0, !dbg !2043
  %4 = extractvalue %"class.aie::vector" %call1, 0, !dbg !2043
  store %"class.aie::detail::vector_base" %4, ptr %3, align 32, !dbg !2043
  %5 = load %"class.aie::vector", ptr %agg.tmp, align 32, !dbg !2044, !tbaa !1670
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #20, !dbg !2045
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_zeros_elems) #20, !dbg !2046
  ret %"class.aie::vector" %5, !dbg !2044
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.0" @_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv() addrspace(1) #6 comdat align 2 !dbg !2047 {
entry:
  %retval = alloca %"class.aie::vector.0", align 32
  %native_zeros_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector.0", align 32
  %tmp = alloca %"class.aie::vector.0", align 32
  %agg.tmp = alloca %struct.v16float, align 32
  store i32 undef, ptr %native_zeros_elems, align 4, !dbg !2058
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_zeros_elems) #20, !dbg !2058
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_zeros_elems, metadata !2056, metadata !DIExpression()), !dbg !2059
  store i32 16, ptr %native_zeros_elems, align 4, !dbg !2059, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2057, metadata !DIExpression()), !dbg !2060
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp) #22, !dbg !2060
  %0 = load %"class.aie::vector.0", ptr %custom_type.tmp, align 32, !dbg !2060, !tbaa !2061
  store %"class.aie::vector.0" %0, ptr %retval, align 32, !dbg !2060, !tbaa !2061
  %call = call addrspace(1) %struct.v16float @_Z26broadcast_zero_to_v16floatv() #22, !dbg !2065
  %1 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !2065
  %2 = extractvalue %struct.v16float %call, 0, !dbg !2065
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32, !dbg !2065
  %3 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !2065, !tbaa !2072
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %tmp, %struct.v16float %3) #22, !dbg !2065
  %4 = load %"class.aie::vector.0", ptr %tmp, align 32, !dbg !2073, !tbaa !2061
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_zeros_elems) #20, !dbg !2074
  ret %"class.aie::vector.0" %4, !dbg !2073
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2075 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::detail::vector_base", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2082, metadata !DIExpression()), !dbg !2085
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2084, metadata !DIExpression()), !dbg !2086
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #20, !dbg !2087
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2088, !tbaa !1721
  %call = call addrspace(1) %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this1, i32 %0) #22, !dbg !2089
  %1 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %ref.tmp, i32 0, i32 0, !dbg !2089
  %2 = extractvalue %"class.aie::detail::vector_base" %call, 0, !dbg !2089
  store %struct.v8float %2, ptr %1, align 32, !dbg !2089
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #22, !dbg !2087
  %3 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !2087, !tbaa !1670
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #20, !dbg !2090
  ret %"class.aie::vector" %3, !dbg !2087
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2091 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2093, metadata !DIExpression()), !dbg !2095
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this1) #22, !dbg !2096
  ret void, !dbg !2097
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z26broadcast_zero_to_v16floatv() addrspace(1) #6 comdat {
entry:
  %custom_type.tmp = alloca %struct.v16float, align 32
  %agg.tmp = alloca %struct.v16int32, align 32
  %call = call addrspace(1) %struct.v16int32 @_Z13broadcast_s32i(i32 0) #24
  %0 = getelementptr inbounds %struct.v16int32, ptr %agg.tmp, i32 0, i32 0
  %1 = extractvalue %struct.v16int32 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32
  %2 = load %struct.v16int32, ptr %agg.tmp, align 32, !tbaa !2072
  call addrspace(1) void @_ZN8v16floatC2E8v16int32(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16int32 %2) #25
  %3 = load %struct.v16float, ptr %custom_type.tmp, align 32, !tbaa !2072
  ret %struct.v16float %3
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16float %v.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2098 {
entry:
  %v = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16float %v.coerce, ptr %v, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2100, metadata !DIExpression()), !dbg !2102
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !2101, metadata !DIExpression()), !dbg !2103
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load %struct.v16float, ptr %v, align 32, !dbg !2104, !tbaa !2072
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this1, %struct.v16float %0) #22, !dbg !2104
  ret void, !dbg !2105
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZN3aie6detail14vector_storageIfLj16EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !2106 {
entry:
  %retval = alloca %struct.v16float, align 32
  %call = call addrspace(1) %struct.v16float @_Z14undef_v16floatv() #22, !dbg !2107
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !2107
  %1 = extractvalue %struct.v16float %call, 0, !dbg !2107
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !2107
  %2 = load %struct.v16float, ptr %retval, align 32, !dbg !2108
  ret %struct.v16float %2, !dbg !2108
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z14undef_v16floatv() addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_undef_v16float() #23
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0
  %1 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32
  %2 = load %struct.v16float, ptr %retval, align 32
  ret %struct.v16float %2
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16float @__regcall3__chessintr_v16float_undef_v16float() addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16int32 @_Z13broadcast_s32i(i32 %a0) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16int32, align 32
  %a0.addr = alloca i32, align 4
  store i32 %a0, ptr %a0.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %a0.addr, align 4, !tbaa !1721
  %call = call x86_regcallcc addrspace(1) %struct.v16int32 @__regcall3__chessintr_v16int32_broadcast_s32___sint(i32 signext %0) #23
  %1 = getelementptr inbounds %struct.v16int32, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v16int32 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32
  %3 = load %struct.v16int32, ptr %retval, align 32
  ret %struct.v16int32 %3
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN8v16floatC2E8v16int32(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16int32 %a0.coerce) unnamed_addr addrspace(1) #16 comdat align 2 {
entry:
  %a0 = alloca %struct.v16int32, align 32
  %this.addr = alloca ptr, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.v128int4.v128int4, align 32
  %agg.tmp = alloca %struct.v16float, align 32
  store %struct.v16int32 %a0.coerce, ptr %a0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v16float, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v128int4.v128int4, ptr %custom_type.tmp, align 32, !tbaa !2072
  store %struct.ipd.custom_type.v128int4.v128int4 %0, ptr %mw, align 32, !tbaa !2072
  %1 = load %struct.v16int32, ptr %a0, align 32, !tbaa !2072
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_v16float_v16int32(%struct.v16int32 %1) #23
  %2 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  %4 = load %struct.v16float, ptr %agg.tmp, align 32, !tbaa !2072
  store %struct.v16float %4, ptr %this1, align 32, !tbaa !2072
  ret void
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16int32 @__regcall3__chessintr_v16int32_broadcast_s32___sint(i32 signext) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16float @__regcall3__chessintr_v16float_v16float_v16int32(%struct.v16int32) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2109 {
entry:
  %retval = alloca %"class.aie::detail::vector_base", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2114, metadata !DIExpression()), !dbg !2117
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2116, metadata !DIExpression()), !dbg !2118
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !2119

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2120, !tbaa !1721
  %cmp = icmp ult i32 %0, 2, !dbg !2120
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !2120
  br i1 %1, label %if.then, label %if.else, !dbg !2123

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !2124

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !2126, !tbaa !1721
  %cmp3 = icmp ult i32 %2, 2, !dbg !2126
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !2126
  br i1 %3, label %if.end, label %if.then4, !dbg !2129

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !2130), !dbg !2126
  br label %if.end, !dbg !2126

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !2129

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !2124

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !2131, !tbaa !1721
  %cmp5 = icmp ult i32 %4, 2, !dbg !2131
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !2131
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !2123

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !2133, !tbaa !1721
  %call = call addrspace(1) %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this1, i32 %5) #22, !dbg !2134
  %6 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %retval, i32 0, i32 0, !dbg !2134
  %7 = extractvalue %"class.aie::detail::vector_base" %call, 0, !dbg !2134
  store %struct.v8float %7, ptr %6, align 32, !dbg !2134
  %8 = load %"class.aie::detail::vector_base", ptr %retval, align 32, !dbg !2135
  ret %"class.aie::detail::vector_base" %8, !dbg !2135
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %v) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2136 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2138, metadata !DIExpression()), !dbg !2140
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2139, metadata !DIExpression()), !dbg !2141
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2142, !tbaa !1512
  %1 = load %"class.aie::detail::vector_base", ptr %0, align 32, !dbg !2143, !tbaa !2144
  store %"class.aie::detail::vector_base" %1, ptr %this1, align 32, !dbg !2143, !tbaa !2144
  ret void, !dbg !2145
}

; Function Attrs: convergent nocallback nofree nosync nounwind willreturn memory(none)
declare i1 @llvm.is.constant.i1(i1) addrspace(1) #17

; Function Attrs: nounwind willreturn memory(none)
declare i1 @llvm.chess_manifest(i1) addrspace(1) #7

; Function Attrs: nounwind willreturn
declare void @llvm.chess_error(metadata) addrspace(1) #18

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2146 {
entry:
  %retval = alloca %"class.aie::detail::vector_base", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %output_bits = alloca i32, align 4
  %agg.tmp = alloca %struct.v8float, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2150, metadata !DIExpression()), !dbg !2153
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2151, metadata !DIExpression()), !dbg !2154
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %output_bits, align 4, !dbg !2155
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %output_bits) #20, !dbg !2155
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %output_bits, metadata !2152, metadata !DIExpression()), !dbg !2156
  store i32 256, ptr %output_bits, align 4, !dbg !2156, !tbaa !1721
  %data = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %this1, i32 0, i32 0, !dbg !2157
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2165, !tbaa !1721
  %call = call addrspace(1) %struct.v8float @_ZN3aie6detailL14vector_extractILj8E8v16floatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %data, i32 noundef %0) #22, !dbg !2166
  %1 = getelementptr inbounds %struct.v8float, ptr %agg.tmp, i32 0, i32 0, !dbg !2166
  %2 = extractvalue %struct.v8float %call, 0, !dbg !2166
  store %struct.ipd.custom_type.v64int4.v64int4 %2, ptr %1, align 32, !dbg !2166
  %3 = load %struct.v8float, ptr %agg.tmp, align 32, !dbg !2166, !tbaa !2167
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float(ptr nonnull align 32 dereferenceable(32) %retval, %struct.v8float %3) #22, !dbg !2166
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %output_bits) #20, !dbg !2168
  %4 = load %"class.aie::detail::vector_base", ptr %retval, align 32, !dbg !2168
  ret %"class.aie::detail::vector_base" %4, !dbg !2168
}

; Function Attrs: inlinehint mustprogress nounwind
define internal %struct.v8float @_ZN3aie6detailL14vector_extractILj8E8v16floatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %v, i32 noundef %idx) addrspace(1) #5 !dbg !2169 {
entry:
  %retval = alloca %struct.v8float, align 32
  %v.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2175, metadata !DIExpression()), !dbg !2179
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2176, metadata !DIExpression()), !dbg !2180
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2181, !tbaa !1512
  %1 = load i32, ptr %idx.addr, align 4, !dbg !2182, !tbaa !1721
  %2 = load %struct.v16float, ptr %0, align 32, !dbg !2183, !tbaa !2072
  %call = call addrspace(1) %struct.v8float @_Z15extract_v8float8v16floati(%struct.v16float %2, i32 %1) #22, !dbg !2183
  %3 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0, !dbg !2183
  %4 = extractvalue %struct.v8float %call, 0, !dbg !2183
  store %struct.ipd.custom_type.v64int4.v64int4 %4, ptr %3, align 32, !dbg !2183
  %5 = load %struct.v8float, ptr %retval, align 32, !dbg !2184
  ret %struct.v8float %5, !dbg !2184
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float(ptr nonnull align 32 dereferenceable(32) %this, %struct.v8float %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2185 {
entry:
  %data = alloca %struct.v8float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v8float %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2187, metadata !DIExpression()), !dbg !2189
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !2188, metadata !DIExpression()), !dbg !2190
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !2191
  %0 = load %struct.v8float, ptr %data, align 32, !dbg !2192, !tbaa !2167
  store %struct.v8float %0, ptr %data2, align 32, !dbg !2192, !tbaa !2167
  ret void, !dbg !2193
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_Z15extract_v8float8v16floati(%struct.v16float %a.coerce, i32 %idx) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8float, align 32
  %a = alloca %struct.v16float, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v16float %a.coerce, ptr %a, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1721
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v16float, ptr %a, align 32, !tbaa !2072
  %call = call addrspace(1) %struct.v8float @_ZN12me_primitive6ext_xlE8v16float(%struct.v16float %1) #24
  %2 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v8float %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %3, ptr %2, align 32
  br label %return

if.else:                                          ; preds = %entry
  %4 = load %struct.v16float, ptr %a, align 32, !tbaa !2072
  %call1 = call addrspace(1) %struct.v8float @_ZN12me_primitive6ext_xhE8v16float(%struct.v16float %4) #24
  %5 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0
  %6 = extractvalue %struct.v8float %call1, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %6, ptr %5, align 32
  br label %return

return:                                           ; preds = %if.else, %if.then
  %7 = load %struct.v8float, ptr %retval, align 32
  ret %struct.v8float %7
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_ZN12me_primitive6ext_xlE8v16float(%struct.v16float %a0.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v8float, align 32
  %a0 = alloca %struct.v16float, align 32
  store %struct.v16float %a0.coerce, ptr %a0, align 32
  %0 = load %struct.v16float, ptr %a0, align 32, !tbaa !2072
  %call = call x86_regcallcc addrspace(1) %struct.v8float @__regcall3__chessintr_v8float_ext_xl_v16float(%struct.v16float %0) #23
  %1 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v8float %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %2, ptr %1, align 32
  %3 = load %struct.v8float, ptr %retval, align 32
  ret %struct.v8float %3
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_ZN12me_primitive6ext_xhE8v16float(%struct.v16float %a0.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v8float, align 32
  %a0 = alloca %struct.v16float, align 32
  store %struct.v16float %a0.coerce, ptr %a0, align 32
  %0 = load %struct.v16float, ptr %a0, align 32, !tbaa !2072
  %call = call x86_regcallcc addrspace(1) %struct.v8float @__regcall3__chessintr_v8float_ext_xh_v16float(%struct.v16float %0) #23
  %1 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v8float %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %2, ptr %1, align 32
  %3 = load %struct.v8float, ptr %retval, align 32
  ret %struct.v8float %3
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8float @__regcall3__chessintr_v8float_ext_xl_v16float(%struct.v16float) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8float @__regcall3__chessintr_v8float_ext_xh_v16float(%struct.v16float) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %v, i32 %shift) addrspace(1) #6 comdat align 2 !dbg !2194 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %shift.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2197, metadata !DIExpression()), !dbg !2200
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2198, metadata !DIExpression()), !dbg !2201
  store i32 %shift, ptr %shift.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %shift.addr, metadata !2199, metadata !DIExpression()), !dbg !2202
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2203, !tbaa !1512
  %1 = load i32, ptr %shift.addr, align 4, !dbg !2204, !tbaa !1721
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %this1, ptr nonnull align 32 dereferenceable(32) %0, i32 %1) #22, !dbg !2205
  ret void, !dbg !2206
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %v, i32 %shift) addrspace(1) #6 comdat align 2 !dbg !2207 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %shift.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2212, metadata !DIExpression()), !dbg !2216
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2214, metadata !DIExpression()), !dbg !2217
  store i32 %shift, ptr %shift.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %shift.addr, metadata !2215, metadata !DIExpression()), !dbg !2218
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2219, !tbaa !1512
  %1 = load i32, ptr %shift.addr, align 4, !dbg !2220, !tbaa !1721
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE16from_vector_signIfEEvRKNS_6vectorIT_Lj8EEEbi(ptr nonnull align 32 dereferenceable(32) %this1, ptr nonnull align 32 dereferenceable(32) %0, i1 zeroext true, i32 %1) #22, !dbg !2221
  ret void, !dbg !2222
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE16from_vector_signIfEEvRKNS_6vectorIT_Lj8EEEbi(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %v, i1 zeroext %v_sign, i32 %shift) addrspace(1) #6 comdat align 2 !dbg !2223 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %v_sign.addr = alloca i8, align 1
  %shift.addr = alloca i32, align 4
  %fn = alloca %class.anon, align 1
  %agg.tmp = alloca %struct.v8accfloat, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2228, metadata !DIExpression()), !dbg !2242
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2229, metadata !DIExpression()), !dbg !2243
  %frombool = zext i1 %v_sign to i8
  store i8 %frombool, ptr %v_sign.addr, align 1, !tbaa !2244
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v_sign.addr, metadata !2230, metadata !DIExpression()), !dbg !2246
  store i32 %shift, ptr %shift.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %shift.addr, metadata !2231, metadata !DIExpression()), !dbg !2247
  %this1 = load ptr, ptr %this.addr, align 4
  store %class.anon undef, ptr %fn, align 1, !dbg !2248
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %fn) #20, !dbg !2248
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn, metadata !2232, metadata !DIExpression()), !dbg !2249
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 1 %fn, ptr align 1 @__const._ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE16from_vector_signIfEEvRKNS_6vectorIT_Lj8EEEbi.fn, i32 1, i1 false), !dbg !2249
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2250, !tbaa !1512
  %1 = load i32, ptr %shift.addr, align 4, !dbg !2252, !tbaa !1721
  %2 = load i8, ptr %v_sign.addr, align 1, !dbg !2253, !tbaa !2244, !range !2254, !noundef !137
  %tobool = trunc i8 %2 to i1, !dbg !2253
  %call = call addrspace(1) %struct.v8accfloat @_ZZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_upsIfLj8EEEDavENKUlRKT_T0_T1_E_clINS_6vectorIfLj8EEEibEEDaS7_S8_S9_(ptr nonnull align 1 dereferenceable(1) %fn, ptr nonnull align 32 dereferenceable(32) %0, i32 %1, i1 zeroext %tobool) #22, !dbg !2255
  %3 = getelementptr inbounds %struct.v8accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !2255
  %4 = extractvalue %struct.v8accfloat %call, 0, !dbg !2255
  store %struct.ipd.custom_type.v8acc32.v8acc32 %4, ptr %3, align 32, !dbg !2255
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !2256
  %5 = load %struct.v8accfloat, ptr %agg.tmp, align 32, !dbg !2257, !tbaa !2258
  store %struct.v8accfloat %5, ptr %data, align 32, !dbg !2257, !tbaa !2258
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %fn) #20, !dbg !2259
  ret void, !dbg !2260
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i32(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i32, i1 immarg) addrspace(1) #19

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_ZZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_upsIfLj8EEEDavENKUlRKT_T0_T1_E_clINS_6vectorIfLj8EEEibEEDaS7_S8_S9_(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 32 dereferenceable(32) %v, i32 %shift_dummy, i1 zeroext %sign_dummy) addrspace(1) #6 comdat align 2 !dbg !2261 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %shift_dummy.addr = alloca i32, align 4
  %sign_dummy.addr = alloca i8, align 1
  %custom_type.tmp = alloca %struct.v8accfloat, align 32
  %agg.tmp = alloca %struct.v8float, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2271, metadata !DIExpression()), !dbg !2276
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2273, metadata !DIExpression()), !dbg !2277
  store i32 %shift_dummy, ptr %shift_dummy.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %shift_dummy.addr, metadata !2274, metadata !DIExpression()), !dbg !2278
  %frombool = zext i1 %sign_dummy to i8
  store i8 %frombool, ptr %sign_dummy.addr, align 1, !tbaa !2244
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sign_dummy.addr, metadata !2275, metadata !DIExpression()), !dbg !2279
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2280, !tbaa !1512
  %call = call addrspace(1) %struct.v8float @_ZNK3aie6vectorIfLj8EEcv7v8floatEv(ptr nonnull align 32 dereferenceable(32) %0) #22, !dbg !2281
  %1 = getelementptr inbounds %struct.v8float, ptr %agg.tmp, i32 0, i32 0, !dbg !2281
  %2 = extractvalue %struct.v8float %call, 0, !dbg !2281
  store %struct.ipd.custom_type.v64int4.v64int4 %2, ptr %1, align 32, !dbg !2281
  %3 = load %struct.v8float, ptr %agg.tmp, align 32, !dbg !2282, !tbaa !2167
  call addrspace(1) void @_ZN10v8accfloatC2E7v8float(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, %struct.v8float %3) #25, !dbg !2282
  %4 = load %struct.v8accfloat, ptr %custom_type.tmp, align 32, !dbg !2282, !tbaa !2258
  ret %struct.v8accfloat %4, !dbg !2282
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_ZNK3aie6vectorIfLj8EEcv7v8floatEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !2283 {
entry:
  %retval = alloca %struct.v8float, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2285, metadata !DIExpression()), !dbg !2287
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v8float @_ZNK3aie6vectorIfLj8EE9to_nativeEv(ptr nonnull align 32 dereferenceable(32) %this1) #22, !dbg !2288
  %0 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0, !dbg !2288
  %1 = extractvalue %struct.v8float %call, 0, !dbg !2288
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32, !dbg !2288
  %2 = load %struct.v8float, ptr %retval, align 32, !dbg !2289
  ret %struct.v8float %2, !dbg !2289
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN10v8accfloatC2E7v8float(ptr nonnull align 32 dereferenceable(32) %this, %struct.v8float %a0.coerce) unnamed_addr addrspace(1) #16 comdat align 2 {
entry:
  %a0 = alloca %struct.v8float, align 32
  %this.addr = alloca ptr, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.v8acc32.v8acc32, align 32
  %agg.tmp = alloca %struct.v8accfloat, align 32
  store %struct.v8float %a0.coerce, ptr %a0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v8accfloat, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v8acc32.v8acc32, ptr %custom_type.tmp, align 32, !tbaa !2258
  store %struct.ipd.custom_type.v8acc32.v8acc32 %0, ptr %mw, align 32, !tbaa !2258
  %1 = load %struct.v8float, ptr %a0, align 32, !tbaa !2167
  %call = call x86_regcallcc addrspace(1) %struct.v8accfloat @__regcall3__chessintr_v8accfloat_v8accfloat_v8float(%struct.v8float %1) #23
  %2 = getelementptr inbounds %struct.v8accfloat, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v8accfloat %call, 0
  store %struct.ipd.custom_type.v8acc32.v8acc32 %3, ptr %2, align 32
  %4 = load %struct.v8accfloat, ptr %agg.tmp, align 32, !tbaa !2258
  store %struct.v8accfloat %4, ptr %this1, align 32, !tbaa !2258
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_ZNK3aie6vectorIfLj8EE9to_nativeEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !2290 {
entry:
  %retval = alloca %struct.v8float, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2292, metadata !DIExpression()), !dbg !2293
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v8float @_ZNK3aie6detail11vector_baseIfLj8EE9to_nativeEv(ptr nonnull align 32 dereferenceable(32) %this1) #22, !dbg !2294
  %0 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0, !dbg !2294
  %1 = extractvalue %struct.v8float %call, 0, !dbg !2294
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32, !dbg !2294
  %2 = load %struct.v8float, ptr %retval, align 32, !dbg !2295
  ret %struct.v8float %2, !dbg !2295
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_ZNK3aie6detail11vector_baseIfLj8EE9to_nativeEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !2296 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2298, metadata !DIExpression()), !dbg !2300
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !2301
  %0 = load %struct.v8float, ptr %data, align 32, !dbg !2301, !tbaa !2167
  ret %struct.v8float %0, !dbg !2301
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8accfloat @__regcall3__chessintr_v8accfloat_v8accfloat_v8float(%struct.v8float) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"class.aie::vector_elem_ref" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !2303 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"class.aie::vector_elem_ref", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.aie::unary_op.2", align 4
  store %"class.aie::vector_elem_ref" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2317, metadata !DIExpression()), !dbg !2322
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2318, metadata !DIExpression()), !dbg !2323
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2319, metadata !DIExpression()), !dbg !2324
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2325, !tbaa !1512
  %call = call addrspace(1) %"struct.aie::unary_op.2" @_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 4 dereferenceable(8) %a) #22, !dbg !2330
  %1 = getelementptr inbounds %"struct.aie::unary_op.2", ptr %agg.tmp, i32 0, i32 0, !dbg !2330
  %2 = extractvalue %"struct.aie::unary_op.2" %call, 0, !dbg !2330
  store %"struct.aie::unary_op_common.3" %2, ptr %1, align 4, !dbg !2330
  %3 = load ptr, ptr %v.addr, align 4, !dbg !2331, !tbaa !1512
  %4 = load %"struct.aie::unary_op.2", ptr %agg.tmp, align 4, !dbg !2332, !tbaa !2333
  %call1 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %0, %"struct.aie::unary_op.2" %4, ptr nonnull align 32 dereferenceable(32) %3) #22, !dbg !2332
  %5 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2332
  %6 = extractvalue %"class.aie::accum" %call1, 0, !dbg !2332
  store %"class.aie::detail::accum_base" %6, ptr %5, align 32, !dbg !2332
  %7 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2336
  ret %"class.aie::accum" %7, !dbg !2336
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"struct.aie::unary_op" @_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_(ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat !dbg !2337 {
entry:
  %retval = alloca %"struct.aie::unary_op", align 32
  %acc.addr = alloca ptr, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2341, metadata !DIExpression()), !dbg !2343
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2344, !tbaa !1512
  %1 = load %"class.aie::accum", ptr %0, align 32, !dbg !2345, !tbaa !1684
  call addrspace(1) void @_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_(ptr nonnull align 32 dereferenceable(32) %retval, %"class.aie::accum" noundef %1) #22, !dbg !2345
  %2 = load %"struct.aie::unary_op", ptr %retval, align 32, !dbg !2346
  ret %"struct.aie::unary_op" %2, !dbg !2346
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"struct.aie::unary_op.2" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !2347 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"struct.aie::unary_op.2", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.aie::unary_op.2", align 4
  %ref.tmp = alloca %"struct.aie::unary_op.4", align 32
  store %"struct.aie::unary_op.2" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2351, metadata !DIExpression()), !dbg !2356
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2352, metadata !DIExpression()), !dbg !2357
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2353, metadata !DIExpression()), !dbg !2358
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2359, !tbaa !1512
  %1 = load %"struct.aie::unary_op.2", ptr %a, align 4, !dbg !2365, !tbaa !2333
  store %"struct.aie::unary_op.2" %1, ptr %agg.tmp, align 4, !dbg !2365, !tbaa !2333
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #20, !dbg !2366
  %2 = load ptr, ptr %v.addr, align 4, !dbg !2367, !tbaa !1512
  %call = call addrspace(1) %"struct.aie::unary_op.4" @_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 32 dereferenceable(32) %2) #22, !dbg !2366
  %3 = getelementptr inbounds %"struct.aie::unary_op.4", ptr %ref.tmp, i32 0, i32 0, !dbg !2366
  %4 = extractvalue %"struct.aie::unary_op.4" %call, 0, !dbg !2366
  store %"struct.aie::unary_op_common.5" %4, ptr %3, align 32, !dbg !2366
  %5 = load %"struct.aie::unary_op.2", ptr %agg.tmp, align 4, !dbg !2368, !tbaa !2333
  %call1 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %0, %"struct.aie::unary_op.2" %5, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #22, !dbg !2368
  %6 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2368
  %7 = extractvalue %"class.aie::accum" %call1, 0, !dbg !2368
  store %"class.aie::detail::accum_base" %7, ptr %6, align 32, !dbg !2368
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #20, !dbg !2369
  %8 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2369
  ret %"class.aie::accum" %8, !dbg !2369
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"struct.aie::unary_op.2" @_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 4 dereferenceable(8) %e) addrspace(1) #6 comdat !dbg !2370 {
entry:
  %retval = alloca %"struct.aie::unary_op.2", align 4
  %e.addr = alloca ptr, align 4
  %agg.tmp = alloca %"class.aie::vector_elem_ref", align 4
  store ptr %e, ptr %e.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %e.addr, metadata !2374, metadata !DIExpression()), !dbg !2375
  %0 = load ptr, ptr %e.addr, align 4, !dbg !2376, !tbaa !1512
  %1 = load %"class.aie::vector_elem_ref", ptr %0, align 4, !dbg !2376, !tbaa !1780
  store %"class.aie::vector_elem_ref" %1, ptr %agg.tmp, align 4, !dbg !2376, !tbaa !1780
  %2 = load %"class.aie::vector_elem_ref", ptr %agg.tmp, align 4, !dbg !2377, !tbaa !1780
  call addrspace(1) void @_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 4 dereferenceable(8) %retval, %"class.aie::vector_elem_ref" noundef %2) #22, !dbg !2377
  %3 = load %"struct.aie::unary_op.2", ptr %retval, align 4, !dbg !2378
  ret %"struct.aie::unary_op.2" %3, !dbg !2378
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"struct.aie::unary_op.2" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !2379 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"struct.aie::unary_op.2", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %Op1 = alloca i32, align 4
  %Op2 = alloca i32, align 4
  %agg.tmp = alloca %"class.aie::vector_elem_const_ref", align 4
  %ref.tmp = alloca %"class.aie::vector_elem_ref", align 4
  %agg.tmp1 = alloca %"struct.aie::unary_op.2", align 4
  %ref.tmp3 = alloca %"class.aie::vector", align 32
  %agg.tmp5 = alloca %"struct.aie::unary_op.4", align 32
  %ref.tmp7 = alloca %"class.aie::accum", align 32
  store %"struct.aie::unary_op.2" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2384, metadata !DIExpression()), !dbg !2401
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2385, metadata !DIExpression()), !dbg !2402
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2386, metadata !DIExpression()), !dbg !2403
  store i32 undef, ptr %Op1, align 4, !dbg !2404
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %Op1) #20, !dbg !2404
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %Op1, metadata !2387, metadata !DIExpression()), !dbg !2405
  store i32 0, ptr %Op1, align 4, !dbg !2405, !tbaa !2406
  store i32 undef, ptr %Op2, align 4, !dbg !2408
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %Op2) #20, !dbg !2408
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %Op2, metadata !2398, metadata !DIExpression()), !dbg !2409
  store i32 0, ptr %Op2, align 4, !dbg !2409, !tbaa !2406
  call addrspace(1) void @llvm.lifetime.start.p0(i64 8, ptr %ref.tmp) #20, !dbg !2410
  %call = call addrspace(1) %"class.aie::vector_elem_ref" @_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 4 dereferenceable(8) %a) #22, !dbg !2412
  %0 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %ref.tmp, i32 0, i32 0, !dbg !2412
  %1 = extractvalue %"class.aie::vector_elem_ref" %call, 0, !dbg !2412
  store ptr %1, ptr %0, align 4, !dbg !2412
  %2 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %ref.tmp, i32 0, i32 1, !dbg !2412
  %3 = extractvalue %"class.aie::vector_elem_ref" %call, 1, !dbg !2412
  store i32 %3, ptr %2, align 4, !dbg !2412
  call addrspace(1) void @_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE(ptr nonnull align 4 dereferenceable(8) %agg.tmp, ptr nonnull align 4 dereferenceable(8) %ref.tmp) #22, !dbg !2413
  %4 = load %"struct.aie::unary_op.2", ptr %a, align 4, !dbg !2414, !tbaa !2333
  store %"struct.aie::unary_op.2" %4, ptr %agg.tmp1, align 4, !dbg !2414, !tbaa !2333
  %5 = load %"struct.aie::unary_op.2", ptr %agg.tmp1, align 4, !dbg !2415, !tbaa !2333
  %call2 = call zeroext addrspace(1) i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.2" %5) #22, !dbg !2415
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp3) #20, !dbg !2416
  %6 = load ptr, ptr %v.addr, align 4, !dbg !2416, !tbaa !1512
  %call4 = call addrspace(1) %"class.aie::vector" @_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %6) #22, !dbg !2417
  %7 = getelementptr inbounds %"class.aie::vector", ptr %ref.tmp3, i32 0, i32 0, !dbg !2417
  %8 = extractvalue %"class.aie::vector" %call4, 0, !dbg !2417
  store %"class.aie::detail::vector_base" %8, ptr %7, align 32, !dbg !2417
  %9 = load ptr, ptr %v.addr, align 4, !dbg !2418, !tbaa !1512
  %10 = load %"struct.aie::unary_op.4", ptr %9, align 32, !dbg !2418, !tbaa !2419
  store %"struct.aie::unary_op.4" %10, ptr %agg.tmp5, align 32, !dbg !2418, !tbaa !2419
  %11 = load %"struct.aie::unary_op.4", ptr %agg.tmp5, align 32, !dbg !2422, !tbaa !2419
  %call6 = call zeroext addrspace(1) i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.4" %11) #22, !dbg !2422
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp7) #20, !dbg !2423
  %12 = load ptr, ptr %acc.addr, align 4, !dbg !2423, !tbaa !1512
  %call8 = call addrspace(1) %"class.aie::accum" @_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %12) #22, !dbg !2424
  %13 = getelementptr inbounds %"class.aie::accum", ptr %ref.tmp7, i32 0, i32 0, !dbg !2424
  %14 = extractvalue %"class.aie::accum" %call8, 0, !dbg !2424
  store %"class.aie::detail::accum_base" %14, ptr %13, align 32, !dbg !2424
  %15 = load %"class.aie::vector_elem_const_ref", ptr %agg.tmp, align 4, !dbg !2425, !tbaa !2426
  %call9 = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_(%"class.aie::vector_elem_const_ref" %15, i1 zeroext %call2, ptr nonnull align 32 dereferenceable(32) %ref.tmp3, i1 zeroext %call6, ptr nonnull align 32 dereferenceable(32) %ref.tmp7) #22, !dbg !2425
  %16 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2425
  %17 = extractvalue %"class.aie::accum" %call9, 0, !dbg !2425
  store %"class.aie::detail::accum_base" %17, ptr %16, align 32, !dbg !2425
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp7) #20, !dbg !2428
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp3) #20, !dbg !2428
  call addrspace(1) void @llvm.lifetime.end.p0(i64 8, ptr %ref.tmp) #20, !dbg !2428
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %Op2) #20, !dbg !2429
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %Op1) #20, !dbg !2429
  %18 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2430
  ret %"class.aie::accum" %18, !dbg !2430
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"struct.aie::unary_op.4" @_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 32 dereferenceable(32) %e) addrspace(1) #6 comdat !dbg !2431 {
entry:
  %retval = alloca %"struct.aie::unary_op.4", align 32
  %e.addr = alloca ptr, align 4
  store ptr %e, ptr %e.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %e.addr, metadata !2435, metadata !DIExpression()), !dbg !2436
  %0 = load ptr, ptr %e.addr, align 4, !dbg !2437, !tbaa !1512
  %1 = load %"class.aie::vector", ptr %0, align 32, !dbg !2438, !tbaa !1670
  call addrspace(1) void @_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 32 dereferenceable(32) %retval, %"class.aie::vector" noundef %1) #22, !dbg !2438
  %2 = load %"struct.aie::unary_op.4", ptr %retval, align 32, !dbg !2439
  ret %"struct.aie::unary_op.4" %2, !dbg !2439
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_(%"class.aie::vector_elem_const_ref" %a.coerce, i1 zeroext %a_sign, ptr nonnull align 32 dereferenceable(32) %v, i1 zeroext %v_sign, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2440 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"class.aie::vector_elem_const_ref", align 4
  %a_sign.addr = alloca i8, align 1
  %v.addr = alloca ptr, align 4
  %v_sign.addr = alloca i8, align 1
  %acc.addr = alloca ptr, align 4
  store %"class.aie::vector_elem_const_ref" %a.coerce, ptr %a, align 4
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2464, metadata !DIExpression()), !dbg !2469
  %frombool = zext i1 %a_sign to i8
  store i8 %frombool, ptr %a_sign.addr, align 1, !tbaa !2244
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a_sign.addr, metadata !2465, metadata !DIExpression()), !dbg !2470
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2466, metadata !DIExpression()), !dbg !2471
  %frombool1 = zext i1 %v_sign to i8
  store i8 %frombool1, ptr %v_sign.addr, align 1, !tbaa !2244
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v_sign.addr, metadata !2467, metadata !DIExpression()), !dbg !2472
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2468, metadata !DIExpression()), !dbg !2473
  %call = call noundef addrspace(1) float @_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv(ptr nonnull align 4 dereferenceable(8) %a) #22, !dbg !2474
  %0 = load i8, ptr %a_sign.addr, align 1, !dbg !2475, !tbaa !2244, !range !2254, !noundef !137
  %tobool = trunc i8 %0 to i1, !dbg !2475
  %1 = load ptr, ptr %v.addr, align 4, !dbg !2476, !tbaa !1512
  %2 = load i8, ptr %v_sign.addr, align 1, !dbg !2477, !tbaa !2244, !range !2254, !noundef !137
  %tobool2 = trunc i8 %2 to i1, !dbg !2477
  %3 = load ptr, ptr %acc.addr, align 4, !dbg !2478, !tbaa !1512
  %call3 = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_(float %call, i1 zeroext %tobool, ptr nonnull align 32 dereferenceable(32) %1, i1 zeroext %tobool2, ptr nonnull align 32 dereferenceable(32) %3) #22, !dbg !2479
  %4 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2479
  %5 = extractvalue %"class.aie::accum" %call3, 0, !dbg !2479
  store %"class.aie::detail::accum_base" %5, ptr %4, align 32, !dbg !2479
  %6 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2480
  ret %"class.aie::accum" %6, !dbg !2480
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector_elem_ref" @_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #6 comdat align 2 !dbg !2481 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2488, metadata !DIExpression()), !dbg !2490
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.3", ptr %this1, i32 0, i32 0, !dbg !2491
  %0 = load %"class.aie::vector_elem_ref", ptr %parent_, align 4, !dbg !2491, !tbaa !1780
  ret %"class.aie::vector_elem_ref" %0, !dbg !2491
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE(ptr nonnull align 4 dereferenceable(8) %this, ptr nonnull align 4 dereferenceable(8) %ref) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !2493 {
entry:
  %this.addr = alloca ptr, align 4
  %ref.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2495, metadata !DIExpression()), !dbg !2498
  store ptr %ref, ptr %ref.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ref.addr, metadata !2497, metadata !DIExpression()), !dbg !2499
  %this1 = load ptr, ptr %this.addr, align 4
  %parent = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 0, !dbg !2500
  %0 = load ptr, ptr %ref.addr, align 4, !dbg !2501, !tbaa !1512
  %parent2 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %0, i32 0, i32 0, !dbg !2502
  %1 = load ptr, ptr %parent2, align 4, !dbg !2502, !tbaa !2503
  store ptr %1, ptr %parent, align 4, !dbg !2500, !tbaa !1512
  %offset = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 1, !dbg !2504
  %2 = load ptr, ptr %ref.addr, align 4, !dbg !2505, !tbaa !1512
  %offset3 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %2, i32 0, i32 1, !dbg !2506
  %3 = load i32, ptr %offset3, align 4, !dbg !2506, !tbaa !2507
  store i32 %3, ptr %offset, align 4, !dbg !2504, !tbaa !2508
  ret void, !dbg !2509
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local zeroext i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.2" %v.coerce) addrspace(1) #6 comdat !dbg !2510 {
entry:
  %v = alloca %"struct.aie::unary_op.2", align 4
  store %"struct.aie::unary_op.2" %v.coerce, ptr %v, align 4
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !2514, metadata !DIExpression()), !dbg !2517
  ret i1 true, !dbg !2518
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !2520 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2527, metadata !DIExpression()), !dbg !2529
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.5", ptr %this1, i32 0, i32 0, !dbg !2530
  %0 = load %"class.aie::vector", ptr %parent_, align 32, !dbg !2530, !tbaa !1670
  ret %"class.aie::vector" %0, !dbg !2530
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local zeroext i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.4" %v.coerce) addrspace(1) #6 comdat !dbg !2532 {
entry:
  %v = alloca %"struct.aie::unary_op.4", align 32
  store %"struct.aie::unary_op.4" %v.coerce, ptr %v, align 32
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !2536, metadata !DIExpression()), !dbg !2539
  ret i1 true, !dbg !2540
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !2542 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2549, metadata !DIExpression()), !dbg !2551
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common", ptr %this1, i32 0, i32 0, !dbg !2552
  %0 = load %"class.aie::accum", ptr %parent_, align 32, !dbg !2552, !tbaa !1684
  ret %"class.aie::accum" %0, !dbg !2552
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_(float %a, i1 zeroext %a_sign, ptr nonnull align 32 dereferenceable(32) %v, i1 zeroext %v_sign, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2554 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a.addr = alloca float, align 4
  %a_sign.addr = alloca i8, align 1
  %v.addr = alloca ptr, align 4
  %v_sign.addr = alloca i8, align 1
  %acc.addr = alloca ptr, align 4
  %ref.tmp = alloca %"class.aie::vector", align 32
  store float %a, ptr %a.addr, align 4, !tbaa !2569
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !2564, metadata !DIExpression()), !dbg !2571
  %frombool = zext i1 %a_sign to i8
  store i8 %frombool, ptr %a_sign.addr, align 1, !tbaa !2244
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a_sign.addr, metadata !2565, metadata !DIExpression()), !dbg !2572
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2566, metadata !DIExpression()), !dbg !2573
  %frombool1 = zext i1 %v_sign to i8
  store i8 %frombool1, ptr %v_sign.addr, align 1, !tbaa !2244
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v_sign.addr, metadata !2567, metadata !DIExpression()), !dbg !2574
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2568, metadata !DIExpression()), !dbg !2575
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #20, !dbg !2576
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a.addr) #22, !dbg !2576
  %0 = getelementptr inbounds %"class.aie::vector", ptr %ref.tmp, i32 0, i32 0, !dbg !2576
  %1 = extractvalue %"class.aie::vector" %call, 0, !dbg !2576
  store %"class.aie::detail::vector_base" %1, ptr %0, align 32, !dbg !2576
  %2 = load i8, ptr %a_sign.addr, align 1, !dbg !2577, !tbaa !2244, !range !2254, !noundef !137
  %tobool = trunc i8 %2 to i1, !dbg !2577
  %3 = load ptr, ptr %v.addr, align 4, !dbg !2578, !tbaa !1512
  %4 = load i8, ptr %v_sign.addr, align 1, !dbg !2579, !tbaa !2244, !range !2254, !noundef !137
  %tobool2 = trunc i8 %4 to i1, !dbg !2579
  %5 = load ptr, ptr %acc.addr, align 4, !dbg !2580, !tbaa !1512
  %call3 = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_(ptr nonnull align 32 dereferenceable(32) %ref.tmp, i1 zeroext %tobool, ptr nonnull align 32 dereferenceable(32) %3, i1 zeroext %tobool2, ptr nonnull align 32 dereferenceable(32) %5) #22, !dbg !2581
  %6 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2581
  %7 = extractvalue %"class.aie::accum" %call3, 0, !dbg !2581
  store %"class.aie::detail::accum_base" %7, ptr %6, align 32, !dbg !2581
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #20, !dbg !2582
  %8 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2582
  ret %"class.aie::accum" %8, !dbg !2582
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local noundef float @_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #9 comdat align 2 !dbg !2583 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2585, metadata !DIExpression()), !dbg !2587
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call noundef addrspace(1) float @_ZNK3aie21vector_elem_const_refIfLj8EE3getEv(ptr nonnull align 4 dereferenceable(8) %this1) #22, !dbg !2588
  ret float %call, !dbg !2589
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_(ptr nonnull align 32 dereferenceable(32) %v1, i1 zeroext %v1_sign, ptr nonnull align 32 dereferenceable(32) %v2, i1 zeroext %v2_sign, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2590 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %v1.addr = alloca ptr, align 4
  %v1_sign.addr = alloca i8, align 1
  %v2.addr = alloca ptr, align 4
  %v2_sign.addr = alloca i8, align 1
  %acc.addr = alloca ptr, align 4
  %mul_op = alloca %class.anon.6, align 1
  %num_mul = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::accum", align 32
  %ref.tmp = alloca %class.anon.8, align 4
  store ptr %v1, ptr %v1.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1.addr, metadata !2595, metadata !DIExpression()), !dbg !2605
  %frombool = zext i1 %v1_sign to i8
  store i8 %frombool, ptr %v1_sign.addr, align 1, !tbaa !2244
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1_sign.addr, metadata !2596, metadata !DIExpression()), !dbg !2606
  store ptr %v2, ptr %v2.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2.addr, metadata !2597, metadata !DIExpression()), !dbg !2607
  %frombool1 = zext i1 %v2_sign to i8
  store i8 %frombool1, ptr %v2_sign.addr, align 1, !tbaa !2244
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2_sign.addr, metadata !2598, metadata !DIExpression()), !dbg !2608
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2599, metadata !DIExpression()), !dbg !2609
  store %class.anon.6 undef, ptr %mul_op, align 1, !dbg !2610
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %mul_op) #20, !dbg !2610
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mul_op, metadata !2600, metadata !DIExpression()), !dbg !2611
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 1 %mul_op, ptr align 1 @__const._ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_.mul_op, i32 1, i1 false), !dbg !2611
  store i32 undef, ptr %num_mul, align 4, !dbg !2612
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_mul) #20, !dbg !2612
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_mul, metadata !2603, metadata !DIExpression()), !dbg !2613
  store i32 1, ptr %num_mul, align 4, !dbg !2613, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2604, metadata !DIExpression()), !dbg !2614
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #22, !dbg !2614
  %0 = load %"class.aie::accum", ptr %custom_type.tmp, align 32, !dbg !2614, !tbaa !1684
  store %"class.aie::accum" %0, ptr %retval, align 32, !dbg !2614, !tbaa !1684
  call addrspace(1) void @llvm.lifetime.start.p0(i64 20, ptr %ref.tmp) #20, !dbg !2615
  %1 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 0, !dbg !2615
  store ptr %mul_op, ptr %1, align 4, !dbg !2615, !tbaa !1512
  %2 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 1, !dbg !2615
  %3 = load ptr, ptr %v1.addr, align 4, !dbg !2616, !tbaa !1512
  store ptr %3, ptr %2, align 4, !dbg !2615, !tbaa !1512
  %4 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 2, !dbg !2615
  %5 = load ptr, ptr %v2.addr, align 4, !dbg !2616, !tbaa !1512
  store ptr %5, ptr %4, align 4, !dbg !2615, !tbaa !1512
  %6 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 3, !dbg !2615
  %7 = load ptr, ptr %acc.addr, align 4, !dbg !2616, !tbaa !1512
  store ptr %7, ptr %6, align 4, !dbg !2615, !tbaa !1512
  %8 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 4, !dbg !2615
  store ptr %retval, ptr %8, align 4, !dbg !2615, !tbaa !1512
  call addrspace(1) void @_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_(ptr nonnull align 4 dereferenceable(20) %ref.tmp) #22, !dbg !2617
  call addrspace(1) void @llvm.lifetime.end.p0(i64 20, ptr %ref.tmp) #20, !dbg !2617
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_mul) #20, !dbg !2618
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %mul_op) #20, !dbg !2618
  %9 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2618
  ret %"class.aie::accum" %9, !dbg !2618
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a) addrspace(1) #9 comdat align 2 !dbg !2619 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %a.addr = alloca ptr, align 4
  store ptr %a, ptr %a.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !2628, metadata !DIExpression()), !dbg !2629
  %0 = load ptr, ptr %a.addr, align 4, !dbg !2630, !tbaa !1512
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %0) #22, !dbg !2631
  %1 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !2631
  %2 = extractvalue %"class.aie::vector" %call, 0, !dbg !2631
  store %"class.aie::detail::vector_base" %2, ptr %1, align 32, !dbg !2631
  %3 = load %"class.aie::vector", ptr %retval, align 32, !dbg !2632
  ret %"class.aie::vector" %3, !dbg !2632
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat !dbg !2633 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2648, metadata !DIExpression()), !dbg !2652
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !2653, !tbaa !1512
  call addrspace(1) void @_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_(ptr nonnull align 4 dereferenceable(20) %0) #22, !dbg !2654
  ret void, !dbg !2655
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat !dbg !2656 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2658, metadata !DIExpression()), !dbg !2664
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !2665, !tbaa !1512
  call addrspace(1) void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %0) #22, !dbg !2666
  ret void, !dbg !2667
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat align 2 !dbg !2668 {
entry:
  %fn.addr = alloca ptr, align 4
  %it = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %agg.tmp = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %next_it = alloca i32, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2675, metadata !DIExpression()), !dbg !2691
  store %"struct.aie::detail::utils::iteration_dim" undef, ptr %it, align 1, !dbg !2692
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %it) #20, !dbg !2692
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %it, metadata !2676, metadata !DIExpression()), !dbg !2693
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 1 %it, ptr align 1 @__const._ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_.it, i32 1, i1 false), !dbg !2693
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !2694, !tbaa !1512
  call addrspace(1) void @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_(ptr nonnull align 4 dereferenceable(20) %0) #22, !dbg !2694
  store i32 undef, ptr %next_it, align 4, !dbg !2696
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %next_it) #20, !dbg !2696
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %next_it, metadata !2690, metadata !DIExpression()), !dbg !2697
  store i32 1, ptr %next_it, align 4, !dbg !2697, !tbaa !1721
  %1 = load ptr, ptr %fn.addr, align 4, !dbg !2698, !tbaa !1512
  call addrspace(1) void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %1) #22, !dbg !2699
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %next_it) #20, !dbg !2700
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %it) #20, !dbg !2700
  ret void, !dbg !2701
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_(ptr nonnull align 4 dereferenceable(20) %this) addrspace(1) #6 comdat align 2 !dbg !2702 {
entry:
  %idx = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %this.addr = alloca ptr, align 4
  %tmp = alloca %"class.aie::accum.9", align 32
  %custom_type.tmp = alloca %"class.aie::accum.9", align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %ref.tmp = alloca %"class.aie::vector.0", align 32
  %ref.tmp3 = alloca %"class.aie::vector.0", align 32
  %ref.tmp6 = alloca %"class.aie::accum.9", align 32
  %ref.tmp11 = alloca %"class.aie::accum", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2711, metadata !DIExpression()), !dbg !2717
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx, metadata !2713, metadata !DIExpression()), !dbg !2718
  %this1 = load ptr, ptr %this.addr, align 4
  store %"class.aie::accum.9" undef, ptr %tmp, align 32, !dbg !2719
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %tmp) #20, !dbg !2719
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %tmp, metadata !2714, metadata !DIExpression()), !dbg !2720
  %0 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 0, !dbg !2721
  %1 = load ptr, ptr %0, align 4, !dbg !2721, !tbaa !2722
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #20, !dbg !2724
  %2 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 1, !dbg !2724
  %3 = load ptr, ptr %2, align 4, !dbg !2724, !tbaa !2725
  %call = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #22, !dbg !2726
  %call2 = call addrspace(1) %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %3, i32 %call) #22, !dbg !2727
  %4 = getelementptr inbounds %"class.aie::vector.0", ptr %ref.tmp, i32 0, i32 0, !dbg !2727
  %5 = extractvalue %"class.aie::vector.0" %call2, 0, !dbg !2727
  store %"class.aie::detail::vector_base.1" %5, ptr %4, align 32, !dbg !2727
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp3) #20, !dbg !2728
  %6 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 2, !dbg !2728
  %7 = load ptr, ptr %6, align 4, !dbg !2728, !tbaa !2729
  %call4 = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #22, !dbg !2730
  %call5 = call addrspace(1) %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %7, i32 %call4) #22, !dbg !2731
  %8 = getelementptr inbounds %"class.aie::vector.0", ptr %ref.tmp3, i32 0, i32 0, !dbg !2731
  %9 = extractvalue %"class.aie::vector.0" %call5, 0, !dbg !2731
  store %"class.aie::detail::vector_base.1" %9, ptr %8, align 32, !dbg !2731
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp6) #20, !dbg !2732
  %10 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 3, !dbg !2732
  %11 = load ptr, ptr %10, align 4, !dbg !2732, !tbaa !2733
  %call7 = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #22, !dbg !2734
  %call8 = call addrspace(1) %"class.aie::accum.9" @_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(32) %11, i32 %call7) #22, !dbg !2735
  %12 = getelementptr inbounds %"class.aie::accum.9", ptr %ref.tmp6, i32 0, i32 0, !dbg !2735
  %13 = extractvalue %"class.aie::accum.9" %call8, 0, !dbg !2735
  store %"class.aie::detail::accum_base.10" %13, ptr %12, align 32, !dbg !2735
  %call9 = call addrspace(1) %struct.v16accfloat @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_(ptr nonnull align 1 dereferenceable(1) %1, ptr nonnull align 32 dereferenceable(64) %ref.tmp, ptr nonnull align 32 dereferenceable(64) %ref.tmp3, ptr nonnull align 32 dereferenceable(64) %ref.tmp6) #22, !dbg !2721
  %14 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !2721
  %15 = extractvalue %struct.v16accfloat %call9, 0, !dbg !2721
  store %struct.ipd.custom_type.v16acc32.v16acc32 %15, ptr %14, align 32, !dbg !2721
  %16 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !2721, !tbaa !2736
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16accfloat %16) #22, !dbg !2721
  %17 = load %"class.aie::accum.9", ptr %custom_type.tmp, align 32, !dbg !2721, !tbaa !2738
  store %"class.aie::accum.9" %17, ptr %tmp, align 32, !dbg !2721, !tbaa !2738
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp6) #20, !dbg !2721
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp3) #20, !dbg !2721
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #20, !dbg !2721
  %18 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 4, !dbg !2741
  %19 = load ptr, ptr %18, align 4, !dbg !2741, !tbaa !2742
  %call10 = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #22, !dbg !2743
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp11) #20, !dbg !2744
  %call12 = call addrspace(1) %"class.aie::accum" @_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(64) %tmp, i32 0) #22, !dbg !2745
  %20 = getelementptr inbounds %"class.aie::accum", ptr %ref.tmp11, i32 0, i32 0, !dbg !2745
  %21 = extractvalue %"class.aie::accum" %call12, 0, !dbg !2745
  store %"class.aie::detail::accum_base" %21, ptr %20, align 32, !dbg !2745
  %call13 = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE(ptr nonnull align 32 dereferenceable(32) %19, i32 %call10, ptr nonnull align 32 dereferenceable(32) %ref.tmp11) #22, !dbg !2746
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp11) #20, !dbg !2741
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %tmp) #20, !dbg !2747
  ret void, !dbg !2747
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat align 2 !dbg !2748 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2754, metadata !DIExpression()), !dbg !2755
  ret void, !dbg !2756
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 32 dereferenceable(64) %args, ptr nonnull align 32 dereferenceable(64) %args1, ptr nonnull align 32 dereferenceable(64) %args3) addrspace(1) #6 comdat align 2 !dbg !2757 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  %args.addr = alloca ptr, align 4
  %args.addr2 = alloca ptr, align 4
  %args.addr4 = alloca ptr, align 4
  %agg.tmp = alloca %struct.v16float, align 32
  %agg.tmp6 = alloca %struct.v16float, align 32
  %agg.tmp8 = alloca %struct.v16accfloat, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2770, metadata !DIExpression()), !dbg !2775
  store ptr %args, ptr %args.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %args.addr, metadata !2772, metadata !DIExpression()), !dbg !2776
  store ptr %args1, ptr %args.addr2, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %args.addr2, metadata !2773, metadata !DIExpression()), !dbg !2776
  store ptr %args3, ptr %args.addr4, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %args.addr4, metadata !2774, metadata !DIExpression()), !dbg !2776
  %this5 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %args.addr, align 4, !dbg !2777, !tbaa !1512
  %call = call addrspace(1) %struct.v16float @_ZNK3aie6vectorIfLj16EEcv8v16floatEv(ptr nonnull align 32 dereferenceable(64) %0) #22, !dbg !2777
  %1 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !2777
  %2 = extractvalue %struct.v16float %call, 0, !dbg !2777
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32, !dbg !2777
  %3 = load ptr, ptr %args.addr2, align 4, !dbg !2777, !tbaa !1512
  %call7 = call addrspace(1) %struct.v16float @_ZNK3aie6vectorIfLj16EEcv8v16floatEv(ptr nonnull align 32 dereferenceable(64) %3) #22, !dbg !2777
  %4 = getelementptr inbounds %struct.v16float, ptr %agg.tmp6, i32 0, i32 0, !dbg !2777
  %5 = extractvalue %struct.v16float %call7, 0, !dbg !2777
  store %struct.ipd.custom_type.v128int4.v128int4 %5, ptr %4, align 32, !dbg !2777
  %6 = load ptr, ptr %args.addr4, align 4, !dbg !2777, !tbaa !1512
  %call9 = call addrspace(1) %struct.v16accfloat @_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %6) #22, !dbg !2777
  %7 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp8, i32 0, i32 0, !dbg !2777
  %8 = extractvalue %struct.v16accfloat %call9, 0, !dbg !2777
  store %struct.ipd.custom_type.v16acc32.v16acc32 %8, ptr %7, align 32, !dbg !2777
  %9 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !2778, !tbaa !2072
  %10 = load %struct.v16float, ptr %agg.tmp6, align 32, !dbg !2778, !tbaa !2072
  %11 = load %struct.v16accfloat, ptr %agg.tmp8, align 32, !dbg !2778, !tbaa !2736
  %call10 = call addrspace(1) %struct.v16accfloat @_Z11mac_elem_168v16floatS_11v16accfloat(%struct.v16float %9, %struct.v16float %10, %struct.v16accfloat %11) #22, !dbg !2778
  %12 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2778
  %13 = extractvalue %struct.v16accfloat %call10, 0, !dbg !2778
  store %struct.ipd.custom_type.v16acc32.v16acc32 %13, ptr %12, align 32, !dbg !2778
  %14 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2779
  ret %struct.v16accfloat %14, !dbg !2779
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2780 {
entry:
  %retval = alloca %"class.aie::vector.0", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2787, metadata !DIExpression()), !dbg !2789
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2788, metadata !DIExpression()), !dbg !2790
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 0) #22, !dbg !2791
  %0 = getelementptr inbounds %"class.aie::vector.0", ptr %retval, i32 0, i32 0, !dbg !2791
  %1 = extractvalue %"class.aie::vector.0" %call, 0, !dbg !2791
  store %"class.aie::detail::vector_base.1" %1, ptr %0, align 32, !dbg !2791
  %2 = load %"class.aie::vector.0", ptr %retval, align 32, !dbg !2793
  ret %"class.aie::vector.0" %2, !dbg !2793
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local noundef i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %this) addrspace(1) #9 comdat align 2 !dbg !2794 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2796, metadata !DIExpression()), !dbg !2798
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv(ptr nonnull align 1 dereferenceable(1) %this1) #22, !dbg !2799
  ret i32 %call, !dbg !2800
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum.9" @_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2801 {
entry:
  %retval = alloca %"class.aie::accum.9", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2806, metadata !DIExpression()), !dbg !2809
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2808, metadata !DIExpression()), !dbg !2810
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %"class.aie::accum.9" @_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv(ptr nonnull align 32 dereferenceable(32) %this1) #22, !dbg !2811
  %0 = getelementptr inbounds %"class.aie::accum.9", ptr %retval, i32 0, i32 0, !dbg !2811
  %1 = extractvalue %"class.aie::accum.9" %call, 0, !dbg !2811
  store %"class.aie::detail::accum_base.10" %1, ptr %0, align 32, !dbg !2811
  %2 = load %"class.aie::accum.9", ptr %retval, align 32, !dbg !2813
  ret %"class.aie::accum.9" %2, !dbg !2813
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16accfloat %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2814 {
entry:
  %data = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16accfloat %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2816, metadata !DIExpression()), !dbg !2819
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !2818, metadata !DIExpression()), !dbg !2820
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load %struct.v16accfloat, ptr %data, align 32, !dbg !2821, !tbaa !2736
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this1, %struct.v16accfloat %0) #22, !dbg !2821
  ret void, !dbg !2822
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local nonnull align 32 dereferenceable(32) ptr @_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2823 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %acc.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2832, metadata !DIExpression()), !dbg !2835
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2833, metadata !DIExpression()), !dbg !2836
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2834, metadata !DIExpression()), !dbg !2837
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2838, !tbaa !1721
  %1 = load ptr, ptr %acc.addr, align 4, !dbg !2839, !tbaa !1512
  %call = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0, ptr nonnull align 32 dereferenceable(32) %1) #22, !dbg !2840
  ret ptr %this1, !dbg !2841
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2842 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::accum", align 32
  %ref.tmp = alloca %"class.aie::detail::accum_base", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2847, metadata !DIExpression()), !dbg !2850
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2849, metadata !DIExpression()), !dbg !2851
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #20, !dbg !2852
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2853, !tbaa !1721
  %call = call addrspace(1) %"class.aie::detail::accum_base" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this1, i32 %0) #22, !dbg !2854
  %1 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %ref.tmp, i32 0, i32 0, !dbg !2854
  %2 = extractvalue %"class.aie::detail::accum_base" %call, 0, !dbg !2854
  store %struct.v8accfloat %2, ptr %1, align 32, !dbg !2854
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #22, !dbg !2855
  %3 = load %"class.aie::accum", ptr %custom_type.tmp, align 32, !dbg !2855, !tbaa !1684
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #20, !dbg !2856
  ret %"class.aie::accum" %3, !dbg !2855
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z11mac_elem_168v16floatS_11v16accfloat(%struct.v16float %v1.coerce, %struct.v16float %v2.coerce, %struct.v16accfloat %acc.coerce) addrspace(1) #6 comdat !dbg !2857 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %v1 = alloca %struct.v16float, align 32
  %v2 = alloca %struct.v16float, align 32
  %acc = alloca %struct.v16accfloat, align 32
  store %struct.v16float %v1.coerce, ptr %v1, align 32
  store %struct.v16float %v2.coerce, ptr %v2, align 32
  store %struct.v16accfloat %acc.coerce, ptr %acc, align 32
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1, metadata !2862, metadata !DIExpression()), !dbg !2865
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2, metadata !2863, metadata !DIExpression()), !dbg !2865
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !2864, metadata !DIExpression()), !dbg !2865
  %0 = load %struct.v16float, ptr %v1, align 32, !dbg !2865, !tbaa !2072
  %1 = load %struct.v16float, ptr %v2, align 32, !dbg !2865, !tbaa !2072
  %2 = load %struct.v16accfloat, ptr %acc, align 32, !dbg !2865, !tbaa !2736
  %call = call addrspace(1) %struct.v16accfloat @_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii(%struct.v16float %0, %struct.v16float %1, %struct.v16accfloat %2, i32 0, i32 0, i32 0) #22, !dbg !2865
  %3 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2865
  %4 = extractvalue %struct.v16accfloat %call, 0, !dbg !2865
  store %struct.ipd.custom_type.v16acc32.v16acc32 %4, ptr %3, align 32, !dbg !2865
  %5 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2865
  ret %struct.v16accfloat %5, !dbg !2865
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZNK3aie6vectorIfLj16EEcv8v16floatEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !2866 {
entry:
  %retval = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2868, metadata !DIExpression()), !dbg !2869
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v16float @_ZNK3aie6vectorIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this1) #22, !dbg !2870
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !2870
  %1 = extractvalue %struct.v16float %call, 0, !dbg !2870
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !2870
  %2 = load %struct.v16float, ptr %retval, align 32, !dbg !2871
  ret %struct.v16float %2, !dbg !2871
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !2872 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2874, metadata !DIExpression()), !dbg !2875
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v16accfloat @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %this1) #22, !dbg !2876
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2876
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !2876
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !2876
  %2 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2877
  ret %struct.v16accfloat %2, !dbg !2877
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii(%struct.v16float %v1.coerce, %struct.v16float %v2.coerce, %struct.v16accfloat %acc.coerce, i32 %zero_acc, i32 %sub_mul, i32 %sub_acc1) addrspace(1) #6 comdat !dbg !2878 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %v1 = alloca %struct.v16float, align 32
  %v2 = alloca %struct.v16float, align 32
  %acc = alloca %struct.v16accfloat, align 32
  %zero_acc.addr = alloca i32, align 4
  %sub_mul.addr = alloca i32, align 4
  %sub_acc1.addr = alloca i32, align 4
  store %struct.v16float %v1.coerce, ptr %v1, align 32
  store %struct.v16float %v2.coerce, ptr %v2, align 32
  store %struct.v16accfloat %acc.coerce, ptr %acc, align 32
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1, metadata !2882, metadata !DIExpression()), !dbg !2889
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2, metadata !2883, metadata !DIExpression()), !dbg !2889
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !2884, metadata !DIExpression()), !dbg !2889
  store i32 %zero_acc, ptr %zero_acc.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %zero_acc.addr, metadata !2885, metadata !DIExpression()), !dbg !2889
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_mul.addr, metadata !2886, metadata !DIExpression()), !dbg !2889
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_acc1.addr, metadata !2887, metadata !DIExpression()), !dbg !2889
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2888, metadata !DIExpression()), !dbg !2889
  %0 = load i32, ptr %zero_acc.addr, align 4, !dbg !2889, !tbaa !1721
  %1 = load i32, ptr %sub_mul.addr, align 4, !dbg !2889, !tbaa !1721
  %2 = load i32, ptr %sub_acc1.addr, align 4, !dbg !2889, !tbaa !1721
  %3 = load %struct.v16float, ptr %v1, align 32, !dbg !2889, !tbaa !2072
  %4 = load %struct.v16float, ptr %v2, align 32, !dbg !2889, !tbaa !2072
  %5 = load %struct.v16accfloat, ptr %acc, align 32, !dbg !2889, !tbaa !2736
  %call = call addrspace(1) %struct.v16accfloat @_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii(%struct.v16float %3, %struct.v16float %4, %struct.v16accfloat %5, i32 %0, i32 %1, i32 %2) #22, !dbg !2889
  %6 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2889
  %7 = extractvalue %struct.v16accfloat %call, 0, !dbg !2889
  store %struct.ipd.custom_type.v16acc32.v16acc32 %7, ptr %6, align 32, !dbg !2889
  %8 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2889
  ret %struct.v16accfloat %8, !dbg !2889
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii(%struct.v16float %v1.coerce, %struct.v16float %v2.coerce, %struct.v16accfloat %acc.coerce, i32 %zero_acc, i32 %sub_mul, i32 %sub_acc1) addrspace(1) #6 comdat !dbg !2890 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %v1 = alloca %struct.v16float, align 32
  %v2 = alloca %struct.v16float, align 32
  %acc = alloca %struct.v16accfloat, align 32
  %zero_acc.addr = alloca i32, align 4
  %sub_mul.addr = alloca i32, align 4
  %sub_acc1.addr = alloca i32, align 4
  %a = alloca %struct.v32bfloat16, align 32
  %b = alloca %struct.v32bfloat16, align 32
  %c = alloca %struct.v32bfloat16, align 32
  %d = alloca %struct.v32bfloat16, align 32
  %e = alloca %struct.v32bfloat16, align 32
  %f = alloca %struct.v32bfloat16, align 32
  %dummy0 = alloca %struct.v32bfloat16, align 32
  %agg.tmp = alloca %struct.v16bfloat16, align 32
  %agg.tmp7 = alloca %struct.v16accfloat, align 32
  %custom_type.tmp = alloca %struct.v16accfloat, align 32
  %agg.tmp10 = alloca %struct.v32bfloat16, align 32
  %acc0 = alloca %struct.v16accfloat, align 32
  %agg.tmp11 = alloca %struct.v16accfloat, align 32
  %custom_type.tmp12 = alloca %struct.v16accfloat, align 32
  %agg.tmp14 = alloca %struct.v16bfloat16, align 32
  %agg.tmp17 = alloca %struct.v32bfloat16, align 32
  %agg.tmp18 = alloca %struct.v16bfloat16, align 32
  %agg.tmp19 = alloca %struct.v16accfloat, align 32
  %agg.tmp23 = alloca %struct.v32bfloat16, align 32
  %agg.tmp24 = alloca %struct.v16bfloat16, align 32
  %agg.tmp25 = alloca %struct.v16accfloat, align 32
  %custom_type.tmp26 = alloca %struct.v16accfloat, align 32
  %agg.tmp29 = alloca %struct.v32bfloat16, align 32
  %acc1 = alloca %struct.v16accfloat, align 32
  %agg.tmp30 = alloca %struct.v16accfloat, align 32
  %custom_type.tmp31 = alloca %struct.v16accfloat, align 32
  %agg.tmp33 = alloca %struct.v16bfloat16, align 32
  %agg.tmp36 = alloca %struct.v32bfloat16, align 32
  %agg.tmp37 = alloca %struct.v16bfloat16, align 32
  %agg.tmp38 = alloca %struct.v16accfloat, align 32
  %agg.tmp42 = alloca %struct.v32bfloat16, align 32
  %agg.tmp43 = alloca %struct.v16accfloat, align 32
  %agg.tmp44 = alloca %struct.v16accfloat, align 32
  %agg.tmp45 = alloca %struct.v16accfloat, align 32
  %agg.tmp46 = alloca %struct.v16accfloat, align 32
  %agg.tmp47 = alloca %struct.v16accfloat, align 32
  store %struct.v16float %v1.coerce, ptr %v1, align 32
  store %struct.v16float %v2.coerce, ptr %v2, align 32
  store %struct.v16accfloat %acc.coerce, ptr %acc, align 32
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1, metadata !2893, metadata !DIExpression()), !dbg !2908
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2, metadata !2894, metadata !DIExpression()), !dbg !2909
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !2895, metadata !DIExpression()), !dbg !2910
  store i32 %zero_acc, ptr %zero_acc.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %zero_acc.addr, metadata !2896, metadata !DIExpression()), !dbg !2911
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_mul.addr, metadata !2897, metadata !DIExpression()), !dbg !2912
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_acc1.addr, metadata !2898, metadata !DIExpression()), !dbg !2913
  store %struct.v32bfloat16 undef, ptr %a, align 32, !dbg !2914
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %a) #20, !dbg !2914
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2899, metadata !DIExpression()), !dbg !2915
  %call = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #22, !dbg !2916
  %0 = getelementptr inbounds %struct.v32bfloat16, ptr %a, i32 0, i32 0, !dbg !2916
  %1 = extractvalue %struct.v32bfloat16 %call, 0, !dbg !2916
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !2916
  store %struct.v32bfloat16 undef, ptr %b, align 32, !dbg !2917
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %b) #20, !dbg !2917
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %b, metadata !2900, metadata !DIExpression()), !dbg !2918
  %call1 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #22, !dbg !2919
  %2 = getelementptr inbounds %struct.v32bfloat16, ptr %b, i32 0, i32 0, !dbg !2919
  %3 = extractvalue %struct.v32bfloat16 %call1, 0, !dbg !2919
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32, !dbg !2919
  store %struct.v32bfloat16 undef, ptr %c, align 32, !dbg !2920
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %c) #20, !dbg !2920
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %c, metadata !2901, metadata !DIExpression()), !dbg !2921
  %call2 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #22, !dbg !2922
  %4 = getelementptr inbounds %struct.v32bfloat16, ptr %c, i32 0, i32 0, !dbg !2922
  %5 = extractvalue %struct.v32bfloat16 %call2, 0, !dbg !2922
  store %struct.ipd.custom_type.v128int4.v128int4 %5, ptr %4, align 32, !dbg !2922
  store %struct.v32bfloat16 undef, ptr %d, align 32, !dbg !2923
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %d) #20, !dbg !2923
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %d, metadata !2902, metadata !DIExpression()), !dbg !2924
  %call3 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #22, !dbg !2925
  %6 = getelementptr inbounds %struct.v32bfloat16, ptr %d, i32 0, i32 0, !dbg !2925
  %7 = extractvalue %struct.v32bfloat16 %call3, 0, !dbg !2925
  store %struct.ipd.custom_type.v128int4.v128int4 %7, ptr %6, align 32, !dbg !2925
  store %struct.v32bfloat16 undef, ptr %e, align 32, !dbg !2926
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %e) #20, !dbg !2926
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %e, metadata !2903, metadata !DIExpression()), !dbg !2927
  %call4 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #22, !dbg !2928
  %8 = getelementptr inbounds %struct.v32bfloat16, ptr %e, i32 0, i32 0, !dbg !2928
  %9 = extractvalue %struct.v32bfloat16 %call4, 0, !dbg !2928
  store %struct.ipd.custom_type.v128int4.v128int4 %9, ptr %8, align 32, !dbg !2928
  store %struct.v32bfloat16 undef, ptr %f, align 32, !dbg !2929
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %f) #20, !dbg !2929
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %f, metadata !2904, metadata !DIExpression()), !dbg !2930
  %call5 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #22, !dbg !2931
  %10 = getelementptr inbounds %struct.v32bfloat16, ptr %f, i32 0, i32 0, !dbg !2931
  %11 = extractvalue %struct.v32bfloat16 %call5, 0, !dbg !2931
  store %struct.ipd.custom_type.v128int4.v128int4 %11, ptr %10, align 32, !dbg !2931
  store %struct.v32bfloat16 undef, ptr %dummy0, align 32, !dbg !2932
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %dummy0) #20, !dbg !2932
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %dummy0, metadata !2905, metadata !DIExpression()), !dbg !2933
  %call6 = call addrspace(1) %struct.v32bfloat16 @_Z28broadcast_one_to_v32bfloat16v() #22, !dbg !2934
  %12 = getelementptr inbounds %struct.v32bfloat16, ptr %dummy0, i32 0, i32 0, !dbg !2934
  %13 = extractvalue %struct.v32bfloat16 %call6, 0, !dbg !2934
  store %struct.ipd.custom_type.v128int4.v128int4 %13, ptr %12, align 32, !dbg !2934
  %14 = load %struct.v16float, ptr %v1, align 32, !dbg !2935, !tbaa !2072
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16float %14) #25, !dbg !2935
  %15 = load %struct.v16accfloat, ptr %custom_type.tmp, align 32, !dbg !2935, !tbaa !2736
  store %struct.v16accfloat %15, ptr %agg.tmp7, align 32, !dbg !2935, !tbaa !2736
  %16 = load %struct.v16accfloat, ptr %agg.tmp7, align 32, !dbg !2936, !tbaa !2736
  %call8 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %16) #22, !dbg !2936
  %17 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp, i32 0, i32 0, !dbg !2936
  %18 = extractvalue %struct.v16bfloat16 %call8, 0, !dbg !2936
  store %struct.ipd.custom_type.v64int4.v64int4 %18, ptr %17, align 32, !dbg !2936
  %19 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !2937, !tbaa !2072
  %20 = load %struct.v16bfloat16, ptr %agg.tmp, align 32, !dbg !2937, !tbaa !2167
  %call9 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %19, i32 0, %struct.v16bfloat16 %20) #22, !dbg !2937
  %21 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp10, i32 0, i32 0, !dbg !2937
  %22 = extractvalue %struct.v32bfloat16 %call9, 0, !dbg !2937
  store %struct.ipd.custom_type.v128int4.v128int4 %22, ptr %21, align 32, !dbg !2937
  %23 = load %struct.v32bfloat16, ptr %agg.tmp10, align 32, !dbg !2938, !tbaa !2072
  store %struct.v32bfloat16 %23, ptr %a, align 32, !dbg !2938, !tbaa !2072
  store %struct.v16accfloat undef, ptr %acc0, align 32, !dbg !2939
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %acc0) #20, !dbg !2939
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc0, metadata !2906, metadata !DIExpression()), !dbg !2940
  %24 = load %struct.v16float, ptr %v1, align 32, !dbg !2941, !tbaa !2072
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp12, %struct.v16float %24) #25, !dbg !2941
  %25 = load %struct.v16accfloat, ptr %custom_type.tmp12, align 32, !dbg !2941, !tbaa !2736
  store %struct.v16accfloat %25, ptr %agg.tmp11, align 32, !dbg !2941, !tbaa !2736
  %26 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !2942, !tbaa !2072
  %27 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !2942, !tbaa !2072
  %28 = load %struct.v16accfloat, ptr %agg.tmp11, align 32, !dbg !2942, !tbaa !2736
  %call13 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %26, %struct.v32bfloat16 %27, %struct.v16accfloat %28) #22, !dbg !2942
  %29 = getelementptr inbounds %struct.v16accfloat, ptr %acc0, i32 0, i32 0, !dbg !2942
  %30 = extractvalue %struct.v16accfloat %call13, 0, !dbg !2942
  store %struct.ipd.custom_type.v16acc32.v16acc32 %30, ptr %29, align 32, !dbg !2942
  %31 = load %struct.v16accfloat, ptr %acc0, align 32, !dbg !2943, !tbaa !2736
  %call15 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %31) #22, !dbg !2943
  %32 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp14, i32 0, i32 0, !dbg !2943
  %33 = extractvalue %struct.v16bfloat16 %call15, 0, !dbg !2943
  store %struct.ipd.custom_type.v64int4.v64int4 %33, ptr %32, align 32, !dbg !2943
  %34 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !2944, !tbaa !2072
  %35 = load %struct.v16bfloat16, ptr %agg.tmp14, align 32, !dbg !2944, !tbaa !2167
  %call16 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %34, i32 0, %struct.v16bfloat16 %35) #22, !dbg !2944
  %36 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp17, i32 0, i32 0, !dbg !2944
  %37 = extractvalue %struct.v32bfloat16 %call16, 0, !dbg !2944
  store %struct.ipd.custom_type.v128int4.v128int4 %37, ptr %36, align 32, !dbg !2944
  %38 = load %struct.v32bfloat16, ptr %agg.tmp17, align 32, !dbg !2945, !tbaa !2072
  store %struct.v32bfloat16 %38, ptr %b, align 32, !dbg !2945, !tbaa !2072
  %39 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !2946, !tbaa !2072
  %40 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !2946, !tbaa !2072
  %41 = load %struct.v16accfloat, ptr %acc0, align 32, !dbg !2946, !tbaa !2736
  %call20 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %39, %struct.v32bfloat16 %40, %struct.v16accfloat %41) #22, !dbg !2946
  %42 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp19, i32 0, i32 0, !dbg !2946
  %43 = extractvalue %struct.v16accfloat %call20, 0, !dbg !2946
  store %struct.ipd.custom_type.v16acc32.v16acc32 %43, ptr %42, align 32, !dbg !2946
  %44 = load %struct.v16accfloat, ptr %agg.tmp19, align 32, !dbg !2947, !tbaa !2736
  %call21 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %44) #22, !dbg !2947
  %45 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp18, i32 0, i32 0, !dbg !2947
  %46 = extractvalue %struct.v16bfloat16 %call21, 0, !dbg !2947
  store %struct.ipd.custom_type.v64int4.v64int4 %46, ptr %45, align 32, !dbg !2947
  %47 = load %struct.v32bfloat16, ptr %c, align 32, !dbg !2948, !tbaa !2072
  %48 = load %struct.v16bfloat16, ptr %agg.tmp18, align 32, !dbg !2948, !tbaa !2167
  %call22 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %47, i32 0, %struct.v16bfloat16 %48) #22, !dbg !2948
  %49 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp23, i32 0, i32 0, !dbg !2948
  %50 = extractvalue %struct.v32bfloat16 %call22, 0, !dbg !2948
  store %struct.ipd.custom_type.v128int4.v128int4 %50, ptr %49, align 32, !dbg !2948
  %51 = load %struct.v32bfloat16, ptr %agg.tmp23, align 32, !dbg !2949, !tbaa !2072
  store %struct.v32bfloat16 %51, ptr %c, align 32, !dbg !2949, !tbaa !2072
  %52 = load %struct.v16float, ptr %v2, align 32, !dbg !2950, !tbaa !2072
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp26, %struct.v16float %52) #25, !dbg !2950
  %53 = load %struct.v16accfloat, ptr %custom_type.tmp26, align 32, !dbg !2950, !tbaa !2736
  store %struct.v16accfloat %53, ptr %agg.tmp25, align 32, !dbg !2950, !tbaa !2736
  %54 = load %struct.v16accfloat, ptr %agg.tmp25, align 32, !dbg !2951, !tbaa !2736
  %call27 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %54) #22, !dbg !2951
  %55 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp24, i32 0, i32 0, !dbg !2951
  %56 = extractvalue %struct.v16bfloat16 %call27, 0, !dbg !2951
  store %struct.ipd.custom_type.v64int4.v64int4 %56, ptr %55, align 32, !dbg !2951
  %57 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !2952, !tbaa !2072
  %58 = load %struct.v16bfloat16, ptr %agg.tmp24, align 32, !dbg !2952, !tbaa !2167
  %call28 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %57, i32 0, %struct.v16bfloat16 %58) #22, !dbg !2952
  %59 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp29, i32 0, i32 0, !dbg !2952
  %60 = extractvalue %struct.v32bfloat16 %call28, 0, !dbg !2952
  store %struct.ipd.custom_type.v128int4.v128int4 %60, ptr %59, align 32, !dbg !2952
  %61 = load %struct.v32bfloat16, ptr %agg.tmp29, align 32, !dbg !2953, !tbaa !2072
  store %struct.v32bfloat16 %61, ptr %d, align 32, !dbg !2953, !tbaa !2072
  store %struct.v16accfloat undef, ptr %acc1, align 32, !dbg !2954
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %acc1) #20, !dbg !2954
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc1, metadata !2907, metadata !DIExpression()), !dbg !2955
  %62 = load %struct.v16float, ptr %v2, align 32, !dbg !2956, !tbaa !2072
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp31, %struct.v16float %62) #25, !dbg !2956
  %63 = load %struct.v16accfloat, ptr %custom_type.tmp31, align 32, !dbg !2956, !tbaa !2736
  store %struct.v16accfloat %63, ptr %agg.tmp30, align 32, !dbg !2956, !tbaa !2736
  %64 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !2957, !tbaa !2072
  %65 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !2957, !tbaa !2072
  %66 = load %struct.v16accfloat, ptr %agg.tmp30, align 32, !dbg !2957, !tbaa !2736
  %call32 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %64, %struct.v32bfloat16 %65, %struct.v16accfloat %66) #22, !dbg !2957
  %67 = getelementptr inbounds %struct.v16accfloat, ptr %acc1, i32 0, i32 0, !dbg !2957
  %68 = extractvalue %struct.v16accfloat %call32, 0, !dbg !2957
  store %struct.ipd.custom_type.v16acc32.v16acc32 %68, ptr %67, align 32, !dbg !2957
  %69 = load %struct.v16accfloat, ptr %acc1, align 32, !dbg !2958, !tbaa !2736
  %call34 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %69) #22, !dbg !2958
  %70 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp33, i32 0, i32 0, !dbg !2958
  %71 = extractvalue %struct.v16bfloat16 %call34, 0, !dbg !2958
  store %struct.ipd.custom_type.v64int4.v64int4 %71, ptr %70, align 32, !dbg !2958
  %72 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !2959, !tbaa !2072
  %73 = load %struct.v16bfloat16, ptr %agg.tmp33, align 32, !dbg !2959, !tbaa !2167
  %call35 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %72, i32 0, %struct.v16bfloat16 %73) #22, !dbg !2959
  %74 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp36, i32 0, i32 0, !dbg !2959
  %75 = extractvalue %struct.v32bfloat16 %call35, 0, !dbg !2959
  store %struct.ipd.custom_type.v128int4.v128int4 %75, ptr %74, align 32, !dbg !2959
  %76 = load %struct.v32bfloat16, ptr %agg.tmp36, align 32, !dbg !2960, !tbaa !2072
  store %struct.v32bfloat16 %76, ptr %e, align 32, !dbg !2960, !tbaa !2072
  %77 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !2961, !tbaa !2072
  %78 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !2961, !tbaa !2072
  %79 = load %struct.v16accfloat, ptr %acc1, align 32, !dbg !2961, !tbaa !2736
  %call39 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %77, %struct.v32bfloat16 %78, %struct.v16accfloat %79) #22, !dbg !2961
  %80 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp38, i32 0, i32 0, !dbg !2961
  %81 = extractvalue %struct.v16accfloat %call39, 0, !dbg !2961
  store %struct.ipd.custom_type.v16acc32.v16acc32 %81, ptr %80, align 32, !dbg !2961
  %82 = load %struct.v16accfloat, ptr %agg.tmp38, align 32, !dbg !2962, !tbaa !2736
  %call40 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %82) #22, !dbg !2962
  %83 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp37, i32 0, i32 0, !dbg !2962
  %84 = extractvalue %struct.v16bfloat16 %call40, 0, !dbg !2962
  store %struct.ipd.custom_type.v64int4.v64int4 %84, ptr %83, align 32, !dbg !2962
  %85 = load %struct.v32bfloat16, ptr %f, align 32, !dbg !2963, !tbaa !2072
  %86 = load %struct.v16bfloat16, ptr %agg.tmp37, align 32, !dbg !2963, !tbaa !2167
  %call41 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %85, i32 0, %struct.v16bfloat16 %86) #22, !dbg !2963
  %87 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp42, i32 0, i32 0, !dbg !2963
  %88 = extractvalue %struct.v32bfloat16 %call41, 0, !dbg !2963
  store %struct.ipd.custom_type.v128int4.v128int4 %88, ptr %87, align 32, !dbg !2963
  %89 = load %struct.v32bfloat16, ptr %agg.tmp42, align 32, !dbg !2964, !tbaa !2072
  store %struct.v32bfloat16 %89, ptr %f, align 32, !dbg !2964, !tbaa !2072
  %90 = load i32, ptr %sub_mul.addr, align 4, !dbg !2965, !tbaa !1721
  %91 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !2966, !tbaa !2072
  %92 = load %struct.v32bfloat16, ptr %f, align 32, !dbg !2966, !tbaa !2072
  %call48 = call addrspace(1) %struct.v16accfloat @_Z18mul_elem_16_2_conf11v32bfloat16S_i(%struct.v32bfloat16 %91, %struct.v32bfloat16 %92, i32 %90) #22, !dbg !2966
  %93 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp47, i32 0, i32 0, !dbg !2966
  %94 = extractvalue %struct.v16accfloat %call48, 0, !dbg !2966
  store %struct.ipd.custom_type.v16acc32.v16acc32 %94, ptr %93, align 32, !dbg !2966
  %95 = load i32, ptr %sub_mul.addr, align 4, !dbg !2967, !tbaa !1721
  %96 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !2968, !tbaa !2072
  %97 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !2968, !tbaa !2072
  %98 = load %struct.v16accfloat, ptr %agg.tmp47, align 32, !dbg !2968, !tbaa !2736
  %call49 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %96, %struct.v32bfloat16 %97, %struct.v16accfloat %98, i32 0, i32 %95, i32 0) #22, !dbg !2968
  %99 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp46, i32 0, i32 0, !dbg !2968
  %100 = extractvalue %struct.v16accfloat %call49, 0, !dbg !2968
  store %struct.ipd.custom_type.v16acc32.v16acc32 %100, ptr %99, align 32, !dbg !2968
  %101 = load i32, ptr %sub_mul.addr, align 4, !dbg !2969, !tbaa !1721
  %102 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !2970, !tbaa !2072
  %103 = load %struct.v32bfloat16, ptr %c, align 32, !dbg !2970, !tbaa !2072
  %104 = load %struct.v16accfloat, ptr %agg.tmp46, align 32, !dbg !2970, !tbaa !2736
  %call50 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %102, %struct.v32bfloat16 %103, %struct.v16accfloat %104, i32 0, i32 %101, i32 0) #22, !dbg !2970
  %105 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp45, i32 0, i32 0, !dbg !2970
  %106 = extractvalue %struct.v16accfloat %call50, 0, !dbg !2970
  store %struct.ipd.custom_type.v16acc32.v16acc32 %106, ptr %105, align 32, !dbg !2970
  %107 = load i32, ptr %sub_mul.addr, align 4, !dbg !2971, !tbaa !1721
  %108 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !2972, !tbaa !2072
  %109 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !2972, !tbaa !2072
  %110 = load %struct.v16accfloat, ptr %agg.tmp45, align 32, !dbg !2972, !tbaa !2736
  %call51 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %108, %struct.v32bfloat16 %109, %struct.v16accfloat %110, i32 0, i32 %107, i32 0) #22, !dbg !2972
  %111 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp44, i32 0, i32 0, !dbg !2972
  %112 = extractvalue %struct.v16accfloat %call51, 0, !dbg !2972
  store %struct.ipd.custom_type.v16acc32.v16acc32 %112, ptr %111, align 32, !dbg !2972
  %113 = load i32, ptr %sub_mul.addr, align 4, !dbg !2973, !tbaa !1721
  %114 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !2974, !tbaa !2072
  %115 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !2974, !tbaa !2072
  %116 = load %struct.v16accfloat, ptr %agg.tmp44, align 32, !dbg !2974, !tbaa !2736
  %call52 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %114, %struct.v32bfloat16 %115, %struct.v16accfloat %116, i32 0, i32 %113, i32 0) #22, !dbg !2974
  %117 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp43, i32 0, i32 0, !dbg !2974
  %118 = extractvalue %struct.v16accfloat %call52, 0, !dbg !2974
  store %struct.ipd.custom_type.v16acc32.v16acc32 %118, ptr %117, align 32, !dbg !2974
  %119 = load i32, ptr %zero_acc.addr, align 4, !dbg !2975, !tbaa !1721
  %120 = load i32, ptr %sub_mul.addr, align 4, !dbg !2976, !tbaa !1721
  %121 = load i32, ptr %sub_acc1.addr, align 4, !dbg !2977, !tbaa !1721
  %122 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !2978, !tbaa !2072
  %123 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !2978, !tbaa !2072
  %124 = load %struct.v16accfloat, ptr %acc, align 32, !dbg !2978, !tbaa !2736
  %125 = load %struct.v16accfloat, ptr %agg.tmp43, align 32, !dbg !2978, !tbaa !2736
  %call53 = call addrspace(1) %struct.v16accfloat @_Z21addmac_elem_16_2_conf11v32bfloat16S_11v16accfloatS0_iiii(%struct.v32bfloat16 %122, %struct.v32bfloat16 %123, %struct.v16accfloat %124, %struct.v16accfloat %125, i32 %119, i32 %120, i32 %121, i32 0) #22, !dbg !2978
  %126 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2978
  %127 = extractvalue %struct.v16accfloat %call53, 0, !dbg !2978
  store %struct.ipd.custom_type.v16acc32.v16acc32 %127, ptr %126, align 32, !dbg !2978
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %acc1) #20, !dbg !2979
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %acc0) #20, !dbg !2979
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %dummy0) #20, !dbg !2979
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %f) #20, !dbg !2979
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %e) #20, !dbg !2979
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %d) #20, !dbg !2979
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %c) #20, !dbg !2979
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %b) #20, !dbg !2979
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %a) #20, !dbg !2979
  %128 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2979
  ret %struct.v16accfloat %128, !dbg !2979
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() addrspace(1) #6 comdat {
entry:
  %custom_type.tmp = alloca %struct.v32bfloat16, align 32
  %agg.tmp = alloca %struct.v32uint16, align 32
  %call = call addrspace(1) %struct.v32uint16 @_Z13broadcast_u16t(i16 zeroext 0) #24
  %0 = getelementptr inbounds %struct.v32uint16, ptr %agg.tmp, i32 0, i32 0
  %1 = extractvalue %struct.v32uint16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32
  %2 = load %struct.v32uint16, ptr %agg.tmp, align 32, !tbaa !2072
  call addrspace(1) void @_ZN11v32bfloat16C2E9v32uint16(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v32uint16 %2) #25
  %3 = load %struct.v32bfloat16, ptr %custom_type.tmp, align 32, !tbaa !2072
  ret %struct.v32bfloat16 %3
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v32bfloat16 @_Z28broadcast_one_to_v32bfloat16v() addrspace(1) #6 comdat {
entry:
  %custom_type.tmp = alloca %struct.v32bfloat16, align 32
  %agg.tmp = alloca %struct.v32uint16, align 32
  %call = call addrspace(1) %struct.v32uint16 @_Z13broadcast_u16t(i16 zeroext 16256) #24
  %0 = getelementptr inbounds %struct.v32uint16, ptr %agg.tmp, i32 0, i32 0
  %1 = extractvalue %struct.v32uint16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32
  %2 = load %struct.v32uint16, ptr %agg.tmp, align 32, !tbaa !2072
  call addrspace(1) void @_ZN11v32bfloat16C2E9v32uint16(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v32uint16 %2) #25
  %3 = load %struct.v32bfloat16, ptr %custom_type.tmp, align 32, !tbaa !2072
  ret %struct.v32bfloat16 %3
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %a.coerce, i32 %idx, %struct.v16bfloat16 %b.coerce) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v32bfloat16, align 32
  %a = alloca %struct.v32bfloat16, align 32
  %b = alloca %struct.v16bfloat16, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v32bfloat16 %a.coerce, ptr %a, align 32
  store %struct.v16bfloat16 %b.coerce, ptr %b, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1721
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2072
  %2 = load %struct.v16bfloat16, ptr %b, align 32, !tbaa !2167
  %call = call addrspace(1) %struct.v32bfloat16 @_ZN12me_primitive6upd_xlE11v32bfloat1611v16bfloat16(%struct.v32bfloat16 %1, %struct.v16bfloat16 %2) #24
  %3 = getelementptr inbounds %struct.v32bfloat16, ptr %retval, i32 0, i32 0
  %4 = extractvalue %struct.v32bfloat16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %4, ptr %3, align 32
  br label %return

if.else:                                          ; preds = %entry
  %5 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2072
  %6 = load %struct.v16bfloat16, ptr %b, align 32, !tbaa !2167
  %call1 = call addrspace(1) %struct.v32bfloat16 @_ZN12me_primitive6upd_xhE11v32bfloat1611v16bfloat16(%struct.v32bfloat16 %5, %struct.v16bfloat16 %6) #24
  %7 = getelementptr inbounds %struct.v32bfloat16, ptr %retval, i32 0, i32 0
  %8 = extractvalue %struct.v32bfloat16 %call1, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %8, ptr %7, align 32
  br label %return

return:                                           ; preds = %if.else, %if.then
  %9 = load %struct.v32bfloat16, ptr %retval, align 32
  ret %struct.v32bfloat16 %9
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %acc.coerce) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16bfloat16, align 32
  %acc = alloca %struct.v16accfloat, align 32
  %agg.tmp = alloca %struct.ipd.custom_type.uint4_t.uint4_t, align 1
  %custom_type.tmp = alloca %struct.ipd.custom_type.uint4_t.uint4_t, align 1
  %agg.tmp1 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  %custom_type.tmp2 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  store %struct.v16accfloat %acc.coerce, ptr %acc, align 32
  %call = call addrspace(1) i32 @_Z7get_rndv() #22
  call addrspace(1) void @_ZN7uint4_tC2Ej(ptr nonnull align 1 dereferenceable(1) %custom_type.tmp, i32 %call) #22
  %0 = load %struct.ipd.custom_type.uint4_t.uint4_t, ptr %custom_type.tmp, align 1, !tbaa !2980
  store %struct.ipd.custom_type.uint4_t.uint4_t %0, ptr %agg.tmp, align 1, !tbaa !2980
  %call3 = call addrspace(1) i32 @_Z14get_fp2bf_maskv() #22
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #22
  %1 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !2982
  store %struct.ipd.custom_type.uint5_t.uint5_t %1, ptr %agg.tmp1, align 4, !tbaa !2982
  %2 = load %struct.v16accfloat, ptr %acc, align 32, !tbaa !2736
  %3 = load %struct.ipd.custom_type.uint4_t.uint4_t, ptr %agg.tmp, align 1, !tbaa !2980
  %4 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !2982
  %call4 = call addrspace(1) %struct.v16bfloat16 @_ZN12me_primitive3srsE11v16accfloat7uint4_t7uint5_t(%struct.v16accfloat %2, %struct.ipd.custom_type.uint4_t.uint4_t %3, %struct.ipd.custom_type.uint5_t.uint5_t %4) #24
  %5 = getelementptr inbounds %struct.v16bfloat16, ptr %retval, i32 0, i32 0
  %6 = extractvalue %struct.v16bfloat16 %call4, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %6, ptr %5, align 32
  %7 = load %struct.v16bfloat16, ptr %retval, align 32
  ret %struct.v16bfloat16 %7
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16float %a0.coerce) unnamed_addr addrspace(1) #16 comdat align 2 {
entry:
  %a0 = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  store %struct.v16float %a0.coerce, ptr %a0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v16accfloat, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %custom_type.tmp, align 32, !tbaa !2736
  store %struct.ipd.custom_type.v16acc32.v16acc32 %0, ptr %mw, align 32, !tbaa !2736
  %1 = load %struct.v16float, ptr %a0, align 32, !tbaa !2072
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_v16accfloat_v16float(%struct.v16float %1) #23
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !tbaa !2736
  store %struct.v16accfloat %4, ptr %this1, align 32, !tbaa !2736
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %a.coerce, %struct.v32bfloat16 %b.coerce, %struct.v16accfloat %acc1.coerce) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a = alloca %struct.v32bfloat16, align 32
  %b = alloca %struct.v32bfloat16, align 32
  %acc1 = alloca %struct.v16accfloat, align 32
  %conf = alloca i32, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %agg.tmp1 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  %custom_type.tmp2 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  store %struct.v32bfloat16 %a.coerce, ptr %a, align 32
  store %struct.v32bfloat16 %b.coerce, ptr %b, align 32
  store %struct.v16accfloat %acc1.coerce, ptr %acc1, align 32
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #20
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0) #22
  store i32 %call, ptr %conf, align 4, !tbaa !1721
  %0 = load i32, ptr %conf, align 4, !tbaa !1721
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 1) #22
  %1 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2984
  store %struct.ipd.custom_type.uint1_t.uint1_t %1, ptr %agg.tmp, align 4, !tbaa !2984
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #22
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #22
  %2 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !2982
  store %struct.ipd.custom_type.uint5_t.uint5_t %2, ptr %agg.tmp1, align 4, !tbaa !2982
  %3 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2072
  %4 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2072
  %5 = load %struct.v16accfloat, ptr %acc1, align 32, !tbaa !2736
  %6 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2984
  %7 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !2982
  %call4 = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive10mac16_confE11v32bfloat16S0_11v16accfloati7uint1_t7uint5_t(%struct.v32bfloat16 %3, %struct.v32bfloat16 %4, %struct.v16accfloat %5, i32 %0, %struct.ipd.custom_type.uint1_t.uint1_t %6, %struct.ipd.custom_type.uint5_t.uint5_t %7) #24
  %8 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %9 = extractvalue %struct.v16accfloat %call4, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %9, ptr %8, align 32
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %conf) #20
  %10 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %10
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z21addmac_elem_16_2_conf11v32bfloat16S_11v16accfloatS0_iiii(%struct.v32bfloat16 %a.coerce, %struct.v32bfloat16 %b.coerce, %struct.v16accfloat %acc1.coerce, %struct.v16accfloat %acc2.coerce, i32 %zero_acc1, i32 %sub_mul, i32 %sub_acc1, i32 %sub_acc2) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a = alloca %struct.v32bfloat16, align 32
  %b = alloca %struct.v32bfloat16, align 32
  %acc1 = alloca %struct.v16accfloat, align 32
  %acc2 = alloca %struct.v16accfloat, align 32
  %zero_acc1.addr = alloca i32, align 4
  %sub_mul.addr = alloca i32, align 4
  %sub_acc1.addr = alloca i32, align 4
  %sub_acc2.addr = alloca i32, align 4
  %conf = alloca i32, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %agg.tmp1 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  %custom_type.tmp2 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  store %struct.v32bfloat16 %a.coerce, ptr %a, align 32
  store %struct.v32bfloat16 %b.coerce, ptr %b, align 32
  store %struct.v16accfloat %acc1.coerce, ptr %acc1, align 32
  store %struct.v16accfloat %acc2.coerce, ptr %acc2, align 32
  store i32 %zero_acc1, ptr %zero_acc1.addr, align 4, !tbaa !1721
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1721
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1721
  store i32 %sub_acc2, ptr %sub_acc2.addr, align 4, !tbaa !1721
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #20
  %0 = load i32, ptr %zero_acc1.addr, align 4, !tbaa !1721
  %1 = load i32, ptr %sub_mul.addr, align 4, !tbaa !1721
  %2 = load i32, ptr %sub_acc1.addr, align 4, !tbaa !1721
  %3 = load i32, ptr %sub_acc2.addr, align 4, !tbaa !1721
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 %0, i32 0, i32 %1, i32 %2, i32 %3, i32 0) #22
  store i32 %call, ptr %conf, align 4, !tbaa !1721
  %4 = load i32, ptr %conf, align 4, !tbaa !1721
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 0) #22
  %5 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2984
  store %struct.ipd.custom_type.uint1_t.uint1_t %5, ptr %agg.tmp, align 4, !tbaa !2984
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #22
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #22
  %6 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !2982
  store %struct.ipd.custom_type.uint5_t.uint5_t %6, ptr %agg.tmp1, align 4, !tbaa !2982
  %7 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2072
  %8 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2072
  %9 = load %struct.v16accfloat, ptr %acc1, align 32, !tbaa !2736
  %10 = load %struct.v16accfloat, ptr %acc2, align 32, !tbaa !2736
  %11 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2984
  %12 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !2982
  %call4 = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive13addmac16_confE11v32bfloat16S0_11v16accfloatS1_i7uint1_t7uint5_t(%struct.v32bfloat16 %7, %struct.v32bfloat16 %8, %struct.v16accfloat %9, %struct.v16accfloat %10, i32 %4, %struct.ipd.custom_type.uint1_t.uint1_t %11, %struct.ipd.custom_type.uint5_t.uint5_t %12) #24
  %13 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %14 = extractvalue %struct.v16accfloat %call4, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %14, ptr %13, align 32
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %conf) #20
  %15 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %15
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %a.coerce, %struct.v32bfloat16 %b.coerce, %struct.v16accfloat %acc1.coerce, i32 %zero_acc1, i32 %sub_mul, i32 %sub_acc1) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a = alloca %struct.v32bfloat16, align 32
  %b = alloca %struct.v32bfloat16, align 32
  %acc1 = alloca %struct.v16accfloat, align 32
  %zero_acc1.addr = alloca i32, align 4
  %sub_mul.addr = alloca i32, align 4
  %sub_acc1.addr = alloca i32, align 4
  %conf = alloca i32, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %agg.tmp1 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  %custom_type.tmp2 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  store %struct.v32bfloat16 %a.coerce, ptr %a, align 32
  store %struct.v32bfloat16 %b.coerce, ptr %b, align 32
  store %struct.v16accfloat %acc1.coerce, ptr %acc1, align 32
  store i32 %zero_acc1, ptr %zero_acc1.addr, align 4, !tbaa !1721
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1721
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1721
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #20
  %0 = load i32, ptr %zero_acc1.addr, align 4, !tbaa !1721
  %1 = load i32, ptr %sub_mul.addr, align 4, !tbaa !1721
  %2 = load i32, ptr %sub_acc1.addr, align 4, !tbaa !1721
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 %0, i32 0, i32 %1, i32 %2, i32 0, i32 0) #22
  store i32 %call, ptr %conf, align 4, !tbaa !1721
  %3 = load i32, ptr %conf, align 4, !tbaa !1721
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 0) #22
  %4 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2984
  store %struct.ipd.custom_type.uint1_t.uint1_t %4, ptr %agg.tmp, align 4, !tbaa !2984
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #22
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #22
  %5 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !2982
  store %struct.ipd.custom_type.uint5_t.uint5_t %5, ptr %agg.tmp1, align 4, !tbaa !2982
  %6 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2072
  %7 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2072
  %8 = load %struct.v16accfloat, ptr %acc1, align 32, !tbaa !2736
  %9 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2984
  %10 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !2982
  %call4 = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive10mac16_confE11v32bfloat16S0_11v16accfloati7uint1_t7uint5_t(%struct.v32bfloat16 %6, %struct.v32bfloat16 %7, %struct.v16accfloat %8, i32 %3, %struct.ipd.custom_type.uint1_t.uint1_t %9, %struct.ipd.custom_type.uint5_t.uint5_t %10) #24
  %11 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %12 = extractvalue %struct.v16accfloat %call4, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %12, ptr %11, align 32
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %conf) #20
  %13 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %13
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z18mul_elem_16_2_conf11v32bfloat16S_i(%struct.v32bfloat16 %a.coerce, %struct.v32bfloat16 %b.coerce, i32 %sub_mul) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a = alloca %struct.v32bfloat16, align 32
  %b = alloca %struct.v32bfloat16, align 32
  %sub_mul.addr = alloca i32, align 4
  %conf = alloca i32, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %agg.tmp1 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  %custom_type.tmp2 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  store %struct.v32bfloat16 %a.coerce, ptr %a, align 32
  store %struct.v32bfloat16 %b.coerce, ptr %b, align 32
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1721
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #20
  %0 = load i32, ptr %sub_mul.addr, align 4, !tbaa !1721
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 0, i32 0, i32 %0, i32 0, i32 0, i32 0) #22
  store i32 %call, ptr %conf, align 4, !tbaa !1721
  %1 = load i32, ptr %conf, align 4, !tbaa !1721
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 0) #22
  %2 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2984
  store %struct.ipd.custom_type.uint1_t.uint1_t %2, ptr %agg.tmp, align 4, !tbaa !2984
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #22
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #22
  %3 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !2982
  store %struct.ipd.custom_type.uint5_t.uint5_t %3, ptr %agg.tmp1, align 4, !tbaa !2982
  %4 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2072
  %5 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2072
  %6 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2984
  %7 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !2982
  %call4 = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive10mul16_confE11v32bfloat16S0_i7uint1_t7uint5_t(%struct.v32bfloat16 %4, %struct.v32bfloat16 %5, i32 %1, %struct.ipd.custom_type.uint1_t.uint1_t %6, %struct.ipd.custom_type.uint5_t.uint5_t %7) #24
  %8 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %9 = extractvalue %struct.v16accfloat %call4, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %9, ptr %8, align 32
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %conf) #20
  %10 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %10
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v32uint16 @_Z13broadcast_u16t(i16 zeroext %a0) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v32uint16, align 32
  %a0.addr = alloca i16, align 2
  store i16 %a0, ptr %a0.addr, align 2, !tbaa !2986
  %0 = load i16, ptr %a0.addr, align 2, !tbaa !2986
  %call = call x86_regcallcc addrspace(1) %struct.v32uint16 @__regcall3__chessintr_v32uint16_broadcast_u16___ushort(i16 zeroext %0) #23
  %1 = getelementptr inbounds %struct.v32uint16, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v32uint16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32
  %3 = load %struct.v32uint16, ptr %retval, align 32
  ret %struct.v32uint16 %3
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN11v32bfloat16C2E9v32uint16(ptr nonnull align 32 dereferenceable(64) %this, %struct.v32uint16 %a0.coerce) unnamed_addr addrspace(1) #16 comdat align 2 {
entry:
  %a0 = alloca %struct.v32uint16, align 32
  %this.addr = alloca ptr, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.v128int4.v128int4, align 32
  %agg.tmp = alloca %struct.v32bfloat16, align 32
  store %struct.v32uint16 %a0.coerce, ptr %a0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v32bfloat16, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v128int4.v128int4, ptr %custom_type.tmp, align 32, !tbaa !2072
  store %struct.ipd.custom_type.v128int4.v128int4 %0, ptr %mw, align 32, !tbaa !2072
  %1 = load %struct.v32uint16, ptr %a0, align 32, !tbaa !2072
  %call = call x86_regcallcc addrspace(1) %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_v32bfloat16_v32uint16(%struct.v32uint16 %1) #23
  %2 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v32bfloat16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  %4 = load %struct.v32bfloat16, ptr %agg.tmp, align 32, !tbaa !2072
  store %struct.v32bfloat16 %4, ptr %this1, align 32, !tbaa !2072
  ret void
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v32uint16 @__regcall3__chessintr_v32uint16_broadcast_u16___ushort(i16 zeroext) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_v32bfloat16_v32uint16(%struct.v32uint16) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v32bfloat16 @_ZN12me_primitive6upd_xlE11v32bfloat1611v16bfloat16(%struct.v32bfloat16 %a0.coerce, %struct.v16bfloat16 %a1.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v32bfloat16, align 32
  %a0 = alloca %struct.v32bfloat16, align 32
  %a1 = alloca %struct.v16bfloat16, align 32
  store %struct.v32bfloat16 %a0.coerce, ptr %a0, align 32
  store %struct.v16bfloat16 %a1.coerce, ptr %a1, align 32
  %0 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2072
  %1 = load %struct.v16bfloat16, ptr %a1, align 32, !tbaa !2167
  %call = call x86_regcallcc addrspace(1) %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_upd_xl_v32bfloat16_v16bfloat16(%struct.v32bfloat16 %0, %struct.v16bfloat16 %1) #23
  %2 = getelementptr inbounds %struct.v32bfloat16, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v32bfloat16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  %4 = load %struct.v32bfloat16, ptr %retval, align 32
  ret %struct.v32bfloat16 %4
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v32bfloat16 @_ZN12me_primitive6upd_xhE11v32bfloat1611v16bfloat16(%struct.v32bfloat16 %a0.coerce, %struct.v16bfloat16 %a1.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v32bfloat16, align 32
  %a0 = alloca %struct.v32bfloat16, align 32
  %a1 = alloca %struct.v16bfloat16, align 32
  store %struct.v32bfloat16 %a0.coerce, ptr %a0, align 32
  store %struct.v16bfloat16 %a1.coerce, ptr %a1, align 32
  %0 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2072
  %1 = load %struct.v16bfloat16, ptr %a1, align 32, !tbaa !2167
  %call = call x86_regcallcc addrspace(1) %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_upd_xh_v32bfloat16_v16bfloat16(%struct.v32bfloat16 %0, %struct.v16bfloat16 %1) #23
  %2 = getelementptr inbounds %struct.v32bfloat16, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v32bfloat16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  %4 = load %struct.v32bfloat16, ptr %retval, align 32
  ret %struct.v32bfloat16 %4
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_upd_xl_v32bfloat16_v16bfloat16(%struct.v32bfloat16, %struct.v16bfloat16) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_upd_xh_v32bfloat16_v16bfloat16(%struct.v32bfloat16, %struct.v16bfloat16) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16bfloat16 @_ZN12me_primitive3srsE11v16accfloat7uint4_t7uint5_t(%struct.v16accfloat %a0.coerce, %struct.ipd.custom_type.uint4_t.uint4_t %a1.coerce, %struct.ipd.custom_type.uint5_t.uint5_t %a2.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16bfloat16, align 32
  %a0 = alloca %struct.v16accfloat, align 32
  %a1 = alloca %struct.ipd.custom_type.uint4_t.uint4_t, align 1
  %a2 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  store %struct.v16accfloat %a0.coerce, ptr %a0, align 32
  store %struct.ipd.custom_type.uint4_t.uint4_t %a1.coerce, ptr %a1, align 1
  store %struct.ipd.custom_type.uint5_t.uint5_t %a2.coerce, ptr %a2, align 4
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2736
  %1 = load %struct.ipd.custom_type.uint4_t.uint4_t, ptr %a1, align 1, !tbaa !2980
  %2 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a2, align 4, !tbaa !2982
  %call = call x86_regcallcc addrspace(1) %struct.v16bfloat16 @__regcall3__chessintr_v16bfloat16_srs_v16accfloat_uint4_t_uint5_t(%struct.v16accfloat %0, %struct.ipd.custom_type.uint4_t.uint4_t %1, %struct.ipd.custom_type.uint5_t.uint5_t %2) #23
  %3 = getelementptr inbounds %struct.v16bfloat16, ptr %retval, i32 0, i32 0
  %4 = extractvalue %struct.v16bfloat16 %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %4, ptr %3, align 32
  %5 = load %struct.v16bfloat16, ptr %retval, align 32
  ret %struct.v16bfloat16 %5
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local i32 @_Z7get_rndv() addrspace(1) #6 comdat {
entry:
  %0 = load i32, ptr @_ZN12me_primitive11control_rndE, align 4, !tbaa !1721
  ret i32 %0
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7uint4_tC2Ej(ptr nonnull align 1 dereferenceable(1) %this, i32 %a) unnamed_addr addrspace(1) #11 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  store i32 %a, ptr %a.addr, align 4, !tbaa !1721
  %this1 = load ptr, ptr %this.addr, align 4
  store i4 0, ptr %this1, align 1
  %0 = load i32, ptr %a.addr, align 4, !tbaa !1721
  %1 = call addrspace(1) %struct.ipd.custom_type.uint4_t.uint4_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint4_t.uint4_ts.i32.p1(%struct.ipd.custom_type.uint4_t.uint4_t undef, i32 %0, i32 4, i32 32, i1 false, i32 0, ptr addrspace(1) @__regcall3__chessintr_uint4_t_uint4_t___uint)
  store %struct.ipd.custom_type.uint4_t.uint4_t %1, ptr %this1, align 1
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local i32 @_Z14get_fp2bf_maskv() addrspace(1) #6 comdat {
entry:
  %ref.tmp = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %ref.tmp) #20
  %0 = load volatile %struct.ipd.custom_type.uint5_t.uint5_t, ptr !register !1478, align 4, !tbaa !2982, !chess_protect_access !2988
  store %struct.ipd.custom_type.uint5_t.uint5_t %0, ptr %ref.tmp, align 4, !tbaa !2982
  %call = call noundef addrspace(1) i32 @_ZNK7uint5_tcvjEv(ptr nonnull align 4 dereferenceable(1) %ref.tmp) #22
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %ref.tmp) #20
  ret i32 %call
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %this, i32 %a) unnamed_addr addrspace(1) #11 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  store i32 %a, ptr %a.addr, align 4, !tbaa !1721
  %this1 = load ptr, ptr %this.addr, align 4
  store i5 0, ptr %this1, align 4
  %0 = load i32, ptr %a.addr, align 4, !tbaa !1721
  %1 = call addrspace(1) %struct.ipd.custom_type.uint5_t.uint5_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint5_t.uint5_ts.i32.p1(%struct.ipd.custom_type.uint5_t.uint5_t undef, i32 %0, i32 5, i32 32, i1 false, i32 0, ptr addrspace(1) @__regcall3__chessintr_uint5_t_uint5_t___uint)
  store %struct.ipd.custom_type.uint5_t.uint5_t %1, ptr %this1, align 4
  ret void
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16bfloat16 @__regcall3__chessintr_v16bfloat16_srs_v16accfloat_uint4_t_uint5_t(%struct.v16accfloat, %struct.ipd.custom_type.uint4_t.uint4_t, %struct.ipd.custom_type.uint5_t.uint5_t) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.uint4_t.uint4_t @__regcall3__chessintr_uint4_t_uint4_t___uint(i32 zeroext) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare %struct.ipd.custom_type.uint4_t.uint4_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint4_t.uint4_ts.i32.p1(%struct.ipd.custom_type.uint4_t.uint4_t, i32, i32, i32, i1, i32, ptr addrspace(1)) addrspace(1) #7

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local noundef i32 @_ZNK7uint5_tcvjEv(ptr nonnull align 4 dereferenceable(1) %this) addrspace(1) #6 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %r = alloca i32, align 4
  %tmp = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %r, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %r) #20
  store i32 0, ptr %r, align 4, !tbaa !1721
  %0 = load i32, ptr %r, align 4, !tbaa !1721
  %1 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %this1, align 4, !tbaa !2982
  store %struct.ipd.custom_type.uint5_t.uint5_t %1, ptr %tmp, align 4, !tbaa !2982
  %2 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %tmp, align 4
  %3 = call addrspace(1) i32 @llvm.chess.convert.customint.i32.s_struct.ipd.custom_type.uint5_t.uint5_ts.p1(i32 undef, %struct.ipd.custom_type.uint5_t.uint5_t %2, i32 32, i32 5, i1 false, i32 0, ptr addrspace(1) @__regcall3__chessintr___uint___uint_uint5_t)
  store i32 %3, ptr %r, align 4
  %4 = load i32, ptr %r, align 4, !tbaa !1721
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %r) #20
  ret i32 %4
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc zeroext i32 @__regcall3__chessintr___uint___uint_uint5_t(%struct.ipd.custom_type.uint5_t.uint5_t) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare i32 @llvm.chess.convert.customint.i32.s_struct.ipd.custom_type.uint5_t.uint5_ts.p1(i32, %struct.ipd.custom_type.uint5_t.uint5_t, i32, i32, i1, i32, ptr addrspace(1)) addrspace(1) #7

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.uint5_t.uint5_t @__regcall3__chessintr_uint5_t_uint5_t___uint(i32 zeroext) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare %struct.ipd.custom_type.uint5_t.uint5_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint5_t.uint5_ts.i32.p1(%struct.ipd.custom_type.uint5_t.uint5_t, i32, i32, i32, i1, i32, ptr addrspace(1)) addrspace(1) #7

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_v16accfloat_v16float(%struct.v16float) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 %sgn_x, i32 %sgn_y, i32 %amode, i32 %bmode, i32 %variant, i32 %zero_acc, i32 %shift16, i32 %sub0, i32 %sub1, i32 %sub2, i32 %sub_mask) addrspace(1) #6 comdat {
entry:
  %sgn_x.addr = alloca i32, align 4
  %sgn_y.addr = alloca i32, align 4
  %amode.addr = alloca i32, align 4
  %bmode.addr = alloca i32, align 4
  %variant.addr = alloca i32, align 4
  %zero_acc.addr = alloca i32, align 4
  %shift16.addr = alloca i32, align 4
  %sub0.addr = alloca i32, align 4
  %sub1.addr = alloca i32, align 4
  %sub2.addr = alloca i32, align 4
  %sub_mask.addr = alloca i32, align 4
  store i32 %sgn_x, ptr %sgn_x.addr, align 4, !tbaa !1721
  store i32 %sgn_y, ptr %sgn_y.addr, align 4, !tbaa !1721
  store i32 %amode, ptr %amode.addr, align 4, !tbaa !1721
  store i32 %bmode, ptr %bmode.addr, align 4, !tbaa !1721
  store i32 %variant, ptr %variant.addr, align 4, !tbaa !1721
  store i32 %zero_acc, ptr %zero_acc.addr, align 4, !tbaa !1721
  store i32 %shift16, ptr %shift16.addr, align 4, !tbaa !1721
  store i32 %sub0, ptr %sub0.addr, align 4, !tbaa !1721
  store i32 %sub1, ptr %sub1.addr, align 4, !tbaa !1721
  store i32 %sub2, ptr %sub2.addr, align 4, !tbaa !1721
  store i32 %sub_mask, ptr %sub_mask.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %sub_mask.addr, align 4, !tbaa !1721
  %shl = shl i32 %0, 16
  %1 = load i32, ptr %shift16.addr, align 4, !tbaa !1721
  %shl1 = shl i32 %1, 10
  %or = or i32 %shl, %shl1
  %2 = load i32, ptr %sub0.addr, align 4, !tbaa !1721
  %shl2 = shl i32 %2, 11
  %or3 = or i32 %or, %shl2
  %3 = load i32, ptr %sub1.addr, align 4, !tbaa !1721
  %shl4 = shl i32 %3, 12
  %or5 = or i32 %or3, %shl4
  %4 = load i32, ptr %sub2.addr, align 4, !tbaa !1721
  %shl6 = shl i32 %4, 13
  %or7 = or i32 %or5, %shl6
  %5 = load i32, ptr %amode.addr, align 4, !tbaa !1721
  %shl8 = shl i32 %5, 1
  %or9 = or i32 %or7, %shl8
  %6 = load i32, ptr %bmode.addr, align 4, !tbaa !1721
  %shl10 = shl i32 %6, 3
  %or11 = or i32 %or9, %shl10
  %7 = load i32, ptr %variant.addr, align 4, !tbaa !1721
  %shl12 = shl i32 %7, 5
  %or13 = or i32 %or11, %shl12
  %8 = load i32, ptr %sgn_x.addr, align 4, !tbaa !1721
  %shl14 = shl i32 %8, 9
  %9 = load i32, ptr %sgn_y.addr, align 4, !tbaa !1721
  %shl15 = shl i32 %9, 8
  %or16 = or i32 %shl14, %shl15
  %or17 = or i32 %or13, %or16
  %10 = load i32, ptr %zero_acc.addr, align 4, !tbaa !1721
  %shl18 = shl i32 %10, 0
  %or19 = or i32 %or17, %shl18
  ret i32 %or19
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN12me_primitive10mac16_confE11v32bfloat16S0_11v16accfloati7uint1_t7uint5_t(%struct.v32bfloat16 %a0.coerce, %struct.v32bfloat16 %a1.coerce, %struct.v16accfloat %a2.coerce, i32 %a3, %struct.ipd.custom_type.uint1_t.uint1_t %a4.coerce, %struct.ipd.custom_type.uint5_t.uint5_t %a5.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a0 = alloca %struct.v32bfloat16, align 32
  %a1 = alloca %struct.v32bfloat16, align 32
  %a2 = alloca %struct.v16accfloat, align 32
  %a4 = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %a5 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  %a3.addr = alloca i32, align 4
  store %struct.v32bfloat16 %a0.coerce, ptr %a0, align 32
  store %struct.v32bfloat16 %a1.coerce, ptr %a1, align 32
  store %struct.v16accfloat %a2.coerce, ptr %a2, align 32
  store %struct.ipd.custom_type.uint1_t.uint1_t %a4.coerce, ptr %a4, align 4
  store %struct.ipd.custom_type.uint5_t.uint5_t %a5.coerce, ptr %a5, align 4
  store i32 %a3, ptr %a3.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %a3.addr, align 4, !tbaa !1721
  %1 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2072
  %2 = load %struct.v32bfloat16, ptr %a1, align 32, !tbaa !2072
  %3 = load %struct.v16accfloat, ptr %a2, align 32, !tbaa !2736
  %4 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a4, align 4, !tbaa !2984
  %5 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a5, align 4, !tbaa !2982
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_mac16_conf_v32bfloat16_v32bfloat16_v16accfloat___sint_uint1_t_uint5_t(%struct.v32bfloat16 %1, %struct.v32bfloat16 %2, %struct.v16accfloat %3, i32 signext %0, %struct.ipd.custom_type.uint1_t.uint1_t %4, %struct.ipd.custom_type.uint5_t.uint5_t %5) #23
  %6 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %7 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %7, ptr %6, align 32
  %8 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %8
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %this, i32 %a) unnamed_addr addrspace(1) #11 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  store i32 %a, ptr %a.addr, align 4, !tbaa !1721
  %this1 = load ptr, ptr %this.addr, align 4
  store i1 false, ptr %this1, align 4
  %0 = load i32, ptr %a.addr, align 4, !tbaa !1721
  %1 = call addrspace(1) %struct.ipd.custom_type.uint1_t.uint1_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint1_t.uint1_ts.i32.p1(%struct.ipd.custom_type.uint1_t.uint1_t undef, i32 %0, i32 1, i32 32, i1 true, i32 0, ptr addrspace(1) @__regcall3__chessintr_uint1_t_uint1_t___sint)
  store %struct.ipd.custom_type.uint1_t.uint1_t %1, ptr %this1, align 4
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local i32 @_Z17get_fpmulmac_maskv() addrspace(1) #6 comdat {
entry:
  %ref.tmp = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %ref.tmp) #20
  %0 = load volatile %struct.ipd.custom_type.uint5_t.uint5_t, ptr !register !1479, align 4, !tbaa !2982, !chess_protect_access !2988
  store %struct.ipd.custom_type.uint5_t.uint5_t %0, ptr %ref.tmp, align 4, !tbaa !2982
  %call = call noundef addrspace(1) i32 @_ZNK7uint5_tcvjEv(ptr nonnull align 4 dereferenceable(1) %ref.tmp) #22
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %ref.tmp) #20
  ret i32 %call
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_mac16_conf_v32bfloat16_v32bfloat16_v16accfloat___sint_uint1_t_uint5_t(%struct.v32bfloat16, %struct.v32bfloat16, %struct.v16accfloat, i32 signext, %struct.ipd.custom_type.uint1_t.uint1_t, %struct.ipd.custom_type.uint5_t.uint5_t) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.uint1_t.uint1_t @__regcall3__chessintr_uint1_t_uint1_t___sint(i32 signext) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare %struct.ipd.custom_type.uint1_t.uint1_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint1_t.uint1_ts.i32.p1(%struct.ipd.custom_type.uint1_t.uint1_t, i32, i32, i32, i1, i32, ptr addrspace(1)) addrspace(1) #7

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN12me_primitive13addmac16_confE11v32bfloat16S0_11v16accfloatS1_i7uint1_t7uint5_t(%struct.v32bfloat16 %a0.coerce, %struct.v32bfloat16 %a1.coerce, %struct.v16accfloat %a2.coerce, %struct.v16accfloat %a3.coerce, i32 %a4, %struct.ipd.custom_type.uint1_t.uint1_t %a5.coerce, %struct.ipd.custom_type.uint5_t.uint5_t %a6.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a0 = alloca %struct.v32bfloat16, align 32
  %a1 = alloca %struct.v32bfloat16, align 32
  %a2 = alloca %struct.v16accfloat, align 32
  %a3 = alloca %struct.v16accfloat, align 32
  %a5 = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %a6 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  %a4.addr = alloca i32, align 4
  store %struct.v32bfloat16 %a0.coerce, ptr %a0, align 32
  store %struct.v32bfloat16 %a1.coerce, ptr %a1, align 32
  store %struct.v16accfloat %a2.coerce, ptr %a2, align 32
  store %struct.v16accfloat %a3.coerce, ptr %a3, align 32
  store %struct.ipd.custom_type.uint1_t.uint1_t %a5.coerce, ptr %a5, align 4
  store %struct.ipd.custom_type.uint5_t.uint5_t %a6.coerce, ptr %a6, align 4
  store i32 %a4, ptr %a4.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %a4.addr, align 4, !tbaa !1721
  %1 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2072
  %2 = load %struct.v32bfloat16, ptr %a1, align 32, !tbaa !2072
  %3 = load %struct.v16accfloat, ptr %a2, align 32, !tbaa !2736
  %4 = load %struct.v16accfloat, ptr %a3, align 32, !tbaa !2736
  %5 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a5, align 4, !tbaa !2984
  %6 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a6, align 4, !tbaa !2982
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_addmac16_conf_v32bfloat16_v32bfloat16_v16accfloat_v16accfloat___sint_uint1_t_uint5_t(%struct.v32bfloat16 %1, %struct.v32bfloat16 %2, %struct.v16accfloat %3, %struct.v16accfloat %4, i32 signext %0, %struct.ipd.custom_type.uint1_t.uint1_t %5, %struct.ipd.custom_type.uint5_t.uint5_t %6) #23
  %7 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %8 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %8, ptr %7, align 32
  %9 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %9
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_addmac16_conf_v32bfloat16_v32bfloat16_v16accfloat_v16accfloat___sint_uint1_t_uint5_t(%struct.v32bfloat16, %struct.v32bfloat16, %struct.v16accfloat, %struct.v16accfloat, i32 signext, %struct.ipd.custom_type.uint1_t.uint1_t, %struct.ipd.custom_type.uint5_t.uint5_t) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN12me_primitive10mul16_confE11v32bfloat16S0_i7uint1_t7uint5_t(%struct.v32bfloat16 %a0.coerce, %struct.v32bfloat16 %a1.coerce, i32 %a2, %struct.ipd.custom_type.uint1_t.uint1_t %a3.coerce, %struct.ipd.custom_type.uint5_t.uint5_t %a4.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a0 = alloca %struct.v32bfloat16, align 32
  %a1 = alloca %struct.v32bfloat16, align 32
  %a3 = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %a4 = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  %a2.addr = alloca i32, align 4
  store %struct.v32bfloat16 %a0.coerce, ptr %a0, align 32
  store %struct.v32bfloat16 %a1.coerce, ptr %a1, align 32
  store %struct.ipd.custom_type.uint1_t.uint1_t %a3.coerce, ptr %a3, align 4
  store %struct.ipd.custom_type.uint5_t.uint5_t %a4.coerce, ptr %a4, align 4
  store i32 %a2, ptr %a2.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %a2.addr, align 4, !tbaa !1721
  %1 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2072
  %2 = load %struct.v32bfloat16, ptr %a1, align 32, !tbaa !2072
  %3 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a3, align 4, !tbaa !2984
  %4 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a4, align 4, !tbaa !2982
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_mul16_conf_v32bfloat16_v32bfloat16___sint_uint1_t_uint5_t(%struct.v32bfloat16 %1, %struct.v32bfloat16 %2, i32 signext %0, %struct.ipd.custom_type.uint1_t.uint1_t %3, %struct.ipd.custom_type.uint5_t.uint5_t %4) #23
  %5 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %6 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %6, ptr %5, align 32
  %7 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %7
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_mul16_conf_v32bfloat16_v32bfloat16___sint_uint1_t_uint5_t(%struct.v32bfloat16, %struct.v32bfloat16, i32 signext, %struct.ipd.custom_type.uint1_t.uint1_t, %struct.ipd.custom_type.uint5_t.uint5_t) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZNK3aie6vectorIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !2989 {
entry:
  %retval = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2991, metadata !DIExpression()), !dbg !2992
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v16float @_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this1) #22, !dbg !2993
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !2993
  %1 = extractvalue %struct.v16float %call, 0, !dbg !2993
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !2993
  %2 = load %struct.v16float, ptr %retval, align 32, !dbg !2994
  ret %struct.v16float %2, !dbg !2994
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !2995 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2997, metadata !DIExpression()), !dbg !2998
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %this1, i32 0, i32 0, !dbg !2999
  %0 = load %struct.v16float, ptr %data, align 32, !dbg !2999, !tbaa !2072
  ret %struct.v16float %0, !dbg !2999
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !3001 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3003, metadata !DIExpression()), !dbg !3005
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base.10", ptr %this1, i32 0, i32 0, !dbg !3006
  %0 = load %struct.v16accfloat, ptr %data, align 32, !dbg !3006, !tbaa !2736
  ret %struct.v16accfloat %0, !dbg !3006
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3007 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector.0", align 32
  %ref.tmp = alloca %"class.aie::detail::vector_base.1", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3010, metadata !DIExpression()), !dbg !3012
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3011, metadata !DIExpression()), !dbg !3013
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #20, !dbg !3014
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3015, !tbaa !1721
  %call = call addrspace(1) %"class.aie::detail::vector_base.1" @_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0) #22, !dbg !3016
  %1 = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %ref.tmp, i32 0, i32 0, !dbg !3016
  %2 = extractvalue %"class.aie::detail::vector_base.1" %call, 0, !dbg !3016
  store %struct.v16float %2, ptr %1, align 32, !dbg !3016
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, ptr nonnull align 32 dereferenceable(64) %ref.tmp) #22, !dbg !3017
  %3 = load %"class.aie::vector.0", ptr %custom_type.tmp, align 32, !dbg !3017, !tbaa !2061
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #20, !dbg !3018
  ret %"class.aie::vector.0" %3, !dbg !3017
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base.1" @_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3019 {
entry:
  %retval = alloca %"class.aie::detail::vector_base.1", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %output_bits = alloca i32, align 4
  %growth_ratio = alloca i32, align 4
  %in_storage_elems = alloca i32, align 4
  %out_storage_elems = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::detail::vector_base.1", align 32
  %agg.tmp = alloca %struct.v16float, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3024, metadata !DIExpression()), !dbg !3031
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3025, metadata !DIExpression()), !dbg !3032
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %output_bits, align 4, !dbg !3033
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %output_bits) #20, !dbg !3033
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %output_bits, metadata !3026, metadata !DIExpression()), !dbg !3034
  store i32 512, ptr %output_bits, align 4, !dbg !3034, !tbaa !1721
  store i32 undef, ptr %growth_ratio, align 4, !dbg !3035
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %growth_ratio) #20, !dbg !3035
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %growth_ratio, metadata !3027, metadata !DIExpression()), !dbg !3036
  store i32 2, ptr %growth_ratio, align 4, !dbg !3036, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3028, metadata !DIExpression()), !dbg !3037
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %retval) #22, !dbg !3037
  store i32 undef, ptr %in_storage_elems, align 4, !dbg !3038
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %in_storage_elems) #20, !dbg !3038
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in_storage_elems, metadata !3029, metadata !DIExpression()), !dbg !3039
  store i32 1, ptr %in_storage_elems, align 4, !dbg !3039, !tbaa !1721
  store i32 undef, ptr %out_storage_elems, align 4, !dbg !3040
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %out_storage_elems) #20, !dbg !3040
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out_storage_elems, metadata !3030, metadata !DIExpression()), !dbg !3041
  store i32 1, ptr %out_storage_elems, align 4, !dbg !3041, !tbaa !1721
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #20, !dbg !3042
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !3046
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3047, !tbaa !1721
  %call = call addrspace(1) %struct.v16float @_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj(ptr nonnull align 32 dereferenceable(32) %data, i32 noundef %0) #22, !dbg !3042
  %1 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !3042
  %2 = extractvalue %struct.v16float %call, 0, !dbg !3042
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32, !dbg !3042
  %3 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !3042, !tbaa !2072
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %ref.tmp, %struct.v16float %3) #22, !dbg !3042
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %retval, ptr align 32 %ref.tmp, i32 64, i1 false), !dbg !3048, !tbaa !3049, !tbaa.struct !3050
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #20, !dbg !3051
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %out_storage_elems) #20, !dbg !3052
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %in_storage_elems) #20, !dbg !3052
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %growth_ratio) #20, !dbg !3052
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %output_bits) #20, !dbg !3052
  %4 = load %"class.aie::detail::vector_base.1", ptr %retval, align 32, !dbg !3052
  ret %"class.aie::detail::vector_base.1" %4, !dbg !3052
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE(ptr nonnull align 32 dereferenceable(64) %this, ptr nonnull align 32 dereferenceable(64) %v) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3053 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3055, metadata !DIExpression()), !dbg !3057
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3056, metadata !DIExpression()), !dbg !3058
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %v.addr, align 4, !dbg !3059, !tbaa !1512
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %this1, ptr align 32 %0, i32 64, i1 false), !dbg !3060, !tbaa !3049, !tbaa.struct !3050
  ret void, !dbg !3061
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3062 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3064, metadata !DIExpression()), !dbg !3066
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %this1, i32 0, i32 0, !dbg !3067
  %call = call addrspace(1) %struct.v16float @_ZN3aie6detail14vector_storageIfLj16EE5undefEv() #22, !dbg !3068
  %0 = getelementptr inbounds %struct.v16float, ptr %data, i32 0, i32 0, !dbg !3068
  %1 = extractvalue %struct.v16float %call, 0, !dbg !3068
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !3068
  ret void, !dbg !3069
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj(ptr nonnull align 32 dereferenceable(32) %v, i32 noundef %idx) addrspace(1) #9 comdat align 2 !dbg !3070 {
entry:
  %retval = alloca %struct.v16float, align 32
  %v.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3085, metadata !DIExpression()), !dbg !3087
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3086, metadata !DIExpression()), !dbg !3088
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3089, !tbaa !1721
  %1 = load ptr, ptr %v.addr, align 4, !dbg !3090, !tbaa !1512
  %2 = load %struct.v8float, ptr %1, align 32, !dbg !3091, !tbaa !2167
  %call = call addrspace(1) %struct.v16float @_Z12set_v16floati7v8float(i32 %0, %struct.v8float %2) #22, !dbg !3091
  %3 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !3091
  %4 = extractvalue %struct.v16float %call, 0, !dbg !3091
  store %struct.ipd.custom_type.v128int4.v128int4 %4, ptr %3, align 32, !dbg !3091
  %5 = load %struct.v16float, ptr %retval, align 32, !dbg !3092
  ret %struct.v16float %5, !dbg !3092
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16float %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3093 {
entry:
  %data = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16float %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3095, metadata !DIExpression()), !dbg !3097
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !3096, metadata !DIExpression()), !dbg !3098
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %this1, i32 0, i32 0, !dbg !3099
  %0 = load %struct.v16float, ptr %data, align 32, !dbg !3100, !tbaa !2072
  store %struct.v16float %0, ptr %data2, align 32, !dbg !3100, !tbaa !2072
  ret void, !dbg !3101
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z12set_v16floati7v8float(i32 %idx, %struct.v8float %b.coerce) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %b = alloca %struct.v8float, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v8float %b.coerce, ptr %b, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1721
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v8float, ptr %b, align 32, !tbaa !2167
  %call = call addrspace(1) %struct.v16float @_ZN12me_primitive6set_xlE7v8float(%struct.v8float %1) #24
  %2 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  br label %return

if.else:                                          ; preds = %entry
  %4 = load %struct.v8float, ptr %b, align 32, !tbaa !2167
  %call1 = call addrspace(1) %struct.v16float @_ZN12me_primitive6set_xhE7v8float(%struct.v8float %4) #24
  %5 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0
  %6 = extractvalue %struct.v16float %call1, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %6, ptr %5, align 32
  br label %return

return:                                           ; preds = %if.else, %if.then
  %7 = load %struct.v16float, ptr %retval, align 32
  ret %struct.v16float %7
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZN12me_primitive6set_xlE7v8float(%struct.v8float %a0.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %a0 = alloca %struct.v8float, align 32
  store %struct.v8float %a0.coerce, ptr %a0, align 32
  %0 = load %struct.v8float, ptr %a0, align 32, !tbaa !2167
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_set_xl_v8float(%struct.v8float %0) #23
  %1 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32
  %3 = load %struct.v16float, ptr %retval, align 32
  ret %struct.v16float %3
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZN12me_primitive6set_xhE7v8float(%struct.v8float %a0.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %a0 = alloca %struct.v8float, align 32
  store %struct.v8float %a0.coerce, ptr %a0, align 32
  %0 = load %struct.v8float, ptr %a0, align 32, !tbaa !2167
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_set_xh_v8float(%struct.v8float %0) #23
  %1 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32
  %3 = load %struct.v16float, ptr %retval, align 32
  ret %struct.v16float %3
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16float @__regcall3__chessintr_v16float_set_xl_v8float(%struct.v8float) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16float @__regcall3__chessintr_v16float_set_xh_v8float(%struct.v8float) addrspace(1) #14

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local noundef i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv(ptr nonnull align 1 dereferenceable(1) %this) addrspace(1) #9 comdat align 2 !dbg !3102 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3104, metadata !DIExpression()), !dbg !3105
  %this1 = load ptr, ptr %this.addr, align 4
  ret i32 0, !dbg !3106
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum.9" @_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !3107 {
entry:
  %this.addr = alloca ptr, align 4
  %custom_type.tmp = alloca %"class.aie::accum.9", align 32
  %ref.tmp = alloca %"class.aie::detail::accum_base.10", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3112, metadata !DIExpression()), !dbg !3113
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #20, !dbg !3114
  %call = call addrspace(1) %"class.aie::detail::accum_base.10" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv(ptr nonnull align 32 dereferenceable(32) %this1) #22, !dbg !3115
  %0 = getelementptr inbounds %"class.aie::detail::accum_base.10", ptr %ref.tmp, i32 0, i32 0, !dbg !3115
  %1 = extractvalue %"class.aie::detail::accum_base.10" %call, 0, !dbg !3115
  store %struct.v16accfloat %1, ptr %0, align 32, !dbg !3115
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, ptr nonnull align 32 dereferenceable(64) %ref.tmp) #22, !dbg !3116
  %2 = load %"class.aie::accum.9", ptr %custom_type.tmp, align 32, !dbg !3116, !tbaa !2738
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #20, !dbg !3117
  ret %"class.aie::accum.9" %2, !dbg !3116
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::accum_base.10" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !3118 {
entry:
  %retval = alloca %"class.aie::detail::accum_base.10", align 32
  %this.addr = alloca ptr, align 4
  %in_num_subaccums = alloca i32, align 4
  %out_num_subaccums = alloca i32, align 4
  %growth_ratio = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::detail::accum_base.10", align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %agg.tmp2 = alloca %struct.v8accfloat, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3123, metadata !DIExpression()), !dbg !3129
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %in_num_subaccums, align 4, !dbg !3130
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %in_num_subaccums) #20, !dbg !3130
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in_num_subaccums, metadata !3125, metadata !DIExpression()), !dbg !3131
  store i32 1, ptr %in_num_subaccums, align 4, !dbg !3131, !tbaa !1721
  store i32 undef, ptr %out_num_subaccums, align 4, !dbg !3132
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %out_num_subaccums) #20, !dbg !3132
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out_num_subaccums, metadata !3126, metadata !DIExpression()), !dbg !3133
  store i32 1, ptr %out_num_subaccums, align 4, !dbg !3133, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3127, metadata !DIExpression()), !dbg !3134
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %retval) #22, !dbg !3134
  store i32 undef, ptr %growth_ratio, align 4, !dbg !3135
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %growth_ratio) #20, !dbg !3135
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %growth_ratio, metadata !3128, metadata !DIExpression()), !dbg !3136
  store i32 2, ptr %growth_ratio, align 4, !dbg !3136, !tbaa !1721
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #20, !dbg !3137
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !3142
  %call = call addrspace(1) %struct.v8accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv() #22, !dbg !3143
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %agg.tmp2, i32 0, i32 0, !dbg !3143
  %1 = extractvalue %struct.v8accfloat %call, 0, !dbg !3143
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32, !dbg !3143
  %2 = load %struct.v8accfloat, ptr %data, align 32, !dbg !3137, !tbaa !3144
  %3 = load %struct.v8accfloat, ptr %agg.tmp2, align 32, !dbg !3137, !tbaa !2258
  %call3 = call addrspace(1) %struct.v16accfloat @_Z6concat10v8accfloatS_(%struct.v8accfloat %2, %struct.v8accfloat %3) #22, !dbg !3137
  %4 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !3137
  %5 = extractvalue %struct.v16accfloat %call3, 0, !dbg !3137
  store %struct.ipd.custom_type.v16acc32.v16acc32 %5, ptr %4, align 32, !dbg !3137
  %6 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !3137, !tbaa !2736
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %ref.tmp, %struct.v16accfloat %6) #22, !dbg !3137
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %retval, ptr align 32 %ref.tmp, i32 64, i1 false), !dbg !3145, !tbaa !3146, !tbaa.struct !3050
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #20, !dbg !3147
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %growth_ratio) #20, !dbg !3148
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %out_num_subaccums) #20, !dbg !3148
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %in_num_subaccums) #20, !dbg !3148
  %7 = load %"class.aie::detail::accum_base.10", ptr %retval, align 32, !dbg !3148
  ret %"class.aie::detail::accum_base.10" %7, !dbg !3148
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE(ptr nonnull align 32 dereferenceable(64) %this, ptr nonnull align 32 dereferenceable(64) %a) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3149 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3151, metadata !DIExpression()), !dbg !3153
  store ptr %a, ptr %a.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3152, metadata !DIExpression()), !dbg !3154
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %a.addr, align 4, !dbg !3155, !tbaa !1512
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %this1, ptr align 32 %0, i32 64, i1 false), !dbg !3156, !tbaa !3146, !tbaa.struct !3050
  ret void, !dbg !3157
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3158 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3160, metadata !DIExpression()), !dbg !3162
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base.10", ptr %this1, i32 0, i32 0, !dbg !3163
  %call = call addrspace(1) %struct.v16accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv() #22, !dbg !3164
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %data, i32 0, i32 0, !dbg !3164
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !3164
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !3164
  ret void, !dbg !3165
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z6concat10v8accfloatS_(%struct.v8accfloat %a0.coerce, %struct.v8accfloat %a1.coerce) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a0 = alloca %struct.v8accfloat, align 32
  %a1 = alloca %struct.v8accfloat, align 32
  store %struct.v8accfloat %a0.coerce, ptr %a0, align 32
  store %struct.v8accfloat %a1.coerce, ptr %a1, align 32
  %0 = load %struct.v8accfloat, ptr %a0, align 32, !tbaa !2258
  %1 = load %struct.v8accfloat, ptr %a1, align 32, !tbaa !2258
  %call = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive12concat_bm_amE10v8accfloatS0_(%struct.v8accfloat %0, %struct.v8accfloat %1) #24
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %4
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16accfloat %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3166 {
entry:
  %data = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16accfloat %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3168, metadata !DIExpression()), !dbg !3170
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !3169, metadata !DIExpression()), !dbg !3171
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::accum_base.10", ptr %this1, i32 0, i32 0, !dbg !3172
  %0 = load %struct.v16accfloat, ptr %data, align 32, !dbg !3173, !tbaa !2736
  store %struct.v16accfloat %0, ptr %data2, align 32, !dbg !3173, !tbaa !2736
  ret void, !dbg !3174
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !3175 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %call = call addrspace(1) %struct.v16accfloat @_Z17undef_v16accfloatv() #22, !dbg !3176
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !3176
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !3176
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !3176
  %2 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !3177
  ret %struct.v16accfloat %2, !dbg !3177
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z17undef_v16accfloatv() addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_undef_v16accfloat() #23
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %1 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32
  %2 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %2
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_undef_v16accfloat() addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN12me_primitive12concat_bm_amE10v8accfloatS0_(%struct.v8accfloat %a0.coerce, %struct.v8accfloat %a1.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a0 = alloca %struct.v8accfloat, align 32
  %a1 = alloca %struct.v8accfloat, align 32
  store %struct.v8accfloat %a0.coerce, ptr %a0, align 32
  store %struct.v8accfloat %a1.coerce, ptr %a1, align 32
  %0 = load %struct.v8accfloat, ptr %a0, align 32, !tbaa !2258
  %1 = load %struct.v8accfloat, ptr %a1, align 32, !tbaa !2258
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_concat_bm_am_v8accfloat_v8accfloat(%struct.v8accfloat %0, %struct.v8accfloat %1) #23
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %4
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_concat_bm_am_v8accfloat_v8accfloat(%struct.v8accfloat, %struct.v8accfloat) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local nonnull align 32 dereferenceable(32) ptr @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !3178 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %acc.addr = alloca ptr, align 4
  %in_num_subaccums = alloca i32, align 4
  %num_subaccums = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3187, metadata !DIExpression()), !dbg !3192
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3188, metadata !DIExpression()), !dbg !3193
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !3189, metadata !DIExpression()), !dbg !3194
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %in_num_subaccums, align 4, !dbg !3195
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %in_num_subaccums) #20, !dbg !3195
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in_num_subaccums, metadata !3190, metadata !DIExpression()), !dbg !3196
  store i32 1, ptr %in_num_subaccums, align 4, !dbg !3196, !tbaa !1721
  store i32 undef, ptr %num_subaccums, align 4, !dbg !3197
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums) #20, !dbg !3197
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums, metadata !3191, metadata !DIExpression()), !dbg !3198
  store i32 1, ptr %num_subaccums, align 4, !dbg !3198, !tbaa !1721
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !3199, !tbaa !1512
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %0, i32 0, i32 0, !dbg !3202
  %data2 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !3203
  %1 = load %struct.v8accfloat, ptr %data, align 32, !dbg !3204, !tbaa !2258
  store %struct.v8accfloat %1, ptr %data2, align 32, !dbg !3204, !tbaa !2258
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums) #20, !dbg !3205
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %in_num_subaccums) #20, !dbg !3205
  ret ptr %this1, !dbg !3206
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::accum_base" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3207 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %fpacc_128b = alloca i8, align 1
  %num_subaccums = alloca i32, align 4
  %num_subaccums_out = alloca i32, align 4
  %elems_per_subaccum = alloca i32, align 4
  %out_elems_per_subaccum = alloca i32, align 4
  %ratio = alloca i32, align 4
  %ret = alloca %"class.aie::detail::accum_base", align 32
  %ref.tmp = alloca %"class.aie::detail::accum_base", align 32
  %agg.tmp = alloca %struct.v8accfloat, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3212, metadata !DIExpression()), !dbg !3223
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3213, metadata !DIExpression()), !dbg !3224
  %this1 = load ptr, ptr %this.addr, align 4
  store i8 undef, ptr %fpacc_128b, align 1, !dbg !3225
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %fpacc_128b) #20, !dbg !3225
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fpacc_128b, metadata !3214, metadata !DIExpression()), !dbg !3226
  store i8 0, ptr %fpacc_128b, align 1, !dbg !3226, !tbaa !2244
  store i32 undef, ptr %num_subaccums, align 4, !dbg !3227
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums) #20, !dbg !3227
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums, metadata !3215, metadata !DIExpression()), !dbg !3228
  store i32 1, ptr %num_subaccums, align 4, !dbg !3228, !tbaa !1721
  store i32 undef, ptr %num_subaccums_out, align 4, !dbg !3229
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums_out) #20, !dbg !3229
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums_out, metadata !3216, metadata !DIExpression()), !dbg !3230
  store i32 1, ptr %num_subaccums_out, align 4, !dbg !3230, !tbaa !1721
  store i32 undef, ptr %elems_per_subaccum, align 4, !dbg !3231
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %elems_per_subaccum) #20, !dbg !3231
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %elems_per_subaccum, metadata !3217, metadata !DIExpression()), !dbg !3232
  store i32 16, ptr %elems_per_subaccum, align 4, !dbg !3232, !tbaa !1721
  store i32 undef, ptr %out_elems_per_subaccum, align 4, !dbg !3233
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %out_elems_per_subaccum) #20, !dbg !3233
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out_elems_per_subaccum, metadata !3220, metadata !DIExpression()), !dbg !3234
  store i32 8, ptr %out_elems_per_subaccum, align 4, !dbg !3234, !tbaa !1721
  store i32 undef, ptr %ratio, align 4, !dbg !3235
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %ratio) #20, !dbg !3235
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ratio, metadata !3221, metadata !DIExpression()), !dbg !3236
  store i32 2, ptr %ratio, align 4, !dbg !3236, !tbaa !1721
  store %"class.aie::detail::accum_base" undef, ptr %ret, align 32, !dbg !3237
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ret) #20, !dbg !3237
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ret, metadata !3222, metadata !DIExpression()), !dbg !3238
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %ret) #22, !dbg !3238
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #20, !dbg !3239
  %data = getelementptr inbounds %"class.aie::detail::accum_base.10", ptr %this1, i32 0, i32 0, !dbg !3247
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3248, !tbaa !1721
  %call = call addrspace(1) %struct.v8accfloat @_ZN3aie6detailL13accum_extractILj8E11v16accfloatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %data, i32 %0) #22, !dbg !3239
  %1 = getelementptr inbounds %struct.v8accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !3239
  %2 = extractvalue %struct.v8accfloat %call, 0, !dbg !3239
  store %struct.ipd.custom_type.v8acc32.v8acc32 %2, ptr %1, align 32, !dbg !3239
  %3 = load %struct.v8accfloat, ptr %agg.tmp, align 32, !dbg !3239, !tbaa !2258
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat(ptr nonnull align 32 dereferenceable(32) %ref.tmp, %struct.v8accfloat %3) #22, !dbg !3239
  %4 = load %"class.aie::detail::accum_base", ptr %ref.tmp, align 32, !dbg !3249, !tbaa !3250
  store %"class.aie::detail::accum_base" %4, ptr %ret, align 32, !dbg !3249, !tbaa !3250
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #20, !dbg !3251
  %5 = load %"class.aie::detail::accum_base", ptr %ret, align 32, !dbg !3252, !tbaa !3250
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ret) #20, !dbg !3253
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %ratio) #20, !dbg !3253
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %out_elems_per_subaccum) #20, !dbg !3253
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %elems_per_subaccum) #20, !dbg !3253
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums_out) #20, !dbg !3254
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums) #20, !dbg !3254
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %fpacc_128b) #20, !dbg !3254
  ret %"class.aie::detail::accum_base" %5, !dbg !3252
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %a) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3255 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3257, metadata !DIExpression()), !dbg !3259
  store ptr %a, ptr %a.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3258, metadata !DIExpression()), !dbg !3260
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %a.addr, align 4, !dbg !3261, !tbaa !1512
  %1 = load %"class.aie::detail::accum_base", ptr %0, align 32, !dbg !3262, !tbaa !3250
  store %"class.aie::detail::accum_base" %1, ptr %this1, align 32, !dbg !3262, !tbaa !3250
  ret void, !dbg !3263
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3264 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3266, metadata !DIExpression()), !dbg !3267
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !3268
  %call = call addrspace(1) %struct.v8accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv() #22, !dbg !3269
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %data, i32 0, i32 0, !dbg !3269
  %1 = extractvalue %struct.v8accfloat %call, 0, !dbg !3269
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32, !dbg !3269
  ret void, !dbg !3270
}

; Function Attrs: alwaysinline mustprogress nounwind
define internal %struct.v8accfloat @_ZN3aie6detailL13accum_extractILj8E11v16accfloatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %acc, i32 %idx) addrspace(1) #6 !dbg !3271 {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %acc.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !3277, metadata !DIExpression()), !dbg !3281
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3278, metadata !DIExpression()), !dbg !3282
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !3283, !tbaa !1512
  %1 = load i32, ptr %idx.addr, align 4, !dbg !3284, !tbaa !1721
  %2 = load %struct.v16accfloat, ptr %0, align 32, !dbg !3285, !tbaa !2736
  %call = call addrspace(1) %struct.v8accfloat @_Z18extract_v8accfloat11v16accfloati(%struct.v16accfloat %2, i32 %1) #22, !dbg !3285
  %3 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0, !dbg !3285
  %4 = extractvalue %struct.v8accfloat %call, 0, !dbg !3285
  store %struct.ipd.custom_type.v8acc32.v8acc32 %4, ptr %3, align 32, !dbg !3285
  %5 = load %struct.v8accfloat, ptr %retval, align 32, !dbg !3286
  ret %struct.v8accfloat %5, !dbg !3286
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat(ptr nonnull align 32 dereferenceable(32) %this, %struct.v8accfloat %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3287 {
entry:
  %data = alloca %struct.v8accfloat, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v8accfloat %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3289, metadata !DIExpression()), !dbg !3291
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !3290, metadata !DIExpression()), !dbg !3292
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !3293
  %0 = load %struct.v8accfloat, ptr %data, align 32, !dbg !3294, !tbaa !2258
  store %struct.v8accfloat %0, ptr %data2, align 32, !dbg !3294, !tbaa !2258
  ret void, !dbg !3295
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_Z18extract_v8accfloat11v16accfloati(%struct.v16accfloat %a.coerce, i32 %idx) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %a = alloca %struct.v16accfloat, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v16accfloat %a.coerce, ptr %a, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1721
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2736
  %call = call addrspace(1) %struct.v8accfloat @_ZN12me_primitive6ext_blE11v16accfloat(%struct.v16accfloat %1) #24
  %2 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v8accfloat %call, 0
  store %struct.ipd.custom_type.v8acc32.v8acc32 %3, ptr %2, align 32
  br label %return

if.else:                                          ; preds = %entry
  %4 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2736
  %call1 = call addrspace(1) %struct.v8accfloat @_ZN12me_primitive6ext_bhE11v16accfloat(%struct.v16accfloat %4) #24
  %5 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0
  %6 = extractvalue %struct.v8accfloat %call1, 0
  store %struct.ipd.custom_type.v8acc32.v8acc32 %6, ptr %5, align 32
  br label %return

return:                                           ; preds = %if.else, %if.then
  %7 = load %struct.v8accfloat, ptr %retval, align 32
  ret %struct.v8accfloat %7
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_ZN12me_primitive6ext_blE11v16accfloat(%struct.v16accfloat %a0.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %a0 = alloca %struct.v16accfloat, align 32
  store %struct.v16accfloat %a0.coerce, ptr %a0, align 32
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2736
  %call = call x86_regcallcc addrspace(1) %struct.v8accfloat @__regcall3__chessintr_v8accfloat_ext_bl_v16accfloat(%struct.v16accfloat %0) #23
  %1 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v8accfloat %call, 0
  store %struct.ipd.custom_type.v8acc32.v8acc32 %2, ptr %1, align 32
  %3 = load %struct.v8accfloat, ptr %retval, align 32
  ret %struct.v8accfloat %3
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_ZN12me_primitive6ext_bhE11v16accfloat(%struct.v16accfloat %a0.coerce) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %a0 = alloca %struct.v16accfloat, align 32
  store %struct.v16accfloat %a0.coerce, ptr %a0, align 32
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2736
  %call = call x86_regcallcc addrspace(1) %struct.v8accfloat @__regcall3__chessintr_v8accfloat_ext_bh_v16accfloat(%struct.v16accfloat %0) #23
  %1 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v8accfloat %call, 0
  store %struct.ipd.custom_type.v8acc32.v8acc32 %2, ptr %1, align 32
  %3 = load %struct.v8accfloat, ptr %retval, align 32
  ret %struct.v8accfloat %3
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8accfloat @__regcall3__chessintr_v8accfloat_ext_bl_v16accfloat(%struct.v16accfloat) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8accfloat @__regcall3__chessintr_v8accfloat_ext_bh_v16accfloat(%struct.v16accfloat) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a) addrspace(1) #6 comdat align 2 !dbg !3296 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %a.addr = alloca ptr, align 4
  %native_broadcast_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::vector.0", align 32
  %agg.tmp = alloca %"class.aie::vector", align 32
  store ptr %a, ptr %a.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3304, metadata !DIExpression()), !dbg !3307
  store i32 undef, ptr %native_broadcast_elems, align 4, !dbg !3308
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_broadcast_elems) #20, !dbg !3308
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_broadcast_elems, metadata !3305, metadata !DIExpression()), !dbg !3309
  store i32 16, ptr %native_broadcast_elems, align 4, !dbg !3309, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3306, metadata !DIExpression()), !dbg !3310
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #22, !dbg !3310
  %0 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !3310, !tbaa !1670
  store %"class.aie::vector" %0, ptr %retval, align 32, !dbg !3310, !tbaa !1670
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #20, !dbg !3311
  %1 = load ptr, ptr %a.addr, align 4, !dbg !3314, !tbaa !1512
  %call = call addrspace(1) %"class.aie::vector.0" @_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf(ptr nonnull align 4 dereferenceable(4) %1) #22, !dbg !3311
  %2 = getelementptr inbounds %"class.aie::vector.0", ptr %ref.tmp, i32 0, i32 0, !dbg !3311
  %3 = extractvalue %"class.aie::vector.0" %call, 0, !dbg !3311
  store %"class.aie::detail::vector_base.1" %3, ptr %2, align 32, !dbg !3311
  %call1 = call addrspace(1) %"class.aie::vector" @_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %ref.tmp, i32 0) #22, !dbg !3315
  %4 = getelementptr inbounds %"class.aie::vector", ptr %agg.tmp, i32 0, i32 0, !dbg !3315
  %5 = extractvalue %"class.aie::vector" %call1, 0, !dbg !3315
  store %"class.aie::detail::vector_base" %5, ptr %4, align 32, !dbg !3315
  %6 = load %"class.aie::vector", ptr %agg.tmp, align 32, !dbg !3316, !tbaa !1670
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #20, !dbg !3317
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_broadcast_elems) #20, !dbg !3318
  ret %"class.aie::vector" %6, !dbg !3316
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.0" @_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a) addrspace(1) #6 comdat align 2 !dbg !3319 {
entry:
  %retval = alloca %"class.aie::vector.0", align 32
  %a.addr = alloca ptr, align 4
  %native_broadcast_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector.0", align 32
  %tmp = alloca %"class.aie::vector.0", align 32
  %agg.tmp = alloca %struct.v16float, align 32
  store ptr %a, ptr %a.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3327, metadata !DIExpression()), !dbg !3330
  store i32 undef, ptr %native_broadcast_elems, align 4, !dbg !3331
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_broadcast_elems) #20, !dbg !3331
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_broadcast_elems, metadata !3328, metadata !DIExpression()), !dbg !3332
  store i32 16, ptr %native_broadcast_elems, align 4, !dbg !3332, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3329, metadata !DIExpression()), !dbg !3333
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp) #22, !dbg !3333
  %0 = load %"class.aie::vector.0", ptr %custom_type.tmp, align 32, !dbg !3333, !tbaa !2061
  store %"class.aie::vector.0" %0, ptr %retval, align 32, !dbg !3333, !tbaa !2061
  %1 = load ptr, ptr %a.addr, align 4, !dbg !3334, !tbaa !1512
  %2 = load float, ptr %1, align 4, !dbg !3334, !tbaa !2569
  %call = call addrspace(1) %struct.v16float @_Z21broadcast_to_v16floatf(float %2) #24, !dbg !3341
  %3 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !3341
  %4 = extractvalue %struct.v16float %call, 0, !dbg !3341
  store %struct.ipd.custom_type.v128int4.v128int4 %4, ptr %3, align 32, !dbg !3341
  %5 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !3341, !tbaa !2072
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %tmp, %struct.v16float %5) #22, !dbg !3341
  %6 = load %"class.aie::vector.0", ptr %tmp, align 32, !dbg !3342, !tbaa !2061
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_broadcast_elems) #20, !dbg !3343
  ret %"class.aie::vector.0" %6, !dbg !3342
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z21broadcast_to_v16floatf(float %a0) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %a0.addr = alloca float, align 4
  store float %a0, ptr %a0.addr, align 4, !tbaa !2569
  %0 = load float, ptr %a0.addr, align 4, !tbaa !2569
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_broadcast_to_v16float___ffloat(float %0) #23
  %1 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32
  %3 = load %struct.v16float, ptr %retval, align 32
  ret %struct.v16float %3
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16float @__regcall3__chessintr_v16float_broadcast_to_v16float___ffloat(float) addrspace(1) #14

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local noundef float @_ZNK3aie21vector_elem_const_refIfLj8EE3getEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #9 comdat align 2 !dbg !3344 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3346, metadata !DIExpression()), !dbg !3347
  %this1 = load ptr, ptr %this.addr, align 4
  %parent = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 0, !dbg !3348
  %0 = load ptr, ptr %parent, align 4, !dbg !3348, !tbaa !3349
  %offset = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 1, !dbg !3350
  %1 = load i32, ptr %offset, align 4, !dbg !3350, !tbaa !2508
  %call = call addrspace(1) float @_ZNK3aie6vectorIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %0, i32 %1) #22, !dbg !3351
  ret float %call, !dbg !3352
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_ZNK3aie6vectorIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3353 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3355, metadata !DIExpression()), !dbg !3357
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3356, metadata !DIExpression()), !dbg !3358
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3359, !tbaa !1721
  %call = call addrspace(1) float @_ZNK3aie6detail11vector_baseIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0) #22, !dbg !3360
  ret float %call, !dbg !3361
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_ZNK3aie6detail11vector_baseIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3362 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %agg.tmp = alloca %struct.v16float, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3364, metadata !DIExpression()), !dbg !3366
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3365, metadata !DIExpression()), !dbg !3367
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !3368

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3369, !tbaa !1721
  %cmp = icmp ult i32 %0, 8, !dbg !3369
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !3369
  br i1 %1, label %if.then, label %if.else, !dbg !3372

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !3373

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !3375, !tbaa !1721
  %cmp3 = icmp ult i32 %2, 8, !dbg !3375
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !3375
  br i1 %3, label %if.end, label %if.then4, !dbg !3378

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !1897), !dbg !3375
  br label %if.end, !dbg !3375

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !3378

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !3373

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3379, !tbaa !1721
  %cmp5 = icmp ult i32 %4, 8, !dbg !3379
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !3379
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !3372

do.end7:                                          ; preds = %if.end6
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !3381
  %call = call addrspace(1) %struct.v16float @_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj(ptr nonnull align 32 dereferenceable(32) %data, i32 noundef 0) #22, !dbg !3387
  %5 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !3387
  %6 = extractvalue %struct.v16float %call, 0, !dbg !3387
  store %struct.ipd.custom_type.v128int4.v128int4 %6, ptr %5, align 32, !dbg !3387
  %7 = load i32, ptr %idx.addr, align 4, !dbg !3388, !tbaa !1721
  %8 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !3389, !tbaa !2072
  %call8 = call addrspace(1) float @_Z12extract_elem8v16floati(%struct.v16float %8, i32 %7) #22, !dbg !3389
  ret float %call8, !dbg !3390
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_Z12extract_elem8v16floati(%struct.v16float %v.coerce, i32 %idx) addrspace(1) #6 comdat {
entry:
  %v = alloca %struct.v16float, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v16float %v.coerce, ptr %v, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1721
  %cmp = icmp slt i32 %0, 0
  br i1 %cmp, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  %1 = load i32, ptr %idx.addr, align 4, !tbaa !1721
  %cmp1 = icmp sge i32 %1, 64
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %entry
  %2 = phi i1 [ true, %entry ], [ %cmp1, %lor.rhs ]
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %2)
  br i1 %3, label %if.then, label %if.else

if.then:                                          ; preds = %lor.end
  call addrspace(1) void @llvm.chess_error(metadata !3391)
  br label %if.end

if.else:                                          ; preds = %lor.end
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %4 = load i32, ptr %idx.addr, align 4, !tbaa !1721
  %5 = load %struct.v16float, ptr %v, align 32, !tbaa !2072
  %call = call addrspace(1) float @_ZN12me_primitive9ext_elem_E8v16floatii(%struct.v16float %5, i32 %4, i32 1) #22
  ret float %call
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_ZN12me_primitive9ext_elem_E8v16floatii(%struct.v16float %a0.coerce, i32 %a1, i32 %a2) addrspace(1) #6 comdat {
entry:
  %a0 = alloca %struct.v16float, align 32
  %a1.addr = alloca i32, align 4
  %a2.addr = alloca i32, align 4
  store %struct.v16float %a0.coerce, ptr %a0, align 32
  store i32 %a1, ptr %a1.addr, align 4, !tbaa !1721
  store i32 %a2, ptr %a2.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %a1.addr, align 4, !tbaa !1721
  %1 = load i32, ptr %a2.addr, align 4, !tbaa !1721
  %2 = load %struct.v16float, ptr %a0, align 32, !tbaa !2072
  %call = call x86_regcallcc addrspace(1) float @__regcall3__chessintr___ffloat_ext_elem__v16float___sint___sint(%struct.v16float %2, i32 signext %0, i32 signext %1) #23
  ret float %call
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc float @__regcall3__chessintr___ffloat_ext_elem__v16float___sint___sint(%struct.v16float, i32 signext, i32 signext) addrspace(1) #14

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::vector" noundef %.coerce) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !3392 {
entry:
  %0 = alloca %"class.aie::vector", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector" %.coerce, ptr %0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3398, metadata !DIExpression()), !dbg !3401
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %0, metadata !3400, metadata !DIExpression()), !dbg !3401
  %this1 = load ptr, ptr %this.addr, align 4
  %1 = load %"class.aie::vector", ptr %0, align 32, !dbg !3402, !tbaa !1670
  call addrspace(1) void @_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 32 dereferenceable(32) %this1, %"class.aie::vector" %1) #22, !dbg !3402
  ret void, !dbg !3402
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::vector" %parent.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3403 {
entry:
  %parent = alloca %"class.aie::vector", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector" %parent.coerce, ptr %parent, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3405, metadata !DIExpression()), !dbg !3408
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %parent, metadata !3407, metadata !DIExpression()), !dbg !3409
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.5", ptr %this1, i32 0, i32 0, !dbg !3410
  %0 = load %"class.aie::vector", ptr %parent, align 32, !dbg !3411, !tbaa !1670
  store %"class.aie::vector" %0, ptr %parent_, align 32, !dbg !3411, !tbaa !1670
  ret void, !dbg !3412
}

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 4 dereferenceable(8) %this, %"class.aie::vector_elem_ref" noundef %.coerce) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !3413 {
entry:
  %0 = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector_elem_ref" %.coerce, ptr %0, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3419, metadata !DIExpression()), !dbg !3422
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %0, metadata !3421, metadata !DIExpression()), !dbg !3422
  %this1 = load ptr, ptr %this.addr, align 4
  %1 = load %"class.aie::vector_elem_ref", ptr %0, align 4, !dbg !3423, !tbaa !1780
  call addrspace(1) void @_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 4 dereferenceable(8) %this1, %"class.aie::vector_elem_ref" %1) #22, !dbg !3423
  ret void, !dbg !3423
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 4 dereferenceable(8) %this, %"class.aie::vector_elem_ref" %parent.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3424 {
entry:
  %parent = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector_elem_ref" %parent.coerce, ptr %parent, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3426, metadata !DIExpression()), !dbg !3429
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %parent, metadata !3428, metadata !DIExpression()), !dbg !3430
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.3", ptr %this1, i32 0, i32 0, !dbg !3431
  %0 = load %"class.aie::vector_elem_ref", ptr %parent, align 4, !dbg !3431, !tbaa !1780
  store %"class.aie::vector_elem_ref" %0, ptr %parent_, align 4, !dbg !3431, !tbaa !1780
  ret void, !dbg !3432
}

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::accum" noundef %.coerce) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !3433 {
entry:
  %0 = alloca %"class.aie::accum", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::accum" %.coerce, ptr %0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3439, metadata !DIExpression()), !dbg !3442
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %0, metadata !3441, metadata !DIExpression()), !dbg !3442
  %this1 = load ptr, ptr %this.addr, align 4
  %1 = load %"class.aie::accum", ptr %0, align 32, !dbg !3443, !tbaa !1684
  call addrspace(1) void @_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_(ptr nonnull align 32 dereferenceable(32) %this1, %"class.aie::accum" %1) #22, !dbg !3443
  ret void, !dbg !3443
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::accum" %parent.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3444 {
entry:
  %parent = alloca %"class.aie::accum", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::accum" %parent.coerce, ptr %parent, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3446, metadata !DIExpression()), !dbg !3449
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %parent, metadata !3448, metadata !DIExpression()), !dbg !3450
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common", ptr %this1, i32 0, i32 0, !dbg !3451
  %0 = load %"class.aie::accum", ptr %parent, align 32, !dbg !3452, !tbaa !1684
  store %"class.aie::accum" %0, ptr %parent_, align 32, !dbg !3452, !tbaa !1684
  ret void, !dbg !3453
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EE8elem_refEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3454 {
entry:
  %retval = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3456, metadata !DIExpression()), !dbg !3458
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3457, metadata !DIExpression()), !dbg !3459
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !3460

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3461, !tbaa !1721
  %cmp = icmp ult i32 %0, 8, !dbg !3461
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !3461
  br i1 %1, label %if.then, label %if.else, !dbg !3464

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !3465

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !3467, !tbaa !1721
  %cmp3 = icmp ult i32 %2, 8, !dbg !3467
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !3467
  br i1 %3, label %if.end, label %if.then4, !dbg !3470

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !1897), !dbg !3467
  br label %if.end, !dbg !3467

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !3470

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !3465

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3471, !tbaa !1721
  %cmp5 = icmp ult i32 %4, 8, !dbg !3471
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !3471
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !3464

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !3473, !tbaa !1721
  call addrspace(1) void @_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj(ptr nonnull align 4 dereferenceable(8) %retval, ptr nonnull align 32 dereferenceable(32) %this1, i32 noundef %5) #22, !dbg !3474
  %6 = load %"class.aie::vector_elem_ref", ptr %retval, align 4, !dbg !3475
  ret %"class.aie::vector_elem_ref" %6, !dbg !3475
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj(ptr nonnull align 4 dereferenceable(8) %this, ptr nonnull align 32 dereferenceable(32) %v, i32 noundef %idx) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !3476 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3478, metadata !DIExpression()), !dbg !3482
  store ptr %v, ptr %v.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3480, metadata !DIExpression()), !dbg !3483
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3481, metadata !DIExpression()), !dbg !3484
  %this1 = load ptr, ptr %this.addr, align 4
  %parent = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %this1, i32 0, i32 0, !dbg !3485
  %0 = load ptr, ptr %v.addr, align 4, !dbg !3486, !tbaa !1512
  store ptr %0, ptr %parent, align 4, !dbg !3485, !tbaa !1512
  %offset = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %this1, i32 0, i32 1, !dbg !3487
  %1 = load i32, ptr %idx.addr, align 4, !dbg !3488, !tbaa !1721
  store i32 %1, ptr %offset, align 4, !dbg !3487, !tbaa !2507
  ret void, !dbg !3489
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE(ptr %_w, %"class.aie::accum" %value.coerce) addrspace(1) #6 comdat align 2 !dbg !3490 {
entry:
  %value = alloca %"class.aie::accum", align 32
  %_w.addr = alloca ptr, align 4
  %w = alloca ptr, align 4
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %ref.tmp = alloca %"class.aie::accum.9", align 32
  store %"class.aie::accum" %value.coerce, ptr %value, align 32
  store ptr %_w, ptr %_w.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %_w.addr, metadata !3519, metadata !DIExpression()), !dbg !3522
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %value, metadata !3520, metadata !DIExpression()), !dbg !3523
  store ptr undef, ptr %w, align 4, !dbg !3524
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %w) #20, !dbg !3524
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w, metadata !3521, metadata !DIExpression()), !dbg !3525
  %0 = load ptr, ptr %_w.addr, align 4, !dbg !3526, !tbaa !1512
  store ptr %0, ptr %w, align 4, !dbg !3525, !tbaa !1512
  %1 = load ptr, ptr %w, align 4, !dbg !3527, !tbaa !1512
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #20, !dbg !3530
  %call = call addrspace(1) %"class.aie::accum.9" @_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv(ptr nonnull align 32 dereferenceable(32) %value) #22, !dbg !3531
  %2 = getelementptr inbounds %"class.aie::accum.9", ptr %ref.tmp, i32 0, i32 0, !dbg !3531
  %3 = extractvalue %"class.aie::accum.9" %call, 0, !dbg !3531
  store %"class.aie::detail::accum_base.10" %3, ptr %2, align 32, !dbg !3531
  %call1 = call addrspace(1) %struct.v16accfloat @_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %ref.tmp) #22, !dbg !3530
  %4 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !3530
  %5 = extractvalue %struct.v16accfloat %call1, 0, !dbg !3530
  store %struct.ipd.custom_type.v16acc32.v16acc32 %5, ptr %4, align 32, !dbg !3530
  %6 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !3532, !tbaa !2736
  call addrspace(1) void @_ZL9writeincrP14output_cascadeI8accfloatvE11v16accfloat(ptr %1, %struct.v16accfloat noundef %6) #22, !dbg !3532
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #20, !dbg !3532
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %w) #20, !dbg !3533
  ret void, !dbg !3533
}

; Function Attrs: inlinehint mustprogress nounwind
define internal void @_ZL9writeincrP14output_cascadeI8accfloatvE11v16accfloat(ptr %str, %struct.v16accfloat noundef %value.coerce) addrspace(1) #5 !dbg !3534 {
entry:
  %value = alloca %struct.v16accfloat, align 32
  %str.addr = alloca ptr, align 4
  store %struct.v16accfloat %value.coerce, ptr %value, align 32
  store ptr %str, ptr %str.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %str.addr, metadata !3539, metadata !DIExpression()), !dbg !3541
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %value, metadata !3540, metadata !DIExpression()), !dbg !3541
  %0 = load %struct.v16accfloat, ptr %value, align 32, !dbg !3541, !tbaa !2736
  call addrspace(1) void @_Z7put_mcd11v16accfloat(%struct.v16accfloat %0) #22, !dbg !3541
  ret void, !dbg !3541
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z7put_mcd11v16accfloat(%struct.v16accfloat %a.coerce) addrspace(1) #6 comdat {
entry:
  %a = alloca %struct.v16accfloat, align 32
  store %struct.v16accfloat %a.coerce, ptr %a, align 32
  %0 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2736
  call addrspace(1) void @_Z7put_mcd11v16accfloati(%struct.v16accfloat %0, i32 1) #22
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z7put_mcd11v16accfloati(%struct.v16accfloat %a.coerce, i32 %en) addrspace(1) #6 comdat {
entry:
  %a = alloca %struct.v16accfloat, align 32
  %en.addr = alloca i32, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %custom_type.tmp = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  store %struct.v16accfloat %a.coerce, ptr %a, align 32
  store i32 %en, ptr %en.addr, align 4, !tbaa !1721
  %0 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2736
  call addrspace(1) void @_ZN8v16acc32C2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16accfloat %0) #25
  %1 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %custom_type.tmp, align 32, !tbaa !2736
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %agg.tmp, align 32, !tbaa !2736
  %2 = load i32, ptr %en.addr, align 4, !tbaa !1721
  %3 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp, align 32, !tbaa !2736
  call addrspace(1) void @_Z7put_mcd8v16acc32i(%struct.ipd.custom_type.v16acc32.v16acc32 %3, i32 %2) #22
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z7put_mcd8v16acc32i(%struct.ipd.custom_type.v16acc32.v16acc32 %a.coerce, i32 %en) addrspace(1) #6 comdat {
entry:
  %a = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %en.addr = alloca i32, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %agg.tmp1 = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  store %struct.ipd.custom_type.v16acc32.v16acc32 %a.coerce, ptr %a, align 32
  store i32 %en, ptr %en.addr, align 4, !tbaa !1721
  %0 = load i32, ptr %en.addr, align 4, !tbaa !1721
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 %0) #22
  %1 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2984
  store %struct.ipd.custom_type.uint1_t.uint1_t %1, ptr %agg.tmp, align 4, !tbaa !2984
  %2 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %a, align 32, !tbaa !2736
  %3 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2984
  %call = call addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @_ZN12me_primitive9mcd_writeE8v16acc327uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %2, %struct.ipd.custom_type.uint1_t.uint1_t %3) #24
  store %struct.ipd.custom_type.v16acc32.v16acc32 %call, ptr %agg.tmp1, align 32
  %4 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp1, align 32, !tbaa !2736
  store volatile %struct.ipd.custom_type.v16acc32.v16acc32 %4, ptr !register !1480, align 32, !tbaa !2736, !chess_protect_access !3542
  ret void
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN8v16acc32C2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16accfloat %a0.coerce) unnamed_addr addrspace(1) #16 comdat align 2 {
entry:
  %a0 = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  store %struct.v16accfloat %a0.coerce, ptr %a0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2736
  %call = call x86_regcallcc addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_v16acc32_v16accfloat(%struct.v16accfloat %0) #23
  store %struct.ipd.custom_type.v16acc32.v16acc32 %call, ptr %agg.tmp, align 32
  %1 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp, align 32, !tbaa !2736
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %this1, align 32, !tbaa !2736
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.ipd.custom_type.v16acc32.v16acc32 @_ZN12me_primitive9mcd_writeE8v16acc327uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %a0.coerce, %struct.ipd.custom_type.uint1_t.uint1_t %a1.coerce) addrspace(1) #15 comdat {
entry:
  %a0 = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %a1 = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  store %struct.ipd.custom_type.v16acc32.v16acc32 %a0.coerce, ptr %a0, align 32
  store %struct.ipd.custom_type.uint1_t.uint1_t %a1.coerce, ptr %a1, align 4
  %0 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %a0, align 32, !tbaa !2736
  %1 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a1, align 4, !tbaa !2984
  %call = call x86_regcallcc addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_mcd_write_v16acc32_uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %0, %struct.ipd.custom_type.uint1_t.uint1_t %1) #23
  ret %struct.ipd.custom_type.v16acc32.v16acc32 %call
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_mcd_write_v16acc32_uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32, %struct.ipd.custom_type.uint1_t.uint1_t) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_v16acc32_v16accfloat(%struct.v16accfloat) addrspace(1) #14

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEC2Ev(ptr nonnull align 4 dereferenceable(4) %this) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !3543 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1512
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3545, metadata !DIExpression()), !dbg !3546
  %this1 = load ptr, ptr %this.addr, align 4
  ret void, !dbg !3547
}

; Function Attrs: nounwind
define internal void @_GLOBAL__sub_I_i11_wrap_matrix_vector_mul.cpp() addrspace(1) #8 !dbg !3548 {
entry:
  call addrspace(1) void @__cxx_global_var_init(), !dbg !3550
  ret void
}

attributes #0 = { mustprogress noinline nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { inlinehint nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #5 = { inlinehint mustprogress nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #6 = { alwaysinline mustprogress nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #7 = { nounwind willreturn memory(none) }
attributes #8 = { nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #9 = { mustprogress nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #10 = { nounwind speculatable willreturn memory(argmem: readwrite) }
attributes #11 = { alwaysinline nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #12 = { nocse nounwind willreturn memory(none) }
attributes #13 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #14 = { nounwind willreturn memory(none) "frame-pointer"="all" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #15 = { alwaysinline mustprogress nounwind "chessFP:llvm_local_block_replace_operand_with_variable" "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #16 = { alwaysinline nounwind "chessFP:property"="reinterpret" "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #17 = { convergent nocallback nofree nosync nounwind willreturn memory(none) }
attributes #18 = { nounwind willreturn }
attributes #19 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #20 = { nounwind }
attributes #21 = { nounwind "no-builtin-memcpy" }
attributes #22 = { "no-builtin-memcpy" }
attributes #23 = { nounwind willreturn memory(none) "no-builtin-memcpy" }
attributes #24 = { "chessFP:llvm_local_block_replace_operand_with_variable" "no-builtin-memcpy" }
attributes #25 = { "chessFP:property"="reinterpret" "no-builtin-memcpy" }

!llvm.dbg.cu = !{!2}
!llvm.named.register.crF2FMask = !{!1478}
!llvm.named.register.crFPMask = !{!1479}
!llvm.named.register.MCD = !{!1480}
!llvm.linker.options = !{}
!llvm.chess.memory-units = !{!1481, !1482, !1483, !1484, !1485, !1486, !1487, !1488, !1489, !1490, !1491, !1492, !1493, !1494}
!llvm.module.flags = !{!1495, !1496, !1497, !1498}
!llvm.ident = !{!1499}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "i11", scope: !2, file: !1369, line: 7, type: !1010, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !3, producer: "clang version 16.0.3 (/u/sgasip/ipd/repositories/llvm_ipd 6a0b186d7c0e25173296a8e19f630e71bd7e8ed9)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !78, globals: !1049, imports: !1054, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i11_wrap_matrix_vector_mul.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir")
!4 = !{!5, !13, !27, !33, !37, !44, !57}
!5 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "lut_oor_policy", scope: !7, file: !6, line: 12, baseType: !9, size: 32, flags: DIFlagEnumClass, elements: !10, identifier: "_ZTSN3aie6detail14lut_oor_policyE")
!6 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/../lut.hpp", directory: "")
!7 = !DINamespace(name: "detail", scope: !8)
!8 = !DINamespace(name: "aie", scope: null)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !{!11, !12}
!11 = !DIEnumerator(name: "saturate", value: 0)
!12 = !DIEnumerator(name: "truncate", value: 1)
!13 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "rounding_mode", scope: !8, file: !14, line: 36, baseType: !15, size: 32, flags: DIFlagEnumClass, elements: !16, identifier: "_ZTSN3aie13rounding_modeE")
!14 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/aie_types.hpp", directory: "")
!15 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!16 = !{!17, !18, !19, !20, !21, !22, !23, !24, !25, !26}
!17 = !DIEnumerator(name: "floor", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "ceil", value: 1, isUnsigned: true)
!19 = !DIEnumerator(name: "positive_inf", value: 9, isUnsigned: true)
!20 = !DIEnumerator(name: "negative_inf", value: 8, isUnsigned: true)
!21 = !DIEnumerator(name: "symmetric_inf", value: 11, isUnsigned: true)
!22 = !DIEnumerator(name: "symmetric_zero", value: 10, isUnsigned: true)
!23 = !DIEnumerator(name: "conv_even", value: 12, isUnsigned: true)
!24 = !DIEnumerator(name: "conv_odd", value: 13, isUnsigned: true)
!25 = !DIEnumerator(name: "symmetric_floor", value: 2, isUnsigned: true)
!26 = !DIEnumerator(name: "symmetric_ceil", value: 3, isUnsigned: true)
!27 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "saturation_mode", scope: !8, file: !14, line: 29, baseType: !15, size: 32, flags: DIFlagEnumClass, elements: !28, identifier: "_ZTSN3aie15saturation_modeE")
!28 = !{!29, !30, !31, !32}
!29 = !DIEnumerator(name: "none", value: 0, isUnsigned: true)
!30 = !DIEnumerator(name: "truncate", value: 1, isUnsigned: true)
!31 = !DIEnumerator(name: "saturate", value: 1, isUnsigned: true)
!32 = !DIEnumerator(name: "symmetric", value: 3, isUnsigned: true)
!33 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "chessllvmInternal", file: !34, line: 23, baseType: !15, size: 32, elements: !35, identifier: "_ZTS17chessllvmInternal")
!34 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/isg/me_chess_llvm.h", directory: "")
!35 = !{!36}
!36 = !DIEnumerator(name: "chessllvm_reinterpret", value: 0, isUnsigned: true)
!37 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "AccumClass", scope: !7, file: !38, line: 24, baseType: !9, size: 32, flags: DIFlagEnumClass, elements: !39, identifier: "_ZTSN3aie6detail10AccumClassE")
!38 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/accum.hpp", directory: "")
!39 = !{!40, !41, !42, !43}
!40 = !DIEnumerator(name: "Int", value: 0)
!41 = !DIEnumerator(name: "CInt", value: 1)
!42 = !DIEnumerator(name: "FP", value: 2)
!43 = !DIEnumerator(name: "CFP", value: 3)
!44 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "Operation", scope: !8, file: !45, line: 19, baseType: !9, size: 32, flags: DIFlagEnumClass, elements: !46, identifier: "_ZTSN3aie9OperationE")
!45 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/../expr.hpp", directory: "")
!46 = !{!47, !48, !49, !50, !51, !52, !53, !54, !55, !56}
!47 = !DIEnumerator(name: "None", value: 0)
!48 = !DIEnumerator(name: "Acc_Add", value: 1)
!49 = !DIEnumerator(name: "Acc_Sub", value: 2)
!50 = !DIEnumerator(name: "Abs", value: 3)
!51 = !DIEnumerator(name: "Conj", value: 4)
!52 = !DIEnumerator(name: "Transpose", value: 5)
!53 = !DIEnumerator(name: "Max", value: 6)
!54 = !DIEnumerator(name: "Min", value: 7)
!55 = !DIEnumerator(name: "Sign", value: 8)
!56 = !DIEnumerator(name: "Zero", value: 9)
!57 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "MulMacroOp", scope: !7, file: !58, line: 24, baseType: !9, size: 32, flags: DIFlagEnumClass, elements: !59, identifier: "_ZTSN3aie6detail10MulMacroOpE")
!58 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/mul.hpp", directory: "")
!59 = !{!60, !61, !62, !63, !64, !65, !66, !67, !68, !69, !70, !71, !72, !73, !74, !75, !76, !77}
!60 = !DIEnumerator(name: "Unavailable", value: -1)
!61 = !DIEnumerator(name: "Mul", value: 0)
!62 = !DIEnumerator(name: "NegMul", value: 1)
!63 = !DIEnumerator(name: "Add_Mul", value: 2)
!64 = !DIEnumerator(name: "Add_NegMul", value: 3)
!65 = !DIEnumerator(name: "Sub_Mul", value: 3)
!66 = !DIEnumerator(name: "MulConj1", value: 4)
!67 = !DIEnumerator(name: "MulConj1Conj2", value: 5)
!68 = !DIEnumerator(name: "MulConj2", value: 6)
!69 = !DIEnumerator(name: "NegMulConj1", value: 7)
!70 = !DIEnumerator(name: "NegMulConj1Conj2", value: 8)
!71 = !DIEnumerator(name: "NegMulConj2", value: 9)
!72 = !DIEnumerator(name: "Add_MulConj1", value: 10)
!73 = !DIEnumerator(name: "Add_MulConj1Conj2", value: 11)
!74 = !DIEnumerator(name: "Add_MulConj2", value: 12)
!75 = !DIEnumerator(name: "Sub_MulConj1", value: 13)
!76 = !DIEnumerator(name: "Sub_MulConj1Conj2", value: 14)
!77 = !DIEnumerator(name: "Sub_MulConj2", value: 15)
!78 = !{!79, !81, !371, !470, !15, !486, !396, !308, !488, !490, !492, !374, !144, !567, !112, !129, !85, !569, !611, !188, !646, !647, !648, !649, !650, !651, !652, !653, !654, !655, !656, !657, !658, !659, !660, !661, !662, !663, !664, !665, !666, !667, !668, !669, !670, !671, !672, !673, !674, !675, !676, !677, !689, !734, !735, !736, !737, !738, !397, !739, !212, !322, !192, !378, !740, !889, !890, !891, !892, !893, !894, !895, !896, !897, !491, !568, !898, !899, !900, !901, !902, !489, !903, !487, !852, !743, !904, !928, !950, !495, !971, !984, !997, !1010}
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 32)
!80 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 32)
!82 = !DIDerivedType(tag: DW_TAG_typedef, name: "dataA_t", scope: !84, file: !83, line: 161, baseType: !188)
!83 = !DIFile(filename: "dsp_lib/L1/src/aie/matrix_vector_mul.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!84 = distinct !DISubprogram(name: "matVecMulBasic", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !83, line: 158, type: !109, scopeLine: 159, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !146, retainedNodes: !178)
!85 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "kernelMatVecMulClass<float, float, 128U, 768U, 0U, 0U, 0U, 1U, 12U, 1U, 0U, 0U, 1U, 0U, false, true>", scope: !87, file: !86, line: 77, size: 32, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !92, templateParams: !160, identifier: "_ZTSN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEE")
!86 = !DIFile(filename: "dsp_lib/L1/include/aie/matrix_vector_mul.hpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!87 = !DINamespace(name: "matrix_vector_mul", scope: !88)
!88 = !DINamespace(name: "blas", scope: !89)
!89 = !DINamespace(name: "aie", scope: !90)
!90 = !DINamespace(name: "dsp", scope: !91)
!91 = !DINamespace(name: "xf", scope: null)
!92 = !{!93, !95, !96, !97, !98, !99, !100, !102, !103, !104, !105, !106, !108, !146, !147, !148, !156, !159}
!93 = !DIDerivedType(tag: DW_TAG_member, name: "vecSampleNumA", scope: !85, file: !86, line: 100, baseType: !94, flags: DIFlagStaticMember, extraData: i32 8)
!94 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !9)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "vecSampleNumB", scope: !85, file: !86, line: 101, baseType: !94, flags: DIFlagStaticMember, extraData: i32 8)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "vecSampleNumOut", scope: !85, file: !86, line: 102, baseType: !94, flags: DIFlagStaticMember, extraData: i32 8)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "loadsPerColA", scope: !85, file: !86, line: 104, baseType: !94, flags: DIFlagStaticMember, extraData: i32 16)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "loadsPerMatrix", scope: !85, file: !86, line: 105, baseType: !94, flags: DIFlagStaticMember, extraData: i32 1024)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "loadsPerVectorB", scope: !85, file: !86, line: 106, baseType: !94, flags: DIFlagStaticMember, extraData: i32 8)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "streamVectorBuffSize", scope: !85, file: !86, line: 107, baseType: !101, flags: DIFlagStaticMember)
!101 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !15)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "castBtoA", scope: !85, file: !86, line: 111, baseType: !94, flags: DIFlagStaticMember, extraData: i32 0)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "streamLoadSize", scope: !85, file: !86, line: 118, baseType: !101, flags: DIFlagStaticMember)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "streamWriteOutSize", scope: !85, file: !86, line: 119, baseType: !101, flags: DIFlagStaticMember)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "streamLoadsRequired", scope: !85, file: !86, line: 121, baseType: !101, flags: DIFlagStaticMember)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "m_inMatrixPtr", scope: !85, file: !86, line: 131, baseType: !107, size: 32, flags: DIFlagPublic)
!107 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !79)
!108 = !DISubprogram(name: "matVecMulSelectArch", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 123, type: !109, scopeLine: 123, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!109 = !DISubroutineType(types: !110)
!110 = !{null, !111, !112, !129}
!111 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!112 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "T_inputIF<float, float>", scope: !87, file: !113, line: 305, size: 160, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !114, templateParams: !126, identifier: "_ZTSN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEE")
!113 = !DIFile(filename: "dsp_lib/L1/include/aie/matrix_vector_mul_traits.hpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!114 = !{!115, !116, !117, !122, !123}
!115 = !DIDerivedType(tag: DW_TAG_member, name: "inWindowA", scope: !112, file: !113, line: 306, baseType: !107, size: 32)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "inWindowB", scope: !112, file: !113, line: 307, baseType: !107, size: 32, offset: 32)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "inStreamB", scope: !112, file: !113, line: 308, baseType: !118, size: 32, offset: 64)
!118 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !119)
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 32)
!120 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "input_stream<float>", file: !121, line: 71, size: 32, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS12input_streamIfE")
!121 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/stream/me/structs.h", directory: "")
!122 = !DIDerivedType(tag: DW_TAG_member, name: "inStreamB2", scope: !112, file: !113, line: 309, baseType: !118, size: 32, offset: 96)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "inCascade", scope: !112, file: !113, line: 310, baseType: !124, size: 32, offset: 128)
!124 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 32)
!125 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "input_cascade<accfloat, void>", file: !121, line: 156, size: 8, flags: DIFlagFwdDecl, identifier: "_ZTS13input_cascadeI8accfloatvE")
!126 = !{!127, !128}
!127 = !DITemplateTypeParameter(name: "T_A", type: !80)
!128 = !DITemplateTypeParameter(name: "T_B", type: !80)
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "T_outputIF<float, float>", scope: !87, file: !113, line: 314, size: 128, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !130, templateParams: !126, identifier: "_ZTSN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEE")
!130 = !{!131, !138, !142, !143}
!131 = !DIDerivedType(tag: DW_TAG_member, name: "outWindow", scope: !129, file: !113, line: 315, baseType: !132, size: 32)
!132 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !133)
!133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !134, size: 32)
!134 = !DIDerivedType(tag: DW_TAG_typedef, name: "outType_t<float, float>", scope: !87, file: !113, line: 301, baseType: !135)
!135 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !136, file: !113, line: 286, baseType: !80)
!136 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outType<float, float>", scope: !87, file: !113, line: 285, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !126, identifier: "_ZTSN2xf3dsp3aie4blas17matrix_vector_mul7outTypeIffEE")
!137 = !{}
!138 = !DIDerivedType(tag: DW_TAG_member, name: "outStream", scope: !129, file: !113, line: 316, baseType: !139, size: 32, offset: 32)
!139 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !140)
!140 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !141, size: 32)
!141 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "output_stream<float>", file: !121, line: 94, size: 32, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS13output_streamIfE")
!142 = !DIDerivedType(tag: DW_TAG_member, name: "outStream2", scope: !129, file: !113, line: 317, baseType: !139, size: 32, offset: 64)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "outCascade", scope: !129, file: !113, line: 318, baseType: !144, size: 32, offset: 96)
!144 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !145, size: 32)
!145 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "output_cascade<accfloat, void>", file: !121, line: 190, size: 8, flags: DIFlagFwdDecl, identifier: "_ZTS14output_cascadeI8accfloatvE")
!146 = !DISubprogram(name: "matVecMulBasic", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 126, type: !109, scopeLine: 126, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!147 = !DISubprogram(name: "matVecMulStream", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE15matVecMulStreamENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 128, type: !109, scopeLine: 128, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!148 = !DISubprogram(name: "setInMatrixPtr", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14setInMatrixPtrERA8192_Kf", scope: !85, file: !86, line: 132, type: !149, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!149 = !DISubroutineType(types: !150)
!150 = !{null, !111, !151}
!151 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !152, size: 32)
!152 = !DICompositeType(tag: DW_TAG_array_type, baseType: !153, size: 262144, elements: !154)
!153 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !80)
!154 = !{!155}
!155 = !DISubrange(count: 8192)
!156 = !DISubprogram(name: "kernelMatVecMulClass", scope: !85, file: !86, line: 137, type: !157, scopeLine: 137, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!157 = !DISubroutineType(types: !158)
!158 = !{null, !111}
!159 = !DISubprogram(name: "matVecMulKernel", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 140, type: !109, scopeLine: 140, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!160 = !{!161, !162, !163, !164, !165, !166, !167, !168, !169, !170, !171, !172, !173, !174, !175, !177}
!161 = !DITemplateTypeParameter(name: "TT_DATA_A", type: !80)
!162 = !DITemplateTypeParameter(name: "TT_DATA_B", type: !80)
!163 = !DITemplateValueParameter(name: "TP_DIM_A", type: !15, value: i32 128)
!164 = !DITemplateValueParameter(name: "TP_DIM_B", type: !15, value: i32 768)
!165 = !DITemplateValueParameter(name: "TP_SHIFT", type: !15, value: i32 0)
!166 = !DITemplateValueParameter(name: "TP_RND", type: !15, value: i32 0)
!167 = !DITemplateValueParameter(name: "TP_SAT", type: !15, value: i32 0)
!168 = !DITemplateValueParameter(name: "TP_NUM_FRAMES", type: !15, value: i32 1)
!169 = !DITemplateValueParameter(name: "TP_CASC_LEN", type: !15, value: i32 12)
!170 = !DITemplateValueParameter(name: "TP_USE_MATRIX_RELOAD", type: !15, value: i32 1)
!171 = !DITemplateValueParameter(name: "TP_API", type: !15, defaulted: true, value: i32 0)
!172 = !DITemplateValueParameter(name: "TP_DUAL_IP", type: !15, defaulted: true, value: i32 0)
!173 = !DITemplateValueParameter(name: "TP_NUM_OUTPUTS", type: !15, value: i32 1)
!174 = !DITemplateValueParameter(name: "TP_KERNEL_POSITION", type: !15, defaulted: true, value: i32 0)
!175 = !DITemplateValueParameter(name: "TP_CASC_IN", type: !176, defaulted: true, value: i1 false)
!176 = !DIBasicType(name: "bool", size: 8, encoding: DW_ATE_boolean)
!177 = !DITemplateValueParameter(name: "TP_CASC_OUT", type: !176, value: i1 true)
!178 = !{!179, !181, !182, !183, !184, !186, !369, !372, !460, !462, !463, !464, !465, !466, !467, !468, !472, !474, !478, !482}
!179 = !DILocalVariable(name: "this", arg: 1, scope: !84, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!180 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 32)
!181 = !DILocalVariable(name: "inInterface", arg: 2, scope: !84, file: !86, line: 126, type: !112)
!182 = !DILocalVariable(name: "outInterface", arg: 3, scope: !84, file: !86, line: 126, type: !129)
!183 = !DILocalVariable(name: "dataA", scope: !84, file: !83, line: 170, type: !82)
!184 = !DILocalVariable(name: "inPtrA", scope: !84, file: !83, line: 171, type: !185)
!185 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !81)
!186 = !DILocalVariable(name: "dataB", scope: !84, file: !83, line: 172, type: !187)
!187 = !DIDerivedType(tag: DW_TAG_typedef, name: "dataB_t", scope: !84, file: !83, line: 162, baseType: !188)
!188 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector<float, 8U>", scope: !8, file: !189, line: 77, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !190, templateParams: !208, identifier: "_ZTSN3aie6vectorIfLj8EEE")
!189 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/../vector.hpp", directory: "")
!190 = !{!191, !259, !266, !267, !268, !269, !270, !271, !272, !273, !274, !275, !278, !282, !288, !293, !294, !299, !302, !305, !363, !366, !367, !368}
!191 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !188, baseType: !192, extraData: i32 0)
!192 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_base<float, 8U>", scope: !7, file: !193, line: 348, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !194, templateParams: !208, identifier: "_ZTSN3aie6detail11vector_baseIfLj8EEE")
!193 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/vector.hpp", directory: "")
!194 = !{!195, !196, !197, !199, !213, !216, !217, !218, !221, !222, !223, !224, !225, !229, !233, !242, !247, !250, !255, !258}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems", scope: !192, file: !193, line: 1350, baseType: !101, flags: DIFlagStaticMember)
!196 = !DIDerivedType(tag: DW_TAG_member, name: "num_storage_elems", scope: !192, file: !193, line: 1351, baseType: !101, flags: DIFlagStaticMember, extraData: i32 1)
!197 = !DIDerivedType(tag: DW_TAG_member, name: "is_compound_storage", scope: !192, file: !193, line: 1352, baseType: !198, flags: DIFlagStaticMember)
!198 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !176)
!199 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !192, file: !193, line: 1357, baseType: !200, size: 256)
!200 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_storage_t<float, 8U>", scope: !7, file: !201, line: 205, baseType: !202)
!201 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/vector_native_types.hpp", directory: "")
!202 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !203, file: !201, line: 298, baseType: !211)
!203 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vector_storage<float, 8U>", scope: !7, file: !201, line: 298, size: 8, flags: DIFlagTypePassByValue, elements: !204, templateParams: !208, identifier: "_ZTSN3aie6detail14vector_storageIfLj8EEE")
!204 = !{!205}
!205 = !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj8EE5undefEv", scope: !203, file: !201, line: 298, type: !206, scopeLine: 298, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!206 = !DISubroutineType(types: !207)
!207 = !{!202}
!208 = !{!209, !210}
!209 = !DITemplateTypeParameter(name: "T", type: !80)
!210 = !DITemplateValueParameter(name: "Elems", type: !15, value: i32 8)
!211 = !DIDerivedType(tag: DW_TAG_typedef, name: "v8float", file: !34, line: 616, baseType: !212)
!212 = !DIBasicType(name: "v8float", size: 256, encoding: DW_ATE_unsigned)
!213 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE9type_bitsEv", scope: !192, file: !193, line: 361, type: !214, scopeLine: 361, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!214 = !DISubroutineType(types: !215)
!215 = !{!15}
!216 = !DISubprogram(name: "size", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE4sizeEv", scope: !192, file: !193, line: 366, type: !214, scopeLine: 366, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!217 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE4bitsEv", scope: !192, file: !193, line: 371, type: !214, scopeLine: 371, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!218 = !DISubprogram(name: "is_signed", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE9is_signedEv", scope: !192, file: !193, line: 376, type: !219, scopeLine: 376, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!219 = !DISubroutineType(types: !220)
!220 = !{!176}
!221 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE10is_complexEv", scope: !192, file: !193, line: 381, type: !219, scopeLine: 381, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!222 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE7is_realEv", scope: !192, file: !193, line: 386, type: !219, scopeLine: 386, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!223 = !DISubprogram(name: "is_integral", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE11is_integralEv", scope: !192, file: !193, line: 391, type: !219, scopeLine: 391, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!224 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE17is_floating_pointEv", scope: !192, file: !193, line: 396, type: !219, scopeLine: 396, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!225 = !DISubprogram(name: "vector_base", scope: !192, file: !193, line: 402, type: !226, scopeLine: 402, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!226 = !DISubroutineType(types: !227)
!227 = !{null, !228}
!228 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!229 = !DISubprogram(name: "vector_base", scope: !192, file: !193, line: 408, type: !230, scopeLine: 408, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!230 = !DISubroutineType(types: !231)
!231 = !{null, !228, !232}
!232 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !192, file: !193, line: 359, baseType: !202, flags: DIFlagPublic)
!233 = !DISubprogram(name: "vector_base", scope: !192, file: !193, line: 421, type: !234, scopeLine: 421, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!234 = !DISubroutineType(types: !235)
!235 = !{null, !228, !236}
!236 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !237, size: 32)
!237 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !238)
!238 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_type", scope: !192, file: !193, line: 357, baseType: !239, flags: DIFlagPublic)
!239 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_vector_type_t<float, 8U>", scope: !7, file: !201, line: 116, baseType: !240)
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !241, file: !201, line: 96, baseType: !211)
!241 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "native_vector_type<float, 8U>", scope: !7, file: !201, line: 96, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !208, identifier: "_ZTSN3aie6detail18native_vector_typeIfLj8EEE")
!242 = !DISubprogram(name: "push", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE4pushEf", scope: !192, file: !193, line: 494, type: !243, scopeLine: 494, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!243 = !DISubroutineType(types: !244)
!244 = !{!245, !228, !246}
!245 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !192, size: 32)
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !192, file: !193, line: 358, baseType: !80, flags: DIFlagPublic)
!247 = !DISubprogram(name: "set", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE3setEfj", scope: !192, file: !193, line: 652, type: !248, scopeLine: 652, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!248 = !DISubroutineType(types: !249)
!249 = !{null, !228, !246, !15}
!250 = !DISubprogram(name: "get", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE3getEj", scope: !192, file: !193, line: 703, type: !251, scopeLine: 703, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!251 = !DISubroutineType(types: !252)
!252 = !{!246, !253, !15}
!253 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!254 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !192)
!255 = !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE9to_nativeEv", scope: !192, file: !193, line: 1154, type: !256, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!256 = !DISubroutineType(types: !257)
!257 = !{!238, !253}
!258 = !DISubprogram(name: "operator v8float", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EEcv7v8floatEv", scope: !192, file: !193, line: 1164, type: !256, scopeLine: 1164, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!259 = !DISubprogram(name: "vector", scope: !188, file: !189, line: 87, type: !260, scopeLine: 87, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!260 = !DISubroutineType(types: !261)
!261 = !{null, !262, !263}
!262 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !188, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!263 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !264, size: 32)
!264 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !265)
!265 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !188, file: !189, line: 80, baseType: !192)
!266 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie6vectorIfLj8EE9type_bitsEv", scope: !188, file: !189, line: 102, type: !214, scopeLine: 102, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!267 = !DISubprogram(name: "size", linkageName: "_ZN3aie6vectorIfLj8EE4sizeEv", scope: !188, file: !189, line: 107, type: !214, scopeLine: 107, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!268 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6vectorIfLj8EE4bitsEv", scope: !188, file: !189, line: 112, type: !214, scopeLine: 112, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!269 = !DISubprogram(name: "bytes", linkageName: "_ZN3aie6vectorIfLj8EE5bytesEv", scope: !188, file: !189, line: 117, type: !214, scopeLine: 117, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!270 = !DISubprogram(name: "is_signed", linkageName: "_ZN3aie6vectorIfLj8EE9is_signedEv", scope: !188, file: !189, line: 122, type: !219, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!271 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6vectorIfLj8EE10is_complexEv", scope: !188, file: !189, line: 127, type: !219, scopeLine: 127, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!272 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6vectorIfLj8EE7is_realEv", scope: !188, file: !189, line: 132, type: !219, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!273 = !DISubprogram(name: "is_integral", linkageName: "_ZN3aie6vectorIfLj8EE11is_integralEv", scope: !188, file: !189, line: 137, type: !219, scopeLine: 137, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!274 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6vectorIfLj8EE17is_floating_pointEv", scope: !188, file: !189, line: 142, type: !219, scopeLine: 142, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!275 = !DISubprogram(name: "vector", scope: !188, file: !189, line: 148, type: !276, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!276 = !DISubroutineType(types: !277)
!277 = !{null, !262}
!278 = !DISubprogram(name: "vector", scope: !188, file: !189, line: 159, type: !279, scopeLine: 159, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!279 = !DISubroutineType(types: !280)
!280 = !{null, !262, !281}
!281 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !188, file: !189, line: 97, baseType: !232, flags: DIFlagPublic)
!282 = !DISubprogram(name: "vector", scope: !188, file: !189, line: 173, type: !283, scopeLine: 173, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!283 = !DISubroutineType(types: !284)
!284 = !{null, !262, !285}
!285 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !286, size: 32)
!286 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !287)
!287 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_type", scope: !188, file: !189, line: 91, baseType: !238, flags: DIFlagPublic)
!288 = !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6vectorIfLj8EE9to_nativeEv", scope: !188, file: !189, line: 196, type: !289, scopeLine: 196, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!289 = !DISubroutineType(types: !290)
!290 = !{!287, !291}
!291 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !292, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!292 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !188)
!293 = !DISubprogram(name: "operator v8float", linkageName: "_ZNK3aie6vectorIfLj8EEcv7v8floatEv", scope: !188, file: !189, line: 205, type: !289, scopeLine: 205, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!294 = !DISubprogram(name: "push", linkageName: "_ZN3aie6vectorIfLj8EE4pushEf", scope: !188, file: !189, line: 233, type: !295, scopeLine: 233, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!295 = !DISubroutineType(types: !296)
!296 = !{!297, !262, !298}
!297 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !188, size: 32)
!298 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !188, file: !189, line: 94, baseType: !246, flags: DIFlagPublic)
!299 = !DISubprogram(name: "set", linkageName: "_ZN3aie6vectorIfLj8EE3setEfj", scope: !188, file: !189, line: 271, type: !300, scopeLine: 271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!300 = !DISubroutineType(types: !301)
!301 = !{null, !262, !298, !15}
!302 = !DISubprogram(name: "get", linkageName: "_ZNK3aie6vectorIfLj8EE3getEj", scope: !188, file: !189, line: 282, type: !303, scopeLine: 282, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!303 = !DISubroutineType(types: !304)
!304 = !{!298, !291, !15}
!305 = !DISubprogram(name: "operator[]", linkageName: "_ZNK3aie6vectorIfLj8EEixEj", scope: !188, file: !189, line: 292, type: !306, scopeLine: 292, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!306 = !DISubroutineType(types: !307)
!307 = !{!308, !291, !15}
!308 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_elem_const_ref<float, 8U>", scope: !8, file: !309, line: 25, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !310, templateParams: !352, identifier: "_ZTSN3aie21vector_elem_const_refIfLj8EEE")
!309 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/vector_elem_ref.hpp", directory: "")
!310 = !{!311, !315, !316, !354, !359, !360}
!311 = !DIDerivedType(tag: DW_TAG_member, name: "parent", scope: !308, file: !309, line: 114, baseType: !312, size: 32, flags: DIFlagPublic)
!312 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !313, size: 32)
!313 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !314)
!314 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !308, file: !309, line: 28, baseType: !188, flags: DIFlagPublic)
!315 = !DIDerivedType(tag: DW_TAG_member, name: "offset", scope: !308, file: !309, line: 119, baseType: !15, size: 32, offset: 32, flags: DIFlagPublic)
!316 = !DISubprogram(name: "vector_elem_const_ref", scope: !308, file: !309, line: 35, type: !317, scopeLine: 35, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!317 = !DISubroutineType(types: !318)
!318 = !{null, !319, !320}
!319 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !308, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!320 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !321, size: 32)
!321 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !322)
!322 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_elem_ref<float, 8U>", scope: !8, file: !309, line: 133, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !323, templateParams: !352, identifier: "_ZTSN3aie15vector_elem_refIfLj8EEE")
!323 = !{!324, !327, !328, !333, !334, !341, !344, !349}
!324 = !DIDerivedType(tag: DW_TAG_member, name: "parent", scope: !322, file: !309, line: 237, baseType: !325, size: 32, flags: DIFlagPublic)
!325 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !326, size: 32)
!326 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !322, file: !309, line: 136, baseType: !188, flags: DIFlagPublic)
!327 = !DIDerivedType(tag: DW_TAG_member, name: "offset", scope: !322, file: !309, line: 238, baseType: !15, size: 32, offset: 32, flags: DIFlagPublic)
!328 = !DISubprogram(name: "get", linkageName: "_ZNK3aie15vector_elem_refIfLj8EE3getEv", scope: !322, file: !309, line: 143, type: !329, scopeLine: 143, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!329 = !DISubroutineType(types: !330)
!330 = !{!331, !332}
!331 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !322, file: !309, line: 138, baseType: !80, flags: DIFlagPublic)
!332 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !321, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!333 = !DISubprogram(name: "operator float", linkageName: "_ZNK3aie15vector_elem_refIfLj8EEcvfEv", scope: !322, file: !309, line: 151, type: !329, scopeLine: 151, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!334 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj8EEaSERKf", scope: !322, file: !309, line: 159, type: !335, scopeLine: 159, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!335 = !DISubroutineType(types: !336)
!336 = !{!337, !338, !339}
!337 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !322, size: 32)
!338 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !322, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!339 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !340, size: 32)
!340 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !331)
!341 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj8EEaSERKS1_", scope: !322, file: !309, line: 168, type: !342, scopeLine: 168, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!342 = !DISubroutineType(types: !343)
!343 = !{!337, !338, !320}
!344 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj8EEaSERKNS_21vector_elem_const_refIfLj8EEE", scope: !322, file: !309, line: 177, type: !345, scopeLine: 177, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!345 = !DISubroutineType(types: !346)
!346 = !{!337, !338, !347}
!347 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !348, size: 32)
!348 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !308)
!349 = !DISubprogram(name: "vector_elem_ref", scope: !322, file: !309, line: 241, type: !350, scopeLine: 241, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!350 = !DISubroutineType(types: !351)
!351 = !{null, !338, !325, !15}
!352 = !{!209, !353}
!353 = !DITemplateValueParameter(name: "N", type: !15, value: i32 8)
!354 = !DISubprogram(name: "get", linkageName: "_ZNK3aie21vector_elem_const_refIfLj8EE3getEv", scope: !308, file: !309, line: 44, type: !355, scopeLine: 44, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!355 = !DISubroutineType(types: !356)
!356 = !{!357, !358}
!357 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !308, file: !309, line: 30, baseType: !80, flags: DIFlagPublic)
!358 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !348, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!359 = !DISubprogram(name: "operator float", linkageName: "_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv", scope: !308, file: !309, line: 52, type: !355, scopeLine: 52, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!360 = !DISubprogram(name: "vector_elem_const_ref", scope: !308, file: !309, line: 122, type: !361, scopeLine: 122, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!361 = !DISubroutineType(types: !362)
!362 = !{null, !319, !312, !15}
!363 = !DISubprogram(name: "operator[]", linkageName: "_ZN3aie6vectorIfLj8EEixEj", scope: !188, file: !189, line: 303, type: !364, scopeLine: 303, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!364 = !DISubroutineType(types: !365)
!365 = !{!322, !262, !15}
!366 = !DISubprogram(name: "elem_const_ref", linkageName: "_ZNK3aie6vectorIfLj8EE14elem_const_refEj", scope: !188, file: !189, line: 314, type: !306, scopeLine: 314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!367 = !DISubprogram(name: "elem_ref", linkageName: "_ZNK3aie6vectorIfLj8EE8elem_refEj", scope: !188, file: !189, line: 325, type: !306, scopeLine: 325, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!368 = !DISubprogram(name: "elem_ref", linkageName: "_ZN3aie6vectorIfLj8EE8elem_refEj", scope: !188, file: !189, line: 336, type: !364, scopeLine: 336, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!369 = !DILocalVariable(name: "inPtrB", scope: !84, file: !83, line: 173, type: !370)
!370 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !371)
!371 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !187, size: 32)
!372 = !DILocalVariable(name: "acc", scope: !84, file: !83, line: 175, type: !373)
!373 = !DIDerivedType(tag: DW_TAG_typedef, name: "accVect_t", scope: !84, file: !83, line: 165, baseType: !374)
!374 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "accum<accfloat, 8U>", scope: !8, file: !375, line: 47, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !376, templateParams: !457, identifier: "_ZTSN3aie5accumI8accfloatLj8EEE")
!375 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/../accum.hpp", directory: "")
!376 = !{!377, !424, !431, !432, !433, !434, !435, !436, !437, !438, !439, !440, !441, !444, !449, !453}
!377 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !374, baseType: !378, extraData: i32 0)
!378 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "accum_base<(aie::detail::AccumClass)2, 32U, 8U>", scope: !7, file: !379, line: 144, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !380, templateParams: !422, identifier: "_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEE")
!379 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/accum.hpp", directory: "")
!380 = !{!381, !382, !383, !398, !401, !402, !403, !404, !405, !406, !407, !408, !409, !410, !414, !417}
!381 = !DIDerivedType(tag: DW_TAG_member, name: "Bits", scope: !378, file: !379, line: 146, baseType: !101, flags: DIFlagStaticMember, extraData: i32 32)
!382 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems", scope: !378, file: !379, line: 985, baseType: !101, flags: DIFlagStaticMember)
!383 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !378, file: !379, line: 991, baseType: !384, size: 256)
!384 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !378, file: !379, line: 155, baseType: !385, flags: DIFlagPublic)
!385 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_storage_t<(aie::detail::AccumClass)2, Bits, 8U>", scope: !7, file: !386, line: 135, baseType: !387)
!386 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/accum_native_types.hpp", directory: "")
!387 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !388, file: !386, line: 166, baseType: !396)
!388 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "accum_storage<(aie::detail::AccumClass)2, 32U, 8U>", scope: !7, file: !386, line: 166, size: 8, flags: DIFlagTypePassByValue, elements: !389, templateParams: !393, identifier: "_ZTSN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EEE")
!389 = !{!390}
!390 = !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv", scope: !388, file: !386, line: 166, type: !391, scopeLine: 166, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!391 = !DISubroutineType(types: !392)
!392 = !{!387}
!393 = !{!394, !395, !210}
!394 = !DITemplateValueParameter(name: "Class", type: !37, value: i32 2)
!395 = !DITemplateValueParameter(name: "Bits", type: !15, value: i32 32)
!396 = !DIDerivedType(tag: DW_TAG_typedef, name: "v8accfloat", file: !34, line: 628, baseType: !397)
!397 = !DIBasicType(name: "v8accfloat", size: 256, encoding: DW_ATE_unsigned)
!398 = !DISubprogram(name: "value_class", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE11value_classEv", scope: !378, file: !379, line: 157, type: !399, scopeLine: 157, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!399 = !DISubroutineType(types: !400)
!400 = !{!37}
!401 = !DISubprogram(name: "accum_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE10accum_bitsEv", scope: !378, file: !379, line: 162, type: !214, scopeLine: 162, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!402 = !DISubprogram(name: "accum_min_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14accum_min_bitsEv", scope: !378, file: !379, line: 167, type: !214, scopeLine: 167, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!403 = !DISubprogram(name: "value_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE10value_bitsEv", scope: !378, file: !379, line: 172, type: !214, scopeLine: 172, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!404 = !DISubprogram(name: "memory_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE11memory_bitsEv", scope: !378, file: !379, line: 180, type: !214, scopeLine: 180, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!405 = !DISubprogram(name: "size", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4sizeEv", scope: !378, file: !379, line: 192, type: !214, scopeLine: 192, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!406 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4bitsEv", scope: !378, file: !379, line: 197, type: !214, scopeLine: 197, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!407 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE10is_complexEv", scope: !378, file: !379, line: 205, type: !219, scopeLine: 205, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!408 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7is_realEv", scope: !378, file: !379, line: 214, type: !219, scopeLine: 214, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!409 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE17is_floating_pointEv", scope: !378, file: !379, line: 219, type: !219, scopeLine: 219, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!410 = !DISubprogram(name: "accum_base", scope: !378, file: !379, line: 229, type: !411, scopeLine: 229, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!411 = !DISubroutineType(types: !412)
!412 = !{null, !413}
!413 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !378, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!414 = !DISubprogram(name: "accum_base", scope: !378, file: !379, line: 242, type: !415, scopeLine: 242, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!415 = !DISubroutineType(types: !416)
!416 = !{null, !413, !384}
!417 = !DISubprogram(name: "operator v8accfloat", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEcv10v8accfloatEv", scope: !378, file: !379, line: 256, type: !418, scopeLine: 256, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!418 = !DISubroutineType(types: !419)
!419 = !{!384, !420}
!420 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !421, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!421 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !378)
!422 = !{!394, !423, !210}
!423 = !DITemplateValueParameter(name: "MinBits", type: !15, value: i32 32)
!424 = !DISubprogram(name: "accum", scope: !374, file: !375, line: 59, type: !425, scopeLine: 59, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!425 = !DISubroutineType(types: !426)
!426 = !{null, !427, !428}
!427 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !374, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!428 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !429, size: 32)
!429 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !430)
!430 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !374, file: !375, line: 51, baseType: !378)
!431 = !DISubprogram(name: "value_class", linkageName: "_ZN3aie5accumI8accfloatLj8EE11value_classEv", scope: !374, file: !375, line: 78, type: !399, scopeLine: 78, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!432 = !DISubprogram(name: "accum_min_bits", linkageName: "_ZN3aie5accumI8accfloatLj8EE14accum_min_bitsEv", scope: !374, file: !375, line: 83, type: !214, scopeLine: 83, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!433 = !DISubprogram(name: "accum_bits", linkageName: "_ZN3aie5accumI8accfloatLj8EE10accum_bitsEv", scope: !374, file: !375, line: 90, type: !214, scopeLine: 90, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!434 = !DISubprogram(name: "value_bits", linkageName: "_ZN3aie5accumI8accfloatLj8EE10value_bitsEv", scope: !374, file: !375, line: 97, type: !214, scopeLine: 97, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!435 = !DISubprogram(name: "memory_bits", linkageName: "_ZN3aie5accumI8accfloatLj8EE11memory_bitsEv", scope: !374, file: !375, line: 104, type: !214, scopeLine: 104, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!436 = !DISubprogram(name: "size", linkageName: "_ZN3aie5accumI8accfloatLj8EE4sizeEv", scope: !374, file: !375, line: 109, type: !214, scopeLine: 109, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!437 = !DISubprogram(name: "bits", linkageName: "_ZN3aie5accumI8accfloatLj8EE4bitsEv", scope: !374, file: !375, line: 114, type: !214, scopeLine: 114, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!438 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie5accumI8accfloatLj8EE10is_complexEv", scope: !374, file: !375, line: 119, type: !219, scopeLine: 119, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!439 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie5accumI8accfloatLj8EE7is_realEv", scope: !374, file: !375, line: 124, type: !219, scopeLine: 124, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!440 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie5accumI8accfloatLj8EE17is_floating_pointEv", scope: !374, file: !375, line: 129, type: !219, scopeLine: 129, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!441 = !DISubprogram(name: "accum", scope: !374, file: !375, line: 163, type: !442, scopeLine: 163, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!442 = !DISubroutineType(types: !443)
!443 = !{null, !427}
!444 = !DISubprogram(name: "accum", scope: !374, file: !375, line: 168, type: !445, scopeLine: 168, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!445 = !DISubroutineType(types: !446)
!446 = !{null, !427, !447}
!447 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !448, size: 32)
!448 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !374)
!449 = !DISubprogram(name: "accum", scope: !374, file: !375, line: 188, type: !450, scopeLine: 188, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!450 = !DISubroutineType(types: !451)
!451 = !{null, !427, !452}
!452 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !374, file: !375, line: 73, baseType: !384, flags: DIFlagPublic)
!453 = !DISubprogram(name: "operator v8accfloat", linkageName: "_ZNK3aie5accumI8accfloatLj8EEcv10v8accfloatEv", scope: !374, file: !375, line: 234, type: !454, scopeLine: 234, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!454 = !DISubroutineType(types: !455)
!455 = !{!452, !456}
!456 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !448, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!457 = !{!458, !210}
!458 = !DITemplateTypeParameter(name: "MinAccumTag", type: !459)
!459 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "accfloat", file: !34, line: 1591, size: 32, flags: DIFlagFwdDecl, identifier: "_ZTS8accfloat")
!460 = !DILocalVariable(name: "blankVect", scope: !84, file: !83, line: 176, type: !461)
!461 = !DIDerivedType(tag: DW_TAG_typedef, name: "dataAcc_t", scope: !84, file: !83, line: 163, baseType: !188)
!462 = !DILocalVariable(name: "outVect", scope: !84, file: !83, line: 177, type: !461)
!463 = !DILocalVariable(name: "inMatrixBuff", scope: !84, file: !83, line: 180, type: !107)
!464 = !DILocalVariable(name: "inMatrixPtrRtp", scope: !84, file: !83, line: 181, type: !107)
!465 = !DILocalVariable(name: "matrixPtr", scope: !84, file: !83, line: 182, type: !107)
!466 = !DILocalVariable(name: "matrixStartPtr", scope: !84, file: !83, line: 184, type: !185)
!467 = !DILocalVariable(name: "vectorStartPtr", scope: !84, file: !83, line: 185, type: !370)
!468 = !DILocalVariable(name: "outPtr", scope: !84, file: !83, line: 186, type: !469)
!469 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !470)
!470 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !471, size: 32)
!471 = !DIDerivedType(tag: DW_TAG_typedef, name: "dataOut_t", scope: !84, file: !83, line: 164, baseType: !188)
!472 = !DILocalVariable(name: "frame", scope: !473, file: !83, line: 189, type: !9)
!473 = distinct !DILexicalBlock(scope: !84, file: !83, line: 189, column: 5)
!474 = !DILocalVariable(name: "idx", scope: !475, file: !83, line: 191, type: !9)
!475 = distinct !DILexicalBlock(scope: !476, file: !83, line: 191, column: 9)
!476 = distinct !DILexicalBlock(scope: !477, file: !83, line: 189, column: 57)
!477 = distinct !DILexicalBlock(scope: !473, file: !83, line: 189, column: 5)
!478 = !DILocalVariable(name: "vecInB", scope: !479, file: !83, line: 202, type: !9)
!479 = distinct !DILexicalBlock(scope: !480, file: !83, line: 202, column: 17)
!480 = distinct !DILexicalBlock(scope: !481, file: !83, line: 191, column: 114)
!481 = distinct !DILexicalBlock(scope: !475, file: !83, line: 191, column: 9)
!482 = !DILocalVariable(name: "jdx", scope: !483, file: !83, line: 205, type: !9)
!483 = distinct !DILexicalBlock(scope: !484, file: !83, line: 205, column: 21)
!484 = distinct !DILexicalBlock(scope: !485, file: !83, line: 202, column: 74)
!485 = distinct !DILexicalBlock(scope: !479, file: !83, line: 202, column: 17)
!486 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16float", file: !34, line: 617, baseType: !487)
!487 = !DIBasicType(name: "v16float", size: 512, encoding: DW_ATE_unsigned)
!488 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16accfloat", file: !34, line: 629, baseType: !489)
!489 = !DIBasicType(name: "v16accfloat", size: 512, encoding: DW_ATE_unsigned)
!490 = !DIDerivedType(tag: DW_TAG_typedef, name: "v32bfloat16", file: !34, line: 613, baseType: !491)
!491 = !DIBasicType(name: "v32bfloat16", size: 512, encoding: DW_ATE_unsigned)
!492 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "accum<accfloat, 16U>", scope: !8, file: !375, line: 47, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !493, templateParams: !566, identifier: "_ZTSN3aie5accumI8accfloatLj16EEE")
!493 = !{!494, !533, !540, !541, !542, !543, !544, !545, !546, !547, !548, !549, !550, !553, !558, !562}
!494 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !492, baseType: !495, extraData: i32 0)
!495 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "accum_base<(aie::detail::AccumClass)2, 32U, 16U>", scope: !7, file: !379, line: 144, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !496, templateParams: !532, identifier: "_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEE")
!496 = !{!497, !498, !499, !510, !511, !512, !513, !514, !515, !516, !517, !518, !519, !520, !524, !527}
!497 = !DIDerivedType(tag: DW_TAG_member, name: "Bits", scope: !495, file: !379, line: 146, baseType: !101, flags: DIFlagStaticMember, extraData: i32 32)
!498 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems", scope: !495, file: !379, line: 985, baseType: !101, flags: DIFlagStaticMember)
!499 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !495, file: !379, line: 991, baseType: !500, size: 512)
!500 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !495, file: !379, line: 155, baseType: !501, flags: DIFlagPublic)
!501 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_storage_t<(aie::detail::AccumClass)2, Bits, 16U>", scope: !7, file: !386, line: 135, baseType: !502)
!502 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !503, file: !386, line: 167, baseType: !488)
!503 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "accum_storage<(aie::detail::AccumClass)2, 32U, 16U>", scope: !7, file: !386, line: 167, size: 8, flags: DIFlagTypePassByValue, elements: !504, templateParams: !508, identifier: "_ZTSN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EEE")
!504 = !{!505}
!505 = !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv", scope: !503, file: !386, line: 167, type: !506, scopeLine: 167, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!506 = !DISubroutineType(types: !507)
!507 = !{!502}
!508 = !{!394, !395, !509}
!509 = !DITemplateValueParameter(name: "Elems", type: !15, value: i32 16)
!510 = !DISubprogram(name: "value_class", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE11value_classEv", scope: !495, file: !379, line: 157, type: !399, scopeLine: 157, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!511 = !DISubprogram(name: "accum_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE10accum_bitsEv", scope: !495, file: !379, line: 162, type: !214, scopeLine: 162, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!512 = !DISubprogram(name: "accum_min_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE14accum_min_bitsEv", scope: !495, file: !379, line: 167, type: !214, scopeLine: 167, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!513 = !DISubprogram(name: "value_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE10value_bitsEv", scope: !495, file: !379, line: 172, type: !214, scopeLine: 172, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!514 = !DISubprogram(name: "memory_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE11memory_bitsEv", scope: !495, file: !379, line: 180, type: !214, scopeLine: 180, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!515 = !DISubprogram(name: "size", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE4sizeEv", scope: !495, file: !379, line: 192, type: !214, scopeLine: 192, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!516 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE4bitsEv", scope: !495, file: !379, line: 197, type: !214, scopeLine: 197, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!517 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE10is_complexEv", scope: !495, file: !379, line: 205, type: !219, scopeLine: 205, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!518 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7is_realEv", scope: !495, file: !379, line: 214, type: !219, scopeLine: 214, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!519 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE17is_floating_pointEv", scope: !495, file: !379, line: 219, type: !219, scopeLine: 219, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!520 = !DISubprogram(name: "accum_base", scope: !495, file: !379, line: 229, type: !521, scopeLine: 229, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!521 = !DISubroutineType(types: !522)
!522 = !{null, !523}
!523 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !495, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!524 = !DISubprogram(name: "accum_base", scope: !495, file: !379, line: 242, type: !525, scopeLine: 242, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!525 = !DISubroutineType(types: !526)
!526 = !{null, !523, !500}
!527 = !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv", scope: !495, file: !379, line: 256, type: !528, scopeLine: 256, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!528 = !DISubroutineType(types: !529)
!529 = !{!500, !530}
!530 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !531, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!531 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !495)
!532 = !{!394, !423, !509}
!533 = !DISubprogram(name: "accum", scope: !492, file: !375, line: 59, type: !534, scopeLine: 59, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!534 = !DISubroutineType(types: !535)
!535 = !{null, !536, !537}
!536 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !492, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!537 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !538, size: 32)
!538 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !539)
!539 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !492, file: !375, line: 51, baseType: !495)
!540 = !DISubprogram(name: "value_class", linkageName: "_ZN3aie5accumI8accfloatLj16EE11value_classEv", scope: !492, file: !375, line: 78, type: !399, scopeLine: 78, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!541 = !DISubprogram(name: "accum_min_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE14accum_min_bitsEv", scope: !492, file: !375, line: 83, type: !214, scopeLine: 83, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!542 = !DISubprogram(name: "accum_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE10accum_bitsEv", scope: !492, file: !375, line: 90, type: !214, scopeLine: 90, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!543 = !DISubprogram(name: "value_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE10value_bitsEv", scope: !492, file: !375, line: 97, type: !214, scopeLine: 97, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!544 = !DISubprogram(name: "memory_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE11memory_bitsEv", scope: !492, file: !375, line: 104, type: !214, scopeLine: 104, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!545 = !DISubprogram(name: "size", linkageName: "_ZN3aie5accumI8accfloatLj16EE4sizeEv", scope: !492, file: !375, line: 109, type: !214, scopeLine: 109, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!546 = !DISubprogram(name: "bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE4bitsEv", scope: !492, file: !375, line: 114, type: !214, scopeLine: 114, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!547 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie5accumI8accfloatLj16EE10is_complexEv", scope: !492, file: !375, line: 119, type: !219, scopeLine: 119, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!548 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie5accumI8accfloatLj16EE7is_realEv", scope: !492, file: !375, line: 124, type: !219, scopeLine: 124, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!549 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie5accumI8accfloatLj16EE17is_floating_pointEv", scope: !492, file: !375, line: 129, type: !219, scopeLine: 129, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!550 = !DISubprogram(name: "accum", scope: !492, file: !375, line: 163, type: !551, scopeLine: 163, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!551 = !DISubroutineType(types: !552)
!552 = !{null, !536}
!553 = !DISubprogram(name: "accum", scope: !492, file: !375, line: 168, type: !554, scopeLine: 168, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!554 = !DISubroutineType(types: !555)
!555 = !{null, !536, !556}
!556 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !557, size: 32)
!557 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !492)
!558 = !DISubprogram(name: "accum", scope: !492, file: !375, line: 188, type: !559, scopeLine: 188, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!559 = !DISubroutineType(types: !560)
!560 = !{null, !536, !561}
!561 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !492, file: !375, line: 73, baseType: !500, flags: DIFlagPublic)
!562 = !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv", scope: !492, file: !375, line: 234, type: !563, scopeLine: 234, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!563 = !DISubroutineType(types: !564)
!564 = !{!561, !565}
!565 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !557, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!566 = !{!458, !509}
!567 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16acc32", file: !34, line: 560, baseType: !568)
!568 = !DIBasicType(name: "v16acc32", size: 512, encoding: DW_ATE_unsigned)
!569 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tile", scope: !7, file: !570, line: 30, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !571, identifier: "_ZTSN3aie6detail4tileE")
!570 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/tile.hpp", directory: "")
!571 = !{!572, !577, !581, !590, !591, !596, !599, !602, !605, !608}
!572 = !DIDerivedType(tag: DW_TAG_member, name: "compute_row_offset", scope: !569, file: !570, line: 33, baseType: !573, flags: DIFlagStaticMember, extraData: i16 3)
!573 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !574)
!574 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !575, line: 30, baseType: !576)
!575 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdint.h", directory: "")
!576 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!577 = !DISubprogram(name: "tile", scope: !569, file: !570, line: 36, type: !578, scopeLine: 36, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!578 = !DISubroutineType(types: !579)
!579 = !{null, !580}
!580 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !569, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!581 = !DISubprogram(name: "global_id", linkageName: "_ZNK3aie6detail4tile9global_idEv", scope: !569, file: !570, line: 40, type: !582, scopeLine: 40, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!582 = !DISubroutineType(types: !583)
!583 = !{!584, !588}
!584 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tile_id", scope: !8, file: !14, line: 52, size: 32, flags: DIFlagTypePassByValue, elements: !585, identifier: "_ZTSN3aie7tile_idE")
!585 = !{!586, !587}
!586 = !DIDerivedType(tag: DW_TAG_member, name: "row", scope: !584, file: !14, line: 54, baseType: !574, size: 16)
!587 = !DIDerivedType(tag: DW_TAG_member, name: "col", scope: !584, file: !14, line: 55, baseType: !574, size: 16, offset: 16)
!588 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !589, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!589 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !569)
!590 = !DISubprogram(name: "id", linkageName: "_ZNK3aie6detail4tile2idEv", scope: !569, file: !570, line: 49, type: !582, scopeLine: 49, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!591 = !DISubprogram(name: "cycles", linkageName: "_ZNK3aie6detail4tile6cyclesEv", scope: !569, file: !570, line: 58, type: !592, scopeLine: 58, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!592 = !DISubroutineType(types: !593)
!593 = !{!594, !588}
!594 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !575, line: 32, baseType: !595)
!595 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!596 = !DISubprogram(name: "current", linkageName: "_ZN3aie6detail4tile7currentEv", scope: !569, file: !570, line: 64, type: !597, scopeLine: 64, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!597 = !DISubroutineType(types: !598)
!598 = !{!569}
!599 = !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE", scope: !569, file: !570, line: 70, type: !600, scopeLine: 70, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!600 = !DISubroutineType(types: !601)
!601 = !{null, !580, !27}
!602 = !DISubprogram(name: "get_saturation", linkageName: "_ZNK3aie6detail4tile14get_saturationEv", scope: !569, file: !570, line: 76, type: !603, scopeLine: 76, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!603 = !DISubroutineType(types: !604)
!604 = !{!27, !588}
!605 = !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE", scope: !569, file: !570, line: 82, type: !606, scopeLine: 82, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!606 = !DISubroutineType(types: !607)
!607 = !{null, !580, !13}
!608 = !DISubprogram(name: "get_rounding", linkageName: "_ZNK3aie6detail4tile12get_roundingEv", scope: !569, file: !570, line: 88, type: !609, scopeLine: 88, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!609 = !DISubroutineType(types: !610)
!610 = !{!13, !588}
!611 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tile", scope: !8, file: !612, line: 25, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !613, identifier: "_ZTSN3aie4tileE")
!612 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/tile.hpp", directory: "")
!613 = !{!614, !615, !622, !627, !628, !631, !634, !637, !640, !643}
!614 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !611, baseType: !569, extraData: i32 0)
!615 = !DISubprogram(name: "tile", scope: !611, file: !612, line: 30, type: !616, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!616 = !DISubroutineType(types: !617)
!617 = !{null, !618, !619}
!618 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !611, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!619 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !620, size: 32)
!620 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !621)
!621 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !611, file: !612, line: 28, baseType: !569)
!622 = !DISubprogram(name: "global_id", linkageName: "_ZNK3aie4tile9global_idEv", scope: !611, file: !612, line: 34, type: !623, scopeLine: 34, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!623 = !DISubroutineType(types: !624)
!624 = !{!584, !625}
!625 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !626, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!626 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !611)
!627 = !DISubprogram(name: "id", linkageName: "_ZNK3aie4tile2idEv", scope: !611, file: !612, line: 38, type: !623, scopeLine: 38, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!628 = !DISubprogram(name: "cycles", linkageName: "_ZNK3aie4tile6cyclesEv", scope: !611, file: !612, line: 42, type: !629, scopeLine: 42, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!629 = !DISubroutineType(types: !630)
!630 = !{!594, !625}
!631 = !DISubprogram(name: "current", linkageName: "_ZN3aie4tile7currentEv", scope: !611, file: !612, line: 46, type: !632, scopeLine: 46, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!632 = !DISubroutineType(types: !633)
!633 = !{!611}
!634 = !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie4tile14set_saturationENS_15saturation_modeE", scope: !611, file: !612, line: 50, type: !635, scopeLine: 50, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!635 = !DISubroutineType(types: !636)
!636 = !{null, !618, !27}
!637 = !DISubprogram(name: "get_saturation", linkageName: "_ZNK3aie4tile14get_saturationEv", scope: !611, file: !612, line: 54, type: !638, scopeLine: 54, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!638 = !DISubroutineType(types: !639)
!639 = !{!27, !625}
!640 = !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie4tile12set_roundingENS_13rounding_modeE", scope: !611, file: !612, line: 58, type: !641, scopeLine: 58, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!641 = !DISubroutineType(types: !642)
!642 = !{null, !618, !13}
!643 = !DISubprogram(name: "get_rounding", linkageName: "_ZNK3aie4tile12get_roundingEv", scope: !611, file: !612, line: 63, type: !644, scopeLine: 63, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!644 = !DISubroutineType(types: !645)
!645 = !{!13, !625}
!646 = !DIBasicType(name: "v64uint4", size: 256, encoding: DW_ATE_unsigned)
!647 = !DIBasicType(name: "v32uint8", size: 256, encoding: DW_ATE_unsigned)
!648 = !DIBasicType(name: "v32int8", size: 256, encoding: DW_ATE_unsigned)
!649 = !DIBasicType(name: "v16uint16", size: 256, encoding: DW_ATE_unsigned)
!650 = !DIBasicType(name: "v16int16", size: 256, encoding: DW_ATE_unsigned)
!651 = !DIBasicType(name: "v8cint16", size: 256, encoding: DW_ATE_unsigned)
!652 = !DIBasicType(name: "v8uint32", size: 256, encoding: DW_ATE_unsigned)
!653 = !DIBasicType(name: "v8int32", size: 256, encoding: DW_ATE_unsigned)
!654 = !DIBasicType(name: "v4cint32", size: 256, encoding: DW_ATE_unsigned)
!655 = !DIBasicType(name: "v16bfloat16", size: 256, encoding: DW_ATE_unsigned)
!656 = !DIBasicType(name: "v8acc32", size: 256, encoding: DW_ATE_unsigned)
!657 = !DIBasicType(name: "v4acc64", size: 256, encoding: DW_ATE_unsigned)
!658 = !DIBasicType(name: "v2cacc64", size: 256, encoding: DW_ATE_unsigned)
!659 = !DIBasicType(name: "v4caccfloat", size: 256, encoding: DW_ATE_unsigned)
!660 = !DIBasicType(name: "v4cfloat", size: 256, encoding: DW_ATE_unsigned)
!661 = !DIBasicType(name: "v8cbfloat16", size: 256, encoding: DW_ATE_unsigned)
!662 = !DIBasicType(name: "v32uint4", size: 128, encoding: DW_ATE_unsigned)
!663 = !DIBasicType(name: "v16uint8", size: 128, encoding: DW_ATE_unsigned)
!664 = !DIBasicType(name: "v16int8", size: 128, encoding: DW_ATE_unsigned)
!665 = !DIBasicType(name: "v8uint16", size: 128, encoding: DW_ATE_unsigned)
!666 = !DIBasicType(name: "v8int16", size: 128, encoding: DW_ATE_unsigned)
!667 = !DIBasicType(name: "v4cint16", size: 128, encoding: DW_ATE_unsigned)
!668 = !DIBasicType(name: "v4uint32", size: 128, encoding: DW_ATE_unsigned)
!669 = !DIBasicType(name: "v4int32", size: 128, encoding: DW_ATE_unsigned)
!670 = !DIBasicType(name: "v2cint32", size: 128, encoding: DW_ATE_unsigned)
!671 = !DIBasicType(name: "v8bfloat16", size: 128, encoding: DW_ATE_unsigned)
!672 = !DIBasicType(name: "v4float", size: 128, encoding: DW_ATE_unsigned)
!673 = !DIBasicType(name: "v2cfloat", size: 128, encoding: DW_ATE_unsigned)
!674 = !DIBasicType(name: "v16uint4", size: 64, encoding: DW_ATE_unsigned)
!675 = !DIBasicType(name: "v16int4", size: 64, encoding: DW_ATE_unsigned)
!676 = !DIBasicType(name: "cint32_w64", size: 64, encoding: DW_ATE_unsigned)
!677 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cint32", file: !34, line: 5738, size: 64, flags: DIFlagTypePassByValue, elements: !678, identifier: "_ZTS6cint32")
!678 = !{!679, !680, !681, !685, !690, !731}
!679 = !DIDerivedType(tag: DW_TAG_member, name: "real", scope: !677, file: !34, line: 5739, baseType: !9, size: 32)
!680 = !DIDerivedType(tag: DW_TAG_member, name: "imag", scope: !677, file: !34, line: 5740, baseType: !9, size: 32, offset: 32)
!681 = !DISubprogram(name: "cint32", scope: !677, file: !34, line: 5743, type: !682, scopeLine: 5743, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!682 = !DISubroutineType(types: !683)
!683 = !{null, !684, !9, !9}
!684 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !677, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!685 = !DISubprogram(name: "cint32", scope: !677, file: !34, line: 5744, type: !686, scopeLine: 5744, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!686 = !DISubroutineType(types: !687)
!687 = !{null, !684, !688}
!688 = !DIDerivedType(tag: DW_TAG_typedef, name: "cint16", file: !34, line: 476, baseType: !689)
!689 = !DIBasicType(name: "cint16", size: 32, encoding: DW_ATE_unsigned)
!690 = !DISubprogram(name: "cint32", scope: !677, file: !34, line: 5745, type: !691, scopeLine: 5745, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!691 = !DISubroutineType(types: !692)
!692 = !{null, !684, !693}
!693 = !DIDerivedType(tag: DW_TAG_typedef, name: "cint32_w64", file: !34, line: 635, baseType: !694)
!694 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cint32_w64", file: !34, line: 5714, size: 64, flags: DIFlagTypePassByValue, elements: !695, identifier: "_ZTS10cint32_w64")
!695 = !{!696, !698, !702, !705, !709, !712}
!696 = !DIDerivedType(tag: DW_TAG_member, name: "mw", scope: !694, file: !34, line: 5723, baseType: !697, size: 64)
!697 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16int4", file: !34, line: 509, baseType: !675)
!698 = !DISubprogram(name: "cint32_w64", scope: !694, file: !34, line: 5716, type: !699, scopeLine: 5716, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!699 = !DISubroutineType(types: !700)
!700 = !{null, !701, !9}
!701 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !694, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!702 = !DISubprogram(name: "cint32_w64", scope: !694, file: !34, line: 5717, type: !703, scopeLine: 5717, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!703 = !DISubroutineType(types: !704)
!704 = !{null, !701, !9, !9}
!705 = !DISubprogram(name: "cint32_w64", scope: !694, file: !34, line: 5718, type: !706, scopeLine: 5718, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!706 = !DISubroutineType(types: !707)
!707 = !{null, !701, !708}
!708 = !DIDerivedType(tag: DW_TAG_typedef, name: "cint32", file: !34, line: 862, baseType: !677)
!709 = !DISubprogram(name: "cint32_w64", scope: !694, file: !34, line: 5719, type: !710, scopeLine: 5719, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!710 = !DISubroutineType(types: !711)
!711 = !{null, !701}
!712 = !DISubprogram(name: "cint32_w64", scope: !694, file: !34, line: 5720, type: !713, scopeLine: 5720, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!713 = !DISubroutineType(types: !714)
!714 = !{null, !701, !33, !715}
!715 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16int4", file: !34, line: 509, baseType: !716)
!716 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "v16int4", file: !34, line: 1831, size: 64, flags: DIFlagTypePassByValue, elements: !717, identifier: "_ZTS7v16int4")
!717 = !{!718, !719, !720, !725, !728}
!718 = !DIDerivedType(tag: DW_TAG_member, name: "m1", scope: !716, file: !34, line: 1839, baseType: !15, size: 32, flags: DIFlagBitField, extraData: i64 0)
!719 = !DIDerivedType(tag: DW_TAG_member, name: "m0", scope: !716, file: !34, line: 1840, baseType: !15, size: 32, offset: 32, flags: DIFlagBitField, extraData: i64 0)
!720 = !DISubprogram(name: "v16int4", scope: !716, file: !34, line: 1833, type: !721, scopeLine: 1833, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!721 = !DISubroutineType(types: !722)
!722 = !{null, !723, !724}
!723 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !716, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!724 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16uint4", file: !34, line: 510, baseType: !674)
!725 = !DISubprogram(name: "v16int4", scope: !716, file: !34, line: 1834, type: !726, scopeLine: 1834, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!726 = !DISubroutineType(types: !727)
!727 = !{null, !723}
!728 = !DISubprogram(name: "v16int4", scope: !716, file: !34, line: 1835, type: !729, scopeLine: 1835, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!729 = !DISubroutineType(types: !730)
!730 = !{null, !723, !33, !15, !15}
!731 = !DISubprogram(name: "cint32", scope: !677, file: !34, line: 5746, type: !732, scopeLine: 5746, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!732 = !DISubroutineType(types: !733)
!733 = !{null, !684}
!734 = !DIBasicType(name: "bfloat16", size: 16, encoding: DW_ATE_unsigned)
!735 = !DIBasicType(name: "uint4_t", size: 8, encoding: DW_ATE_unsigned)
!736 = !DIBasicType(name: "int4_t", size: 8, encoding: DW_ATE_signed)
!737 = !DIBasicType(name: "v32int4", size: 128, encoding: DW_ATE_unsigned)
!738 = !DIBasicType(name: "v4cbfloat16", size: 128, encoding: DW_ATE_unsigned)
!739 = !DIBasicType(name: "v64int4", size: 256, encoding: DW_ATE_unsigned)
!740 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector<float, 16U>", scope: !8, file: !189, line: 77, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !741, templateParams: !756, identifier: "_ZTSN3aie6vectorIfLj16EEE")
!741 = !{!742, !799, !806, !807, !808, !809, !810, !811, !812, !813, !814, !815, !818, !822, !828, !833, !834, !839, !842, !845, !849, !886, !887, !888}
!742 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !740, baseType: !743, extraData: i32 0)
!743 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_base<float, 16U>", scope: !7, file: !193, line: 348, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !744, templateParams: !756, identifier: "_ZTSN3aie6detail11vector_baseIfLj16EEE")
!744 = !{!745, !746, !747, !748, !757, !758, !759, !760, !761, !762, !763, !764, !765, !769, !773, !782, !787, !790, !795, !798}
!745 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems", scope: !743, file: !193, line: 1350, baseType: !101, flags: DIFlagStaticMember)
!746 = !DIDerivedType(tag: DW_TAG_member, name: "num_storage_elems", scope: !743, file: !193, line: 1351, baseType: !101, flags: DIFlagStaticMember, extraData: i32 1)
!747 = !DIDerivedType(tag: DW_TAG_member, name: "is_compound_storage", scope: !743, file: !193, line: 1352, baseType: !198, flags: DIFlagStaticMember)
!748 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !743, file: !193, line: 1357, baseType: !749, size: 512)
!749 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_storage_t<float, 16U>", scope: !7, file: !201, line: 205, baseType: !750)
!750 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !751, file: !201, line: 299, baseType: !486)
!751 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vector_storage<float, 16U>", scope: !7, file: !201, line: 299, size: 8, flags: DIFlagTypePassByValue, elements: !752, templateParams: !756, identifier: "_ZTSN3aie6detail14vector_storageIfLj16EEE")
!752 = !{!753}
!753 = !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj16EE5undefEv", scope: !751, file: !201, line: 299, type: !754, scopeLine: 299, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!754 = !DISubroutineType(types: !755)
!755 = !{!750}
!756 = !{!209, !509}
!757 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE9type_bitsEv", scope: !743, file: !193, line: 361, type: !214, scopeLine: 361, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!758 = !DISubprogram(name: "size", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE4sizeEv", scope: !743, file: !193, line: 366, type: !214, scopeLine: 366, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!759 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE4bitsEv", scope: !743, file: !193, line: 371, type: !214, scopeLine: 371, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!760 = !DISubprogram(name: "is_signed", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE9is_signedEv", scope: !743, file: !193, line: 376, type: !219, scopeLine: 376, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!761 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE10is_complexEv", scope: !743, file: !193, line: 381, type: !219, scopeLine: 381, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!762 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE7is_realEv", scope: !743, file: !193, line: 386, type: !219, scopeLine: 386, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!763 = !DISubprogram(name: "is_integral", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE11is_integralEv", scope: !743, file: !193, line: 391, type: !219, scopeLine: 391, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!764 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE17is_floating_pointEv", scope: !743, file: !193, line: 396, type: !219, scopeLine: 396, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!765 = !DISubprogram(name: "vector_base", scope: !743, file: !193, line: 402, type: !766, scopeLine: 402, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!766 = !DISubroutineType(types: !767)
!767 = !{null, !768}
!768 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !743, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!769 = !DISubprogram(name: "vector_base", scope: !743, file: !193, line: 408, type: !770, scopeLine: 408, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!770 = !DISubroutineType(types: !771)
!771 = !{null, !768, !772}
!772 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !743, file: !193, line: 359, baseType: !750, flags: DIFlagPublic)
!773 = !DISubprogram(name: "vector_base", scope: !743, file: !193, line: 421, type: !774, scopeLine: 421, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!774 = !DISubroutineType(types: !775)
!775 = !{null, !768, !776}
!776 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !777, size: 32)
!777 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !778)
!778 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_type", scope: !743, file: !193, line: 357, baseType: !779, flags: DIFlagPublic)
!779 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_vector_type_t<float, 16U>", scope: !7, file: !201, line: 116, baseType: !780)
!780 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !781, file: !201, line: 97, baseType: !486)
!781 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "native_vector_type<float, 16U>", scope: !7, file: !201, line: 97, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !756, identifier: "_ZTSN3aie6detail18native_vector_typeIfLj16EEE")
!782 = !DISubprogram(name: "push", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE4pushEf", scope: !743, file: !193, line: 494, type: !783, scopeLine: 494, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!783 = !DISubroutineType(types: !784)
!784 = !{!785, !768, !786}
!785 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !743, size: 32)
!786 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !743, file: !193, line: 358, baseType: !80, flags: DIFlagPublic)
!787 = !DISubprogram(name: "set", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE3setEfj", scope: !743, file: !193, line: 652, type: !788, scopeLine: 652, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!788 = !DISubroutineType(types: !789)
!789 = !{null, !768, !786, !15}
!790 = !DISubprogram(name: "get", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE3getEj", scope: !743, file: !193, line: 703, type: !791, scopeLine: 703, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!791 = !DISubroutineType(types: !792)
!792 = !{!786, !793, !15}
!793 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !794, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!794 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !743)
!795 = !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv", scope: !743, file: !193, line: 1154, type: !796, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!796 = !DISubroutineType(types: !797)
!797 = !{!778, !793}
!798 = !DISubprogram(name: "operator v16float", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EEcv8v16floatEv", scope: !743, file: !193, line: 1164, type: !796, scopeLine: 1164, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!799 = !DISubprogram(name: "vector", scope: !740, file: !189, line: 87, type: !800, scopeLine: 87, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!800 = !DISubroutineType(types: !801)
!801 = !{null, !802, !803}
!802 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !740, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!803 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !804, size: 32)
!804 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !805)
!805 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !740, file: !189, line: 80, baseType: !743)
!806 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie6vectorIfLj16EE9type_bitsEv", scope: !740, file: !189, line: 102, type: !214, scopeLine: 102, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!807 = !DISubprogram(name: "size", linkageName: "_ZN3aie6vectorIfLj16EE4sizeEv", scope: !740, file: !189, line: 107, type: !214, scopeLine: 107, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!808 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6vectorIfLj16EE4bitsEv", scope: !740, file: !189, line: 112, type: !214, scopeLine: 112, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!809 = !DISubprogram(name: "bytes", linkageName: "_ZN3aie6vectorIfLj16EE5bytesEv", scope: !740, file: !189, line: 117, type: !214, scopeLine: 117, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!810 = !DISubprogram(name: "is_signed", linkageName: "_ZN3aie6vectorIfLj16EE9is_signedEv", scope: !740, file: !189, line: 122, type: !219, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!811 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6vectorIfLj16EE10is_complexEv", scope: !740, file: !189, line: 127, type: !219, scopeLine: 127, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!812 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6vectorIfLj16EE7is_realEv", scope: !740, file: !189, line: 132, type: !219, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!813 = !DISubprogram(name: "is_integral", linkageName: "_ZN3aie6vectorIfLj16EE11is_integralEv", scope: !740, file: !189, line: 137, type: !219, scopeLine: 137, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!814 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6vectorIfLj16EE17is_floating_pointEv", scope: !740, file: !189, line: 142, type: !219, scopeLine: 142, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!815 = !DISubprogram(name: "vector", scope: !740, file: !189, line: 148, type: !816, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!816 = !DISubroutineType(types: !817)
!817 = !{null, !802}
!818 = !DISubprogram(name: "vector", scope: !740, file: !189, line: 159, type: !819, scopeLine: 159, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!819 = !DISubroutineType(types: !820)
!820 = !{null, !802, !821}
!821 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !740, file: !189, line: 97, baseType: !772, flags: DIFlagPublic)
!822 = !DISubprogram(name: "vector", scope: !740, file: !189, line: 173, type: !823, scopeLine: 173, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!823 = !DISubroutineType(types: !824)
!824 = !{null, !802, !825}
!825 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !826, size: 32)
!826 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !827)
!827 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_type", scope: !740, file: !189, line: 91, baseType: !778, flags: DIFlagPublic)
!828 = !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6vectorIfLj16EE9to_nativeEv", scope: !740, file: !189, line: 196, type: !829, scopeLine: 196, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!829 = !DISubroutineType(types: !830)
!830 = !{!827, !831}
!831 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !832, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!832 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !740)
!833 = !DISubprogram(name: "operator v16float", linkageName: "_ZNK3aie6vectorIfLj16EEcv8v16floatEv", scope: !740, file: !189, line: 205, type: !829, scopeLine: 205, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!834 = !DISubprogram(name: "push", linkageName: "_ZN3aie6vectorIfLj16EE4pushEf", scope: !740, file: !189, line: 233, type: !835, scopeLine: 233, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!835 = !DISubroutineType(types: !836)
!836 = !{!837, !802, !838}
!837 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !740, size: 32)
!838 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !740, file: !189, line: 94, baseType: !786, flags: DIFlagPublic)
!839 = !DISubprogram(name: "set", linkageName: "_ZN3aie6vectorIfLj16EE3setEfj", scope: !740, file: !189, line: 271, type: !840, scopeLine: 271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!840 = !DISubroutineType(types: !841)
!841 = !{null, !802, !838, !15}
!842 = !DISubprogram(name: "get", linkageName: "_ZNK3aie6vectorIfLj16EE3getEj", scope: !740, file: !189, line: 282, type: !843, scopeLine: 282, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!843 = !DISubroutineType(types: !844)
!844 = !{!838, !831, !15}
!845 = !DISubprogram(name: "operator[]", linkageName: "_ZNK3aie6vectorIfLj16EEixEj", scope: !740, file: !189, line: 292, type: !846, scopeLine: 292, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!846 = !DISubroutineType(types: !847)
!847 = !{!848, !831, !15}
!848 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_elem_const_ref<float, 16U>", scope: !8, file: !309, line: 25, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3aie21vector_elem_const_refIfLj16EEE")
!849 = !DISubprogram(name: "operator[]", linkageName: "_ZN3aie6vectorIfLj16EEixEj", scope: !740, file: !189, line: 303, type: !850, scopeLine: 303, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!850 = !DISubroutineType(types: !851)
!851 = !{!852, !802, !15}
!852 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_elem_ref<float, 16U>", scope: !8, file: !309, line: 133, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !853, templateParams: !884, identifier: "_ZTSN3aie15vector_elem_refIfLj16EEE")
!853 = !{!854, !857, !858, !864, !865, !872, !876, !881}
!854 = !DIDerivedType(tag: DW_TAG_member, name: "parent", scope: !852, file: !309, line: 237, baseType: !855, size: 32, flags: DIFlagPublic)
!855 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !856, size: 32)
!856 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !852, file: !309, line: 136, baseType: !740, flags: DIFlagPublic)
!857 = !DIDerivedType(tag: DW_TAG_member, name: "offset", scope: !852, file: !309, line: 238, baseType: !15, size: 32, offset: 32, flags: DIFlagPublic)
!858 = !DISubprogram(name: "get", linkageName: "_ZNK3aie15vector_elem_refIfLj16EE3getEv", scope: !852, file: !309, line: 143, type: !859, scopeLine: 143, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!859 = !DISubroutineType(types: !860)
!860 = !{!861, !862}
!861 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !852, file: !309, line: 138, baseType: !80, flags: DIFlagPublic)
!862 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !863, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!863 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !852)
!864 = !DISubprogram(name: "operator float", linkageName: "_ZNK3aie15vector_elem_refIfLj16EEcvfEv", scope: !852, file: !309, line: 151, type: !859, scopeLine: 151, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!865 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj16EEaSERKf", scope: !852, file: !309, line: 159, type: !866, scopeLine: 159, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!866 = !DISubroutineType(types: !867)
!867 = !{!868, !869, !870}
!868 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !852, size: 32)
!869 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !852, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!870 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !871, size: 32)
!871 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !861)
!872 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj16EEaSERKS1_", scope: !852, file: !309, line: 168, type: !873, scopeLine: 168, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!873 = !DISubroutineType(types: !874)
!874 = !{!868, !869, !875}
!875 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !863, size: 32)
!876 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj16EEaSERKNS_21vector_elem_const_refIfLj16EEE", scope: !852, file: !309, line: 177, type: !877, scopeLine: 177, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!877 = !DISubroutineType(types: !878)
!878 = !{!868, !869, !879}
!879 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !880, size: 32)
!880 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !848)
!881 = !DISubprogram(name: "vector_elem_ref", scope: !852, file: !309, line: 241, type: !882, scopeLine: 241, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!882 = !DISubroutineType(types: !883)
!883 = !{null, !869, !855, !15}
!884 = !{!209, !885}
!885 = !DITemplateValueParameter(name: "N", type: !15, value: i32 16)
!886 = !DISubprogram(name: "elem_const_ref", linkageName: "_ZNK3aie6vectorIfLj16EE14elem_const_refEj", scope: !740, file: !189, line: 314, type: !846, scopeLine: 314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!887 = !DISubprogram(name: "elem_ref", linkageName: "_ZNK3aie6vectorIfLj16EE8elem_refEj", scope: !740, file: !189, line: 325, type: !846, scopeLine: 325, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!888 = !DISubprogram(name: "elem_ref", linkageName: "_ZN3aie6vectorIfLj16EE8elem_refEj", scope: !740, file: !189, line: 336, type: !850, scopeLine: 336, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!889 = !DIBasicType(name: "v128uint4", size: 512, encoding: DW_ATE_unsigned)
!890 = !DIBasicType(name: "v64uint8", size: 512, encoding: DW_ATE_unsigned)
!891 = !DIBasicType(name: "v64int8", size: 512, encoding: DW_ATE_unsigned)
!892 = !DIBasicType(name: "v32uint16", size: 512, encoding: DW_ATE_unsigned)
!893 = !DIBasicType(name: "v32int16", size: 512, encoding: DW_ATE_unsigned)
!894 = !DIBasicType(name: "v16cint16", size: 512, encoding: DW_ATE_unsigned)
!895 = !DIBasicType(name: "v16uint32", size: 512, encoding: DW_ATE_unsigned)
!896 = !DIBasicType(name: "v16int32", size: 512, encoding: DW_ATE_unsigned)
!897 = !DIBasicType(name: "v8cint32", size: 512, encoding: DW_ATE_unsigned)
!898 = !DIBasicType(name: "v8acc64", size: 512, encoding: DW_ATE_unsigned)
!899 = !DIBasicType(name: "v4cacc64", size: 512, encoding: DW_ATE_unsigned)
!900 = !DIBasicType(name: "v8caccfloat", size: 512, encoding: DW_ATE_unsigned)
!901 = !DIBasicType(name: "v8cfloat", size: 512, encoding: DW_ATE_unsigned)
!902 = !DIBasicType(name: "v16cbfloat16", size: 512, encoding: DW_ATE_unsigned)
!903 = !DIBasicType(name: "v128int4", size: 512, encoding: DW_ATE_unsigned)
!904 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op_common<aie::accum<accfloat, 8U>, (aie::Operation)1>", scope: !8, file: !45, line: 358, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !905, templateParams: !925, identifier: "_ZTSN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEE")
!905 = !{!906, !908, !917, !918, !919, !920, !921}
!906 = !DIDerivedType(tag: DW_TAG_member, name: "operation", scope: !904, file: !45, line: 421, baseType: !907, flags: DIFlagStaticMember, extraData: i32 1)
!907 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !44)
!908 = !DIDerivedType(tag: DW_TAG_member, name: "parent_", scope: !904, file: !45, line: 430, baseType: !909, size: 256, flags: DIFlagPrivate)
!909 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !910)
!910 = !DIDerivedType(tag: DW_TAG_typedef, name: "parent1_type", scope: !904, file: !45, line: 360, baseType: !911)
!911 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_remove_t<aie::accum<accfloat, 8U> >", file: !912, line: 210, baseType: !913)
!912 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/aie_core.h", directory: "")
!913 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !914, file: !912, line: 187, baseType: !374)
!914 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_remove<aie::accum<accfloat, 8U> >", file: !912, line: 185, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !915, identifier: "_ZTS22aie_dm_resource_removeIN3aie5accumI8accfloatLj8EEEE")
!915 = !{!916}
!916 = !DITemplateTypeParameter(name: "T", type: !374)
!917 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE9type_bitsEv", scope: !904, file: !45, line: 364, type: !214, scopeLine: 364, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!918 = !DISubprogram(name: "size", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE4sizeEv", scope: !904, file: !45, line: 372, type: !214, scopeLine: 372, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!919 = !DISubprogram(name: "bits", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE4bitsEv", scope: !904, file: !45, line: 380, type: !214, scopeLine: 380, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!920 = !DISubprogram(name: "is_operation_none", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE17is_operation_noneEv", scope: !904, file: !45, line: 407, type: !219, scopeLine: 407, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!921 = !DISubprogram(name: "unary_op_common", scope: !904, file: !45, line: 424, type: !922, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!922 = !DISubroutineType(types: !923)
!923 = !{null, !924, !909}
!924 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !904, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!925 = !{!926, !927}
!926 = !DITemplateTypeParameter(name: "Parent", type: !374)
!927 = !DITemplateValueParameter(name: "Op", type: !44, value: i32 1)
!928 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op_common<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 358, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !929, templateParams: !947, identifier: "_ZTSN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE")
!929 = !{!930, !931, !939, !940, !941, !942, !943}
!930 = !DIDerivedType(tag: DW_TAG_member, name: "operation", scope: !928, file: !45, line: 421, baseType: !907, flags: DIFlagStaticMember, extraData: i32 0)
!931 = !DIDerivedType(tag: DW_TAG_member, name: "parent_", scope: !928, file: !45, line: 430, baseType: !932, size: 64, flags: DIFlagPrivate)
!932 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !933)
!933 = !DIDerivedType(tag: DW_TAG_typedef, name: "parent1_type", scope: !928, file: !45, line: 360, baseType: !934)
!934 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_remove_t<aie::vector_elem_ref<float, 8U> >", file: !912, line: 210, baseType: !935)
!935 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !936, file: !912, line: 187, baseType: !322)
!936 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_remove<aie::vector_elem_ref<float, 8U> >", file: !912, line: 185, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !937, identifier: "_ZTS22aie_dm_resource_removeIN3aie15vector_elem_refIfLj8EEEE")
!937 = !{!938}
!938 = !DITemplateTypeParameter(name: "T", type: !322)
!939 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE9type_bitsEv", scope: !928, file: !45, line: 364, type: !214, scopeLine: 364, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!940 = !DISubprogram(name: "size", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE4sizeEv", scope: !928, file: !45, line: 372, type: !214, scopeLine: 372, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!941 = !DISubprogram(name: "bits", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE4bitsEv", scope: !928, file: !45, line: 380, type: !214, scopeLine: 380, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!942 = !DISubprogram(name: "is_operation_none", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE17is_operation_noneEv", scope: !928, file: !45, line: 407, type: !219, scopeLine: 407, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!943 = !DISubprogram(name: "unary_op_common", scope: !928, file: !45, line: 424, type: !944, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!944 = !DISubroutineType(types: !945)
!945 = !{null, !946, !932}
!946 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !928, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!947 = !{!948, !949}
!948 = !DITemplateTypeParameter(name: "Parent", type: !322)
!949 = !DITemplateValueParameter(name: "Op", type: !44, value: i32 0)
!950 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op_common<aie::vector<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 358, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !951, templateParams: !969, identifier: "_ZTSN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEE")
!951 = !{!952, !953, !961, !962, !963, !964, !965}
!952 = !DIDerivedType(tag: DW_TAG_member, name: "operation", scope: !950, file: !45, line: 421, baseType: !907, flags: DIFlagStaticMember, extraData: i32 0)
!953 = !DIDerivedType(tag: DW_TAG_member, name: "parent_", scope: !950, file: !45, line: 430, baseType: !954, size: 256, flags: DIFlagPrivate)
!954 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !955)
!955 = !DIDerivedType(tag: DW_TAG_typedef, name: "parent1_type", scope: !950, file: !45, line: 360, baseType: !956)
!956 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_remove_t<aie::vector<float, 8U> >", file: !912, line: 210, baseType: !957)
!957 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !958, file: !912, line: 187, baseType: !188)
!958 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_remove<aie::vector<float, 8U> >", file: !912, line: 185, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !959, identifier: "_ZTS22aie_dm_resource_removeIN3aie6vectorIfLj8EEEE")
!959 = !{!960}
!960 = !DITemplateTypeParameter(name: "T", type: !188)
!961 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE9type_bitsEv", scope: !950, file: !45, line: 364, type: !214, scopeLine: 364, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!962 = !DISubprogram(name: "size", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE4sizeEv", scope: !950, file: !45, line: 372, type: !214, scopeLine: 372, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!963 = !DISubprogram(name: "bits", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE4bitsEv", scope: !950, file: !45, line: 380, type: !214, scopeLine: 380, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!964 = !DISubprogram(name: "is_operation_none", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE17is_operation_noneEv", scope: !950, file: !45, line: 407, type: !219, scopeLine: 407, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!965 = !DISubprogram(name: "unary_op_common", scope: !950, file: !45, line: 424, type: !966, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!966 = !DISubroutineType(types: !967)
!967 = !{null, !968, !954}
!968 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !950, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!969 = !{!970, !949}
!970 = !DITemplateTypeParameter(name: "Parent", type: !188)
!971 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op<aie::vector<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 454, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !972, templateParams: !969, identifier: "_ZTSN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEE")
!972 = !{!973, !974}
!973 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !971, baseType: !950, extraData: i32 0)
!974 = !DISubprogram(name: "operator()", linkageName: "_ZNK3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEclEv", scope: !971, file: !45, line: 454, type: !975, scopeLine: 454, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!975 = !DISubroutineType(types: !976)
!976 = !{!977, !982}
!977 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_type", scope: !971, file: !45, line: 454, baseType: !978)
!978 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_result_type_t<parent1_type, Operation::None>", scope: !8, file: !45, line: 352, baseType: !979)
!979 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !980, file: !45, line: 312, baseType: !188)
!980 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_result_helper<aie::vector<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 310, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !981, identifier: "_ZTSN3aie16op_result_helperINS_6vectorIfLj8EEELNS_9OperationE0EEE")
!981 = !{!960, !949}
!982 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !983, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!983 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !971)
!984 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 454, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !985, templateParams: !947, identifier: "_ZTSN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE")
!985 = !{!986, !987}
!986 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !984, baseType: !928, extraData: i32 0)
!987 = !DISubprogram(name: "operator()", linkageName: "_ZNK3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEclEv", scope: !984, file: !45, line: 454, type: !988, scopeLine: 454, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!988 = !DISubroutineType(types: !989)
!989 = !{!990, !995}
!990 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_type", scope: !984, file: !45, line: 454, baseType: !991)
!991 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_result_type_t<parent1_type, Operation::None>", scope: !8, file: !45, line: 352, baseType: !992)
!992 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !993, file: !45, line: 312, baseType: !322)
!993 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_result_helper<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 310, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !994, identifier: "_ZTSN3aie16op_result_helperINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE")
!994 = !{!938, !949}
!995 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !996, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!996 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !984)
!997 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>", scope: !8, file: !45, line: 459, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !998, templateParams: !925, identifier: "_ZTSN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEE")
!998 = !{!999, !1000}
!999 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !997, baseType: !904, extraData: i32 0)
!1000 = !DISubprogram(name: "operator()", linkageName: "_ZNK3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEclEv", scope: !997, file: !45, line: 459, type: !1001, scopeLine: 459, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1001 = !DISubroutineType(types: !1002)
!1002 = !{!1003, !1008}
!1003 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_type", scope: !997, file: !45, line: 459, baseType: !1004)
!1004 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_result_type_t<parent1_type, Operation::Acc_Add>", scope: !8, file: !45, line: 352, baseType: !1005)
!1005 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1006, file: !45, line: 306, baseType: !374)
!1006 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_result_helper<aie::accum<accfloat, 8U>, (aie::Operation)1>", scope: !8, file: !45, line: 304, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !1007, identifier: "_ZTSN3aie16op_result_helperINS_5accumI8accfloatLj8EEELNS_9OperationE1EEE")
!1007 = !{!916, !927}
!1008 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1009, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1009 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !997)
!1010 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "matrix_vector_mul<float, float, 128U, 768U, 0U, 0U, 0U, 1U, 12U, 1U, 0U, 0U, 1U, 0U, false, true>", scope: !87, file: !86, line: 233, size: 32, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1011, templateParams: !1044, identifier: "_ZTSN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEE")
!1011 = !{!1012, !1013, !1014, !1018, !1021, !1035, !1038, !1041}
!1012 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1010, baseType: !85, flags: DIFlagPublic, extraData: i32 0)
!1013 = !DIDerivedType(tag: DW_TAG_member, name: "matrixASize", scope: !1010, file: !86, line: 266, baseType: !101, flags: DIFlagPublic | DIFlagStaticMember, extraData: i32 8192)
!1014 = !DISubprogram(name: "matrix_vector_mul", scope: !1010, file: !86, line: 268, type: !1015, scopeLine: 268, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1015 = !DISubroutineType(types: !1016)
!1016 = !{null, !1017}
!1017 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1010, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1018 = !DISubprogram(name: "registerKernelClass", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE19registerKernelClassEv", scope: !1010, file: !86, line: 270, type: !1019, scopeLine: 270, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!1019 = !DISubroutineType(types: !1020)
!1020 = !{null}
!1021 = !DISubprogram(name: "matVecMulRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE12matVecMulRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEERNSA_IfNSB_3outESM_EE", scope: !1010, file: !86, line: 284, type: !1022, scopeLine: 284, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1022 = !DISubroutineType(types: !1023)
!1023 = !{null, !1017, !151, !1024, !1031}
!1024 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1025)
!1025 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1026, size: 32)
!1026 = !DIDerivedType(tag: DW_TAG_typedef, name: "input_buffer<float>", scope: !1028, file: !1027, line: 104, baseType: !1029)
!1027 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/io_buffer/io_buffer_types.h", directory: "")
!1028 = !DINamespace(name: "adf", scope: null)
!1029 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "io_buffer<float, adf::direction::in, adf::io_buffer_config<adf::extents<4294967295U>, adf::locking::sync, adf::addressing::linear, adf::margin<0U> > >", scope: !1028, file: !1030, line: 33, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEEE")
!1030 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/io_buffer/io_buffer_main.h", directory: "")
!1031 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1032)
!1032 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1033, size: 32)
!1033 = !DIDerivedType(tag: DW_TAG_typedef, name: "output_buffer<TT_OUT>", scope: !1028, file: !1027, line: 144, baseType: !1034)
!1034 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "io_buffer<float, adf::direction::out, adf::io_buffer_config<adf::extents<4294967295U>, adf::locking::sync, adf::addressing::linear, adf::margin<0U> > >", scope: !1028, file: !1027, line: 92, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEEE")
!1035 = !DISubprogram(name: "matVecMulFirstRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE", scope: !1010, file: !86, line: 288, type: !1036, scopeLine: 288, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1036 = !DISubroutineType(types: !1037)
!1037 = !{null, !1017, !151, !1024, !144}
!1038 = !DISubprogram(name: "matVecMulMiddleRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE", scope: !1010, file: !86, line: 292, type: !1039, scopeLine: 292, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1039 = !DISubroutineType(types: !1040)
!1040 = !{null, !1017, !151, !1024, !124, !144}
!1041 = !DISubprogram(name: "matVecMulLastRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE", scope: !1010, file: !86, line: 297, type: !1042, scopeLine: 297, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1042 = !DISubroutineType(types: !1043)
!1043 = !{null, !1017, !151, !1024, !124, !1031}
!1044 = !{!161, !162, !163, !164, !165, !166, !167, !168, !169, !170, !1045, !1046, !173, !1047, !1048, !177}
!1045 = !DITemplateValueParameter(name: "TP_API", type: !15, value: i32 0)
!1046 = !DITemplateValueParameter(name: "TP_DUAL_IP", type: !15, value: i32 0)
!1047 = !DITemplateValueParameter(name: "TP_KERNEL_POSITION", type: !15, value: i32 0)
!1048 = !DITemplateValueParameter(name: "TP_CASC_IN", type: !176, value: i1 false)
!1049 = !{!0, !1050}
!1050 = !DIGlobalVariableExpression(var: !1051, expr: !DIExpression(DW_OP_constu, 1, DW_OP_stack_value))
!1051 = distinct !DIGlobalVariable(name: "is_signed_v", scope: !7, file: !1052, line: 117, type: !198, isLocal: true, isDefinition: true, templateParams: !1053)
!1052 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/concepts.hpp", directory: "")
!1053 = !{!209}
!1054 = !{!1055, !1061, !1063, !1067, !1071, !1074, !1076, !1079, !1082, !1083, !1085, !1086, !1088, !1090, !1092, !1094, !1096, !1098, !1100, !1102, !1104, !1106, !1108, !1110, !1112, !1114, !1116, !1118, !1120, !1122, !1124, !1126, !1128, !1138, !1142, !1152, !1156, !1158, !1160, !1164, !1168, !1172, !1174, !1178, !1183, !1187, !1191, !1195, !1197, !1199, !1201, !1203, !1205, !1209, !1211, !1216, !1221, !1227, !1232, !1236, !1240, !1245, !1249, !1253, !1257, !1259, !1264, !1268, !1270, !1277, !1283, !1285, !1287, !1291, !1293, !1295, !1297, !1299, !1301, !1306, !1311, !1315, !1317, !1319, !1321, !1323, !1325, !1327, !1329, !1331, !1336, !1337, !1342, !1344, !1348, !1350, !1354, !1358, !1362, !1370, !1372, !1376, !1380, !1384, !1386, !1390, !1394, !1398, !1400, !1402, !1404, !1409, !1414, !1418, !1422, !1426, !1428, !1430, !1432, !1436, !1440, !1444, !1446, !1448, !1452, !1454, !1458, !1462, !1464, !1468, !1470, !1472, !1475, !1476}
!1055 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1058, file: !1060, line: 57)
!1056 = !DINamespace(name: "__2", scope: !1057, exportSymbols: true)
!1057 = !DINamespace(name: "std", scope: null)
!1058 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", file: !1059, line: 35, baseType: !9)
!1059 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/stddef.h", directory: "")
!1060 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstddef", directory: "")
!1061 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1062, file: !1060, line: 58)
!1062 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !1059, line: 46, baseType: !15)
!1063 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1064, file: !1060, line: 63)
!1064 = !DIDerivedType(tag: DW_TAG_typedef, name: "max_align_t", file: !1065, line: 24, baseType: !1066)
!1065 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/__stddef_max_align_t.h", directory: "")
!1066 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1065, line: 19, size: 128, flags: DIFlagFwdDecl, identifier: "_ZTS11max_align_t")
!1067 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1068, file: !1070, line: 161)
!1068 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !575, line: 24, baseType: !1069)
!1069 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!1070 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdint", directory: "")
!1071 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1072, file: !1070, line: 163)
!1072 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !575, line: 25, baseType: !1073)
!1073 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!1074 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1075, file: !1070, line: 164)
!1075 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !575, line: 26, baseType: !9)
!1076 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1077, file: !1070, line: 166)
!1077 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !575, line: 27, baseType: !1078)
!1078 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!1079 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1080, file: !1070, line: 170)
!1080 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !575, line: 29, baseType: !1081)
!1081 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!1082 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !574, file: !1070, line: 172)
!1083 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1084, file: !1070, line: 173)
!1084 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !575, line: 31, baseType: !15)
!1085 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !594, file: !1070, line: 175)
!1086 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1087, file: !1070, line: 178)
!1087 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !575, line: 35, baseType: !1069)
!1088 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1089, file: !1070, line: 179)
!1089 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !575, line: 36, baseType: !1073)
!1090 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1091, file: !1070, line: 180)
!1091 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !575, line: 37, baseType: !9)
!1092 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1093, file: !1070, line: 182)
!1093 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !575, line: 38, baseType: !1078)
!1094 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1095, file: !1070, line: 185)
!1095 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !575, line: 40, baseType: !1081)
!1096 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1097, file: !1070, line: 186)
!1097 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !575, line: 41, baseType: !576)
!1098 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1099, file: !1070, line: 187)
!1099 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !575, line: 42, baseType: !15)
!1100 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1101, file: !1070, line: 189)
!1101 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !575, line: 43, baseType: !595)
!1102 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1103, file: !1070, line: 192)
!1103 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !575, line: 46, baseType: !9)
!1104 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1105, file: !1070, line: 193)
!1105 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !575, line: 47, baseType: !9)
!1106 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1107, file: !1070, line: 194)
!1107 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !575, line: 48, baseType: !9)
!1108 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1109, file: !1070, line: 196)
!1109 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !575, line: 49, baseType: !1078)
!1110 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1111, file: !1070, line: 199)
!1111 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !575, line: 51, baseType: !15)
!1112 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1113, file: !1070, line: 200)
!1113 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !575, line: 52, baseType: !15)
!1114 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1115, file: !1070, line: 201)
!1115 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !575, line: 53, baseType: !15)
!1116 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1117, file: !1070, line: 203)
!1117 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !575, line: 54, baseType: !595)
!1118 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1119, file: !1070, line: 206)
!1119 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !575, line: 57, baseType: !9)
!1120 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1121, file: !1070, line: 207)
!1121 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !575, line: 58, baseType: !15)
!1122 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1123, file: !1070, line: 209)
!1123 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !575, line: 61, baseType: !9)
!1124 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1125, file: !1070, line: 210)
!1125 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !575, line: 62, baseType: !15)
!1126 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1062, file: !1127, line: 76)
!1127 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstring", directory: "")
!1128 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1129, file: !1127, line: 77)
!1129 = !DISubprogram(name: "memcpy", scope: !1130, file: !1130, line: 28, type: !1131, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1130 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/string.h", directory: "")
!1131 = !DISubroutineType(types: !1132)
!1132 = !{!1133, !1134, !1135, !1062}
!1133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 32)
!1134 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1133)
!1135 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1136)
!1136 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1137, size: 32)
!1137 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1138 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1139, file: !1127, line: 78)
!1139 = !DISubprogram(name: "memmove", scope: !1130, file: !1130, line: 29, type: !1140, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1140 = !DISubroutineType(types: !1141)
!1141 = !{!1133, !1133, !1136, !1062}
!1142 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1143, file: !1127, line: 79)
!1143 = !DISubprogram(name: "strcpy", scope: !1130, file: !1130, line: 30, type: !1144, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1144 = !DISubroutineType(types: !1145)
!1145 = !{!1146, !1148, !1149}
!1146 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1147, size: 32)
!1147 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!1148 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1146)
!1149 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1150)
!1150 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1151, size: 32)
!1151 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1147)
!1152 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1153, file: !1127, line: 80)
!1153 = !DISubprogram(name: "strncpy", scope: !1130, file: !1130, line: 31, type: !1154, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1154 = !DISubroutineType(types: !1155)
!1155 = !{!1146, !1148, !1149, !1062}
!1156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1157, file: !1127, line: 81)
!1157 = !DISubprogram(name: "strcat", scope: !1130, file: !1130, line: 34, type: !1144, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1158 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1159, file: !1127, line: 82)
!1159 = !DISubprogram(name: "strncat", scope: !1130, file: !1130, line: 35, type: !1154, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1160 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1161, file: !1127, line: 83)
!1161 = !DISubprogram(name: "memcmp", scope: !1130, file: !1130, line: 38, type: !1162, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1162 = !DISubroutineType(types: !1163)
!1163 = !{!9, !1136, !1136, !1062}
!1164 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1165, file: !1127, line: 84)
!1165 = !DISubprogram(name: "strcmp", scope: !1130, file: !1130, line: 39, type: !1166, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1166 = !DISubroutineType(types: !1167)
!1167 = !{!9, !1150, !1150}
!1168 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1169, file: !1127, line: 85)
!1169 = !DISubprogram(name: "strncmp", scope: !1130, file: !1130, line: 41, type: !1170, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1170 = !DISubroutineType(types: !1171)
!1171 = !{!9, !1150, !1150, !1062}
!1172 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1173, file: !1127, line: 86)
!1173 = !DISubprogram(name: "strcoll", scope: !1130, file: !1130, line: 40, type: !1166, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1174 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1175, file: !1127, line: 87)
!1175 = !DISubprogram(name: "strxfrm", scope: !1130, file: !1130, line: 42, type: !1176, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1176 = !DISubroutineType(types: !1177)
!1177 = !{!1062, !1148, !1149, !1062}
!1178 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1179, file: !1127, line: 88)
!1179 = !DISubprogram(name: "memchr", linkageName: "_Z6memchrUa9enable_ifILb1EEPvij", scope: !1180, file: !1180, line: 107, type: !1181, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1180 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/string.h", directory: "")
!1181 = !DISubroutineType(types: !1182)
!1182 = !{!1133, !1133, !9, !1062}
!1183 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1184, file: !1127, line: 89)
!1184 = !DISubprogram(name: "strchr", linkageName: "_Z6strchrUa9enable_ifILb1EEPci", scope: !1180, file: !1180, line: 86, type: !1185, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1185 = !DISubroutineType(types: !1186)
!1186 = !{!1146, !1146, !9}
!1187 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1188, file: !1127, line: 90)
!1188 = !DISubprogram(name: "strcspn", scope: !1130, file: !1130, line: 47, type: !1189, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1189 = !DISubroutineType(types: !1190)
!1190 = !{!1062, !1150, !1150}
!1191 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1192, file: !1127, line: 91)
!1192 = !DISubprogram(name: "strpbrk", linkageName: "_Z7strpbrkUa9enable_ifILb1EEPcPKc", scope: !1180, file: !1180, line: 93, type: !1193, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1193 = !DISubroutineType(types: !1194)
!1194 = !{!1146, !1146, !1150}
!1195 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1196, file: !1127, line: 92)
!1196 = !DISubprogram(name: "strrchr", linkageName: "_Z7strrchrUa9enable_ifILb1EEPci", scope: !1180, file: !1180, line: 100, type: !1185, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1197 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1198, file: !1127, line: 93)
!1198 = !DISubprogram(name: "strspn", scope: !1130, file: !1130, line: 50, type: !1189, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1199 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1200, file: !1127, line: 94)
!1200 = !DISubprogram(name: "strstr", linkageName: "_Z6strstrUa9enable_ifILb1EEPcPKc", scope: !1180, file: !1180, line: 114, type: !1193, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1201 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1202, file: !1127, line: 96)
!1202 = !DISubprogram(name: "strtok", scope: !1130, file: !1130, line: 52, type: !1144, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1203 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1204, file: !1127, line: 98)
!1204 = !DISubprogram(name: "memset", scope: !1130, file: !1130, line: 55, type: !1181, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1205 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1206, file: !1127, line: 102)
!1206 = !DISubprogram(name: "strlen", scope: !1130, file: !1130, line: 57, type: !1207, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1207 = !DISubroutineType(types: !1208)
!1208 = !{!1062, !1150}
!1209 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1062, file: !1210, line: 107)
!1210 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdlib", directory: "")
!1211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1212, file: !1210, line: 118)
!1212 = !DISubprogram(name: "atoi", scope: !1213, file: !1213, line: 38, type: !1214, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1213 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdlib.h", directory: "")
!1214 = !DISubroutineType(types: !1215)
!1215 = !{!9, !1150}
!1216 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1217, file: !1210, line: 119)
!1217 = !DISubprogram(name: "atol", scope: !1213, file: !1213, line: 43, type: !1218, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1218 = !DISubroutineType(types: !1219)
!1219 = !{!1220, !1150}
!1220 = !DIBasicType(name: "long", size: 32, encoding: DW_ATE_signed)
!1221 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1222, file: !1210, line: 128)
!1222 = !DISubprogram(name: "strtol", scope: !1213, file: !1213, line: 30, type: !1223, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1223 = !DISubroutineType(types: !1224)
!1224 = !{!1220, !1149, !1225, !9}
!1225 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1226)
!1226 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1146, size: 32)
!1227 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1228, file: !1210, line: 134)
!1228 = !DISubprogram(name: "strtoul", scope: !1213, file: !1213, line: 34, type: !1229, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1229 = !DISubroutineType(types: !1230)
!1230 = !{!1231, !1149, !1225, !9}
!1231 = !DIBasicType(name: "unsigned long", size: 32, encoding: DW_ATE_unsigned)
!1232 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1233, file: !1210, line: 140)
!1233 = !DISubprogram(name: "rand", scope: !1213, file: !1213, line: 52, type: !1234, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1234 = !DISubroutineType(types: !1235)
!1235 = !{!9}
!1236 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1237, file: !1210, line: 141)
!1237 = !DISubprogram(name: "srand", scope: !1213, file: !1213, line: 53, type: !1238, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1238 = !DISubroutineType(types: !1239)
!1239 = !{null, !15}
!1240 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1241, file: !1210, line: 142)
!1241 = !DISubprogram(name: "calloc", scope: !1242, file: !1242, line: 33, type: !1243, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1242 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/malloc.h", directory: "")
!1243 = !DISubroutineType(types: !1244)
!1244 = !{!1133, !1062, !1062}
!1245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1246, file: !1210, line: 143)
!1246 = !DISubprogram(name: "free", scope: !1242, file: !1242, line: 31, type: !1247, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1247 = !DISubroutineType(types: !1248)
!1248 = !{null, !1133}
!1249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1250, file: !1210, line: 144)
!1250 = !DISubprogram(name: "malloc", scope: !1242, file: !1242, line: 29, type: !1251, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1251 = !DISubroutineType(types: !1252)
!1252 = !{!1133, !1062}
!1253 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1254, file: !1210, line: 145)
!1254 = !DISubprogram(name: "realloc", scope: !1242, file: !1242, line: 35, type: !1255, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1255 = !DISubroutineType(types: !1256)
!1256 = !{!1133, !1133, !1062}
!1257 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1258, file: !1210, line: 146)
!1258 = !DISubprogram(name: "abort", scope: !1213, file: !1213, line: 91, type: !1019, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1259 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1260, file: !1210, line: 147)
!1260 = !DISubprogram(name: "atexit", scope: !1213, file: !1213, line: 98, type: !1261, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1261 = !DISubroutineType(types: !1262)
!1262 = !{!9, !1263}
!1263 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1019, size: 32, dwarfAddressSpace: 61)
!1264 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1265, file: !1210, line: 148)
!1265 = !DISubprogram(name: "exit", scope: !1213, file: !1213, line: 83, type: !1266, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1266 = !DISubroutineType(types: !1267)
!1267 = !{null, !9}
!1268 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1269, file: !1210, line: 149)
!1269 = !DISubprogram(name: "_Exit", scope: !1213, file: !1213, line: 96, type: !1266, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1270 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1271, file: !1210, line: 157)
!1271 = !DISubprogram(name: "qsort", scope: !1213, file: !1213, line: 104, type: !1272, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1272 = !DISubroutineType(types: !1273)
!1273 = !{null, !1133, !1062, !1062, !1274}
!1274 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1275, size: 32, dwarfAddressSpace: 61)
!1275 = !DISubroutineType(types: !1276)
!1276 = !{!9, !1136, !1136}
!1277 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1278, file: !1282, line: 351)
!1278 = !DISubprogram(name: "acosf", scope: !1279, file: !1279, line: 93, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1279 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/math.h", directory: "")
!1280 = !DISubroutineType(types: !1281)
!1281 = !{!80, !80}
!1282 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cmath", directory: "")
!1283 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1284, file: !1282, line: 353)
!1284 = !DISubprogram(name: "asinf", scope: !1279, file: !1279, line: 95, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1285 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1286, file: !1282, line: 355)
!1286 = !DISubprogram(name: "atanf", scope: !1279, file: !1279, line: 101, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1287 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1288, file: !1282, line: 357)
!1288 = !DISubprogram(name: "atan2f", scope: !1279, file: !1279, line: 98, type: !1289, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1289 = !DISubroutineType(types: !1290)
!1290 = !{!80, !80, !80}
!1291 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1292, file: !1282, line: 359)
!1292 = !DISubprogram(name: "ceilf", scope: !1279, file: !1279, line: 68, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1293 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1294, file: !1282, line: 361)
!1294 = !DISubprogram(name: "cosf", scope: !1279, file: !1279, line: 74, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1295 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1296, file: !1282, line: 368)
!1296 = !DISubprogram(name: "expf", scope: !1279, file: !1279, line: 78, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1297 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1298, file: !1282, line: 371)
!1298 = !DISubprogram(name: "fabsf", scope: !1279, file: !1279, line: 31, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1299 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1300, file: !1282, line: 373)
!1300 = !DISubprogram(name: "floorf", scope: !1279, file: !1279, line: 70, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1301 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1302, file: !1282, line: 375)
!1302 = !DISubprogram(name: "fmod", scope: !1279, file: !1279, line: 92, type: !1303, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1303 = !DISubroutineType(types: !1304)
!1304 = !{!1305, !1305, !1305}
!1305 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!1306 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1307, file: !1282, line: 381)
!1307 = !DISubprogram(name: "frexpf", scope: !1279, file: !1279, line: 108, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1308 = !DISubroutineType(types: !1309)
!1309 = !{!80, !80, !1310}
!1310 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 32)
!1311 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1312, file: !1282, line: 383)
!1312 = !DISubprogram(name: "ldexpf", scope: !1279, file: !1279, line: 66, type: !1313, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1313 = !DISubroutineType(types: !1314)
!1314 = !{!80, !80, !9}
!1315 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1316, file: !1282, line: 386)
!1316 = !DISubprogram(name: "logf", scope: !1279, file: !1279, line: 80, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1317 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1318, file: !1282, line: 389)
!1318 = !DISubprogram(name: "log10f", scope: !1279, file: !1279, line: 82, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1319 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1320, file: !1282, line: 396)
!1320 = !DISubprogram(name: "powf", scope: !1279, file: !1279, line: 90, type: !1289, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1321 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1322, file: !1282, line: 399)
!1322 = !DISubprogram(name: "sinf", scope: !1279, file: !1279, line: 76, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1323 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1324, file: !1282, line: 406)
!1324 = !DISubprogram(name: "sqrtf", scope: !1279, file: !1279, line: 85, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1325 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1326, file: !1282, line: 427)
!1326 = !DISubprogram(name: "copysignf", scope: !1279, file: !1279, line: 36, type: !1289, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1327 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1328, file: !1282, line: 484)
!1328 = !DISubprogram(name: "roundf", scope: !1279, file: !1279, line: 72, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1329 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1330, file: !1282, line: 494)
!1330 = !DISubprogram(name: "truncf", scope: !1279, file: !1279, line: 104, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1331 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1332, file: !1335, line: 115)
!1332 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !1333, line: 31, baseType: !1334)
!1333 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdio.h", directory: "")
!1334 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "FILE", file: !1333, line: 30, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS4FILE")
!1335 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdio", directory: "")
!1336 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1062, file: !1335, line: 119)
!1337 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1338, file: !1335, line: 121)
!1338 = !DISubprogram(name: "fclose", scope: !1333, file: !1333, line: 78, type: !1339, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1339 = !DISubroutineType(types: !1340)
!1340 = !{!9, !1341}
!1341 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1332, size: 32)
!1342 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1343, file: !1335, line: 122)
!1343 = !DISubprogram(name: "fflush", scope: !1333, file: !1333, line: 79, type: !1339, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1344 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1345, file: !1335, line: 127)
!1345 = !DISubprogram(name: "fprintf", scope: !1333, file: !1333, line: 88, type: !1346, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1346 = !DISubroutineType(types: !1347)
!1347 = !{!9, !1341, !1150, null}
!1348 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1349, file: !1335, line: 128)
!1349 = !DISubprogram(name: "fscanf", scope: !1333, file: !1333, line: 93, type: !1346, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1350 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1351, file: !1335, line: 129)
!1351 = !DISubprogram(name: "snprintf", scope: !1333, file: !1333, line: 97, type: !1352, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1352 = !DISubroutineType(types: !1353)
!1353 = !{!9, !1146, !1062, !1150, null}
!1354 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1355, file: !1335, line: 130)
!1355 = !DISubprogram(name: "sprintf", scope: !1333, file: !1333, line: 96, type: !1356, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1356 = !DISubroutineType(types: !1357)
!1357 = !{!9, !1146, !1150, null}
!1358 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1359, file: !1335, line: 131)
!1359 = !DISubprogram(name: "sscanf", scope: !1333, file: !1333, line: 101, type: !1360, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1360 = !DISubroutineType(types: !1361)
!1361 = !{!9, !1150, !1150, null}
!1362 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1363, file: !1335, line: 132)
!1363 = !DISubprogram(name: "vfprintf", scope: !1333, file: !1333, line: 86, type: !1364, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1364 = !DISubroutineType(types: !1365)
!1365 = !{!9, !1341, !1150, !1366}
!1366 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1367, line: 22, baseType: !1368)
!1367 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/stdarg.h", directory: "")
!1368 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1369, baseType: !1146)
!1369 = !DIFile(filename: "i11_wrap_matrix_vector_mul.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir")
!1370 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1371, file: !1335, line: 133)
!1371 = !DISubprogram(name: "vfscanf", scope: !1333, file: !1333, line: 91, type: !1364, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1372 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1373, file: !1335, line: 134)
!1373 = !DISubprogram(name: "vsscanf", scope: !1333, file: !1333, line: 102, type: !1374, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1374 = !DISubroutineType(types: !1375)
!1375 = !{!9, !1150, !1150, !1366}
!1376 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1377, file: !1335, line: 135)
!1377 = !DISubprogram(name: "vsnprintf", scope: !1333, file: !1333, line: 99, type: !1378, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1378 = !DISubroutineType(types: !1379)
!1379 = !{!9, !1146, !1062, !1150, !1366}
!1380 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1381, file: !1335, line: 136)
!1381 = !DISubprogram(name: "vsprintf", scope: !1333, file: !1333, line: 98, type: !1382, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1382 = !DISubroutineType(types: !1383)
!1383 = !{!9, !1146, !1150, !1366}
!1384 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1385, file: !1335, line: 137)
!1385 = !DISubprogram(name: "fgetc", scope: !1333, file: !1333, line: 113, type: !1339, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1386 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1387, file: !1335, line: 138)
!1387 = !DISubprogram(name: "fgets", scope: !1333, file: !1333, line: 116, type: !1388, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1388 = !DISubroutineType(types: !1389)
!1389 = !{!1146, !1146, !9, !1341}
!1390 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1391, file: !1335, line: 139)
!1391 = !DISubprogram(name: "fputc", scope: !1333, file: !1333, line: 107, type: !1392, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1392 = !DISubroutineType(types: !1393)
!1393 = !{!9, !9, !1341}
!1394 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1395, file: !1335, line: 140)
!1395 = !DISubprogram(name: "fputs", scope: !1333, file: !1333, line: 110, type: !1396, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1396 = !DISubroutineType(types: !1397)
!1397 = !{!9, !1150, !1341}
!1398 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1399, file: !1335, line: 141)
!1399 = !DISubprogram(name: "getc", scope: !1333, file: !1333, line: 187, type: !1339, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1400 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1401, file: !1335, line: 142)
!1401 = !DISubprogram(name: "putc", scope: !1333, file: !1333, line: 169, type: !1392, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1402 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1403, file: !1335, line: 143)
!1403 = !DISubprogram(name: "ungetc", scope: !1333, file: !1333, line: 119, type: !1392, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1404 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1405, file: !1335, line: 144)
!1405 = !DISubprogram(name: "fread", scope: !1333, file: !1333, line: 126, type: !1406, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1406 = !DISubroutineType(types: !1407)
!1407 = !{!1062, !1408, !1062, !1062, !1341}
!1408 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 32, dwarfAddressSpace: 12)
!1409 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1410, file: !1335, line: 145)
!1410 = !DISubprogram(name: "fwrite", scope: !1333, file: !1333, line: 124, type: !1411, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1411 = !DISubroutineType(types: !1412)
!1412 = !{!1062, !1413, !1062, !1062, !1341}
!1413 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1137, size: 32, dwarfAddressSpace: 12)
!1414 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1415, file: !1335, line: 149)
!1415 = !DISubprogram(name: "fseek", scope: !1333, file: !1333, line: 139, type: !1416, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1416 = !DISubroutineType(types: !1417)
!1417 = !{!9, !1341, !1220, !9}
!1418 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1419, file: !1335, line: 153)
!1419 = !DISubprogram(name: "ftell", scope: !1333, file: !1333, line: 141, type: !1420, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1420 = !DISubroutineType(types: !1421)
!1421 = !{!1220, !1341}
!1422 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1423, file: !1335, line: 154)
!1423 = !DISubprogram(name: "rewind", scope: !1333, file: !1333, line: 164, type: !1424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1424 = !DISubroutineType(types: !1425)
!1425 = !{null, !1341}
!1426 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1427, file: !1335, line: 155)
!1427 = !DISubprogram(name: "clearerr", scope: !1333, file: !1333, line: 148, type: !1424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1428 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1429, file: !1335, line: 156)
!1429 = !DISubprogram(name: "feof", scope: !1333, file: !1333, line: 146, type: !1339, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1430 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1431, file: !1335, line: 157)
!1431 = !DISubprogram(name: "ferror", scope: !1333, file: !1333, line: 147, type: !1339, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1432 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1433, file: !1335, line: 158)
!1433 = !DISubprogram(name: "perror", scope: !1333, file: !1333, line: 149, type: !1434, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1434 = !DISubroutineType(types: !1435)
!1435 = !{null, !1150}
!1436 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1437, file: !1335, line: 161)
!1437 = !DISubprogram(name: "fopen", scope: !1333, file: !1333, line: 77, type: !1438, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1438 = !DISubroutineType(types: !1439)
!1439 = !{!1341, !1150, !1150}
!1440 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1441, file: !1335, line: 162)
!1441 = !DISubprogram(name: "freopen", scope: !1333, file: !1333, line: 81, type: !1442, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1442 = !DISubroutineType(types: !1443)
!1443 = !{!1341, !1150, !1150, !1341}
!1444 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1445, file: !1335, line: 163)
!1445 = !DISubprogram(name: "remove", scope: !1333, file: !1333, line: 67, type: !1214, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1446 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1447, file: !1335, line: 164)
!1447 = !DISubprogram(name: "rename", scope: !1333, file: !1333, line: 68, type: !1166, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1448 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1449, file: !1335, line: 165)
!1449 = !DISubprogram(name: "tmpfile", scope: !1333, file: !1333, line: 69, type: !1450, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1450 = !DISubroutineType(types: !1451)
!1451 = !{!1341}
!1452 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1453, file: !1335, line: 172)
!1453 = !DISubprogram(name: "getchar", scope: !1333, file: !1333, line: 192, type: !1234, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1454 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1455, file: !1335, line: 176)
!1455 = !DISubprogram(name: "scanf", scope: !1333, file: !1333, line: 94, type: !1456, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1456 = !DISubroutineType(types: !1457)
!1457 = !{!9, !1150, null}
!1458 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1459, file: !1335, line: 177)
!1459 = !DISubprogram(name: "vscanf", scope: !1333, file: !1333, line: 159, type: !1460, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1460 = !DISubroutineType(types: !1461)
!1461 = !{!9, !1150, !1366}
!1462 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1463, file: !1335, line: 181)
!1463 = !DISubprogram(name: "printf", scope: !1333, file: !1333, line: 89, type: !1456, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1464 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1465, file: !1335, line: 182)
!1465 = !DISubprogram(name: "putchar", scope: !1333, file: !1333, line: 174, type: !1466, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1466 = !DISubroutineType(types: !1467)
!1467 = !{!9, !9}
!1468 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1469, file: !1335, line: 183)
!1469 = !DISubprogram(name: "puts", scope: !1333, file: !1333, line: 179, type: !1214, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1470 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1056, entity: !1471, file: !1335, line: 184)
!1471 = !DISubprogram(name: "vprintf", scope: !1333, file: !1333, line: 154, type: !1460, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1472 = !DIImportedEntity(tag: DW_TAG_imported_declaration, name: "Utils", scope: !8, entity: !1473, file: !1474, line: 89)
!1473 = !DINamespace(name: "utils", scope: !7)
!1474 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/adf/../aie.hpp", directory: "")
!1475 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !5, file: !1474, line: 6158)
!1476 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !2, entity: !1028, file: !1477, line: 32)
!1477 = !DIFile(filename: "dsp_lib/L1/include/aie/fir_utils.hpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!1478 = !{!"crF2FMask"}
!1479 = !{!"crFPMask"}
!1480 = !{!"MCD"}
!1481 = !{i32 0, i8 undef}
!1482 = !{i32 2, i8 undef}
!1483 = !{i32 3, i8 undef}
!1484 = !{i32 4, i8 undef}
!1485 = !{i32 5, i8 undef}
!1486 = !{i32 6, i8 undef}
!1487 = !{i32 7, i8 undef}
!1488 = !{i32 8, i8 undef}
!1489 = !{i32 9, i8 undef}
!1490 = !{i32 10, i8 undef}
!1491 = !{i32 11, i8 undef}
!1492 = !{i32 12, i8 undef}
!1493 = !{i32 13, i8 undef}
!1494 = !{i32 14, i8 undef}
!1495 = !{i32 7, !"Dwarf Version", i32 4}
!1496 = !{i32 2, !"Debug Info Version", i32 3}
!1497 = !{i32 1, !"wchar_size", i32 4}
!1498 = !{i32 7, !"frame-pointer", i32 2}
!1499 = !{!"clang version 16.0.3 (/u/sgasip/ipd/repositories/llvm_ipd 6a0b186d7c0e25173296a8e19f630e71bd7e8ed9)"}
!1500 = distinct !DISubprogram(name: "matVecMulFirstRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE", scope: !1010, file: !83, line: 612, type: !1036, scopeLine: 614, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1035, retainedNodes: !1501)
!1501 = !{!1502, !1504, !1505, !1506, !1507, !1508}
!1502 = !DILocalVariable(name: "this", arg: 1, scope: !1500, type: !1503, flags: DIFlagArtificial | DIFlagObjectPointer)
!1503 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1010, size: 32)
!1504 = !DILocalVariable(name: "inMatrixA", arg: 2, scope: !1500, file: !86, line: 288, type: !151)
!1505 = !DILocalVariable(name: "inWindowB", arg: 3, scope: !1500, file: !86, line: 289, type: !1024)
!1506 = !DILocalVariable(name: "outCascade", arg: 4, scope: !1500, file: !86, line: 290, type: !144)
!1507 = !DILocalVariable(name: "inInterface", scope: !1500, file: !83, line: 615, type: !112)
!1508 = !DILocalVariable(name: "outInterface", scope: !1500, file: !83, line: 616, type: !129)
!1509 = !{!1510}
!1510 = distinct !{!1510, !1511, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE: unknown scope"}
!1511 = distinct !{!1511, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE"}
!1512 = !{!1513, !1513, i64 0, i64 4}
!1513 = !{!1514, i64 4, !"any pointer"}
!1514 = !{!1515, i64 1, !"omnipotent char"}
!1515 = !{!"Simple C++ TBAA"}
!1516 = !{!1517, !1518, !1519, !1510}
!1517 = distinct !{!1517, !1511, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE: inWindowB"}
!1518 = distinct !{!1518, !1511, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE: inInterface"}
!1519 = distinct !{!1519, !1511, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE: outInterface"}
!1520 = !DILocation(line: 0, scope: !1500)
!1521 = !DILocation(line: 288, column: 46, scope: !1500)
!1522 = !{!1517}
!1523 = !DILocation(line: 289, column: 64, scope: !1500)
!1524 = !DILocation(line: 290, column: 78, scope: !1500)
!1525 = !DILocation(line: 615, column: 5, scope: !1500)
!1526 = !DILocation(line: 615, column: 37, scope: !1500)
!1527 = !{!1518}
!1528 = !DILocation(line: 616, column: 5, scope: !1500)
!1529 = !DILocation(line: 616, column: 38, scope: !1500)
!1530 = !{!1519}
!1531 = !DILocation(line: 617, column: 29, scope: !1500)
!1532 = !DILocation(line: 617, column: 39, scope: !1500)
!1533 = !DILocation(line: 617, column: 17, scope: !1500)
!1534 = !DILocation(line: 617, column: 27, scope: !1500)
!1535 = !{!1536, !1513, i64 4, i64 4}
!1536 = !{!1514, i64 20, !"_ZTSN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEE", !1513, i64 0, i64 4, !1513, i64 4, i64 4, !1513, i64 8, i64 4, !1513, i64 12, i64 4, !1513, i64 16, i64 4}
!1537 = !DILocation(line: 618, column: 31, scope: !1500)
!1538 = !DILocation(line: 618, column: 18, scope: !1500)
!1539 = !DILocation(line: 618, column: 29, scope: !1500)
!1540 = !{!1541, !1513, i64 12, i64 4}
!1541 = !{!1514, i64 16, !"_ZTSN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEE", !1513, i64 0, i64 4, !1513, i64 4, i64 4, !1513, i64 8, i64 4, !1513, i64 12, i64 4}
!1542 = !DILocation(line: 619, column: 39, scope: !1500)
!1543 = !DILocation(line: 619, column: 11, scope: !1500)
!1544 = !DILocation(line: 619, column: 25, scope: !1500)
!1545 = !{!1546, !1513, i64 0, i64 4}
!1546 = !{!1514, i64 4, !"_ZTSN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEE", !1513, i64 0, i64 4}
!1547 = !{i64 20, i64 0, i64 4, i64 4}
!1548 = !DILocation(line: 620, column: 27, scope: !1500)
!1549 = !{!1536, !1536, i64 0, i64 20}
!1550 = !{i64 16, i64 0, i64 4, i64 3}
!1551 = !DILocation(line: 620, column: 40, scope: !1500)
!1552 = !{!1541, !1541, i64 0, i64 16}
!1553 = !DILocation(line: 620, column: 11, scope: !1500)
!1554 = !DILocation(line: 621, column: 1, scope: !1500)
!1555 = distinct !DISubprogram(name: "T_inputIF", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev", scope: !112, file: !113, line: 305, type: !1556, scopeLine: 305, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1559, retainedNodes: !1560)
!1556 = !DISubroutineType(types: !1557)
!1557 = !{null, !1558}
!1558 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1559 = !DISubprogram(name: "T_inputIF", scope: !112, type: !1556, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1560 = !{!1561}
!1561 = !DILocalVariable(name: "this", arg: 1, scope: !1555, type: !1562, flags: DIFlagArtificial | DIFlagObjectPointer)
!1562 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 32)
!1563 = !DILocation(line: 0, scope: !1555)
!1564 = !DILocation(line: 310, column: 42, scope: !1555)
!1565 = !{!1536, !1513, i64 16, i64 4}
!1566 = !DILocation(line: 305, column: 8, scope: !1555)
!1567 = distinct !DISubprogram(name: "T_outputIF", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev", scope: !129, file: !113, line: 314, type: !1568, scopeLine: 314, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1571, retainedNodes: !1572)
!1568 = !DISubroutineType(types: !1569)
!1569 = !{null, !1570}
!1570 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1571 = !DISubprogram(name: "T_outputIF", scope: !129, type: !1568, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1572 = !{!1573}
!1573 = !DILocalVariable(name: "this", arg: 1, scope: !1567, type: !1574, flags: DIFlagArtificial | DIFlagObjectPointer)
!1574 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 32)
!1575 = !DILocation(line: 0, scope: !1567)
!1576 = !DILocation(line: 318, column: 43, scope: !1567)
!1577 = !DILocation(line: 314, column: 8, scope: !1567)
!1578 = distinct !DISubprogram(name: "data", linkageName: "_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv", scope: !1029, file: !1030, line: 122, type: !1579, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1586, retainedNodes: !1587)
!1579 = !DISubroutineType(types: !1580)
!1580 = !{!1581, !1584}
!1581 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1582)
!1582 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1583, size: 32)
!1583 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !1029, file: !1030, line: 47, baseType: !80, flags: DIFlagPublic)
!1584 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1585, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1585 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1029)
!1586 = !DISubprogram(name: "data", linkageName: "_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv", scope: !1029, file: !1030, line: 122, type: !1579, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1587 = !{!1588}
!1588 = !DILocalVariable(name: "this", arg: 1, scope: !1578, type: !1589, flags: DIFlagArtificial | DIFlagObjectPointer)
!1589 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1585, size: 32)
!1590 = !{!1591}
!1591 = distinct !{!1591, !1592, !"_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv: unknown scope"}
!1592 = distinct !{!1592, !"_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv"}
!1593 = !DILocation(line: 0, scope: !1578)
!1594 = !DILocation(line: 125, column: 26, scope: !1595)
!1595 = distinct !DILexicalBlock(scope: !1578, file: !1030, line: 124, column: 23)
!1596 = !{!1597, !1513, i64 0, i64 4}
!1597 = !{!1514, i64 4, !"_ZTSN3adf6detail14io_buffer_baseIfNS_7locking4syncEEE", !1513, i64 0, i64 4}
!1598 = !DILocation(line: 125, column: 13, scope: !1595)
!1599 = distinct !DISubprogram(name: "matVecMulKernel", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !83, line: 78, type: !109, scopeLine: 79, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !159, retainedNodes: !1600)
!1600 = !{!1601, !1602, !1603}
!1601 = !DILocalVariable(name: "this", arg: 1, scope: !1599, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!1602 = !DILocalVariable(name: "inInterface", arg: 2, scope: !1599, file: !86, line: 140, type: !112)
!1603 = !DILocalVariable(name: "outInterface", arg: 3, scope: !1599, file: !86, line: 140, type: !129)
!1604 = !{!1605}
!1605 = distinct !{!1605, !1606, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: unknown scope"}
!1606 = distinct !{!1606, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE"}
!1607 = !{!1608, !1605}
!1608 = distinct !{!1608, !1606, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outInterface"}
!1609 = !DILocation(line: 0, scope: !1599)
!1610 = !DILocation(line: 140, column: 58, scope: !1599)
!1611 = !{!1608}
!1612 = !DILocation(line: 140, column: 104, scope: !1599)
!1613 = !DILocation(line: 81, column: 25, scope: !1599)
!1614 = !DILocation(line: 81, column: 38, scope: !1599)
!1615 = !DILocation(line: 81, column: 5, scope: !1599)
!1616 = !DILocation(line: 82, column: 1, scope: !1599)
!1617 = distinct !DISubprogram(name: "__cxx_global_var_init", scope: !1369, file: !1369, type: !1019, flags: DIFlagArtificial | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!1618 = !DILocation(line: 7, column: 126, scope: !1617)
!1619 = distinct !DISubprogram(name: "matrix_vector_mul", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEC2Ev", scope: !1010, file: !86, line: 268, type: !1015, scopeLine: 268, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1014, retainedNodes: !1620)
!1620 = !{!1621}
!1621 = !DILocalVariable(name: "this", arg: 1, scope: !1619, type: !1503, flags: DIFlagArtificial | DIFlagObjectPointer)
!1622 = !DILocation(line: 0, scope: !1619)
!1623 = !DILocation(line: 268, column: 5, scope: !1619)
!1624 = !DILocation(line: 268, column: 25, scope: !1619)
!1625 = distinct !DISubprogram(name: "i11_user", linkageName: "_Z8i11_userv", scope: !1369, file: !1369, line: 8, type: !1626, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!1626 = !DISubroutineType(types: !1627)
!1627 = !{!1133}
!1628 = !DILocation(line: 8, column: 19, scope: !1625)
!1629 = distinct !DISubprogram(name: "matVecMulSelectArch", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !83, line: 117, type: !109, scopeLine: 118, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !108, retainedNodes: !1630)
!1630 = !{!1631, !1632, !1633}
!1631 = !DILocalVariable(name: "this", arg: 1, scope: !1629, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!1632 = !DILocalVariable(name: "inInterface", arg: 2, scope: !1629, file: !86, line: 123, type: !112)
!1633 = !DILocalVariable(name: "outInterface", arg: 3, scope: !1629, file: !86, line: 124, type: !129)
!1634 = !{!1635}
!1635 = distinct !{!1635, !1636, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: unknown scope"}
!1636 = distinct !{!1636, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE"}
!1637 = !{!1638, !1635}
!1638 = distinct !{!1638, !1636, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outInterface"}
!1639 = !DILocation(line: 0, scope: !1629)
!1640 = !DILocation(line: 123, column: 62, scope: !1629)
!1641 = !{!1638}
!1642 = !DILocation(line: 124, column: 63, scope: !1629)
!1643 = !DILocation(line: 120, column: 49, scope: !1644)
!1644 = distinct !DILexicalBlock(scope: !1645, file: !83, line: 120, column: 32)
!1645 = distinct !DILexicalBlock(scope: !1629, file: !83, line: 120, column: 19)
!1646 = !DILocation(line: 120, column: 62, scope: !1644)
!1647 = !DILocation(line: 120, column: 34, scope: !1644)
!1648 = !DILocation(line: 124, column: 1, scope: !1629)
!1649 = !{!1650}
!1650 = distinct !{!1650, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: unknown scope"}
!1651 = distinct !{!1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE"}
!1652 = !{!1653, !1654, !1655, !1656, !1650, !1657, !1658, !1659, !1660, !1661}
!1653 = distinct !{!1653, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outInterface"}
!1654 = distinct !{!1654, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inPtrA"}
!1655 = distinct !{!1655, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inPtrB"}
!1656 = distinct !{!1656, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inMatrixBuff"}
!1657 = distinct !{!1657, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inMatrixPtrRtp"}
!1658 = distinct !{!1658, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: matrixPtr"}
!1659 = distinct !{!1659, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: matrixStartPtr"}
!1660 = distinct !{!1660, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: vectorStartPtr"}
!1661 = distinct !{!1661, !1651, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outPtr"}
!1662 = !DILocation(line: 0, scope: !84)
!1663 = !DILocation(line: 126, column: 57, scope: !84)
!1664 = !{!1653}
!1665 = !DILocation(line: 126, column: 103, scope: !84)
!1666 = !DILocation(line: 167, column: 5, scope: !84)
!1667 = !DILocation(line: 168, column: 5, scope: !84)
!1668 = !DILocation(line: 170, column: 5, scope: !84)
!1669 = !DILocation(line: 170, column: 13, scope: !84)
!1670 = !{!1671, !1671, i64 0, i64 32}
!1671 = !{!1514, i64 32, !"_ZTSN3aie6vectorIfLj8EEE", !1672, i64 0, i64 32}
!1672 = !{!1514, i64 32, !"_ZTSN3aie6detail11vector_baseIfLj8EEE", !1673, i64 0, i64 32}
!1673 = !{!1514, i64 32, !"v64int4"}
!1674 = !DILocation(line: 171, column: 5, scope: !84)
!1675 = !DILocation(line: 171, column: 25, scope: !84)
!1676 = !{!1654}
!1677 = !DILocation(line: 172, column: 5, scope: !84)
!1678 = !DILocation(line: 172, column: 13, scope: !84)
!1679 = !DILocation(line: 173, column: 5, scope: !84)
!1680 = !DILocation(line: 173, column: 25, scope: !84)
!1681 = !{!1655}
!1682 = !DILocation(line: 175, column: 5, scope: !84)
!1683 = !DILocation(line: 175, column: 15, scope: !84)
!1684 = !{!1685, !1685, i64 0, i64 32}
!1685 = !{!1514, i64 32, !"_ZTSN3aie5accumI8accfloatLj8EEE", !1686, i64 0, i64 32}
!1686 = !{!1514, i64 32, !"_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEE", !1687, i64 0, i64 32}
!1687 = !{!1514, i64 32, !"v8acc32"}
!1688 = !DILocation(line: 176, column: 5, scope: !84)
!1689 = !DILocation(line: 176, column: 15, scope: !84)
!1690 = !DILocation(line: 176, column: 27, scope: !84)
!1691 = !DILocation(line: 177, column: 5, scope: !84)
!1692 = !DILocation(line: 177, column: 15, scope: !84)
!1693 = !DILocation(line: 180, column: 5, scope: !84)
!1694 = !DILocation(line: 180, column: 27, scope: !84)
!1695 = !{!1656}
!1696 = !DILocation(line: 180, column: 66, scope: !84)
!1697 = !{!1536, !1513, i64 0, i64 4}
!1698 = !DILocation(line: 181, column: 5, scope: !84)
!1699 = !DILocation(line: 181, column: 27, scope: !84)
!1700 = !{!1657}
!1701 = !DILocation(line: 181, column: 44, scope: !84)
!1702 = !DILocation(line: 182, column: 5, scope: !84)
!1703 = !DILocation(line: 182, column: 27, scope: !84)
!1704 = !{!1658}
!1705 = !DILocation(line: 182, column: 69, scope: !84)
!1706 = !DILocation(line: 184, column: 5, scope: !84)
!1707 = !DILocation(line: 184, column: 25, scope: !84)
!1708 = !{!1659}
!1709 = !DILocation(line: 184, column: 53, scope: !84)
!1710 = !DILocation(line: 185, column: 5, scope: !84)
!1711 = !DILocation(line: 185, column: 25, scope: !84)
!1712 = !{!1660}
!1713 = !DILocation(line: 185, column: 64, scope: !84)
!1714 = !DILocation(line: 186, column: 5, scope: !84)
!1715 = !DILocation(line: 186, column: 27, scope: !84)
!1716 = !{!1661}
!1717 = !DILocation(line: 186, column: 61, scope: !84)
!1718 = !{!1541, !1513, i64 0, i64 4}
!1719 = !DILocation(line: 189, column: 10, scope: !473)
!1720 = !DILocation(line: 189, column: 14, scope: !473)
!1721 = !{!1722, !1722, i64 0, i64 4}
!1722 = !{!1514, i64 4, !"int"}
!1723 = !DILocation(line: 189, column: 25, scope: !477)
!1724 = !DILocation(line: 189, column: 31, scope: !477)
!1725 = !DILocation(line: 189, column: 5, scope: !473)
!1726 = !DILocation(line: 189, column: 5, scope: !477)
!1727 = !DILocation(line: 191, column: 14, scope: !475)
!1728 = !DILocation(line: 191, column: 18, scope: !475)
!1729 = !DILocation(line: 191, column: 27, scope: !481)
!1730 = !DILocation(line: 191, column: 31, scope: !481)
!1731 = !DILocation(line: 191, column: 9, scope: !475)
!1732 = distinct !{!1732, !1731, !1733, !1734, !1735, !1736, !1737, !1738}
!1733 = !DILocation(line: 227, column: 13, scope: !475)
!1734 = !{!"llvm.loop.mustprogress"}
!1735 = !{!"llvm.loop.chess.prepare_for_pipelining"}
!1736 = !{!"llvm.loop.chess.min_loop_count", i32 16}
!1737 = !{!"llvm.loop.chess.max_loop_count", i32 16}
!1738 = !{!"llvm.loop.disable_llvm_transforms"}
!1739 = !DILocation(line: 191, column: 9, scope: !481)
!1740 = !DILocation(line: 192, column: 27, scope: !480)
!1741 = !DILocation(line: 192, column: 46, scope: !480)
!1742 = !DILocation(line: 192, column: 52, scope: !480)
!1743 = !DILocation(line: 192, column: 43, scope: !480)
!1744 = !DILocation(line: 192, column: 73, scope: !480)
!1745 = !DILocation(line: 192, column: 70, scope: !480)
!1746 = !DILocation(line: 192, column: 24, scope: !480)
!1747 = !DILocation(line: 193, column: 27, scope: !480)
!1748 = !DILocation(line: 193, column: 46, scope: !480)
!1749 = !DILocation(line: 193, column: 52, scope: !480)
!1750 = !DILocation(line: 193, column: 43, scope: !480)
!1751 = !DILocation(line: 193, column: 24, scope: !480)
!1752 = !DILocation(line: 200, column: 27, scope: !1753)
!1753 = distinct !DILexicalBlock(scope: !1754, file: !83, line: 199, column: 22)
!1754 = distinct !DILexicalBlock(scope: !480, file: !83, line: 196, column: 31)
!1755 = !DILocation(line: 200, column: 25, scope: !1753)
!1756 = !DILocation(line: 202, column: 22, scope: !479)
!1757 = !DILocation(line: 202, column: 26, scope: !479)
!1758 = !DILocation(line: 202, column: 38, scope: !485)
!1759 = !DILocation(line: 202, column: 45, scope: !485)
!1760 = !DILocation(line: 202, column: 17, scope: !479)
!1761 = !DILocation(line: 202, column: 17, scope: !485)
!1762 = !DILocation(line: 203, column: 36, scope: !484)
!1763 = !DILocation(line: 203, column: 27, scope: !484)
!1764 = !DILocation(line: 205, column: 26, scope: !483)
!1765 = !DILocation(line: 205, column: 30, scope: !483)
!1766 = !DILocation(line: 205, column: 39, scope: !1767)
!1767 = distinct !DILexicalBlock(scope: !483, file: !83, line: 205, column: 21)
!1768 = !DILocation(line: 205, column: 43, scope: !1767)
!1769 = !DILocation(line: 205, column: 21, scope: !483)
!1770 = !DILocation(line: 205, column: 21, scope: !1767)
!1771 = !DILocation(line: 206, column: 34, scope: !1772)
!1772 = distinct !DILexicalBlock(scope: !1767, file: !83, line: 205, column: 67)
!1773 = !DILocation(line: 206, column: 31, scope: !1772)
!1774 = !DILocation(line: 207, column: 32, scope: !1772)
!1775 = !DILocation(line: 211, column: 57, scope: !1776)
!1776 = distinct !DILexicalBlock(scope: !1777, file: !83, line: 210, column: 30)
!1777 = distinct !DILexicalBlock(scope: !1772, file: !83, line: 209, column: 39)
!1778 = !DILocation(line: 211, column: 51, scope: !1776)
!1779 = !DILocation(line: 211, column: 35, scope: !1776)
!1780 = !{!1781, !1781, i64 0, i64 8}
!1781 = !{!1514, i64 8, !"_ZTSN3aie15vector_elem_refIfLj8EEE", !1513, i64 0, i64 4, !1722, i64 4, i64 4}
!1782 = !DILocation(line: 211, column: 33, scope: !1776)
!1783 = !DILocation(line: 213, column: 21, scope: !1772)
!1784 = !DILocation(line: 205, column: 63, scope: !1767)
!1785 = distinct !{!1785, !1769, !1786, !1734, !1787}
!1786 = !DILocation(line: 213, column: 21, scope: !483)
!1787 = !{!"llvm.loop.unroll.count", i32 8}
!1788 = !DILocation(line: 214, column: 17, scope: !484)
!1789 = !DILocation(line: 202, column: 70, scope: !485)
!1790 = distinct !{!1790, !1760, !1791, !1734}
!1791 = !DILocation(line: 214, column: 17, scope: !479)
!1792 = !DILocation(line: 225, column: 44, scope: !1793)
!1793 = distinct !DILexicalBlock(scope: !1794, file: !83, line: 224, column: 22)
!1794 = distinct !DILexicalBlock(scope: !480, file: !83, line: 217, column: 31)
!1795 = !DILocation(line: 225, column: 21, scope: !1793)
!1796 = !DILocation(line: 227, column: 13, scope: !480)
!1797 = !DILocation(line: 191, column: 50, scope: !481)
!1798 = !DILocation(line: 228, column: 5, scope: !476)
!1799 = !DILocation(line: 189, column: 53, scope: !477)
!1800 = distinct !{!1800, !1725, !1801, !1734}
!1801 = !DILocation(line: 228, column: 5, scope: !473)
!1802 = !DILocation(line: 229, column: 1, scope: !84)
!1803 = distinct !DISubprogram(name: "set_rnd_mode<0U>", linkageName: "_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv", scope: !89, file: !1804, line: 42, type: !1019, scopeLine: 42, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1805, retainedNodes: !137)
!1804 = !DIFile(filename: "dsp_lib/L1/include/aie/kernel_api_utils.hpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!1805 = !{!1806}
!1806 = !DITemplateValueParameter(name: "rndMode", type: !15, value: i32 0)
!1807 = !DILocation(line: 45, column: 43, scope: !1808)
!1808 = distinct !DILexicalBlock(scope: !1809, file: !1804, line: 45, column: 41)
!1809 = distinct !DILexicalBlock(scope: !1803, file: !1804, line: 45, column: 19)
!1810 = !DILocation(line: 76, column: 1, scope: !1803)
!1811 = distinct !DISubprogram(name: "set_sat_mode<0U>", linkageName: "_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv", scope: !89, file: !1804, line: 80, type: !1019, scopeLine: 80, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1812, retainedNodes: !137)
!1812 = !{!1813}
!1813 = !DITemplateValueParameter(name: "satMode", type: !15, value: i32 0)
!1814 = !DILocation(line: 83, column: 35, scope: !1815)
!1815 = distinct !DILexicalBlock(scope: !1816, file: !1804, line: 83, column: 33)
!1816 = distinct !DILexicalBlock(scope: !1811, file: !1804, line: 83, column: 19)
!1817 = !DILocation(line: 93, column: 1, scope: !1811)
!1818 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj8EEC2Ev", scope: !188, file: !189, line: 148, type: !276, scopeLine: 150, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !275, retainedNodes: !1819)
!1819 = !{!1820}
!1820 = !DILocalVariable(name: "this", arg: 1, scope: !1818, type: !1821, flags: DIFlagArtificial | DIFlagObjectPointer)
!1821 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !188, size: 32)
!1822 = !DILocation(line: 0, scope: !1818)
!1823 = !DILocation(line: 149, column: 9, scope: !1818)
!1824 = !DILocation(line: 151, column: 5, scope: !1818)
!1825 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj8EEC2Ev", scope: !374, file: !375, line: 163, type: !442, scopeLine: 163, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !441, retainedNodes: !1826)
!1826 = !{!1827}
!1827 = !DILocalVariable(name: "this", arg: 1, scope: !1825, type: !1828, flags: DIFlagArtificial | DIFlagObjectPointer)
!1828 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !374, size: 32)
!1829 = !DILocation(line: 0, scope: !1825)
!1830 = !DILocation(line: 163, column: 5, scope: !1825)
!1831 = !DILocation(line: 163, column: 21, scope: !1825)
!1832 = distinct !DISubprogram(name: "zeros<float, 8U>", linkageName: "_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv", scope: !8, file: !1474, line: 1084, type: !1833, scopeLine: 1085, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !208, retainedNodes: !137)
!1833 = !DISubroutineType(types: !1834)
!1834 = !{!188}
!1835 = !DILocation(line: 1086, column: 12, scope: !1832)
!1836 = !DILocation(line: 1086, column: 5, scope: !1832)
!1837 = distinct !DISubprogram(name: "accum<float>", linkageName: "_ZN3aie5accumI8accfloatLj8EEC2IfEERKNS_6vectorIT_Lj8EEEi", scope: !374, file: !375, line: 205, type: !1838, scopeLine: 206, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1053, declaration: !1841, retainedNodes: !1842)
!1838 = !DISubroutineType(types: !1839)
!1839 = !{null, !427, !1840, !9}
!1840 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !292, size: 32)
!1841 = !DISubprogram(name: "accum<float>", scope: !374, file: !375, line: 205, type: !1838, scopeLine: 205, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1053)
!1842 = !{!1843, !1844, !1845}
!1843 = !DILocalVariable(name: "this", arg: 1, scope: !1837, type: !1828, flags: DIFlagArtificial | DIFlagObjectPointer)
!1844 = !DILocalVariable(name: "v", arg: 2, scope: !1837, file: !375, line: 205, type: !1840)
!1845 = !DILocalVariable(name: "shift", arg: 3, scope: !1837, file: !375, line: 205, type: !9)
!1846 = !DILocation(line: 0, scope: !1837)
!1847 = !DILocation(line: 205, column: 44, scope: !1837)
!1848 = !DILocation(line: 205, column: 51, scope: !1837)
!1849 = !DILocation(line: 205, column: 14, scope: !1837)
!1850 = !DILocation(line: 207, column: 27, scope: !1851)
!1851 = distinct !DILexicalBlock(scope: !1837, file: !375, line: 206, column: 5)
!1852 = !DILocation(line: 207, column: 30, scope: !1851)
!1853 = !DILocation(line: 207, column: 15, scope: !1851)
!1854 = !DILocation(line: 208, column: 5, scope: !1837)
!1855 = distinct !DISubprogram(name: "mac<aie::accum<accfloat, 8U>, aie::vector_elem_ref<float, 8U>, aie::vector<float, 8U> >", linkageName: "_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_", scope: !8, file: !1474, line: 4866, type: !1856, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1865, retainedNodes: !1861)
!1856 = !DISubroutineType(types: !1857)
!1857 = !{!1858, !447, !322, !1840}
!1858 = !DIDerivedType(tag: DW_TAG_typedef, name: "operand_base_type_t<aie::accum<accfloat, 8U> >", scope: !8, file: !1052, line: 410, baseType: !1859)
!1859 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1860, file: !1474, line: 94, baseType: !911)
!1860 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "operand_base_type<aie::accum<accfloat, 8U> >", scope: !8, file: !1474, line: 92, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !915, identifier: "_ZTSN3aie17operand_base_typeINS_5accumI8accfloatLj8EEEEE")
!1861 = !{!1862, !1863, !1864}
!1862 = !DILocalVariable(name: "acc", arg: 1, scope: !1855, file: !1474, line: 4866, type: !447)
!1863 = !DILocalVariable(name: "a", arg: 2, scope: !1855, file: !1474, line: 4866, type: !322)
!1864 = !DILocalVariable(name: "v", arg: 3, scope: !1855, file: !1474, line: 4866, type: !1840)
!1865 = !{!1866, !1867, !1868}
!1866 = !DITemplateTypeParameter(name: "Acc", type: !374)
!1867 = !DITemplateTypeParameter(name: "E", type: !322)
!1868 = !DITemplateTypeParameter(name: "Vec", type: !188)
!1869 = !DILocation(line: 4866, column: 31, scope: !1855)
!1870 = !DILocation(line: 4866, column: 38, scope: !1855)
!1871 = !DILocation(line: 4866, column: 52, scope: !1855)
!1872 = !DILocation(line: 4869, column: 20, scope: !1873)
!1873 = distinct !DILexicalBlock(scope: !1874, file: !1474, line: 4868, column: 39)
!1874 = distinct !DILexicalBlock(scope: !1855, file: !1474, line: 4868, column: 24)
!1875 = !DILocation(line: 4869, column: 27, scope: !1873)
!1876 = !DILocation(line: 4869, column: 33, scope: !1873)
!1877 = !DILocation(line: 4869, column: 36, scope: !1873)
!1878 = !DILocation(line: 4869, column: 16, scope: !1873)
!1879 = !DILocation(line: 4869, column: 9, scope: !1873)
!1880 = distinct !DISubprogram(name: "operator[]", linkageName: "_ZN3aie6vectorIfLj8EEixEj", scope: !188, file: !189, line: 303, type: !364, scopeLine: 304, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !363, retainedNodes: !1881)
!1881 = !{!1882, !1883}
!1882 = !DILocalVariable(name: "this", arg: 1, scope: !1880, type: !1821, flags: DIFlagArtificial | DIFlagObjectPointer)
!1883 = !DILocalVariable(name: "idx", arg: 2, scope: !1880, file: !189, line: 303, type: !15)
!1884 = !DILocation(line: 0, scope: !1880)
!1885 = !DILocation(line: 303, column: 83, scope: !1880)
!1886 = !DILocation(line: 305, column: 9, scope: !1880)
!1887 = !DILocation(line: 305, column: 9, scope: !1888)
!1888 = distinct !DILexicalBlock(scope: !1889, file: !189, line: 305, column: 9)
!1889 = distinct !DILexicalBlock(scope: !1880, file: !189, line: 305, column: 9)
!1890 = !DILocation(line: 305, column: 9, scope: !1889)
!1891 = !DILocation(line: 305, column: 9, scope: !1892)
!1892 = distinct !DILexicalBlock(scope: !1888, file: !189, line: 305, column: 9)
!1893 = !DILocation(line: 305, column: 9, scope: !1894)
!1894 = distinct !DILexicalBlock(scope: !1895, file: !189, line: 305, column: 9)
!1895 = distinct !DILexicalBlock(scope: !1892, file: !189, line: 305, column: 9)
!1896 = !DILocation(line: 305, column: 9, scope: !1895)
!1897 = !{!"idx needs to be a valid element index"}
!1898 = !DILocation(line: 305, column: 9, scope: !1899)
!1899 = distinct !DILexicalBlock(scope: !1888, file: !189, line: 305, column: 9)
!1900 = !DILocation(line: 306, column: 25, scope: !1880)
!1901 = !DILocation(line: 306, column: 16, scope: !1880)
!1902 = !DILocation(line: 306, column: 9, scope: !1880)
!1903 = distinct !DISubprogram(name: "writeincr<accfloat, 8U>", linkageName: "_Z9writeincrI8accfloatLj8EEvP14output_cascadeIT_vERKN3aie5accumIS2_XT0_EEE", scope: !1904, file: !1904, line: 696, type: !1905, scopeLine: 696, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1910, retainedNodes: !1907)
!1904 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/adf/stream.hpp", directory: "")
!1905 = !DISubroutineType(types: !1906)
!1906 = !{null, !144, !447}
!1907 = !{!1908, !1909}
!1908 = !DILocalVariable(name: "w", arg: 1, scope: !1903, file: !1904, line: 696, type: !144)
!1909 = !DILocalVariable(name: "value", arg: 2, scope: !1903, file: !1904, line: 696, type: !447)
!1910 = !{!1911, !353}
!1911 = !DITemplateTypeParameter(name: "T", type: !459)
!1912 = !DILocation(line: 696, column: 48, scope: !1903)
!1913 = !DILocation(line: 696, column: 76, scope: !1903)
!1914 = !DILocation(line: 696, column: 162, scope: !1903)
!1915 = !DILocation(line: 696, column: 165, scope: !1903)
!1916 = !DILocation(line: 696, column: 104, scope: !1903)
!1917 = !DILocation(line: 696, column: 175, scope: !1903)
!1918 = distinct !DISubprogram(name: "set_rounding", linkageName: "_ZN3aieL12set_roundingENS_13rounding_modeE", scope: !8, file: !1474, line: 7750, type: !1919, scopeLine: 7751, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1921)
!1919 = !DISubroutineType(types: !1920)
!1920 = !{null, !13}
!1921 = !{!1922}
!1922 = !DILocalVariable(name: "m", arg: 1, scope: !1918, file: !1474, line: 7750, type: !13)
!1923 = !{!1924, !1924, i64 0, i64 4}
!1924 = !{!1514, i64 4, !"_ZTSN3aie13rounding_modeE"}
!1925 = !DILocation(line: 7750, column: 47, scope: !1918)
!1926 = !DILocation(line: 7752, column: 5, scope: !1918)
!1927 = !DILocation(line: 7752, column: 39, scope: !1918)
!1928 = !DILocation(line: 7752, column: 26, scope: !1918)
!1929 = !DILocation(line: 7753, column: 1, scope: !1918)
!1930 = distinct !DISubprogram(name: "current", linkageName: "_ZN3aie4tile7currentEv", scope: !611, file: !612, line: 46, type: !632, scopeLine: 46, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !631, retainedNodes: !137)
!1931 = !DILocation(line: 46, column: 36, scope: !1930)
!1932 = !DILocation(line: 46, column: 29, scope: !1930)
!1933 = distinct !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie4tile12set_roundingENS_13rounding_modeE", scope: !611, file: !612, line: 58, type: !641, scopeLine: 58, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !640, retainedNodes: !1934)
!1934 = !{!1935, !1937}
!1935 = !DILocalVariable(name: "this", arg: 1, scope: !1933, type: !1936, flags: DIFlagArtificial | DIFlagObjectPointer)
!1936 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !611, size: 32)
!1937 = !DILocalVariable(name: "mode", arg: 2, scope: !1933, file: !612, line: 58, type: !13)
!1938 = !DILocation(line: 0, scope: !1933)
!1939 = !DILocation(line: 58, column: 37, scope: !1933)
!1940 = !DILocation(line: 58, column: 69, scope: !1933)
!1941 = !DILocation(line: 58, column: 56, scope: !1933)
!1942 = !DILocation(line: 59, column: 5, scope: !1933)
!1943 = distinct !DISubprogram(name: "current", linkageName: "_ZN3aie6detail4tile7currentEv", scope: !569, file: !570, line: 64, type: !597, scopeLine: 65, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !596, retainedNodes: !137)
!1944 = !DILocation(line: 66, column: 16, scope: !1943)
!1945 = !DILocation(line: 66, column: 9, scope: !1943)
!1946 = distinct !DISubprogram(name: "tile", linkageName: "_ZN3aie4tileC2ERKNS_6detail4tileE", scope: !611, file: !612, line: 30, type: !616, scopeLine: 30, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !615, retainedNodes: !1947)
!1947 = !{!1948, !1949}
!1948 = !DILocalVariable(name: "this", arg: 1, scope: !1946, type: !1936, flags: DIFlagArtificial | DIFlagObjectPointer)
!1949 = !DILocalVariable(name: "t", arg: 2, scope: !1946, file: !612, line: 30, type: !619)
!1950 = !DILocation(line: 0, scope: !1946)
!1951 = !DILocation(line: 30, column: 27, scope: !1946)
!1952 = !DILocation(line: 30, column: 45, scope: !1946)
!1953 = !DILocation(line: 30, column: 49, scope: !1946)
!1954 = distinct !DISubprogram(name: "tile", linkageName: "_ZN3aie6detail4tileC2Ev", scope: !569, file: !570, line: 36, type: !578, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !577, retainedNodes: !1955)
!1955 = !{!1956}
!1956 = !DILocalVariable(name: "this", arg: 1, scope: !1954, type: !1957, flags: DIFlagArtificial | DIFlagObjectPointer)
!1957 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !569, size: 32)
!1958 = !DILocation(line: 0, scope: !1954)
!1959 = !DILocation(line: 36, column: 23, scope: !1954)
!1960 = distinct !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE", scope: !569, file: !570, line: 82, type: !606, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !605, retainedNodes: !1961)
!1961 = !{!1962, !1963}
!1962 = !DILocalVariable(name: "this", arg: 1, scope: !1960, type: !1957, flags: DIFlagArtificial | DIFlagObjectPointer)
!1963 = !DILocalVariable(name: "mode", arg: 2, scope: !1960, file: !570, line: 82, type: !13)
!1964 = !DILocation(line: 0, scope: !1960)
!1965 = !DILocation(line: 82, column: 37, scope: !1960)
!1966 = !DILocation(line: 84, column: 29, scope: !1960)
!1967 = !DILocation(line: 84, column: 9, scope: !1960)
!1968 = !DILocation(line: 85, column: 5, scope: !1960)
!1969 = distinct !DISubprogram(name: "set_saturation", linkageName: "_ZN3aieL14set_saturationENS_15saturation_modeE", scope: !8, file: !1474, line: 7715, type: !1970, scopeLine: 7716, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1972)
!1970 = !DISubroutineType(types: !1971)
!1971 = !{null, !27}
!1972 = !{!1973}
!1973 = !DILocalVariable(name: "m", arg: 1, scope: !1969, file: !1474, line: 7715, type: !27)
!1974 = !{!1975, !1975, i64 0, i64 4}
!1975 = !{!1514, i64 4, !"_ZTSN3aie15saturation_modeE"}
!1976 = !DILocation(line: 7715, column: 51, scope: !1969)
!1977 = !DILocation(line: 7717, column: 5, scope: !1969)
!1978 = !DILocation(line: 7717, column: 41, scope: !1969)
!1979 = !DILocation(line: 7717, column: 26, scope: !1969)
!1980 = !DILocation(line: 7718, column: 1, scope: !1969)
!1981 = distinct !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie4tile14set_saturationENS_15saturation_modeE", scope: !611, file: !612, line: 50, type: !635, scopeLine: 50, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !634, retainedNodes: !1982)
!1982 = !{!1983, !1984}
!1983 = !DILocalVariable(name: "this", arg: 1, scope: !1981, type: !1936, flags: DIFlagArtificial | DIFlagObjectPointer)
!1984 = !DILocalVariable(name: "mode", arg: 2, scope: !1981, file: !612, line: 50, type: !27)
!1985 = !DILocation(line: 0, scope: !1981)
!1986 = !DILocation(line: 50, column: 41, scope: !1981)
!1987 = !DILocation(line: 50, column: 75, scope: !1981)
!1988 = !DILocation(line: 50, column: 60, scope: !1981)
!1989 = !DILocation(line: 50, column: 82, scope: !1981)
!1990 = distinct !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE", scope: !569, file: !570, line: 70, type: !600, scopeLine: 71, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !599, retainedNodes: !1991)
!1991 = !{!1992, !1993}
!1992 = !DILocalVariable(name: "this", arg: 1, scope: !1990, type: !1957, flags: DIFlagArtificial | DIFlagObjectPointer)
!1993 = !DILocalVariable(name: "mode", arg: 2, scope: !1990, file: !570, line: 70, type: !27)
!1994 = !DILocation(line: 0, scope: !1990)
!1995 = !DILocation(line: 70, column: 41, scope: !1990)
!1996 = !DILocation(line: 72, column: 33, scope: !1990)
!1997 = !DILocation(line: 72, column: 9, scope: !1990)
!1998 = !DILocation(line: 73, column: 5, scope: !1990)
!1999 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj8EEC2Ev", scope: !192, file: !193, line: 402, type: !226, scopeLine: 404, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !225, retainedNodes: !2000)
!2000 = !{!2001}
!2001 = !DILocalVariable(name: "this", arg: 1, scope: !1999, type: !2002, flags: DIFlagArtificial | DIFlagObjectPointer)
!2002 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 32)
!2003 = !DILocation(line: 0, scope: !1999)
!2004 = !DILocation(line: 403, column: 9, scope: !1999)
!2005 = !DILocation(line: 403, column: 14, scope: !1999)
!2006 = !DILocation(line: 405, column: 5, scope: !1999)
!2007 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj8EE5undefEv", scope: !203, file: !201, line: 298, type: !206, scopeLine: 298, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !205, retainedNodes: !137)
!2008 = !DILocation(line: 298, column: 138, scope: !2007)
!2009 = !DILocation(line: 298, column: 131, scope: !2007)
!2010 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv", scope: !388, file: !386, line: 166, type: !391, scopeLine: 166, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !390, retainedNodes: !137)
!2011 = !DILocation(line: 166, column: 147, scope: !2010)
!2012 = !DILocation(line: 166, column: 140, scope: !2010)
!2013 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv", scope: !2015, file: !2014, line: 88, type: !2018, scopeLine: 89, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2017, retainedNodes: !137)
!2014 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/../broadcast.hpp", directory: "")
!2015 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "zeros_bits<32U, float, 8U>", scope: !7, file: !2014, line: 83, size: 8, flags: DIFlagTypePassByValue, elements: !2016, templateParams: !2021, identifier: "_ZTSN3aie6detail10zeros_bitsILj32EfLj8EEE")
!2016 = !{!2017}
!2017 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv", scope: !2015, file: !2014, line: 88, type: !2018, scopeLine: 88, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2018 = !DISubroutineType(types: !2019)
!2019 = !{!2020}
!2020 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2015, file: !2014, line: 85, baseType: !188)
!2021 = !{!2022, !209, !210}
!2022 = !DITemplateValueParameter(name: "TypeBits", type: !15, value: i32 32)
!2023 = !DILocation(line: 111, column: 20, scope: !2024)
!2024 = distinct !DILexicalBlock(scope: !2013, file: !2014, line: 108, column: 23)
!2025 = !DILocation(line: 111, column: 13, scope: !2024)
!2026 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv", scope: !2028, file: !2027, line: 292, type: !2031, scopeLine: 293, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2030, retainedNodes: !2034)
!2027 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/broadcast.hpp", directory: "")
!2028 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "zeros_bits_impl<32U, float, 8U>", scope: !7, file: !2027, line: 287, size: 8, flags: DIFlagTypePassByValue, elements: !2029, templateParams: !2021, identifier: "_ZTSN3aie6detail15zeros_bits_implILj32EfLj8EEE")
!2029 = !{!2030}
!2030 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv", scope: !2028, file: !2027, line: 292, type: !2031, scopeLine: 292, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2031 = !DISubroutineType(types: !2032)
!2032 = !{!2033}
!2033 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2028, file: !2027, line: 289, baseType: !188)
!2034 = !{!2035, !2036}
!2035 = !DILocalVariable(name: "native_zeros_elems", scope: !2026, file: !2027, line: 294, type: !101)
!2036 = !DILocalVariable(name: "ret", scope: !2026, file: !2027, line: 297, type: !2033)
!2037 = !DILocation(line: 294, column: 9, scope: !2026)
!2038 = !DILocation(line: 294, column: 28, scope: !2026)
!2039 = !DILocation(line: 297, column: 21, scope: !2026)
!2040 = !DILocation(line: 300, column: 19, scope: !2041)
!2041 = distinct !DILexicalBlock(scope: !2042, file: !2027, line: 299, column: 49)
!2042 = distinct !DILexicalBlock(scope: !2026, file: !2027, line: 299, column: 23)
!2043 = !DILocation(line: 300, column: 53, scope: !2041)
!2044 = !DILocation(line: 300, column: 17, scope: !2041)
!2045 = !DILocation(line: 300, column: 13, scope: !2041)
!2046 = !DILocation(line: 326, column: 5, scope: !2026)
!2047 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv", scope: !2048, file: !2027, line: 292, type: !2051, scopeLine: 293, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2050, retainedNodes: !2055)
!2048 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "zeros_bits_impl<32U, float, 16U>", scope: !7, file: !2027, line: 287, size: 8, flags: DIFlagTypePassByValue, elements: !2049, templateParams: !2054, identifier: "_ZTSN3aie6detail15zeros_bits_implILj32EfLj16EEE")
!2049 = !{!2050}
!2050 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv", scope: !2048, file: !2027, line: 292, type: !2051, scopeLine: 292, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2051 = !DISubroutineType(types: !2052)
!2052 = !{!2053}
!2053 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2048, file: !2027, line: 289, baseType: !740)
!2054 = !{!2022, !209, !509}
!2055 = !{!2056, !2057}
!2056 = !DILocalVariable(name: "native_zeros_elems", scope: !2047, file: !2027, line: 294, type: !101)
!2057 = !DILocalVariable(name: "ret", scope: !2047, file: !2027, line: 297, type: !2053)
!2058 = !DILocation(line: 294, column: 9, scope: !2047)
!2059 = !DILocation(line: 294, column: 28, scope: !2047)
!2060 = !DILocation(line: 297, column: 21, scope: !2047)
!2061 = !{!2062, !2062, i64 0, i64 64}
!2062 = !{!1514, i64 64, !"_ZTSN3aie6vectorIfLj16EEE", !2063, i64 0, i64 64}
!2063 = !{!1514, i64 64, !"_ZTSN3aie6detail11vector_baseIfLj16EEE", !2064, i64 0, i64 64}
!2064 = !{!1514, i64 64, !"v128int4"}
!2065 = !DILocation(line: 311, column: 23, scope: !2066)
!2066 = distinct !DILexicalBlock(scope: !2067, file: !2027, line: 310, column: 32)
!2067 = distinct !DILexicalBlock(scope: !2068, file: !2027, line: 308, column: 27)
!2068 = distinct !DILexicalBlock(scope: !2069, file: !2027, line: 304, column: 27)
!2069 = distinct !DILexicalBlock(scope: !2070, file: !2027, line: 302, column: 41)
!2070 = distinct !DILexicalBlock(scope: !2071, file: !2027, line: 302, column: 28)
!2071 = distinct !DILexicalBlock(scope: !2047, file: !2027, line: 299, column: 23)
!2072 = !{!2064, !2064, i64 0, i64 64}
!2073 = !DILocation(line: 311, column: 21, scope: !2066)
!2074 = !DILocation(line: 326, column: 5, scope: !2047)
!2075 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj", scope: !740, file: !189, line: 427, type: !2076, scopeLine: 428, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2079, declaration: !2078, retainedNodes: !2081)
!2076 = !DISubroutineType(types: !2077)
!2077 = !{!188, !831, !15}
!2078 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj", scope: !740, file: !189, line: 427, type: !2076, scopeLine: 427, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2079)
!2079 = !{!2080}
!2080 = !DITemplateValueParameter(name: "ElemsOut", type: !15, value: i32 8)
!2081 = !{!2082, !2084}
!2082 = !DILocalVariable(name: "this", arg: 1, scope: !2075, type: !2083, flags: DIFlagArtificial | DIFlagObjectPointer)
!2083 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !832, size: 32)
!2084 = !DILocalVariable(name: "idx", arg: 2, scope: !2075, file: !189, line: 427, type: !15)
!2085 = !DILocation(line: 0, scope: !2075)
!2086 = !DILocation(line: 427, column: 51, scope: !2075)
!2087 = !DILocation(line: 429, column: 16, scope: !2075)
!2088 = !DILocation(line: 429, column: 54, scope: !2075)
!2089 = !DILocation(line: 429, column: 36, scope: !2075)
!2090 = !DILocation(line: 429, column: 9, scope: !2075)
!2091 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj16EEC2Ev", scope: !740, file: !189, line: 148, type: !816, scopeLine: 150, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !815, retainedNodes: !2092)
!2092 = !{!2093}
!2093 = !DILocalVariable(name: "this", arg: 1, scope: !2091, type: !2094, flags: DIFlagArtificial | DIFlagObjectPointer)
!2094 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !740, size: 32)
!2095 = !DILocation(line: 0, scope: !2091)
!2096 = !DILocation(line: 149, column: 9, scope: !2091)
!2097 = !DILocation(line: 151, column: 5, scope: !2091)
!2098 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj16EEC2E8v16float", scope: !740, file: !189, line: 159, type: !819, scopeLine: 161, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !818, retainedNodes: !2099)
!2099 = !{!2100, !2101}
!2100 = !DILocalVariable(name: "this", arg: 1, scope: !2098, type: !2094, flags: DIFlagArtificial | DIFlagObjectPointer)
!2101 = !DILocalVariable(name: "v", arg: 2, scope: !2098, file: !189, line: 159, type: !821)
!2102 = !DILocation(line: 0, scope: !2098)
!2103 = !DILocation(line: 159, column: 22, scope: !2098)
!2104 = !DILocation(line: 160, column: 9, scope: !2098)
!2105 = !DILocation(line: 163, column: 5, scope: !2098)
!2106 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj16EE5undefEv", scope: !751, file: !201, line: 299, type: !754, scopeLine: 299, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !753, retainedNodes: !137)
!2107 = !DILocation(line: 299, column: 138, scope: !2106)
!2108 = !DILocation(line: 299, column: 131, scope: !2106)
!2109 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj", scope: !743, file: !193, line: 867, type: !2110, scopeLine: 868, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2079, declaration: !2112, retainedNodes: !2113)
!2110 = !DISubroutineType(types: !2111)
!2111 = !{!192, !793, !15}
!2112 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj", scope: !743, file: !193, line: 867, type: !2110, scopeLine: 867, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2079)
!2113 = !{!2114, !2116}
!2114 = !DILocalVariable(name: "this", arg: 1, scope: !2109, type: !2115, flags: DIFlagArtificial | DIFlagObjectPointer)
!2115 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !794, size: 32)
!2116 = !DILocalVariable(name: "idx", arg: 2, scope: !2109, file: !193, line: 867, type: !15)
!2117 = !DILocation(line: 0, scope: !2109)
!2118 = !DILocation(line: 867, column: 47, scope: !2109)
!2119 = !DILocation(line: 869, column: 9, scope: !2109)
!2120 = !DILocation(line: 869, column: 9, scope: !2121)
!2121 = distinct !DILexicalBlock(scope: !2122, file: !193, line: 869, column: 9)
!2122 = distinct !DILexicalBlock(scope: !2109, file: !193, line: 869, column: 9)
!2123 = !DILocation(line: 869, column: 9, scope: !2122)
!2124 = !DILocation(line: 869, column: 9, scope: !2125)
!2125 = distinct !DILexicalBlock(scope: !2121, file: !193, line: 869, column: 9)
!2126 = !DILocation(line: 869, column: 9, scope: !2127)
!2127 = distinct !DILexicalBlock(scope: !2128, file: !193, line: 869, column: 9)
!2128 = distinct !DILexicalBlock(scope: !2125, file: !193, line: 869, column: 9)
!2129 = !DILocation(line: 869, column: 9, scope: !2128)
!2130 = !{!"idx needs to be a valid subvector index"}
!2131 = !DILocation(line: 869, column: 9, scope: !2132)
!2132 = distinct !DILexicalBlock(scope: !2121, file: !193, line: 869, column: 9)
!2133 = !DILocation(line: 871, column: 41, scope: !2109)
!2134 = !DILocation(line: 871, column: 16, scope: !2109)
!2135 = !DILocation(line: 871, column: 9, scope: !2109)
!2136 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE", scope: !188, file: !189, line: 87, type: !260, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !259, retainedNodes: !2137)
!2137 = !{!2138, !2139}
!2138 = !DILocalVariable(name: "this", arg: 1, scope: !2136, type: !1821, flags: DIFlagArtificial | DIFlagObjectPointer)
!2139 = !DILocalVariable(name: "v", arg: 2, scope: !2136, file: !189, line: 87, type: !263)
!2140 = !DILocation(line: 0, scope: !2136)
!2141 = !DILocation(line: 87, column: 29, scope: !2136)
!2142 = !DILocation(line: 87, column: 44, scope: !2136)
!2143 = !DILocation(line: 87, column: 34, scope: !2136)
!2144 = !{!1672, !1672, i64 0, i64 32}
!2145 = !DILocation(line: 87, column: 48, scope: !2136)
!2146 = distinct !DISubprogram(name: "extract_helper<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj", scope: !743, file: !193, line: 1280, type: !2110, scopeLine: 1281, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2148, declaration: !2147, retainedNodes: !2149)
!2147 = !DISubprogram(name: "extract_helper<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj", scope: !743, file: !193, line: 1280, type: !2110, scopeLine: 1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2148)
!2148 = !{!353}
!2149 = !{!2150, !2151, !2152}
!2150 = !DILocalVariable(name: "this", arg: 1, scope: !2146, type: !2115, flags: DIFlagArtificial | DIFlagObjectPointer)
!2151 = !DILocalVariable(name: "idx", arg: 2, scope: !2146, file: !193, line: 1280, type: !15)
!2152 = !DILocalVariable(name: "output_bits", scope: !2146, file: !193, line: 1282, type: !101)
!2153 = !DILocation(line: 0, scope: !2146)
!2154 = !DILocation(line: 1280, column: 56, scope: !2146)
!2155 = !DILocation(line: 1282, column: 9, scope: !2146)
!2156 = !DILocation(line: 1282, column: 28, scope: !2146)
!2157 = !DILocation(line: 1315, column: 46, scope: !2158)
!2158 = distinct !DILexicalBlock(scope: !2159, file: !193, line: 1314, column: 51)
!2159 = distinct !DILexicalBlock(scope: !2160, file: !193, line: 1314, column: 31)
!2160 = distinct !DILexicalBlock(scope: !2161, file: !193, line: 1313, column: 47)
!2161 = distinct !DILexicalBlock(scope: !2162, file: !193, line: 1313, column: 32)
!2162 = distinct !DILexicalBlock(scope: !2163, file: !193, line: 1291, column: 27)
!2163 = distinct !DILexicalBlock(scope: !2164, file: !193, line: 1290, column: 14)
!2164 = distinct !DILexicalBlock(scope: !2146, file: !193, line: 1287, column: 23)
!2165 = !DILocation(line: 1315, column: 52, scope: !2158)
!2166 = !DILocation(line: 1315, column: 28, scope: !2158)
!2167 = !{!1673, !1673, i64 0, i64 32}
!2168 = !DILocation(line: 1328, column: 5, scope: !2146)
!2169 = distinct !DISubprogram(name: "vector_extract<8U, v16float>", linkageName: "_ZN3aie6detailL14vector_extractILj8E8v16floatEEDaRKT0_j", scope: !7, file: !193, line: 99, type: !2170, scopeLine: 99, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2177, retainedNodes: !2174)
!2170 = !DISubroutineType(types: !2171)
!2171 = !{!211, !2172, !15}
!2172 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2173, size: 32)
!2173 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !486)
!2174 = !{!2175, !2176}
!2175 = !DILocalVariable(name: "v", arg: 1, scope: !2169, file: !193, line: 99, type: !2172)
!2176 = !DILocalVariable(name: "idx", arg: 2, scope: !2169, file: !193, line: 99, type: !15)
!2177 = !{!210, !2178}
!2178 = !DITemplateTypeParameter(name: "T", type: !487)
!2179 = !DILocation(line: 99, column: 70, scope: !2169)
!2180 = !DILocation(line: 99, column: 82, scope: !2169)
!2181 = !DILocation(line: 99, column: 114, scope: !2169)
!2182 = !DILocation(line: 99, column: 117, scope: !2169)
!2183 = !DILocation(line: 99, column: 96, scope: !2169)
!2184 = !DILocation(line: 99, column: 89, scope: !2169)
!2185 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float", scope: !192, file: !193, line: 408, type: !230, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !229, retainedNodes: !2186)
!2186 = !{!2187, !2188}
!2187 = !DILocalVariable(name: "this", arg: 1, scope: !2185, type: !2002, flags: DIFlagArtificial | DIFlagObjectPointer)
!2188 = !DILocalVariable(name: "data", arg: 2, scope: !2185, file: !193, line: 408, type: !232)
!2189 = !DILocation(line: 0, scope: !2185)
!2190 = !DILocation(line: 408, column: 27, scope: !2185)
!2191 = !DILocation(line: 409, column: 9, scope: !2185)
!2192 = !DILocation(line: 409, column: 14, scope: !2185)
!2193 = !DILocation(line: 412, column: 5, scope: !2185)
!2194 = distinct !DISubprogram(name: "from_vector<float>", linkageName: "_ZN3aie5accumI8accfloatLj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi", scope: !374, file: !375, line: 474, type: !1838, scopeLine: 475, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1053, declaration: !2195, retainedNodes: !2196)
!2195 = !DISubprogram(name: "from_vector<float>", linkageName: "_ZN3aie5accumI8accfloatLj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi", scope: !374, file: !375, line: 474, type: !1838, scopeLine: 474, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1053)
!2196 = !{!2197, !2198, !2199}
!2197 = !DILocalVariable(name: "this", arg: 1, scope: !2194, type: !1828, flags: DIFlagArtificial | DIFlagObjectPointer)
!2198 = !DILocalVariable(name: "v", arg: 2, scope: !2194, file: !375, line: 474, type: !1840)
!2199 = !DILocalVariable(name: "shift", arg: 3, scope: !2194, file: !375, line: 474, type: !9)
!2200 = !DILocation(line: 0, scope: !2194)
!2201 = !DILocation(line: 474, column: 46, scope: !2194)
!2202 = !DILocation(line: 474, column: 53, scope: !2194)
!2203 = !DILocation(line: 476, column: 32, scope: !2194)
!2204 = !DILocation(line: 476, column: 35, scope: !2194)
!2205 = !DILocation(line: 476, column: 20, scope: !2194)
!2206 = !DILocation(line: 477, column: 5, scope: !2194)
!2207 = distinct !DISubprogram(name: "from_vector<float>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi", scope: !378, file: !379, line: 683, type: !2208, scopeLine: 684, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1053, declaration: !2210, retainedNodes: !2211)
!2208 = !DISubroutineType(types: !2209)
!2209 = !{null, !413, !1840, !9}
!2210 = !DISubprogram(name: "from_vector<float>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE11from_vectorIfEEvRKNS_6vectorIT_Lj8EEEi", scope: !378, file: !379, line: 683, type: !2208, scopeLine: 683, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1053)
!2211 = !{!2212, !2214, !2215}
!2212 = !DILocalVariable(name: "this", arg: 1, scope: !2207, type: !2213, flags: DIFlagArtificial | DIFlagObjectPointer)
!2213 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !378, size: 32)
!2214 = !DILocalVariable(name: "v", arg: 2, scope: !2207, file: !379, line: 683, type: !1840)
!2215 = !DILocalVariable(name: "shift", arg: 3, scope: !2207, file: !379, line: 683, type: !9)
!2216 = !DILocation(line: 0, scope: !2207)
!2217 = !DILocation(line: 683, column: 46, scope: !2207)
!2218 = !DILocation(line: 683, column: 53, scope: !2207)
!2219 = !DILocation(line: 685, column: 26, scope: !2207)
!2220 = !DILocation(line: 685, column: 45, scope: !2207)
!2221 = !DILocation(line: 685, column: 9, scope: !2207)
!2222 = !DILocation(line: 686, column: 5, scope: !2207)
!2223 = distinct !DISubprogram(name: "from_vector_sign<float>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE16from_vector_signIfEEvRKNS_6vectorIT_Lj8EEEbi", scope: !378, file: !379, line: 631, type: !2224, scopeLine: 632, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1053, declaration: !2226, retainedNodes: !2227)
!2224 = !DISubroutineType(types: !2225)
!2225 = !{null, !413, !1840, !176, !9}
!2226 = !DISubprogram(name: "from_vector_sign<float>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE16from_vector_signIfEEvRKNS_6vectorIT_Lj8EEEbi", scope: !378, file: !379, line: 631, type: !2224, scopeLine: 631, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1053)
!2227 = !{!2228, !2229, !2230, !2231, !2232}
!2228 = !DILocalVariable(name: "this", arg: 1, scope: !2223, type: !2213, flags: DIFlagArtificial | DIFlagObjectPointer)
!2229 = !DILocalVariable(name: "v", arg: 2, scope: !2223, file: !379, line: 631, type: !1840)
!2230 = !DILocalVariable(name: "v_sign", arg: 3, scope: !2223, file: !379, line: 631, type: !176)
!2231 = !DILocalVariable(name: "shift", arg: 4, scope: !2223, file: !379, line: 631, type: !9)
!2232 = !DILocalVariable(name: "fn", scope: !2233, file: !379, line: 643, type: !2240)
!2233 = distinct !DILexicalBlock(scope: !2234, file: !379, line: 642, column: 94)
!2234 = distinct !DILexicalBlock(scope: !2235, file: !379, line: 642, column: 31)
!2235 = distinct !DILexicalBlock(scope: !2236, file: !379, line: 641, column: 63)
!2236 = distinct !DILexicalBlock(scope: !2237, file: !379, line: 641, column: 27)
!2237 = distinct !DILexicalBlock(scope: !2238, file: !379, line: 640, column: 14)
!2238 = distinct !DILexicalBlock(scope: !2239, file: !379, line: 637, column: 28)
!2239 = distinct !DILexicalBlock(scope: !2223, file: !379, line: 633, column: 23)
!2240 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2241)
!2241 = distinct !DICompositeType(tag: DW_TAG_class_type, file: !379, line: 748, size: 8, flags: DIFlagTypePassByValue, elements: !137, identifier: "_ZTSZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_upsIfLj8EEEDavEUlRKT_T0_T1_E_")
!2242 = !DILocation(line: 0, scope: !2223)
!2243 = !DILocation(line: 631, column: 51, scope: !2223)
!2244 = !{!2245, !2245, i64 0, i64 1}
!2245 = !{!1514, i64 1, !"bool"}
!2246 = !DILocation(line: 631, column: 59, scope: !2223)
!2247 = !DILocation(line: 631, column: 71, scope: !2223)
!2248 = !DILocation(line: 643, column: 21, scope: !2233)
!2249 = !DILocation(line: 643, column: 36, scope: !2233)
!2250 = !DILocation(line: 648, column: 35, scope: !2251)
!2251 = distinct !DILexicalBlock(scope: !2233, file: !379, line: 645, column: 35)
!2252 = !DILocation(line: 648, column: 38, scope: !2251)
!2253 = !DILocation(line: 648, column: 45, scope: !2251)
!2254 = !{i8 0, i8 2}
!2255 = !DILocation(line: 648, column: 32, scope: !2251)
!2256 = !DILocation(line: 648, column: 25, scope: !2251)
!2257 = !DILocation(line: 648, column: 30, scope: !2251)
!2258 = !{!1687, !1687, i64 0, i64 32}
!2259 = !DILocation(line: 649, column: 17, scope: !2234)
!2260 = !DILocation(line: 679, column: 5, scope: !2223)
!2261 = distinct !DISubprogram(name: "operator()<aie::vector<float, 8U>, int, bool>", linkageName: "_ZZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_upsIfLj8EEEDavENKUlRKT_T0_T1_E_clINS_6vectorIfLj8EEEibEEDaS7_S8_S9_", scope: !2241, file: !379, line: 748, type: !2262, scopeLine: 748, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2266, declaration: !2265, retainedNodes: !2270)
!2262 = !DISubroutineType(types: !2263)
!2263 = !{!396, !2264, !1840, !9, !176}
!2264 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2240, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2265 = !DISubprogram(name: "operator()<aie::vector<float, 8U>, int, bool>", scope: !2241, file: !379, line: 748, type: !2262, scopeLine: 748, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2266)
!2266 = !{!2267, !2268, !2269}
!2267 = !DITemplateTypeParameter(name: "v:auto", type: !188)
!2268 = !DITemplateTypeParameter(name: "shift_dummy:auto", type: !9)
!2269 = !DITemplateTypeParameter(name: "sign_dummy:auto", type: !176)
!2270 = !{!2271, !2273, !2274, !2275}
!2271 = !DILocalVariable(name: "this", arg: 1, scope: !2261, type: !2272, flags: DIFlagArtificial | DIFlagObjectPointer)
!2272 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2240, size: 32)
!2273 = !DILocalVariable(name: "v", arg: 2, scope: !2261, file: !379, line: 748, type: !1840)
!2274 = !DILocalVariable(name: "shift_dummy", arg: 3, scope: !2261, file: !379, line: 748, type: !9)
!2275 = !DILocalVariable(name: "sign_dummy", arg: 4, scope: !2261, file: !379, line: 748, type: !176)
!2276 = !DILocation(line: 0, scope: !2261)
!2277 = !DILocation(line: 748, column: 39, scope: !2261)
!2278 = !DILocation(line: 748, column: 47, scope: !2261)
!2279 = !DILocation(line: 748, column: 65, scope: !2261)
!2280 = !DILocation(line: 748, column: 112, scope: !2261)
!2281 = !DILocation(line: 748, column: 111, scope: !2261)
!2282 = !DILocation(line: 748, column: 99, scope: !2261)
!2283 = distinct !DISubprogram(name: "operator v8float", linkageName: "_ZNK3aie6vectorIfLj8EEcv7v8floatEv", scope: !188, file: !189, line: 205, type: !289, scopeLine: 206, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !293, retainedNodes: !2284)
!2284 = !{!2285}
!2285 = !DILocalVariable(name: "this", arg: 1, scope: !2283, type: !2286, flags: DIFlagArtificial | DIFlagObjectPointer)
!2286 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !292, size: 32)
!2287 = !DILocation(line: 0, scope: !2283)
!2288 = !DILocation(line: 207, column: 16, scope: !2283)
!2289 = !DILocation(line: 207, column: 9, scope: !2283)
!2290 = distinct !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6vectorIfLj8EE9to_nativeEv", scope: !188, file: !189, line: 196, type: !289, scopeLine: 197, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !288, retainedNodes: !2291)
!2291 = !{!2292}
!2292 = !DILocalVariable(name: "this", arg: 1, scope: !2290, type: !2286, flags: DIFlagArtificial | DIFlagObjectPointer)
!2293 = !DILocation(line: 0, scope: !2290)
!2294 = !DILocation(line: 198, column: 27, scope: !2290)
!2295 = !DILocation(line: 198, column: 9, scope: !2290)
!2296 = distinct !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE9to_nativeEv", scope: !192, file: !193, line: 1154, type: !256, scopeLine: 1155, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !255, retainedNodes: !2297)
!2297 = !{!2298}
!2298 = !DILocalVariable(name: "this", arg: 1, scope: !2296, type: !2299, flags: DIFlagArtificial | DIFlagObjectPointer)
!2299 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 32)
!2300 = !DILocation(line: 0, scope: !2296)
!2301 = !DILocation(line: 1160, column: 20, scope: !2302)
!2302 = distinct !DILexicalBlock(scope: !2296, file: !193, line: 1157, column: 23)
!2303 = distinct !DISubprogram(name: "mac<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>, aie::vector_elem_ref<float, 8U>, aie::vector<float, 8U> >", linkageName: "_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_", scope: !8, file: !1474, line: 4866, type: !2304, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2320, retainedNodes: !2316)
!2304 = !DISubroutineType(types: !2305)
!2305 = !{!2306, !2315, !322, !1840}
!2306 = !DIDerivedType(tag: DW_TAG_typedef, name: "operand_base_type_t<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1> >", scope: !8, file: !1052, line: 410, baseType: !2307)
!2307 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2308, file: !1474, line: 112, baseType: !2311)
!2308 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "operand_base_type<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1> >", scope: !8, file: !1474, line: 110, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2309, identifier: "_ZTSN3aie17operand_base_typeINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEEEE")
!2309 = !{!2310}
!2310 = !DITemplateTypeParameter(name: "T", type: !997)
!2311 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !997, file: !45, line: 459, baseType: !2312)
!2312 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_value_type_t<result_type>", scope: !8, file: !45, line: 355, baseType: !2313)
!2313 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2314, file: !45, line: 242, baseType: !374)
!2314 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_value_type_helper<aie::accum<accfloat, 8U> >", scope: !8, file: !45, line: 240, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !915, identifier: "_ZTSN3aie20op_value_type_helperINS_5accumI8accfloatLj8EEEEE")
!2315 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1009, size: 32)
!2316 = !{!2317, !2318, !2319}
!2317 = !DILocalVariable(name: "acc", arg: 1, scope: !2303, file: !1474, line: 4866, type: !2315)
!2318 = !DILocalVariable(name: "a", arg: 2, scope: !2303, file: !1474, line: 4866, type: !322)
!2319 = !DILocalVariable(name: "v", arg: 3, scope: !2303, file: !1474, line: 4866, type: !1840)
!2320 = !{!2321, !1867, !1868}
!2321 = !DITemplateTypeParameter(name: "Acc", type: !997)
!2322 = !DILocation(line: 4866, column: 31, scope: !2303)
!2323 = !DILocation(line: 4866, column: 38, scope: !2303)
!2324 = !DILocation(line: 4866, column: 52, scope: !2303)
!2325 = !DILocation(line: 4875, column: 20, scope: !2326)
!2326 = distinct !DILexicalBlock(scope: !2327, file: !1474, line: 4874, column: 37)
!2327 = distinct !DILexicalBlock(scope: !2328, file: !1474, line: 4874, column: 24)
!2328 = distinct !DILexicalBlock(scope: !2329, file: !1474, line: 4871, column: 24)
!2329 = distinct !DILexicalBlock(scope: !2303, file: !1474, line: 4868, column: 24)
!2330 = !DILocation(line: 4875, column: 25, scope: !2326)
!2331 = !DILocation(line: 4875, column: 37, scope: !2326)
!2332 = !DILocation(line: 4875, column: 16, scope: !2326)
!2333 = !{!2334, !2334, i64 0, i64 8}
!2334 = !{!1514, i64 8, !"_ZTSN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE", !2335, i64 0, i64 8}
!2335 = !{!1514, i64 8, !"_ZTSN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE", !1781, i64 0, i64 8}
!2336 = !DILocation(line: 4875, column: 9, scope: !2326)
!2337 = distinct !DISubprogram(name: "op_add<aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_", scope: !8, file: !1474, line: 380, type: !2338, scopeLine: 381, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2342, retainedNodes: !2340)
!2338 = !DISubroutineType(types: !2339)
!2339 = !{!997, !447}
!2340 = !{!2341}
!2341 = !DILocalVariable(name: "acc", arg: 1, scope: !2337, file: !1474, line: 380, type: !447)
!2342 = !{!1866}
!2343 = !DILocation(line: 380, column: 63, scope: !2337)
!2344 = !DILocation(line: 382, column: 13, scope: !2337)
!2345 = !DILocation(line: 382, column: 12, scope: !2337)
!2346 = !DILocation(line: 382, column: 5, scope: !2337)
!2347 = distinct !DISubprogram(name: "mac<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>, aie::unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>, aie::vector<float, 8U> >", linkageName: "_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_", scope: !8, file: !1474, line: 4866, type: !2348, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2354, retainedNodes: !2350)
!2348 = !DISubroutineType(types: !2349)
!2349 = !{!2306, !2315, !984, !1840}
!2350 = !{!2351, !2352, !2353}
!2351 = !DILocalVariable(name: "acc", arg: 1, scope: !2347, file: !1474, line: 4866, type: !2315)
!2352 = !DILocalVariable(name: "a", arg: 2, scope: !2347, file: !1474, line: 4866, type: !984)
!2353 = !DILocalVariable(name: "v", arg: 3, scope: !2347, file: !1474, line: 4866, type: !1840)
!2354 = !{!2321, !2355, !1868}
!2355 = !DITemplateTypeParameter(name: "E", type: !984)
!2356 = !DILocation(line: 4866, column: 31, scope: !2347)
!2357 = !DILocation(line: 4866, column: 38, scope: !2347)
!2358 = !DILocation(line: 4866, column: 52, scope: !2347)
!2359 = !DILocation(line: 4878, column: 20, scope: !2360)
!2360 = distinct !DILexicalBlock(scope: !2361, file: !1474, line: 4877, column: 39)
!2361 = distinct !DILexicalBlock(scope: !2362, file: !1474, line: 4877, column: 24)
!2362 = distinct !DILexicalBlock(scope: !2363, file: !1474, line: 4874, column: 24)
!2363 = distinct !DILexicalBlock(scope: !2364, file: !1474, line: 4871, column: 24)
!2364 = distinct !DILexicalBlock(scope: !2347, file: !1474, line: 4868, column: 24)
!2365 = !DILocation(line: 4878, column: 25, scope: !2360)
!2366 = !DILocation(line: 4878, column: 28, scope: !2360)
!2367 = !DILocation(line: 4878, column: 36, scope: !2360)
!2368 = !DILocation(line: 4878, column: 16, scope: !2360)
!2369 = !DILocation(line: 4878, column: 9, scope: !2360)
!2370 = distinct !DISubprogram(name: "op_none<aie::vector_elem_ref<float, 8U> >", linkageName: "_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_", scope: !8, file: !1474, line: 409, type: !2371, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !937, retainedNodes: !2373)
!2371 = !DISubroutineType(types: !2372)
!2372 = !{!984, !320}
!2373 = !{!2374}
!2374 = !DILocalVariable(name: "e", arg: 1, scope: !2370, file: !1474, line: 409, type: !320)
!2375 = !DILocation(line: 409, column: 57, scope: !2370)
!2376 = !DILocation(line: 411, column: 13, scope: !2370)
!2377 = !DILocation(line: 411, column: 12, scope: !2370)
!2378 = !DILocation(line: 411, column: 5, scope: !2370)
!2379 = distinct !DISubprogram(name: "mac<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>, aie::unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>, aie::unary_op<aie::vector<float, 8U>, (aie::Operation)0> >", linkageName: "_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_", scope: !8, file: !1474, line: 4866, type: !2380, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2399, retainedNodes: !2383)
!2380 = !DISubroutineType(types: !2381)
!2381 = !{!2306, !2315, !984, !2382}
!2382 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !983, size: 32)
!2383 = !{!2384, !2385, !2386, !2387, !2398}
!2384 = !DILocalVariable(name: "acc", arg: 1, scope: !2379, file: !1474, line: 4866, type: !2315)
!2385 = !DILocalVariable(name: "a", arg: 2, scope: !2379, file: !1474, line: 4866, type: !984)
!2386 = !DILocalVariable(name: "v", arg: 3, scope: !2379, file: !1474, line: 4866, type: !2382)
!2387 = !DILocalVariable(name: "Op1", scope: !2388, file: !1474, line: 4902, type: !907)
!2388 = distinct !DILexicalBlock(scope: !2389, file: !1474, line: 4901, column: 14)
!2389 = distinct !DILexicalBlock(scope: !2390, file: !1474, line: 4898, column: 28)
!2390 = distinct !DILexicalBlock(scope: !2391, file: !1474, line: 4896, column: 28)
!2391 = distinct !DILexicalBlock(scope: !2392, file: !1474, line: 4894, column: 28)
!2392 = distinct !DILexicalBlock(scope: !2393, file: !1474, line: 4892, column: 28)
!2393 = distinct !DILexicalBlock(scope: !2394, file: !1474, line: 4880, column: 10)
!2394 = distinct !DILexicalBlock(scope: !2395, file: !1474, line: 4877, column: 24)
!2395 = distinct !DILexicalBlock(scope: !2396, file: !1474, line: 4874, column: 24)
!2396 = distinct !DILexicalBlock(scope: !2397, file: !1474, line: 4871, column: 24)
!2397 = distinct !DILexicalBlock(scope: !2379, file: !1474, line: 4868, column: 24)
!2398 = !DILocalVariable(name: "Op2", scope: !2388, file: !1474, line: 4903, type: !907)
!2399 = !{!2321, !2355, !2400}
!2400 = !DITemplateTypeParameter(name: "Vec", type: !971)
!2401 = !DILocation(line: 4866, column: 31, scope: !2379)
!2402 = !DILocation(line: 4866, column: 38, scope: !2379)
!2403 = !DILocation(line: 4866, column: 52, scope: !2379)
!2404 = !DILocation(line: 4902, column: 13, scope: !2388)
!2405 = !DILocation(line: 4902, column: 33, scope: !2388)
!2406 = !{!2407, !2407, i64 0, i64 4}
!2407 = !{!1514, i64 4, !"_ZTSN3aie9OperationE"}
!2408 = !DILocation(line: 4903, column: 13, scope: !2388)
!2409 = !DILocation(line: 4903, column: 33, scope: !2388)
!2410 = !DILocation(line: 4906, column: 156, scope: !2411)
!2411 = distinct !DILexicalBlock(scope: !2388, file: !1474, line: 4905, column: 27)
!2412 = !DILocation(line: 4906, column: 158, scope: !2411)
!2413 = !DILocation(line: 4906, column: 134, scope: !2411)
!2414 = !DILocation(line: 4906, column: 191, scope: !2411)
!2415 = !DILocation(line: 4906, column: 170, scope: !2411)
!2416 = !DILocation(line: 4906, column: 195, scope: !2411)
!2417 = !DILocation(line: 4906, column: 197, scope: !2411)
!2418 = !DILocation(line: 4906, column: 229, scope: !2411)
!2419 = !{!2420, !2420, i64 0, i64 32}
!2420 = !{!1514, i64 32, !"_ZTSN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEE", !2421, i64 0, i64 32}
!2421 = !{!1514, i64 32, !"_ZTSN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEE", !1671, i64 0, i64 32}
!2422 = !DILocation(line: 4906, column: 208, scope: !2411)
!2423 = !DILocation(line: 4906, column: 233, scope: !2411)
!2424 = !DILocation(line: 4906, column: 237, scope: !2411)
!2425 = !DILocation(line: 4906, column: 24, scope: !2411)
!2426 = !{!2427, !2427, i64 0, i64 8}
!2427 = !{!1514, i64 8, !"_ZTSN3aie21vector_elem_const_refIfLj8EEE", !1513, i64 0, i64 4, !1722, i64 4, i64 4}
!2428 = !DILocation(line: 4906, column: 17, scope: !2411)
!2429 = !DILocation(line: 4909, column: 9, scope: !2389)
!2430 = !DILocation(line: 4911, column: 1, scope: !2379)
!2431 = distinct !DISubprogram(name: "op_none<aie::vector<float, 8U> >", linkageName: "_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_", scope: !8, file: !1474, line: 409, type: !2432, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !959, retainedNodes: !2434)
!2432 = !DISubroutineType(types: !2433)
!2433 = !{!971, !1840}
!2434 = !{!2435}
!2435 = !DILocalVariable(name: "e", arg: 1, scope: !2431, file: !1474, line: 409, type: !1840)
!2436 = !DILocation(line: 409, column: 57, scope: !2431)
!2437 = !DILocation(line: 411, column: 13, scope: !2431)
!2438 = !DILocation(line: 411, column: 12, scope: !2431)
!2439 = !DILocation(line: 411, column: 5, scope: !2431)
!2440 = distinct !DISubprogram(name: "run<8U, 8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_", scope: !2441, file: !58, line: 792, type: !2449, scopeLine: 793, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2458, declaration: !2457, retainedNodes: !2463)
!2441 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "mul_bits<(aie::detail::MulMacroOp)2, 32U, 32U, float, 32U, float>", scope: !7, file: !58, line: 776, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2442, identifier: "_ZTSN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfEE")
!2442 = !{!2443, !2444, !2445, !2446, !2447, !2448}
!2443 = !DITemplateValueParameter(name: "MulOp", type: !57, value: i32 2)
!2444 = !DITemplateValueParameter(name: "AccumBits", type: !15, value: i32 32)
!2445 = !DITemplateValueParameter(name: "Type1Bits", type: !15, value: i32 32)
!2446 = !DITemplateTypeParameter(name: "T1", type: !80)
!2447 = !DITemplateValueParameter(name: "Type2Bits", type: !15, value: i32 32)
!2448 = !DITemplateTypeParameter(name: "T2", type: !80)
!2449 = !DISubroutineType(types: !2450)
!2450 = !{!2451, !308, !176, !2454, !176, !447}
!2451 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_type<8U>", scope: !2453, file: !2452, line: 80, baseType: !374)
!2452 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp", directory: "")
!2453 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "mul_bits_impl<(aie::detail::MulMacroOp)2, 32U, 32U, float, 32U, float>", scope: !7, file: !2452, line: 73, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2442, identifier: "_ZTSN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfEE")
!2454 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2455, size: 32)
!2455 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2456)
!2456 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type2<8U>", scope: !2441, file: !58, line: 781, baseType: !188)
!2457 = !DISubprogram(name: "run<8U, 8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_", scope: !2441, file: !58, line: 792, type: !2449, scopeLine: 792, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2458)
!2458 = !{!210, !2459, !2460}
!2459 = !DITemplateValueParameter(name: "Elems2", type: !15, value: i32 8)
!2460 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "Acc", value: !2461)
!2461 = !{!2462}
!2462 = !DITemplateTypeParameter(type: !374)
!2463 = !{!2464, !2465, !2466, !2467, !2468}
!2464 = !DILocalVariable(name: "a", arg: 1, scope: !2440, file: !58, line: 792, type: !308)
!2465 = !DILocalVariable(name: "a_sign", arg: 2, scope: !2440, file: !58, line: 792, type: !176)
!2466 = !DILocalVariable(name: "v", arg: 3, scope: !2440, file: !58, line: 792, type: !2454)
!2467 = !DILocalVariable(name: "v_sign", arg: 4, scope: !2440, file: !58, line: 792, type: !176)
!2468 = !DILocalVariable(name: "acc", arg: 5, scope: !2440, file: !58, line: 792, type: !447)
!2469 = !DILocation(line: 792, column: 54, scope: !2440)
!2470 = !DILocation(line: 792, column: 62, scope: !2440)
!2471 = !DILocation(line: 792, column: 98, scope: !2440)
!2472 = !DILocation(line: 792, column: 106, scope: !2440)
!2473 = !DILocation(line: 792, column: 129, scope: !2440)
!2474 = !DILocation(line: 794, column: 83, scope: !2440)
!2475 = !DILocation(line: 794, column: 86, scope: !2440)
!2476 = !DILocation(line: 794, column: 94, scope: !2440)
!2477 = !DILocation(line: 794, column: 97, scope: !2440)
!2478 = !DILocation(line: 794, column: 105, scope: !2440)
!2479 = !DILocation(line: 794, column: 16, scope: !2440)
!2480 = !DILocation(line: 794, column: 9, scope: !2440)
!2481 = distinct !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !928, file: !45, line: 413, type: !2482, scopeLine: 414, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2486, retainedNodes: !2487)
!2482 = !DISubroutineType(types: !2483)
!2483 = !{!933, !2484}
!2484 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2485, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2485 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !928)
!2486 = !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !928, file: !45, line: 413, type: !2482, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2487 = !{!2488}
!2488 = !DILocalVariable(name: "this", arg: 1, scope: !2481, type: !2489, flags: DIFlagArtificial | DIFlagObjectPointer)
!2489 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2485, size: 32)
!2490 = !DILocation(line: 0, scope: !2481)
!2491 = !DILocation(line: 418, column: 20, scope: !2492)
!2492 = distinct !DILexicalBlock(scope: !2481, file: !45, line: 415, column: 22)
!2493 = distinct !DISubprogram(name: "vector_elem_const_ref", linkageName: "_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE", scope: !308, file: !309, line: 35, type: !317, scopeLine: 38, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !316, retainedNodes: !2494)
!2494 = !{!2495, !2497}
!2495 = !DILocalVariable(name: "this", arg: 1, scope: !2493, type: !2496, flags: DIFlagArtificial | DIFlagObjectPointer)
!2496 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !308, size: 32)
!2497 = !DILocalVariable(name: "ref", arg: 2, scope: !2493, file: !309, line: 35, type: !320)
!2498 = !DILocation(line: 0, scope: !2493)
!2499 = !DILocation(line: 35, column: 66, scope: !2493)
!2500 = !DILocation(line: 36, column: 9, scope: !2493)
!2501 = !DILocation(line: 36, column: 16, scope: !2493)
!2502 = !DILocation(line: 36, column: 20, scope: !2493)
!2503 = !{!1781, !1513, i64 0, i64 4}
!2504 = !DILocation(line: 37, column: 9, scope: !2493)
!2505 = !DILocation(line: 37, column: 16, scope: !2493)
!2506 = !DILocation(line: 37, column: 20, scope: !2493)
!2507 = !{!1781, !1722, i64 4, i64 4}
!2508 = !{!2427, !1722, i64 4, i64 4}
!2509 = !DILocation(line: 39, column: 5, scope: !2493)
!2510 = distinct !DISubprogram(name: "get_mul_sign<aie::unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0> >", linkageName: "_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_", scope: !7, file: !58, line: 640, type: !2511, scopeLine: 641, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2515, retainedNodes: !2513)
!2511 = !DISubroutineType(types: !2512)
!2512 = !{!176, !984}
!2513 = !{!2514}
!2514 = !DILocalVariable(name: "v", arg: 1, scope: !2510, file: !58, line: 640, type: !984)
!2515 = !{!2516}
!2516 = !DITemplateTypeParameter(name: "T", type: !984)
!2517 = !DILocation(line: 640, column: 31, scope: !2510)
!2518 = !DILocation(line: 645, column: 13, scope: !2519)
!2519 = distinct !DILexicalBlock(scope: !2510, file: !58, line: 642, column: 23)
!2520 = distinct !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !950, file: !45, line: 413, type: !2521, scopeLine: 414, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2525, retainedNodes: !2526)
!2521 = !DISubroutineType(types: !2522)
!2522 = !{!955, !2523}
!2523 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2524, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2524 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !950)
!2525 = !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !950, file: !45, line: 413, type: !2521, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2526 = !{!2527}
!2527 = !DILocalVariable(name: "this", arg: 1, scope: !2520, type: !2528, flags: DIFlagArtificial | DIFlagObjectPointer)
!2528 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2524, size: 32)
!2529 = !DILocation(line: 0, scope: !2520)
!2530 = !DILocation(line: 418, column: 20, scope: !2531)
!2531 = distinct !DILexicalBlock(scope: !2520, file: !45, line: 415, column: 22)
!2532 = distinct !DISubprogram(name: "get_mul_sign<aie::unary_op<aie::vector<float, 8U>, (aie::Operation)0> >", linkageName: "_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_", scope: !7, file: !58, line: 640, type: !2533, scopeLine: 641, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2537, retainedNodes: !2535)
!2533 = !DISubroutineType(types: !2534)
!2534 = !{!176, !971}
!2535 = !{!2536}
!2536 = !DILocalVariable(name: "v", arg: 1, scope: !2532, file: !58, line: 640, type: !971)
!2537 = !{!2538}
!2538 = !DITemplateTypeParameter(name: "T", type: !971)
!2539 = !DILocation(line: 640, column: 31, scope: !2532)
!2540 = !DILocation(line: 645, column: 13, scope: !2541)
!2541 = distinct !DILexicalBlock(scope: !2532, file: !58, line: 642, column: 23)
!2542 = distinct !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev", scope: !904, file: !45, line: 413, type: !2543, scopeLine: 414, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2547, retainedNodes: !2548)
!2543 = !DISubroutineType(types: !2544)
!2544 = !{!910, !2545}
!2545 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2546, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2546 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !904)
!2547 = !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev", scope: !904, file: !45, line: 413, type: !2543, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2548 = !{!2549}
!2549 = !DILocalVariable(name: "this", arg: 1, scope: !2542, type: !2550, flags: DIFlagArtificial | DIFlagObjectPointer)
!2550 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2546, size: 32)
!2551 = !DILocation(line: 0, scope: !2542)
!2552 = !DILocation(line: 418, column: 20, scope: !2553)
!2553 = distinct !DILexicalBlock(scope: !2542, file: !45, line: 415, column: 22)
!2554 = distinct !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_", scope: !2453, file: !2452, line: 113, type: !2555, scopeLine: 114, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2562, declaration: !2561, retainedNodes: !2563)
!2555 = !DISubroutineType(types: !2556)
!2556 = !{!2451, !2557, !198, !2558, !198, !447}
!2557 = !DIDerivedType(tag: DW_TAG_typedef, name: "T", file: !2452, line: 75, baseType: !80)
!2558 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2559, size: 32)
!2559 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2560)
!2560 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type<8U>", scope: !2453, file: !2452, line: 78, baseType: !188)
!2561 = !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_", scope: !2453, file: !2452, line: 113, type: !2555, scopeLine: 113, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2562)
!2562 = !{!210, !2460}
!2563 = !{!2564, !2565, !2566, !2567, !2568}
!2564 = !DILocalVariable(name: "a", arg: 1, scope: !2554, file: !2452, line: 113, type: !2557)
!2565 = !DILocalVariable(name: "a_sign", arg: 2, scope: !2554, file: !2452, line: 113, type: !198)
!2566 = !DILocalVariable(name: "v", arg: 3, scope: !2554, file: !2452, line: 113, type: !2558)
!2567 = !DILocalVariable(name: "v_sign", arg: 4, scope: !2554, file: !2452, line: 113, type: !198)
!2568 = !DILocalVariable(name: "acc", arg: 5, scope: !2554, file: !2452, line: 113, type: !447)
!2569 = !{!2570, !2570, i64 0, i64 4}
!2570 = !{!1514, i64 4, !"float"}
!2571 = !DILocation(line: 113, column: 36, scope: !2554)
!2572 = !DILocation(line: 113, column: 50, scope: !2554)
!2573 = !DILocation(line: 113, column: 84, scope: !2554)
!2574 = !DILocation(line: 113, column: 98, scope: !2554)
!2575 = !DILocation(line: 113, column: 121, scope: !2554)
!2576 = !DILocation(line: 115, column: 20, scope: !2554)
!2577 = !DILocation(line: 115, column: 49, scope: !2554)
!2578 = !DILocation(line: 115, column: 57, scope: !2554)
!2579 = !DILocation(line: 115, column: 60, scope: !2554)
!2580 = !DILocation(line: 115, column: 68, scope: !2554)
!2581 = !DILocation(line: 115, column: 16, scope: !2554)
!2582 = !DILocation(line: 115, column: 9, scope: !2554)
!2583 = distinct !DISubprogram(name: "operator float", linkageName: "_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv", scope: !308, file: !309, line: 52, type: !355, scopeLine: 53, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !359, retainedNodes: !2584)
!2584 = !{!2585}
!2585 = !DILocalVariable(name: "this", arg: 1, scope: !2583, type: !2586, flags: DIFlagArtificial | DIFlagObjectPointer)
!2586 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !348, size: 32)
!2587 = !DILocation(line: 0, scope: !2583)
!2588 = !DILocation(line: 54, column: 16, scope: !2583)
!2589 = !DILocation(line: 54, column: 9, scope: !2583)
!2590 = distinct !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_", scope: !2453, file: !2452, line: 93, type: !2591, scopeLine: 94, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2562, declaration: !2593, retainedNodes: !2594)
!2591 = !DISubroutineType(types: !2592)
!2592 = !{!2451, !2558, !198, !2558, !198, !447}
!2593 = !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_", scope: !2453, file: !2452, line: 93, type: !2591, scopeLine: 93, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2562)
!2594 = !{!2595, !2596, !2597, !2598, !2599, !2600, !2603, !2604}
!2595 = !DILocalVariable(name: "v1", arg: 1, scope: !2590, file: !2452, line: 93, type: !2558)
!2596 = !DILocalVariable(name: "v1_sign", arg: 2, scope: !2590, file: !2452, line: 93, type: !198)
!2597 = !DILocalVariable(name: "v2", arg: 3, scope: !2590, file: !2452, line: 93, type: !2558)
!2598 = !DILocalVariable(name: "v2_sign", arg: 4, scope: !2590, file: !2452, line: 93, type: !198)
!2599 = !DILocalVariable(name: "acc", arg: 5, scope: !2590, file: !2452, line: 93, type: !447)
!2600 = !DILocalVariable(name: "mul_op", scope: !2590, file: !2452, line: 95, type: !2601)
!2601 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2602)
!2602 = distinct !DICompositeType(tag: DW_TAG_class_type, file: !2452, line: 87, size: 8, flags: DIFlagTypePassByValue, elements: !137, identifier: "_ZTSZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavEUlDpOT_E_")
!2603 = !DILocalVariable(name: "num_mul", scope: !2590, file: !2452, line: 97, type: !101)
!2604 = !DILocalVariable(name: "ret", scope: !2590, file: !2452, line: 99, type: !2451)
!2605 = !DILocation(line: 93, column: 60, scope: !2590)
!2606 = !DILocation(line: 93, column: 75, scope: !2590)
!2607 = !DILocation(line: 93, column: 110, scope: !2590)
!2608 = !DILocation(line: 93, column: 125, scope: !2590)
!2609 = !DILocation(line: 93, column: 149, scope: !2590)
!2610 = !DILocation(line: 95, column: 9, scope: !2590)
!2611 = !DILocation(line: 95, column: 24, scope: !2590)
!2612 = !DILocation(line: 97, column: 9, scope: !2590)
!2613 = !DILocation(line: 97, column: 28, scope: !2590)
!2614 = !DILocation(line: 99, column: 27, scope: !2590)
!2615 = !DILocation(line: 101, column: 38, scope: !2590)
!2616 = !DILocation(line: 101, column: 39, scope: !2590)
!2617 = !DILocation(line: 101, column: 9, scope: !2590)
!2618 = !DILocation(line: 109, column: 5, scope: !2590)
!2619 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf", scope: !2620, file: !2014, line: 63, type: !2623, scopeLine: 64, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2622, retainedNodes: !2627)
!2620 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "broadcast_bits<32U, float, 8U>", scope: !7, file: !2014, line: 59, size: 8, flags: DIFlagTypePassByValue, elements: !2621, templateParams: !2021, identifier: "_ZTSN3aie6detail14broadcast_bitsILj32EfLj8EEE")
!2621 = !{!2622}
!2622 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf", scope: !2620, file: !2014, line: 63, type: !2623, scopeLine: 63, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2623 = !DISubroutineType(types: !2624)
!2624 = !{!2625, !2626}
!2625 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2620, file: !2014, line: 61, baseType: !188)
!2626 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !153, size: 32)
!2627 = !{!2628}
!2628 = !DILocalVariable(name: "a", arg: 1, scope: !2619, file: !2014, line: 63, type: !2626)
!2629 = !DILocation(line: 63, column: 37, scope: !2619)
!2630 = !DILocation(line: 65, column: 61, scope: !2619)
!2631 = !DILocation(line: 65, column: 16, scope: !2619)
!2632 = !DILocation(line: 65, column: 9, scope: !2619)
!2633 = distinct !DISubprogram(name: "unroll_times<1U, (lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_", scope: !1473, file: !2634, line: 612, type: !2635, scopeLine: 613, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2649, retainedNodes: !2647)
!2634 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/utils.hpp", directory: "")
!2635 = !DISubroutineType(types: !2636)
!2636 = !{null, !2637}
!2637 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2638, size: 32)
!2638 = distinct !DICompositeType(tag: DW_TAG_class_type, scope: !2590, file: !2452, line: 101, size: 160, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !2639, identifier: "_ZTSZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_EUlT_E_")
!2639 = !{!2640, !2642, !2643, !2644, !2645}
!2640 = !DIDerivedType(tag: DW_TAG_member, name: "mul_op", scope: !2638, file: !2452, line: 102, baseType: !2641, size: 32)
!2641 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2601, size: 32)
!2642 = !DIDerivedType(tag: DW_TAG_member, name: "v1", scope: !2638, file: !2452, line: 102, baseType: !2558, size: 32, offset: 32)
!2643 = !DIDerivedType(tag: DW_TAG_member, name: "v2", scope: !2638, file: !2452, line: 103, baseType: !2558, size: 32, offset: 64)
!2644 = !DIDerivedType(tag: DW_TAG_member, name: "acc", scope: !2638, file: !2452, line: 104, baseType: !447, size: 32, offset: 96)
!2645 = !DIDerivedType(tag: DW_TAG_member, name: "ret", scope: !2638, file: !2452, line: 105, baseType: !2646, size: 32, offset: 128)
!2646 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2451, size: 32)
!2647 = !{!2648}
!2648 = !DILocalVariable(name: "fn", arg: 1, scope: !2633, file: !2634, line: 612, type: !2637)
!2649 = !{!2650, !2651}
!2650 = !DITemplateValueParameter(name: "Times", type: !15, value: i32 1)
!2651 = !DITemplateTypeParameter(name: "Fn", type: !2638)
!2652 = !DILocation(line: 612, column: 24, scope: !2633)
!2653 = !DILocation(line: 614, column: 56, scope: !2633)
!2654 = !DILocation(line: 614, column: 5, scope: !2633)
!2655 = !DILocation(line: 615, column: 1, scope: !2633)
!2656 = distinct !DISubprogram(name: "unroll_for<unsigned int, 0U, 1U, 1U, (lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_", scope: !1473, file: !2634, line: 590, type: !2635, scopeLine: 591, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2659, retainedNodes: !2657)
!2657 = !{!2658}
!2658 = !DILocalVariable(name: "fn", arg: 1, scope: !2656, file: !2634, line: 590, type: !2637)
!2659 = !{!2660, !2661, !2662, !2663, !2651}
!2660 = !DITemplateTypeParameter(name: "T", type: !15)
!2661 = !DITemplateValueParameter(name: "Start", type: !15, value: i32 0)
!2662 = !DITemplateValueParameter(name: "End", type: !15, value: i32 1)
!2663 = !DITemplateValueParameter(name: "Step", type: !15, value: i32 1)
!2664 = !DILocation(line: 590, column: 22, scope: !2656)
!2665 = !DILocation(line: 592, column: 77, scope: !2656)
!2666 = !DILocation(line: 592, column: 5, scope: !2656)
!2667 = !DILocation(line: 593, column: 1, scope: !2656)
!2668 = distinct !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2669, file: !2634, line: 495, type: !2635, scopeLine: 496, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2673, declaration: !2672, retainedNodes: !2674)
!2669 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unroll_for_helper<unsigned int, 0U, 1U, 0U, 1U>", scope: !1473, file: !2634, line: 489, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2670, identifier: "_ZTSN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EEE")
!2670 = !{!2660, !2661, !2662, !2671, !2663}
!2671 = !DITemplateValueParameter(name: "It", type: !15, value: i32 0)
!2672 = !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2669, file: !2634, line: 495, type: !2635, scopeLine: 495, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2673)
!2673 = !{!2651}
!2674 = !{!2675, !2676, !2690}
!2675 = !DILocalVariable(name: "fn", arg: 1, scope: !2668, file: !2634, line: 495, type: !2637)
!2676 = !DILocalVariable(name: "it", scope: !2677, file: !2634, line: 498, type: !2679)
!2677 = distinct !DILexicalBlock(scope: !2678, file: !2634, line: 497, column: 73)
!2678 = distinct !DILexicalBlock(scope: !2668, file: !2634, line: 497, column: 23)
!2679 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2680)
!2680 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iteration_dim<unsigned int, 0U, 1U, 0U>", scope: !1473, file: !2634, line: 465, size: 8, flags: DIFlagTypePassByValue, elements: !2681, templateParams: !2689, identifier: "_ZTSN3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEE")
!2681 = !{!2682, !2686, !2687, !2688}
!2682 = !DISubprogram(name: "operator unsigned int", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv", scope: !2680, file: !2634, line: 467, type: !2683, scopeLine: 467, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2683 = !DISubroutineType(types: !2684)
!2684 = !{!15, !2685}
!2685 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2679, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2686 = !DISubprogram(name: "min", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE3minEv", scope: !2680, file: !2634, line: 472, type: !2683, scopeLine: 472, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2687 = !DISubprogram(name: "max", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE3maxEv", scope: !2680, file: !2634, line: 477, type: !2683, scopeLine: 477, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2688 = !DISubprogram(name: "current", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv", scope: !2680, file: !2634, line: 482, type: !2683, scopeLine: 482, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2689 = !{!2660, !2661, !2662, !2671}
!2690 = !DILocalVariable(name: "next_it", scope: !2677, file: !2634, line: 511, type: !101)
!2691 = !DILocation(line: 495, column: 31, scope: !2668)
!2692 = !DILocation(line: 498, column: 13, scope: !2677)
!2693 = !DILocation(line: 498, column: 56, scope: !2677)
!2694 = !DILocation(line: 505, column: 17, scope: !2695)
!2695 = distinct !DILexicalBlock(scope: !2677, file: !2634, line: 504, column: 27)
!2696 = !DILocation(line: 511, column: 13, scope: !2677)
!2697 = !DILocation(line: 511, column: 25, scope: !2677)
!2698 = !DILocation(line: 517, column: 87, scope: !2677)
!2699 = !DILocation(line: 517, column: 13, scope: !2677)
!2700 = !DILocation(line: 518, column: 9, scope: !2678)
!2701 = !DILocation(line: 519, column: 5, scope: !2668)
!2702 = distinct !DISubprogram(name: "operator()<aie::detail::utils::iteration_dim<unsigned int, 0U, 1U, 0U> >", linkageName: "_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_", scope: !2638, file: !2452, line: 101, type: !2703, scopeLine: 101, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2708, declaration: !2707, retainedNodes: !2710)
!2703 = !DISubroutineType(types: !2704)
!2704 = !{null, !2705, !2680}
!2705 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2706, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2706 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2638)
!2707 = !DISubprogram(name: "operator()<aie::detail::utils::iteration_dim<unsigned int, 0U, 1U, 0U> >", scope: !2638, file: !2452, line: 101, type: !2703, scopeLine: 101, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2708)
!2708 = !{!2709}
!2709 = !DITemplateTypeParameter(name: "idx:auto", type: !2680)
!2710 = !{!2711, !2713, !2714}
!2711 = !DILocalVariable(name: "this", arg: 1, scope: !2702, type: !2712, flags: DIFlagArtificial | DIFlagObjectPointer)
!2712 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2706, size: 32)
!2713 = !DILocalVariable(name: "idx", arg: 2, scope: !2702, file: !2452, line: 101, type: !2680)
!2714 = !DILocalVariable(name: "tmp", scope: !2702, file: !2452, line: 102, type: !2715)
!2715 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2716)
!2716 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_type<16>", file: !2452, line: 80, baseType: !492)
!2717 = !DILocation(line: 0, scope: !2702)
!2718 = !DILocation(line: 101, column: 47, scope: !2702)
!2719 = !DILocation(line: 102, column: 13, scope: !2702)
!2720 = !DILocation(line: 102, column: 34, scope: !2702)
!2721 = !DILocation(line: 102, column: 40, scope: !2702)
!2722 = !{!2723, !1513, i64 0, i64 4}
!2723 = !{!1514, i64 20, !"_ZTSZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_EUlT_E_", !1513, i64 0, i64 4, !1513, i64 4, i64 4, !1513, i64 8, i64 4, !1513, i64 12, i64 4, !1513, i64 16, i64 4}
!2724 = !DILocation(line: 102, column: 47, scope: !2702)
!2725 = !{!2723, !1513, i64 4, i64 4}
!2726 = !DILocation(line: 102, column: 76, scope: !2702)
!2727 = !DILocation(line: 102, column: 59, scope: !2702)
!2728 = !DILocation(line: 103, column: 47, scope: !2702)
!2729 = !{!2723, !1513, i64 8, i64 4}
!2730 = !DILocation(line: 103, column: 76, scope: !2702)
!2731 = !DILocation(line: 103, column: 59, scope: !2702)
!2732 = !DILocation(line: 104, column: 47, scope: !2702)
!2733 = !{!2723, !1513, i64 12, i64 4}
!2734 = !DILocation(line: 104, column: 77, scope: !2702)
!2735 = !DILocation(line: 104, column: 60, scope: !2702)
!2736 = !{!2737, !2737, i64 0, i64 64}
!2737 = !{!1514, i64 64, !"v16acc32"}
!2738 = !{!2739, !2739, i64 0, i64 64}
!2739 = !{!1514, i64 64, !"_ZTSN3aie5accumI8accfloatLj16EEE", !2740, i64 0, i64 64}
!2740 = !{!1514, i64 64, !"_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEE", !2737, i64 0, i64 64}
!2741 = !DILocation(line: 105, column: 13, scope: !2702)
!2742 = !{!2723, !1513, i64 16, i64 4}
!2743 = !DILocation(line: 105, column: 24, scope: !2702)
!2744 = !DILocation(line: 105, column: 29, scope: !2702)
!2745 = !DILocation(line: 105, column: 42, scope: !2702)
!2746 = !DILocation(line: 105, column: 17, scope: !2702)
!2747 = !DILocation(line: 106, column: 9, scope: !2702)
!2748 = distinct !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2749, file: !2634, line: 495, type: !2635, scopeLine: 496, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2673, declaration: !2752, retainedNodes: !2753)
!2749 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unroll_for_helper<unsigned int, 0U, 1U, 1U, 1U>", scope: !1473, file: !2634, line: 489, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2750, identifier: "_ZTSN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EEE")
!2750 = !{!2660, !2661, !2662, !2751, !2663}
!2751 = !DITemplateValueParameter(name: "It", type: !15, value: i32 1)
!2752 = !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2749, file: !2634, line: 495, type: !2635, scopeLine: 495, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2673)
!2753 = !{!2754}
!2754 = !DILocalVariable(name: "fn", arg: 1, scope: !2748, file: !2634, line: 495, type: !2637)
!2755 = !DILocation(line: 495, column: 31, scope: !2748)
!2756 = !DILocation(line: 519, column: 5, scope: !2748)
!2757 = distinct !DISubprogram(name: "operator()<aie::vector<float, 16U>, aie::vector<float, 16U>, aie::accum<accfloat, 16U> >", linkageName: "_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_", scope: !2602, file: !2452, line: 87, type: !2758, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2764, declaration: !2763, retainedNodes: !2769)
!2758 = !DISubroutineType(types: !2759)
!2759 = !{!488, !2760, !2761, !2761, !2762}
!2760 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2601, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2761 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !740, size: 32)
!2762 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !492, size: 32)
!2763 = !DISubprogram(name: "operator()<aie::vector<float, 16U>, aie::vector<float, 16U>, aie::accum<accfloat, 16U> >", scope: !2602, file: !2452, line: 87, type: !2758, scopeLine: 87, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2764)
!2764 = !{!2765}
!2765 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "args:auto", value: !2766)
!2766 = !{!2767, !2767, !2768}
!2767 = !DITemplateTypeParameter(type: !740)
!2768 = !DITemplateTypeParameter(type: !492)
!2769 = !{!2770, !2772, !2773, !2774}
!2770 = !DILocalVariable(name: "this", arg: 1, scope: !2757, type: !2771, flags: DIFlagArtificial | DIFlagObjectPointer)
!2771 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2601, size: 32)
!2772 = !DILocalVariable(name: "args", arg: 2, scope: !2757, file: !2452, line: 87, type: !2761)
!2773 = !DILocalVariable(name: "args", arg: 3, scope: !2757, file: !2452, line: 87, type: !2761)
!2774 = !DILocalVariable(name: "args", arg: 4, scope: !2757, file: !2452, line: 87, type: !2762)
!2775 = !DILocation(line: 0, scope: !2757)
!2776 = !DILocation(line: 87, column: 79, scope: !2757)
!2777 = !DILocation(line: 87, column: 121, scope: !2757)
!2778 = !DILocation(line: 87, column: 107, scope: !2757)
!2779 = !DILocation(line: 87, column: 100, scope: !2757)
!2780 = distinct !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 443, type: !2781, scopeLine: 444, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2784, declaration: !2783, retainedNodes: !2786)
!2781 = !DISubroutineType(types: !2782)
!2782 = !{!740, !291, !15}
!2783 = !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 443, type: !2781, scopeLine: 443, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2784)
!2784 = !{!2785}
!2785 = !DITemplateValueParameter(name: "ElemsOut", type: !15, value: i32 16)
!2786 = !{!2787, !2788}
!2787 = !DILocalVariable(name: "this", arg: 1, scope: !2780, type: !2286, flags: DIFlagArtificial | DIFlagObjectPointer)
!2788 = !DILocalVariable(name: "idx", arg: 2, scope: !2780, file: !189, line: 443, type: !15)
!2789 = !DILocation(line: 0, scope: !2780)
!2790 = !DILocation(line: 443, column: 56, scope: !2780)
!2791 = !DILocation(line: 446, column: 20, scope: !2792)
!2792 = distinct !DILexicalBlock(scope: !2780, file: !189, line: 445, column: 23)
!2793 = !DILocation(line: 446, column: 13, scope: !2792)
!2794 = distinct !DISubprogram(name: "operator unsigned int", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv", scope: !2680, file: !2634, line: 467, type: !2683, scopeLine: 468, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2682, retainedNodes: !2795)
!2795 = !{!2796}
!2796 = !DILocalVariable(name: "this", arg: 1, scope: !2794, type: !2797, flags: DIFlagArtificial | DIFlagObjectPointer)
!2797 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2679, size: 32)
!2798 = !DILocation(line: 0, scope: !2794)
!2799 = !DILocation(line: 469, column: 16, scope: !2794)
!2800 = !DILocation(line: 469, column: 9, scope: !2794)
!2801 = distinct !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj", scope: !374, file: !375, line: 302, type: !2802, scopeLine: 303, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2784, declaration: !2804, retainedNodes: !2805)
!2802 = !DISubroutineType(types: !2803)
!2803 = !{!492, !456, !15}
!2804 = !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj", scope: !374, file: !375, line: 302, type: !2802, scopeLine: 302, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2784)
!2805 = !{!2806, !2808}
!2806 = !DILocalVariable(name: "this", arg: 1, scope: !2801, type: !2807, flags: DIFlagArtificial | DIFlagObjectPointer)
!2807 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !448, size: 32)
!2808 = !DILocalVariable(name: "idx", arg: 2, scope: !2801, file: !375, line: 302, type: !15)
!2809 = !DILocation(line: 0, scope: !2801)
!2810 = !DILocation(line: 302, column: 56, scope: !2801)
!2811 = !DILocation(line: 305, column: 20, scope: !2812)
!2812 = distinct !DILexicalBlock(scope: !2801, file: !375, line: 304, column: 23)
!2813 = !DILocation(line: 305, column: 13, scope: !2812)
!2814 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat", scope: !492, file: !375, line: 188, type: !559, scopeLine: 190, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !558, retainedNodes: !2815)
!2815 = !{!2816, !2818}
!2816 = !DILocalVariable(name: "this", arg: 1, scope: !2814, type: !2817, flags: DIFlagArtificial | DIFlagObjectPointer)
!2817 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !492, size: 32)
!2818 = !DILocalVariable(name: "data", arg: 2, scope: !2814, file: !375, line: 188, type: !561)
!2819 = !DILocation(line: 0, scope: !2814)
!2820 = !DILocation(line: 188, column: 21, scope: !2814)
!2821 = !DILocation(line: 189, column: 9, scope: !2814)
!2822 = !DILocation(line: 192, column: 5, scope: !2814)
!2823 = distinct !DISubprogram(name: "insert<8U, accfloat>", linkageName: "_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE", scope: !374, file: !375, line: 334, type: !2824, scopeLine: 335, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2828, declaration: !2827, retainedNodes: !2831)
!2824 = !DISubroutineType(types: !2825)
!2825 = !{!2826, !427, !15, !447}
!2826 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !374, size: 32)
!2827 = !DISubprogram(name: "insert<8U, accfloat>", linkageName: "_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE", scope: !374, file: !375, line: 334, type: !2824, scopeLine: 334, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2828)
!2828 = !{!2829, !2830}
!2829 = !DITemplateValueParameter(name: "ElemsIn", type: !15, value: i32 8)
!2830 = !DITemplateTypeParameter(name: "Tag2", type: !459)
!2831 = !{!2832, !2833, !2834}
!2832 = !DILocalVariable(name: "this", arg: 1, scope: !2823, type: !1828, flags: DIFlagArtificial | DIFlagObjectPointer)
!2833 = !DILocalVariable(name: "idx", arg: 2, scope: !2823, file: !375, line: 334, type: !15)
!2834 = !DILocalVariable(name: "acc", arg: 3, scope: !2823, file: !375, line: 334, type: !447)
!2835 = !DILocation(line: 0, scope: !2823)
!2836 = !DILocation(line: 334, column: 28, scope: !2823)
!2837 = !DILocation(line: 334, column: 61, scope: !2823)
!2838 = !DILocation(line: 337, column: 27, scope: !2823)
!2839 = !DILocation(line: 337, column: 63, scope: !2823)
!2840 = !DILocation(line: 337, column: 20, scope: !2823)
!2841 = !DILocation(line: 338, column: 9, scope: !2823)
!2842 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj", scope: !492, file: !375, line: 286, type: !2843, scopeLine: 287, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2079, declaration: !2845, retainedNodes: !2846)
!2843 = !DISubroutineType(types: !2844)
!2844 = !{!374, !565, !15}
!2845 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj", scope: !492, file: !375, line: 286, type: !2843, scopeLine: 286, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2079)
!2846 = !{!2847, !2849}
!2847 = !DILocalVariable(name: "this", arg: 1, scope: !2842, type: !2848, flags: DIFlagArtificial | DIFlagObjectPointer)
!2848 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !557, size: 32)
!2849 = !DILocalVariable(name: "idx", arg: 2, scope: !2842, file: !375, line: 286, type: !15)
!2850 = !DILocation(line: 0, scope: !2842)
!2851 = !DILocation(line: 286, column: 51, scope: !2842)
!2852 = !DILocation(line: 288, column: 45, scope: !2842)
!2853 = !DILocation(line: 288, column: 83, scope: !2842)
!2854 = !DILocation(line: 288, column: 65, scope: !2842)
!2855 = !DILocation(line: 288, column: 16, scope: !2842)
!2856 = !DILocation(line: 288, column: 9, scope: !2842)
!2857 = distinct !DISubprogram(name: "mac_elem_16", linkageName: "_Z11mac_elem_168v16floatS_11v16accfloat", scope: !2858, file: !2858, line: 883, type: !2859, scopeLine: 883, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2861)
!2858 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/me_vmult_float_emulated.h", directory: "")
!2859 = !DISubroutineType(types: !2860)
!2860 = !{!488, !486, !486, !488}
!2861 = !{!2862, !2863, !2864}
!2862 = !DILocalVariable(name: "v1", arg: 1, scope: !2857, file: !2858, line: 883, type: !486)
!2863 = !DILocalVariable(name: "v2", arg: 2, scope: !2857, file: !2858, line: 883, type: !486)
!2864 = !DILocalVariable(name: "acc", arg: 3, scope: !2857, file: !2858, line: 883, type: !488)
!2865 = !DILocation(line: 883, column: 1, scope: !2857)
!2866 = distinct !DISubprogram(name: "operator v16float", linkageName: "_ZNK3aie6vectorIfLj16EEcv8v16floatEv", scope: !740, file: !189, line: 205, type: !829, scopeLine: 206, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !833, retainedNodes: !2867)
!2867 = !{!2868}
!2868 = !DILocalVariable(name: "this", arg: 1, scope: !2866, type: !2083, flags: DIFlagArtificial | DIFlagObjectPointer)
!2869 = !DILocation(line: 0, scope: !2866)
!2870 = !DILocation(line: 207, column: 16, scope: !2866)
!2871 = !DILocation(line: 207, column: 9, scope: !2866)
!2872 = distinct !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv", scope: !492, file: !375, line: 234, type: !563, scopeLine: 235, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !562, retainedNodes: !2873)
!2873 = !{!2874}
!2874 = !DILocalVariable(name: "this", arg: 1, scope: !2872, type: !2848, flags: DIFlagArtificial | DIFlagObjectPointer)
!2875 = !DILocation(line: 0, scope: !2872)
!2876 = !DILocation(line: 236, column: 27, scope: !2872)
!2877 = !DILocation(line: 236, column: 9, scope: !2872)
!2878 = distinct !DISubprogram(name: "mac_elem_16_accuracy_fast", linkageName: "_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii", scope: !2858, file: !2858, line: 835, type: !2879, scopeLine: 835, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2881)
!2879 = !DISubroutineType(types: !2880)
!2880 = !{!488, !486, !486, !488, !9, !9, !9}
!2881 = !{!2882, !2883, !2884, !2885, !2886, !2887, !2888}
!2882 = !DILocalVariable(name: "v1", arg: 1, scope: !2878, file: !2858, line: 835, type: !486)
!2883 = !DILocalVariable(name: "v2", arg: 2, scope: !2878, file: !2858, line: 835, type: !486)
!2884 = !DILocalVariable(name: "acc", arg: 3, scope: !2878, file: !2858, line: 835, type: !488)
!2885 = !DILocalVariable(name: "zero_acc", arg: 4, scope: !2878, file: !2858, line: 835, type: !9)
!2886 = !DILocalVariable(name: "sub_mul", arg: 5, scope: !2878, file: !2858, line: 835, type: !9)
!2887 = !DILocalVariable(name: "sub_acc1", arg: 6, scope: !2878, file: !2858, line: 835, type: !9)
!2888 = !DILocalVariable(name: "o", scope: !2878, file: !2858, line: 835, type: !488)
!2889 = !DILocation(line: 835, column: 1, scope: !2878)
!2890 = distinct !DISubprogram(name: "mac_elem_16_accuracy_fast_inner", linkageName: "_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii", scope: !2891, file: !2858, line: 175, type: !2879, scopeLine: 176, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2892)
!2891 = !DINamespace(name: "me_detail", scope: null)
!2892 = !{!2893, !2894, !2895, !2896, !2897, !2898, !2899, !2900, !2901, !2902, !2903, !2904, !2905, !2906, !2907}
!2893 = !DILocalVariable(name: "v1", arg: 1, scope: !2890, file: !2858, line: 175, type: !486)
!2894 = !DILocalVariable(name: "v2", arg: 2, scope: !2890, file: !2858, line: 175, type: !486)
!2895 = !DILocalVariable(name: "acc", arg: 3, scope: !2890, file: !2858, line: 175, type: !488)
!2896 = !DILocalVariable(name: "zero_acc", arg: 4, scope: !2890, file: !2858, line: 175, type: !9)
!2897 = !DILocalVariable(name: "sub_mul", arg: 5, scope: !2890, file: !2858, line: 176, type: !9)
!2898 = !DILocalVariable(name: "sub_acc1", arg: 6, scope: !2890, file: !2858, line: 176, type: !9)
!2899 = !DILocalVariable(name: "a", scope: !2890, file: !2858, line: 177, type: !490)
!2900 = !DILocalVariable(name: "b", scope: !2890, file: !2858, line: 178, type: !490)
!2901 = !DILocalVariable(name: "c", scope: !2890, file: !2858, line: 179, type: !490)
!2902 = !DILocalVariable(name: "d", scope: !2890, file: !2858, line: 180, type: !490)
!2903 = !DILocalVariable(name: "e", scope: !2890, file: !2858, line: 181, type: !490)
!2904 = !DILocalVariable(name: "f", scope: !2890, file: !2858, line: 182, type: !490)
!2905 = !DILocalVariable(name: "dummy0", scope: !2890, file: !2858, line: 183, type: !490)
!2906 = !DILocalVariable(name: "acc0", scope: !2890, file: !2858, line: 186, type: !488)
!2907 = !DILocalVariable(name: "acc1", scope: !2890, file: !2858, line: 191, type: !488)
!2908 = !DILocation(line: 175, column: 69, scope: !2890)
!2909 = !DILocation(line: 175, column: 82, scope: !2890)
!2910 = !DILocation(line: 175, column: 98, scope: !2890)
!2911 = !DILocation(line: 175, column: 107, scope: !2890)
!2912 = !DILocation(line: 176, column: 64, scope: !2890)
!2913 = !DILocation(line: 176, column: 77, scope: !2890)
!2914 = !DILocation(line: 177, column: 3, scope: !2890)
!2915 = !DILocation(line: 177, column: 15, scope: !2890)
!2916 = !DILocation(line: 177, column: 19, scope: !2890)
!2917 = !DILocation(line: 178, column: 3, scope: !2890)
!2918 = !DILocation(line: 178, column: 15, scope: !2890)
!2919 = !DILocation(line: 178, column: 19, scope: !2890)
!2920 = !DILocation(line: 179, column: 3, scope: !2890)
!2921 = !DILocation(line: 179, column: 15, scope: !2890)
!2922 = !DILocation(line: 179, column: 19, scope: !2890)
!2923 = !DILocation(line: 180, column: 3, scope: !2890)
!2924 = !DILocation(line: 180, column: 15, scope: !2890)
!2925 = !DILocation(line: 180, column: 19, scope: !2890)
!2926 = !DILocation(line: 181, column: 3, scope: !2890)
!2927 = !DILocation(line: 181, column: 15, scope: !2890)
!2928 = !DILocation(line: 181, column: 19, scope: !2890)
!2929 = !DILocation(line: 182, column: 3, scope: !2890)
!2930 = !DILocation(line: 182, column: 15, scope: !2890)
!2931 = !DILocation(line: 182, column: 19, scope: !2890)
!2932 = !DILocation(line: 183, column: 3, scope: !2890)
!2933 = !DILocation(line: 183, column: 15, scope: !2890)
!2934 = !DILocation(line: 183, column: 24, scope: !2890)
!2935 = !DILocation(line: 185, column: 35, scope: !2890)
!2936 = !DILocation(line: 185, column: 20, scope: !2890)
!2937 = !DILocation(line: 185, column: 7, scope: !2890)
!2938 = !DILocation(line: 185, column: 5, scope: !2890)
!2939 = !DILocation(line: 186, column: 3, scope: !2890)
!2940 = !DILocation(line: 186, column: 15, scope: !2890)
!2941 = !DILocation(line: 186, column: 47, scope: !2890)
!2942 = !DILocation(line: 186, column: 22, scope: !2890)
!2943 = !DILocation(line: 187, column: 20, scope: !2890)
!2944 = !DILocation(line: 187, column: 7, scope: !2890)
!2945 = !DILocation(line: 187, column: 5, scope: !2890)
!2946 = !DILocation(line: 188, column: 35, scope: !2890)
!2947 = !DILocation(line: 188, column: 20, scope: !2890)
!2948 = !DILocation(line: 188, column: 7, scope: !2890)
!2949 = !DILocation(line: 188, column: 5, scope: !2890)
!2950 = !DILocation(line: 190, column: 35, scope: !2890)
!2951 = !DILocation(line: 190, column: 20, scope: !2890)
!2952 = !DILocation(line: 190, column: 7, scope: !2890)
!2953 = !DILocation(line: 190, column: 5, scope: !2890)
!2954 = !DILocation(line: 191, column: 3, scope: !2890)
!2955 = !DILocation(line: 191, column: 15, scope: !2890)
!2956 = !DILocation(line: 191, column: 47, scope: !2890)
!2957 = !DILocation(line: 191, column: 22, scope: !2890)
!2958 = !DILocation(line: 192, column: 20, scope: !2890)
!2959 = !DILocation(line: 192, column: 7, scope: !2890)
!2960 = !DILocation(line: 192, column: 5, scope: !2890)
!2961 = !DILocation(line: 193, column: 35, scope: !2890)
!2962 = !DILocation(line: 193, column: 20, scope: !2890)
!2963 = !DILocation(line: 193, column: 7, scope: !2890)
!2964 = !DILocation(line: 193, column: 5, scope: !2890)
!2965 = !DILocation(line: 201, column: 90, scope: !2890)
!2966 = !DILocation(line: 201, column: 65, scope: !2890)
!2967 = !DILocation(line: 201, column: 103, scope: !2890)
!2968 = !DILocation(line: 201, column: 40, scope: !2890)
!2969 = !DILocation(line: 202, column: 34, scope: !2890)
!2970 = !DILocation(line: 201, column: 15, scope: !2890)
!2971 = !DILocation(line: 203, column: 18, scope: !2890)
!2972 = !DILocation(line: 199, column: 11, scope: !2890)
!2973 = !DILocation(line: 204, column: 14, scope: !2890)
!2974 = !DILocation(line: 197, column: 7, scope: !2890)
!2975 = !DILocation(line: 205, column: 7, scope: !2890)
!2976 = !DILocation(line: 205, column: 17, scope: !2890)
!2977 = !DILocation(line: 205, column: 26, scope: !2890)
!2978 = !DILocation(line: 195, column: 10, scope: !2890)
!2979 = !DILocation(line: 206, column: 1, scope: !2890)
!2980 = !{!2981, !2981, i64 0, i64 1}
!2981 = !{!1514, i64 1, !"uint4_t"}
!2982 = !{!2983, !2983, i64 0, i64 4}
!2983 = !{!1514, i64 4, !"uint5_t"}
!2984 = !{!2985, !2985, i64 0, i64 4}
!2985 = !{!1514, i64 4, !"uint1_t"}
!2986 = !{!2987, !2987, i64 0, i64 2}
!2987 = !{!1514, i64 2, !"short"}
!2988 = !{i32 2}
!2989 = distinct !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6vectorIfLj16EE9to_nativeEv", scope: !740, file: !189, line: 196, type: !829, scopeLine: 197, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !828, retainedNodes: !2990)
!2990 = !{!2991}
!2991 = !DILocalVariable(name: "this", arg: 1, scope: !2989, type: !2083, flags: DIFlagArtificial | DIFlagObjectPointer)
!2992 = !DILocation(line: 0, scope: !2989)
!2993 = !DILocation(line: 198, column: 27, scope: !2989)
!2994 = !DILocation(line: 198, column: 9, scope: !2989)
!2995 = distinct !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv", scope: !743, file: !193, line: 1154, type: !796, scopeLine: 1155, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !795, retainedNodes: !2996)
!2996 = !{!2997}
!2997 = !DILocalVariable(name: "this", arg: 1, scope: !2995, type: !2115, flags: DIFlagArtificial | DIFlagObjectPointer)
!2998 = !DILocation(line: 0, scope: !2995)
!2999 = !DILocation(line: 1160, column: 20, scope: !3000)
!3000 = distinct !DILexicalBlock(scope: !2995, file: !193, line: 1157, column: 23)
!3001 = distinct !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv", scope: !495, file: !379, line: 256, type: !528, scopeLine: 257, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !527, retainedNodes: !3002)
!3002 = !{!3003}
!3003 = !DILocalVariable(name: "this", arg: 1, scope: !3001, type: !3004, flags: DIFlagArtificial | DIFlagObjectPointer)
!3004 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !531, size: 32)
!3005 = !DILocation(line: 0, scope: !3001)
!3006 = !DILocation(line: 258, column: 16, scope: !3001)
!3007 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 247, type: !2781, scopeLine: 248, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2784, declaration: !3008, retainedNodes: !3009)
!3008 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 247, type: !2781, scopeLine: 247, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2784)
!3009 = !{!3010, !3011}
!3010 = !DILocalVariable(name: "this", arg: 1, scope: !3007, type: !2286, flags: DIFlagArtificial | DIFlagObjectPointer)
!3011 = !DILocalVariable(name: "idx", arg: 2, scope: !3007, file: !189, line: 247, type: !15)
!3012 = !DILocation(line: 0, scope: !3007)
!3013 = !DILocation(line: 247, column: 91, scope: !3007)
!3014 = !DILocation(line: 249, column: 17, scope: !3007)
!3015 = !DILocation(line: 249, column: 52, scope: !3007)
!3016 = !DILocation(line: 249, column: 37, scope: !3007)
!3017 = !DILocation(line: 249, column: 16, scope: !3007)
!3018 = !DILocation(line: 249, column: 9, scope: !3007)
!3019 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 548, type: !3020, scopeLine: 549, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2784, declaration: !3022, retainedNodes: !3023)
!3020 = !DISubroutineType(types: !3021)
!3021 = !{!743, !253, !15}
!3022 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 548, type: !3020, scopeLine: 548, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2784)
!3023 = !{!3024, !3025, !3026, !3027, !3028, !3029, !3030}
!3024 = !DILocalVariable(name: "this", arg: 1, scope: !3019, type: !2299, flags: DIFlagArtificial | DIFlagObjectPointer)
!3025 = !DILocalVariable(name: "idx", arg: 2, scope: !3019, file: !193, line: 548, type: !15)
!3026 = !DILocalVariable(name: "output_bits", scope: !3019, file: !193, line: 550, type: !101)
!3027 = !DILocalVariable(name: "growth_ratio", scope: !3019, file: !193, line: 551, type: !101)
!3028 = !DILocalVariable(name: "ret", scope: !3019, file: !193, line: 556, type: !743)
!3029 = !DILocalVariable(name: "in_storage_elems", scope: !3019, file: !193, line: 558, type: !101)
!3030 = !DILocalVariable(name: "out_storage_elems", scope: !3019, file: !193, line: 559, type: !101)
!3031 = !DILocation(line: 0, scope: !3019)
!3032 = !DILocation(line: 548, column: 44, scope: !3019)
!3033 = !DILocation(line: 550, column: 9, scope: !3019)
!3034 = !DILocation(line: 550, column: 28, scope: !3019)
!3035 = !DILocation(line: 551, column: 9, scope: !3019)
!3036 = !DILocation(line: 551, column: 28, scope: !3019)
!3037 = !DILocation(line: 556, column: 34, scope: !3019)
!3038 = !DILocation(line: 558, column: 9, scope: !3019)
!3039 = !DILocation(line: 558, column: 28, scope: !3019)
!3040 = !DILocation(line: 559, column: 9, scope: !3019)
!3041 = !DILocation(line: 559, column: 28, scope: !3019)
!3042 = !DILocation(line: 565, column: 19, scope: !3043)
!3043 = distinct !DILexicalBlock(scope: !3044, file: !193, line: 564, column: 77)
!3044 = distinct !DILexicalBlock(scope: !3045, file: !193, line: 564, column: 28)
!3045 = distinct !DILexicalBlock(scope: !3019, file: !193, line: 561, column: 23)
!3046 = !DILocation(line: 565, column: 57, scope: !3043)
!3047 = !DILocation(line: 565, column: 63, scope: !3043)
!3048 = !DILocation(line: 565, column: 17, scope: !3043)
!3049 = !{!2063, !2063, i64 0, i64 64}
!3050 = !{i64 0, i64 4, !1721, i64 4, i64 4, !1721, i64 8, i64 4, !1721, i64 12, i64 4, !1721, i64 16, i64 4, !1721, i64 20, i64 4, !1721, i64 24, i64 4, !1721, i64 28, i64 4, !1721, i64 32, i64 4, !1721, i64 36, i64 4, !1721, i64 40, i64 4, !1721, i64 44, i64 4, !1721, i64 48, i64 4, !1721, i64 52, i64 4, !1721, i64 56, i64 4, !1721, i64 60, i64 4, !1721}
!3051 = !DILocation(line: 565, column: 13, scope: !3043)
!3052 = !DILocation(line: 584, column: 5, scope: !3019)
!3053 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE", scope: !740, file: !189, line: 87, type: !800, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !799, retainedNodes: !3054)
!3054 = !{!3055, !3056}
!3055 = !DILocalVariable(name: "this", arg: 1, scope: !3053, type: !2094, flags: DIFlagArtificial | DIFlagObjectPointer)
!3056 = !DILocalVariable(name: "v", arg: 2, scope: !3053, file: !189, line: 87, type: !803)
!3057 = !DILocation(line: 0, scope: !3053)
!3058 = !DILocation(line: 87, column: 29, scope: !3053)
!3059 = !DILocation(line: 87, column: 44, scope: !3053)
!3060 = !DILocation(line: 87, column: 34, scope: !3053)
!3061 = !DILocation(line: 87, column: 48, scope: !3053)
!3062 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj16EEC2Ev", scope: !743, file: !193, line: 402, type: !766, scopeLine: 404, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !765, retainedNodes: !3063)
!3063 = !{!3064}
!3064 = !DILocalVariable(name: "this", arg: 1, scope: !3062, type: !3065, flags: DIFlagArtificial | DIFlagObjectPointer)
!3065 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !743, size: 32)
!3066 = !DILocation(line: 0, scope: !3062)
!3067 = !DILocation(line: 403, column: 9, scope: !3062)
!3068 = !DILocation(line: 403, column: 14, scope: !3062)
!3069 = !DILocation(line: 405, column: 5, scope: !3062)
!3070 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj", scope: !3071, file: !193, line: 175, type: !3074, scopeLine: 175, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3073, retainedNodes: !3084)
!3071 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vector_set<float, 16U>", scope: !7, file: !193, line: 175, size: 8, flags: DIFlagTypePassByValue, elements: !3072, templateParams: !756, identifier: "_ZTSN3aie6detail10vector_setIfLj16EEE")
!3072 = !{!3073, !3078}
!3073 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj", scope: !3071, file: !193, line: 175, type: !3074, scopeLine: 175, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3074 = !DISubroutineType(types: !3075)
!3075 = !{!486, !3076, !15}
!3076 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3077, size: 32)
!3077 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !211)
!3078 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10vector_setIfLj16EE3runERK7v4floatj", scope: !3071, file: !193, line: 176, type: !3079, scopeLine: 176, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3079 = !DISubroutineType(types: !3080)
!3080 = !{!486, !3081, !15}
!3081 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3082, size: 32)
!3082 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3083)
!3083 = !DIDerivedType(tag: DW_TAG_typedef, name: "v4float", file: !34, line: 615, baseType: !672)
!3084 = !{!3085, !3086}
!3085 = !DILocalVariable(name: "v", arg: 1, scope: !3070, file: !193, line: 175, type: !3076)
!3086 = !DILocalVariable(name: "idx", arg: 2, scope: !3070, file: !193, line: 175, type: !15)
!3087 = !DILocation(line: 175, column: 90, scope: !3070)
!3088 = !DILocation(line: 175, column: 102, scope: !3070)
!3089 = !DILocation(line: 175, column: 131, scope: !3070)
!3090 = !DILocation(line: 175, column: 136, scope: !3070)
!3091 = !DILocation(line: 175, column: 116, scope: !3070)
!3092 = !DILocation(line: 175, column: 109, scope: !3070)
!3093 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float", scope: !743, file: !193, line: 408, type: !770, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !769, retainedNodes: !3094)
!3094 = !{!3095, !3096}
!3095 = !DILocalVariable(name: "this", arg: 1, scope: !3093, type: !3065, flags: DIFlagArtificial | DIFlagObjectPointer)
!3096 = !DILocalVariable(name: "data", arg: 2, scope: !3093, file: !193, line: 408, type: !772)
!3097 = !DILocation(line: 0, scope: !3093)
!3098 = !DILocation(line: 408, column: 27, scope: !3093)
!3099 = !DILocation(line: 409, column: 9, scope: !3093)
!3100 = !DILocation(line: 409, column: 14, scope: !3093)
!3101 = !DILocation(line: 412, column: 5, scope: !3093)
!3102 = distinct !DISubprogram(name: "current", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv", scope: !2680, file: !2634, line: 482, type: !2683, scopeLine: 483, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2688, retainedNodes: !3103)
!3103 = !{!3104}
!3104 = !DILocalVariable(name: "this", arg: 1, scope: !3102, type: !2797, flags: DIFlagArtificial | DIFlagObjectPointer)
!3105 = !DILocation(line: 0, scope: !3102)
!3106 = !DILocation(line: 484, column: 9, scope: !3102)
!3107 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv", scope: !374, file: !375, line: 248, type: !3108, scopeLine: 249, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2784, declaration: !3110, retainedNodes: !3111)
!3108 = !DISubroutineType(types: !3109)
!3109 = !{!492, !456}
!3110 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv", scope: !374, file: !375, line: 248, type: !3108, scopeLine: 248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2784)
!3111 = !{!3112}
!3112 = !DILocalVariable(name: "this", arg: 1, scope: !3107, type: !2807, flags: DIFlagArtificial | DIFlagObjectPointer)
!3113 = !DILocation(line: 0, scope: !3107)
!3114 = !DILocation(line: 250, column: 45, scope: !3107)
!3115 = !DILocation(line: 250, column: 65, scope: !3107)
!3116 = !DILocation(line: 250, column: 16, scope: !3107)
!3117 = !DILocation(line: 250, column: 9, scope: !3107)
!3118 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv", scope: !378, file: !379, line: 287, type: !3119, scopeLine: 288, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2784, declaration: !3121, retainedNodes: !3122)
!3119 = !DISubroutineType(types: !3120)
!3120 = !{!495, !420}
!3121 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv", scope: !378, file: !379, line: 287, type: !3119, scopeLine: 287, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2784)
!3122 = !{!3123, !3125, !3126, !3127, !3128}
!3123 = !DILocalVariable(name: "this", arg: 1, scope: !3118, type: !3124, flags: DIFlagArtificial | DIFlagObjectPointer)
!3124 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !421, size: 32)
!3125 = !DILocalVariable(name: "in_num_subaccums", scope: !3118, file: !379, line: 293, type: !101)
!3126 = !DILocalVariable(name: "out_num_subaccums", scope: !3118, file: !379, line: 294, type: !101)
!3127 = !DILocalVariable(name: "ret", scope: !3118, file: !379, line: 295, type: !495)
!3128 = !DILocalVariable(name: "growth_ratio", scope: !3118, file: !379, line: 298, type: !101)
!3129 = !DILocation(line: 0, scope: !3118)
!3130 = !DILocation(line: 293, column: 9, scope: !3118)
!3131 = !DILocation(line: 293, column: 28, scope: !3118)
!3132 = !DILocation(line: 294, column: 9, scope: !3118)
!3133 = !DILocation(line: 294, column: 28, scope: !3118)
!3134 = !DILocation(line: 295, column: 46, scope: !3118)
!3135 = !DILocation(line: 298, column: 9, scope: !3118)
!3136 = !DILocation(line: 298, column: 28, scope: !3118)
!3137 = !DILocation(line: 310, column: 23, scope: !3138)
!3138 = distinct !DILexicalBlock(scope: !3139, file: !379, line: 309, column: 27)
!3139 = distinct !DILexicalBlock(scope: !3140, file: !379, line: 308, column: 77)
!3140 = distinct !DILexicalBlock(scope: !3141, file: !379, line: 308, column: 28)
!3141 = distinct !DILexicalBlock(scope: !3118, file: !379, line: 305, column: 23)
!3142 = !DILocation(line: 310, column: 32, scope: !3138)
!3143 = !DILocation(line: 310, column: 38, scope: !3138)
!3144 = !{!1686, !1687, i64 0, i64 32}
!3145 = !DILocation(line: 310, column: 21, scope: !3138)
!3146 = !{!2740, !2740, i64 0, i64 64}
!3147 = !DILocation(line: 310, column: 17, scope: !3138)
!3148 = !DILocation(line: 326, column: 5, scope: !3118)
!3149 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE", scope: !492, file: !375, line: 59, type: !534, scopeLine: 59, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !533, retainedNodes: !3150)
!3150 = !{!3151, !3152}
!3151 = !DILocalVariable(name: "this", arg: 1, scope: !3149, type: !2817, flags: DIFlagArtificial | DIFlagObjectPointer)
!3152 = !DILocalVariable(name: "a", arg: 2, scope: !3149, file: !375, line: 59, type: !537)
!3153 = !DILocation(line: 0, scope: !3149)
!3154 = !DILocation(line: 59, column: 37, scope: !3149)
!3155 = !DILocation(line: 59, column: 52, scope: !3149)
!3156 = !DILocation(line: 59, column: 42, scope: !3149)
!3157 = !DILocation(line: 59, column: 56, scope: !3149)
!3158 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev", scope: !495, file: !379, line: 229, type: !521, scopeLine: 231, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !520, retainedNodes: !3159)
!3159 = !{!3160}
!3160 = !DILocalVariable(name: "this", arg: 1, scope: !3158, type: !3161, flags: DIFlagArtificial | DIFlagObjectPointer)
!3161 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !495, size: 32)
!3162 = !DILocation(line: 0, scope: !3158)
!3163 = !DILocation(line: 230, column: 9, scope: !3158)
!3164 = !DILocation(line: 230, column: 14, scope: !3158)
!3165 = !DILocation(line: 232, column: 5, scope: !3158)
!3166 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat", scope: !495, file: !379, line: 242, type: !525, scopeLine: 244, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !524, retainedNodes: !3167)
!3167 = !{!3168, !3169}
!3168 = !DILocalVariable(name: "this", arg: 1, scope: !3166, type: !3161, flags: DIFlagArtificial | DIFlagObjectPointer)
!3169 = !DILocalVariable(name: "data", arg: 2, scope: !3166, file: !379, line: 242, type: !500)
!3170 = !DILocation(line: 0, scope: !3166)
!3171 = !DILocation(line: 242, column: 26, scope: !3166)
!3172 = !DILocation(line: 243, column: 9, scope: !3166)
!3173 = !DILocation(line: 243, column: 14, scope: !3166)
!3174 = !DILocation(line: 246, column: 5, scope: !3166)
!3175 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv", scope: !503, file: !386, line: 167, type: !506, scopeLine: 167, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !505, retainedNodes: !137)
!3176 = !DILocation(line: 167, column: 147, scope: !3175)
!3177 = !DILocation(line: 167, column: 140, scope: !3175)
!3178 = distinct !DISubprogram(name: "insert<8U, 32U>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE", scope: !378, file: !379, line: 463, type: !3179, scopeLine: 464, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3184, declaration: !3183, retainedNodes: !3186)
!3179 = !DISubroutineType(types: !3180)
!3180 = !{!3181, !413, !15, !3182}
!3181 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !378, size: 32)
!3182 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !421, size: 32)
!3183 = !DISubprogram(name: "insert<8U, 32U>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE", scope: !378, file: !379, line: 463, type: !3179, scopeLine: 463, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !3184)
!3184 = !{!2829, !3185}
!3185 = !DITemplateValueParameter(name: "Bits2", type: !15, value: i32 32)
!3186 = !{!3187, !3188, !3189, !3190, !3191}
!3187 = !DILocalVariable(name: "this", arg: 1, scope: !3178, type: !2213, flags: DIFlagArtificial | DIFlagObjectPointer)
!3188 = !DILocalVariable(name: "idx", arg: 2, scope: !3178, file: !379, line: 463, type: !15)
!3189 = !DILocalVariable(name: "acc", arg: 3, scope: !3178, file: !379, line: 463, type: !3182)
!3190 = !DILocalVariable(name: "in_num_subaccums", scope: !3178, file: !379, line: 468, type: !101)
!3191 = !DILocalVariable(name: "num_subaccums", scope: !3178, file: !379, line: 469, type: !101)
!3192 = !DILocation(line: 0, scope: !3178)
!3193 = !DILocation(line: 463, column: 33, scope: !3178)
!3194 = !DILocation(line: 463, column: 79, scope: !3178)
!3195 = !DILocation(line: 468, column: 9, scope: !3178)
!3196 = !DILocation(line: 468, column: 28, scope: !3178)
!3197 = !DILocation(line: 469, column: 9, scope: !3178)
!3198 = !DILocation(line: 469, column: 31, scope: !3178)
!3199 = !DILocation(line: 474, column: 20, scope: !3200)
!3200 = distinct !DILexicalBlock(scope: !3201, file: !379, line: 473, column: 41)
!3201 = distinct !DILexicalBlock(scope: !3178, file: !379, line: 473, column: 23)
!3202 = !DILocation(line: 474, column: 24, scope: !3200)
!3203 = !DILocation(line: 474, column: 13, scope: !3200)
!3204 = !DILocation(line: 474, column: 18, scope: !3200)
!3205 = !DILocation(line: 552, column: 5, scope: !3178)
!3206 = !DILocation(line: 476, column: 13, scope: !3200)
!3207 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj", scope: !495, file: !379, line: 367, type: !3208, scopeLine: 368, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2079, declaration: !3210, retainedNodes: !3211)
!3208 = !DISubroutineType(types: !3209)
!3209 = !{!378, !530, !15}
!3210 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj", scope: !495, file: !379, line: 367, type: !3208, scopeLine: 367, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2079)
!3211 = !{!3212, !3213, !3214, !3215, !3216, !3217, !3220, !3221, !3222}
!3212 = !DILocalVariable(name: "this", arg: 1, scope: !3207, type: !3004, flags: DIFlagArtificial | DIFlagObjectPointer)
!3213 = !DILocalVariable(name: "idx", arg: 2, scope: !3207, file: !379, line: 367, type: !15)
!3214 = !DILocalVariable(name: "fpacc_128b", scope: !3207, file: !379, line: 374, type: !198)
!3215 = !DILocalVariable(name: "num_subaccums", scope: !3207, file: !379, line: 380, type: !101)
!3216 = !DILocalVariable(name: "num_subaccums_out", scope: !3207, file: !379, line: 381, type: !101)
!3217 = !DILocalVariable(name: "elems_per_subaccum", scope: !3218, file: !379, line: 387, type: !101)
!3218 = distinct !DILexicalBlock(scope: !3219, file: !379, line: 386, column: 14)
!3219 = distinct !DILexicalBlock(scope: !3207, file: !379, line: 383, column: 23)
!3220 = !DILocalVariable(name: "out_elems_per_subaccum", scope: !3218, file: !379, line: 388, type: !101)
!3221 = !DILocalVariable(name: "ratio", scope: !3218, file: !379, line: 389, type: !101)
!3222 = !DILocalVariable(name: "ret", scope: !3218, file: !379, line: 391, type: !378)
!3223 = !DILocation(line: 0, scope: !3207)
!3224 = !DILocation(line: 367, column: 59, scope: !3207)
!3225 = !DILocation(line: 374, column: 9, scope: !3207)
!3226 = !DILocation(line: 374, column: 24, scope: !3207)
!3227 = !DILocation(line: 380, column: 9, scope: !3207)
!3228 = !DILocation(line: 380, column: 28, scope: !3207)
!3229 = !DILocation(line: 381, column: 9, scope: !3207)
!3230 = !DILocation(line: 381, column: 28, scope: !3207)
!3231 = !DILocation(line: 387, column: 13, scope: !3218)
!3232 = !DILocation(line: 387, column: 32, scope: !3218)
!3233 = !DILocation(line: 388, column: 13, scope: !3218)
!3234 = !DILocation(line: 388, column: 32, scope: !3218)
!3235 = !DILocation(line: 389, column: 13, scope: !3218)
!3236 = !DILocation(line: 389, column: 32, scope: !3218)
!3237 = !DILocation(line: 391, column: 13, scope: !3218)
!3238 = !DILocation(line: 391, column: 50, scope: !3218)
!3239 = !DILocation(line: 411, column: 31, scope: !3240)
!3240 = distinct !DILexicalBlock(scope: !3241, file: !379, line: 410, column: 26)
!3241 = distinct !DILexicalBlock(scope: !3242, file: !379, line: 399, column: 35)
!3242 = distinct !DILexicalBlock(scope: !3243, file: !379, line: 398, column: 56)
!3243 = distinct !DILexicalBlock(scope: !3244, file: !379, line: 398, column: 36)
!3244 = distinct !DILexicalBlock(scope: !3245, file: !379, line: 394, column: 31)
!3245 = distinct !DILexicalBlock(scope: !3246, file: !379, line: 393, column: 51)
!3246 = distinct !DILexicalBlock(scope: !3218, file: !379, line: 393, column: 27)
!3247 = !DILocation(line: 411, column: 55, scope: !3240)
!3248 = !DILocation(line: 411, column: 61, scope: !3240)
!3249 = !DILocation(line: 411, column: 29, scope: !3240)
!3250 = !{!1686, !1686, i64 0, i64 32}
!3251 = !DILocation(line: 411, column: 25, scope: !3240)
!3252 = !DILocation(line: 414, column: 28, scope: !3242)
!3253 = !DILocation(line: 434, column: 9, scope: !3219)
!3254 = !DILocation(line: 435, column: 5, scope: !3207)
!3255 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE", scope: !374, file: !375, line: 59, type: !425, scopeLine: 59, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !424, retainedNodes: !3256)
!3256 = !{!3257, !3258}
!3257 = !DILocalVariable(name: "this", arg: 1, scope: !3255, type: !1828, flags: DIFlagArtificial | DIFlagObjectPointer)
!3258 = !DILocalVariable(name: "a", arg: 2, scope: !3255, file: !375, line: 59, type: !428)
!3259 = !DILocation(line: 0, scope: !3255)
!3260 = !DILocation(line: 59, column: 37, scope: !3255)
!3261 = !DILocation(line: 59, column: 52, scope: !3255)
!3262 = !DILocation(line: 59, column: 42, scope: !3255)
!3263 = !DILocation(line: 59, column: 56, scope: !3255)
!3264 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev", scope: !378, file: !379, line: 229, type: !411, scopeLine: 231, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !410, retainedNodes: !3265)
!3265 = !{!3266}
!3266 = !DILocalVariable(name: "this", arg: 1, scope: !3264, type: !2213, flags: DIFlagArtificial | DIFlagObjectPointer)
!3267 = !DILocation(line: 0, scope: !3264)
!3268 = !DILocation(line: 230, column: 9, scope: !3264)
!3269 = !DILocation(line: 230, column: 14, scope: !3264)
!3270 = !DILocation(line: 232, column: 5, scope: !3264)
!3271 = distinct !DISubprogram(name: "accum_extract<8U, v16accfloat>", linkageName: "_ZN3aie6detailL13accum_extractILj8E11v16accfloatEEDaRKT0_j", scope: !7, file: !379, line: 123, type: !3272, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3279, retainedNodes: !3276)
!3272 = !DISubroutineType(types: !3273)
!3273 = !{!396, !3274, !15}
!3274 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3275, size: 32)
!3275 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !488)
!3276 = !{!3277, !3278}
!3277 = !DILocalVariable(name: "acc", arg: 1, scope: !3271, file: !379, line: 123, type: !3274)
!3278 = !DILocalVariable(name: "idx", arg: 2, scope: !3271, file: !379, line: 123, type: !15)
!3279 = !{!210, !3280}
!3280 = !DITemplateTypeParameter(name: "T", type: !489)
!3281 = !DILocation(line: 123, column: 88, scope: !3271)
!3282 = !DILocation(line: 123, column: 102, scope: !3271)
!3283 = !DILocation(line: 123, column: 137, scope: !3271)
!3284 = !DILocation(line: 123, column: 142, scope: !3271)
!3285 = !DILocation(line: 123, column: 116, scope: !3271)
!3286 = !DILocation(line: 123, column: 109, scope: !3271)
!3287 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat", scope: !378, file: !379, line: 242, type: !415, scopeLine: 244, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !414, retainedNodes: !3288)
!3288 = !{!3289, !3290}
!3289 = !DILocalVariable(name: "this", arg: 1, scope: !3287, type: !2213, flags: DIFlagArtificial | DIFlagObjectPointer)
!3290 = !DILocalVariable(name: "data", arg: 2, scope: !3287, file: !379, line: 242, type: !384)
!3291 = !DILocation(line: 0, scope: !3287)
!3292 = !DILocation(line: 242, column: 26, scope: !3287)
!3293 = !DILocation(line: 243, column: 9, scope: !3287)
!3294 = !DILocation(line: 243, column: 14, scope: !3287)
!3295 = !DILocation(line: 246, column: 5, scope: !3287)
!3296 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf", scope: !3297, file: !2027, line: 122, type: !3300, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3299, retainedNodes: !3303)
!3297 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "broadcast_bits_impl<32U, float, 8U>", scope: !7, file: !2027, line: 117, size: 8, flags: DIFlagTypePassByValue, elements: !3298, templateParams: !2021, identifier: "_ZTSN3aie6detail19broadcast_bits_implILj32EfLj8EEE")
!3298 = !{!3299}
!3299 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf", scope: !3297, file: !2027, line: 122, type: !3300, scopeLine: 122, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3300 = !DISubroutineType(types: !3301)
!3301 = !{!3302, !2626}
!3302 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !3297, file: !2027, line: 119, baseType: !188)
!3303 = !{!3304, !3305, !3306}
!3304 = !DILocalVariable(name: "a", arg: 1, scope: !3296, file: !2027, line: 122, type: !2626)
!3305 = !DILocalVariable(name: "native_broadcast_elems", scope: !3296, file: !2027, line: 124, type: !101)
!3306 = !DILocalVariable(name: "ret", scope: !3296, file: !2027, line: 127, type: !3302)
!3307 = !DILocation(line: 122, column: 37, scope: !3296)
!3308 = !DILocation(line: 124, column: 9, scope: !3296)
!3309 = !DILocation(line: 124, column: 28, scope: !3296)
!3310 = !DILocation(line: 127, column: 21, scope: !3296)
!3311 = !DILocation(line: 130, column: 19, scope: !3312)
!3312 = distinct !DILexicalBlock(scope: !3313, file: !2027, line: 129, column: 49)
!3313 = distinct !DILexicalBlock(scope: !3296, file: !2027, line: 129, column: 23)
!3314 = !DILocation(line: 130, column: 46, scope: !3312)
!3315 = !DILocation(line: 130, column: 58, scope: !3312)
!3316 = !DILocation(line: 130, column: 17, scope: !3312)
!3317 = !DILocation(line: 130, column: 13, scope: !3312)
!3318 = !DILocation(line: 156, column: 5, scope: !3296)
!3319 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf", scope: !3320, file: !2027, line: 122, type: !3323, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3322, retainedNodes: !3326)
!3320 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "broadcast_bits_impl<32U, float, 16U>", scope: !7, file: !2027, line: 117, size: 8, flags: DIFlagTypePassByValue, elements: !3321, templateParams: !2054, identifier: "_ZTSN3aie6detail19broadcast_bits_implILj32EfLj16EEE")
!3321 = !{!3322}
!3322 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf", scope: !3320, file: !2027, line: 122, type: !3323, scopeLine: 122, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3323 = !DISubroutineType(types: !3324)
!3324 = !{!3325, !2626}
!3325 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !3320, file: !2027, line: 119, baseType: !740)
!3326 = !{!3327, !3328, !3329}
!3327 = !DILocalVariable(name: "a", arg: 1, scope: !3319, file: !2027, line: 122, type: !2626)
!3328 = !DILocalVariable(name: "native_broadcast_elems", scope: !3319, file: !2027, line: 124, type: !101)
!3329 = !DILocalVariable(name: "ret", scope: !3319, file: !2027, line: 127, type: !3325)
!3330 = !DILocation(line: 122, column: 37, scope: !3319)
!3331 = !DILocation(line: 124, column: 9, scope: !3319)
!3332 = !DILocation(line: 124, column: 28, scope: !3319)
!3333 = !DILocation(line: 127, column: 21, scope: !3319)
!3334 = !DILocation(line: 141, column: 47, scope: !3335)
!3335 = distinct !DILexicalBlock(scope: !3336, file: !2027, line: 140, column: 32)
!3336 = distinct !DILexicalBlock(scope: !3337, file: !2027, line: 138, column: 27)
!3337 = distinct !DILexicalBlock(scope: !3338, file: !2027, line: 134, column: 27)
!3338 = distinct !DILexicalBlock(scope: !3339, file: !2027, line: 132, column: 41)
!3339 = distinct !DILexicalBlock(scope: !3340, file: !2027, line: 132, column: 28)
!3340 = distinct !DILexicalBlock(scope: !3319, file: !2027, line: 129, column: 23)
!3341 = !DILocation(line: 141, column: 23, scope: !3335)
!3342 = !DILocation(line: 141, column: 21, scope: !3335)
!3343 = !DILocation(line: 156, column: 5, scope: !3319)
!3344 = distinct !DISubprogram(name: "get", linkageName: "_ZNK3aie21vector_elem_const_refIfLj8EE3getEv", scope: !308, file: !309, line: 44, type: !355, scopeLine: 45, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !354, retainedNodes: !3345)
!3345 = !{!3346}
!3346 = !DILocalVariable(name: "this", arg: 1, scope: !3344, type: !2586, flags: DIFlagArtificial | DIFlagObjectPointer)
!3347 = !DILocation(line: 0, scope: !3344)
!3348 = !DILocation(line: 46, column: 16, scope: !3344)
!3349 = !{!2427, !1513, i64 0, i64 4}
!3350 = !DILocation(line: 46, column: 27, scope: !3344)
!3351 = !DILocation(line: 46, column: 23, scope: !3344)
!3352 = !DILocation(line: 46, column: 9, scope: !3344)
!3353 = distinct !DISubprogram(name: "get", linkageName: "_ZNK3aie6vectorIfLj8EE3getEj", scope: !188, file: !189, line: 282, type: !303, scopeLine: 283, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !302, retainedNodes: !3354)
!3354 = !{!3355, !3356}
!3355 = !DILocalVariable(name: "this", arg: 1, scope: !3353, type: !2286, flags: DIFlagArtificial | DIFlagObjectPointer)
!3356 = !DILocalVariable(name: "idx", arg: 2, scope: !3353, file: !189, line: 282, type: !15)
!3357 = !DILocation(line: 0, scope: !3353)
!3358 = !DILocation(line: 282, column: 29, scope: !3353)
!3359 = !DILocation(line: 284, column: 31, scope: !3353)
!3360 = !DILocation(line: 284, column: 27, scope: !3353)
!3361 = !DILocation(line: 284, column: 9, scope: !3353)
!3362 = distinct !DISubprogram(name: "get", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE3getEj", scope: !192, file: !193, line: 703, type: !251, scopeLine: 704, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !250, retainedNodes: !3363)
!3363 = !{!3364, !3365}
!3364 = !DILocalVariable(name: "this", arg: 1, scope: !3362, type: !2299, flags: DIFlagArtificial | DIFlagObjectPointer)
!3365 = !DILocalVariable(name: "idx", arg: 2, scope: !3362, file: !193, line: 703, type: !15)
!3366 = !DILocation(line: 0, scope: !3362)
!3367 = !DILocation(line: 703, column: 29, scope: !3362)
!3368 = !DILocation(line: 705, column: 9, scope: !3362)
!3369 = !DILocation(line: 705, column: 9, scope: !3370)
!3370 = distinct !DILexicalBlock(scope: !3371, file: !193, line: 705, column: 9)
!3371 = distinct !DILexicalBlock(scope: !3362, file: !193, line: 705, column: 9)
!3372 = !DILocation(line: 705, column: 9, scope: !3371)
!3373 = !DILocation(line: 705, column: 9, scope: !3374)
!3374 = distinct !DILexicalBlock(scope: !3370, file: !193, line: 705, column: 9)
!3375 = !DILocation(line: 705, column: 9, scope: !3376)
!3376 = distinct !DILexicalBlock(scope: !3377, file: !193, line: 705, column: 9)
!3377 = distinct !DILexicalBlock(scope: !3374, file: !193, line: 705, column: 9)
!3378 = !DILocation(line: 705, column: 9, scope: !3377)
!3379 = !DILocation(line: 705, column: 9, scope: !3380)
!3380 = distinct !DILexicalBlock(scope: !3370, file: !193, line: 705, column: 9)
!3381 = !DILocation(line: 748, column: 79, scope: !3382)
!3382 = distinct !DILexicalBlock(scope: !3383, file: !193, line: 747, column: 47)
!3383 = distinct !DILexicalBlock(scope: !3384, file: !193, line: 747, column: 32)
!3384 = distinct !DILexicalBlock(scope: !3385, file: !193, line: 744, column: 27)
!3385 = distinct !DILexicalBlock(scope: !3386, file: !193, line: 743, column: 14)
!3386 = distinct !DILexicalBlock(scope: !3362, file: !193, line: 707, column: 23)
!3387 = !DILocation(line: 748, column: 39, scope: !3382)
!3388 = !DILocation(line: 748, column: 89, scope: !3382)
!3389 = !DILocation(line: 748, column: 24, scope: !3382)
!3390 = !DILocation(line: 748, column: 17, scope: !3382)
!3391 = !{!"2nd parameter of extract intrinsic should be const in [0,63]"}
!3392 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_", scope: !971, file: !45, line: 454, type: !3393, scopeLine: 454, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3396, retainedNodes: !3397)
!3393 = !DISubroutineType(types: !3394)
!3394 = !{null, !3395, !954}
!3395 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !971, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3396 = !DISubprogram(name: "unary_op_common", scope: !971, type: !3393, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3397 = !{!3398, !3400}
!3398 = !DILocalVariable(name: "this", arg: 1, scope: !3392, type: !3399, flags: DIFlagArtificial | DIFlagObjectPointer)
!3399 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !971, size: 32)
!3400 = !DILocalVariable(arg: 2, scope: !3392, type: !954, flags: DIFlagArtificial)
!3401 = !DILocation(line: 0, scope: !3392)
!3402 = !DILocation(line: 454, column: 1, scope: !3392)
!3403 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_", scope: !950, file: !45, line: 424, type: !966, scopeLine: 426, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !965, retainedNodes: !3404)
!3404 = !{!3405, !3407}
!3405 = !DILocalVariable(name: "this", arg: 1, scope: !3403, type: !3406, flags: DIFlagArtificial | DIFlagObjectPointer)
!3406 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !950, size: 32)
!3407 = !DILocalVariable(name: "parent", arg: 2, scope: !3403, file: !45, line: 424, type: !954)
!3408 = !DILocation(line: 0, scope: !3403)
!3409 = !DILocation(line: 424, column: 50, scope: !3403)
!3410 = !DILocation(line: 425, column: 9, scope: !3403)
!3411 = !DILocation(line: 425, column: 17, scope: !3403)
!3412 = !DILocation(line: 427, column: 5, scope: !3403)
!3413 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_", scope: !984, file: !45, line: 454, type: !3414, scopeLine: 454, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3417, retainedNodes: !3418)
!3414 = !DISubroutineType(types: !3415)
!3415 = !{null, !3416, !932}
!3416 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !984, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3417 = !DISubprogram(name: "unary_op_common", scope: !984, type: !3414, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3418 = !{!3419, !3421}
!3419 = !DILocalVariable(name: "this", arg: 1, scope: !3413, type: !3420, flags: DIFlagArtificial | DIFlagObjectPointer)
!3420 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !984, size: 32)
!3421 = !DILocalVariable(arg: 2, scope: !3413, type: !932, flags: DIFlagArtificial)
!3422 = !DILocation(line: 0, scope: !3413)
!3423 = !DILocation(line: 454, column: 1, scope: !3413)
!3424 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_", scope: !928, file: !45, line: 424, type: !944, scopeLine: 426, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !943, retainedNodes: !3425)
!3425 = !{!3426, !3428}
!3426 = !DILocalVariable(name: "this", arg: 1, scope: !3424, type: !3427, flags: DIFlagArtificial | DIFlagObjectPointer)
!3427 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !928, size: 32)
!3428 = !DILocalVariable(name: "parent", arg: 2, scope: !3424, file: !45, line: 424, type: !932)
!3429 = !DILocation(line: 0, scope: !3424)
!3430 = !DILocation(line: 424, column: 50, scope: !3424)
!3431 = !DILocation(line: 425, column: 9, scope: !3424)
!3432 = !DILocation(line: 427, column: 5, scope: !3424)
!3433 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_", scope: !997, file: !45, line: 459, type: !3434, scopeLine: 459, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3437, retainedNodes: !3438)
!3434 = !DISubroutineType(types: !3435)
!3435 = !{null, !3436, !909}
!3436 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !997, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3437 = !DISubprogram(name: "unary_op_common", scope: !997, type: !3434, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3438 = !{!3439, !3441}
!3439 = !DILocalVariable(name: "this", arg: 1, scope: !3433, type: !3440, flags: DIFlagArtificial | DIFlagObjectPointer)
!3440 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !997, size: 32)
!3441 = !DILocalVariable(arg: 2, scope: !3433, type: !909, flags: DIFlagArtificial)
!3442 = !DILocation(line: 0, scope: !3433)
!3443 = !DILocation(line: 459, column: 1, scope: !3433)
!3444 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_", scope: !904, file: !45, line: 424, type: !922, scopeLine: 426, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !921, retainedNodes: !3445)
!3445 = !{!3446, !3448}
!3446 = !DILocalVariable(name: "this", arg: 1, scope: !3444, type: !3447, flags: DIFlagArtificial | DIFlagObjectPointer)
!3447 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !904, size: 32)
!3448 = !DILocalVariable(name: "parent", arg: 2, scope: !3444, file: !45, line: 424, type: !909)
!3449 = !DILocation(line: 0, scope: !3444)
!3450 = !DILocation(line: 424, column: 50, scope: !3444)
!3451 = !DILocation(line: 425, column: 9, scope: !3444)
!3452 = !DILocation(line: 425, column: 17, scope: !3444)
!3453 = !DILocation(line: 427, column: 5, scope: !3444)
!3454 = distinct !DISubprogram(name: "elem_ref", linkageName: "_ZN3aie6vectorIfLj8EE8elem_refEj", scope: !188, file: !189, line: 336, type: !364, scopeLine: 337, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !368, retainedNodes: !3455)
!3455 = !{!3456, !3457}
!3456 = !DILocalVariable(name: "this", arg: 1, scope: !3454, type: !1821, flags: DIFlagArtificial | DIFlagObjectPointer)
!3457 = !DILocalVariable(name: "idx", arg: 2, scope: !3454, file: !189, line: 336, type: !15)
!3458 = !DILocation(line: 0, scope: !3454)
!3459 = !DILocation(line: 336, column: 81, scope: !3454)
!3460 = !DILocation(line: 338, column: 9, scope: !3454)
!3461 = !DILocation(line: 338, column: 9, scope: !3462)
!3462 = distinct !DILexicalBlock(scope: !3463, file: !189, line: 338, column: 9)
!3463 = distinct !DILexicalBlock(scope: !3454, file: !189, line: 338, column: 9)
!3464 = !DILocation(line: 338, column: 9, scope: !3463)
!3465 = !DILocation(line: 338, column: 9, scope: !3466)
!3466 = distinct !DILexicalBlock(scope: !3462, file: !189, line: 338, column: 9)
!3467 = !DILocation(line: 338, column: 9, scope: !3468)
!3468 = distinct !DILexicalBlock(scope: !3469, file: !189, line: 338, column: 9)
!3469 = distinct !DILexicalBlock(scope: !3466, file: !189, line: 338, column: 9)
!3470 = !DILocation(line: 338, column: 9, scope: !3469)
!3471 = !DILocation(line: 338, column: 9, scope: !3472)
!3472 = distinct !DILexicalBlock(scope: !3462, file: !189, line: 338, column: 9)
!3473 = !DILocation(line: 339, column: 24, scope: !3454)
!3474 = !DILocation(line: 339, column: 16, scope: !3454)
!3475 = !DILocation(line: 339, column: 9, scope: !3454)
!3476 = distinct !DISubprogram(name: "vector_elem_ref", linkageName: "_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj", scope: !322, file: !309, line: 241, type: !350, scopeLine: 244, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !349, retainedNodes: !3477)
!3477 = !{!3478, !3480, !3481}
!3478 = !DILocalVariable(name: "this", arg: 1, scope: !3476, type: !3479, flags: DIFlagArtificial | DIFlagObjectPointer)
!3479 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !322, size: 32)
!3480 = !DILocalVariable(name: "v", arg: 2, scope: !3476, file: !309, line: 241, type: !325)
!3481 = !DILocalVariable(name: "idx", arg: 3, scope: !3476, file: !309, line: 241, type: !15)
!3482 = !DILocation(line: 0, scope: !3476)
!3483 = !DILocation(line: 241, column: 44, scope: !3476)
!3484 = !DILocation(line: 241, column: 56, scope: !3476)
!3485 = !DILocation(line: 242, column: 9, scope: !3476)
!3486 = !DILocation(line: 242, column: 16, scope: !3476)
!3487 = !DILocation(line: 243, column: 9, scope: !3476)
!3488 = !DILocation(line: 243, column: 16, scope: !3476)
!3489 = !DILocation(line: 245, column: 5, scope: !3476)
!3490 = distinct !DISubprogram(name: "writeincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE", scope: !3491, file: !1904, line: 193, type: !3506, scopeLine: 194, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3505, retainedNodes: !3518)
!3491 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cascade_stream_helper<accfloat, 8U>", scope: !3492, file: !1904, line: 151, size: 8, flags: DIFlagTypePassByValue, elements: !3493, templateParams: !3516, identifier: "_ZTSN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EEE")
!3492 = !DINamespace(name: "adf", scope: !7)
!3493 = !{!3494, !3495, !3496, !3497, !3498, !3499, !3505, !3508, !3513}
!3494 = !DIDerivedType(tag: DW_TAG_member, name: "cascade_width", scope: !3491, file: !1904, line: 179, baseType: !101, flags: DIFlagStaticMember, extraData: i32 512)
!3495 = !DIDerivedType(tag: DW_TAG_member, name: "num_ops", scope: !3491, file: !1904, line: 180, baseType: !101, flags: DIFlagStaticMember, extraData: i32 1)
!3496 = !DIDerivedType(tag: DW_TAG_member, name: "elems_per_op", scope: !3491, file: !1904, line: 181, baseType: !101, flags: DIFlagStaticMember, extraData: i32 8)
!3497 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems_per_op", scope: !3491, file: !1904, line: 182, baseType: !101, flags: DIFlagStaticMember, extraData: i32 16)
!3498 = !DISubprogram(name: "compute_native_elems_per_op", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE27compute_native_elems_per_opEv", scope: !3491, file: !1904, line: 169, type: !214, scopeLine: 169, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3499 = !DISubprogram(name: "writeincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP13output_streamIS3_ENS_5accumIS3_Lj8EEE", scope: !3491, file: !1904, line: 186, type: !3500, scopeLine: 186, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3500 = !DISubroutineType(types: !3501)
!3501 = !{null, !3502, !3504}
!3502 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3503, size: 32)
!3503 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "output_stream<accfloat>", file: !121, line: 150, size: 32, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS13output_streamI8accfloatE")
!3504 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3491, file: !1904, line: 154, baseType: !374)
!3505 = !DISubprogram(name: "writeincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE", scope: !3491, file: !1904, line: 193, type: !3506, scopeLine: 193, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3506 = !DISubroutineType(types: !3507)
!3507 = !{null, !144, !3504}
!3508 = !DISubprogram(name: "readincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP12input_streamIS3_E", scope: !3491, file: !1904, line: 208, type: !3509, scopeLine: 208, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3509 = !DISubroutineType(types: !3510)
!3510 = !{!3504, !3511}
!3511 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3512, size: 32)
!3512 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "input_stream<accfloat>", file: !121, line: 144, size: 32, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS12input_streamI8accfloatE")
!3513 = !DISubprogram(name: "readincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE", scope: !3491, file: !1904, line: 215, type: !3514, scopeLine: 215, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3514 = !DISubroutineType(types: !3515)
!3515 = !{!3504, !124}
!3516 = !{!3517, !353}
!3517 = !DITemplateTypeParameter(name: "AccumTag", type: !459)
!3518 = !{!3519, !3520, !3521}
!3519 = !DILocalVariable(name: "_w", arg: 1, scope: !3490, file: !1904, line: 193, type: !144)
!3520 = !DILocalVariable(name: "value", arg: 2, scope: !3490, file: !1904, line: 193, type: !3504)
!3521 = !DILocalVariable(name: "w", scope: !3490, file: !1904, line: 195, type: !144)
!3522 = !DILocation(line: 193, column: 53, scope: !3490)
!3523 = !DILocation(line: 193, column: 62, scope: !3490)
!3524 = !DILocation(line: 195, column: 9, scope: !3490)
!3525 = !DILocation(line: 195, column: 37, scope: !3490)
!3526 = !DILocation(line: 195, column: 72, scope: !3490)
!3527 = !DILocation(line: 198, column: 25, scope: !3528)
!3528 = distinct !DILexicalBlock(scope: !3529, file: !1904, line: 197, column: 59)
!3529 = distinct !DILexicalBlock(scope: !3490, file: !1904, line: 197, column: 23)
!3530 = !DILocation(line: 198, column: 28, scope: !3528)
!3531 = !DILocation(line: 198, column: 43, scope: !3528)
!3532 = !DILocation(line: 198, column: 13, scope: !3528)
!3533 = !DILocation(line: 205, column: 5, scope: !3490)
!3534 = distinct !DISubprogram(name: "writeincr", linkageName: "_ZL9writeincrP14output_cascadeI8accfloatvE11v16accfloat", scope: !3535, file: !3535, line: 1035, type: !3536, scopeLine: 1035, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !3538)
!3535 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/stream/me/accessors.h", directory: "")
!3536 = !DISubroutineType(types: !3537)
!3537 = !{null, !144, !488}
!3538 = !{!3539, !3540}
!3539 = !DILocalVariable(name: "str", arg: 1, scope: !3534, file: !3535, line: 1035, type: !144)
!3540 = !DILocalVariable(name: "value", arg: 2, scope: !3534, file: !3535, line: 1035, type: !488)
!3541 = !DILocation(line: 1035, column: 1, scope: !3534)
!3542 = !{i32 1}
!3543 = distinct !DISubprogram(name: "kernelMatVecMulClass", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj0ELb0ELb1EEC2Ev", scope: !85, file: !86, line: 137, type: !157, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !156, retainedNodes: !3544)
!3544 = !{!3545}
!3545 = !DILocalVariable(name: "this", arg: 1, scope: !3543, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!3546 = !DILocation(line: 0, scope: !3543)
!3547 = !DILocation(line: 137, column: 29, scope: !3543)
!3548 = distinct !DISubprogram(linkageName: "_GLOBAL__sub_I_i11_wrap_matrix_vector_mul.cpp", scope: !1369, file: !1369, type: !3549, flags: DIFlagArtificial | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!3549 = !DISubroutineType(types: !137)
!3550 = !DILocation(line: 0, scope: !3548)
