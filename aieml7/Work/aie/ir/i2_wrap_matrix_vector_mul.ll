; ModuleID = 'i2_wrap_matrix_vector_mul.ll'
source_filename = "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i2_wrap_matrix_vector_mul.cpp"
target datalayout = "e-i8:8:8-i16:16:16-i32:32:32-i64:32:32-f32:32:32-f64:32:32-p:32:32:32:32:8-s0:256:256-a0:8:8-S256-n32:64-P1-p0:20:32:32:32:8-p1:20:32:32:32:8-p2:20:32:32:32:8-p3:20:32:32:32:8-p4:20:32:32:32:8-p5:20:32:32:32:8-p6:20:32:32:32:8-p7:20:32:32:32:8-p8:20:32:32:32:8-p9:20:32:32:32:8-p10:20:32:32:32:8-p11:20:32:32:32:8-p12:20:32:32:32:8-p13:20:32:32:32:8-p14:20:32:32:32:8-p15:20:32:32:32:8"
target triple = "pdarch-unknown-unknown-elf"

%"class.xf::dsp::aie::blas::matrix_vector_mul::matrix_vector_mul" = type { %"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass" }
%"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass" = type { ptr }
%class.anon = type { i8 }
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
%"class.aie::accum.2" = type { %"class.aie::detail::accum_base.3" }
%"class.aie::detail::accum_base.3" = type { %struct.v16accfloat }
%struct.v16accfloat = type { %struct.ipd.custom_type.v16acc32.v16acc32 }
%struct.ipd.custom_type.v16acc32.v16acc32 = type { i512 }
%struct.ipd.custom_type.uint1_t.uint1_t = type { i1 }
%"struct.aie::unary_op.4" = type { %"struct.aie::unary_op_common.5" }
%"struct.aie::unary_op_common.5" = type { %"class.aie::vector_elem_ref" }
%"struct.aie::unary_op.6" = type { %"struct.aie::unary_op_common.7" }
%"struct.aie::unary_op_common.7" = type { %"class.aie::vector" }
%"class.aie::vector_elem_const_ref" = type { ptr, i32 }
%class.anon.8 = type { ptr, ptr, ptr, ptr, ptr }
%struct.v32bfloat16 = type { %struct.ipd.custom_type.v128int4.v128int4 }
%struct.v16bfloat16 = type { %struct.ipd.custom_type.v64int4.v64int4 }
%struct.v32uint16 = type { %struct.ipd.custom_type.v128int4.v128int4 }
%struct.ipd.custom_type.uint4_t.uint4_t = type { i4 }
%struct.ipd.custom_type.uint5_t.uint5_t = type { i5 }

$_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev = comdat any

$_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEC2Ev = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE = comdat any

$_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv = comdat any

$_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv = comdat any

$_ZN3aie6vectorIfLj8EEC2Ev = comdat any

$_ZN3aie5accumI8accfloatLj8EEC2Ev = comdat any

$_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv = comdat any

$_Z10readincr_vILj8E8accfloatEN3aie5accumIT0_XT_EEEP13input_cascadeIS3_vE = comdat any

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

$_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE = comdat any

$_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat = comdat any

$_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE = comdat any

$_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj = comdat any

$_Z19get_scd_v16accfloatv = comdat any

$_Z19get_scd_v16accfloati = comdat any

$_Z16get_scd_v16acc32i = comdat any

$_ZN11v16accfloatC2E8v16acc32 = comdat any

$_ZN12me_primitive8scd_readE8v16acc327uint1_t = comdat any

$_ZN7uint1_tC2Ei = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE = comdat any

$_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj = comdat any

$_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev = comdat any

$_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat = comdat any

$_Z18extract_v8accfloat11v16accfloati = comdat any

$_ZN12me_primitive6ext_blE11v16accfloat = comdat any

$_ZN12me_primitive6ext_bhE11v16accfloat = comdat any

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

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEC2Ev = comdat any

@i2 = dso_local global %"class.xf::dsp::aie::blas::matrix_vector_mul::matrix_vector_mul" zeroinitializer, align 4, !dbg !0
@_ZN12me_primitive11control_rndE = external dso_local global i32, align 4
@_ZN12me_primitive11control_satE = external dso_local global i32, align 4
@__const._ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_.mul_op = private unnamed_addr constant %class.anon undef, align 1
@__const._ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_.it = private unnamed_addr constant %"struct.aie::detail::utils::iteration_dim" undef, align 1
@llvm.global_ctors = appending global [1 x { i32, ptr addrspace(1), ptr }] [{ i32, ptr addrspace(1), ptr } { i32 65535, ptr addrspace(1) @_GLOBAL__sub_I_i2_wrap_matrix_vector_mul.cpp, ptr null }]

; Function Attrs: mustprogress noinline nounwind
define weak_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE(ptr nonnull align 4 dereferenceable(4) %this, ptr nonnull align 4 dereferenceable(32768) %inMatrixA, ptr chesscopy noalias nonnull align 4 dereferenceable(8) %inWindowB, ptr %inCascade, ptr %outCascade) addrspace(1) #0 comdat align 2 !dbg !1529 !noalias !1539 {
entry:
  %this.addr = alloca ptr, align 4
  %inMatrixA.addr = alloca ptr, align 4
  %inWindowB.addr = alloca ptr, align 4
  %inCascade.addr = alloca ptr, align 4
  %outCascade.addr = alloca ptr, align 4
  %inInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %agg.tmp = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %agg.tmp5 = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542, !noalias !1546
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1531, metadata !DIExpression()), !dbg !1550
  store ptr %inMatrixA, ptr %inMatrixA.addr, align 4, !tbaa !1542, !noalias !1546
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inMatrixA.addr, metadata !1533, metadata !DIExpression()), !dbg !1551
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inWindowB.addr, i32 0, metadata !1552), !noalias !1546
  store ptr %inWindowB, ptr %inWindowB.addr, align 4, !tbaa !1542, !noalias !1546
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inWindowB.addr, metadata !1534, metadata !DIExpression()), !dbg !1553
  store ptr %inCascade, ptr %inCascade.addr, align 4, !tbaa !1542, !noalias !1546
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inCascade.addr, metadata !1535, metadata !DIExpression()), !dbg !1554
  store ptr %outCascade, ptr %outCascade.addr, align 4, !tbaa !1542, !noalias !1546
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outCascade.addr, metadata !1536, metadata !DIExpression()), !dbg !1555
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1546
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" undef, ptr %inInterface, align 4, !dbg !1556, !noalias !1546
  call addrspace(1) void @llvm.lifetime.start.p0(i64 20, ptr %inInterface) #22, !dbg !1556, !noalias !1546
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !1537, metadata !DIExpression()), !dbg !1557
  %1 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inInterface, i32 0, metadata !1558), !dbg !1556, !noalias !1546
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(20) %inInterface) #23, !dbg !1557, !noalias !1546
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" undef, ptr %outInterface, align 4, !dbg !1559, !noalias !1546
  call addrspace(1) void @llvm.lifetime.start.p0(i64 16, ptr %outInterface) #22, !dbg !1559, !noalias !1546
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !1538, metadata !DIExpression()), !dbg !1560
  %2 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1561), !dbg !1559, !noalias !1546
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(16) %outInterface) #23, !dbg !1560, !noalias !1546
  %3 = load ptr, ptr %inWindowB.addr, align 4, !dbg !1562, !tbaa !1542, !noalias !1546
  %call = call addrspace(1) ptr @_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv(ptr nonnull align 4 dereferenceable(8) %3) #24, !dbg !1563, !noalias !1546
  %inWindowB2 = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 1, !dbg !1564
  store ptr %call, ptr %inWindowB2, align 4, !dbg !1565, !tbaa !1566, !noalias !1546
  %4 = load ptr, ptr %inCascade.addr, align 4, !dbg !1568, !tbaa !1542, !noalias !1546
  %inCascade3 = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 4, !dbg !1569
  store ptr %4, ptr %inCascade3, align 4, !dbg !1570, !tbaa !1571, !noalias !1546
  %5 = load ptr, ptr %outCascade.addr, align 4, !dbg !1572, !tbaa !1542, !noalias !1546
  %outCascade4 = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %outInterface, i32 0, i32 3, !dbg !1573
  store ptr %5, ptr %outCascade4, align 4, !dbg !1574, !tbaa !1575, !noalias !1546
  %6 = load ptr, ptr %inMatrixA.addr, align 4, !dbg !1577, !tbaa !1542, !noalias !1546
  %arraydecay = getelementptr inbounds [8192 x float], ptr %6, i32 0, i32 0, !dbg !1577
  %m_inMatrixPtr = getelementptr inbounds %"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass", ptr %this1, i32 0, i32 0, !dbg !1578
  store ptr %arraydecay, ptr %m_inMatrixPtr, align 4, !dbg !1579, !tbaa !1580, !noalias !1546
  %7 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %inInterface, ptr %1, metadata !1582, metadata !1558), !dbg !1583
  %8 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %7, align 4, !dbg !1583, !tbaa !1584, !noalias !1546
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" %8, ptr %agg.tmp, align 4, !dbg !1583, !tbaa !1584, !noalias !1546
  %9 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %outInterface, ptr %2, metadata !1585, metadata !1561), !dbg !1586
  %10 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %9, align 4, !dbg !1586, !tbaa !1587, !noalias !1546
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %10, ptr %agg.tmp5, align 4, !dbg !1586, !tbaa !1587, !noalias !1546
  %11 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %agg.tmp5, ptr null, metadata !1585, metadata !1539), !dbg !1588
  %12 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %11, align 4, !dbg !1588, !tbaa !1587, !noalias !1546
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this1, ptr %agg.tmp, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %12) #24, !dbg !1588, !noalias !1546
  call addrspace(1) void @llvm.lifetime.end.p0(i64 16, ptr %outInterface) #22, !dbg !1589
  call addrspace(1) void @llvm.lifetime.end.p0(i64 20, ptr %inInterface) #22, !dbg !1589
  ret void, !dbg !1589
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) addrspace(1) #1

; Function Attrs: nounwind willreturn memory(inaccessiblemem: readwrite)
declare ptr @llvm.noalias.decl.p0.p0.i32(ptr, i32, metadata) addrspace(1) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) addrspace(1) #3

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(20) %this) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !1590 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1596, metadata !DIExpression()), !dbg !1598
  %this1 = load ptr, ptr %this.addr, align 4
  %inCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %this1, i32 0, i32 4, !dbg !1599
  store ptr null, ptr %inCascade, align 4, !dbg !1599, !tbaa !1571
  ret void, !dbg !1600
}

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(16) %this) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !1601 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1607, metadata !DIExpression()), !dbg !1609
  %this1 = load ptr, ptr %this.addr, align 4
  %outCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %this1, i32 0, i32 3, !dbg !1610
  store ptr null, ptr %outCascade, align 4, !dbg !1610, !tbaa !1575
  ret void, !dbg !1611
}

; Function Attrs: inlinehint mustprogress nounwind
define linkonce_odr dso_local ptr @_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #5 comdat align 2 !dbg !1612 !noalias !1624 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542, !noalias !1624
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1622, metadata !DIExpression()), !dbg !1627
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1624
  %_base = getelementptr inbounds %"struct.adf::detail::io_buffer_base", ptr %this1, i32 0, i32 0, !dbg !1628
  %0 = load ptr, ptr %_base, align 4, !dbg !1628, !tbaa !1630, !noalias !1624
  %1 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %0, ptr null, ptr %_base, i32 0, metadata !1624), !dbg !1628, !tbaa !1630, !noalias !1624
  ret ptr %1, !dbg !1632
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this, ptr %inInterface, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce) addrspace(1) #6 comdat align 2 !dbg !1633 !noalias !1638 {
entry:
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %this.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %agg.tmp2 = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce, ptr %outInterface, align 4, !noalias !1641
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542, !noalias !1641
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1635, metadata !DIExpression()), !dbg !1643
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !1636, metadata !DIExpression()), !dbg !1644
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1645), !noalias !1641
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !1637, metadata !DIExpression()), !dbg !1646
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1641
  %1 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %inInterface, ptr null, metadata !1582, metadata !1638), !dbg !1647
  %2 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %1, align 4, !dbg !1647, !tbaa !1584, !noalias !1641
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" %2, ptr %agg.tmp, align 4, !dbg !1647, !tbaa !1584, !noalias !1641
  %3 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %outInterface, ptr %0, metadata !1585, metadata !1645), !dbg !1648
  %4 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %3, align 4, !dbg !1648, !tbaa !1587, !noalias !1641
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %4, ptr %agg.tmp2, align 4, !dbg !1648, !tbaa !1587, !noalias !1641
  %5 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %agg.tmp2, ptr null, metadata !1585, metadata !1638), !dbg !1649
  %6 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %5, align 4, !dbg !1649, !tbaa !1587, !noalias !1641
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this1, ptr %agg.tmp, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %6) #24, !dbg !1649, !noalias !1641
  ret void, !dbg !1650
}

; Function Attrs: nounwind willreturn memory(none)
declare ptr @llvm.noalias.copy.guard.p0.p0(ptr, ptr, metadata, metadata) addrspace(1) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) addrspace(1) #3

; Function Attrs: nounwind
define internal void @__cxx_global_var_init() addrspace(1) #8 !dbg !1651 {
entry:
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEC2Ev(ptr nonnull align 4 dereferenceable(4) @i2) #24, !dbg !1652
  ret void, !dbg !1652
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEC2Ev(ptr nonnull align 4 dereferenceable(4) %this) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !1653 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1655, metadata !DIExpression()), !dbg !1656
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEC2Ev(ptr nonnull align 4 dereferenceable(4) %this1) #24, !dbg !1657
  ret void, !dbg !1658
}

; Function Attrs: mustprogress nounwind
define dso_local ptr @_Z7i2_userv() addrspace(1) #9 !dbg !1659 {
entry:
  ret ptr @i2, !dbg !1662
}

; Function Attrs: nounwind speculatable willreturn memory(argmem: readwrite)
declare ptr @llvm.noalias.p0.p0.p0.i32(ptr, ptr, ptr, i32, metadata) addrspace(1) #10

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this, ptr %inInterface, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce) addrspace(1) #6 comdat align 2 !dbg !1663 !noalias !1668 {
entry:
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %this.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %agg.tmp2 = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce, ptr %outInterface, align 4, !noalias !1671
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542, !noalias !1671
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1665, metadata !DIExpression()), !dbg !1673
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !1666, metadata !DIExpression()), !dbg !1674
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1675), !noalias !1671
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !1667, metadata !DIExpression()), !dbg !1676
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1671
  %1 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %inInterface, ptr null, metadata !1582, metadata !1668), !dbg !1677
  %2 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %1, align 4, !dbg !1677, !tbaa !1584, !noalias !1671
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" %2, ptr %agg.tmp, align 4, !dbg !1677, !tbaa !1584, !noalias !1671
  %3 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %outInterface, ptr %0, metadata !1585, metadata !1675), !dbg !1680
  %4 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %3, align 4, !dbg !1680, !tbaa !1587, !noalias !1671
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %4, ptr %agg.tmp2, align 4, !dbg !1680, !tbaa !1587, !noalias !1671
  %5 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %agg.tmp2, ptr null, metadata !1585, metadata !1668), !dbg !1681
  %6 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %5, align 4, !dbg !1681, !tbaa !1587, !noalias !1671
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this1, ptr %agg.tmp, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %6) #24, !dbg !1681, !noalias !1671
  ret void, !dbg !1682
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this, ptr %inInterface, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce) addrspace(1) #6 comdat align 2 !dbg !84 !noalias !1683 {
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
  %agg.tmp = alloca %"class.aie::accum", align 32
  %vecInB = alloca i32, align 4
  %jdx = alloca i32, align 4
  %agg.tmp23 = alloca %"class.aie::vector_elem_ref", align 4
  %agg.tmp26 = alloca %"class.aie::accum", align 32
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce, ptr %outInterface, align 4, !noalias !1686
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !179, metadata !DIExpression()), !dbg !1696
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !181, metadata !DIExpression()), !dbg !1697
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1698), !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !182, metadata !DIExpression()), !dbg !1699
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1686
  call addrspace(1) void @_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv() #24, !dbg !1700, !noalias !1686
  call addrspace(1) void @_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv() #24, !dbg !1701, !noalias !1686
  store %"class.aie::vector" undef, ptr %dataA, align 32, !dbg !1702, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %dataA) #22, !dbg !1702, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %dataA, metadata !183, metadata !DIExpression()), !dbg !1703
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !1703, !noalias !1686
  %1 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !1703, !tbaa !1704, !noalias !1686
  store %"class.aie::vector" %1, ptr %dataA, align 32, !dbg !1703, !tbaa !1704, !noalias !1686
  store ptr undef, ptr %inPtrA, align 4, !dbg !1708, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inPtrA) #22, !dbg !1708, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inPtrA, metadata !184, metadata !DIExpression()), !dbg !1709
  %2 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inPtrA, i32 0, metadata !1710), !dbg !1708, !noalias !1686
  store %"class.aie::vector" undef, ptr %dataB, align 32, !dbg !1711, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %dataB) #22, !dbg !1711, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %dataB, metadata !186, metadata !DIExpression()), !dbg !1712
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp2) #24, !dbg !1712, !noalias !1686
  %3 = load %"class.aie::vector", ptr %custom_type.tmp2, align 32, !dbg !1712, !tbaa !1704, !noalias !1686
  store %"class.aie::vector" %3, ptr %dataB, align 32, !dbg !1712, !tbaa !1704, !noalias !1686
  store ptr undef, ptr %inPtrB, align 4, !dbg !1713, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inPtrB) #22, !dbg !1713, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inPtrB, metadata !369, metadata !DIExpression()), !dbg !1714
  %4 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inPtrB, i32 0, metadata !1715), !dbg !1713, !noalias !1686
  store %"class.aie::accum" undef, ptr %acc, align 32, !dbg !1716, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %acc) #22, !dbg !1716, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !372, metadata !DIExpression()), !dbg !1717
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp3) #24, !dbg !1717, !noalias !1686
  %5 = load %"class.aie::accum", ptr %custom_type.tmp3, align 32, !dbg !1717, !tbaa !1718, !noalias !1686
  store %"class.aie::accum" %5, ptr %acc, align 32, !dbg !1717, !tbaa !1718, !noalias !1686
  store %"class.aie::vector" undef, ptr %blankVect, align 32, !dbg !1722, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %blankVect) #22, !dbg !1722, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %blankVect, metadata !460, metadata !DIExpression()), !dbg !1723
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv() #24, !dbg !1724, !noalias !1686
  %6 = getelementptr inbounds %"class.aie::vector", ptr %blankVect, i32 0, i32 0, !dbg !1724
  %7 = extractvalue %"class.aie::vector" %call, 0, !dbg !1724
  store %"class.aie::detail::vector_base" %7, ptr %6, align 32, !dbg !1724, !noalias !1686
  store %"class.aie::vector" undef, ptr %outVect, align 32, !dbg !1725, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %outVect) #22, !dbg !1725, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outVect, metadata !462, metadata !DIExpression()), !dbg !1726
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp4) #24, !dbg !1726, !noalias !1686
  %8 = load %"class.aie::vector", ptr %custom_type.tmp4, align 32, !dbg !1726, !tbaa !1704, !noalias !1686
  store %"class.aie::vector" %8, ptr %outVect, align 32, !dbg !1726, !tbaa !1704, !noalias !1686
  store ptr undef, ptr %inMatrixBuff, align 4, !dbg !1727, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inMatrixBuff) #22, !dbg !1727, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inMatrixBuff, metadata !463, metadata !DIExpression()), !dbg !1728
  %9 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inMatrixBuff, i32 0, metadata !1729), !dbg !1727, !noalias !1686
  %inWindowA = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 0, !dbg !1730
  %10 = load ptr, ptr %inWindowA, align 4, !dbg !1730, !tbaa !1731, !noalias !1686
  %11 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %10, ptr null, ptr %inWindowA, i32 0, metadata !1683), !dbg !1730, !tbaa !1731, !noalias !1686
  %12 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %11), !dbg !1728
  store ptr %12, ptr %inMatrixBuff, align 4, !dbg !1728, !tbaa !1542, !noalias !1686
  store ptr undef, ptr %inMatrixPtrRtp, align 4, !dbg !1732, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inMatrixPtrRtp) #22, !dbg !1732, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inMatrixPtrRtp, metadata !464, metadata !DIExpression()), !dbg !1733
  %13 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inMatrixPtrRtp, i32 0, metadata !1734), !dbg !1732, !noalias !1686
  %m_inMatrixPtr = getelementptr inbounds %"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass", ptr %this1, i32 0, i32 0, !dbg !1735
  %14 = load ptr, ptr %m_inMatrixPtr, align 4, !dbg !1735, !tbaa !1580, !noalias !1686
  %15 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %14, ptr null, ptr %m_inMatrixPtr, i32 0, metadata !1683), !dbg !1735, !tbaa !1580, !noalias !1686
  %16 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %15), !dbg !1733
  store ptr %16, ptr %inMatrixPtrRtp, align 4, !dbg !1733, !tbaa !1542, !noalias !1686
  store ptr undef, ptr %matrixPtr, align 4, !dbg !1736, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %matrixPtr) #22, !dbg !1736, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %matrixPtr, metadata !465, metadata !DIExpression()), !dbg !1737
  %17 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %matrixPtr, i32 0, metadata !1738), !dbg !1736, !noalias !1686
  %18 = load ptr, ptr %inMatrixPtrRtp, align 4, !dbg !1739, !tbaa !1542, !noalias !1686
  %19 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %18, ptr %13, ptr %inMatrixPtrRtp, i32 0, metadata !1734), !dbg !1739, !tbaa !1542, !noalias !1686
  %20 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %19), !dbg !1737
  store ptr %20, ptr %matrixPtr, align 4, !dbg !1737, !tbaa !1542, !noalias !1686
  store ptr undef, ptr %matrixStartPtr, align 4, !dbg !1740, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %matrixStartPtr) #22, !dbg !1740, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %matrixStartPtr, metadata !466, metadata !DIExpression()), !dbg !1741
  %21 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %matrixStartPtr, i32 0, metadata !1742), !dbg !1740, !noalias !1686
  %22 = load ptr, ptr %matrixPtr, align 4, !dbg !1743, !tbaa !1542, !noalias !1686
  %23 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %22, ptr %17, ptr %matrixPtr, i32 0, metadata !1738), !dbg !1743, !tbaa !1542, !noalias !1686
  %24 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %23), !dbg !1741
  store ptr %24, ptr %matrixStartPtr, align 4, !dbg !1741, !tbaa !1542, !noalias !1686
  store ptr undef, ptr %vectorStartPtr, align 4, !dbg !1744, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %vectorStartPtr) #22, !dbg !1744, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %vectorStartPtr, metadata !467, metadata !DIExpression()), !dbg !1745
  %25 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %vectorStartPtr, i32 0, metadata !1746), !dbg !1744, !noalias !1686
  %inWindowB = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 1, !dbg !1747
  %26 = load ptr, ptr %inWindowB, align 4, !dbg !1747, !tbaa !1566, !noalias !1686
  %27 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %26, ptr null, ptr %inWindowB, i32 0, metadata !1683), !dbg !1747, !tbaa !1566, !noalias !1686
  %28 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %27), !dbg !1745
  store ptr %28, ptr %vectorStartPtr, align 4, !dbg !1745, !tbaa !1542, !noalias !1686
  store ptr undef, ptr %outPtr, align 4, !dbg !1748, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %outPtr) #22, !dbg !1748, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outPtr, metadata !468, metadata !DIExpression()), !dbg !1749
  %29 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outPtr, i32 0, metadata !1750), !dbg !1748, !noalias !1686
  %outWindow = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %outInterface, i32 0, i32 0, !dbg !1751
  %30 = load ptr, ptr %outWindow, align 4, !dbg !1751, !tbaa !1752, !noalias !1686
  %31 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %30, ptr %0, ptr %outWindow, i32 0, metadata !1698), !dbg !1751, !tbaa !1752, !noalias !1686
  %32 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %31), !dbg !1749
  store ptr %32, ptr %outPtr, align 4, !dbg !1749, !tbaa !1542, !noalias !1686
  store i32 undef, ptr %frame, align 4, !dbg !1753, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %frame) #22, !dbg !1753, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %frame, metadata !472, metadata !DIExpression()), !dbg !1754
  store i32 0, ptr %frame, align 4, !dbg !1754, !tbaa !1755, !noalias !1686
  br label %for.cond, !dbg !1753

for.cond:                                         ; preds = %for.inc33, %entry
  %33 = load i32, ptr %frame, align 4, !dbg !1757, !tbaa !1755, !noalias !1686
  %cmp = icmp ult i32 %33, 1, !dbg !1758
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !1759

for.cond.cleanup:                                 ; preds = %for.cond
  store i32 2, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %frame) #22, !dbg !1760, !noalias !1686
  br label %for.end35

for.body:                                         ; preds = %for.cond
  store i32 undef, ptr %idx, align 4, !dbg !1761, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %idx) #22, !dbg !1761, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx, metadata !474, metadata !DIExpression()), !dbg !1762
  store i32 0, ptr %idx, align 4, !dbg !1762, !tbaa !1755, !noalias !1686
  br label %for.pre_assume, !dbg !1761

for.pre_assume:                                   ; preds = %for.body
  %34 = load i32, ptr %idx, align 4, !dbg !1763, !tbaa !1755, !noalias !1686
  %cmp7 = icmp slt i32 %34, 16, !dbg !1764
  call addrspace(1) void @llvm.assume(i1 %cmp7), !dbg !1765, !noalias !1686
  br label %for.body9, !dbg !1765

for.cond5:                                        ; preds = %for.inc30
  %35 = load i32, ptr %idx, align 4, !dbg !1763, !tbaa !1755, !noalias !1686
  %cmp6 = icmp slt i32 %35, 16, !dbg !1764
  br i1 %cmp6, label %for.body9, label %for.cond.cleanup8, !dbg !1765, !llvm.loop !1766

for.cond.cleanup8:                                ; preds = %for.cond5
  store i32 5, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %idx) #22, !dbg !1773, !noalias !1686
  br label %for.end32

for.body9:                                        ; preds = %for.cond5, %for.pre_assume
  %36 = load ptr, ptr %matrixStartPtr, align 4, !dbg !1774, !tbaa !1542, !noalias !1686
  %37 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %36, ptr %21, ptr %matrixStartPtr, i32 0, metadata !1742), !dbg !1774, !tbaa !1542, !noalias !1686
  %38 = load i32, ptr %frame, align 4, !dbg !1775, !tbaa !1755, !noalias !1686
  %mul = mul nsw i32 %38, 1024, !dbg !1776
  %add.ptr = getelementptr inbounds %"class.aie::vector", ptr %37, i32 %mul, !dbg !1777
  %39 = load i32, ptr %idx, align 4, !dbg !1778, !tbaa !1755, !noalias !1686
  %add.ptr10 = getelementptr inbounds %"class.aie::vector", ptr %add.ptr, i32 %39, !dbg !1779
  store ptr %add.ptr10, ptr %inPtrA, align 4, !dbg !1780, !tbaa !1542, !noalias !1686
  %40 = load ptr, ptr %vectorStartPtr, align 4, !dbg !1781, !tbaa !1542, !noalias !1686
  %41 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %40, ptr %25, ptr %vectorStartPtr, i32 0, metadata !1746), !dbg !1781, !tbaa !1542, !noalias !1686
  %42 = load i32, ptr %frame, align 4, !dbg !1782, !tbaa !1755, !noalias !1686
  %mul11 = mul nsw i32 %42, 8, !dbg !1783
  %add.ptr12 = getelementptr inbounds %"class.aie::vector", ptr %41, i32 %mul11, !dbg !1784
  store ptr %add.ptr12, ptr %inPtrB, align 4, !dbg !1785, !tbaa !1542, !noalias !1686
  %inCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 4, !dbg !1786
  %43 = load ptr, ptr %inCascade, align 4, !dbg !1786, !tbaa !1571, !noalias !1686
  %call13 = call addrspace(1) %"class.aie::accum" @_Z10readincr_vILj8E8accfloatEN3aie5accumIT0_XT_EEEP13input_cascadeIS3_vE(ptr %43) #24, !dbg !1789, !noalias !1686
  %44 = getelementptr inbounds %"class.aie::accum", ptr %agg.tmp, i32 0, i32 0, !dbg !1789
  %45 = extractvalue %"class.aie::accum" %call13, 0, !dbg !1789
  store %"class.aie::detail::accum_base" %45, ptr %44, align 32, !dbg !1789, !noalias !1686
  %46 = load %"class.aie::accum", ptr %agg.tmp, align 32, !dbg !1790, !tbaa !1718, !noalias !1686
  store %"class.aie::accum" %46, ptr %acc, align 32, !dbg !1790, !tbaa !1718, !noalias !1686
  store i32 undef, ptr %vecInB, align 4, !dbg !1791, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %vecInB) #22, !dbg !1791, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %vecInB, metadata !478, metadata !DIExpression()), !dbg !1792
  store i32 0, ptr %vecInB, align 4, !dbg !1792, !tbaa !1755, !noalias !1686
  br label %for.cond14, !dbg !1791

for.cond14:                                       ; preds = %for.inc27, %for.body9
  %47 = load i32, ptr %vecInB, align 4, !dbg !1793, !tbaa !1755, !noalias !1686
  %cmp15 = icmp slt i32 %47, 8, !dbg !1794
  br i1 %cmp15, label %for.body17, label %for.cond.cleanup16, !dbg !1795

for.cond.cleanup16:                               ; preds = %for.cond14
  store i32 8, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %vecInB) #22, !dbg !1796, !noalias !1686
  br label %for.end29

for.body17:                                       ; preds = %for.cond14
  %48 = load ptr, ptr %inPtrB, align 4, !dbg !1797, !tbaa !1542, !noalias !1686
  %49 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %48, ptr %4, ptr %inPtrB, i32 0, metadata !1715), !dbg !1797, !tbaa !1542, !noalias !1686
  %incdec.ptr = getelementptr inbounds %"class.aie::vector", ptr %49, i32 1, !dbg !1797
  store ptr %incdec.ptr, ptr %inPtrB, align 4, !dbg !1797, !tbaa !1542, !noalias !1686
  %50 = load %"class.aie::vector", ptr %49, align 32, !dbg !1798, !tbaa !1704, !noalias !1686
  store %"class.aie::vector" %50, ptr %dataB, align 32, !dbg !1798, !tbaa !1704, !noalias !1686
  store i32 undef, ptr %jdx, align 4, !dbg !1799, !noalias !1686
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %jdx) #22, !dbg !1799, !noalias !1686
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %jdx, metadata !482, metadata !DIExpression()), !dbg !1800
  store i32 0, ptr %jdx, align 4, !dbg !1800, !tbaa !1755, !noalias !1686
  br label %for.cond18, !dbg !1799

for.cond18:                                       ; preds = %for.inc, %for.body17
  %51 = load i32, ptr %jdx, align 4, !dbg !1801, !tbaa !1755, !noalias !1686
  %cmp19 = icmp slt i32 %51, 8, !dbg !1803
  br i1 %cmp19, label %for.body21, label %for.cond.cleanup20, !dbg !1804

for.cond.cleanup20:                               ; preds = %for.cond18
  store i32 11, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %jdx) #22, !dbg !1805, !noalias !1686
  br label %for.end

for.body21:                                       ; preds = %for.cond18
  %52 = load ptr, ptr %inPtrA, align 4, !dbg !1806, !tbaa !1542, !noalias !1686
  %53 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %52, ptr %2, ptr %inPtrA, i32 0, metadata !1710), !dbg !1806, !tbaa !1542, !noalias !1686
  %54 = load %"class.aie::vector", ptr %53, align 32, !dbg !1808, !tbaa !1704, !noalias !1686
  store %"class.aie::vector" %54, ptr %dataA, align 32, !dbg !1808, !tbaa !1704, !noalias !1686
  %55 = load ptr, ptr %inPtrA, align 4, !dbg !1809, !tbaa !1542, !noalias !1686
  %56 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %55, ptr %2, ptr %inPtrA, i32 0, metadata !1710), !dbg !1809, !tbaa !1542, !noalias !1686
  %add.ptr22 = getelementptr inbounds %"class.aie::vector", ptr %56, i32 16, !dbg !1809
  store ptr %add.ptr22, ptr %inPtrA, align 4, !dbg !1809, !tbaa !1542, !noalias !1686
  %57 = load i32, ptr %jdx, align 4, !dbg !1810, !tbaa !1755, !noalias !1686
  %call24 = call addrspace(1) %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EEixEj(ptr nonnull align 32 dereferenceable(32) %dataB, i32 %57) #24, !dbg !1813, !noalias !1686
  %58 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %agg.tmp23, i32 0, i32 0, !dbg !1813
  %59 = extractvalue %"class.aie::vector_elem_ref" %call24, 0, !dbg !1813
  store ptr %59, ptr %58, align 4, !dbg !1813, !noalias !1686
  %60 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %agg.tmp23, i32 0, i32 1, !dbg !1813
  %61 = extractvalue %"class.aie::vector_elem_ref" %call24, 1, !dbg !1813
  store i32 %61, ptr %60, align 4, !dbg !1813, !noalias !1686
  %62 = load %"class.aie::vector_elem_ref", ptr %agg.tmp23, align 4, !dbg !1814, !tbaa !1815, !noalias !1686
  %call25 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"class.aie::vector_elem_ref" %62, ptr nonnull align 32 dereferenceable(32) %dataA) #24, !dbg !1814, !noalias !1686
  %63 = getelementptr inbounds %"class.aie::accum", ptr %agg.tmp26, i32 0, i32 0, !dbg !1814
  %64 = extractvalue %"class.aie::accum" %call25, 0, !dbg !1814
  store %"class.aie::detail::accum_base" %64, ptr %63, align 32, !dbg !1814, !noalias !1686
  %65 = load %"class.aie::accum", ptr %agg.tmp26, align 32, !dbg !1817, !tbaa !1718, !noalias !1686
  store %"class.aie::accum" %65, ptr %acc, align 32, !dbg !1817, !tbaa !1718, !noalias !1686
  br label %for.inc, !dbg !1818

for.inc:                                          ; preds = %for.body21
  %66 = load i32, ptr %jdx, align 4, !dbg !1819, !tbaa !1755, !noalias !1686
  %inc = add nsw i32 %66, 1, !dbg !1819
  store i32 %inc, ptr %jdx, align 4, !dbg !1819, !tbaa !1755, !noalias !1686
  br label %for.cond18, !dbg !1805, !llvm.loop !1820

for.end:                                          ; preds = %for.cond.cleanup20
  br label %for.inc27, !dbg !1823

for.inc27:                                        ; preds = %for.end
  %67 = load i32, ptr %vecInB, align 4, !dbg !1824, !tbaa !1755, !noalias !1686
  %inc28 = add nsw i32 %67, 1, !dbg !1824
  store i32 %inc28, ptr %vecInB, align 4, !dbg !1824, !tbaa !1755, !noalias !1686
  br label %for.cond14, !dbg !1796, !llvm.loop !1825

for.end29:                                        ; preds = %for.cond.cleanup16
  %outCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %outInterface, i32 0, i32 3, !dbg !1827
  %68 = load ptr, ptr %outCascade, align 4, !dbg !1827, !tbaa !1575, !noalias !1686
  call addrspace(1) void @_Z9writeincrI8accfloatLj8EEvP14output_cascadeIT_vERKN3aie5accumIS2_XT0_EEE(ptr %68, ptr nonnull align 32 dereferenceable(32) %acc) #24, !dbg !1830, !noalias !1686
  br label %for.inc30, !dbg !1831

for.inc30:                                        ; preds = %for.end29
  %69 = load i32, ptr %idx, align 4, !dbg !1832, !tbaa !1755, !noalias !1686
  %inc31 = add nsw i32 %69, 1, !dbg !1832
  store i32 %inc31, ptr %idx, align 4, !dbg !1832, !tbaa !1755, !noalias !1686
  br label %for.cond5, !dbg !1773, !llvm.loop !1766

for.end32:                                        ; preds = %for.cond.cleanup8
  br label %for.inc33, !dbg !1833

for.inc33:                                        ; preds = %for.end32
  %70 = load i32, ptr %frame, align 4, !dbg !1834, !tbaa !1755, !noalias !1686
  %inc34 = add nsw i32 %70, 1, !dbg !1834
  store i32 %inc34, ptr %frame, align 4, !dbg !1834, !tbaa !1755, !noalias !1686
  br label %for.cond, !dbg !1760, !llvm.loop !1835

for.end35:                                        ; preds = %for.cond.cleanup
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %outPtr) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %vectorStartPtr) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %matrixStartPtr) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %matrixPtr) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inMatrixPtrRtp) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inMatrixBuff) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %outVect) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %blankVect) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %acc) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inPtrB) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %dataB) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inPtrA) #22, !dbg !1837
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %dataA) #22, !dbg !1837
  ret void, !dbg !1837
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv() addrspace(1) #6 comdat !dbg !1838 {
entry:
  call addrspace(1) void @_ZN3aieL12set_roundingENS_13rounding_modeE(i32 0) #24, !dbg !1842
  ret void, !dbg !1845
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv() addrspace(1) #6 comdat !dbg !1846 {
entry:
  call addrspace(1) void @_ZN3aieL14set_saturationENS_15saturation_modeE(i32 0) #24, !dbg !1849
  ret void, !dbg !1852
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1853 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1855, metadata !DIExpression()), !dbg !1857
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this1) #24, !dbg !1858
  ret void, !dbg !1859
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1860 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1862, metadata !DIExpression()), !dbg !1864
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this1) #24, !dbg !1865
  ret void, !dbg !1866
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv() addrspace(1) #6 comdat !dbg !1867 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv() #24, !dbg !1870
  %0 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !1870
  %1 = extractvalue %"class.aie::vector" %call, 0, !dbg !1870
  store %"class.aie::detail::vector_base" %1, ptr %0, align 32, !dbg !1870
  %2 = load %"class.aie::vector", ptr %retval, align 32, !dbg !1871
  ret %"class.aie::vector" %2, !dbg !1871
}

; Function Attrs: nocse nounwind willreturn memory(none)
declare ptr @llvm.chess.copy.p0(ptr) addrspace(1) #12

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) addrspace(1) #13

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_Z10readincr_vILj8E8accfloatEN3aie5accumIT0_XT_EEEP13input_cascadeIS3_vE(ptr %w) addrspace(1) #6 comdat !dbg !1872 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %w.addr = alloca ptr, align 4
  store ptr %w, ptr %w.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w.addr, metadata !1876, metadata !DIExpression()), !dbg !1879
  %0 = load ptr, ptr %w.addr, align 4, !dbg !1880, !tbaa !1542
  %call = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE(ptr %0) #24, !dbg !1881
  %1 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !1881
  %2 = extractvalue %"class.aie::accum" %call, 0, !dbg !1881
  store %"class.aie::detail::accum_base" %2, ptr %1, align 32, !dbg !1881
  %3 = load %"class.aie::accum", ptr %retval, align 32, !dbg !1882
  ret %"class.aie::accum" %3, !dbg !1882
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"class.aie::vector_elem_ref" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !1883 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"class.aie::vector_elem_ref", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %ref.tmp = alloca %"struct.aie::unary_op", align 32
  %agg.tmp = alloca %"class.aie::vector_elem_ref", align 4
  store %"class.aie::vector_elem_ref" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !1891, metadata !DIExpression()), !dbg !1898
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !1892, metadata !DIExpression()), !dbg !1899
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !1893, metadata !DIExpression()), !dbg !1900
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !1901
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !1904, !tbaa !1542
  %call = call addrspace(1) %"struct.aie::unary_op" @_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_(ptr nonnull align 32 dereferenceable(32) %0) #24, !dbg !1901
  %1 = getelementptr inbounds %"struct.aie::unary_op", ptr %ref.tmp, i32 0, i32 0, !dbg !1901
  %2 = extractvalue %"struct.aie::unary_op" %call, 0, !dbg !1901
  store %"struct.aie::unary_op_common" %2, ptr %1, align 32, !dbg !1901
  %3 = load %"class.aie::vector_elem_ref", ptr %a, align 4, !dbg !1905, !tbaa !1815
  store %"class.aie::vector_elem_ref" %3, ptr %agg.tmp, align 4, !dbg !1905, !tbaa !1815
  %4 = load ptr, ptr %v.addr, align 4, !dbg !1906, !tbaa !1542
  %5 = load %"class.aie::vector_elem_ref", ptr %agg.tmp, align 4, !dbg !1907, !tbaa !1815
  %call1 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %ref.tmp, %"class.aie::vector_elem_ref" %5, ptr nonnull align 32 dereferenceable(32) %4) #24, !dbg !1907
  %6 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !1907
  %7 = extractvalue %"class.aie::accum" %call1, 0, !dbg !1907
  store %"class.aie::detail::accum_base" %7, ptr %6, align 32, !dbg !1907
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !1908
  %8 = load %"class.aie::accum", ptr %retval, align 32, !dbg !1908
  ret %"class.aie::accum" %8, !dbg !1908
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EEixEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !1909 {
entry:
  %retval = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1911, metadata !DIExpression()), !dbg !1913
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !1912, metadata !DIExpression()), !dbg !1914
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !1915

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !1916, !tbaa !1755
  %cmp = icmp ult i32 %0, 8, !dbg !1916
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !1916
  br i1 %1, label %if.then, label %if.else, !dbg !1919

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !1920

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !1922, !tbaa !1755
  %cmp3 = icmp ult i32 %2, 8, !dbg !1922
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !1922
  br i1 %3, label %if.end, label %if.then4, !dbg !1925

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !1926), !dbg !1922
  br label %if.end, !dbg !1922

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !1925

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !1920

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !1927, !tbaa !1755
  %cmp5 = icmp ult i32 %4, 8, !dbg !1927
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !1927
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !1919

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !1929, !tbaa !1755
  %call = call addrspace(1) %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EE8elem_refEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %5) #24, !dbg !1930
  %6 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %retval, i32 0, i32 0, !dbg !1930
  %7 = extractvalue %"class.aie::vector_elem_ref" %call, 0, !dbg !1930
  store ptr %7, ptr %6, align 4, !dbg !1930
  %8 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %retval, i32 0, i32 1, !dbg !1930
  %9 = extractvalue %"class.aie::vector_elem_ref" %call, 1, !dbg !1930
  store i32 %9, ptr %8, align 4, !dbg !1930
  %10 = load %"class.aie::vector_elem_ref", ptr %retval, align 4, !dbg !1931
  ret %"class.aie::vector_elem_ref" %10, !dbg !1931
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z9writeincrI8accfloatLj8EEvP14output_cascadeIT_vERKN3aie5accumIS2_XT0_EEE(ptr %w, ptr nonnull align 32 dereferenceable(32) %value) addrspace(1) #6 comdat !dbg !1932 {
entry:
  %w.addr = alloca ptr, align 4
  %value.addr = alloca ptr, align 4
  store ptr %w, ptr %w.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w.addr, metadata !1936, metadata !DIExpression()), !dbg !1939
  store ptr %value, ptr %value.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %value.addr, metadata !1937, metadata !DIExpression()), !dbg !1940
  %0 = load ptr, ptr %w.addr, align 4, !dbg !1941, !tbaa !1542
  %1 = load ptr, ptr %value.addr, align 4, !dbg !1942, !tbaa !1542
  %2 = load %"class.aie::accum", ptr %1, align 32, !dbg !1943, !tbaa !1718
  call addrspace(1) void @_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE(ptr %0, %"class.aie::accum" %2) #24, !dbg !1943
  ret void, !dbg !1944
}

; Function Attrs: alwaysinline mustprogress nounwind
define internal void @_ZN3aieL12set_roundingENS_13rounding_modeE(i32 %m) addrspace(1) #6 !dbg !1945 {
entry:
  %m.addr = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::tile", align 1
  %undef.agg.tmp = alloca %"class.aie::tile", align 1
  store i32 %m, ptr %m.addr, align 4, !tbaa !1950
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %m.addr, metadata !1949, metadata !DIExpression()), !dbg !1952
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %ref.tmp) #22, !dbg !1953
  call addrspace(1) void @_ZN3aie4tile7currentEv() #24, !dbg !1953
  %0 = load i32, ptr %m.addr, align 4, !dbg !1954, !tbaa !1950
  call addrspace(1) void @_ZN3aie4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %ref.tmp, i32 %0) #24, !dbg !1955
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %ref.tmp) #22, !dbg !1953
  ret void, !dbg !1956
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie4tile7currentEv() addrspace(1) #6 comdat align 2 !dbg !1957 {
entry:
  %retval = alloca %"class.aie::tile", align 1
  %ref.tmp = alloca %"class.aie::detail::tile", align 1
  %undef.agg.tmp = alloca %"class.aie::detail::tile", align 1
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %ref.tmp) #22, !dbg !1958
  call addrspace(1) void @_ZN3aie6detail4tile7currentEv() #24, !dbg !1958
  call addrspace(1) void @_ZN3aie4tileC2ERKNS_6detail4tileE(ptr nonnull align 1 dereferenceable(1) %retval, ptr nonnull align 1 dereferenceable(1) %ref.tmp) #24, !dbg !1958
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %ref.tmp) #22, !dbg !1959
  ret void, !dbg !1959
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !1960 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1962, metadata !DIExpression()), !dbg !1965
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !1950
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !1964, metadata !DIExpression()), !dbg !1966
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !1967, !tbaa !1950
  call addrspace(1) void @_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %this1, i32 %0) #24, !dbg !1968
  ret void, !dbg !1969
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tile7currentEv() addrspace(1) #6 comdat align 2 !dbg !1970 {
entry:
  %retval = alloca %"class.aie::detail::tile", align 1
  call addrspace(1) void @_ZN3aie6detail4tileC2Ev(ptr nonnull align 1 dereferenceable(1) %retval) #24, !dbg !1971
  ret void, !dbg !1972
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN3aie4tileC2ERKNS_6detail4tileE(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 1 dereferenceable(1) %t) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !1973 {
entry:
  %this.addr = alloca ptr, align 4
  %t.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1975, metadata !DIExpression()), !dbg !1977
  store ptr %t, ptr %t.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %t.addr, metadata !1976, metadata !DIExpression()), !dbg !1978
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %t.addr, align 4, !dbg !1979, !tbaa !1542
  ret void, !dbg !1980
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tileC2Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1981 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1983, metadata !DIExpression()), !dbg !1985
  %this1 = load ptr, ptr %this.addr, align 4
  ret void, !dbg !1986
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !1987 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1989, metadata !DIExpression()), !dbg !1991
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !1950
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !1990, metadata !DIExpression()), !dbg !1992
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !1993, !tbaa !1950
  call addrspace(1) void @_Z7set_rndj(i32 %0) #24, !dbg !1994
  ret void, !dbg !1995
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z7set_rndj(i32 %val) addrspace(1) #6 comdat {
entry:
  %val.addr = alloca i32, align 4
  store i32 %val, ptr %val.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %val.addr, align 4, !tbaa !1755
  store i32 %0, ptr @_ZN12me_primitive11control_rndE, align 4, !tbaa !1755
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define internal void @_ZN3aieL14set_saturationENS_15saturation_modeE(i32 %m) addrspace(1) #6 !dbg !1996 {
entry:
  %m.addr = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::tile", align 1
  %undef.agg.tmp = alloca %"class.aie::tile", align 1
  store i32 %m, ptr %m.addr, align 4, !tbaa !2001
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %m.addr, metadata !2000, metadata !DIExpression()), !dbg !2003
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %ref.tmp) #22, !dbg !2004
  call addrspace(1) void @_ZN3aie4tile7currentEv() #24, !dbg !2004
  %0 = load i32, ptr %m.addr, align 4, !dbg !2005, !tbaa !2001
  call addrspace(1) void @_ZN3aie4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %ref.tmp, i32 %0) #24, !dbg !2006
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %ref.tmp) #22, !dbg !2004
  ret void, !dbg !2007
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !2008 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2010, metadata !DIExpression()), !dbg !2012
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !2001
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !2011, metadata !DIExpression()), !dbg !2013
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !2014, !tbaa !2001
  call addrspace(1) void @_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %this1, i32 %0) #24, !dbg !2015
  ret void, !dbg !2016
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !2017 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2019, metadata !DIExpression()), !dbg !2021
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !2001
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !2020, metadata !DIExpression()), !dbg !2022
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !2023, !tbaa !2001
  call addrspace(1) void @_Z11set_satmodej(i32 %0) #24, !dbg !2024
  ret void, !dbg !2025
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z11set_satmodej(i32 %val) addrspace(1) #6 comdat {
entry:
  %val.addr = alloca i32, align 4
  store i32 %val, ptr %val.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %val.addr, align 4, !tbaa !1755
  store i32 %0, ptr @_ZN12me_primitive11control_satE, align 4, !tbaa !1755
  ret void
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2026 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2028, metadata !DIExpression()), !dbg !2030
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !2031
  %call = call addrspace(1) %struct.v8float @_ZN3aie6detail14vector_storageIfLj8EE5undefEv() #24, !dbg !2032
  %0 = getelementptr inbounds %struct.v8float, ptr %data, i32 0, i32 0, !dbg !2032
  %1 = extractvalue %struct.v8float %call, 0, !dbg !2032
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32, !dbg !2032
  ret void, !dbg !2033
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_ZN3aie6detail14vector_storageIfLj8EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !2034 {
entry:
  %retval = alloca %struct.v8float, align 32
  %call = call addrspace(1) %struct.v8float @_Z13undef_v8floatv() #24, !dbg !2035
  %0 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0, !dbg !2035
  %1 = extractvalue %struct.v8float %call, 0, !dbg !2035
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32, !dbg !2035
  %2 = load %struct.v8float, ptr %retval, align 32, !dbg !2036
  ret %struct.v8float %2, !dbg !2036
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_Z13undef_v8floatv() addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8float, align 32
  %call = call x86_regcallcc addrspace(1) %struct.v8float @__regcall3__chessintr_v8float_undef_v8float() #25
  %0 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0
  %1 = extractvalue %struct.v8float %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32
  %2 = load %struct.v8float, ptr %retval, align 32
  ret %struct.v8float %2
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8float @__regcall3__chessintr_v8float_undef_v8float() addrspace(1) #14

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !2037 {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %call = call addrspace(1) %struct.v8accfloat @_Z16undef_v8accfloatv() #24, !dbg !2038
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0, !dbg !2038
  %1 = extractvalue %struct.v8accfloat %call, 0, !dbg !2038
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32, !dbg !2038
  %2 = load %struct.v8accfloat, ptr %retval, align 32, !dbg !2039
  ret %struct.v8accfloat %2, !dbg !2039
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_Z16undef_v8accfloatv() addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %call = call x86_regcallcc addrspace(1) %struct.v8accfloat @__regcall3__chessintr_v8accfloat_undef_v8accfloat() #25
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0
  %1 = extractvalue %struct.v8accfloat %call, 0
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32
  %2 = load %struct.v8accfloat, ptr %retval, align 32
  ret %struct.v8accfloat %2
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8accfloat @__regcall3__chessintr_v8accfloat_undef_v8accfloat() addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv() addrspace(1) #6 comdat align 2 !dbg !2040 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv() #24, !dbg !2050
  %0 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !2050
  %1 = extractvalue %"class.aie::vector" %call, 0, !dbg !2050
  store %"class.aie::detail::vector_base" %1, ptr %0, align 32, !dbg !2050
  %2 = load %"class.aie::vector", ptr %retval, align 32, !dbg !2052
  ret %"class.aie::vector" %2, !dbg !2052
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv() addrspace(1) #6 comdat align 2 !dbg !2053 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %native_zeros_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::vector.0", align 32
  %agg.tmp = alloca %"class.aie::vector", align 32
  store i32 undef, ptr %native_zeros_elems, align 4, !dbg !2064
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_zeros_elems) #22, !dbg !2064
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_zeros_elems, metadata !2062, metadata !DIExpression()), !dbg !2065
  store i32 16, ptr %native_zeros_elems, align 4, !dbg !2065, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2063, metadata !DIExpression()), !dbg !2066
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !2066
  %0 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !2066, !tbaa !1704
  store %"class.aie::vector" %0, ptr %retval, align 32, !dbg !2066, !tbaa !1704
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !2067
  %call = call addrspace(1) %"class.aie::vector.0" @_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv() #24, !dbg !2067
  %1 = getelementptr inbounds %"class.aie::vector.0", ptr %ref.tmp, i32 0, i32 0, !dbg !2067
  %2 = extractvalue %"class.aie::vector.0" %call, 0, !dbg !2067
  store %"class.aie::detail::vector_base.1" %2, ptr %1, align 32, !dbg !2067
  %call1 = call addrspace(1) %"class.aie::vector" @_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %ref.tmp, i32 0) #24, !dbg !2070
  %3 = getelementptr inbounds %"class.aie::vector", ptr %agg.tmp, i32 0, i32 0, !dbg !2070
  %4 = extractvalue %"class.aie::vector" %call1, 0, !dbg !2070
  store %"class.aie::detail::vector_base" %4, ptr %3, align 32, !dbg !2070
  %5 = load %"class.aie::vector", ptr %agg.tmp, align 32, !dbg !2071, !tbaa !1704
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !2072
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_zeros_elems) #22, !dbg !2073
  ret %"class.aie::vector" %5, !dbg !2071
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.0" @_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv() addrspace(1) #6 comdat align 2 !dbg !2074 {
entry:
  %retval = alloca %"class.aie::vector.0", align 32
  %native_zeros_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector.0", align 32
  %tmp = alloca %"class.aie::vector.0", align 32
  %agg.tmp = alloca %struct.v16float, align 32
  store i32 undef, ptr %native_zeros_elems, align 4, !dbg !2085
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_zeros_elems) #22, !dbg !2085
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_zeros_elems, metadata !2083, metadata !DIExpression()), !dbg !2086
  store i32 16, ptr %native_zeros_elems, align 4, !dbg !2086, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2084, metadata !DIExpression()), !dbg !2087
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp) #24, !dbg !2087
  %0 = load %"class.aie::vector.0", ptr %custom_type.tmp, align 32, !dbg !2087, !tbaa !2088
  store %"class.aie::vector.0" %0, ptr %retval, align 32, !dbg !2087, !tbaa !2088
  %call = call addrspace(1) %struct.v16float @_Z26broadcast_zero_to_v16floatv() #24, !dbg !2092
  %1 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !2092
  %2 = extractvalue %struct.v16float %call, 0, !dbg !2092
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32, !dbg !2092
  %3 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !2092, !tbaa !2099
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %tmp, %struct.v16float %3) #24, !dbg !2092
  %4 = load %"class.aie::vector.0", ptr %tmp, align 32, !dbg !2100, !tbaa !2088
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_zeros_elems) #22, !dbg !2101
  ret %"class.aie::vector.0" %4, !dbg !2100
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2102 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::detail::vector_base", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2109, metadata !DIExpression()), !dbg !2112
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2111, metadata !DIExpression()), !dbg !2113
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2114
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2115, !tbaa !1755
  %call = call addrspace(1) %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this1, i32 %0) #24, !dbg !2116
  %1 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %ref.tmp, i32 0, i32 0, !dbg !2116
  %2 = extractvalue %"class.aie::detail::vector_base" %call, 0, !dbg !2116
  store %struct.v8float %2, ptr %1, align 32, !dbg !2116
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #24, !dbg !2114
  %3 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !2114, !tbaa !1704
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2117
  ret %"class.aie::vector" %3, !dbg !2114
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2118 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2120, metadata !DIExpression()), !dbg !2122
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this1) #24, !dbg !2123
  ret void, !dbg !2124
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z26broadcast_zero_to_v16floatv() addrspace(1) #6 comdat {
entry:
  %custom_type.tmp = alloca %struct.v16float, align 32
  %agg.tmp = alloca %struct.v16int32, align 32
  %call = call addrspace(1) %struct.v16int32 @_Z13broadcast_s32i(i32 0) #26
  %0 = getelementptr inbounds %struct.v16int32, ptr %agg.tmp, i32 0, i32 0
  %1 = extractvalue %struct.v16int32 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32
  %2 = load %struct.v16int32, ptr %agg.tmp, align 32, !tbaa !2099
  call addrspace(1) void @_ZN8v16floatC2E8v16int32(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16int32 %2) #27
  %3 = load %struct.v16float, ptr %custom_type.tmp, align 32, !tbaa !2099
  ret %struct.v16float %3
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16float %v.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2125 {
entry:
  %v = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16float %v.coerce, ptr %v, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2127, metadata !DIExpression()), !dbg !2129
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !2128, metadata !DIExpression()), !dbg !2130
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load %struct.v16float, ptr %v, align 32, !dbg !2131, !tbaa !2099
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this1, %struct.v16float %0) #24, !dbg !2131
  ret void, !dbg !2132
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZN3aie6detail14vector_storageIfLj16EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !2133 {
entry:
  %retval = alloca %struct.v16float, align 32
  %call = call addrspace(1) %struct.v16float @_Z14undef_v16floatv() #24, !dbg !2134
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !2134
  %1 = extractvalue %struct.v16float %call, 0, !dbg !2134
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !2134
  %2 = load %struct.v16float, ptr %retval, align 32, !dbg !2135
  ret %struct.v16float %2, !dbg !2135
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z14undef_v16floatv() addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_undef_v16float() #25
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
  store i32 %a0, ptr %a0.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %a0.addr, align 4, !tbaa !1755
  %call = call x86_regcallcc addrspace(1) %struct.v16int32 @__regcall3__chessintr_v16int32_broadcast_s32___sint(i32 signext %0) #25
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v16float, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v128int4.v128int4, ptr %custom_type.tmp, align 32, !tbaa !2099
  store %struct.ipd.custom_type.v128int4.v128int4 %0, ptr %mw, align 32, !tbaa !2099
  %1 = load %struct.v16int32, ptr %a0, align 32, !tbaa !2099
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_v16float_v16int32(%struct.v16int32 %1) #25
  %2 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  %4 = load %struct.v16float, ptr %agg.tmp, align 32, !tbaa !2099
  store %struct.v16float %4, ptr %this1, align 32, !tbaa !2099
  ret void
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16int32 @__regcall3__chessintr_v16int32_broadcast_s32___sint(i32 signext) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16float @__regcall3__chessintr_v16float_v16float_v16int32(%struct.v16int32) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2136 {
entry:
  %retval = alloca %"class.aie::detail::vector_base", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2141, metadata !DIExpression()), !dbg !2144
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2143, metadata !DIExpression()), !dbg !2145
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !2146

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2147, !tbaa !1755
  %cmp = icmp ult i32 %0, 2, !dbg !2147
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !2147
  br i1 %1, label %if.then, label %if.else, !dbg !2150

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !2151

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !2153, !tbaa !1755
  %cmp3 = icmp ult i32 %2, 2, !dbg !2153
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !2153
  br i1 %3, label %if.end, label %if.then4, !dbg !2156

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !2157), !dbg !2153
  br label %if.end, !dbg !2153

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !2156

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !2151

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !2158, !tbaa !1755
  %cmp5 = icmp ult i32 %4, 2, !dbg !2158
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !2158
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !2150

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !2160, !tbaa !1755
  %call = call addrspace(1) %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this1, i32 %5) #24, !dbg !2161
  %6 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %retval, i32 0, i32 0, !dbg !2161
  %7 = extractvalue %"class.aie::detail::vector_base" %call, 0, !dbg !2161
  store %struct.v8float %7, ptr %6, align 32, !dbg !2161
  %8 = load %"class.aie::detail::vector_base", ptr %retval, align 32, !dbg !2162
  ret %"class.aie::detail::vector_base" %8, !dbg !2162
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %v) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2163 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2165, metadata !DIExpression()), !dbg !2167
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2166, metadata !DIExpression()), !dbg !2168
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2169, !tbaa !1542
  %1 = load %"class.aie::detail::vector_base", ptr %0, align 32, !dbg !2170, !tbaa !2171
  store %"class.aie::detail::vector_base" %1, ptr %this1, align 32, !dbg !2170, !tbaa !2171
  ret void, !dbg !2172
}

; Function Attrs: convergent nocallback nofree nosync nounwind willreturn memory(none)
declare i1 @llvm.is.constant.i1(i1) addrspace(1) #17

; Function Attrs: nounwind willreturn memory(none)
declare i1 @llvm.chess_manifest(i1) addrspace(1) #7

; Function Attrs: nounwind willreturn
declare void @llvm.chess_error(metadata) addrspace(1) #18

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2173 {
entry:
  %retval = alloca %"class.aie::detail::vector_base", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %output_bits = alloca i32, align 4
  %agg.tmp = alloca %struct.v8float, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2177, metadata !DIExpression()), !dbg !2180
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2178, metadata !DIExpression()), !dbg !2181
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %output_bits, align 4, !dbg !2182
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %output_bits) #22, !dbg !2182
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %output_bits, metadata !2179, metadata !DIExpression()), !dbg !2183
  store i32 256, ptr %output_bits, align 4, !dbg !2183, !tbaa !1755
  %data = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %this1, i32 0, i32 0, !dbg !2184
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2192, !tbaa !1755
  %call = call addrspace(1) %struct.v8float @_ZN3aie6detailL14vector_extractILj8E8v16floatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %data, i32 noundef %0) #24, !dbg !2193
  %1 = getelementptr inbounds %struct.v8float, ptr %agg.tmp, i32 0, i32 0, !dbg !2193
  %2 = extractvalue %struct.v8float %call, 0, !dbg !2193
  store %struct.ipd.custom_type.v64int4.v64int4 %2, ptr %1, align 32, !dbg !2193
  %3 = load %struct.v8float, ptr %agg.tmp, align 32, !dbg !2193, !tbaa !2194
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float(ptr nonnull align 32 dereferenceable(32) %retval, %struct.v8float %3) #24, !dbg !2193
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %output_bits) #22, !dbg !2195
  %4 = load %"class.aie::detail::vector_base", ptr %retval, align 32, !dbg !2195
  ret %"class.aie::detail::vector_base" %4, !dbg !2195
}

; Function Attrs: inlinehint mustprogress nounwind
define internal %struct.v8float @_ZN3aie6detailL14vector_extractILj8E8v16floatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %v, i32 noundef %idx) addrspace(1) #5 !dbg !2196 {
entry:
  %retval = alloca %struct.v8float, align 32
  %v.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2202, metadata !DIExpression()), !dbg !2206
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2203, metadata !DIExpression()), !dbg !2207
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2208, !tbaa !1542
  %1 = load i32, ptr %idx.addr, align 4, !dbg !2209, !tbaa !1755
  %2 = load %struct.v16float, ptr %0, align 32, !dbg !2210, !tbaa !2099
  %call = call addrspace(1) %struct.v8float @_Z15extract_v8float8v16floati(%struct.v16float %2, i32 %1) #24, !dbg !2210
  %3 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0, !dbg !2210
  %4 = extractvalue %struct.v8float %call, 0, !dbg !2210
  store %struct.ipd.custom_type.v64int4.v64int4 %4, ptr %3, align 32, !dbg !2210
  %5 = load %struct.v8float, ptr %retval, align 32, !dbg !2211
  ret %struct.v8float %5, !dbg !2211
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float(ptr nonnull align 32 dereferenceable(32) %this, %struct.v8float %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2212 {
entry:
  %data = alloca %struct.v8float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v8float %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2214, metadata !DIExpression()), !dbg !2216
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !2215, metadata !DIExpression()), !dbg !2217
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !2218
  %0 = load %struct.v8float, ptr %data, align 32, !dbg !2219, !tbaa !2194
  store %struct.v8float %0, ptr %data2, align 32, !dbg !2219, !tbaa !2194
  ret void, !dbg !2220
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_Z15extract_v8float8v16floati(%struct.v16float %a.coerce, i32 %idx) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8float, align 32
  %a = alloca %struct.v16float, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v16float %a.coerce, ptr %a, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1755
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v16float, ptr %a, align 32, !tbaa !2099
  %call = call addrspace(1) %struct.v8float @_ZN12me_primitive6ext_xlE8v16float(%struct.v16float %1) #26
  %2 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v8float %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %3, ptr %2, align 32
  br label %return

if.else:                                          ; preds = %entry
  %4 = load %struct.v16float, ptr %a, align 32, !tbaa !2099
  %call1 = call addrspace(1) %struct.v8float @_ZN12me_primitive6ext_xhE8v16float(%struct.v16float %4) #26
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
  %0 = load %struct.v16float, ptr %a0, align 32, !tbaa !2099
  %call = call x86_regcallcc addrspace(1) %struct.v8float @__regcall3__chessintr_v8float_ext_xl_v16float(%struct.v16float %0) #25
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
  %0 = load %struct.v16float, ptr %a0, align 32, !tbaa !2099
  %call = call x86_regcallcc addrspace(1) %struct.v8float @__regcall3__chessintr_v8float_ext_xh_v16float(%struct.v16float %0) #25
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
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE(ptr %_w) addrspace(1) #6 comdat align 2 !dbg !2221 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %_w.addr = alloca ptr, align 4
  %w = alloca ptr, align 4
  %custom_type.tmp = alloca %"class.aie::accum", align 32
  %i = alloca i32, align 4
  %tmp = alloca %"class.aie::accum.2", align 32
  %custom_type.tmp1 = alloca %"class.aie::accum.2", align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %ref.tmp = alloca %"class.aie::accum", align 32
  store ptr %_w, ptr %_w.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %_w.addr, metadata !2223, metadata !DIExpression()), !dbg !2237
  store ptr undef, ptr %w, align 4, !dbg !2238
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %w) #22, !dbg !2238
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w, metadata !2224, metadata !DIExpression()), !dbg !2239
  %0 = load ptr, ptr %_w.addr, align 4, !dbg !2240, !tbaa !1542
  store ptr %0, ptr %w, align 4, !dbg !2239, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2225, metadata !DIExpression()), !dbg !2241
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !2241
  %1 = load %"class.aie::accum", ptr %custom_type.tmp, align 32, !dbg !2241, !tbaa !1718
  store %"class.aie::accum" %1, ptr %retval, align 32, !dbg !2241, !tbaa !1718
  store i32 undef, ptr %i, align 4, !dbg !2242
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %i) #22, !dbg !2242
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %i, metadata !2226, metadata !DIExpression()), !dbg !2243
  store i32 0, ptr %i, align 4, !dbg !2243, !tbaa !1755
  br label %for.cond, !dbg !2242

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, ptr %i, align 4, !dbg !2244, !tbaa !1755
  %cmp = icmp ult i32 %2, 1, !dbg !2245
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !2246

for.cond.cleanup:                                 ; preds = %for.cond
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %i) #22, !dbg !2247
  br label %for.end

for.body:                                         ; preds = %for.cond
  store %"class.aie::accum.2" undef, ptr %tmp, align 32, !dbg !2248
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %tmp) #22, !dbg !2248
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %tmp, metadata !2230, metadata !DIExpression()), !dbg !2249
  %3 = load ptr, ptr %w, align 4, !dbg !2250, !tbaa !1542
  %call = call addrspace(1) %struct.v16accfloat @_ZL12readincr_v16P13input_cascadeI8accfloatvE(ptr %3) #24, !dbg !2251
  %4 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !2251
  %5 = extractvalue %struct.v16accfloat %call, 0, !dbg !2251
  store %struct.ipd.custom_type.v16acc32.v16acc32 %5, ptr %4, align 32, !dbg !2251
  %6 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !2251, !tbaa !2252
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp1, %struct.v16accfloat %6) #24, !dbg !2251
  %7 = load %"class.aie::accum.2", ptr %custom_type.tmp1, align 32, !dbg !2251, !tbaa !2254
  store %"class.aie::accum.2" %7, ptr %tmp, align 32, !dbg !2251, !tbaa !2254
  %8 = load i32, ptr %i, align 4, !dbg !2257, !tbaa !1755
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2259
  %call2 = call addrspace(1) %"class.aie::accum" @_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(64) %tmp, i32 0) #24, !dbg !2260
  %9 = getelementptr inbounds %"class.aie::accum", ptr %ref.tmp, i32 0, i32 0, !dbg !2260
  %10 = extractvalue %"class.aie::accum" %call2, 0, !dbg !2260
  store %"class.aie::detail::accum_base" %10, ptr %9, align 32, !dbg !2260
  %call3 = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE(ptr nonnull align 32 dereferenceable(32) %retval, i32 %8, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #24, !dbg !2261
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2262
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %tmp) #22, !dbg !2263
  br label %for.inc, !dbg !2264

for.inc:                                          ; preds = %for.body
  %11 = load i32, ptr %i, align 4, !dbg !2265, !tbaa !1755
  %inc = add i32 %11, 1, !dbg !2265
  store i32 %inc, ptr %i, align 4, !dbg !2265, !tbaa !1755
  br label %for.cond, !dbg !2247, !llvm.loop !2266

for.end:                                          ; preds = %for.cond.cleanup
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %w) #22, !dbg !2269
  %12 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2269
  ret %"class.aie::accum" %12, !dbg !2269
}

; Function Attrs: inlinehint mustprogress nounwind
define internal %struct.v16accfloat @_ZL12readincr_v16P13input_cascadeI8accfloatvE(ptr %str) addrspace(1) #5 !dbg !2270 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %str.addr = alloca ptr, align 4
  store ptr %str, ptr %str.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %str.addr, metadata !2275, metadata !DIExpression()), !dbg !2276
  %call = call addrspace(1) %struct.v16accfloat @_Z19get_scd_v16accfloatv() #24, !dbg !2276
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2276
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !2276
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !2276
  %2 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2276
  ret %struct.v16accfloat %2, !dbg !2276
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16accfloat %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2277 {
entry:
  %data = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16accfloat %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2279, metadata !DIExpression()), !dbg !2282
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !2281, metadata !DIExpression()), !dbg !2283
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load %struct.v16accfloat, ptr %data, align 32, !dbg !2284, !tbaa !2252
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this1, %struct.v16accfloat %0) #24, !dbg !2284
  ret void, !dbg !2285
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local nonnull align 32 dereferenceable(32) ptr @_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2286 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %acc.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2295, metadata !DIExpression()), !dbg !2298
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2296, metadata !DIExpression()), !dbg !2299
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2297, metadata !DIExpression()), !dbg !2300
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2301, !tbaa !1755
  %1 = load ptr, ptr %acc.addr, align 4, !dbg !2302, !tbaa !1542
  %call = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0, ptr nonnull align 32 dereferenceable(32) %1) #24, !dbg !2303
  ret ptr %this1, !dbg !2304
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2305 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::accum", align 32
  %ref.tmp = alloca %"class.aie::detail::accum_base", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2310, metadata !DIExpression()), !dbg !2313
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2312, metadata !DIExpression()), !dbg !2314
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2315
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2316, !tbaa !1755
  %call = call addrspace(1) %"class.aie::detail::accum_base" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this1, i32 %0) #24, !dbg !2317
  %1 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %ref.tmp, i32 0, i32 0, !dbg !2317
  %2 = extractvalue %"class.aie::detail::accum_base" %call, 0, !dbg !2317
  store %struct.v8accfloat %2, ptr %1, align 32, !dbg !2317
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #24, !dbg !2318
  %3 = load %"class.aie::accum", ptr %custom_type.tmp, align 32, !dbg !2318, !tbaa !1718
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2319
  ret %"class.aie::accum" %3, !dbg !2318
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z19get_scd_v16accfloatv() addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %call = call addrspace(1) %struct.v16accfloat @_Z19get_scd_v16accfloati(i32 1) #24
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %1 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32
  %2 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %2
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z19get_scd_v16accfloati(i32 %en) addrspace(1) #6 comdat {
entry:
  %en.addr = alloca i32, align 4
  %custom_type.tmp = alloca %struct.v16accfloat, align 32
  %agg.tmp = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  store i32 %en, ptr %en.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %en.addr, align 4, !tbaa !1755
  %call = call addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @_Z16get_scd_v16acc32i(i32 %0) #28
  store %struct.ipd.custom_type.v16acc32.v16acc32 %call, ptr %agg.tmp, align 32
  %1 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp, align 32, !tbaa !2252
  call addrspace(1) void @_ZN11v16accfloatC2E8v16acc32(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.ipd.custom_type.v16acc32.v16acc32 %1) #27
  %2 = load %struct.v16accfloat, ptr %custom_type.tmp, align 32, !tbaa !2252
  ret %struct.v16accfloat %2
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.ipd.custom_type.v16acc32.v16acc32 @_Z16get_scd_v16acc32i(i32 %en) addrspace(1) #19 comdat {
entry:
  %en.addr = alloca i32, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %agg.tmp1 = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %agg.tmp2 = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  store i32 %en, ptr %en.addr, align 4, !tbaa !1755
  %0 = load volatile %struct.ipd.custom_type.v16acc32.v16acc32, ptr !register !1506, align 32, !tbaa !2252, !chess_protect_access !2320
  store %struct.ipd.custom_type.v16acc32.v16acc32 %0, ptr %agg.tmp1, align 32, !tbaa !2252
  %1 = load i32, ptr %en.addr, align 4, !tbaa !1755
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 %1) #24
  %2 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2321
  store %struct.ipd.custom_type.uint1_t.uint1_t %2, ptr %agg.tmp2, align 4, !tbaa !2321
  %3 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp1, align 32, !tbaa !2252
  %4 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp2, align 4, !tbaa !2321
  %call = call addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @_ZN12me_primitive8scd_readE8v16acc327uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %3, %struct.ipd.custom_type.uint1_t.uint1_t %4) #26
  store %struct.ipd.custom_type.v16acc32.v16acc32 %call, ptr %agg.tmp, align 32
  %5 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp, align 32, !tbaa !2252
  %call3 = call addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @_Z15chess_keep_deadI8v16acc32ET_S1_(%struct.ipd.custom_type.v16acc32.v16acc32 noundef %5) #29
  ret %struct.ipd.custom_type.v16acc32.v16acc32 %call3
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN11v16accfloatC2E8v16acc32(ptr nonnull align 32 dereferenceable(64) %this, %struct.ipd.custom_type.v16acc32.v16acc32 %a0.coerce) unnamed_addr addrspace(1) #16 comdat align 2 {
entry:
  %a0 = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %this.addr = alloca ptr, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  store %struct.ipd.custom_type.v16acc32.v16acc32 %a0.coerce, ptr %a0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v16accfloat, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %custom_type.tmp, align 32, !tbaa !2252
  store %struct.ipd.custom_type.v16acc32.v16acc32 %0, ptr %mw, align 32, !tbaa !2252
  %1 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %a0, align 32, !tbaa !2252
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_v16accfloat_v16acc32(%struct.ipd.custom_type.v16acc32.v16acc32 %1) #25
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !tbaa !2252
  store %struct.v16accfloat %4, ptr %this1, align 32, !tbaa !2252
  ret void
}

; Function Attrs: nounwind memory(inaccessiblemem: readwrite)
declare dso_local %struct.ipd.custom_type.v16acc32.v16acc32 @_Z15chess_keep_deadI8v16acc32ET_S1_(%struct.ipd.custom_type.v16acc32.v16acc32 noundef) addrspace(1) #20

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.ipd.custom_type.v16acc32.v16acc32 @_ZN12me_primitive8scd_readE8v16acc327uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %a0.coerce, %struct.ipd.custom_type.uint1_t.uint1_t %a1.coerce) addrspace(1) #15 comdat {
entry:
  %a0 = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %a1 = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  store %struct.ipd.custom_type.v16acc32.v16acc32 %a0.coerce, ptr %a0, align 32
  store %struct.ipd.custom_type.uint1_t.uint1_t %a1.coerce, ptr %a1, align 4
  %0 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %a0, align 32, !tbaa !2252
  %1 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a1, align 4, !tbaa !2321
  %call = call x86_regcallcc addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_scd_read_v16acc32_uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %0, %struct.ipd.custom_type.uint1_t.uint1_t %1) #25
  ret %struct.ipd.custom_type.v16acc32.v16acc32 %call
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %this, i32 %a) unnamed_addr addrspace(1) #11 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  store i32 %a, ptr %a.addr, align 4, !tbaa !1755
  %this1 = load ptr, ptr %this.addr, align 4
  store i1 false, ptr %this1, align 4
  %0 = load i32, ptr %a.addr, align 4, !tbaa !1755
  %1 = call addrspace(1) %struct.ipd.custom_type.uint1_t.uint1_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint1_t.uint1_ts.i32.p1(%struct.ipd.custom_type.uint1_t.uint1_t undef, i32 %0, i32 1, i32 32, i1 true, i32 0, ptr addrspace(1) @__regcall3__chessintr_uint1_t_uint1_t___sint)
  store %struct.ipd.custom_type.uint1_t.uint1_t %1, ptr %this1, align 4
  ret void
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_scd_read_v16acc32_uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32, %struct.ipd.custom_type.uint1_t.uint1_t) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.uint1_t.uint1_t @__regcall3__chessintr_uint1_t_uint1_t___sint(i32 signext) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare %struct.ipd.custom_type.uint1_t.uint1_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint1_t.uint1_ts.i32.p1(%struct.ipd.custom_type.uint1_t.uint1_t, i32, i32, i32, i1, i32, ptr addrspace(1)) addrspace(1) #7

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_v16accfloat_v16acc32(%struct.ipd.custom_type.v16acc32.v16acc32) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local nonnull align 32 dereferenceable(32) ptr @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2323 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %acc.addr = alloca ptr, align 4
  %in_num_subaccums = alloca i32, align 4
  %num_subaccums = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2332, metadata !DIExpression()), !dbg !2338
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2334, metadata !DIExpression()), !dbg !2339
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2335, metadata !DIExpression()), !dbg !2340
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %in_num_subaccums, align 4, !dbg !2341
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %in_num_subaccums) #22, !dbg !2341
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in_num_subaccums, metadata !2336, metadata !DIExpression()), !dbg !2342
  store i32 1, ptr %in_num_subaccums, align 4, !dbg !2342, !tbaa !1755
  store i32 undef, ptr %num_subaccums, align 4, !dbg !2343
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums) #22, !dbg !2343
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums, metadata !2337, metadata !DIExpression()), !dbg !2344
  store i32 1, ptr %num_subaccums, align 4, !dbg !2344, !tbaa !1755
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2345, !tbaa !1542
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %0, i32 0, i32 0, !dbg !2348
  %data2 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !2349
  %1 = load %struct.v8accfloat, ptr %data, align 32, !dbg !2350, !tbaa !2351
  store %struct.v8accfloat %1, ptr %data2, align 32, !dbg !2350, !tbaa !2351
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums) #22, !dbg !2352
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %in_num_subaccums) #22, !dbg !2352
  ret ptr %this1, !dbg !2353
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::accum_base" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2354 {
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2359, metadata !DIExpression()), !dbg !2371
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2361, metadata !DIExpression()), !dbg !2372
  %this1 = load ptr, ptr %this.addr, align 4
  store i8 undef, ptr %fpacc_128b, align 1, !dbg !2373
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %fpacc_128b) #22, !dbg !2373
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fpacc_128b, metadata !2362, metadata !DIExpression()), !dbg !2374
  store i8 0, ptr %fpacc_128b, align 1, !dbg !2374, !tbaa !2375
  store i32 undef, ptr %num_subaccums, align 4, !dbg !2377
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums) #22, !dbg !2377
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums, metadata !2363, metadata !DIExpression()), !dbg !2378
  store i32 1, ptr %num_subaccums, align 4, !dbg !2378, !tbaa !1755
  store i32 undef, ptr %num_subaccums_out, align 4, !dbg !2379
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums_out) #22, !dbg !2379
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums_out, metadata !2364, metadata !DIExpression()), !dbg !2380
  store i32 1, ptr %num_subaccums_out, align 4, !dbg !2380, !tbaa !1755
  store i32 undef, ptr %elems_per_subaccum, align 4, !dbg !2381
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %elems_per_subaccum) #22, !dbg !2381
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %elems_per_subaccum, metadata !2365, metadata !DIExpression()), !dbg !2382
  store i32 16, ptr %elems_per_subaccum, align 4, !dbg !2382, !tbaa !1755
  store i32 undef, ptr %out_elems_per_subaccum, align 4, !dbg !2383
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %out_elems_per_subaccum) #22, !dbg !2383
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out_elems_per_subaccum, metadata !2368, metadata !DIExpression()), !dbg !2384
  store i32 8, ptr %out_elems_per_subaccum, align 4, !dbg !2384, !tbaa !1755
  store i32 undef, ptr %ratio, align 4, !dbg !2385
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %ratio) #22, !dbg !2385
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ratio, metadata !2369, metadata !DIExpression()), !dbg !2386
  store i32 2, ptr %ratio, align 4, !dbg !2386, !tbaa !1755
  store %"class.aie::detail::accum_base" undef, ptr %ret, align 32, !dbg !2387
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ret) #22, !dbg !2387
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ret, metadata !2370, metadata !DIExpression()), !dbg !2388
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %ret) #24, !dbg !2388
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2389
  %data = getelementptr inbounds %"class.aie::detail::accum_base.3", ptr %this1, i32 0, i32 0, !dbg !2397
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2398, !tbaa !1755
  %call = call addrspace(1) %struct.v8accfloat @_ZN3aie6detailL13accum_extractILj8E11v16accfloatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %data, i32 %0) #24, !dbg !2389
  %1 = getelementptr inbounds %struct.v8accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !2389
  %2 = extractvalue %struct.v8accfloat %call, 0, !dbg !2389
  store %struct.ipd.custom_type.v8acc32.v8acc32 %2, ptr %1, align 32, !dbg !2389
  %3 = load %struct.v8accfloat, ptr %agg.tmp, align 32, !dbg !2389, !tbaa !2351
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat(ptr nonnull align 32 dereferenceable(32) %ref.tmp, %struct.v8accfloat %3) #24, !dbg !2389
  %4 = load %"class.aie::detail::accum_base", ptr %ref.tmp, align 32, !dbg !2399, !tbaa !2400
  store %"class.aie::detail::accum_base" %4, ptr %ret, align 32, !dbg !2399, !tbaa !2400
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2401
  %5 = load %"class.aie::detail::accum_base", ptr %ret, align 32, !dbg !2402, !tbaa !2400
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ret) #22, !dbg !2403
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %ratio) #22, !dbg !2403
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %out_elems_per_subaccum) #22, !dbg !2403
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %elems_per_subaccum) #22, !dbg !2403
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums_out) #22, !dbg !2404
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums) #22, !dbg !2404
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %fpacc_128b) #22, !dbg !2404
  ret %"class.aie::detail::accum_base" %5, !dbg !2402
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %a) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2405 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2407, metadata !DIExpression()), !dbg !2409
  store ptr %a, ptr %a.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !2408, metadata !DIExpression()), !dbg !2410
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %a.addr, align 4, !dbg !2411, !tbaa !1542
  %1 = load %"class.aie::detail::accum_base", ptr %0, align 32, !dbg !2412, !tbaa !2400
  store %"class.aie::detail::accum_base" %1, ptr %this1, align 32, !dbg !2412, !tbaa !2400
  ret void, !dbg !2413
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2414 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2416, metadata !DIExpression()), !dbg !2417
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !2418
  %call = call addrspace(1) %struct.v8accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv() #24, !dbg !2419
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %data, i32 0, i32 0, !dbg !2419
  %1 = extractvalue %struct.v8accfloat %call, 0, !dbg !2419
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32, !dbg !2419
  ret void, !dbg !2420
}

; Function Attrs: alwaysinline mustprogress nounwind
define internal %struct.v8accfloat @_ZN3aie6detailL13accum_extractILj8E11v16accfloatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %acc, i32 %idx) addrspace(1) #6 !dbg !2421 {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %acc.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2427, metadata !DIExpression()), !dbg !2431
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2428, metadata !DIExpression()), !dbg !2432
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2433, !tbaa !1542
  %1 = load i32, ptr %idx.addr, align 4, !dbg !2434, !tbaa !1755
  %2 = load %struct.v16accfloat, ptr %0, align 32, !dbg !2435, !tbaa !2252
  %call = call addrspace(1) %struct.v8accfloat @_Z18extract_v8accfloat11v16accfloati(%struct.v16accfloat %2, i32 %1) #24, !dbg !2435
  %3 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0, !dbg !2435
  %4 = extractvalue %struct.v8accfloat %call, 0, !dbg !2435
  store %struct.ipd.custom_type.v8acc32.v8acc32 %4, ptr %3, align 32, !dbg !2435
  %5 = load %struct.v8accfloat, ptr %retval, align 32, !dbg !2436
  ret %struct.v8accfloat %5, !dbg !2436
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat(ptr nonnull align 32 dereferenceable(32) %this, %struct.v8accfloat %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2437 {
entry:
  %data = alloca %struct.v8accfloat, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v8accfloat %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2439, metadata !DIExpression()), !dbg !2441
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !2440, metadata !DIExpression()), !dbg !2442
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !2443
  %0 = load %struct.v8accfloat, ptr %data, align 32, !dbg !2444, !tbaa !2351
  store %struct.v8accfloat %0, ptr %data2, align 32, !dbg !2444, !tbaa !2351
  ret void, !dbg !2445
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_Z18extract_v8accfloat11v16accfloati(%struct.v16accfloat %a.coerce, i32 %idx) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %a = alloca %struct.v16accfloat, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v16accfloat %a.coerce, ptr %a, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1755
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2252
  %call = call addrspace(1) %struct.v8accfloat @_ZN12me_primitive6ext_blE11v16accfloat(%struct.v16accfloat %1) #26
  %2 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v8accfloat %call, 0
  store %struct.ipd.custom_type.v8acc32.v8acc32 %3, ptr %2, align 32
  br label %return

if.else:                                          ; preds = %entry
  %4 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2252
  %call1 = call addrspace(1) %struct.v8accfloat @_ZN12me_primitive6ext_bhE11v16accfloat(%struct.v16accfloat %4) #26
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
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2252
  %call = call x86_regcallcc addrspace(1) %struct.v8accfloat @__regcall3__chessintr_v8accfloat_ext_bl_v16accfloat(%struct.v16accfloat %0) #25
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
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2252
  %call = call x86_regcallcc addrspace(1) %struct.v8accfloat @__regcall3__chessintr_v8accfloat_ext_bh_v16accfloat(%struct.v16accfloat %0) #25
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
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"class.aie::vector_elem_ref" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !2446 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"class.aie::vector_elem_ref", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.aie::unary_op.4", align 4
  store %"class.aie::vector_elem_ref" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2460, metadata !DIExpression()), !dbg !2465
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2461, metadata !DIExpression()), !dbg !2466
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2462, metadata !DIExpression()), !dbg !2467
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2468, !tbaa !1542
  %call = call addrspace(1) %"struct.aie::unary_op.4" @_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 4 dereferenceable(8) %a) #24, !dbg !2473
  %1 = getelementptr inbounds %"struct.aie::unary_op.4", ptr %agg.tmp, i32 0, i32 0, !dbg !2473
  %2 = extractvalue %"struct.aie::unary_op.4" %call, 0, !dbg !2473
  store %"struct.aie::unary_op_common.5" %2, ptr %1, align 4, !dbg !2473
  %3 = load ptr, ptr %v.addr, align 4, !dbg !2474, !tbaa !1542
  %4 = load %"struct.aie::unary_op.4", ptr %agg.tmp, align 4, !dbg !2475, !tbaa !2476
  %call1 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %0, %"struct.aie::unary_op.4" %4, ptr nonnull align 32 dereferenceable(32) %3) #24, !dbg !2475
  %5 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2475
  %6 = extractvalue %"class.aie::accum" %call1, 0, !dbg !2475
  store %"class.aie::detail::accum_base" %6, ptr %5, align 32, !dbg !2475
  %7 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2479
  ret %"class.aie::accum" %7, !dbg !2479
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"struct.aie::unary_op" @_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_(ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat !dbg !2480 {
entry:
  %retval = alloca %"struct.aie::unary_op", align 32
  %acc.addr = alloca ptr, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2484, metadata !DIExpression()), !dbg !2486
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2487, !tbaa !1542
  %1 = load %"class.aie::accum", ptr %0, align 32, !dbg !2488, !tbaa !1718
  call addrspace(1) void @_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_(ptr nonnull align 32 dereferenceable(32) %retval, %"class.aie::accum" noundef %1) #24, !dbg !2488
  %2 = load %"struct.aie::unary_op", ptr %retval, align 32, !dbg !2489
  ret %"struct.aie::unary_op" %2, !dbg !2489
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"struct.aie::unary_op.4" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !2490 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"struct.aie::unary_op.4", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.aie::unary_op.4", align 4
  %ref.tmp = alloca %"struct.aie::unary_op.6", align 32
  store %"struct.aie::unary_op.4" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2494, metadata !DIExpression()), !dbg !2499
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2495, metadata !DIExpression()), !dbg !2500
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2496, metadata !DIExpression()), !dbg !2501
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2502, !tbaa !1542
  %1 = load %"struct.aie::unary_op.4", ptr %a, align 4, !dbg !2508, !tbaa !2476
  store %"struct.aie::unary_op.4" %1, ptr %agg.tmp, align 4, !dbg !2508, !tbaa !2476
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2509
  %2 = load ptr, ptr %v.addr, align 4, !dbg !2510, !tbaa !1542
  %call = call addrspace(1) %"struct.aie::unary_op.6" @_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 32 dereferenceable(32) %2) #24, !dbg !2509
  %3 = getelementptr inbounds %"struct.aie::unary_op.6", ptr %ref.tmp, i32 0, i32 0, !dbg !2509
  %4 = extractvalue %"struct.aie::unary_op.6" %call, 0, !dbg !2509
  store %"struct.aie::unary_op_common.7" %4, ptr %3, align 32, !dbg !2509
  %5 = load %"struct.aie::unary_op.4", ptr %agg.tmp, align 4, !dbg !2511, !tbaa !2476
  %call1 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %0, %"struct.aie::unary_op.4" %5, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #24, !dbg !2511
  %6 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2511
  %7 = extractvalue %"class.aie::accum" %call1, 0, !dbg !2511
  store %"class.aie::detail::accum_base" %7, ptr %6, align 32, !dbg !2511
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2512
  %8 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2512
  ret %"class.aie::accum" %8, !dbg !2512
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"struct.aie::unary_op.4" @_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 4 dereferenceable(8) %e) addrspace(1) #6 comdat !dbg !2513 {
entry:
  %retval = alloca %"struct.aie::unary_op.4", align 4
  %e.addr = alloca ptr, align 4
  %agg.tmp = alloca %"class.aie::vector_elem_ref", align 4
  store ptr %e, ptr %e.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %e.addr, metadata !2517, metadata !DIExpression()), !dbg !2518
  %0 = load ptr, ptr %e.addr, align 4, !dbg !2519, !tbaa !1542
  %1 = load %"class.aie::vector_elem_ref", ptr %0, align 4, !dbg !2519, !tbaa !1815
  store %"class.aie::vector_elem_ref" %1, ptr %agg.tmp, align 4, !dbg !2519, !tbaa !1815
  %2 = load %"class.aie::vector_elem_ref", ptr %agg.tmp, align 4, !dbg !2520, !tbaa !1815
  call addrspace(1) void @_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 4 dereferenceable(8) %retval, %"class.aie::vector_elem_ref" noundef %2) #24, !dbg !2520
  %3 = load %"struct.aie::unary_op.4", ptr %retval, align 4, !dbg !2521
  ret %"struct.aie::unary_op.4" %3, !dbg !2521
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"struct.aie::unary_op.4" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !2522 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"struct.aie::unary_op.4", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %Op1 = alloca i32, align 4
  %Op2 = alloca i32, align 4
  %agg.tmp = alloca %"class.aie::vector_elem_const_ref", align 4
  %ref.tmp = alloca %"class.aie::vector_elem_ref", align 4
  %agg.tmp1 = alloca %"struct.aie::unary_op.4", align 4
  %ref.tmp3 = alloca %"class.aie::vector", align 32
  %agg.tmp5 = alloca %"struct.aie::unary_op.6", align 32
  %ref.tmp7 = alloca %"class.aie::accum", align 32
  store %"struct.aie::unary_op.4" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2527, metadata !DIExpression()), !dbg !2544
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2528, metadata !DIExpression()), !dbg !2545
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2529, metadata !DIExpression()), !dbg !2546
  store i32 undef, ptr %Op1, align 4, !dbg !2547
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %Op1) #22, !dbg !2547
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %Op1, metadata !2530, metadata !DIExpression()), !dbg !2548
  store i32 0, ptr %Op1, align 4, !dbg !2548, !tbaa !2549
  store i32 undef, ptr %Op2, align 4, !dbg !2551
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %Op2) #22, !dbg !2551
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %Op2, metadata !2541, metadata !DIExpression()), !dbg !2552
  store i32 0, ptr %Op2, align 4, !dbg !2552, !tbaa !2549
  call addrspace(1) void @llvm.lifetime.start.p0(i64 8, ptr %ref.tmp) #22, !dbg !2553
  %call = call addrspace(1) %"class.aie::vector_elem_ref" @_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 4 dereferenceable(8) %a) #24, !dbg !2555
  %0 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %ref.tmp, i32 0, i32 0, !dbg !2555
  %1 = extractvalue %"class.aie::vector_elem_ref" %call, 0, !dbg !2555
  store ptr %1, ptr %0, align 4, !dbg !2555
  %2 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %ref.tmp, i32 0, i32 1, !dbg !2555
  %3 = extractvalue %"class.aie::vector_elem_ref" %call, 1, !dbg !2555
  store i32 %3, ptr %2, align 4, !dbg !2555
  call addrspace(1) void @_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE(ptr nonnull align 4 dereferenceable(8) %agg.tmp, ptr nonnull align 4 dereferenceable(8) %ref.tmp) #24, !dbg !2556
  %4 = load %"struct.aie::unary_op.4", ptr %a, align 4, !dbg !2557, !tbaa !2476
  store %"struct.aie::unary_op.4" %4, ptr %agg.tmp1, align 4, !dbg !2557, !tbaa !2476
  %5 = load %"struct.aie::unary_op.4", ptr %agg.tmp1, align 4, !dbg !2558, !tbaa !2476
  %call2 = call zeroext addrspace(1) i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.4" %5) #24, !dbg !2558
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp3) #22, !dbg !2559
  %6 = load ptr, ptr %v.addr, align 4, !dbg !2559, !tbaa !1542
  %call4 = call addrspace(1) %"class.aie::vector" @_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %6) #24, !dbg !2560
  %7 = getelementptr inbounds %"class.aie::vector", ptr %ref.tmp3, i32 0, i32 0, !dbg !2560
  %8 = extractvalue %"class.aie::vector" %call4, 0, !dbg !2560
  store %"class.aie::detail::vector_base" %8, ptr %7, align 32, !dbg !2560
  %9 = load ptr, ptr %v.addr, align 4, !dbg !2561, !tbaa !1542
  %10 = load %"struct.aie::unary_op.6", ptr %9, align 32, !dbg !2561, !tbaa !2562
  store %"struct.aie::unary_op.6" %10, ptr %agg.tmp5, align 32, !dbg !2561, !tbaa !2562
  %11 = load %"struct.aie::unary_op.6", ptr %agg.tmp5, align 32, !dbg !2565, !tbaa !2562
  %call6 = call zeroext addrspace(1) i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.6" %11) #24, !dbg !2565
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp7) #22, !dbg !2566
  %12 = load ptr, ptr %acc.addr, align 4, !dbg !2566, !tbaa !1542
  %call8 = call addrspace(1) %"class.aie::accum" @_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %12) #24, !dbg !2567
  %13 = getelementptr inbounds %"class.aie::accum", ptr %ref.tmp7, i32 0, i32 0, !dbg !2567
  %14 = extractvalue %"class.aie::accum" %call8, 0, !dbg !2567
  store %"class.aie::detail::accum_base" %14, ptr %13, align 32, !dbg !2567
  %15 = load %"class.aie::vector_elem_const_ref", ptr %agg.tmp, align 4, !dbg !2568, !tbaa !2569
  %call9 = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_(%"class.aie::vector_elem_const_ref" %15, i1 zeroext %call2, ptr nonnull align 32 dereferenceable(32) %ref.tmp3, i1 zeroext %call6, ptr nonnull align 32 dereferenceable(32) %ref.tmp7) #24, !dbg !2568
  %16 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2568
  %17 = extractvalue %"class.aie::accum" %call9, 0, !dbg !2568
  store %"class.aie::detail::accum_base" %17, ptr %16, align 32, !dbg !2568
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp7) #22, !dbg !2571
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp3) #22, !dbg !2571
  call addrspace(1) void @llvm.lifetime.end.p0(i64 8, ptr %ref.tmp) #22, !dbg !2571
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %Op2) #22, !dbg !2572
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %Op1) #22, !dbg !2572
  %18 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2573
  ret %"class.aie::accum" %18, !dbg !2573
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"struct.aie::unary_op.6" @_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 32 dereferenceable(32) %e) addrspace(1) #6 comdat !dbg !2574 {
entry:
  %retval = alloca %"struct.aie::unary_op.6", align 32
  %e.addr = alloca ptr, align 4
  store ptr %e, ptr %e.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %e.addr, metadata !2578, metadata !DIExpression()), !dbg !2579
  %0 = load ptr, ptr %e.addr, align 4, !dbg !2580, !tbaa !1542
  %1 = load %"class.aie::vector", ptr %0, align 32, !dbg !2581, !tbaa !1704
  call addrspace(1) void @_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 32 dereferenceable(32) %retval, %"class.aie::vector" noundef %1) #24, !dbg !2581
  %2 = load %"struct.aie::unary_op.6", ptr %retval, align 32, !dbg !2582
  ret %"struct.aie::unary_op.6" %2, !dbg !2582
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_(%"class.aie::vector_elem_const_ref" %a.coerce, i1 zeroext %a_sign, ptr nonnull align 32 dereferenceable(32) %v, i1 zeroext %v_sign, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2583 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"class.aie::vector_elem_const_ref", align 4
  %a_sign.addr = alloca i8, align 1
  %v.addr = alloca ptr, align 4
  %v_sign.addr = alloca i8, align 1
  %acc.addr = alloca ptr, align 4
  store %"class.aie::vector_elem_const_ref" %a.coerce, ptr %a, align 4
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2607, metadata !DIExpression()), !dbg !2612
  %frombool = zext i1 %a_sign to i8
  store i8 %frombool, ptr %a_sign.addr, align 1, !tbaa !2375
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a_sign.addr, metadata !2608, metadata !DIExpression()), !dbg !2613
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2609, metadata !DIExpression()), !dbg !2614
  %frombool1 = zext i1 %v_sign to i8
  store i8 %frombool1, ptr %v_sign.addr, align 1, !tbaa !2375
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v_sign.addr, metadata !2610, metadata !DIExpression()), !dbg !2615
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2611, metadata !DIExpression()), !dbg !2616
  %call = call noundef addrspace(1) float @_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv(ptr nonnull align 4 dereferenceable(8) %a) #24, !dbg !2617
  %0 = load i8, ptr %a_sign.addr, align 1, !dbg !2618, !tbaa !2375, !range !2619, !noundef !137
  %tobool = trunc i8 %0 to i1, !dbg !2618
  %1 = load ptr, ptr %v.addr, align 4, !dbg !2620, !tbaa !1542
  %2 = load i8, ptr %v_sign.addr, align 1, !dbg !2621, !tbaa !2375, !range !2619, !noundef !137
  %tobool2 = trunc i8 %2 to i1, !dbg !2621
  %3 = load ptr, ptr %acc.addr, align 4, !dbg !2622, !tbaa !1542
  %call3 = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_(float %call, i1 zeroext %tobool, ptr nonnull align 32 dereferenceable(32) %1, i1 zeroext %tobool2, ptr nonnull align 32 dereferenceable(32) %3) #24, !dbg !2623
  %4 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2623
  %5 = extractvalue %"class.aie::accum" %call3, 0, !dbg !2623
  store %"class.aie::detail::accum_base" %5, ptr %4, align 32, !dbg !2623
  %6 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2624
  ret %"class.aie::accum" %6, !dbg !2624
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector_elem_ref" @_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #6 comdat align 2 !dbg !2625 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2632, metadata !DIExpression()), !dbg !2634
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.5", ptr %this1, i32 0, i32 0, !dbg !2635
  %0 = load %"class.aie::vector_elem_ref", ptr %parent_, align 4, !dbg !2635, !tbaa !1815
  ret %"class.aie::vector_elem_ref" %0, !dbg !2635
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE(ptr nonnull align 4 dereferenceable(8) %this, ptr nonnull align 4 dereferenceable(8) %ref) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !2637 {
entry:
  %this.addr = alloca ptr, align 4
  %ref.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2639, metadata !DIExpression()), !dbg !2642
  store ptr %ref, ptr %ref.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ref.addr, metadata !2641, metadata !DIExpression()), !dbg !2643
  %this1 = load ptr, ptr %this.addr, align 4
  %parent = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 0, !dbg !2644
  %0 = load ptr, ptr %ref.addr, align 4, !dbg !2645, !tbaa !1542
  %parent2 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %0, i32 0, i32 0, !dbg !2646
  %1 = load ptr, ptr %parent2, align 4, !dbg !2646, !tbaa !2647
  store ptr %1, ptr %parent, align 4, !dbg !2644, !tbaa !1542
  %offset = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 1, !dbg !2648
  %2 = load ptr, ptr %ref.addr, align 4, !dbg !2649, !tbaa !1542
  %offset3 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %2, i32 0, i32 1, !dbg !2650
  %3 = load i32, ptr %offset3, align 4, !dbg !2650, !tbaa !2651
  store i32 %3, ptr %offset, align 4, !dbg !2648, !tbaa !2652
  ret void, !dbg !2653
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local zeroext i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.4" %v.coerce) addrspace(1) #6 comdat !dbg !2654 {
entry:
  %v = alloca %"struct.aie::unary_op.4", align 4
  store %"struct.aie::unary_op.4" %v.coerce, ptr %v, align 4
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !2658, metadata !DIExpression()), !dbg !2661
  ret i1 true, !dbg !2662
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !2664 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2671, metadata !DIExpression()), !dbg !2673
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.7", ptr %this1, i32 0, i32 0, !dbg !2674
  %0 = load %"class.aie::vector", ptr %parent_, align 32, !dbg !2674, !tbaa !1704
  ret %"class.aie::vector" %0, !dbg !2674
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local zeroext i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.6" %v.coerce) addrspace(1) #6 comdat !dbg !2676 {
entry:
  %v = alloca %"struct.aie::unary_op.6", align 32
  store %"struct.aie::unary_op.6" %v.coerce, ptr %v, align 32
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !2680, metadata !DIExpression()), !dbg !2683
  ret i1 true, !dbg !2684
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !2686 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2693, metadata !DIExpression()), !dbg !2695
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common", ptr %this1, i32 0, i32 0, !dbg !2696
  %0 = load %"class.aie::accum", ptr %parent_, align 32, !dbg !2696, !tbaa !1718
  ret %"class.aie::accum" %0, !dbg !2696
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_(float %a, i1 zeroext %a_sign, ptr nonnull align 32 dereferenceable(32) %v, i1 zeroext %v_sign, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2698 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a.addr = alloca float, align 4
  %a_sign.addr = alloca i8, align 1
  %v.addr = alloca ptr, align 4
  %v_sign.addr = alloca i8, align 1
  %acc.addr = alloca ptr, align 4
  %ref.tmp = alloca %"class.aie::vector", align 32
  store float %a, ptr %a.addr, align 4, !tbaa !2713
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !2708, metadata !DIExpression()), !dbg !2715
  %frombool = zext i1 %a_sign to i8
  store i8 %frombool, ptr %a_sign.addr, align 1, !tbaa !2375
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a_sign.addr, metadata !2709, metadata !DIExpression()), !dbg !2716
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2710, metadata !DIExpression()), !dbg !2717
  %frombool1 = zext i1 %v_sign to i8
  store i8 %frombool1, ptr %v_sign.addr, align 1, !tbaa !2375
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v_sign.addr, metadata !2711, metadata !DIExpression()), !dbg !2718
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2712, metadata !DIExpression()), !dbg !2719
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2720
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a.addr) #24, !dbg !2720
  %0 = getelementptr inbounds %"class.aie::vector", ptr %ref.tmp, i32 0, i32 0, !dbg !2720
  %1 = extractvalue %"class.aie::vector" %call, 0, !dbg !2720
  store %"class.aie::detail::vector_base" %1, ptr %0, align 32, !dbg !2720
  %2 = load i8, ptr %a_sign.addr, align 1, !dbg !2721, !tbaa !2375, !range !2619, !noundef !137
  %tobool = trunc i8 %2 to i1, !dbg !2721
  %3 = load ptr, ptr %v.addr, align 4, !dbg !2722, !tbaa !1542
  %4 = load i8, ptr %v_sign.addr, align 1, !dbg !2723, !tbaa !2375, !range !2619, !noundef !137
  %tobool2 = trunc i8 %4 to i1, !dbg !2723
  %5 = load ptr, ptr %acc.addr, align 4, !dbg !2724, !tbaa !1542
  %call3 = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_(ptr nonnull align 32 dereferenceable(32) %ref.tmp, i1 zeroext %tobool, ptr nonnull align 32 dereferenceable(32) %3, i1 zeroext %tobool2, ptr nonnull align 32 dereferenceable(32) %5) #24, !dbg !2725
  %6 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2725
  %7 = extractvalue %"class.aie::accum" %call3, 0, !dbg !2725
  store %"class.aie::detail::accum_base" %7, ptr %6, align 32, !dbg !2725
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2726
  %8 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2726
  ret %"class.aie::accum" %8, !dbg !2726
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local noundef float @_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #9 comdat align 2 !dbg !2727 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2729, metadata !DIExpression()), !dbg !2731
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call noundef addrspace(1) float @_ZNK3aie21vector_elem_const_refIfLj8EE3getEv(ptr nonnull align 4 dereferenceable(8) %this1) #24, !dbg !2732
  ret float %call, !dbg !2733
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_(ptr nonnull align 32 dereferenceable(32) %v1, i1 zeroext %v1_sign, ptr nonnull align 32 dereferenceable(32) %v2, i1 zeroext %v2_sign, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2734 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %v1.addr = alloca ptr, align 4
  %v1_sign.addr = alloca i8, align 1
  %v2.addr = alloca ptr, align 4
  %v2_sign.addr = alloca i8, align 1
  %acc.addr = alloca ptr, align 4
  %mul_op = alloca %class.anon, align 1
  %num_mul = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::accum", align 32
  %ref.tmp = alloca %class.anon.8, align 4
  store ptr %v1, ptr %v1.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1.addr, metadata !2739, metadata !DIExpression()), !dbg !2749
  %frombool = zext i1 %v1_sign to i8
  store i8 %frombool, ptr %v1_sign.addr, align 1, !tbaa !2375
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1_sign.addr, metadata !2740, metadata !DIExpression()), !dbg !2750
  store ptr %v2, ptr %v2.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2.addr, metadata !2741, metadata !DIExpression()), !dbg !2751
  %frombool1 = zext i1 %v2_sign to i8
  store i8 %frombool1, ptr %v2_sign.addr, align 1, !tbaa !2375
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2_sign.addr, metadata !2742, metadata !DIExpression()), !dbg !2752
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2743, metadata !DIExpression()), !dbg !2753
  store %class.anon undef, ptr %mul_op, align 1, !dbg !2754
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %mul_op) #22, !dbg !2754
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mul_op, metadata !2744, metadata !DIExpression()), !dbg !2755
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 1 %mul_op, ptr align 1 @__const._ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_.mul_op, i32 1, i1 false), !dbg !2755
  store i32 undef, ptr %num_mul, align 4, !dbg !2756
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_mul) #22, !dbg !2756
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_mul, metadata !2747, metadata !DIExpression()), !dbg !2757
  store i32 1, ptr %num_mul, align 4, !dbg !2757, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2748, metadata !DIExpression()), !dbg !2758
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !2758
  %0 = load %"class.aie::accum", ptr %custom_type.tmp, align 32, !dbg !2758, !tbaa !1718
  store %"class.aie::accum" %0, ptr %retval, align 32, !dbg !2758, !tbaa !1718
  call addrspace(1) void @llvm.lifetime.start.p0(i64 20, ptr %ref.tmp) #22, !dbg !2759
  %1 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 0, !dbg !2759
  store ptr %mul_op, ptr %1, align 4, !dbg !2759, !tbaa !1542
  %2 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 1, !dbg !2759
  %3 = load ptr, ptr %v1.addr, align 4, !dbg !2760, !tbaa !1542
  store ptr %3, ptr %2, align 4, !dbg !2759, !tbaa !1542
  %4 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 2, !dbg !2759
  %5 = load ptr, ptr %v2.addr, align 4, !dbg !2760, !tbaa !1542
  store ptr %5, ptr %4, align 4, !dbg !2759, !tbaa !1542
  %6 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 3, !dbg !2759
  %7 = load ptr, ptr %acc.addr, align 4, !dbg !2760, !tbaa !1542
  store ptr %7, ptr %6, align 4, !dbg !2759, !tbaa !1542
  %8 = getelementptr inbounds %class.anon.8, ptr %ref.tmp, i32 0, i32 4, !dbg !2759
  store ptr %retval, ptr %8, align 4, !dbg !2759, !tbaa !1542
  call addrspace(1) void @_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_(ptr nonnull align 4 dereferenceable(20) %ref.tmp) #24, !dbg !2761
  call addrspace(1) void @llvm.lifetime.end.p0(i64 20, ptr %ref.tmp) #22, !dbg !2761
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_mul) #22, !dbg !2762
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %mul_op) #22, !dbg !2762
  %9 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2762
  ret %"class.aie::accum" %9, !dbg !2762
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a) addrspace(1) #9 comdat align 2 !dbg !2763 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %a.addr = alloca ptr, align 4
  store ptr %a, ptr %a.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !2772, metadata !DIExpression()), !dbg !2773
  %0 = load ptr, ptr %a.addr, align 4, !dbg !2774, !tbaa !1542
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %0) #24, !dbg !2775
  %1 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !2775
  %2 = extractvalue %"class.aie::vector" %call, 0, !dbg !2775
  store %"class.aie::detail::vector_base" %2, ptr %1, align 32, !dbg !2775
  %3 = load %"class.aie::vector", ptr %retval, align 32, !dbg !2776
  ret %"class.aie::vector" %3, !dbg !2776
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i32(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i32, i1 immarg) addrspace(1) #21

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat !dbg !2777 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2792, metadata !DIExpression()), !dbg !2796
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !2797, !tbaa !1542
  call addrspace(1) void @_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_(ptr nonnull align 4 dereferenceable(20) %0) #24, !dbg !2798
  ret void, !dbg !2799
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat !dbg !2800 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2802, metadata !DIExpression()), !dbg !2808
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !2809, !tbaa !1542
  call addrspace(1) void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %0) #24, !dbg !2810
  ret void, !dbg !2811
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat align 2 !dbg !2812 {
entry:
  %fn.addr = alloca ptr, align 4
  %it = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %agg.tmp = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %next_it = alloca i32, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2819, metadata !DIExpression()), !dbg !2835
  store %"struct.aie::detail::utils::iteration_dim" undef, ptr %it, align 1, !dbg !2836
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %it) #22, !dbg !2836
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %it, metadata !2820, metadata !DIExpression()), !dbg !2837
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 1 %it, ptr align 1 @__const._ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_.it, i32 1, i1 false), !dbg !2837
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !2838, !tbaa !1542
  call addrspace(1) void @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_(ptr nonnull align 4 dereferenceable(20) %0) #24, !dbg !2838
  store i32 undef, ptr %next_it, align 4, !dbg !2840
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %next_it) #22, !dbg !2840
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %next_it, metadata !2834, metadata !DIExpression()), !dbg !2841
  store i32 1, ptr %next_it, align 4, !dbg !2841, !tbaa !1755
  %1 = load ptr, ptr %fn.addr, align 4, !dbg !2842, !tbaa !1542
  call addrspace(1) void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %1) #24, !dbg !2843
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %next_it) #22, !dbg !2844
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %it) #22, !dbg !2844
  ret void, !dbg !2845
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_(ptr nonnull align 4 dereferenceable(20) %this) addrspace(1) #6 comdat align 2 !dbg !2846 {
entry:
  %idx = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %this.addr = alloca ptr, align 4
  %tmp = alloca %"class.aie::accum.2", align 32
  %custom_type.tmp = alloca %"class.aie::accum.2", align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %ref.tmp = alloca %"class.aie::vector.0", align 32
  %ref.tmp3 = alloca %"class.aie::vector.0", align 32
  %ref.tmp6 = alloca %"class.aie::accum.2", align 32
  %ref.tmp11 = alloca %"class.aie::accum", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2855, metadata !DIExpression()), !dbg !2861
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx, metadata !2857, metadata !DIExpression()), !dbg !2862
  %this1 = load ptr, ptr %this.addr, align 4
  store %"class.aie::accum.2" undef, ptr %tmp, align 32, !dbg !2863
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %tmp) #22, !dbg !2863
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %tmp, metadata !2858, metadata !DIExpression()), !dbg !2864
  %0 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 0, !dbg !2865
  %1 = load ptr, ptr %0, align 4, !dbg !2865, !tbaa !2866
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !2868
  %2 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 1, !dbg !2868
  %3 = load ptr, ptr %2, align 4, !dbg !2868, !tbaa !2869
  %call = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #24, !dbg !2870
  %call2 = call addrspace(1) %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %3, i32 %call) #24, !dbg !2871
  %4 = getelementptr inbounds %"class.aie::vector.0", ptr %ref.tmp, i32 0, i32 0, !dbg !2871
  %5 = extractvalue %"class.aie::vector.0" %call2, 0, !dbg !2871
  store %"class.aie::detail::vector_base.1" %5, ptr %4, align 32, !dbg !2871
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp3) #22, !dbg !2872
  %6 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 2, !dbg !2872
  %7 = load ptr, ptr %6, align 4, !dbg !2872, !tbaa !2873
  %call4 = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #24, !dbg !2874
  %call5 = call addrspace(1) %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %7, i32 %call4) #24, !dbg !2875
  %8 = getelementptr inbounds %"class.aie::vector.0", ptr %ref.tmp3, i32 0, i32 0, !dbg !2875
  %9 = extractvalue %"class.aie::vector.0" %call5, 0, !dbg !2875
  store %"class.aie::detail::vector_base.1" %9, ptr %8, align 32, !dbg !2875
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp6) #22, !dbg !2876
  %10 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 3, !dbg !2876
  %11 = load ptr, ptr %10, align 4, !dbg !2876, !tbaa !2877
  %call7 = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #24, !dbg !2878
  %call8 = call addrspace(1) %"class.aie::accum.2" @_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(32) %11, i32 %call7) #24, !dbg !2879
  %12 = getelementptr inbounds %"class.aie::accum.2", ptr %ref.tmp6, i32 0, i32 0, !dbg !2879
  %13 = extractvalue %"class.aie::accum.2" %call8, 0, !dbg !2879
  store %"class.aie::detail::accum_base.3" %13, ptr %12, align 32, !dbg !2879
  %call9 = call addrspace(1) %struct.v16accfloat @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_(ptr nonnull align 1 dereferenceable(1) %1, ptr nonnull align 32 dereferenceable(64) %ref.tmp, ptr nonnull align 32 dereferenceable(64) %ref.tmp3, ptr nonnull align 32 dereferenceable(64) %ref.tmp6) #24, !dbg !2865
  %14 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !2865
  %15 = extractvalue %struct.v16accfloat %call9, 0, !dbg !2865
  store %struct.ipd.custom_type.v16acc32.v16acc32 %15, ptr %14, align 32, !dbg !2865
  %16 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !2865, !tbaa !2252
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16accfloat %16) #24, !dbg !2865
  %17 = load %"class.aie::accum.2", ptr %custom_type.tmp, align 32, !dbg !2865, !tbaa !2254
  store %"class.aie::accum.2" %17, ptr %tmp, align 32, !dbg !2865, !tbaa !2254
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp6) #22, !dbg !2865
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp3) #22, !dbg !2865
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !2865
  %18 = getelementptr inbounds %class.anon.8, ptr %this1, i32 0, i32 4, !dbg !2880
  %19 = load ptr, ptr %18, align 4, !dbg !2880, !tbaa !2881
  %call10 = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #24, !dbg !2882
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp11) #22, !dbg !2883
  %call12 = call addrspace(1) %"class.aie::accum" @_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(64) %tmp, i32 0) #24, !dbg !2884
  %20 = getelementptr inbounds %"class.aie::accum", ptr %ref.tmp11, i32 0, i32 0, !dbg !2884
  %21 = extractvalue %"class.aie::accum" %call12, 0, !dbg !2884
  store %"class.aie::detail::accum_base" %21, ptr %20, align 32, !dbg !2884
  %call13 = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE(ptr nonnull align 32 dereferenceable(32) %19, i32 %call10, ptr nonnull align 32 dereferenceable(32) %ref.tmp11) #24, !dbg !2885
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp11) #22, !dbg !2880
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %tmp) #22, !dbg !2886
  ret void, !dbg !2886
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat align 2 !dbg !2887 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2893, metadata !DIExpression()), !dbg !2894
  ret void, !dbg !2895
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 32 dereferenceable(64) %args, ptr nonnull align 32 dereferenceable(64) %args1, ptr nonnull align 32 dereferenceable(64) %args3) addrspace(1) #6 comdat align 2 !dbg !2896 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  %args.addr = alloca ptr, align 4
  %args.addr2 = alloca ptr, align 4
  %args.addr4 = alloca ptr, align 4
  %agg.tmp = alloca %struct.v16float, align 32
  %agg.tmp6 = alloca %struct.v16float, align 32
  %agg.tmp8 = alloca %struct.v16accfloat, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2909, metadata !DIExpression()), !dbg !2914
  store ptr %args, ptr %args.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %args.addr, metadata !2911, metadata !DIExpression()), !dbg !2915
  store ptr %args1, ptr %args.addr2, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %args.addr2, metadata !2912, metadata !DIExpression()), !dbg !2915
  store ptr %args3, ptr %args.addr4, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %args.addr4, metadata !2913, metadata !DIExpression()), !dbg !2915
  %this5 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %args.addr, align 4, !dbg !2916, !tbaa !1542
  %call = call addrspace(1) %struct.v16float @_ZNK3aie6vectorIfLj16EEcv8v16floatEv(ptr nonnull align 32 dereferenceable(64) %0) #24, !dbg !2916
  %1 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !2916
  %2 = extractvalue %struct.v16float %call, 0, !dbg !2916
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32, !dbg !2916
  %3 = load ptr, ptr %args.addr2, align 4, !dbg !2916, !tbaa !1542
  %call7 = call addrspace(1) %struct.v16float @_ZNK3aie6vectorIfLj16EEcv8v16floatEv(ptr nonnull align 32 dereferenceable(64) %3) #24, !dbg !2916
  %4 = getelementptr inbounds %struct.v16float, ptr %agg.tmp6, i32 0, i32 0, !dbg !2916
  %5 = extractvalue %struct.v16float %call7, 0, !dbg !2916
  store %struct.ipd.custom_type.v128int4.v128int4 %5, ptr %4, align 32, !dbg !2916
  %6 = load ptr, ptr %args.addr4, align 4, !dbg !2916, !tbaa !1542
  %call9 = call addrspace(1) %struct.v16accfloat @_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %6) #24, !dbg !2916
  %7 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp8, i32 0, i32 0, !dbg !2916
  %8 = extractvalue %struct.v16accfloat %call9, 0, !dbg !2916
  store %struct.ipd.custom_type.v16acc32.v16acc32 %8, ptr %7, align 32, !dbg !2916
  %9 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !2917, !tbaa !2099
  %10 = load %struct.v16float, ptr %agg.tmp6, align 32, !dbg !2917, !tbaa !2099
  %11 = load %struct.v16accfloat, ptr %agg.tmp8, align 32, !dbg !2917, !tbaa !2252
  %call10 = call addrspace(1) %struct.v16accfloat @_Z11mac_elem_168v16floatS_11v16accfloat(%struct.v16float %9, %struct.v16float %10, %struct.v16accfloat %11) #24, !dbg !2917
  %12 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2917
  %13 = extractvalue %struct.v16accfloat %call10, 0, !dbg !2917
  store %struct.ipd.custom_type.v16acc32.v16acc32 %13, ptr %12, align 32, !dbg !2917
  %14 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2918
  ret %struct.v16accfloat %14, !dbg !2918
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2919 {
entry:
  %retval = alloca %"class.aie::vector.0", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2926, metadata !DIExpression()), !dbg !2929
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2928, metadata !DIExpression()), !dbg !2930
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 0) #24, !dbg !2931
  %0 = getelementptr inbounds %"class.aie::vector.0", ptr %retval, i32 0, i32 0, !dbg !2931
  %1 = extractvalue %"class.aie::vector.0" %call, 0, !dbg !2931
  store %"class.aie::detail::vector_base.1" %1, ptr %0, align 32, !dbg !2931
  %2 = load %"class.aie::vector.0", ptr %retval, align 32, !dbg !2933
  ret %"class.aie::vector.0" %2, !dbg !2933
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local noundef i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %this) addrspace(1) #9 comdat align 2 !dbg !2934 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2936, metadata !DIExpression()), !dbg !2938
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv(ptr nonnull align 1 dereferenceable(1) %this1) #24, !dbg !2939
  ret i32 %call, !dbg !2940
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum.2" @_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2941 {
entry:
  %retval = alloca %"class.aie::accum.2", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2946, metadata !DIExpression()), !dbg !2949
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2948, metadata !DIExpression()), !dbg !2950
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %"class.aie::accum.2" @_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv(ptr nonnull align 32 dereferenceable(32) %this1) #24, !dbg !2951
  %0 = getelementptr inbounds %"class.aie::accum.2", ptr %retval, i32 0, i32 0, !dbg !2951
  %1 = extractvalue %"class.aie::accum.2" %call, 0, !dbg !2951
  store %"class.aie::detail::accum_base.3" %1, ptr %0, align 32, !dbg !2951
  %2 = load %"class.aie::accum.2", ptr %retval, align 32, !dbg !2953
  ret %"class.aie::accum.2" %2, !dbg !2953
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z11mac_elem_168v16floatS_11v16accfloat(%struct.v16float %v1.coerce, %struct.v16float %v2.coerce, %struct.v16accfloat %acc.coerce) addrspace(1) #6 comdat !dbg !2954 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %v1 = alloca %struct.v16float, align 32
  %v2 = alloca %struct.v16float, align 32
  %acc = alloca %struct.v16accfloat, align 32
  store %struct.v16float %v1.coerce, ptr %v1, align 32
  store %struct.v16float %v2.coerce, ptr %v2, align 32
  store %struct.v16accfloat %acc.coerce, ptr %acc, align 32
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1, metadata !2959, metadata !DIExpression()), !dbg !2962
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2, metadata !2960, metadata !DIExpression()), !dbg !2962
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !2961, metadata !DIExpression()), !dbg !2962
  %0 = load %struct.v16float, ptr %v1, align 32, !dbg !2962, !tbaa !2099
  %1 = load %struct.v16float, ptr %v2, align 32, !dbg !2962, !tbaa !2099
  %2 = load %struct.v16accfloat, ptr %acc, align 32, !dbg !2962, !tbaa !2252
  %call = call addrspace(1) %struct.v16accfloat @_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii(%struct.v16float %0, %struct.v16float %1, %struct.v16accfloat %2, i32 0, i32 0, i32 0) #24, !dbg !2962
  %3 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2962
  %4 = extractvalue %struct.v16accfloat %call, 0, !dbg !2962
  store %struct.ipd.custom_type.v16acc32.v16acc32 %4, ptr %3, align 32, !dbg !2962
  %5 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2962
  ret %struct.v16accfloat %5, !dbg !2962
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZNK3aie6vectorIfLj16EEcv8v16floatEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !2963 {
entry:
  %retval = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2965, metadata !DIExpression()), !dbg !2966
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v16float @_ZNK3aie6vectorIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this1) #24, !dbg !2967
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !2967
  %1 = extractvalue %struct.v16float %call, 0, !dbg !2967
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !2967
  %2 = load %struct.v16float, ptr %retval, align 32, !dbg !2968
  ret %struct.v16float %2, !dbg !2968
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !2969 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2971, metadata !DIExpression()), !dbg !2972
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v16accfloat @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %this1) #24, !dbg !2973
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2973
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !2973
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !2973
  %2 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2974
  ret %struct.v16accfloat %2, !dbg !2974
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii(%struct.v16float %v1.coerce, %struct.v16float %v2.coerce, %struct.v16accfloat %acc.coerce, i32 %zero_acc, i32 %sub_mul, i32 %sub_acc1) addrspace(1) #6 comdat !dbg !2975 {
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
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1, metadata !2979, metadata !DIExpression()), !dbg !2986
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2, metadata !2980, metadata !DIExpression()), !dbg !2986
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !2981, metadata !DIExpression()), !dbg !2986
  store i32 %zero_acc, ptr %zero_acc.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %zero_acc.addr, metadata !2982, metadata !DIExpression()), !dbg !2986
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_mul.addr, metadata !2983, metadata !DIExpression()), !dbg !2986
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_acc1.addr, metadata !2984, metadata !DIExpression()), !dbg !2986
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2985, metadata !DIExpression()), !dbg !2986
  %0 = load i32, ptr %zero_acc.addr, align 4, !dbg !2986, !tbaa !1755
  %1 = load i32, ptr %sub_mul.addr, align 4, !dbg !2986, !tbaa !1755
  %2 = load i32, ptr %sub_acc1.addr, align 4, !dbg !2986, !tbaa !1755
  %3 = load %struct.v16float, ptr %v1, align 32, !dbg !2986, !tbaa !2099
  %4 = load %struct.v16float, ptr %v2, align 32, !dbg !2986, !tbaa !2099
  %5 = load %struct.v16accfloat, ptr %acc, align 32, !dbg !2986, !tbaa !2252
  %call = call addrspace(1) %struct.v16accfloat @_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii(%struct.v16float %3, %struct.v16float %4, %struct.v16accfloat %5, i32 %0, i32 %1, i32 %2) #24, !dbg !2986
  %6 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2986
  %7 = extractvalue %struct.v16accfloat %call, 0, !dbg !2986
  store %struct.ipd.custom_type.v16acc32.v16acc32 %7, ptr %6, align 32, !dbg !2986
  %8 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2986
  ret %struct.v16accfloat %8, !dbg !2986
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii(%struct.v16float %v1.coerce, %struct.v16float %v2.coerce, %struct.v16accfloat %acc.coerce, i32 %zero_acc, i32 %sub_mul, i32 %sub_acc1) addrspace(1) #6 comdat !dbg !2987 {
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
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1, metadata !2990, metadata !DIExpression()), !dbg !3005
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2, metadata !2991, metadata !DIExpression()), !dbg !3006
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !2992, metadata !DIExpression()), !dbg !3007
  store i32 %zero_acc, ptr %zero_acc.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %zero_acc.addr, metadata !2993, metadata !DIExpression()), !dbg !3008
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_mul.addr, metadata !2994, metadata !DIExpression()), !dbg !3009
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_acc1.addr, metadata !2995, metadata !DIExpression()), !dbg !3010
  store %struct.v32bfloat16 undef, ptr %a, align 32, !dbg !3011
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %a) #22, !dbg !3011
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2996, metadata !DIExpression()), !dbg !3012
  %call = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3013
  %0 = getelementptr inbounds %struct.v32bfloat16, ptr %a, i32 0, i32 0, !dbg !3013
  %1 = extractvalue %struct.v32bfloat16 %call, 0, !dbg !3013
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !3013
  store %struct.v32bfloat16 undef, ptr %b, align 32, !dbg !3014
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %b) #22, !dbg !3014
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %b, metadata !2997, metadata !DIExpression()), !dbg !3015
  %call1 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3016
  %2 = getelementptr inbounds %struct.v32bfloat16, ptr %b, i32 0, i32 0, !dbg !3016
  %3 = extractvalue %struct.v32bfloat16 %call1, 0, !dbg !3016
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32, !dbg !3016
  store %struct.v32bfloat16 undef, ptr %c, align 32, !dbg !3017
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %c) #22, !dbg !3017
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %c, metadata !2998, metadata !DIExpression()), !dbg !3018
  %call2 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3019
  %4 = getelementptr inbounds %struct.v32bfloat16, ptr %c, i32 0, i32 0, !dbg !3019
  %5 = extractvalue %struct.v32bfloat16 %call2, 0, !dbg !3019
  store %struct.ipd.custom_type.v128int4.v128int4 %5, ptr %4, align 32, !dbg !3019
  store %struct.v32bfloat16 undef, ptr %d, align 32, !dbg !3020
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %d) #22, !dbg !3020
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %d, metadata !2999, metadata !DIExpression()), !dbg !3021
  %call3 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3022
  %6 = getelementptr inbounds %struct.v32bfloat16, ptr %d, i32 0, i32 0, !dbg !3022
  %7 = extractvalue %struct.v32bfloat16 %call3, 0, !dbg !3022
  store %struct.ipd.custom_type.v128int4.v128int4 %7, ptr %6, align 32, !dbg !3022
  store %struct.v32bfloat16 undef, ptr %e, align 32, !dbg !3023
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %e) #22, !dbg !3023
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %e, metadata !3000, metadata !DIExpression()), !dbg !3024
  %call4 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3025
  %8 = getelementptr inbounds %struct.v32bfloat16, ptr %e, i32 0, i32 0, !dbg !3025
  %9 = extractvalue %struct.v32bfloat16 %call4, 0, !dbg !3025
  store %struct.ipd.custom_type.v128int4.v128int4 %9, ptr %8, align 32, !dbg !3025
  store %struct.v32bfloat16 undef, ptr %f, align 32, !dbg !3026
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %f) #22, !dbg !3026
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %f, metadata !3001, metadata !DIExpression()), !dbg !3027
  %call5 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3028
  %10 = getelementptr inbounds %struct.v32bfloat16, ptr %f, i32 0, i32 0, !dbg !3028
  %11 = extractvalue %struct.v32bfloat16 %call5, 0, !dbg !3028
  store %struct.ipd.custom_type.v128int4.v128int4 %11, ptr %10, align 32, !dbg !3028
  store %struct.v32bfloat16 undef, ptr %dummy0, align 32, !dbg !3029
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %dummy0) #22, !dbg !3029
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %dummy0, metadata !3002, metadata !DIExpression()), !dbg !3030
  %call6 = call addrspace(1) %struct.v32bfloat16 @_Z28broadcast_one_to_v32bfloat16v() #24, !dbg !3031
  %12 = getelementptr inbounds %struct.v32bfloat16, ptr %dummy0, i32 0, i32 0, !dbg !3031
  %13 = extractvalue %struct.v32bfloat16 %call6, 0, !dbg !3031
  store %struct.ipd.custom_type.v128int4.v128int4 %13, ptr %12, align 32, !dbg !3031
  %14 = load %struct.v16float, ptr %v1, align 32, !dbg !3032, !tbaa !2099
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16float %14) #27, !dbg !3032
  %15 = load %struct.v16accfloat, ptr %custom_type.tmp, align 32, !dbg !3032, !tbaa !2252
  store %struct.v16accfloat %15, ptr %agg.tmp7, align 32, !dbg !3032, !tbaa !2252
  %16 = load %struct.v16accfloat, ptr %agg.tmp7, align 32, !dbg !3033, !tbaa !2252
  %call8 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %16) #24, !dbg !3033
  %17 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp, i32 0, i32 0, !dbg !3033
  %18 = extractvalue %struct.v16bfloat16 %call8, 0, !dbg !3033
  store %struct.ipd.custom_type.v64int4.v64int4 %18, ptr %17, align 32, !dbg !3033
  %19 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3034, !tbaa !2099
  %20 = load %struct.v16bfloat16, ptr %agg.tmp, align 32, !dbg !3034, !tbaa !2194
  %call9 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %19, i32 0, %struct.v16bfloat16 %20) #24, !dbg !3034
  %21 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp10, i32 0, i32 0, !dbg !3034
  %22 = extractvalue %struct.v32bfloat16 %call9, 0, !dbg !3034
  store %struct.ipd.custom_type.v128int4.v128int4 %22, ptr %21, align 32, !dbg !3034
  %23 = load %struct.v32bfloat16, ptr %agg.tmp10, align 32, !dbg !3035, !tbaa !2099
  store %struct.v32bfloat16 %23, ptr %a, align 32, !dbg !3035, !tbaa !2099
  store %struct.v16accfloat undef, ptr %acc0, align 32, !dbg !3036
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %acc0) #22, !dbg !3036
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc0, metadata !3003, metadata !DIExpression()), !dbg !3037
  %24 = load %struct.v16float, ptr %v1, align 32, !dbg !3038, !tbaa !2099
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp12, %struct.v16float %24) #27, !dbg !3038
  %25 = load %struct.v16accfloat, ptr %custom_type.tmp12, align 32, !dbg !3038, !tbaa !2252
  store %struct.v16accfloat %25, ptr %agg.tmp11, align 32, !dbg !3038, !tbaa !2252
  %26 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3039, !tbaa !2099
  %27 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !3039, !tbaa !2099
  %28 = load %struct.v16accfloat, ptr %agg.tmp11, align 32, !dbg !3039, !tbaa !2252
  %call13 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %26, %struct.v32bfloat16 %27, %struct.v16accfloat %28) #24, !dbg !3039
  %29 = getelementptr inbounds %struct.v16accfloat, ptr %acc0, i32 0, i32 0, !dbg !3039
  %30 = extractvalue %struct.v16accfloat %call13, 0, !dbg !3039
  store %struct.ipd.custom_type.v16acc32.v16acc32 %30, ptr %29, align 32, !dbg !3039
  %31 = load %struct.v16accfloat, ptr %acc0, align 32, !dbg !3040, !tbaa !2252
  %call15 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %31) #24, !dbg !3040
  %32 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp14, i32 0, i32 0, !dbg !3040
  %33 = extractvalue %struct.v16bfloat16 %call15, 0, !dbg !3040
  store %struct.ipd.custom_type.v64int4.v64int4 %33, ptr %32, align 32, !dbg !3040
  %34 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !3041, !tbaa !2099
  %35 = load %struct.v16bfloat16, ptr %agg.tmp14, align 32, !dbg !3041, !tbaa !2194
  %call16 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %34, i32 0, %struct.v16bfloat16 %35) #24, !dbg !3041
  %36 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp17, i32 0, i32 0, !dbg !3041
  %37 = extractvalue %struct.v32bfloat16 %call16, 0, !dbg !3041
  store %struct.ipd.custom_type.v128int4.v128int4 %37, ptr %36, align 32, !dbg !3041
  %38 = load %struct.v32bfloat16, ptr %agg.tmp17, align 32, !dbg !3042, !tbaa !2099
  store %struct.v32bfloat16 %38, ptr %b, align 32, !dbg !3042, !tbaa !2099
  %39 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !3043, !tbaa !2099
  %40 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !3043, !tbaa !2099
  %41 = load %struct.v16accfloat, ptr %acc0, align 32, !dbg !3043, !tbaa !2252
  %call20 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %39, %struct.v32bfloat16 %40, %struct.v16accfloat %41) #24, !dbg !3043
  %42 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp19, i32 0, i32 0, !dbg !3043
  %43 = extractvalue %struct.v16accfloat %call20, 0, !dbg !3043
  store %struct.ipd.custom_type.v16acc32.v16acc32 %43, ptr %42, align 32, !dbg !3043
  %44 = load %struct.v16accfloat, ptr %agg.tmp19, align 32, !dbg !3044, !tbaa !2252
  %call21 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %44) #24, !dbg !3044
  %45 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp18, i32 0, i32 0, !dbg !3044
  %46 = extractvalue %struct.v16bfloat16 %call21, 0, !dbg !3044
  store %struct.ipd.custom_type.v64int4.v64int4 %46, ptr %45, align 32, !dbg !3044
  %47 = load %struct.v32bfloat16, ptr %c, align 32, !dbg !3045, !tbaa !2099
  %48 = load %struct.v16bfloat16, ptr %agg.tmp18, align 32, !dbg !3045, !tbaa !2194
  %call22 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %47, i32 0, %struct.v16bfloat16 %48) #24, !dbg !3045
  %49 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp23, i32 0, i32 0, !dbg !3045
  %50 = extractvalue %struct.v32bfloat16 %call22, 0, !dbg !3045
  store %struct.ipd.custom_type.v128int4.v128int4 %50, ptr %49, align 32, !dbg !3045
  %51 = load %struct.v32bfloat16, ptr %agg.tmp23, align 32, !dbg !3046, !tbaa !2099
  store %struct.v32bfloat16 %51, ptr %c, align 32, !dbg !3046, !tbaa !2099
  %52 = load %struct.v16float, ptr %v2, align 32, !dbg !3047, !tbaa !2099
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp26, %struct.v16float %52) #27, !dbg !3047
  %53 = load %struct.v16accfloat, ptr %custom_type.tmp26, align 32, !dbg !3047, !tbaa !2252
  store %struct.v16accfloat %53, ptr %agg.tmp25, align 32, !dbg !3047, !tbaa !2252
  %54 = load %struct.v16accfloat, ptr %agg.tmp25, align 32, !dbg !3048, !tbaa !2252
  %call27 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %54) #24, !dbg !3048
  %55 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp24, i32 0, i32 0, !dbg !3048
  %56 = extractvalue %struct.v16bfloat16 %call27, 0, !dbg !3048
  store %struct.ipd.custom_type.v64int4.v64int4 %56, ptr %55, align 32, !dbg !3048
  %57 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3049, !tbaa !2099
  %58 = load %struct.v16bfloat16, ptr %agg.tmp24, align 32, !dbg !3049, !tbaa !2194
  %call28 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %57, i32 0, %struct.v16bfloat16 %58) #24, !dbg !3049
  %59 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp29, i32 0, i32 0, !dbg !3049
  %60 = extractvalue %struct.v32bfloat16 %call28, 0, !dbg !3049
  store %struct.ipd.custom_type.v128int4.v128int4 %60, ptr %59, align 32, !dbg !3049
  %61 = load %struct.v32bfloat16, ptr %agg.tmp29, align 32, !dbg !3050, !tbaa !2099
  store %struct.v32bfloat16 %61, ptr %d, align 32, !dbg !3050, !tbaa !2099
  store %struct.v16accfloat undef, ptr %acc1, align 32, !dbg !3051
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %acc1) #22, !dbg !3051
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc1, metadata !3004, metadata !DIExpression()), !dbg !3052
  %62 = load %struct.v16float, ptr %v2, align 32, !dbg !3053, !tbaa !2099
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp31, %struct.v16float %62) #27, !dbg !3053
  %63 = load %struct.v16accfloat, ptr %custom_type.tmp31, align 32, !dbg !3053, !tbaa !2252
  store %struct.v16accfloat %63, ptr %agg.tmp30, align 32, !dbg !3053, !tbaa !2252
  %64 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3054, !tbaa !2099
  %65 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !3054, !tbaa !2099
  %66 = load %struct.v16accfloat, ptr %agg.tmp30, align 32, !dbg !3054, !tbaa !2252
  %call32 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %64, %struct.v32bfloat16 %65, %struct.v16accfloat %66) #24, !dbg !3054
  %67 = getelementptr inbounds %struct.v16accfloat, ptr %acc1, i32 0, i32 0, !dbg !3054
  %68 = extractvalue %struct.v16accfloat %call32, 0, !dbg !3054
  store %struct.ipd.custom_type.v16acc32.v16acc32 %68, ptr %67, align 32, !dbg !3054
  %69 = load %struct.v16accfloat, ptr %acc1, align 32, !dbg !3055, !tbaa !2252
  %call34 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %69) #24, !dbg !3055
  %70 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp33, i32 0, i32 0, !dbg !3055
  %71 = extractvalue %struct.v16bfloat16 %call34, 0, !dbg !3055
  store %struct.ipd.custom_type.v64int4.v64int4 %71, ptr %70, align 32, !dbg !3055
  %72 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !3056, !tbaa !2099
  %73 = load %struct.v16bfloat16, ptr %agg.tmp33, align 32, !dbg !3056, !tbaa !2194
  %call35 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %72, i32 0, %struct.v16bfloat16 %73) #24, !dbg !3056
  %74 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp36, i32 0, i32 0, !dbg !3056
  %75 = extractvalue %struct.v32bfloat16 %call35, 0, !dbg !3056
  store %struct.ipd.custom_type.v128int4.v128int4 %75, ptr %74, align 32, !dbg !3056
  %76 = load %struct.v32bfloat16, ptr %agg.tmp36, align 32, !dbg !3057, !tbaa !2099
  store %struct.v32bfloat16 %76, ptr %e, align 32, !dbg !3057, !tbaa !2099
  %77 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !3058, !tbaa !2099
  %78 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !3058, !tbaa !2099
  %79 = load %struct.v16accfloat, ptr %acc1, align 32, !dbg !3058, !tbaa !2252
  %call39 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %77, %struct.v32bfloat16 %78, %struct.v16accfloat %79) #24, !dbg !3058
  %80 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp38, i32 0, i32 0, !dbg !3058
  %81 = extractvalue %struct.v16accfloat %call39, 0, !dbg !3058
  store %struct.ipd.custom_type.v16acc32.v16acc32 %81, ptr %80, align 32, !dbg !3058
  %82 = load %struct.v16accfloat, ptr %agg.tmp38, align 32, !dbg !3059, !tbaa !2252
  %call40 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %82) #24, !dbg !3059
  %83 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp37, i32 0, i32 0, !dbg !3059
  %84 = extractvalue %struct.v16bfloat16 %call40, 0, !dbg !3059
  store %struct.ipd.custom_type.v64int4.v64int4 %84, ptr %83, align 32, !dbg !3059
  %85 = load %struct.v32bfloat16, ptr %f, align 32, !dbg !3060, !tbaa !2099
  %86 = load %struct.v16bfloat16, ptr %agg.tmp37, align 32, !dbg !3060, !tbaa !2194
  %call41 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %85, i32 0, %struct.v16bfloat16 %86) #24, !dbg !3060
  %87 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp42, i32 0, i32 0, !dbg !3060
  %88 = extractvalue %struct.v32bfloat16 %call41, 0, !dbg !3060
  store %struct.ipd.custom_type.v128int4.v128int4 %88, ptr %87, align 32, !dbg !3060
  %89 = load %struct.v32bfloat16, ptr %agg.tmp42, align 32, !dbg !3061, !tbaa !2099
  store %struct.v32bfloat16 %89, ptr %f, align 32, !dbg !3061, !tbaa !2099
  %90 = load i32, ptr %sub_mul.addr, align 4, !dbg !3062, !tbaa !1755
  %91 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3063, !tbaa !2099
  %92 = load %struct.v32bfloat16, ptr %f, align 32, !dbg !3063, !tbaa !2099
  %call48 = call addrspace(1) %struct.v16accfloat @_Z18mul_elem_16_2_conf11v32bfloat16S_i(%struct.v32bfloat16 %91, %struct.v32bfloat16 %92, i32 %90) #24, !dbg !3063
  %93 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp47, i32 0, i32 0, !dbg !3063
  %94 = extractvalue %struct.v16accfloat %call48, 0, !dbg !3063
  store %struct.ipd.custom_type.v16acc32.v16acc32 %94, ptr %93, align 32, !dbg !3063
  %95 = load i32, ptr %sub_mul.addr, align 4, !dbg !3064, !tbaa !1755
  %96 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !3065, !tbaa !2099
  %97 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !3065, !tbaa !2099
  %98 = load %struct.v16accfloat, ptr %agg.tmp47, align 32, !dbg !3065, !tbaa !2252
  %call49 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %96, %struct.v32bfloat16 %97, %struct.v16accfloat %98, i32 0, i32 %95, i32 0) #24, !dbg !3065
  %99 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp46, i32 0, i32 0, !dbg !3065
  %100 = extractvalue %struct.v16accfloat %call49, 0, !dbg !3065
  store %struct.ipd.custom_type.v16acc32.v16acc32 %100, ptr %99, align 32, !dbg !3065
  %101 = load i32, ptr %sub_mul.addr, align 4, !dbg !3066, !tbaa !1755
  %102 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3067, !tbaa !2099
  %103 = load %struct.v32bfloat16, ptr %c, align 32, !dbg !3067, !tbaa !2099
  %104 = load %struct.v16accfloat, ptr %agg.tmp46, align 32, !dbg !3067, !tbaa !2252
  %call50 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %102, %struct.v32bfloat16 %103, %struct.v16accfloat %104, i32 0, i32 %101, i32 0) #24, !dbg !3067
  %105 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp45, i32 0, i32 0, !dbg !3067
  %106 = extractvalue %struct.v16accfloat %call50, 0, !dbg !3067
  store %struct.ipd.custom_type.v16acc32.v16acc32 %106, ptr %105, align 32, !dbg !3067
  %107 = load i32, ptr %sub_mul.addr, align 4, !dbg !3068, !tbaa !1755
  %108 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !3069, !tbaa !2099
  %109 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3069, !tbaa !2099
  %110 = load %struct.v16accfloat, ptr %agg.tmp45, align 32, !dbg !3069, !tbaa !2252
  %call51 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %108, %struct.v32bfloat16 %109, %struct.v16accfloat %110, i32 0, i32 %107, i32 0) #24, !dbg !3069
  %111 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp44, i32 0, i32 0, !dbg !3069
  %112 = extractvalue %struct.v16accfloat %call51, 0, !dbg !3069
  store %struct.ipd.custom_type.v16acc32.v16acc32 %112, ptr %111, align 32, !dbg !3069
  %113 = load i32, ptr %sub_mul.addr, align 4, !dbg !3070, !tbaa !1755
  %114 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3071, !tbaa !2099
  %115 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !3071, !tbaa !2099
  %116 = load %struct.v16accfloat, ptr %agg.tmp44, align 32, !dbg !3071, !tbaa !2252
  %call52 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %114, %struct.v32bfloat16 %115, %struct.v16accfloat %116, i32 0, i32 %113, i32 0) #24, !dbg !3071
  %117 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp43, i32 0, i32 0, !dbg !3071
  %118 = extractvalue %struct.v16accfloat %call52, 0, !dbg !3071
  store %struct.ipd.custom_type.v16acc32.v16acc32 %118, ptr %117, align 32, !dbg !3071
  %119 = load i32, ptr %zero_acc.addr, align 4, !dbg !3072, !tbaa !1755
  %120 = load i32, ptr %sub_mul.addr, align 4, !dbg !3073, !tbaa !1755
  %121 = load i32, ptr %sub_acc1.addr, align 4, !dbg !3074, !tbaa !1755
  %122 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3075, !tbaa !2099
  %123 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3075, !tbaa !2099
  %124 = load %struct.v16accfloat, ptr %acc, align 32, !dbg !3075, !tbaa !2252
  %125 = load %struct.v16accfloat, ptr %agg.tmp43, align 32, !dbg !3075, !tbaa !2252
  %call53 = call addrspace(1) %struct.v16accfloat @_Z21addmac_elem_16_2_conf11v32bfloat16S_11v16accfloatS0_iiii(%struct.v32bfloat16 %122, %struct.v32bfloat16 %123, %struct.v16accfloat %124, %struct.v16accfloat %125, i32 %119, i32 %120, i32 %121, i32 0) #24, !dbg !3075
  %126 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !3075
  %127 = extractvalue %struct.v16accfloat %call53, 0, !dbg !3075
  store %struct.ipd.custom_type.v16acc32.v16acc32 %127, ptr %126, align 32, !dbg !3075
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %acc1) #22, !dbg !3076
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %acc0) #22, !dbg !3076
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %dummy0) #22, !dbg !3076
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %f) #22, !dbg !3076
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %e) #22, !dbg !3076
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %d) #22, !dbg !3076
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %c) #22, !dbg !3076
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %b) #22, !dbg !3076
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %a) #22, !dbg !3076
  %128 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !3076
  ret %struct.v16accfloat %128, !dbg !3076
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() addrspace(1) #6 comdat {
entry:
  %custom_type.tmp = alloca %struct.v32bfloat16, align 32
  %agg.tmp = alloca %struct.v32uint16, align 32
  %call = call addrspace(1) %struct.v32uint16 @_Z13broadcast_u16t(i16 zeroext 0) #26
  %0 = getelementptr inbounds %struct.v32uint16, ptr %agg.tmp, i32 0, i32 0
  %1 = extractvalue %struct.v32uint16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32
  %2 = load %struct.v32uint16, ptr %agg.tmp, align 32, !tbaa !2099
  call addrspace(1) void @_ZN11v32bfloat16C2E9v32uint16(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v32uint16 %2) #27
  %3 = load %struct.v32bfloat16, ptr %custom_type.tmp, align 32, !tbaa !2099
  ret %struct.v32bfloat16 %3
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v32bfloat16 @_Z28broadcast_one_to_v32bfloat16v() addrspace(1) #6 comdat {
entry:
  %custom_type.tmp = alloca %struct.v32bfloat16, align 32
  %agg.tmp = alloca %struct.v32uint16, align 32
  %call = call addrspace(1) %struct.v32uint16 @_Z13broadcast_u16t(i16 zeroext 16256) #26
  %0 = getelementptr inbounds %struct.v32uint16, ptr %agg.tmp, i32 0, i32 0
  %1 = extractvalue %struct.v32uint16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32
  %2 = load %struct.v32uint16, ptr %agg.tmp, align 32, !tbaa !2099
  call addrspace(1) void @_ZN11v32bfloat16C2E9v32uint16(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v32uint16 %2) #27
  %3 = load %struct.v32bfloat16, ptr %custom_type.tmp, align 32, !tbaa !2099
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
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1755
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2099
  %2 = load %struct.v16bfloat16, ptr %b, align 32, !tbaa !2194
  %call = call addrspace(1) %struct.v32bfloat16 @_ZN12me_primitive6upd_xlE11v32bfloat1611v16bfloat16(%struct.v32bfloat16 %1, %struct.v16bfloat16 %2) #26
  %3 = getelementptr inbounds %struct.v32bfloat16, ptr %retval, i32 0, i32 0
  %4 = extractvalue %struct.v32bfloat16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %4, ptr %3, align 32
  br label %return

if.else:                                          ; preds = %entry
  %5 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2099
  %6 = load %struct.v16bfloat16, ptr %b, align 32, !tbaa !2194
  %call1 = call addrspace(1) %struct.v32bfloat16 @_ZN12me_primitive6upd_xhE11v32bfloat1611v16bfloat16(%struct.v32bfloat16 %5, %struct.v16bfloat16 %6) #26
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
  %call = call addrspace(1) i32 @_Z7get_rndv() #24
  call addrspace(1) void @_ZN7uint4_tC2Ej(ptr nonnull align 1 dereferenceable(1) %custom_type.tmp, i32 %call) #24
  %0 = load %struct.ipd.custom_type.uint4_t.uint4_t, ptr %custom_type.tmp, align 1, !tbaa !3077
  store %struct.ipd.custom_type.uint4_t.uint4_t %0, ptr %agg.tmp, align 1, !tbaa !3077
  %call3 = call addrspace(1) i32 @_Z14get_fp2bf_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %1 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3079
  store %struct.ipd.custom_type.uint5_t.uint5_t %1, ptr %agg.tmp1, align 4, !tbaa !3079
  %2 = load %struct.v16accfloat, ptr %acc, align 32, !tbaa !2252
  %3 = load %struct.ipd.custom_type.uint4_t.uint4_t, ptr %agg.tmp, align 1, !tbaa !3077
  %4 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3079
  %call4 = call addrspace(1) %struct.v16bfloat16 @_ZN12me_primitive3srsE11v16accfloat7uint4_t7uint5_t(%struct.v16accfloat %2, %struct.ipd.custom_type.uint4_t.uint4_t %3, %struct.ipd.custom_type.uint5_t.uint5_t %4) #26
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v16accfloat, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %custom_type.tmp, align 32, !tbaa !2252
  store %struct.ipd.custom_type.v16acc32.v16acc32 %0, ptr %mw, align 32, !tbaa !2252
  %1 = load %struct.v16float, ptr %a0, align 32, !tbaa !2099
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_v16accfloat_v16float(%struct.v16float %1) #25
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !tbaa !2252
  store %struct.v16accfloat %4, ptr %this1, align 32, !tbaa !2252
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
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #22
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0) #24
  store i32 %call, ptr %conf, align 4, !tbaa !1755
  %0 = load i32, ptr %conf, align 4, !tbaa !1755
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 1) #24
  %1 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2321
  store %struct.ipd.custom_type.uint1_t.uint1_t %1, ptr %agg.tmp, align 4, !tbaa !2321
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %2 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3079
  store %struct.ipd.custom_type.uint5_t.uint5_t %2, ptr %agg.tmp1, align 4, !tbaa !3079
  %3 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2099
  %4 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2099
  %5 = load %struct.v16accfloat, ptr %acc1, align 32, !tbaa !2252
  %6 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2321
  %7 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3079
  %call4 = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive10mac16_confE11v32bfloat16S0_11v16accfloati7uint1_t7uint5_t(%struct.v32bfloat16 %3, %struct.v32bfloat16 %4, %struct.v16accfloat %5, i32 %0, %struct.ipd.custom_type.uint1_t.uint1_t %6, %struct.ipd.custom_type.uint5_t.uint5_t %7) #26
  %8 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %9 = extractvalue %struct.v16accfloat %call4, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %9, ptr %8, align 32
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %conf) #22
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
  store i32 %zero_acc1, ptr %zero_acc1.addr, align 4, !tbaa !1755
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1755
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1755
  store i32 %sub_acc2, ptr %sub_acc2.addr, align 4, !tbaa !1755
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #22
  %0 = load i32, ptr %zero_acc1.addr, align 4, !tbaa !1755
  %1 = load i32, ptr %sub_mul.addr, align 4, !tbaa !1755
  %2 = load i32, ptr %sub_acc1.addr, align 4, !tbaa !1755
  %3 = load i32, ptr %sub_acc2.addr, align 4, !tbaa !1755
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 %0, i32 0, i32 %1, i32 %2, i32 %3, i32 0) #24
  store i32 %call, ptr %conf, align 4, !tbaa !1755
  %4 = load i32, ptr %conf, align 4, !tbaa !1755
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 0) #24
  %5 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2321
  store %struct.ipd.custom_type.uint1_t.uint1_t %5, ptr %agg.tmp, align 4, !tbaa !2321
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %6 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3079
  store %struct.ipd.custom_type.uint5_t.uint5_t %6, ptr %agg.tmp1, align 4, !tbaa !3079
  %7 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2099
  %8 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2099
  %9 = load %struct.v16accfloat, ptr %acc1, align 32, !tbaa !2252
  %10 = load %struct.v16accfloat, ptr %acc2, align 32, !tbaa !2252
  %11 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2321
  %12 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3079
  %call4 = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive13addmac16_confE11v32bfloat16S0_11v16accfloatS1_i7uint1_t7uint5_t(%struct.v32bfloat16 %7, %struct.v32bfloat16 %8, %struct.v16accfloat %9, %struct.v16accfloat %10, i32 %4, %struct.ipd.custom_type.uint1_t.uint1_t %11, %struct.ipd.custom_type.uint5_t.uint5_t %12) #26
  %13 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %14 = extractvalue %struct.v16accfloat %call4, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %14, ptr %13, align 32
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %conf) #22
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
  store i32 %zero_acc1, ptr %zero_acc1.addr, align 4, !tbaa !1755
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1755
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1755
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #22
  %0 = load i32, ptr %zero_acc1.addr, align 4, !tbaa !1755
  %1 = load i32, ptr %sub_mul.addr, align 4, !tbaa !1755
  %2 = load i32, ptr %sub_acc1.addr, align 4, !tbaa !1755
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 %0, i32 0, i32 %1, i32 %2, i32 0, i32 0) #24
  store i32 %call, ptr %conf, align 4, !tbaa !1755
  %3 = load i32, ptr %conf, align 4, !tbaa !1755
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 0) #24
  %4 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2321
  store %struct.ipd.custom_type.uint1_t.uint1_t %4, ptr %agg.tmp, align 4, !tbaa !2321
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %5 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3079
  store %struct.ipd.custom_type.uint5_t.uint5_t %5, ptr %agg.tmp1, align 4, !tbaa !3079
  %6 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2099
  %7 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2099
  %8 = load %struct.v16accfloat, ptr %acc1, align 32, !tbaa !2252
  %9 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2321
  %10 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3079
  %call4 = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive10mac16_confE11v32bfloat16S0_11v16accfloati7uint1_t7uint5_t(%struct.v32bfloat16 %6, %struct.v32bfloat16 %7, %struct.v16accfloat %8, i32 %3, %struct.ipd.custom_type.uint1_t.uint1_t %9, %struct.ipd.custom_type.uint5_t.uint5_t %10) #26
  %11 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %12 = extractvalue %struct.v16accfloat %call4, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %12, ptr %11, align 32
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %conf) #22
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
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1755
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #22
  %0 = load i32, ptr %sub_mul.addr, align 4, !tbaa !1755
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 0, i32 0, i32 %0, i32 0, i32 0, i32 0) #24
  store i32 %call, ptr %conf, align 4, !tbaa !1755
  %1 = load i32, ptr %conf, align 4, !tbaa !1755
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 0) #24
  %2 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2321
  store %struct.ipd.custom_type.uint1_t.uint1_t %2, ptr %agg.tmp, align 4, !tbaa !2321
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %3 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3079
  store %struct.ipd.custom_type.uint5_t.uint5_t %3, ptr %agg.tmp1, align 4, !tbaa !3079
  %4 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2099
  %5 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2099
  %6 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2321
  %7 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3079
  %call4 = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive10mul16_confE11v32bfloat16S0_i7uint1_t7uint5_t(%struct.v32bfloat16 %4, %struct.v32bfloat16 %5, i32 %1, %struct.ipd.custom_type.uint1_t.uint1_t %6, %struct.ipd.custom_type.uint5_t.uint5_t %7) #26
  %8 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %9 = extractvalue %struct.v16accfloat %call4, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %9, ptr %8, align 32
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %conf) #22
  %10 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %10
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v32uint16 @_Z13broadcast_u16t(i16 zeroext %a0) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v32uint16, align 32
  %a0.addr = alloca i16, align 2
  store i16 %a0, ptr %a0.addr, align 2, !tbaa !3081
  %0 = load i16, ptr %a0.addr, align 2, !tbaa !3081
  %call = call x86_regcallcc addrspace(1) %struct.v32uint16 @__regcall3__chessintr_v32uint16_broadcast_u16___ushort(i16 zeroext %0) #25
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v32bfloat16, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v128int4.v128int4, ptr %custom_type.tmp, align 32, !tbaa !2099
  store %struct.ipd.custom_type.v128int4.v128int4 %0, ptr %mw, align 32, !tbaa !2099
  %1 = load %struct.v32uint16, ptr %a0, align 32, !tbaa !2099
  %call = call x86_regcallcc addrspace(1) %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_v32bfloat16_v32uint16(%struct.v32uint16 %1) #25
  %2 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v32bfloat16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  %4 = load %struct.v32bfloat16, ptr %agg.tmp, align 32, !tbaa !2099
  store %struct.v32bfloat16 %4, ptr %this1, align 32, !tbaa !2099
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
  %0 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2099
  %1 = load %struct.v16bfloat16, ptr %a1, align 32, !tbaa !2194
  %call = call x86_regcallcc addrspace(1) %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_upd_xl_v32bfloat16_v16bfloat16(%struct.v32bfloat16 %0, %struct.v16bfloat16 %1) #25
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
  %0 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2099
  %1 = load %struct.v16bfloat16, ptr %a1, align 32, !tbaa !2194
  %call = call x86_regcallcc addrspace(1) %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_upd_xh_v32bfloat16_v16bfloat16(%struct.v32bfloat16 %0, %struct.v16bfloat16 %1) #25
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
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2252
  %1 = load %struct.ipd.custom_type.uint4_t.uint4_t, ptr %a1, align 1, !tbaa !3077
  %2 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a2, align 4, !tbaa !3079
  %call = call x86_regcallcc addrspace(1) %struct.v16bfloat16 @__regcall3__chessintr_v16bfloat16_srs_v16accfloat_uint4_t_uint5_t(%struct.v16accfloat %0, %struct.ipd.custom_type.uint4_t.uint4_t %1, %struct.ipd.custom_type.uint5_t.uint5_t %2) #25
  %3 = getelementptr inbounds %struct.v16bfloat16, ptr %retval, i32 0, i32 0
  %4 = extractvalue %struct.v16bfloat16 %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %4, ptr %3, align 32
  %5 = load %struct.v16bfloat16, ptr %retval, align 32
  ret %struct.v16bfloat16 %5
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local i32 @_Z7get_rndv() addrspace(1) #6 comdat {
entry:
  %0 = load i32, ptr @_ZN12me_primitive11control_rndE, align 4, !tbaa !1755
  ret i32 %0
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7uint4_tC2Ej(ptr nonnull align 1 dereferenceable(1) %this, i32 %a) unnamed_addr addrspace(1) #11 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  store i32 %a, ptr %a.addr, align 4, !tbaa !1755
  %this1 = load ptr, ptr %this.addr, align 4
  store i4 0, ptr %this1, align 1
  %0 = load i32, ptr %a.addr, align 4, !tbaa !1755
  %1 = call addrspace(1) %struct.ipd.custom_type.uint4_t.uint4_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint4_t.uint4_ts.i32.p1(%struct.ipd.custom_type.uint4_t.uint4_t undef, i32 %0, i32 4, i32 32, i1 false, i32 0, ptr addrspace(1) @__regcall3__chessintr_uint4_t_uint4_t___uint)
  store %struct.ipd.custom_type.uint4_t.uint4_t %1, ptr %this1, align 1
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local i32 @_Z14get_fp2bf_maskv() addrspace(1) #6 comdat {
entry:
  %ref.tmp = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %ref.tmp) #22
  %0 = load volatile %struct.ipd.custom_type.uint5_t.uint5_t, ptr !register !1507, align 4, !tbaa !3079, !chess_protect_access !3083
  store %struct.ipd.custom_type.uint5_t.uint5_t %0, ptr %ref.tmp, align 4, !tbaa !3079
  %call = call noundef addrspace(1) i32 @_ZNK7uint5_tcvjEv(ptr nonnull align 4 dereferenceable(1) %ref.tmp) #24
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %ref.tmp) #22
  ret i32 %call
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %this, i32 %a) unnamed_addr addrspace(1) #11 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  store i32 %a, ptr %a.addr, align 4, !tbaa !1755
  %this1 = load ptr, ptr %this.addr, align 4
  store i5 0, ptr %this1, align 4
  %0 = load i32, ptr %a.addr, align 4, !tbaa !1755
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %r, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %r) #22
  store i32 0, ptr %r, align 4, !tbaa !1755
  %0 = load i32, ptr %r, align 4, !tbaa !1755
  %1 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %this1, align 4, !tbaa !3079
  store %struct.ipd.custom_type.uint5_t.uint5_t %1, ptr %tmp, align 4, !tbaa !3079
  %2 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %tmp, align 4
  %3 = call addrspace(1) i32 @llvm.chess.convert.customint.i32.s_struct.ipd.custom_type.uint5_t.uint5_ts.p1(i32 undef, %struct.ipd.custom_type.uint5_t.uint5_t %2, i32 32, i32 5, i1 false, i32 0, ptr addrspace(1) @__regcall3__chessintr___uint___uint_uint5_t)
  store i32 %3, ptr %r, align 4
  %4 = load i32, ptr %r, align 4, !tbaa !1755
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %r) #22
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
  store i32 %sgn_x, ptr %sgn_x.addr, align 4, !tbaa !1755
  store i32 %sgn_y, ptr %sgn_y.addr, align 4, !tbaa !1755
  store i32 %amode, ptr %amode.addr, align 4, !tbaa !1755
  store i32 %bmode, ptr %bmode.addr, align 4, !tbaa !1755
  store i32 %variant, ptr %variant.addr, align 4, !tbaa !1755
  store i32 %zero_acc, ptr %zero_acc.addr, align 4, !tbaa !1755
  store i32 %shift16, ptr %shift16.addr, align 4, !tbaa !1755
  store i32 %sub0, ptr %sub0.addr, align 4, !tbaa !1755
  store i32 %sub1, ptr %sub1.addr, align 4, !tbaa !1755
  store i32 %sub2, ptr %sub2.addr, align 4, !tbaa !1755
  store i32 %sub_mask, ptr %sub_mask.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %sub_mask.addr, align 4, !tbaa !1755
  %shl = shl i32 %0, 16
  %1 = load i32, ptr %shift16.addr, align 4, !tbaa !1755
  %shl1 = shl i32 %1, 10
  %or = or i32 %shl, %shl1
  %2 = load i32, ptr %sub0.addr, align 4, !tbaa !1755
  %shl2 = shl i32 %2, 11
  %or3 = or i32 %or, %shl2
  %3 = load i32, ptr %sub1.addr, align 4, !tbaa !1755
  %shl4 = shl i32 %3, 12
  %or5 = or i32 %or3, %shl4
  %4 = load i32, ptr %sub2.addr, align 4, !tbaa !1755
  %shl6 = shl i32 %4, 13
  %or7 = or i32 %or5, %shl6
  %5 = load i32, ptr %amode.addr, align 4, !tbaa !1755
  %shl8 = shl i32 %5, 1
  %or9 = or i32 %or7, %shl8
  %6 = load i32, ptr %bmode.addr, align 4, !tbaa !1755
  %shl10 = shl i32 %6, 3
  %or11 = or i32 %or9, %shl10
  %7 = load i32, ptr %variant.addr, align 4, !tbaa !1755
  %shl12 = shl i32 %7, 5
  %or13 = or i32 %or11, %shl12
  %8 = load i32, ptr %sgn_x.addr, align 4, !tbaa !1755
  %shl14 = shl i32 %8, 9
  %9 = load i32, ptr %sgn_y.addr, align 4, !tbaa !1755
  %shl15 = shl i32 %9, 8
  %or16 = or i32 %shl14, %shl15
  %or17 = or i32 %or13, %or16
  %10 = load i32, ptr %zero_acc.addr, align 4, !tbaa !1755
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
  store i32 %a3, ptr %a3.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %a3.addr, align 4, !tbaa !1755
  %1 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2099
  %2 = load %struct.v32bfloat16, ptr %a1, align 32, !tbaa !2099
  %3 = load %struct.v16accfloat, ptr %a2, align 32, !tbaa !2252
  %4 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a4, align 4, !tbaa !2321
  %5 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a5, align 4, !tbaa !3079
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_mac16_conf_v32bfloat16_v32bfloat16_v16accfloat___sint_uint1_t_uint5_t(%struct.v32bfloat16 %1, %struct.v32bfloat16 %2, %struct.v16accfloat %3, i32 signext %0, %struct.ipd.custom_type.uint1_t.uint1_t %4, %struct.ipd.custom_type.uint5_t.uint5_t %5) #25
  %6 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %7 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %7, ptr %6, align 32
  %8 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %8
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local i32 @_Z17get_fpmulmac_maskv() addrspace(1) #6 comdat {
entry:
  %ref.tmp = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %ref.tmp) #22
  %0 = load volatile %struct.ipd.custom_type.uint5_t.uint5_t, ptr !register !1508, align 4, !tbaa !3079, !chess_protect_access !3083
  store %struct.ipd.custom_type.uint5_t.uint5_t %0, ptr %ref.tmp, align 4, !tbaa !3079
  %call = call noundef addrspace(1) i32 @_ZNK7uint5_tcvjEv(ptr nonnull align 4 dereferenceable(1) %ref.tmp) #24
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %ref.tmp) #22
  ret i32 %call
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_mac16_conf_v32bfloat16_v32bfloat16_v16accfloat___sint_uint1_t_uint5_t(%struct.v32bfloat16, %struct.v32bfloat16, %struct.v16accfloat, i32 signext, %struct.ipd.custom_type.uint1_t.uint1_t, %struct.ipd.custom_type.uint5_t.uint5_t) addrspace(1) #14

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
  store i32 %a4, ptr %a4.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %a4.addr, align 4, !tbaa !1755
  %1 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2099
  %2 = load %struct.v32bfloat16, ptr %a1, align 32, !tbaa !2099
  %3 = load %struct.v16accfloat, ptr %a2, align 32, !tbaa !2252
  %4 = load %struct.v16accfloat, ptr %a3, align 32, !tbaa !2252
  %5 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a5, align 4, !tbaa !2321
  %6 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a6, align 4, !tbaa !3079
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_addmac16_conf_v32bfloat16_v32bfloat16_v16accfloat_v16accfloat___sint_uint1_t_uint5_t(%struct.v32bfloat16 %1, %struct.v32bfloat16 %2, %struct.v16accfloat %3, %struct.v16accfloat %4, i32 signext %0, %struct.ipd.custom_type.uint1_t.uint1_t %5, %struct.ipd.custom_type.uint5_t.uint5_t %6) #25
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
  store i32 %a2, ptr %a2.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %a2.addr, align 4, !tbaa !1755
  %1 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2099
  %2 = load %struct.v32bfloat16, ptr %a1, align 32, !tbaa !2099
  %3 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a3, align 4, !tbaa !2321
  %4 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a4, align 4, !tbaa !3079
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_mul16_conf_v32bfloat16_v32bfloat16___sint_uint1_t_uint5_t(%struct.v32bfloat16 %1, %struct.v32bfloat16 %2, i32 signext %0, %struct.ipd.custom_type.uint1_t.uint1_t %3, %struct.ipd.custom_type.uint5_t.uint5_t %4) #25
  %5 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %6 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %6, ptr %5, align 32
  %7 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %7
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_mul16_conf_v32bfloat16_v32bfloat16___sint_uint1_t_uint5_t(%struct.v32bfloat16, %struct.v32bfloat16, i32 signext, %struct.ipd.custom_type.uint1_t.uint1_t, %struct.ipd.custom_type.uint5_t.uint5_t) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZNK3aie6vectorIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !3084 {
entry:
  %retval = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3086, metadata !DIExpression()), !dbg !3087
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v16float @_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this1) #24, !dbg !3088
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !3088
  %1 = extractvalue %struct.v16float %call, 0, !dbg !3088
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !3088
  %2 = load %struct.v16float, ptr %retval, align 32, !dbg !3089
  ret %struct.v16float %2, !dbg !3089
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !3090 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3092, metadata !DIExpression()), !dbg !3093
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %this1, i32 0, i32 0, !dbg !3094
  %0 = load %struct.v16float, ptr %data, align 32, !dbg !3094, !tbaa !2099
  ret %struct.v16float %0, !dbg !3094
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !3096 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3098, metadata !DIExpression()), !dbg !3099
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base.3", ptr %this1, i32 0, i32 0, !dbg !3100
  %0 = load %struct.v16accfloat, ptr %data, align 32, !dbg !3100, !tbaa !2252
  ret %struct.v16accfloat %0, !dbg !3100
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.0" @_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3101 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector.0", align 32
  %ref.tmp = alloca %"class.aie::detail::vector_base.1", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3104, metadata !DIExpression()), !dbg !3106
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3105, metadata !DIExpression()), !dbg !3107
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3108
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3109, !tbaa !1755
  %call = call addrspace(1) %"class.aie::detail::vector_base.1" @_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0) #24, !dbg !3110
  %1 = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %ref.tmp, i32 0, i32 0, !dbg !3110
  %2 = extractvalue %"class.aie::detail::vector_base.1" %call, 0, !dbg !3110
  store %struct.v16float %2, ptr %1, align 32, !dbg !3110
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, ptr nonnull align 32 dereferenceable(64) %ref.tmp) #24, !dbg !3111
  %3 = load %"class.aie::vector.0", ptr %custom_type.tmp, align 32, !dbg !3111, !tbaa !2088
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3112
  ret %"class.aie::vector.0" %3, !dbg !3111
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base.1" @_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3113 {
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3118, metadata !DIExpression()), !dbg !3126
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3120, metadata !DIExpression()), !dbg !3127
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %output_bits, align 4, !dbg !3128
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %output_bits) #22, !dbg !3128
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %output_bits, metadata !3121, metadata !DIExpression()), !dbg !3129
  store i32 512, ptr %output_bits, align 4, !dbg !3129, !tbaa !1755
  store i32 undef, ptr %growth_ratio, align 4, !dbg !3130
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %growth_ratio) #22, !dbg !3130
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %growth_ratio, metadata !3122, metadata !DIExpression()), !dbg !3131
  store i32 2, ptr %growth_ratio, align 4, !dbg !3131, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3123, metadata !DIExpression()), !dbg !3132
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %retval) #24, !dbg !3132
  store i32 undef, ptr %in_storage_elems, align 4, !dbg !3133
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %in_storage_elems) #22, !dbg !3133
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in_storage_elems, metadata !3124, metadata !DIExpression()), !dbg !3134
  store i32 1, ptr %in_storage_elems, align 4, !dbg !3134, !tbaa !1755
  store i32 undef, ptr %out_storage_elems, align 4, !dbg !3135
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %out_storage_elems) #22, !dbg !3135
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out_storage_elems, metadata !3125, metadata !DIExpression()), !dbg !3136
  store i32 1, ptr %out_storage_elems, align 4, !dbg !3136, !tbaa !1755
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3137
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !3141
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3142, !tbaa !1755
  %call = call addrspace(1) %struct.v16float @_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj(ptr nonnull align 32 dereferenceable(32) %data, i32 noundef %0) #24, !dbg !3137
  %1 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !3137
  %2 = extractvalue %struct.v16float %call, 0, !dbg !3137
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32, !dbg !3137
  %3 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !3137, !tbaa !2099
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %ref.tmp, %struct.v16float %3) #24, !dbg !3137
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %retval, ptr align 32 %ref.tmp, i32 64, i1 false), !dbg !3143, !tbaa !3144, !tbaa.struct !3145
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3146
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %out_storage_elems) #22, !dbg !3147
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %in_storage_elems) #22, !dbg !3147
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %growth_ratio) #22, !dbg !3147
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %output_bits) #22, !dbg !3147
  %4 = load %"class.aie::detail::vector_base.1", ptr %retval, align 32, !dbg !3147
  ret %"class.aie::detail::vector_base.1" %4, !dbg !3147
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE(ptr nonnull align 32 dereferenceable(64) %this, ptr nonnull align 32 dereferenceable(64) %v) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3148 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3150, metadata !DIExpression()), !dbg !3152
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3151, metadata !DIExpression()), !dbg !3153
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %v.addr, align 4, !dbg !3154, !tbaa !1542
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %this1, ptr align 32 %0, i32 64, i1 false), !dbg !3155, !tbaa !3144, !tbaa.struct !3145
  ret void, !dbg !3156
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3157 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3159, metadata !DIExpression()), !dbg !3161
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %this1, i32 0, i32 0, !dbg !3162
  %call = call addrspace(1) %struct.v16float @_ZN3aie6detail14vector_storageIfLj16EE5undefEv() #24, !dbg !3163
  %0 = getelementptr inbounds %struct.v16float, ptr %data, i32 0, i32 0, !dbg !3163
  %1 = extractvalue %struct.v16float %call, 0, !dbg !3163
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !3163
  ret void, !dbg !3164
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj(ptr nonnull align 32 dereferenceable(32) %v, i32 noundef %idx) addrspace(1) #9 comdat align 2 !dbg !3165 {
entry:
  %retval = alloca %struct.v16float, align 32
  %v.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3180, metadata !DIExpression()), !dbg !3182
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3181, metadata !DIExpression()), !dbg !3183
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3184, !tbaa !1755
  %1 = load ptr, ptr %v.addr, align 4, !dbg !3185, !tbaa !1542
  %2 = load %struct.v8float, ptr %1, align 32, !dbg !3186, !tbaa !2194
  %call = call addrspace(1) %struct.v16float @_Z12set_v16floati7v8float(i32 %0, %struct.v8float %2) #24, !dbg !3186
  %3 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !3186
  %4 = extractvalue %struct.v16float %call, 0, !dbg !3186
  store %struct.ipd.custom_type.v128int4.v128int4 %4, ptr %3, align 32, !dbg !3186
  %5 = load %struct.v16float, ptr %retval, align 32, !dbg !3187
  ret %struct.v16float %5, !dbg !3187
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16float %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3188 {
entry:
  %data = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16float %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3190, metadata !DIExpression()), !dbg !3192
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !3191, metadata !DIExpression()), !dbg !3193
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::vector_base.1", ptr %this1, i32 0, i32 0, !dbg !3194
  %0 = load %struct.v16float, ptr %data, align 32, !dbg !3195, !tbaa !2099
  store %struct.v16float %0, ptr %data2, align 32, !dbg !3195, !tbaa !2099
  ret void, !dbg !3196
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z12set_v16floati7v8float(i32 %idx, %struct.v8float %b.coerce) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %b = alloca %struct.v8float, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v8float %b.coerce, ptr %b, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1755
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v8float, ptr %b, align 32, !tbaa !2194
  %call = call addrspace(1) %struct.v16float @_ZN12me_primitive6set_xlE7v8float(%struct.v8float %1) #26
  %2 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  br label %return

if.else:                                          ; preds = %entry
  %4 = load %struct.v8float, ptr %b, align 32, !tbaa !2194
  %call1 = call addrspace(1) %struct.v16float @_ZN12me_primitive6set_xhE7v8float(%struct.v8float %4) #26
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
  %0 = load %struct.v8float, ptr %a0, align 32, !tbaa !2194
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_set_xl_v8float(%struct.v8float %0) #25
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
  %0 = load %struct.v8float, ptr %a0, align 32, !tbaa !2194
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_set_xh_v8float(%struct.v8float %0) #25
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
define linkonce_odr dso_local noundef i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv(ptr nonnull align 1 dereferenceable(1) %this) addrspace(1) #9 comdat align 2 !dbg !3197 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3199, metadata !DIExpression()), !dbg !3200
  %this1 = load ptr, ptr %this.addr, align 4
  ret i32 0, !dbg !3201
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum.2" @_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !3202 {
entry:
  %this.addr = alloca ptr, align 4
  %custom_type.tmp = alloca %"class.aie::accum.2", align 32
  %ref.tmp = alloca %"class.aie::detail::accum_base.3", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3207, metadata !DIExpression()), !dbg !3208
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3209
  %call = call addrspace(1) %"class.aie::detail::accum_base.3" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv(ptr nonnull align 32 dereferenceable(32) %this1) #24, !dbg !3210
  %0 = getelementptr inbounds %"class.aie::detail::accum_base.3", ptr %ref.tmp, i32 0, i32 0, !dbg !3210
  %1 = extractvalue %"class.aie::detail::accum_base.3" %call, 0, !dbg !3210
  store %struct.v16accfloat %1, ptr %0, align 32, !dbg !3210
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, ptr nonnull align 32 dereferenceable(64) %ref.tmp) #24, !dbg !3211
  %2 = load %"class.aie::accum.2", ptr %custom_type.tmp, align 32, !dbg !3211, !tbaa !2254
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3212
  ret %"class.aie::accum.2" %2, !dbg !3211
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::accum_base.3" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !3213 {
entry:
  %retval = alloca %"class.aie::detail::accum_base.3", align 32
  %this.addr = alloca ptr, align 4
  %in_num_subaccums = alloca i32, align 4
  %out_num_subaccums = alloca i32, align 4
  %growth_ratio = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::detail::accum_base.3", align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %agg.tmp2 = alloca %struct.v8accfloat, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3218, metadata !DIExpression()), !dbg !3224
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %in_num_subaccums, align 4, !dbg !3225
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %in_num_subaccums) #22, !dbg !3225
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in_num_subaccums, metadata !3220, metadata !DIExpression()), !dbg !3226
  store i32 1, ptr %in_num_subaccums, align 4, !dbg !3226, !tbaa !1755
  store i32 undef, ptr %out_num_subaccums, align 4, !dbg !3227
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %out_num_subaccums) #22, !dbg !3227
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out_num_subaccums, metadata !3221, metadata !DIExpression()), !dbg !3228
  store i32 1, ptr %out_num_subaccums, align 4, !dbg !3228, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3222, metadata !DIExpression()), !dbg !3229
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %retval) #24, !dbg !3229
  store i32 undef, ptr %growth_ratio, align 4, !dbg !3230
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %growth_ratio) #22, !dbg !3230
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %growth_ratio, metadata !3223, metadata !DIExpression()), !dbg !3231
  store i32 2, ptr %growth_ratio, align 4, !dbg !3231, !tbaa !1755
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3232
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !3237
  %call = call addrspace(1) %struct.v8accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv() #24, !dbg !3238
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %agg.tmp2, i32 0, i32 0, !dbg !3238
  %1 = extractvalue %struct.v8accfloat %call, 0, !dbg !3238
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32, !dbg !3238
  %2 = load %struct.v8accfloat, ptr %data, align 32, !dbg !3232, !tbaa !3239
  %3 = load %struct.v8accfloat, ptr %agg.tmp2, align 32, !dbg !3232, !tbaa !2351
  %call3 = call addrspace(1) %struct.v16accfloat @_Z6concat10v8accfloatS_(%struct.v8accfloat %2, %struct.v8accfloat %3) #24, !dbg !3232
  %4 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !3232
  %5 = extractvalue %struct.v16accfloat %call3, 0, !dbg !3232
  store %struct.ipd.custom_type.v16acc32.v16acc32 %5, ptr %4, align 32, !dbg !3232
  %6 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !3232, !tbaa !2252
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %ref.tmp, %struct.v16accfloat %6) #24, !dbg !3232
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %retval, ptr align 32 %ref.tmp, i32 64, i1 false), !dbg !3240, !tbaa !3241, !tbaa.struct !3145
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3242
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %growth_ratio) #22, !dbg !3243
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %out_num_subaccums) #22, !dbg !3243
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %in_num_subaccums) #22, !dbg !3243
  %7 = load %"class.aie::detail::accum_base.3", ptr %retval, align 32, !dbg !3243
  ret %"class.aie::detail::accum_base.3" %7, !dbg !3243
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE(ptr nonnull align 32 dereferenceable(64) %this, ptr nonnull align 32 dereferenceable(64) %a) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3244 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3246, metadata !DIExpression()), !dbg !3248
  store ptr %a, ptr %a.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3247, metadata !DIExpression()), !dbg !3249
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %a.addr, align 4, !dbg !3250, !tbaa !1542
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %this1, ptr align 32 %0, i32 64, i1 false), !dbg !3251, !tbaa !3241, !tbaa.struct !3145
  ret void, !dbg !3252
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3253 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3255, metadata !DIExpression()), !dbg !3257
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base.3", ptr %this1, i32 0, i32 0, !dbg !3258
  %call = call addrspace(1) %struct.v16accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv() #24, !dbg !3259
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %data, i32 0, i32 0, !dbg !3259
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !3259
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !3259
  ret void, !dbg !3260
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z6concat10v8accfloatS_(%struct.v8accfloat %a0.coerce, %struct.v8accfloat %a1.coerce) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a0 = alloca %struct.v8accfloat, align 32
  %a1 = alloca %struct.v8accfloat, align 32
  store %struct.v8accfloat %a0.coerce, ptr %a0, align 32
  store %struct.v8accfloat %a1.coerce, ptr %a1, align 32
  %0 = load %struct.v8accfloat, ptr %a0, align 32, !tbaa !2351
  %1 = load %struct.v8accfloat, ptr %a1, align 32, !tbaa !2351
  %call = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive12concat_bm_amE10v8accfloatS0_(%struct.v8accfloat %0, %struct.v8accfloat %1) #26
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %4
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16accfloat %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3261 {
entry:
  %data = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16accfloat %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3263, metadata !DIExpression()), !dbg !3265
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !3264, metadata !DIExpression()), !dbg !3266
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::accum_base.3", ptr %this1, i32 0, i32 0, !dbg !3267
  %0 = load %struct.v16accfloat, ptr %data, align 32, !dbg !3268, !tbaa !2252
  store %struct.v16accfloat %0, ptr %data2, align 32, !dbg !3268, !tbaa !2252
  ret void, !dbg !3269
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !3270 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %call = call addrspace(1) %struct.v16accfloat @_Z17undef_v16accfloatv() #24, !dbg !3271
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !3271
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !3271
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !3271
  %2 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !3272
  ret %struct.v16accfloat %2, !dbg !3272
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z17undef_v16accfloatv() addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_undef_v16accfloat() #25
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
  %0 = load %struct.v8accfloat, ptr %a0, align 32, !tbaa !2351
  %1 = load %struct.v8accfloat, ptr %a1, align 32, !tbaa !2351
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_concat_bm_am_v8accfloat_v8accfloat(%struct.v8accfloat %0, %struct.v8accfloat %1) #25
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %4
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16accfloat @__regcall3__chessintr_v16accfloat_concat_bm_am_v8accfloat_v8accfloat(%struct.v8accfloat, %struct.v8accfloat) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a) addrspace(1) #6 comdat align 2 !dbg !3273 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %a.addr = alloca ptr, align 4
  %native_broadcast_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::vector.0", align 32
  %agg.tmp = alloca %"class.aie::vector", align 32
  store ptr %a, ptr %a.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3281, metadata !DIExpression()), !dbg !3284
  store i32 undef, ptr %native_broadcast_elems, align 4, !dbg !3285
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_broadcast_elems) #22, !dbg !3285
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_broadcast_elems, metadata !3282, metadata !DIExpression()), !dbg !3286
  store i32 16, ptr %native_broadcast_elems, align 4, !dbg !3286, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3283, metadata !DIExpression()), !dbg !3287
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !3287
  %0 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !3287, !tbaa !1704
  store %"class.aie::vector" %0, ptr %retval, align 32, !dbg !3287, !tbaa !1704
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3288
  %1 = load ptr, ptr %a.addr, align 4, !dbg !3291, !tbaa !1542
  %call = call addrspace(1) %"class.aie::vector.0" @_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf(ptr nonnull align 4 dereferenceable(4) %1) #24, !dbg !3288
  %2 = getelementptr inbounds %"class.aie::vector.0", ptr %ref.tmp, i32 0, i32 0, !dbg !3288
  %3 = extractvalue %"class.aie::vector.0" %call, 0, !dbg !3288
  store %"class.aie::detail::vector_base.1" %3, ptr %2, align 32, !dbg !3288
  %call1 = call addrspace(1) %"class.aie::vector" @_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %ref.tmp, i32 0) #24, !dbg !3292
  %4 = getelementptr inbounds %"class.aie::vector", ptr %agg.tmp, i32 0, i32 0, !dbg !3292
  %5 = extractvalue %"class.aie::vector" %call1, 0, !dbg !3292
  store %"class.aie::detail::vector_base" %5, ptr %4, align 32, !dbg !3292
  %6 = load %"class.aie::vector", ptr %agg.tmp, align 32, !dbg !3293, !tbaa !1704
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3294
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_broadcast_elems) #22, !dbg !3295
  ret %"class.aie::vector" %6, !dbg !3293
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.0" @_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a) addrspace(1) #6 comdat align 2 !dbg !3296 {
entry:
  %retval = alloca %"class.aie::vector.0", align 32
  %a.addr = alloca ptr, align 4
  %native_broadcast_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector.0", align 32
  %tmp = alloca %"class.aie::vector.0", align 32
  %agg.tmp = alloca %struct.v16float, align 32
  store ptr %a, ptr %a.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3304, metadata !DIExpression()), !dbg !3307
  store i32 undef, ptr %native_broadcast_elems, align 4, !dbg !3308
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_broadcast_elems) #22, !dbg !3308
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_broadcast_elems, metadata !3305, metadata !DIExpression()), !dbg !3309
  store i32 16, ptr %native_broadcast_elems, align 4, !dbg !3309, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3306, metadata !DIExpression()), !dbg !3310
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp) #24, !dbg !3310
  %0 = load %"class.aie::vector.0", ptr %custom_type.tmp, align 32, !dbg !3310, !tbaa !2088
  store %"class.aie::vector.0" %0, ptr %retval, align 32, !dbg !3310, !tbaa !2088
  %1 = load ptr, ptr %a.addr, align 4, !dbg !3311, !tbaa !1542
  %2 = load float, ptr %1, align 4, !dbg !3311, !tbaa !2713
  %call = call addrspace(1) %struct.v16float @_Z21broadcast_to_v16floatf(float %2) #26, !dbg !3318
  %3 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !3318
  %4 = extractvalue %struct.v16float %call, 0, !dbg !3318
  store %struct.ipd.custom_type.v128int4.v128int4 %4, ptr %3, align 32, !dbg !3318
  %5 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !3318, !tbaa !2099
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %tmp, %struct.v16float %5) #24, !dbg !3318
  %6 = load %"class.aie::vector.0", ptr %tmp, align 32, !dbg !3319, !tbaa !2088
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_broadcast_elems) #22, !dbg !3320
  ret %"class.aie::vector.0" %6, !dbg !3319
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z21broadcast_to_v16floatf(float %a0) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %a0.addr = alloca float, align 4
  store float %a0, ptr %a0.addr, align 4, !tbaa !2713
  %0 = load float, ptr %a0.addr, align 4, !tbaa !2713
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_broadcast_to_v16float___ffloat(float %0) #25
  %1 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0
  %2 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32
  %3 = load %struct.v16float, ptr %retval, align 32
  ret %struct.v16float %3
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16float @__regcall3__chessintr_v16float_broadcast_to_v16float___ffloat(float) addrspace(1) #14

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local noundef float @_ZNK3aie21vector_elem_const_refIfLj8EE3getEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #9 comdat align 2 !dbg !3321 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3323, metadata !DIExpression()), !dbg !3324
  %this1 = load ptr, ptr %this.addr, align 4
  %parent = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 0, !dbg !3325
  %0 = load ptr, ptr %parent, align 4, !dbg !3325, !tbaa !3326
  %offset = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 1, !dbg !3327
  %1 = load i32, ptr %offset, align 4, !dbg !3327, !tbaa !2652
  %call = call addrspace(1) float @_ZNK3aie6vectorIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %0, i32 %1) #24, !dbg !3328
  ret float %call, !dbg !3329
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_ZNK3aie6vectorIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3330 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3332, metadata !DIExpression()), !dbg !3334
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3333, metadata !DIExpression()), !dbg !3335
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3336, !tbaa !1755
  %call = call addrspace(1) float @_ZNK3aie6detail11vector_baseIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0) #24, !dbg !3337
  ret float %call, !dbg !3338
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_ZNK3aie6detail11vector_baseIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3339 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %agg.tmp = alloca %struct.v16float, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3341, metadata !DIExpression()), !dbg !3343
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3342, metadata !DIExpression()), !dbg !3344
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !3345

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3346, !tbaa !1755
  %cmp = icmp ult i32 %0, 8, !dbg !3346
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !3346
  br i1 %1, label %if.then, label %if.else, !dbg !3349

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !3350

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !3352, !tbaa !1755
  %cmp3 = icmp ult i32 %2, 8, !dbg !3352
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !3352
  br i1 %3, label %if.end, label %if.then4, !dbg !3355

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !1926), !dbg !3352
  br label %if.end, !dbg !3352

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !3355

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !3350

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3356, !tbaa !1755
  %cmp5 = icmp ult i32 %4, 8, !dbg !3356
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !3356
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !3349

do.end7:                                          ; preds = %if.end6
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !3358
  %call = call addrspace(1) %struct.v16float @_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj(ptr nonnull align 32 dereferenceable(32) %data, i32 noundef 0) #24, !dbg !3364
  %5 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !3364
  %6 = extractvalue %struct.v16float %call, 0, !dbg !3364
  store %struct.ipd.custom_type.v128int4.v128int4 %6, ptr %5, align 32, !dbg !3364
  %7 = load i32, ptr %idx.addr, align 4, !dbg !3365, !tbaa !1755
  %8 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !3366, !tbaa !2099
  %call8 = call addrspace(1) float @_Z12extract_elem8v16floati(%struct.v16float %8, i32 %7) #24, !dbg !3366
  ret float %call8, !dbg !3367
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_Z12extract_elem8v16floati(%struct.v16float %v.coerce, i32 %idx) addrspace(1) #6 comdat {
entry:
  %v = alloca %struct.v16float, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v16float %v.coerce, ptr %v, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1755
  %cmp = icmp slt i32 %0, 0
  br i1 %cmp, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  %1 = load i32, ptr %idx.addr, align 4, !tbaa !1755
  %cmp1 = icmp sge i32 %1, 64
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %entry
  %2 = phi i1 [ true, %entry ], [ %cmp1, %lor.rhs ]
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %2)
  br i1 %3, label %if.then, label %if.else

if.then:                                          ; preds = %lor.end
  call addrspace(1) void @llvm.chess_error(metadata !3368)
  br label %if.end

if.else:                                          ; preds = %lor.end
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %4 = load i32, ptr %idx.addr, align 4, !tbaa !1755
  %5 = load %struct.v16float, ptr %v, align 32, !tbaa !2099
  %call = call addrspace(1) float @_ZN12me_primitive9ext_elem_E8v16floatii(%struct.v16float %5, i32 %4, i32 1) #24
  ret float %call
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_ZN12me_primitive9ext_elem_E8v16floatii(%struct.v16float %a0.coerce, i32 %a1, i32 %a2) addrspace(1) #6 comdat {
entry:
  %a0 = alloca %struct.v16float, align 32
  %a1.addr = alloca i32, align 4
  %a2.addr = alloca i32, align 4
  store %struct.v16float %a0.coerce, ptr %a0, align 32
  store i32 %a1, ptr %a1.addr, align 4, !tbaa !1755
  store i32 %a2, ptr %a2.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %a1.addr, align 4, !tbaa !1755
  %1 = load i32, ptr %a2.addr, align 4, !tbaa !1755
  %2 = load %struct.v16float, ptr %a0, align 32, !tbaa !2099
  %call = call x86_regcallcc addrspace(1) float @__regcall3__chessintr___ffloat_ext_elem__v16float___sint___sint(%struct.v16float %2, i32 signext %0, i32 signext %1) #25
  ret float %call
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc float @__regcall3__chessintr___ffloat_ext_elem__v16float___sint___sint(%struct.v16float, i32 signext, i32 signext) addrspace(1) #14

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::vector" noundef %.coerce) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !3369 {
entry:
  %0 = alloca %"class.aie::vector", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector" %.coerce, ptr %0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3375, metadata !DIExpression()), !dbg !3378
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %0, metadata !3377, metadata !DIExpression()), !dbg !3378
  %this1 = load ptr, ptr %this.addr, align 4
  %1 = load %"class.aie::vector", ptr %0, align 32, !dbg !3379, !tbaa !1704
  call addrspace(1) void @_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 32 dereferenceable(32) %this1, %"class.aie::vector" %1) #24, !dbg !3379
  ret void, !dbg !3379
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::vector" %parent.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3380 {
entry:
  %parent = alloca %"class.aie::vector", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector" %parent.coerce, ptr %parent, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3382, metadata !DIExpression()), !dbg !3385
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %parent, metadata !3384, metadata !DIExpression()), !dbg !3386
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.7", ptr %this1, i32 0, i32 0, !dbg !3387
  %0 = load %"class.aie::vector", ptr %parent, align 32, !dbg !3388, !tbaa !1704
  store %"class.aie::vector" %0, ptr %parent_, align 32, !dbg !3388, !tbaa !1704
  ret void, !dbg !3389
}

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 4 dereferenceable(8) %this, %"class.aie::vector_elem_ref" noundef %.coerce) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !3390 {
entry:
  %0 = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector_elem_ref" %.coerce, ptr %0, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3396, metadata !DIExpression()), !dbg !3399
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %0, metadata !3398, metadata !DIExpression()), !dbg !3399
  %this1 = load ptr, ptr %this.addr, align 4
  %1 = load %"class.aie::vector_elem_ref", ptr %0, align 4, !dbg !3400, !tbaa !1815
  call addrspace(1) void @_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 4 dereferenceable(8) %this1, %"class.aie::vector_elem_ref" %1) #24, !dbg !3400
  ret void, !dbg !3400
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 4 dereferenceable(8) %this, %"class.aie::vector_elem_ref" %parent.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3401 {
entry:
  %parent = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector_elem_ref" %parent.coerce, ptr %parent, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3403, metadata !DIExpression()), !dbg !3406
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %parent, metadata !3405, metadata !DIExpression()), !dbg !3407
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.5", ptr %this1, i32 0, i32 0, !dbg !3408
  %0 = load %"class.aie::vector_elem_ref", ptr %parent, align 4, !dbg !3408, !tbaa !1815
  store %"class.aie::vector_elem_ref" %0, ptr %parent_, align 4, !dbg !3408, !tbaa !1815
  ret void, !dbg !3409
}

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::accum" noundef %.coerce) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !3410 {
entry:
  %0 = alloca %"class.aie::accum", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::accum" %.coerce, ptr %0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3416, metadata !DIExpression()), !dbg !3419
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %0, metadata !3418, metadata !DIExpression()), !dbg !3419
  %this1 = load ptr, ptr %this.addr, align 4
  %1 = load %"class.aie::accum", ptr %0, align 32, !dbg !3420, !tbaa !1718
  call addrspace(1) void @_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_(ptr nonnull align 32 dereferenceable(32) %this1, %"class.aie::accum" %1) #24, !dbg !3420
  ret void, !dbg !3420
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::accum" %parent.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3421 {
entry:
  %parent = alloca %"class.aie::accum", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::accum" %parent.coerce, ptr %parent, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3423, metadata !DIExpression()), !dbg !3426
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %parent, metadata !3425, metadata !DIExpression()), !dbg !3427
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common", ptr %this1, i32 0, i32 0, !dbg !3428
  %0 = load %"class.aie::accum", ptr %parent, align 32, !dbg !3429, !tbaa !1718
  store %"class.aie::accum" %0, ptr %parent_, align 32, !dbg !3429, !tbaa !1718
  ret void, !dbg !3430
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EE8elem_refEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3431 {
entry:
  %retval = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3433, metadata !DIExpression()), !dbg !3435
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3434, metadata !DIExpression()), !dbg !3436
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !3437

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3438, !tbaa !1755
  %cmp = icmp ult i32 %0, 8, !dbg !3438
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !3438
  br i1 %1, label %if.then, label %if.else, !dbg !3441

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !3442

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !3444, !tbaa !1755
  %cmp3 = icmp ult i32 %2, 8, !dbg !3444
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !3444
  br i1 %3, label %if.end, label %if.then4, !dbg !3447

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !1926), !dbg !3444
  br label %if.end, !dbg !3444

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !3447

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !3442

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3448, !tbaa !1755
  %cmp5 = icmp ult i32 %4, 8, !dbg !3448
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !3448
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !3441

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !3450, !tbaa !1755
  call addrspace(1) void @_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj(ptr nonnull align 4 dereferenceable(8) %retval, ptr nonnull align 32 dereferenceable(32) %this1, i32 noundef %5) #24, !dbg !3451
  %6 = load %"class.aie::vector_elem_ref", ptr %retval, align 4, !dbg !3452
  ret %"class.aie::vector_elem_ref" %6, !dbg !3452
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj(ptr nonnull align 4 dereferenceable(8) %this, ptr nonnull align 32 dereferenceable(32) %v, i32 noundef %idx) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !3453 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3455, metadata !DIExpression()), !dbg !3459
  store ptr %v, ptr %v.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3457, metadata !DIExpression()), !dbg !3460
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1755
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3458, metadata !DIExpression()), !dbg !3461
  %this1 = load ptr, ptr %this.addr, align 4
  %parent = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %this1, i32 0, i32 0, !dbg !3462
  %0 = load ptr, ptr %v.addr, align 4, !dbg !3463, !tbaa !1542
  store ptr %0, ptr %parent, align 4, !dbg !3462, !tbaa !1542
  %offset = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %this1, i32 0, i32 1, !dbg !3464
  %1 = load i32, ptr %idx.addr, align 4, !dbg !3465, !tbaa !1755
  store i32 %1, ptr %offset, align 4, !dbg !3464, !tbaa !2651
  ret void, !dbg !3466
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE(ptr %_w, %"class.aie::accum" %value.coerce) addrspace(1) #6 comdat align 2 !dbg !3467 {
entry:
  %value = alloca %"class.aie::accum", align 32
  %_w.addr = alloca ptr, align 4
  %w = alloca ptr, align 4
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %ref.tmp = alloca %"class.aie::accum.2", align 32
  store %"class.aie::accum" %value.coerce, ptr %value, align 32
  store ptr %_w, ptr %_w.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %_w.addr, metadata !3469, metadata !DIExpression()), !dbg !3472
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %value, metadata !3470, metadata !DIExpression()), !dbg !3473
  store ptr undef, ptr %w, align 4, !dbg !3474
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %w) #22, !dbg !3474
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w, metadata !3471, metadata !DIExpression()), !dbg !3475
  %0 = load ptr, ptr %_w.addr, align 4, !dbg !3476, !tbaa !1542
  store ptr %0, ptr %w, align 4, !dbg !3475, !tbaa !1542
  %1 = load ptr, ptr %w, align 4, !dbg !3477, !tbaa !1542
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3480
  %call = call addrspace(1) %"class.aie::accum.2" @_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv(ptr nonnull align 32 dereferenceable(32) %value) #24, !dbg !3481
  %2 = getelementptr inbounds %"class.aie::accum.2", ptr %ref.tmp, i32 0, i32 0, !dbg !3481
  %3 = extractvalue %"class.aie::accum.2" %call, 0, !dbg !3481
  store %"class.aie::detail::accum_base.3" %3, ptr %2, align 32, !dbg !3481
  %call1 = call addrspace(1) %struct.v16accfloat @_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %ref.tmp) #24, !dbg !3480
  %4 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !3480
  %5 = extractvalue %struct.v16accfloat %call1, 0, !dbg !3480
  store %struct.ipd.custom_type.v16acc32.v16acc32 %5, ptr %4, align 32, !dbg !3480
  %6 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !3482, !tbaa !2252
  call addrspace(1) void @_ZL9writeincrP14output_cascadeI8accfloatvE11v16accfloat(ptr %1, %struct.v16accfloat noundef %6) #24, !dbg !3482
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3482
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %w) #22, !dbg !3483
  ret void, !dbg !3483
}

; Function Attrs: inlinehint mustprogress nounwind
define internal void @_ZL9writeincrP14output_cascadeI8accfloatvE11v16accfloat(ptr %str, %struct.v16accfloat noundef %value.coerce) addrspace(1) #5 !dbg !3484 {
entry:
  %value = alloca %struct.v16accfloat, align 32
  %str.addr = alloca ptr, align 4
  store %struct.v16accfloat %value.coerce, ptr %value, align 32
  store ptr %str, ptr %str.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %str.addr, metadata !3488, metadata !DIExpression()), !dbg !3490
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %value, metadata !3489, metadata !DIExpression()), !dbg !3490
  %0 = load %struct.v16accfloat, ptr %value, align 32, !dbg !3490, !tbaa !2252
  call addrspace(1) void @_Z7put_mcd11v16accfloat(%struct.v16accfloat %0) #24, !dbg !3490
  ret void, !dbg !3490
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z7put_mcd11v16accfloat(%struct.v16accfloat %a.coerce) addrspace(1) #6 comdat {
entry:
  %a = alloca %struct.v16accfloat, align 32
  store %struct.v16accfloat %a.coerce, ptr %a, align 32
  %0 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2252
  call addrspace(1) void @_Z7put_mcd11v16accfloati(%struct.v16accfloat %0, i32 1) #24
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
  store i32 %en, ptr %en.addr, align 4, !tbaa !1755
  %0 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2252
  call addrspace(1) void @_ZN8v16acc32C2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16accfloat %0) #27
  %1 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %custom_type.tmp, align 32, !tbaa !2252
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %agg.tmp, align 32, !tbaa !2252
  %2 = load i32, ptr %en.addr, align 4, !tbaa !1755
  %3 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp, align 32, !tbaa !2252
  call addrspace(1) void @_Z7put_mcd8v16acc32i(%struct.ipd.custom_type.v16acc32.v16acc32 %3, i32 %2) #24
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
  store i32 %en, ptr %en.addr, align 4, !tbaa !1755
  %0 = load i32, ptr %en.addr, align 4, !tbaa !1755
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 %0) #24
  %1 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2321
  store %struct.ipd.custom_type.uint1_t.uint1_t %1, ptr %agg.tmp, align 4, !tbaa !2321
  %2 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %a, align 32, !tbaa !2252
  %3 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2321
  %call = call addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @_ZN12me_primitive9mcd_writeE8v16acc327uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %2, %struct.ipd.custom_type.uint1_t.uint1_t %3) #26
  store %struct.ipd.custom_type.v16acc32.v16acc32 %call, ptr %agg.tmp1, align 32
  %4 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp1, align 32, !tbaa !2252
  store volatile %struct.ipd.custom_type.v16acc32.v16acc32 %4, ptr !register !1509, align 32, !tbaa !2252, !chess_protect_access !2320
  ret void
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN8v16acc32C2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16accfloat %a0.coerce) unnamed_addr addrspace(1) #16 comdat align 2 {
entry:
  %a0 = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  store %struct.v16accfloat %a0.coerce, ptr %a0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2252
  %call = call x86_regcallcc addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_v16acc32_v16accfloat(%struct.v16accfloat %0) #25
  store %struct.ipd.custom_type.v16acc32.v16acc32 %call, ptr %agg.tmp, align 32
  %1 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp, align 32, !tbaa !2252
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %this1, align 32, !tbaa !2252
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.ipd.custom_type.v16acc32.v16acc32 @_ZN12me_primitive9mcd_writeE8v16acc327uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %a0.coerce, %struct.ipd.custom_type.uint1_t.uint1_t %a1.coerce) addrspace(1) #15 comdat {
entry:
  %a0 = alloca %struct.ipd.custom_type.v16acc32.v16acc32, align 32
  %a1 = alloca %struct.ipd.custom_type.uint1_t.uint1_t, align 4
  store %struct.ipd.custom_type.v16acc32.v16acc32 %a0.coerce, ptr %a0, align 32
  store %struct.ipd.custom_type.uint1_t.uint1_t %a1.coerce, ptr %a1, align 4
  %0 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %a0, align 32, !tbaa !2252
  %1 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a1, align 4, !tbaa !2321
  %call = call x86_regcallcc addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_mcd_write_v16acc32_uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %0, %struct.ipd.custom_type.uint1_t.uint1_t %1) #25
  ret %struct.ipd.custom_type.v16acc32.v16acc32 %call
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_mcd_write_v16acc32_uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32, %struct.ipd.custom_type.uint1_t.uint1_t) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_v16acc32_v16accfloat(%struct.v16accfloat) addrspace(1) #14

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEC2Ev(ptr nonnull align 4 dereferenceable(4) %this) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !3491 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1542
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3493, metadata !DIExpression()), !dbg !3494
  %this1 = load ptr, ptr %this.addr, align 4
  ret void, !dbg !3495
}

; Function Attrs: nounwind
define internal void @_GLOBAL__sub_I_i2_wrap_matrix_vector_mul.cpp() addrspace(1) #8 !dbg !3496 {
entry:
  call addrspace(1) void @__cxx_global_var_init(), !dbg !3498
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
attributes #19 = { alwaysinline mustprogress nounwind "chessFP:property"="do_generate_llvm" "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #20 = { nounwind memory(inaccessiblemem: readwrite) "frame-pointer"="all" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #21 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #22 = { nounwind }
attributes #23 = { nounwind "no-builtin-memcpy" }
attributes #24 = { "no-builtin-memcpy" }
attributes #25 = { nounwind willreturn memory(none) "no-builtin-memcpy" }
attributes #26 = { "chessFP:llvm_local_block_replace_operand_with_variable" "no-builtin-memcpy" }
attributes #27 = { "chessFP:property"="reinterpret" "no-builtin-memcpy" }
attributes #28 = { "chessFP:property"="do_generate_llvm" "no-builtin-memcpy" }
attributes #29 = { nounwind memory(inaccessiblemem: readwrite) "no-builtin-memcpy" }

!llvm.dbg.cu = !{!2}
!llvm.named.register.SCD = !{!1506}
!llvm.named.register.crF2FMask = !{!1507}
!llvm.named.register.crFPMask = !{!1508}
!llvm.named.register.MCD = !{!1509}
!llvm.linker.options = !{}
!llvm.chess.memory-units = !{!1510, !1511, !1512, !1513, !1514, !1515, !1516, !1517, !1518, !1519, !1520, !1521, !1522, !1523}
!llvm.module.flags = !{!1524, !1525, !1526, !1527}
!llvm.ident = !{!1528}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "i2", scope: !2, file: !1397, line: 7, type: !1040, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !3, producer: "clang version 16.0.3 (/u/sgasip/ipd/repositories/llvm_ipd 6a0b186d7c0e25173296a8e19f630e71bd7e8ed9)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !78, globals: !1077, imports: !1082, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i2_wrap_matrix_vector_mul.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir")
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
!78 = !{!79, !81, !371, !470, !15, !486, !124, !488, !490, !374, !308, !492, !494, !144, !569, !112, !129, !85, !571, !613, !188, !648, !649, !650, !651, !652, !653, !654, !655, !656, !657, !658, !659, !660, !661, !662, !663, !664, !665, !666, !667, !668, !669, !670, !671, !672, !673, !674, !675, !676, !677, !678, !679, !691, !736, !737, !738, !739, !740, !397, !741, !212, !322, !192, !378, !742, !891, !892, !893, !894, !895, !896, !897, !898, !899, !493, !570, !900, !901, !902, !903, !904, !489, !905, !487, !854, !745, !906, !491, !497, !934, !958, !980, !1001, !1014, !1027, !1040}
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 32)
!80 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 32)
!82 = !DIDerivedType(tag: DW_TAG_typedef, name: "dataA_t", scope: !84, file: !83, line: 161, baseType: !188)
!83 = !DIFile(filename: "dsp_lib/L1/src/aie/matrix_vector_mul.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!84 = distinct !DISubprogram(name: "matVecMulBasic", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !83, line: 158, type: !109, scopeLine: 159, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !146, retainedNodes: !178)
!85 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "kernelMatVecMulClass<float, float, 128U, 768U, 0U, 0U, 0U, 1U, 12U, 1U, 0U, 0U, 1U, 9U, true, true>", scope: !87, file: !86, line: 77, size: 32, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !92, templateParams: !160, identifier: "_ZTSN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEE")
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
!108 = !DISubprogram(name: "matVecMulSelectArch", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 123, type: !109, scopeLine: 123, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
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
!146 = !DISubprogram(name: "matVecMulBasic", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 126, type: !109, scopeLine: 126, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!147 = !DISubprogram(name: "matVecMulStream", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE15matVecMulStreamENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 128, type: !109, scopeLine: 128, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!148 = !DISubprogram(name: "setInMatrixPtr", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14setInMatrixPtrERA8192_Kf", scope: !85, file: !86, line: 132, type: !149, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
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
!159 = !DISubprogram(name: "matVecMulKernel", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 140, type: !109, scopeLine: 140, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
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
!174 = !DITemplateValueParameter(name: "TP_KERNEL_POSITION", type: !15, value: i32 9)
!175 = !DITemplateValueParameter(name: "TP_CASC_IN", type: !176, value: i1 true)
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
!490 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint1_t", file: !34, line: 464, baseType: !491)
!491 = !DIBasicType(name: "uint1_t", size: 32, encoding: DW_ATE_unsigned)
!492 = !DIDerivedType(tag: DW_TAG_typedef, name: "v32bfloat16", file: !34, line: 613, baseType: !493)
!493 = !DIBasicType(name: "v32bfloat16", size: 512, encoding: DW_ATE_unsigned)
!494 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "accum<accfloat, 16U>", scope: !8, file: !375, line: 47, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !495, templateParams: !568, identifier: "_ZTSN3aie5accumI8accfloatLj16EEE")
!495 = !{!496, !535, !542, !543, !544, !545, !546, !547, !548, !549, !550, !551, !552, !555, !560, !564}
!496 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !494, baseType: !497, extraData: i32 0)
!497 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "accum_base<(aie::detail::AccumClass)2, 32U, 16U>", scope: !7, file: !379, line: 144, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !498, templateParams: !534, identifier: "_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEE")
!498 = !{!499, !500, !501, !512, !513, !514, !515, !516, !517, !518, !519, !520, !521, !522, !526, !529}
!499 = !DIDerivedType(tag: DW_TAG_member, name: "Bits", scope: !497, file: !379, line: 146, baseType: !101, flags: DIFlagStaticMember, extraData: i32 32)
!500 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems", scope: !497, file: !379, line: 985, baseType: !101, flags: DIFlagStaticMember)
!501 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !497, file: !379, line: 991, baseType: !502, size: 512)
!502 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !497, file: !379, line: 155, baseType: !503, flags: DIFlagPublic)
!503 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_storage_t<(aie::detail::AccumClass)2, Bits, 16U>", scope: !7, file: !386, line: 135, baseType: !504)
!504 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !505, file: !386, line: 167, baseType: !488)
!505 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "accum_storage<(aie::detail::AccumClass)2, 32U, 16U>", scope: !7, file: !386, line: 167, size: 8, flags: DIFlagTypePassByValue, elements: !506, templateParams: !510, identifier: "_ZTSN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EEE")
!506 = !{!507}
!507 = !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv", scope: !505, file: !386, line: 167, type: !508, scopeLine: 167, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!508 = !DISubroutineType(types: !509)
!509 = !{!504}
!510 = !{!394, !395, !511}
!511 = !DITemplateValueParameter(name: "Elems", type: !15, value: i32 16)
!512 = !DISubprogram(name: "value_class", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE11value_classEv", scope: !497, file: !379, line: 157, type: !399, scopeLine: 157, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!513 = !DISubprogram(name: "accum_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE10accum_bitsEv", scope: !497, file: !379, line: 162, type: !214, scopeLine: 162, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!514 = !DISubprogram(name: "accum_min_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE14accum_min_bitsEv", scope: !497, file: !379, line: 167, type: !214, scopeLine: 167, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!515 = !DISubprogram(name: "value_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE10value_bitsEv", scope: !497, file: !379, line: 172, type: !214, scopeLine: 172, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!516 = !DISubprogram(name: "memory_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE11memory_bitsEv", scope: !497, file: !379, line: 180, type: !214, scopeLine: 180, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!517 = !DISubprogram(name: "size", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE4sizeEv", scope: !497, file: !379, line: 192, type: !214, scopeLine: 192, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!518 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE4bitsEv", scope: !497, file: !379, line: 197, type: !214, scopeLine: 197, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!519 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE10is_complexEv", scope: !497, file: !379, line: 205, type: !219, scopeLine: 205, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!520 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7is_realEv", scope: !497, file: !379, line: 214, type: !219, scopeLine: 214, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!521 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE17is_floating_pointEv", scope: !497, file: !379, line: 219, type: !219, scopeLine: 219, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!522 = !DISubprogram(name: "accum_base", scope: !497, file: !379, line: 229, type: !523, scopeLine: 229, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!523 = !DISubroutineType(types: !524)
!524 = !{null, !525}
!525 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !497, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!526 = !DISubprogram(name: "accum_base", scope: !497, file: !379, line: 242, type: !527, scopeLine: 242, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!527 = !DISubroutineType(types: !528)
!528 = !{null, !525, !502}
!529 = !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv", scope: !497, file: !379, line: 256, type: !530, scopeLine: 256, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!530 = !DISubroutineType(types: !531)
!531 = !{!502, !532}
!532 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !533, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!533 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !497)
!534 = !{!394, !423, !511}
!535 = !DISubprogram(name: "accum", scope: !494, file: !375, line: 59, type: !536, scopeLine: 59, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!536 = !DISubroutineType(types: !537)
!537 = !{null, !538, !539}
!538 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !494, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!539 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !540, size: 32)
!540 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !541)
!541 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !494, file: !375, line: 51, baseType: !497)
!542 = !DISubprogram(name: "value_class", linkageName: "_ZN3aie5accumI8accfloatLj16EE11value_classEv", scope: !494, file: !375, line: 78, type: !399, scopeLine: 78, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!543 = !DISubprogram(name: "accum_min_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE14accum_min_bitsEv", scope: !494, file: !375, line: 83, type: !214, scopeLine: 83, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!544 = !DISubprogram(name: "accum_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE10accum_bitsEv", scope: !494, file: !375, line: 90, type: !214, scopeLine: 90, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!545 = !DISubprogram(name: "value_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE10value_bitsEv", scope: !494, file: !375, line: 97, type: !214, scopeLine: 97, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!546 = !DISubprogram(name: "memory_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE11memory_bitsEv", scope: !494, file: !375, line: 104, type: !214, scopeLine: 104, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!547 = !DISubprogram(name: "size", linkageName: "_ZN3aie5accumI8accfloatLj16EE4sizeEv", scope: !494, file: !375, line: 109, type: !214, scopeLine: 109, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!548 = !DISubprogram(name: "bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE4bitsEv", scope: !494, file: !375, line: 114, type: !214, scopeLine: 114, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!549 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie5accumI8accfloatLj16EE10is_complexEv", scope: !494, file: !375, line: 119, type: !219, scopeLine: 119, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!550 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie5accumI8accfloatLj16EE7is_realEv", scope: !494, file: !375, line: 124, type: !219, scopeLine: 124, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!551 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie5accumI8accfloatLj16EE17is_floating_pointEv", scope: !494, file: !375, line: 129, type: !219, scopeLine: 129, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!552 = !DISubprogram(name: "accum", scope: !494, file: !375, line: 163, type: !553, scopeLine: 163, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!553 = !DISubroutineType(types: !554)
!554 = !{null, !538}
!555 = !DISubprogram(name: "accum", scope: !494, file: !375, line: 168, type: !556, scopeLine: 168, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!556 = !DISubroutineType(types: !557)
!557 = !{null, !538, !558}
!558 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !559, size: 32)
!559 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !494)
!560 = !DISubprogram(name: "accum", scope: !494, file: !375, line: 188, type: !561, scopeLine: 188, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!561 = !DISubroutineType(types: !562)
!562 = !{null, !538, !563}
!563 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !494, file: !375, line: 73, baseType: !502, flags: DIFlagPublic)
!564 = !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv", scope: !494, file: !375, line: 234, type: !565, scopeLine: 234, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!565 = !DISubroutineType(types: !566)
!566 = !{!563, !567}
!567 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !559, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!568 = !{!458, !511}
!569 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16acc32", file: !34, line: 560, baseType: !570)
!570 = !DIBasicType(name: "v16acc32", size: 512, encoding: DW_ATE_unsigned)
!571 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tile", scope: !7, file: !572, line: 30, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !573, identifier: "_ZTSN3aie6detail4tileE")
!572 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/tile.hpp", directory: "")
!573 = !{!574, !579, !583, !592, !593, !598, !601, !604, !607, !610}
!574 = !DIDerivedType(tag: DW_TAG_member, name: "compute_row_offset", scope: !571, file: !572, line: 33, baseType: !575, flags: DIFlagStaticMember, extraData: i16 3)
!575 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !576)
!576 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !577, line: 30, baseType: !578)
!577 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdint.h", directory: "")
!578 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!579 = !DISubprogram(name: "tile", scope: !571, file: !572, line: 36, type: !580, scopeLine: 36, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!580 = !DISubroutineType(types: !581)
!581 = !{null, !582}
!582 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !571, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!583 = !DISubprogram(name: "global_id", linkageName: "_ZNK3aie6detail4tile9global_idEv", scope: !571, file: !572, line: 40, type: !584, scopeLine: 40, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!584 = !DISubroutineType(types: !585)
!585 = !{!586, !590}
!586 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tile_id", scope: !8, file: !14, line: 52, size: 32, flags: DIFlagTypePassByValue, elements: !587, identifier: "_ZTSN3aie7tile_idE")
!587 = !{!588, !589}
!588 = !DIDerivedType(tag: DW_TAG_member, name: "row", scope: !586, file: !14, line: 54, baseType: !576, size: 16)
!589 = !DIDerivedType(tag: DW_TAG_member, name: "col", scope: !586, file: !14, line: 55, baseType: !576, size: 16, offset: 16)
!590 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !591, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!591 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !571)
!592 = !DISubprogram(name: "id", linkageName: "_ZNK3aie6detail4tile2idEv", scope: !571, file: !572, line: 49, type: !584, scopeLine: 49, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!593 = !DISubprogram(name: "cycles", linkageName: "_ZNK3aie6detail4tile6cyclesEv", scope: !571, file: !572, line: 58, type: !594, scopeLine: 58, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!594 = !DISubroutineType(types: !595)
!595 = !{!596, !590}
!596 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !577, line: 32, baseType: !597)
!597 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!598 = !DISubprogram(name: "current", linkageName: "_ZN3aie6detail4tile7currentEv", scope: !571, file: !572, line: 64, type: !599, scopeLine: 64, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!599 = !DISubroutineType(types: !600)
!600 = !{!571}
!601 = !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE", scope: !571, file: !572, line: 70, type: !602, scopeLine: 70, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!602 = !DISubroutineType(types: !603)
!603 = !{null, !582, !27}
!604 = !DISubprogram(name: "get_saturation", linkageName: "_ZNK3aie6detail4tile14get_saturationEv", scope: !571, file: !572, line: 76, type: !605, scopeLine: 76, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!605 = !DISubroutineType(types: !606)
!606 = !{!27, !590}
!607 = !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE", scope: !571, file: !572, line: 82, type: !608, scopeLine: 82, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!608 = !DISubroutineType(types: !609)
!609 = !{null, !582, !13}
!610 = !DISubprogram(name: "get_rounding", linkageName: "_ZNK3aie6detail4tile12get_roundingEv", scope: !571, file: !572, line: 88, type: !611, scopeLine: 88, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!611 = !DISubroutineType(types: !612)
!612 = !{!13, !590}
!613 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tile", scope: !8, file: !614, line: 25, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !615, identifier: "_ZTSN3aie4tileE")
!614 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/tile.hpp", directory: "")
!615 = !{!616, !617, !624, !629, !630, !633, !636, !639, !642, !645}
!616 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !613, baseType: !571, extraData: i32 0)
!617 = !DISubprogram(name: "tile", scope: !613, file: !614, line: 30, type: !618, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!618 = !DISubroutineType(types: !619)
!619 = !{null, !620, !621}
!620 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !613, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!621 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !622, size: 32)
!622 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !623)
!623 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !613, file: !614, line: 28, baseType: !571)
!624 = !DISubprogram(name: "global_id", linkageName: "_ZNK3aie4tile9global_idEv", scope: !613, file: !614, line: 34, type: !625, scopeLine: 34, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!625 = !DISubroutineType(types: !626)
!626 = !{!586, !627}
!627 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !628, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!628 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !613)
!629 = !DISubprogram(name: "id", linkageName: "_ZNK3aie4tile2idEv", scope: !613, file: !614, line: 38, type: !625, scopeLine: 38, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!630 = !DISubprogram(name: "cycles", linkageName: "_ZNK3aie4tile6cyclesEv", scope: !613, file: !614, line: 42, type: !631, scopeLine: 42, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!631 = !DISubroutineType(types: !632)
!632 = !{!596, !627}
!633 = !DISubprogram(name: "current", linkageName: "_ZN3aie4tile7currentEv", scope: !613, file: !614, line: 46, type: !634, scopeLine: 46, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!634 = !DISubroutineType(types: !635)
!635 = !{!613}
!636 = !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie4tile14set_saturationENS_15saturation_modeE", scope: !613, file: !614, line: 50, type: !637, scopeLine: 50, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!637 = !DISubroutineType(types: !638)
!638 = !{null, !620, !27}
!639 = !DISubprogram(name: "get_saturation", linkageName: "_ZNK3aie4tile14get_saturationEv", scope: !613, file: !614, line: 54, type: !640, scopeLine: 54, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!640 = !DISubroutineType(types: !641)
!641 = !{!27, !627}
!642 = !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie4tile12set_roundingENS_13rounding_modeE", scope: !613, file: !614, line: 58, type: !643, scopeLine: 58, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!643 = !DISubroutineType(types: !644)
!644 = !{null, !620, !13}
!645 = !DISubprogram(name: "get_rounding", linkageName: "_ZNK3aie4tile12get_roundingEv", scope: !613, file: !614, line: 63, type: !646, scopeLine: 63, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!646 = !DISubroutineType(types: !647)
!647 = !{!13, !627}
!648 = !DIBasicType(name: "v64uint4", size: 256, encoding: DW_ATE_unsigned)
!649 = !DIBasicType(name: "v32uint8", size: 256, encoding: DW_ATE_unsigned)
!650 = !DIBasicType(name: "v32int8", size: 256, encoding: DW_ATE_unsigned)
!651 = !DIBasicType(name: "v16uint16", size: 256, encoding: DW_ATE_unsigned)
!652 = !DIBasicType(name: "v16int16", size: 256, encoding: DW_ATE_unsigned)
!653 = !DIBasicType(name: "v8cint16", size: 256, encoding: DW_ATE_unsigned)
!654 = !DIBasicType(name: "v8uint32", size: 256, encoding: DW_ATE_unsigned)
!655 = !DIBasicType(name: "v8int32", size: 256, encoding: DW_ATE_unsigned)
!656 = !DIBasicType(name: "v4cint32", size: 256, encoding: DW_ATE_unsigned)
!657 = !DIBasicType(name: "v16bfloat16", size: 256, encoding: DW_ATE_unsigned)
!658 = !DIBasicType(name: "v8acc32", size: 256, encoding: DW_ATE_unsigned)
!659 = !DIBasicType(name: "v4acc64", size: 256, encoding: DW_ATE_unsigned)
!660 = !DIBasicType(name: "v2cacc64", size: 256, encoding: DW_ATE_unsigned)
!661 = !DIBasicType(name: "v4caccfloat", size: 256, encoding: DW_ATE_unsigned)
!662 = !DIBasicType(name: "v4cfloat", size: 256, encoding: DW_ATE_unsigned)
!663 = !DIBasicType(name: "v8cbfloat16", size: 256, encoding: DW_ATE_unsigned)
!664 = !DIBasicType(name: "v32uint4", size: 128, encoding: DW_ATE_unsigned)
!665 = !DIBasicType(name: "v16uint8", size: 128, encoding: DW_ATE_unsigned)
!666 = !DIBasicType(name: "v16int8", size: 128, encoding: DW_ATE_unsigned)
!667 = !DIBasicType(name: "v8uint16", size: 128, encoding: DW_ATE_unsigned)
!668 = !DIBasicType(name: "v8int16", size: 128, encoding: DW_ATE_unsigned)
!669 = !DIBasicType(name: "v4cint16", size: 128, encoding: DW_ATE_unsigned)
!670 = !DIBasicType(name: "v4uint32", size: 128, encoding: DW_ATE_unsigned)
!671 = !DIBasicType(name: "v4int32", size: 128, encoding: DW_ATE_unsigned)
!672 = !DIBasicType(name: "v2cint32", size: 128, encoding: DW_ATE_unsigned)
!673 = !DIBasicType(name: "v8bfloat16", size: 128, encoding: DW_ATE_unsigned)
!674 = !DIBasicType(name: "v4float", size: 128, encoding: DW_ATE_unsigned)
!675 = !DIBasicType(name: "v2cfloat", size: 128, encoding: DW_ATE_unsigned)
!676 = !DIBasicType(name: "v16uint4", size: 64, encoding: DW_ATE_unsigned)
!677 = !DIBasicType(name: "v16int4", size: 64, encoding: DW_ATE_unsigned)
!678 = !DIBasicType(name: "cint32_w64", size: 64, encoding: DW_ATE_unsigned)
!679 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cint32", file: !34, line: 5738, size: 64, flags: DIFlagTypePassByValue, elements: !680, identifier: "_ZTS6cint32")
!680 = !{!681, !682, !683, !687, !692, !733}
!681 = !DIDerivedType(tag: DW_TAG_member, name: "real", scope: !679, file: !34, line: 5739, baseType: !9, size: 32)
!682 = !DIDerivedType(tag: DW_TAG_member, name: "imag", scope: !679, file: !34, line: 5740, baseType: !9, size: 32, offset: 32)
!683 = !DISubprogram(name: "cint32", scope: !679, file: !34, line: 5743, type: !684, scopeLine: 5743, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!684 = !DISubroutineType(types: !685)
!685 = !{null, !686, !9, !9}
!686 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !679, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!687 = !DISubprogram(name: "cint32", scope: !679, file: !34, line: 5744, type: !688, scopeLine: 5744, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!688 = !DISubroutineType(types: !689)
!689 = !{null, !686, !690}
!690 = !DIDerivedType(tag: DW_TAG_typedef, name: "cint16", file: !34, line: 476, baseType: !691)
!691 = !DIBasicType(name: "cint16", size: 32, encoding: DW_ATE_unsigned)
!692 = !DISubprogram(name: "cint32", scope: !679, file: !34, line: 5745, type: !693, scopeLine: 5745, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!693 = !DISubroutineType(types: !694)
!694 = !{null, !686, !695}
!695 = !DIDerivedType(tag: DW_TAG_typedef, name: "cint32_w64", file: !34, line: 635, baseType: !696)
!696 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cint32_w64", file: !34, line: 5714, size: 64, flags: DIFlagTypePassByValue, elements: !697, identifier: "_ZTS10cint32_w64")
!697 = !{!698, !700, !704, !707, !711, !714}
!698 = !DIDerivedType(tag: DW_TAG_member, name: "mw", scope: !696, file: !34, line: 5723, baseType: !699, size: 64)
!699 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16int4", file: !34, line: 509, baseType: !677)
!700 = !DISubprogram(name: "cint32_w64", scope: !696, file: !34, line: 5716, type: !701, scopeLine: 5716, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!701 = !DISubroutineType(types: !702)
!702 = !{null, !703, !9}
!703 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !696, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!704 = !DISubprogram(name: "cint32_w64", scope: !696, file: !34, line: 5717, type: !705, scopeLine: 5717, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!705 = !DISubroutineType(types: !706)
!706 = !{null, !703, !9, !9}
!707 = !DISubprogram(name: "cint32_w64", scope: !696, file: !34, line: 5718, type: !708, scopeLine: 5718, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!708 = !DISubroutineType(types: !709)
!709 = !{null, !703, !710}
!710 = !DIDerivedType(tag: DW_TAG_typedef, name: "cint32", file: !34, line: 862, baseType: !679)
!711 = !DISubprogram(name: "cint32_w64", scope: !696, file: !34, line: 5719, type: !712, scopeLine: 5719, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!712 = !DISubroutineType(types: !713)
!713 = !{null, !703}
!714 = !DISubprogram(name: "cint32_w64", scope: !696, file: !34, line: 5720, type: !715, scopeLine: 5720, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!715 = !DISubroutineType(types: !716)
!716 = !{null, !703, !33, !717}
!717 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16int4", file: !34, line: 509, baseType: !718)
!718 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "v16int4", file: !34, line: 1831, size: 64, flags: DIFlagTypePassByValue, elements: !719, identifier: "_ZTS7v16int4")
!719 = !{!720, !721, !722, !727, !730}
!720 = !DIDerivedType(tag: DW_TAG_member, name: "m1", scope: !718, file: !34, line: 1839, baseType: !15, size: 32, flags: DIFlagBitField, extraData: i64 0)
!721 = !DIDerivedType(tag: DW_TAG_member, name: "m0", scope: !718, file: !34, line: 1840, baseType: !15, size: 32, offset: 32, flags: DIFlagBitField, extraData: i64 0)
!722 = !DISubprogram(name: "v16int4", scope: !718, file: !34, line: 1833, type: !723, scopeLine: 1833, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!723 = !DISubroutineType(types: !724)
!724 = !{null, !725, !726}
!725 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !718, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!726 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16uint4", file: !34, line: 510, baseType: !676)
!727 = !DISubprogram(name: "v16int4", scope: !718, file: !34, line: 1834, type: !728, scopeLine: 1834, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!728 = !DISubroutineType(types: !729)
!729 = !{null, !725}
!730 = !DISubprogram(name: "v16int4", scope: !718, file: !34, line: 1835, type: !731, scopeLine: 1835, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!731 = !DISubroutineType(types: !732)
!732 = !{null, !725, !33, !15, !15}
!733 = !DISubprogram(name: "cint32", scope: !679, file: !34, line: 5746, type: !734, scopeLine: 5746, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!734 = !DISubroutineType(types: !735)
!735 = !{null, !686}
!736 = !DIBasicType(name: "bfloat16", size: 16, encoding: DW_ATE_unsigned)
!737 = !DIBasicType(name: "uint4_t", size: 8, encoding: DW_ATE_unsigned)
!738 = !DIBasicType(name: "int4_t", size: 8, encoding: DW_ATE_signed)
!739 = !DIBasicType(name: "v32int4", size: 128, encoding: DW_ATE_unsigned)
!740 = !DIBasicType(name: "v4cbfloat16", size: 128, encoding: DW_ATE_unsigned)
!741 = !DIBasicType(name: "v64int4", size: 256, encoding: DW_ATE_unsigned)
!742 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector<float, 16U>", scope: !8, file: !189, line: 77, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !743, templateParams: !758, identifier: "_ZTSN3aie6vectorIfLj16EEE")
!743 = !{!744, !801, !808, !809, !810, !811, !812, !813, !814, !815, !816, !817, !820, !824, !830, !835, !836, !841, !844, !847, !851, !888, !889, !890}
!744 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !742, baseType: !745, extraData: i32 0)
!745 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_base<float, 16U>", scope: !7, file: !193, line: 348, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !746, templateParams: !758, identifier: "_ZTSN3aie6detail11vector_baseIfLj16EEE")
!746 = !{!747, !748, !749, !750, !759, !760, !761, !762, !763, !764, !765, !766, !767, !771, !775, !784, !789, !792, !797, !800}
!747 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems", scope: !745, file: !193, line: 1350, baseType: !101, flags: DIFlagStaticMember)
!748 = !DIDerivedType(tag: DW_TAG_member, name: "num_storage_elems", scope: !745, file: !193, line: 1351, baseType: !101, flags: DIFlagStaticMember, extraData: i32 1)
!749 = !DIDerivedType(tag: DW_TAG_member, name: "is_compound_storage", scope: !745, file: !193, line: 1352, baseType: !198, flags: DIFlagStaticMember)
!750 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !745, file: !193, line: 1357, baseType: !751, size: 512)
!751 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_storage_t<float, 16U>", scope: !7, file: !201, line: 205, baseType: !752)
!752 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !753, file: !201, line: 299, baseType: !486)
!753 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vector_storage<float, 16U>", scope: !7, file: !201, line: 299, size: 8, flags: DIFlagTypePassByValue, elements: !754, templateParams: !758, identifier: "_ZTSN3aie6detail14vector_storageIfLj16EEE")
!754 = !{!755}
!755 = !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj16EE5undefEv", scope: !753, file: !201, line: 299, type: !756, scopeLine: 299, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!756 = !DISubroutineType(types: !757)
!757 = !{!752}
!758 = !{!209, !511}
!759 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE9type_bitsEv", scope: !745, file: !193, line: 361, type: !214, scopeLine: 361, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!760 = !DISubprogram(name: "size", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE4sizeEv", scope: !745, file: !193, line: 366, type: !214, scopeLine: 366, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!761 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE4bitsEv", scope: !745, file: !193, line: 371, type: !214, scopeLine: 371, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!762 = !DISubprogram(name: "is_signed", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE9is_signedEv", scope: !745, file: !193, line: 376, type: !219, scopeLine: 376, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!763 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE10is_complexEv", scope: !745, file: !193, line: 381, type: !219, scopeLine: 381, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!764 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE7is_realEv", scope: !745, file: !193, line: 386, type: !219, scopeLine: 386, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!765 = !DISubprogram(name: "is_integral", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE11is_integralEv", scope: !745, file: !193, line: 391, type: !219, scopeLine: 391, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!766 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE17is_floating_pointEv", scope: !745, file: !193, line: 396, type: !219, scopeLine: 396, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!767 = !DISubprogram(name: "vector_base", scope: !745, file: !193, line: 402, type: !768, scopeLine: 402, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!768 = !DISubroutineType(types: !769)
!769 = !{null, !770}
!770 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !745, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!771 = !DISubprogram(name: "vector_base", scope: !745, file: !193, line: 408, type: !772, scopeLine: 408, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!772 = !DISubroutineType(types: !773)
!773 = !{null, !770, !774}
!774 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !745, file: !193, line: 359, baseType: !752, flags: DIFlagPublic)
!775 = !DISubprogram(name: "vector_base", scope: !745, file: !193, line: 421, type: !776, scopeLine: 421, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!776 = !DISubroutineType(types: !777)
!777 = !{null, !770, !778}
!778 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !779, size: 32)
!779 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !780)
!780 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_type", scope: !745, file: !193, line: 357, baseType: !781, flags: DIFlagPublic)
!781 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_vector_type_t<float, 16U>", scope: !7, file: !201, line: 116, baseType: !782)
!782 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !783, file: !201, line: 97, baseType: !486)
!783 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "native_vector_type<float, 16U>", scope: !7, file: !201, line: 97, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !758, identifier: "_ZTSN3aie6detail18native_vector_typeIfLj16EEE")
!784 = !DISubprogram(name: "push", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE4pushEf", scope: !745, file: !193, line: 494, type: !785, scopeLine: 494, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!785 = !DISubroutineType(types: !786)
!786 = !{!787, !770, !788}
!787 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !745, size: 32)
!788 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !745, file: !193, line: 358, baseType: !80, flags: DIFlagPublic)
!789 = !DISubprogram(name: "set", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE3setEfj", scope: !745, file: !193, line: 652, type: !790, scopeLine: 652, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!790 = !DISubroutineType(types: !791)
!791 = !{null, !770, !788, !15}
!792 = !DISubprogram(name: "get", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE3getEj", scope: !745, file: !193, line: 703, type: !793, scopeLine: 703, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!793 = !DISubroutineType(types: !794)
!794 = !{!788, !795, !15}
!795 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !796, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!796 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !745)
!797 = !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv", scope: !745, file: !193, line: 1154, type: !798, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!798 = !DISubroutineType(types: !799)
!799 = !{!780, !795}
!800 = !DISubprogram(name: "operator v16float", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EEcv8v16floatEv", scope: !745, file: !193, line: 1164, type: !798, scopeLine: 1164, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!801 = !DISubprogram(name: "vector", scope: !742, file: !189, line: 87, type: !802, scopeLine: 87, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!802 = !DISubroutineType(types: !803)
!803 = !{null, !804, !805}
!804 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !742, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!805 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !806, size: 32)
!806 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !807)
!807 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !742, file: !189, line: 80, baseType: !745)
!808 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie6vectorIfLj16EE9type_bitsEv", scope: !742, file: !189, line: 102, type: !214, scopeLine: 102, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!809 = !DISubprogram(name: "size", linkageName: "_ZN3aie6vectorIfLj16EE4sizeEv", scope: !742, file: !189, line: 107, type: !214, scopeLine: 107, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!810 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6vectorIfLj16EE4bitsEv", scope: !742, file: !189, line: 112, type: !214, scopeLine: 112, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!811 = !DISubprogram(name: "bytes", linkageName: "_ZN3aie6vectorIfLj16EE5bytesEv", scope: !742, file: !189, line: 117, type: !214, scopeLine: 117, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!812 = !DISubprogram(name: "is_signed", linkageName: "_ZN3aie6vectorIfLj16EE9is_signedEv", scope: !742, file: !189, line: 122, type: !219, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!813 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6vectorIfLj16EE10is_complexEv", scope: !742, file: !189, line: 127, type: !219, scopeLine: 127, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!814 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6vectorIfLj16EE7is_realEv", scope: !742, file: !189, line: 132, type: !219, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!815 = !DISubprogram(name: "is_integral", linkageName: "_ZN3aie6vectorIfLj16EE11is_integralEv", scope: !742, file: !189, line: 137, type: !219, scopeLine: 137, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!816 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6vectorIfLj16EE17is_floating_pointEv", scope: !742, file: !189, line: 142, type: !219, scopeLine: 142, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!817 = !DISubprogram(name: "vector", scope: !742, file: !189, line: 148, type: !818, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!818 = !DISubroutineType(types: !819)
!819 = !{null, !804}
!820 = !DISubprogram(name: "vector", scope: !742, file: !189, line: 159, type: !821, scopeLine: 159, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!821 = !DISubroutineType(types: !822)
!822 = !{null, !804, !823}
!823 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !742, file: !189, line: 97, baseType: !774, flags: DIFlagPublic)
!824 = !DISubprogram(name: "vector", scope: !742, file: !189, line: 173, type: !825, scopeLine: 173, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!825 = !DISubroutineType(types: !826)
!826 = !{null, !804, !827}
!827 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !828, size: 32)
!828 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !829)
!829 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_type", scope: !742, file: !189, line: 91, baseType: !780, flags: DIFlagPublic)
!830 = !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6vectorIfLj16EE9to_nativeEv", scope: !742, file: !189, line: 196, type: !831, scopeLine: 196, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!831 = !DISubroutineType(types: !832)
!832 = !{!829, !833}
!833 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !834, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!834 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !742)
!835 = !DISubprogram(name: "operator v16float", linkageName: "_ZNK3aie6vectorIfLj16EEcv8v16floatEv", scope: !742, file: !189, line: 205, type: !831, scopeLine: 205, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!836 = !DISubprogram(name: "push", linkageName: "_ZN3aie6vectorIfLj16EE4pushEf", scope: !742, file: !189, line: 233, type: !837, scopeLine: 233, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!837 = !DISubroutineType(types: !838)
!838 = !{!839, !804, !840}
!839 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !742, size: 32)
!840 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !742, file: !189, line: 94, baseType: !788, flags: DIFlagPublic)
!841 = !DISubprogram(name: "set", linkageName: "_ZN3aie6vectorIfLj16EE3setEfj", scope: !742, file: !189, line: 271, type: !842, scopeLine: 271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!842 = !DISubroutineType(types: !843)
!843 = !{null, !804, !840, !15}
!844 = !DISubprogram(name: "get", linkageName: "_ZNK3aie6vectorIfLj16EE3getEj", scope: !742, file: !189, line: 282, type: !845, scopeLine: 282, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!845 = !DISubroutineType(types: !846)
!846 = !{!840, !833, !15}
!847 = !DISubprogram(name: "operator[]", linkageName: "_ZNK3aie6vectorIfLj16EEixEj", scope: !742, file: !189, line: 292, type: !848, scopeLine: 292, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!848 = !DISubroutineType(types: !849)
!849 = !{!850, !833, !15}
!850 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_elem_const_ref<float, 16U>", scope: !8, file: !309, line: 25, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3aie21vector_elem_const_refIfLj16EEE")
!851 = !DISubprogram(name: "operator[]", linkageName: "_ZN3aie6vectorIfLj16EEixEj", scope: !742, file: !189, line: 303, type: !852, scopeLine: 303, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!852 = !DISubroutineType(types: !853)
!853 = !{!854, !804, !15}
!854 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_elem_ref<float, 16U>", scope: !8, file: !309, line: 133, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !855, templateParams: !886, identifier: "_ZTSN3aie15vector_elem_refIfLj16EEE")
!855 = !{!856, !859, !860, !866, !867, !874, !878, !883}
!856 = !DIDerivedType(tag: DW_TAG_member, name: "parent", scope: !854, file: !309, line: 237, baseType: !857, size: 32, flags: DIFlagPublic)
!857 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !858, size: 32)
!858 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !854, file: !309, line: 136, baseType: !742, flags: DIFlagPublic)
!859 = !DIDerivedType(tag: DW_TAG_member, name: "offset", scope: !854, file: !309, line: 238, baseType: !15, size: 32, offset: 32, flags: DIFlagPublic)
!860 = !DISubprogram(name: "get", linkageName: "_ZNK3aie15vector_elem_refIfLj16EE3getEv", scope: !854, file: !309, line: 143, type: !861, scopeLine: 143, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!861 = !DISubroutineType(types: !862)
!862 = !{!863, !864}
!863 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !854, file: !309, line: 138, baseType: !80, flags: DIFlagPublic)
!864 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !865, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!865 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !854)
!866 = !DISubprogram(name: "operator float", linkageName: "_ZNK3aie15vector_elem_refIfLj16EEcvfEv", scope: !854, file: !309, line: 151, type: !861, scopeLine: 151, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!867 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj16EEaSERKf", scope: !854, file: !309, line: 159, type: !868, scopeLine: 159, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!868 = !DISubroutineType(types: !869)
!869 = !{!870, !871, !872}
!870 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !854, size: 32)
!871 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !854, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!872 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !873, size: 32)
!873 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !863)
!874 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj16EEaSERKS1_", scope: !854, file: !309, line: 168, type: !875, scopeLine: 168, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!875 = !DISubroutineType(types: !876)
!876 = !{!870, !871, !877}
!877 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !865, size: 32)
!878 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj16EEaSERKNS_21vector_elem_const_refIfLj16EEE", scope: !854, file: !309, line: 177, type: !879, scopeLine: 177, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!879 = !DISubroutineType(types: !880)
!880 = !{!870, !871, !881}
!881 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !882, size: 32)
!882 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !850)
!883 = !DISubprogram(name: "vector_elem_ref", scope: !854, file: !309, line: 241, type: !884, scopeLine: 241, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!884 = !DISubroutineType(types: !885)
!885 = !{null, !871, !857, !15}
!886 = !{!209, !887}
!887 = !DITemplateValueParameter(name: "N", type: !15, value: i32 16)
!888 = !DISubprogram(name: "elem_const_ref", linkageName: "_ZNK3aie6vectorIfLj16EE14elem_const_refEj", scope: !742, file: !189, line: 314, type: !848, scopeLine: 314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!889 = !DISubprogram(name: "elem_ref", linkageName: "_ZNK3aie6vectorIfLj16EE8elem_refEj", scope: !742, file: !189, line: 325, type: !848, scopeLine: 325, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!890 = !DISubprogram(name: "elem_ref", linkageName: "_ZN3aie6vectorIfLj16EE8elem_refEj", scope: !742, file: !189, line: 336, type: !852, scopeLine: 336, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!891 = !DIBasicType(name: "v128uint4", size: 512, encoding: DW_ATE_unsigned)
!892 = !DIBasicType(name: "v64uint8", size: 512, encoding: DW_ATE_unsigned)
!893 = !DIBasicType(name: "v64int8", size: 512, encoding: DW_ATE_unsigned)
!894 = !DIBasicType(name: "v32uint16", size: 512, encoding: DW_ATE_unsigned)
!895 = !DIBasicType(name: "v32int16", size: 512, encoding: DW_ATE_unsigned)
!896 = !DIBasicType(name: "v16cint16", size: 512, encoding: DW_ATE_unsigned)
!897 = !DIBasicType(name: "v16uint32", size: 512, encoding: DW_ATE_unsigned)
!898 = !DIBasicType(name: "v16int32", size: 512, encoding: DW_ATE_unsigned)
!899 = !DIBasicType(name: "v8cint32", size: 512, encoding: DW_ATE_unsigned)
!900 = !DIBasicType(name: "v8acc64", size: 512, encoding: DW_ATE_unsigned)
!901 = !DIBasicType(name: "v4cacc64", size: 512, encoding: DW_ATE_unsigned)
!902 = !DIBasicType(name: "v8caccfloat", size: 512, encoding: DW_ATE_unsigned)
!903 = !DIBasicType(name: "v8cfloat", size: 512, encoding: DW_ATE_unsigned)
!904 = !DIBasicType(name: "v16cbfloat16", size: 512, encoding: DW_ATE_unsigned)
!905 = !DIBasicType(name: "v128int4", size: 512, encoding: DW_ATE_unsigned)
!906 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cascade_stream_helper<accfloat, 8U>", scope: !908, file: !907, line: 151, size: 8, flags: DIFlagTypePassByValue, elements: !909, templateParams: !932, identifier: "_ZTSN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EEE")
!907 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/adf/stream.hpp", directory: "")
!908 = !DINamespace(name: "adf", scope: !7)
!909 = !{!910, !911, !912, !913, !914, !915, !921, !924, !929}
!910 = !DIDerivedType(tag: DW_TAG_member, name: "cascade_width", scope: !906, file: !907, line: 179, baseType: !101, flags: DIFlagStaticMember, extraData: i32 512)
!911 = !DIDerivedType(tag: DW_TAG_member, name: "num_ops", scope: !906, file: !907, line: 180, baseType: !101, flags: DIFlagStaticMember, extraData: i32 1)
!912 = !DIDerivedType(tag: DW_TAG_member, name: "elems_per_op", scope: !906, file: !907, line: 181, baseType: !101, flags: DIFlagStaticMember, extraData: i32 8)
!913 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems_per_op", scope: !906, file: !907, line: 182, baseType: !101, flags: DIFlagStaticMember, extraData: i32 16)
!914 = !DISubprogram(name: "compute_native_elems_per_op", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE27compute_native_elems_per_opEv", scope: !906, file: !907, line: 169, type: !214, scopeLine: 169, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!915 = !DISubprogram(name: "writeincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP13output_streamIS3_ENS_5accumIS3_Lj8EEE", scope: !906, file: !907, line: 186, type: !916, scopeLine: 186, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!916 = !DISubroutineType(types: !917)
!917 = !{null, !918, !920}
!918 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !919, size: 32)
!919 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "output_stream<accfloat>", file: !121, line: 150, size: 32, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS13output_streamI8accfloatE")
!920 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !906, file: !907, line: 154, baseType: !374)
!921 = !DISubprogram(name: "writeincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE", scope: !906, file: !907, line: 193, type: !922, scopeLine: 193, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!922 = !DISubroutineType(types: !923)
!923 = !{null, !144, !920}
!924 = !DISubprogram(name: "readincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP12input_streamIS3_E", scope: !906, file: !907, line: 208, type: !925, scopeLine: 208, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!925 = !DISubroutineType(types: !926)
!926 = !{!920, !927}
!927 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !928, size: 32)
!928 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "input_stream<accfloat>", file: !121, line: 144, size: 32, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS12input_streamI8accfloatE")
!929 = !DISubprogram(name: "readincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE", scope: !906, file: !907, line: 215, type: !930, scopeLine: 215, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!930 = !DISubroutineType(types: !931)
!931 = !{!920, !124}
!932 = !{!933, !353}
!933 = !DITemplateTypeParameter(name: "AccumTag", type: !459)
!934 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op_common<aie::accum<accfloat, 8U>, (aie::Operation)1>", scope: !8, file: !45, line: 358, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !935, templateParams: !955, identifier: "_ZTSN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEE")
!935 = !{!936, !938, !947, !948, !949, !950, !951}
!936 = !DIDerivedType(tag: DW_TAG_member, name: "operation", scope: !934, file: !45, line: 421, baseType: !937, flags: DIFlagStaticMember, extraData: i32 1)
!937 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !44)
!938 = !DIDerivedType(tag: DW_TAG_member, name: "parent_", scope: !934, file: !45, line: 430, baseType: !939, size: 256, flags: DIFlagPrivate)
!939 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !940)
!940 = !DIDerivedType(tag: DW_TAG_typedef, name: "parent1_type", scope: !934, file: !45, line: 360, baseType: !941)
!941 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_remove_t<aie::accum<accfloat, 8U> >", file: !942, line: 210, baseType: !943)
!942 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/aie_core.h", directory: "")
!943 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !944, file: !942, line: 187, baseType: !374)
!944 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_remove<aie::accum<accfloat, 8U> >", file: !942, line: 185, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !945, identifier: "_ZTS22aie_dm_resource_removeIN3aie5accumI8accfloatLj8EEEE")
!945 = !{!946}
!946 = !DITemplateTypeParameter(name: "T", type: !374)
!947 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE9type_bitsEv", scope: !934, file: !45, line: 364, type: !214, scopeLine: 364, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!948 = !DISubprogram(name: "size", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE4sizeEv", scope: !934, file: !45, line: 372, type: !214, scopeLine: 372, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!949 = !DISubprogram(name: "bits", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE4bitsEv", scope: !934, file: !45, line: 380, type: !214, scopeLine: 380, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!950 = !DISubprogram(name: "is_operation_none", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE17is_operation_noneEv", scope: !934, file: !45, line: 407, type: !219, scopeLine: 407, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!951 = !DISubprogram(name: "unary_op_common", scope: !934, file: !45, line: 424, type: !952, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!952 = !DISubroutineType(types: !953)
!953 = !{null, !954, !939}
!954 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !934, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!955 = !{!956, !957}
!956 = !DITemplateTypeParameter(name: "Parent", type: !374)
!957 = !DITemplateValueParameter(name: "Op", type: !44, value: i32 1)
!958 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op_common<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 358, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !959, templateParams: !977, identifier: "_ZTSN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE")
!959 = !{!960, !961, !969, !970, !971, !972, !973}
!960 = !DIDerivedType(tag: DW_TAG_member, name: "operation", scope: !958, file: !45, line: 421, baseType: !937, flags: DIFlagStaticMember, extraData: i32 0)
!961 = !DIDerivedType(tag: DW_TAG_member, name: "parent_", scope: !958, file: !45, line: 430, baseType: !962, size: 64, flags: DIFlagPrivate)
!962 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !963)
!963 = !DIDerivedType(tag: DW_TAG_typedef, name: "parent1_type", scope: !958, file: !45, line: 360, baseType: !964)
!964 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_remove_t<aie::vector_elem_ref<float, 8U> >", file: !942, line: 210, baseType: !965)
!965 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !966, file: !942, line: 187, baseType: !322)
!966 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_remove<aie::vector_elem_ref<float, 8U> >", file: !942, line: 185, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !967, identifier: "_ZTS22aie_dm_resource_removeIN3aie15vector_elem_refIfLj8EEEE")
!967 = !{!968}
!968 = !DITemplateTypeParameter(name: "T", type: !322)
!969 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE9type_bitsEv", scope: !958, file: !45, line: 364, type: !214, scopeLine: 364, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!970 = !DISubprogram(name: "size", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE4sizeEv", scope: !958, file: !45, line: 372, type: !214, scopeLine: 372, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!971 = !DISubprogram(name: "bits", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE4bitsEv", scope: !958, file: !45, line: 380, type: !214, scopeLine: 380, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!972 = !DISubprogram(name: "is_operation_none", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE17is_operation_noneEv", scope: !958, file: !45, line: 407, type: !219, scopeLine: 407, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!973 = !DISubprogram(name: "unary_op_common", scope: !958, file: !45, line: 424, type: !974, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!974 = !DISubroutineType(types: !975)
!975 = !{null, !976, !962}
!976 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !958, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!977 = !{!978, !979}
!978 = !DITemplateTypeParameter(name: "Parent", type: !322)
!979 = !DITemplateValueParameter(name: "Op", type: !44, value: i32 0)
!980 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op_common<aie::vector<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 358, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !981, templateParams: !999, identifier: "_ZTSN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEE")
!981 = !{!982, !983, !991, !992, !993, !994, !995}
!982 = !DIDerivedType(tag: DW_TAG_member, name: "operation", scope: !980, file: !45, line: 421, baseType: !937, flags: DIFlagStaticMember, extraData: i32 0)
!983 = !DIDerivedType(tag: DW_TAG_member, name: "parent_", scope: !980, file: !45, line: 430, baseType: !984, size: 256, flags: DIFlagPrivate)
!984 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !985)
!985 = !DIDerivedType(tag: DW_TAG_typedef, name: "parent1_type", scope: !980, file: !45, line: 360, baseType: !986)
!986 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_remove_t<aie::vector<float, 8U> >", file: !942, line: 210, baseType: !987)
!987 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !988, file: !942, line: 187, baseType: !188)
!988 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_remove<aie::vector<float, 8U> >", file: !942, line: 185, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !989, identifier: "_ZTS22aie_dm_resource_removeIN3aie6vectorIfLj8EEEE")
!989 = !{!990}
!990 = !DITemplateTypeParameter(name: "T", type: !188)
!991 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE9type_bitsEv", scope: !980, file: !45, line: 364, type: !214, scopeLine: 364, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!992 = !DISubprogram(name: "size", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE4sizeEv", scope: !980, file: !45, line: 372, type: !214, scopeLine: 372, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!993 = !DISubprogram(name: "bits", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE4bitsEv", scope: !980, file: !45, line: 380, type: !214, scopeLine: 380, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!994 = !DISubprogram(name: "is_operation_none", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE17is_operation_noneEv", scope: !980, file: !45, line: 407, type: !219, scopeLine: 407, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!995 = !DISubprogram(name: "unary_op_common", scope: !980, file: !45, line: 424, type: !996, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!996 = !DISubroutineType(types: !997)
!997 = !{null, !998, !984}
!998 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !980, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!999 = !{!1000, !979}
!1000 = !DITemplateTypeParameter(name: "Parent", type: !188)
!1001 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op<aie::vector<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 454, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1002, templateParams: !999, identifier: "_ZTSN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEE")
!1002 = !{!1003, !1004}
!1003 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1001, baseType: !980, extraData: i32 0)
!1004 = !DISubprogram(name: "operator()", linkageName: "_ZNK3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEclEv", scope: !1001, file: !45, line: 454, type: !1005, scopeLine: 454, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1005 = !DISubroutineType(types: !1006)
!1006 = !{!1007, !1012}
!1007 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_type", scope: !1001, file: !45, line: 454, baseType: !1008)
!1008 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_result_type_t<parent1_type, Operation::None>", scope: !8, file: !45, line: 352, baseType: !1009)
!1009 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1010, file: !45, line: 312, baseType: !188)
!1010 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_result_helper<aie::vector<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 310, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !1011, identifier: "_ZTSN3aie16op_result_helperINS_6vectorIfLj8EEELNS_9OperationE0EEE")
!1011 = !{!990, !979}
!1012 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1013, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1013 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1001)
!1014 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 454, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1015, templateParams: !977, identifier: "_ZTSN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE")
!1015 = !{!1016, !1017}
!1016 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1014, baseType: !958, extraData: i32 0)
!1017 = !DISubprogram(name: "operator()", linkageName: "_ZNK3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEclEv", scope: !1014, file: !45, line: 454, type: !1018, scopeLine: 454, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1018 = !DISubroutineType(types: !1019)
!1019 = !{!1020, !1025}
!1020 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_type", scope: !1014, file: !45, line: 454, baseType: !1021)
!1021 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_result_type_t<parent1_type, Operation::None>", scope: !8, file: !45, line: 352, baseType: !1022)
!1022 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1023, file: !45, line: 312, baseType: !322)
!1023 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_result_helper<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 310, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !1024, identifier: "_ZTSN3aie16op_result_helperINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE")
!1024 = !{!968, !979}
!1025 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1026, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1026 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1014)
!1027 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>", scope: !8, file: !45, line: 459, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1028, templateParams: !955, identifier: "_ZTSN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEE")
!1028 = !{!1029, !1030}
!1029 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1027, baseType: !934, extraData: i32 0)
!1030 = !DISubprogram(name: "operator()", linkageName: "_ZNK3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEclEv", scope: !1027, file: !45, line: 459, type: !1031, scopeLine: 459, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1031 = !DISubroutineType(types: !1032)
!1032 = !{!1033, !1038}
!1033 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_type", scope: !1027, file: !45, line: 459, baseType: !1034)
!1034 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_result_type_t<parent1_type, Operation::Acc_Add>", scope: !8, file: !45, line: 352, baseType: !1035)
!1035 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1036, file: !45, line: 306, baseType: !374)
!1036 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_result_helper<aie::accum<accfloat, 8U>, (aie::Operation)1>", scope: !8, file: !45, line: 304, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !1037, identifier: "_ZTSN3aie16op_result_helperINS_5accumI8accfloatLj8EEELNS_9OperationE1EEE")
!1037 = !{!946, !957}
!1038 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1039, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1039 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1027)
!1040 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "matrix_vector_mul<float, float, 128U, 768U, 0U, 0U, 0U, 1U, 12U, 1U, 0U, 0U, 1U, 9U, true, true>", scope: !87, file: !86, line: 233, size: 32, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1041, templateParams: !1074, identifier: "_ZTSN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEE")
!1041 = !{!1042, !1043, !1044, !1048, !1051, !1065, !1068, !1071}
!1042 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1040, baseType: !85, flags: DIFlagPublic, extraData: i32 0)
!1043 = !DIDerivedType(tag: DW_TAG_member, name: "matrixASize", scope: !1040, file: !86, line: 266, baseType: !101, flags: DIFlagPublic | DIFlagStaticMember, extraData: i32 8192)
!1044 = !DISubprogram(name: "matrix_vector_mul", scope: !1040, file: !86, line: 268, type: !1045, scopeLine: 268, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1045 = !DISubroutineType(types: !1046)
!1046 = !{null, !1047}
!1047 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1040, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1048 = !DISubprogram(name: "registerKernelClass", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE19registerKernelClassEv", scope: !1040, file: !86, line: 270, type: !1049, scopeLine: 270, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!1049 = !DISubroutineType(types: !1050)
!1050 = !{null}
!1051 = !DISubprogram(name: "matVecMulRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE12matVecMulRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEERNSA_IfNSB_3outESM_EE", scope: !1040, file: !86, line: 284, type: !1052, scopeLine: 284, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1052 = !DISubroutineType(types: !1053)
!1053 = !{null, !1047, !151, !1054, !1061}
!1054 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1055)
!1055 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1056, size: 32)
!1056 = !DIDerivedType(tag: DW_TAG_typedef, name: "input_buffer<float>", scope: !1058, file: !1057, line: 104, baseType: !1059)
!1057 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/io_buffer/io_buffer_types.h", directory: "")
!1058 = !DINamespace(name: "adf", scope: null)
!1059 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "io_buffer<float, adf::direction::in, adf::io_buffer_config<adf::extents<4294967295U>, adf::locking::sync, adf::addressing::linear, adf::margin<0U> > >", scope: !1058, file: !1060, line: 33, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEEE")
!1060 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/io_buffer/io_buffer_main.h", directory: "")
!1061 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1062)
!1062 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1063, size: 32)
!1063 = !DIDerivedType(tag: DW_TAG_typedef, name: "output_buffer<TT_OUT>", scope: !1058, file: !1057, line: 144, baseType: !1064)
!1064 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "io_buffer<float, adf::direction::out, adf::io_buffer_config<adf::extents<4294967295U>, adf::locking::sync, adf::addressing::linear, adf::margin<0U> > >", scope: !1058, file: !1057, line: 92, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEEE")
!1065 = !DISubprogram(name: "matVecMulFirstRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE", scope: !1040, file: !86, line: 288, type: !1066, scopeLine: 288, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1066 = !DISubroutineType(types: !1067)
!1067 = !{null, !1047, !151, !1054, !144}
!1068 = !DISubprogram(name: "matVecMulMiddleRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE", scope: !1040, file: !86, line: 292, type: !1069, scopeLine: 292, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1069 = !DISubroutineType(types: !1070)
!1070 = !{null, !1047, !151, !1054, !124, !144}
!1071 = !DISubprogram(name: "matVecMulLastRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE", scope: !1040, file: !86, line: 297, type: !1072, scopeLine: 297, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1072 = !DISubroutineType(types: !1073)
!1073 = !{null, !1047, !151, !1054, !124, !1061}
!1074 = !{!161, !162, !163, !164, !165, !166, !167, !168, !169, !170, !1075, !1076, !173, !174, !175, !177}
!1075 = !DITemplateValueParameter(name: "TP_API", type: !15, value: i32 0)
!1076 = !DITemplateValueParameter(name: "TP_DUAL_IP", type: !15, value: i32 0)
!1077 = !{!0, !1078}
!1078 = !DIGlobalVariableExpression(var: !1079, expr: !DIExpression(DW_OP_constu, 1, DW_OP_stack_value))
!1079 = distinct !DIGlobalVariable(name: "is_signed_v", scope: !7, file: !1080, line: 117, type: !198, isLocal: true, isDefinition: true, templateParams: !1081)
!1080 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/concepts.hpp", directory: "")
!1081 = !{!209}
!1082 = !{!1083, !1089, !1091, !1095, !1099, !1102, !1104, !1107, !1110, !1111, !1113, !1114, !1116, !1118, !1120, !1122, !1124, !1126, !1128, !1130, !1132, !1134, !1136, !1138, !1140, !1142, !1144, !1146, !1148, !1150, !1152, !1154, !1156, !1166, !1170, !1180, !1184, !1186, !1188, !1192, !1196, !1200, !1202, !1206, !1211, !1215, !1219, !1223, !1225, !1227, !1229, !1231, !1233, !1237, !1239, !1244, !1249, !1255, !1260, !1264, !1268, !1273, !1277, !1281, !1285, !1287, !1292, !1296, !1298, !1305, !1311, !1313, !1315, !1319, !1321, !1323, !1325, !1327, !1329, !1334, !1339, !1343, !1345, !1347, !1349, !1351, !1353, !1355, !1357, !1359, !1364, !1365, !1370, !1372, !1376, !1378, !1382, !1386, !1390, !1398, !1400, !1404, !1408, !1412, !1414, !1418, !1422, !1426, !1428, !1430, !1432, !1437, !1442, !1446, !1450, !1454, !1456, !1458, !1460, !1464, !1468, !1472, !1474, !1476, !1480, !1482, !1486, !1490, !1492, !1496, !1498, !1500, !1503, !1504}
!1083 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1086, file: !1088, line: 57)
!1084 = !DINamespace(name: "__2", scope: !1085, exportSymbols: true)
!1085 = !DINamespace(name: "std", scope: null)
!1086 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", file: !1087, line: 35, baseType: !9)
!1087 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/stddef.h", directory: "")
!1088 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstddef", directory: "")
!1089 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1090, file: !1088, line: 58)
!1090 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !1087, line: 46, baseType: !15)
!1091 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1092, file: !1088, line: 63)
!1092 = !DIDerivedType(tag: DW_TAG_typedef, name: "max_align_t", file: !1093, line: 24, baseType: !1094)
!1093 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/__stddef_max_align_t.h", directory: "")
!1094 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1093, line: 19, size: 128, flags: DIFlagFwdDecl, identifier: "_ZTS11max_align_t")
!1095 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1096, file: !1098, line: 161)
!1096 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !577, line: 24, baseType: !1097)
!1097 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!1098 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdint", directory: "")
!1099 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1100, file: !1098, line: 163)
!1100 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !577, line: 25, baseType: !1101)
!1101 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!1102 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1103, file: !1098, line: 164)
!1103 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !577, line: 26, baseType: !9)
!1104 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1105, file: !1098, line: 166)
!1105 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !577, line: 27, baseType: !1106)
!1106 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!1107 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1108, file: !1098, line: 170)
!1108 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !577, line: 29, baseType: !1109)
!1109 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!1110 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !576, file: !1098, line: 172)
!1111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1112, file: !1098, line: 173)
!1112 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !577, line: 31, baseType: !15)
!1113 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !596, file: !1098, line: 175)
!1114 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1115, file: !1098, line: 178)
!1115 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !577, line: 35, baseType: !1097)
!1116 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1117, file: !1098, line: 179)
!1117 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !577, line: 36, baseType: !1101)
!1118 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1119, file: !1098, line: 180)
!1119 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !577, line: 37, baseType: !9)
!1120 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1121, file: !1098, line: 182)
!1121 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !577, line: 38, baseType: !1106)
!1122 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1123, file: !1098, line: 185)
!1123 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !577, line: 40, baseType: !1109)
!1124 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1125, file: !1098, line: 186)
!1125 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !577, line: 41, baseType: !578)
!1126 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1127, file: !1098, line: 187)
!1127 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !577, line: 42, baseType: !15)
!1128 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1129, file: !1098, line: 189)
!1129 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !577, line: 43, baseType: !597)
!1130 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1131, file: !1098, line: 192)
!1131 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !577, line: 46, baseType: !9)
!1132 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1133, file: !1098, line: 193)
!1133 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !577, line: 47, baseType: !9)
!1134 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1135, file: !1098, line: 194)
!1135 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !577, line: 48, baseType: !9)
!1136 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1137, file: !1098, line: 196)
!1137 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !577, line: 49, baseType: !1106)
!1138 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1139, file: !1098, line: 199)
!1139 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !577, line: 51, baseType: !15)
!1140 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1141, file: !1098, line: 200)
!1141 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !577, line: 52, baseType: !15)
!1142 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1143, file: !1098, line: 201)
!1143 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !577, line: 53, baseType: !15)
!1144 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1145, file: !1098, line: 203)
!1145 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !577, line: 54, baseType: !597)
!1146 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1147, file: !1098, line: 206)
!1147 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !577, line: 57, baseType: !9)
!1148 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1149, file: !1098, line: 207)
!1149 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !577, line: 58, baseType: !15)
!1150 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1151, file: !1098, line: 209)
!1151 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !577, line: 61, baseType: !9)
!1152 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1153, file: !1098, line: 210)
!1153 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !577, line: 62, baseType: !15)
!1154 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1090, file: !1155, line: 76)
!1155 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstring", directory: "")
!1156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1157, file: !1155, line: 77)
!1157 = !DISubprogram(name: "memcpy", scope: !1158, file: !1158, line: 28, type: !1159, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1158 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/string.h", directory: "")
!1159 = !DISubroutineType(types: !1160)
!1160 = !{!1161, !1162, !1163, !1090}
!1161 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 32)
!1162 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1161)
!1163 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1164)
!1164 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1165, size: 32)
!1165 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1166 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1167, file: !1155, line: 78)
!1167 = !DISubprogram(name: "memmove", scope: !1158, file: !1158, line: 29, type: !1168, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1168 = !DISubroutineType(types: !1169)
!1169 = !{!1161, !1161, !1164, !1090}
!1170 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1171, file: !1155, line: 79)
!1171 = !DISubprogram(name: "strcpy", scope: !1158, file: !1158, line: 30, type: !1172, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1172 = !DISubroutineType(types: !1173)
!1173 = !{!1174, !1176, !1177}
!1174 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1175, size: 32)
!1175 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!1176 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1174)
!1177 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1178)
!1178 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1179, size: 32)
!1179 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1175)
!1180 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1181, file: !1155, line: 80)
!1181 = !DISubprogram(name: "strncpy", scope: !1158, file: !1158, line: 31, type: !1182, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1182 = !DISubroutineType(types: !1183)
!1183 = !{!1174, !1176, !1177, !1090}
!1184 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1185, file: !1155, line: 81)
!1185 = !DISubprogram(name: "strcat", scope: !1158, file: !1158, line: 34, type: !1172, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1186 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1187, file: !1155, line: 82)
!1187 = !DISubprogram(name: "strncat", scope: !1158, file: !1158, line: 35, type: !1182, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1188 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1189, file: !1155, line: 83)
!1189 = !DISubprogram(name: "memcmp", scope: !1158, file: !1158, line: 38, type: !1190, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1190 = !DISubroutineType(types: !1191)
!1191 = !{!9, !1164, !1164, !1090}
!1192 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1193, file: !1155, line: 84)
!1193 = !DISubprogram(name: "strcmp", scope: !1158, file: !1158, line: 39, type: !1194, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1194 = !DISubroutineType(types: !1195)
!1195 = !{!9, !1178, !1178}
!1196 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1197, file: !1155, line: 85)
!1197 = !DISubprogram(name: "strncmp", scope: !1158, file: !1158, line: 41, type: !1198, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1198 = !DISubroutineType(types: !1199)
!1199 = !{!9, !1178, !1178, !1090}
!1200 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1201, file: !1155, line: 86)
!1201 = !DISubprogram(name: "strcoll", scope: !1158, file: !1158, line: 40, type: !1194, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1202 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1203, file: !1155, line: 87)
!1203 = !DISubprogram(name: "strxfrm", scope: !1158, file: !1158, line: 42, type: !1204, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1204 = !DISubroutineType(types: !1205)
!1205 = !{!1090, !1176, !1177, !1090}
!1206 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1207, file: !1155, line: 88)
!1207 = !DISubprogram(name: "memchr", linkageName: "_Z6memchrUa9enable_ifILb1EEPvij", scope: !1208, file: !1208, line: 107, type: !1209, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1208 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/string.h", directory: "")
!1209 = !DISubroutineType(types: !1210)
!1210 = !{!1161, !1161, !9, !1090}
!1211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1212, file: !1155, line: 89)
!1212 = !DISubprogram(name: "strchr", linkageName: "_Z6strchrUa9enable_ifILb1EEPci", scope: !1208, file: !1208, line: 86, type: !1213, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1213 = !DISubroutineType(types: !1214)
!1214 = !{!1174, !1174, !9}
!1215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1216, file: !1155, line: 90)
!1216 = !DISubprogram(name: "strcspn", scope: !1158, file: !1158, line: 47, type: !1217, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1217 = !DISubroutineType(types: !1218)
!1218 = !{!1090, !1178, !1178}
!1219 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1220, file: !1155, line: 91)
!1220 = !DISubprogram(name: "strpbrk", linkageName: "_Z7strpbrkUa9enable_ifILb1EEPcPKc", scope: !1208, file: !1208, line: 93, type: !1221, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1221 = !DISubroutineType(types: !1222)
!1222 = !{!1174, !1174, !1178}
!1223 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1224, file: !1155, line: 92)
!1224 = !DISubprogram(name: "strrchr", linkageName: "_Z7strrchrUa9enable_ifILb1EEPci", scope: !1208, file: !1208, line: 100, type: !1213, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1225 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1226, file: !1155, line: 93)
!1226 = !DISubprogram(name: "strspn", scope: !1158, file: !1158, line: 50, type: !1217, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1227 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1228, file: !1155, line: 94)
!1228 = !DISubprogram(name: "strstr", linkageName: "_Z6strstrUa9enable_ifILb1EEPcPKc", scope: !1208, file: !1208, line: 114, type: !1221, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1229 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1230, file: !1155, line: 96)
!1230 = !DISubprogram(name: "strtok", scope: !1158, file: !1158, line: 52, type: !1172, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1231 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1232, file: !1155, line: 98)
!1232 = !DISubprogram(name: "memset", scope: !1158, file: !1158, line: 55, type: !1209, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1233 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1234, file: !1155, line: 102)
!1234 = !DISubprogram(name: "strlen", scope: !1158, file: !1158, line: 57, type: !1235, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1235 = !DISubroutineType(types: !1236)
!1236 = !{!1090, !1178}
!1237 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1090, file: !1238, line: 107)
!1238 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdlib", directory: "")
!1239 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1240, file: !1238, line: 118)
!1240 = !DISubprogram(name: "atoi", scope: !1241, file: !1241, line: 38, type: !1242, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1241 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdlib.h", directory: "")
!1242 = !DISubroutineType(types: !1243)
!1243 = !{!9, !1178}
!1244 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1245, file: !1238, line: 119)
!1245 = !DISubprogram(name: "atol", scope: !1241, file: !1241, line: 43, type: !1246, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1246 = !DISubroutineType(types: !1247)
!1247 = !{!1248, !1178}
!1248 = !DIBasicType(name: "long", size: 32, encoding: DW_ATE_signed)
!1249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1250, file: !1238, line: 128)
!1250 = !DISubprogram(name: "strtol", scope: !1241, file: !1241, line: 30, type: !1251, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1251 = !DISubroutineType(types: !1252)
!1252 = !{!1248, !1177, !1253, !9}
!1253 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1254)
!1254 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1174, size: 32)
!1255 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1256, file: !1238, line: 134)
!1256 = !DISubprogram(name: "strtoul", scope: !1241, file: !1241, line: 34, type: !1257, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1257 = !DISubroutineType(types: !1258)
!1258 = !{!1259, !1177, !1253, !9}
!1259 = !DIBasicType(name: "unsigned long", size: 32, encoding: DW_ATE_unsigned)
!1260 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1261, file: !1238, line: 140)
!1261 = !DISubprogram(name: "rand", scope: !1241, file: !1241, line: 52, type: !1262, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1262 = !DISubroutineType(types: !1263)
!1263 = !{!9}
!1264 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1265, file: !1238, line: 141)
!1265 = !DISubprogram(name: "srand", scope: !1241, file: !1241, line: 53, type: !1266, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1266 = !DISubroutineType(types: !1267)
!1267 = !{null, !15}
!1268 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1269, file: !1238, line: 142)
!1269 = !DISubprogram(name: "calloc", scope: !1270, file: !1270, line: 33, type: !1271, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1270 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/malloc.h", directory: "")
!1271 = !DISubroutineType(types: !1272)
!1272 = !{!1161, !1090, !1090}
!1273 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1274, file: !1238, line: 143)
!1274 = !DISubprogram(name: "free", scope: !1270, file: !1270, line: 31, type: !1275, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1275 = !DISubroutineType(types: !1276)
!1276 = !{null, !1161}
!1277 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1278, file: !1238, line: 144)
!1278 = !DISubprogram(name: "malloc", scope: !1270, file: !1270, line: 29, type: !1279, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1279 = !DISubroutineType(types: !1280)
!1280 = !{!1161, !1090}
!1281 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1282, file: !1238, line: 145)
!1282 = !DISubprogram(name: "realloc", scope: !1270, file: !1270, line: 35, type: !1283, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1283 = !DISubroutineType(types: !1284)
!1284 = !{!1161, !1161, !1090}
!1285 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1286, file: !1238, line: 146)
!1286 = !DISubprogram(name: "abort", scope: !1241, file: !1241, line: 91, type: !1049, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1287 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1288, file: !1238, line: 147)
!1288 = !DISubprogram(name: "atexit", scope: !1241, file: !1241, line: 98, type: !1289, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1289 = !DISubroutineType(types: !1290)
!1290 = !{!9, !1291}
!1291 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1049, size: 32, dwarfAddressSpace: 61)
!1292 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1293, file: !1238, line: 148)
!1293 = !DISubprogram(name: "exit", scope: !1241, file: !1241, line: 83, type: !1294, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1294 = !DISubroutineType(types: !1295)
!1295 = !{null, !9}
!1296 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1297, file: !1238, line: 149)
!1297 = !DISubprogram(name: "_Exit", scope: !1241, file: !1241, line: 96, type: !1294, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1298 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1299, file: !1238, line: 157)
!1299 = !DISubprogram(name: "qsort", scope: !1241, file: !1241, line: 104, type: !1300, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1300 = !DISubroutineType(types: !1301)
!1301 = !{null, !1161, !1090, !1090, !1302}
!1302 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1303, size: 32, dwarfAddressSpace: 61)
!1303 = !DISubroutineType(types: !1304)
!1304 = !{!9, !1164, !1164}
!1305 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1306, file: !1310, line: 351)
!1306 = !DISubprogram(name: "acosf", scope: !1307, file: !1307, line: 93, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1307 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/math.h", directory: "")
!1308 = !DISubroutineType(types: !1309)
!1309 = !{!80, !80}
!1310 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cmath", directory: "")
!1311 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1312, file: !1310, line: 353)
!1312 = !DISubprogram(name: "asinf", scope: !1307, file: !1307, line: 95, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1313 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1314, file: !1310, line: 355)
!1314 = !DISubprogram(name: "atanf", scope: !1307, file: !1307, line: 101, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1315 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1316, file: !1310, line: 357)
!1316 = !DISubprogram(name: "atan2f", scope: !1307, file: !1307, line: 98, type: !1317, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1317 = !DISubroutineType(types: !1318)
!1318 = !{!80, !80, !80}
!1319 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1320, file: !1310, line: 359)
!1320 = !DISubprogram(name: "ceilf", scope: !1307, file: !1307, line: 68, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1321 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1322, file: !1310, line: 361)
!1322 = !DISubprogram(name: "cosf", scope: !1307, file: !1307, line: 74, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1323 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1324, file: !1310, line: 368)
!1324 = !DISubprogram(name: "expf", scope: !1307, file: !1307, line: 78, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1325 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1326, file: !1310, line: 371)
!1326 = !DISubprogram(name: "fabsf", scope: !1307, file: !1307, line: 31, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1327 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1328, file: !1310, line: 373)
!1328 = !DISubprogram(name: "floorf", scope: !1307, file: !1307, line: 70, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1329 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1330, file: !1310, line: 375)
!1330 = !DISubprogram(name: "fmod", scope: !1307, file: !1307, line: 92, type: !1331, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1331 = !DISubroutineType(types: !1332)
!1332 = !{!1333, !1333, !1333}
!1333 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!1334 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1335, file: !1310, line: 381)
!1335 = !DISubprogram(name: "frexpf", scope: !1307, file: !1307, line: 108, type: !1336, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1336 = !DISubroutineType(types: !1337)
!1337 = !{!80, !80, !1338}
!1338 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 32)
!1339 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1340, file: !1310, line: 383)
!1340 = !DISubprogram(name: "ldexpf", scope: !1307, file: !1307, line: 66, type: !1341, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1341 = !DISubroutineType(types: !1342)
!1342 = !{!80, !80, !9}
!1343 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1344, file: !1310, line: 386)
!1344 = !DISubprogram(name: "logf", scope: !1307, file: !1307, line: 80, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1345 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1346, file: !1310, line: 389)
!1346 = !DISubprogram(name: "log10f", scope: !1307, file: !1307, line: 82, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1347 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1348, file: !1310, line: 396)
!1348 = !DISubprogram(name: "powf", scope: !1307, file: !1307, line: 90, type: !1317, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1349 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1350, file: !1310, line: 399)
!1350 = !DISubprogram(name: "sinf", scope: !1307, file: !1307, line: 76, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1351 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1352, file: !1310, line: 406)
!1352 = !DISubprogram(name: "sqrtf", scope: !1307, file: !1307, line: 85, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1353 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1354, file: !1310, line: 427)
!1354 = !DISubprogram(name: "copysignf", scope: !1307, file: !1307, line: 36, type: !1317, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1355 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1356, file: !1310, line: 484)
!1356 = !DISubprogram(name: "roundf", scope: !1307, file: !1307, line: 72, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1357 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1358, file: !1310, line: 494)
!1358 = !DISubprogram(name: "truncf", scope: !1307, file: !1307, line: 104, type: !1308, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1359 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1360, file: !1363, line: 115)
!1360 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !1361, line: 31, baseType: !1362)
!1361 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdio.h", directory: "")
!1362 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "FILE", file: !1361, line: 30, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS4FILE")
!1363 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdio", directory: "")
!1364 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1090, file: !1363, line: 119)
!1365 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1366, file: !1363, line: 121)
!1366 = !DISubprogram(name: "fclose", scope: !1361, file: !1361, line: 78, type: !1367, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1367 = !DISubroutineType(types: !1368)
!1368 = !{!9, !1369}
!1369 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1360, size: 32)
!1370 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1371, file: !1363, line: 122)
!1371 = !DISubprogram(name: "fflush", scope: !1361, file: !1361, line: 79, type: !1367, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1372 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1373, file: !1363, line: 127)
!1373 = !DISubprogram(name: "fprintf", scope: !1361, file: !1361, line: 88, type: !1374, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1374 = !DISubroutineType(types: !1375)
!1375 = !{!9, !1369, !1178, null}
!1376 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1377, file: !1363, line: 128)
!1377 = !DISubprogram(name: "fscanf", scope: !1361, file: !1361, line: 93, type: !1374, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1378 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1379, file: !1363, line: 129)
!1379 = !DISubprogram(name: "snprintf", scope: !1361, file: !1361, line: 97, type: !1380, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1380 = !DISubroutineType(types: !1381)
!1381 = !{!9, !1174, !1090, !1178, null}
!1382 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1383, file: !1363, line: 130)
!1383 = !DISubprogram(name: "sprintf", scope: !1361, file: !1361, line: 96, type: !1384, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1384 = !DISubroutineType(types: !1385)
!1385 = !{!9, !1174, !1178, null}
!1386 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1387, file: !1363, line: 131)
!1387 = !DISubprogram(name: "sscanf", scope: !1361, file: !1361, line: 101, type: !1388, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1388 = !DISubroutineType(types: !1389)
!1389 = !{!9, !1178, !1178, null}
!1390 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1391, file: !1363, line: 132)
!1391 = !DISubprogram(name: "vfprintf", scope: !1361, file: !1361, line: 86, type: !1392, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1392 = !DISubroutineType(types: !1393)
!1393 = !{!9, !1369, !1178, !1394}
!1394 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1395, line: 22, baseType: !1396)
!1395 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/stdarg.h", directory: "")
!1396 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1397, baseType: !1174)
!1397 = !DIFile(filename: "i2_wrap_matrix_vector_mul.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir")
!1398 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1399, file: !1363, line: 133)
!1399 = !DISubprogram(name: "vfscanf", scope: !1361, file: !1361, line: 91, type: !1392, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1400 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1401, file: !1363, line: 134)
!1401 = !DISubprogram(name: "vsscanf", scope: !1361, file: !1361, line: 102, type: !1402, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1402 = !DISubroutineType(types: !1403)
!1403 = !{!9, !1178, !1178, !1394}
!1404 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1405, file: !1363, line: 135)
!1405 = !DISubprogram(name: "vsnprintf", scope: !1361, file: !1361, line: 99, type: !1406, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1406 = !DISubroutineType(types: !1407)
!1407 = !{!9, !1174, !1090, !1178, !1394}
!1408 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1409, file: !1363, line: 136)
!1409 = !DISubprogram(name: "vsprintf", scope: !1361, file: !1361, line: 98, type: !1410, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1410 = !DISubroutineType(types: !1411)
!1411 = !{!9, !1174, !1178, !1394}
!1412 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1413, file: !1363, line: 137)
!1413 = !DISubprogram(name: "fgetc", scope: !1361, file: !1361, line: 113, type: !1367, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1414 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1415, file: !1363, line: 138)
!1415 = !DISubprogram(name: "fgets", scope: !1361, file: !1361, line: 116, type: !1416, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1416 = !DISubroutineType(types: !1417)
!1417 = !{!1174, !1174, !9, !1369}
!1418 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1419, file: !1363, line: 139)
!1419 = !DISubprogram(name: "fputc", scope: !1361, file: !1361, line: 107, type: !1420, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1420 = !DISubroutineType(types: !1421)
!1421 = !{!9, !9, !1369}
!1422 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1423, file: !1363, line: 140)
!1423 = !DISubprogram(name: "fputs", scope: !1361, file: !1361, line: 110, type: !1424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1424 = !DISubroutineType(types: !1425)
!1425 = !{!9, !1178, !1369}
!1426 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1427, file: !1363, line: 141)
!1427 = !DISubprogram(name: "getc", scope: !1361, file: !1361, line: 187, type: !1367, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1428 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1429, file: !1363, line: 142)
!1429 = !DISubprogram(name: "putc", scope: !1361, file: !1361, line: 169, type: !1420, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1430 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1431, file: !1363, line: 143)
!1431 = !DISubprogram(name: "ungetc", scope: !1361, file: !1361, line: 119, type: !1420, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1432 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1433, file: !1363, line: 144)
!1433 = !DISubprogram(name: "fread", scope: !1361, file: !1361, line: 126, type: !1434, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1434 = !DISubroutineType(types: !1435)
!1435 = !{!1090, !1436, !1090, !1090, !1369}
!1436 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 32, dwarfAddressSpace: 12)
!1437 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1438, file: !1363, line: 145)
!1438 = !DISubprogram(name: "fwrite", scope: !1361, file: !1361, line: 124, type: !1439, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1439 = !DISubroutineType(types: !1440)
!1440 = !{!1090, !1441, !1090, !1090, !1369}
!1441 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1165, size: 32, dwarfAddressSpace: 12)
!1442 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1443, file: !1363, line: 149)
!1443 = !DISubprogram(name: "fseek", scope: !1361, file: !1361, line: 139, type: !1444, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1444 = !DISubroutineType(types: !1445)
!1445 = !{!9, !1369, !1248, !9}
!1446 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1447, file: !1363, line: 153)
!1447 = !DISubprogram(name: "ftell", scope: !1361, file: !1361, line: 141, type: !1448, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1448 = !DISubroutineType(types: !1449)
!1449 = !{!1248, !1369}
!1450 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1451, file: !1363, line: 154)
!1451 = !DISubprogram(name: "rewind", scope: !1361, file: !1361, line: 164, type: !1452, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1452 = !DISubroutineType(types: !1453)
!1453 = !{null, !1369}
!1454 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1455, file: !1363, line: 155)
!1455 = !DISubprogram(name: "clearerr", scope: !1361, file: !1361, line: 148, type: !1452, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1456 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1457, file: !1363, line: 156)
!1457 = !DISubprogram(name: "feof", scope: !1361, file: !1361, line: 146, type: !1367, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1458 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1459, file: !1363, line: 157)
!1459 = !DISubprogram(name: "ferror", scope: !1361, file: !1361, line: 147, type: !1367, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1460 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1461, file: !1363, line: 158)
!1461 = !DISubprogram(name: "perror", scope: !1361, file: !1361, line: 149, type: !1462, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1462 = !DISubroutineType(types: !1463)
!1463 = !{null, !1178}
!1464 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1465, file: !1363, line: 161)
!1465 = !DISubprogram(name: "fopen", scope: !1361, file: !1361, line: 77, type: !1466, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1466 = !DISubroutineType(types: !1467)
!1467 = !{!1369, !1178, !1178}
!1468 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1469, file: !1363, line: 162)
!1469 = !DISubprogram(name: "freopen", scope: !1361, file: !1361, line: 81, type: !1470, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1470 = !DISubroutineType(types: !1471)
!1471 = !{!1369, !1178, !1178, !1369}
!1472 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1473, file: !1363, line: 163)
!1473 = !DISubprogram(name: "remove", scope: !1361, file: !1361, line: 67, type: !1242, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1474 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1475, file: !1363, line: 164)
!1475 = !DISubprogram(name: "rename", scope: !1361, file: !1361, line: 68, type: !1194, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1476 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1477, file: !1363, line: 165)
!1477 = !DISubprogram(name: "tmpfile", scope: !1361, file: !1361, line: 69, type: !1478, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1478 = !DISubroutineType(types: !1479)
!1479 = !{!1369}
!1480 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1481, file: !1363, line: 172)
!1481 = !DISubprogram(name: "getchar", scope: !1361, file: !1361, line: 192, type: !1262, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1482 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1483, file: !1363, line: 176)
!1483 = !DISubprogram(name: "scanf", scope: !1361, file: !1361, line: 94, type: !1484, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1484 = !DISubroutineType(types: !1485)
!1485 = !{!9, !1178, null}
!1486 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1487, file: !1363, line: 177)
!1487 = !DISubprogram(name: "vscanf", scope: !1361, file: !1361, line: 159, type: !1488, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1488 = !DISubroutineType(types: !1489)
!1489 = !{!9, !1178, !1394}
!1490 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1491, file: !1363, line: 181)
!1491 = !DISubprogram(name: "printf", scope: !1361, file: !1361, line: 89, type: !1484, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1492 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1493, file: !1363, line: 182)
!1493 = !DISubprogram(name: "putchar", scope: !1361, file: !1361, line: 174, type: !1494, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1494 = !DISubroutineType(types: !1495)
!1495 = !{!9, !9}
!1496 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1497, file: !1363, line: 183)
!1497 = !DISubprogram(name: "puts", scope: !1361, file: !1361, line: 179, type: !1242, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1498 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1084, entity: !1499, file: !1363, line: 184)
!1499 = !DISubprogram(name: "vprintf", scope: !1361, file: !1361, line: 154, type: !1488, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1500 = !DIImportedEntity(tag: DW_TAG_imported_declaration, name: "Utils", scope: !8, entity: !1501, file: !1502, line: 89)
!1501 = !DINamespace(name: "utils", scope: !7)
!1502 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/adf/../aie.hpp", directory: "")
!1503 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !5, file: !1502, line: 6158)
!1504 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !2, entity: !1058, file: !1505, line: 32)
!1505 = !DIFile(filename: "dsp_lib/L1/include/aie/fir_utils.hpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!1506 = !{!"SCD"}
!1507 = !{!"crF2FMask"}
!1508 = !{!"crFPMask"}
!1509 = !{!"MCD"}
!1510 = !{i32 0, i8 undef}
!1511 = !{i32 2, i8 undef}
!1512 = !{i32 3, i8 undef}
!1513 = !{i32 4, i8 undef}
!1514 = !{i32 5, i8 undef}
!1515 = !{i32 6, i8 undef}
!1516 = !{i32 7, i8 undef}
!1517 = !{i32 8, i8 undef}
!1518 = !{i32 9, i8 undef}
!1519 = !{i32 10, i8 undef}
!1520 = !{i32 11, i8 undef}
!1521 = !{i32 12, i8 undef}
!1522 = !{i32 13, i8 undef}
!1523 = !{i32 14, i8 undef}
!1524 = !{i32 7, !"Dwarf Version", i32 4}
!1525 = !{i32 2, !"Debug Info Version", i32 3}
!1526 = !{i32 1, !"wchar_size", i32 4}
!1527 = !{i32 7, !"frame-pointer", i32 2}
!1528 = !{!"clang version 16.0.3 (/u/sgasip/ipd/repositories/llvm_ipd 6a0b186d7c0e25173296a8e19f630e71bd7e8ed9)"}
!1529 = distinct !DISubprogram(name: "matVecMulMiddleRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE", scope: !1040, file: !83, line: 655, type: !1069, scopeLine: 658, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1068, retainedNodes: !1530)
!1530 = !{!1531, !1533, !1534, !1535, !1536, !1537, !1538}
!1531 = !DILocalVariable(name: "this", arg: 1, scope: !1529, type: !1532, flags: DIFlagArtificial | DIFlagObjectPointer)
!1532 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1040, size: 32)
!1533 = !DILocalVariable(name: "inMatrixA", arg: 2, scope: !1529, file: !86, line: 292, type: !151)
!1534 = !DILocalVariable(name: "inWindowB", arg: 3, scope: !1529, file: !86, line: 293, type: !1054)
!1535 = !DILocalVariable(name: "inCascade", arg: 4, scope: !1529, file: !86, line: 294, type: !124)
!1536 = !DILocalVariable(name: "outCascade", arg: 5, scope: !1529, file: !86, line: 295, type: !144)
!1537 = !DILocalVariable(name: "inInterface", scope: !1529, file: !83, line: 659, type: !112)
!1538 = !DILocalVariable(name: "outInterface", scope: !1529, file: !83, line: 660, type: !129)
!1539 = !{!1540}
!1540 = distinct !{!1540, !1541, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE: unknown scope"}
!1541 = distinct !{!1541, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE"}
!1542 = !{!1543, !1543, i64 0, i64 4}
!1543 = !{!1544, i64 4, !"any pointer"}
!1544 = !{!1545, i64 1, !"omnipotent char"}
!1545 = !{!"Simple C++ TBAA"}
!1546 = !{!1547, !1548, !1549, !1540}
!1547 = distinct !{!1547, !1541, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE: inWindowB"}
!1548 = distinct !{!1548, !1541, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE: inInterface"}
!1549 = distinct !{!1549, !1541, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE: outInterface"}
!1550 = !DILocation(line: 0, scope: !1529)
!1551 = !DILocation(line: 292, column: 47, scope: !1529)
!1552 = !{!1547}
!1553 = !DILocation(line: 293, column: 65, scope: !1529)
!1554 = !DILocation(line: 294, column: 78, scope: !1529)
!1555 = !DILocation(line: 295, column: 79, scope: !1529)
!1556 = !DILocation(line: 659, column: 5, scope: !1529)
!1557 = !DILocation(line: 659, column: 37, scope: !1529)
!1558 = !{!1548}
!1559 = !DILocation(line: 660, column: 5, scope: !1529)
!1560 = !DILocation(line: 660, column: 38, scope: !1529)
!1561 = !{!1549}
!1562 = !DILocation(line: 661, column: 29, scope: !1529)
!1563 = !DILocation(line: 661, column: 39, scope: !1529)
!1564 = !DILocation(line: 661, column: 17, scope: !1529)
!1565 = !DILocation(line: 661, column: 27, scope: !1529)
!1566 = !{!1567, !1543, i64 4, i64 4}
!1567 = !{!1544, i64 20, !"_ZTSN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEE", !1543, i64 0, i64 4, !1543, i64 4, i64 4, !1543, i64 8, i64 4, !1543, i64 12, i64 4, !1543, i64 16, i64 4}
!1568 = !DILocation(line: 662, column: 29, scope: !1529)
!1569 = !DILocation(line: 662, column: 17, scope: !1529)
!1570 = !DILocation(line: 662, column: 27, scope: !1529)
!1571 = !{!1567, !1543, i64 16, i64 4}
!1572 = !DILocation(line: 663, column: 31, scope: !1529)
!1573 = !DILocation(line: 663, column: 18, scope: !1529)
!1574 = !DILocation(line: 663, column: 29, scope: !1529)
!1575 = !{!1576, !1543, i64 12, i64 4}
!1576 = !{!1544, i64 16, !"_ZTSN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEE", !1543, i64 0, i64 4, !1543, i64 4, i64 4, !1543, i64 8, i64 4, !1543, i64 12, i64 4}
!1577 = !DILocation(line: 664, column: 39, scope: !1529)
!1578 = !DILocation(line: 664, column: 11, scope: !1529)
!1579 = !DILocation(line: 664, column: 25, scope: !1529)
!1580 = !{!1581, !1543, i64 0, i64 4}
!1581 = !{!1544, i64 4, !"_ZTSN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEE", !1543, i64 0, i64 4}
!1582 = !{i64 20, i64 0, i64 4, i64 4}
!1583 = !DILocation(line: 665, column: 27, scope: !1529)
!1584 = !{!1567, !1567, i64 0, i64 20}
!1585 = !{i64 16, i64 0, i64 4, i64 3}
!1586 = !DILocation(line: 665, column: 40, scope: !1529)
!1587 = !{!1576, !1576, i64 0, i64 16}
!1588 = !DILocation(line: 665, column: 11, scope: !1529)
!1589 = !DILocation(line: 666, column: 1, scope: !1529)
!1590 = distinct !DISubprogram(name: "T_inputIF", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev", scope: !112, file: !113, line: 305, type: !1591, scopeLine: 305, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1594, retainedNodes: !1595)
!1591 = !DISubroutineType(types: !1592)
!1592 = !{null, !1593}
!1593 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1594 = !DISubprogram(name: "T_inputIF", scope: !112, type: !1591, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1595 = !{!1596}
!1596 = !DILocalVariable(name: "this", arg: 1, scope: !1590, type: !1597, flags: DIFlagArtificial | DIFlagObjectPointer)
!1597 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 32)
!1598 = !DILocation(line: 0, scope: !1590)
!1599 = !DILocation(line: 310, column: 42, scope: !1590)
!1600 = !DILocation(line: 305, column: 8, scope: !1590)
!1601 = distinct !DISubprogram(name: "T_outputIF", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev", scope: !129, file: !113, line: 314, type: !1602, scopeLine: 314, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1605, retainedNodes: !1606)
!1602 = !DISubroutineType(types: !1603)
!1603 = !{null, !1604}
!1604 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1605 = !DISubprogram(name: "T_outputIF", scope: !129, type: !1602, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1606 = !{!1607}
!1607 = !DILocalVariable(name: "this", arg: 1, scope: !1601, type: !1608, flags: DIFlagArtificial | DIFlagObjectPointer)
!1608 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 32)
!1609 = !DILocation(line: 0, scope: !1601)
!1610 = !DILocation(line: 318, column: 43, scope: !1601)
!1611 = !DILocation(line: 314, column: 8, scope: !1601)
!1612 = distinct !DISubprogram(name: "data", linkageName: "_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv", scope: !1059, file: !1060, line: 122, type: !1613, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1620, retainedNodes: !1621)
!1613 = !DISubroutineType(types: !1614)
!1614 = !{!1615, !1618}
!1615 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1616)
!1616 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1617, size: 32)
!1617 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !1059, file: !1060, line: 47, baseType: !80, flags: DIFlagPublic)
!1618 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1619, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1619 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1059)
!1620 = !DISubprogram(name: "data", linkageName: "_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv", scope: !1059, file: !1060, line: 122, type: !1613, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1621 = !{!1622}
!1622 = !DILocalVariable(name: "this", arg: 1, scope: !1612, type: !1623, flags: DIFlagArtificial | DIFlagObjectPointer)
!1623 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1619, size: 32)
!1624 = !{!1625}
!1625 = distinct !{!1625, !1626, !"_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv: unknown scope"}
!1626 = distinct !{!1626, !"_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv"}
!1627 = !DILocation(line: 0, scope: !1612)
!1628 = !DILocation(line: 125, column: 26, scope: !1629)
!1629 = distinct !DILexicalBlock(scope: !1612, file: !1060, line: 124, column: 23)
!1630 = !{!1631, !1543, i64 0, i64 4}
!1631 = !{!1544, i64 4, !"_ZTSN3adf6detail14io_buffer_baseIfNS_7locking4syncEEE", !1543, i64 0, i64 4}
!1632 = !DILocation(line: 125, column: 13, scope: !1629)
!1633 = distinct !DISubprogram(name: "matVecMulKernel", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !83, line: 78, type: !109, scopeLine: 79, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !159, retainedNodes: !1634)
!1634 = !{!1635, !1636, !1637}
!1635 = !DILocalVariable(name: "this", arg: 1, scope: !1633, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!1636 = !DILocalVariable(name: "inInterface", arg: 2, scope: !1633, file: !86, line: 140, type: !112)
!1637 = !DILocalVariable(name: "outInterface", arg: 3, scope: !1633, file: !86, line: 140, type: !129)
!1638 = !{!1639}
!1639 = distinct !{!1639, !1640, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: unknown scope"}
!1640 = distinct !{!1640, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE"}
!1641 = !{!1642, !1639}
!1642 = distinct !{!1642, !1640, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outInterface"}
!1643 = !DILocation(line: 0, scope: !1633)
!1644 = !DILocation(line: 140, column: 58, scope: !1633)
!1645 = !{!1642}
!1646 = !DILocation(line: 140, column: 104, scope: !1633)
!1647 = !DILocation(line: 81, column: 25, scope: !1633)
!1648 = !DILocation(line: 81, column: 38, scope: !1633)
!1649 = !DILocation(line: 81, column: 5, scope: !1633)
!1650 = !DILocation(line: 82, column: 1, scope: !1633)
!1651 = distinct !DISubprogram(name: "__cxx_global_var_init", scope: !1397, file: !1397, type: !1049, flags: DIFlagArtificial | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!1652 = !DILocation(line: 7, column: 125, scope: !1651)
!1653 = distinct !DISubprogram(name: "matrix_vector_mul", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEC2Ev", scope: !1040, file: !86, line: 268, type: !1045, scopeLine: 268, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1044, retainedNodes: !1654)
!1654 = !{!1655}
!1655 = !DILocalVariable(name: "this", arg: 1, scope: !1653, type: !1532, flags: DIFlagArtificial | DIFlagObjectPointer)
!1656 = !DILocation(line: 0, scope: !1653)
!1657 = !DILocation(line: 268, column: 5, scope: !1653)
!1658 = !DILocation(line: 268, column: 25, scope: !1653)
!1659 = distinct !DISubprogram(name: "i2_user", linkageName: "_Z7i2_userv", scope: !1397, file: !1397, line: 8, type: !1660, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!1660 = !DISubroutineType(types: !1661)
!1661 = !{!1161}
!1662 = !DILocation(line: 8, column: 18, scope: !1659)
!1663 = distinct !DISubprogram(name: "matVecMulSelectArch", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !83, line: 117, type: !109, scopeLine: 118, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !108, retainedNodes: !1664)
!1664 = !{!1665, !1666, !1667}
!1665 = !DILocalVariable(name: "this", arg: 1, scope: !1663, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!1666 = !DILocalVariable(name: "inInterface", arg: 2, scope: !1663, file: !86, line: 123, type: !112)
!1667 = !DILocalVariable(name: "outInterface", arg: 3, scope: !1663, file: !86, line: 124, type: !129)
!1668 = !{!1669}
!1669 = distinct !{!1669, !1670, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: unknown scope"}
!1670 = distinct !{!1670, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE"}
!1671 = !{!1672, !1669}
!1672 = distinct !{!1672, !1670, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outInterface"}
!1673 = !DILocation(line: 0, scope: !1663)
!1674 = !DILocation(line: 123, column: 62, scope: !1663)
!1675 = !{!1672}
!1676 = !DILocation(line: 124, column: 63, scope: !1663)
!1677 = !DILocation(line: 120, column: 49, scope: !1678)
!1678 = distinct !DILexicalBlock(scope: !1679, file: !83, line: 120, column: 32)
!1679 = distinct !DILexicalBlock(scope: !1663, file: !83, line: 120, column: 19)
!1680 = !DILocation(line: 120, column: 62, scope: !1678)
!1681 = !DILocation(line: 120, column: 34, scope: !1678)
!1682 = !DILocation(line: 124, column: 1, scope: !1663)
!1683 = !{!1684}
!1684 = distinct !{!1684, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: unknown scope"}
!1685 = distinct !{!1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE"}
!1686 = !{!1687, !1688, !1689, !1690, !1684, !1691, !1692, !1693, !1694, !1695}
!1687 = distinct !{!1687, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outInterface"}
!1688 = distinct !{!1688, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inPtrA"}
!1689 = distinct !{!1689, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inPtrB"}
!1690 = distinct !{!1690, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inMatrixBuff"}
!1691 = distinct !{!1691, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inMatrixPtrRtp"}
!1692 = distinct !{!1692, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: matrixPtr"}
!1693 = distinct !{!1693, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: matrixStartPtr"}
!1694 = distinct !{!1694, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: vectorStartPtr"}
!1695 = distinct !{!1695, !1685, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outPtr"}
!1696 = !DILocation(line: 0, scope: !84)
!1697 = !DILocation(line: 126, column: 57, scope: !84)
!1698 = !{!1687}
!1699 = !DILocation(line: 126, column: 103, scope: !84)
!1700 = !DILocation(line: 167, column: 5, scope: !84)
!1701 = !DILocation(line: 168, column: 5, scope: !84)
!1702 = !DILocation(line: 170, column: 5, scope: !84)
!1703 = !DILocation(line: 170, column: 13, scope: !84)
!1704 = !{!1705, !1705, i64 0, i64 32}
!1705 = !{!1544, i64 32, !"_ZTSN3aie6vectorIfLj8EEE", !1706, i64 0, i64 32}
!1706 = !{!1544, i64 32, !"_ZTSN3aie6detail11vector_baseIfLj8EEE", !1707, i64 0, i64 32}
!1707 = !{!1544, i64 32, !"v64int4"}
!1708 = !DILocation(line: 171, column: 5, scope: !84)
!1709 = !DILocation(line: 171, column: 25, scope: !84)
!1710 = !{!1688}
!1711 = !DILocation(line: 172, column: 5, scope: !84)
!1712 = !DILocation(line: 172, column: 13, scope: !84)
!1713 = !DILocation(line: 173, column: 5, scope: !84)
!1714 = !DILocation(line: 173, column: 25, scope: !84)
!1715 = !{!1689}
!1716 = !DILocation(line: 175, column: 5, scope: !84)
!1717 = !DILocation(line: 175, column: 15, scope: !84)
!1718 = !{!1719, !1719, i64 0, i64 32}
!1719 = !{!1544, i64 32, !"_ZTSN3aie5accumI8accfloatLj8EEE", !1720, i64 0, i64 32}
!1720 = !{!1544, i64 32, !"_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEE", !1721, i64 0, i64 32}
!1721 = !{!1544, i64 32, !"v8acc32"}
!1722 = !DILocation(line: 176, column: 5, scope: !84)
!1723 = !DILocation(line: 176, column: 15, scope: !84)
!1724 = !DILocation(line: 176, column: 27, scope: !84)
!1725 = !DILocation(line: 177, column: 5, scope: !84)
!1726 = !DILocation(line: 177, column: 15, scope: !84)
!1727 = !DILocation(line: 180, column: 5, scope: !84)
!1728 = !DILocation(line: 180, column: 27, scope: !84)
!1729 = !{!1690}
!1730 = !DILocation(line: 180, column: 66, scope: !84)
!1731 = !{!1567, !1543, i64 0, i64 4}
!1732 = !DILocation(line: 181, column: 5, scope: !84)
!1733 = !DILocation(line: 181, column: 27, scope: !84)
!1734 = !{!1691}
!1735 = !DILocation(line: 181, column: 44, scope: !84)
!1736 = !DILocation(line: 182, column: 5, scope: !84)
!1737 = !DILocation(line: 182, column: 27, scope: !84)
!1738 = !{!1692}
!1739 = !DILocation(line: 182, column: 69, scope: !84)
!1740 = !DILocation(line: 184, column: 5, scope: !84)
!1741 = !DILocation(line: 184, column: 25, scope: !84)
!1742 = !{!1693}
!1743 = !DILocation(line: 184, column: 53, scope: !84)
!1744 = !DILocation(line: 185, column: 5, scope: !84)
!1745 = !DILocation(line: 185, column: 25, scope: !84)
!1746 = !{!1694}
!1747 = !DILocation(line: 185, column: 64, scope: !84)
!1748 = !DILocation(line: 186, column: 5, scope: !84)
!1749 = !DILocation(line: 186, column: 27, scope: !84)
!1750 = !{!1695}
!1751 = !DILocation(line: 186, column: 61, scope: !84)
!1752 = !{!1576, !1543, i64 0, i64 4}
!1753 = !DILocation(line: 189, column: 10, scope: !473)
!1754 = !DILocation(line: 189, column: 14, scope: !473)
!1755 = !{!1756, !1756, i64 0, i64 4}
!1756 = !{!1544, i64 4, !"int"}
!1757 = !DILocation(line: 189, column: 25, scope: !477)
!1758 = !DILocation(line: 189, column: 31, scope: !477)
!1759 = !DILocation(line: 189, column: 5, scope: !473)
!1760 = !DILocation(line: 189, column: 5, scope: !477)
!1761 = !DILocation(line: 191, column: 14, scope: !475)
!1762 = !DILocation(line: 191, column: 18, scope: !475)
!1763 = !DILocation(line: 191, column: 27, scope: !481)
!1764 = !DILocation(line: 191, column: 31, scope: !481)
!1765 = !DILocation(line: 191, column: 9, scope: !475)
!1766 = distinct !{!1766, !1765, !1767, !1768, !1769, !1770, !1771, !1772}
!1767 = !DILocation(line: 227, column: 13, scope: !475)
!1768 = !{!"llvm.loop.mustprogress"}
!1769 = !{!"llvm.loop.chess.prepare_for_pipelining"}
!1770 = !{!"llvm.loop.chess.min_loop_count", i32 16}
!1771 = !{!"llvm.loop.chess.max_loop_count", i32 16}
!1772 = !{!"llvm.loop.disable_llvm_transforms"}
!1773 = !DILocation(line: 191, column: 9, scope: !481)
!1774 = !DILocation(line: 192, column: 27, scope: !480)
!1775 = !DILocation(line: 192, column: 46, scope: !480)
!1776 = !DILocation(line: 192, column: 52, scope: !480)
!1777 = !DILocation(line: 192, column: 43, scope: !480)
!1778 = !DILocation(line: 192, column: 73, scope: !480)
!1779 = !DILocation(line: 192, column: 70, scope: !480)
!1780 = !DILocation(line: 192, column: 24, scope: !480)
!1781 = !DILocation(line: 193, column: 27, scope: !480)
!1782 = !DILocation(line: 193, column: 46, scope: !480)
!1783 = !DILocation(line: 193, column: 52, scope: !480)
!1784 = !DILocation(line: 193, column: 43, scope: !480)
!1785 = !DILocation(line: 193, column: 24, scope: !480)
!1786 = !DILocation(line: 197, column: 80, scope: !1787)
!1787 = distinct !DILexicalBlock(scope: !1788, file: !83, line: 196, column: 59)
!1788 = distinct !DILexicalBlock(scope: !480, file: !83, line: 196, column: 31)
!1789 = !DILocation(line: 197, column: 42, scope: !1787)
!1790 = !DILocation(line: 197, column: 29, scope: !1787)
!1791 = !DILocation(line: 202, column: 22, scope: !479)
!1792 = !DILocation(line: 202, column: 26, scope: !479)
!1793 = !DILocation(line: 202, column: 38, scope: !485)
!1794 = !DILocation(line: 202, column: 45, scope: !485)
!1795 = !DILocation(line: 202, column: 17, scope: !479)
!1796 = !DILocation(line: 202, column: 17, scope: !485)
!1797 = !DILocation(line: 203, column: 36, scope: !484)
!1798 = !DILocation(line: 203, column: 27, scope: !484)
!1799 = !DILocation(line: 205, column: 26, scope: !483)
!1800 = !DILocation(line: 205, column: 30, scope: !483)
!1801 = !DILocation(line: 205, column: 39, scope: !1802)
!1802 = distinct !DILexicalBlock(scope: !483, file: !83, line: 205, column: 21)
!1803 = !DILocation(line: 205, column: 43, scope: !1802)
!1804 = !DILocation(line: 205, column: 21, scope: !483)
!1805 = !DILocation(line: 205, column: 21, scope: !1802)
!1806 = !DILocation(line: 206, column: 34, scope: !1807)
!1807 = distinct !DILexicalBlock(scope: !1802, file: !83, line: 205, column: 67)
!1808 = !DILocation(line: 206, column: 31, scope: !1807)
!1809 = !DILocation(line: 207, column: 32, scope: !1807)
!1810 = !DILocation(line: 211, column: 57, scope: !1811)
!1811 = distinct !DILexicalBlock(scope: !1812, file: !83, line: 210, column: 30)
!1812 = distinct !DILexicalBlock(scope: !1807, file: !83, line: 209, column: 39)
!1813 = !DILocation(line: 211, column: 51, scope: !1811)
!1814 = !DILocation(line: 211, column: 35, scope: !1811)
!1815 = !{!1816, !1816, i64 0, i64 8}
!1816 = !{!1544, i64 8, !"_ZTSN3aie15vector_elem_refIfLj8EEE", !1543, i64 0, i64 4, !1756, i64 4, i64 4}
!1817 = !DILocation(line: 211, column: 33, scope: !1811)
!1818 = !DILocation(line: 213, column: 21, scope: !1807)
!1819 = !DILocation(line: 205, column: 63, scope: !1802)
!1820 = distinct !{!1820, !1804, !1821, !1768, !1822}
!1821 = !DILocation(line: 213, column: 21, scope: !483)
!1822 = !{!"llvm.loop.unroll.count", i32 8}
!1823 = !DILocation(line: 214, column: 17, scope: !484)
!1824 = !DILocation(line: 202, column: 70, scope: !485)
!1825 = distinct !{!1825, !1795, !1826, !1768}
!1826 = !DILocation(line: 214, column: 17, scope: !479)
!1827 = !DILocation(line: 225, column: 44, scope: !1828)
!1828 = distinct !DILexicalBlock(scope: !1829, file: !83, line: 224, column: 22)
!1829 = distinct !DILexicalBlock(scope: !480, file: !83, line: 217, column: 31)
!1830 = !DILocation(line: 225, column: 21, scope: !1828)
!1831 = !DILocation(line: 227, column: 13, scope: !480)
!1832 = !DILocation(line: 191, column: 50, scope: !481)
!1833 = !DILocation(line: 228, column: 5, scope: !476)
!1834 = !DILocation(line: 189, column: 53, scope: !477)
!1835 = distinct !{!1835, !1759, !1836, !1768}
!1836 = !DILocation(line: 228, column: 5, scope: !473)
!1837 = !DILocation(line: 229, column: 1, scope: !84)
!1838 = distinct !DISubprogram(name: "set_rnd_mode<0U>", linkageName: "_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv", scope: !89, file: !1839, line: 42, type: !1049, scopeLine: 42, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1840, retainedNodes: !137)
!1839 = !DIFile(filename: "dsp_lib/L1/include/aie/kernel_api_utils.hpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!1840 = !{!1841}
!1841 = !DITemplateValueParameter(name: "rndMode", type: !15, value: i32 0)
!1842 = !DILocation(line: 45, column: 43, scope: !1843)
!1843 = distinct !DILexicalBlock(scope: !1844, file: !1839, line: 45, column: 41)
!1844 = distinct !DILexicalBlock(scope: !1838, file: !1839, line: 45, column: 19)
!1845 = !DILocation(line: 76, column: 1, scope: !1838)
!1846 = distinct !DISubprogram(name: "set_sat_mode<0U>", linkageName: "_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv", scope: !89, file: !1839, line: 80, type: !1049, scopeLine: 80, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1847, retainedNodes: !137)
!1847 = !{!1848}
!1848 = !DITemplateValueParameter(name: "satMode", type: !15, value: i32 0)
!1849 = !DILocation(line: 83, column: 35, scope: !1850)
!1850 = distinct !DILexicalBlock(scope: !1851, file: !1839, line: 83, column: 33)
!1851 = distinct !DILexicalBlock(scope: !1846, file: !1839, line: 83, column: 19)
!1852 = !DILocation(line: 93, column: 1, scope: !1846)
!1853 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj8EEC2Ev", scope: !188, file: !189, line: 148, type: !276, scopeLine: 150, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !275, retainedNodes: !1854)
!1854 = !{!1855}
!1855 = !DILocalVariable(name: "this", arg: 1, scope: !1853, type: !1856, flags: DIFlagArtificial | DIFlagObjectPointer)
!1856 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !188, size: 32)
!1857 = !DILocation(line: 0, scope: !1853)
!1858 = !DILocation(line: 149, column: 9, scope: !1853)
!1859 = !DILocation(line: 151, column: 5, scope: !1853)
!1860 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj8EEC2Ev", scope: !374, file: !375, line: 163, type: !442, scopeLine: 163, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !441, retainedNodes: !1861)
!1861 = !{!1862}
!1862 = !DILocalVariable(name: "this", arg: 1, scope: !1860, type: !1863, flags: DIFlagArtificial | DIFlagObjectPointer)
!1863 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !374, size: 32)
!1864 = !DILocation(line: 0, scope: !1860)
!1865 = !DILocation(line: 163, column: 5, scope: !1860)
!1866 = !DILocation(line: 163, column: 21, scope: !1860)
!1867 = distinct !DISubprogram(name: "zeros<float, 8U>", linkageName: "_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv", scope: !8, file: !1502, line: 1084, type: !1868, scopeLine: 1085, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !208, retainedNodes: !137)
!1868 = !DISubroutineType(types: !1869)
!1869 = !{!188}
!1870 = !DILocation(line: 1086, column: 12, scope: !1867)
!1871 = !DILocation(line: 1086, column: 5, scope: !1867)
!1872 = distinct !DISubprogram(name: "readincr_v<8U, accfloat>", linkageName: "_Z10readincr_vILj8E8accfloatEN3aie5accumIT0_XT_EEEP13input_cascadeIS3_vE", scope: !907, file: !907, line: 718, type: !1873, scopeLine: 718, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1877, retainedNodes: !1875)
!1873 = !DISubroutineType(types: !1874)
!1874 = !{!374, !124}
!1875 = !{!1876}
!1876 = !DILocalVariable(name: "w", arg: 1, scope: !1872, file: !907, line: 718, type: !124)
!1877 = !{!353, !1878}
!1878 = !DITemplateTypeParameter(name: "T", type: !459)
!1879 = !DILocation(line: 718, column: 49, scope: !1872)
!1880 = !DILocation(line: 718, column: 160, scope: !1872)
!1881 = !DILocation(line: 718, column: 104, scope: !1872)
!1882 = !DILocation(line: 718, column: 97, scope: !1872)
!1883 = distinct !DISubprogram(name: "mac<aie::accum<accfloat, 8U>, aie::vector_elem_ref<float, 8U>, aie::vector<float, 8U> >", linkageName: "_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_", scope: !8, file: !1502, line: 4866, type: !1884, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1894, retainedNodes: !1890)
!1884 = !DISubroutineType(types: !1885)
!1885 = !{!1886, !447, !322, !1889}
!1886 = !DIDerivedType(tag: DW_TAG_typedef, name: "operand_base_type_t<aie::accum<accfloat, 8U> >", scope: !8, file: !1080, line: 410, baseType: !1887)
!1887 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1888, file: !1502, line: 94, baseType: !941)
!1888 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "operand_base_type<aie::accum<accfloat, 8U> >", scope: !8, file: !1502, line: 92, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !945, identifier: "_ZTSN3aie17operand_base_typeINS_5accumI8accfloatLj8EEEEE")
!1889 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !292, size: 32)
!1890 = !{!1891, !1892, !1893}
!1891 = !DILocalVariable(name: "acc", arg: 1, scope: !1883, file: !1502, line: 4866, type: !447)
!1892 = !DILocalVariable(name: "a", arg: 2, scope: !1883, file: !1502, line: 4866, type: !322)
!1893 = !DILocalVariable(name: "v", arg: 3, scope: !1883, file: !1502, line: 4866, type: !1889)
!1894 = !{!1895, !1896, !1897}
!1895 = !DITemplateTypeParameter(name: "Acc", type: !374)
!1896 = !DITemplateTypeParameter(name: "E", type: !322)
!1897 = !DITemplateTypeParameter(name: "Vec", type: !188)
!1898 = !DILocation(line: 4866, column: 31, scope: !1883)
!1899 = !DILocation(line: 4866, column: 38, scope: !1883)
!1900 = !DILocation(line: 4866, column: 52, scope: !1883)
!1901 = !DILocation(line: 4869, column: 20, scope: !1902)
!1902 = distinct !DILexicalBlock(scope: !1903, file: !1502, line: 4868, column: 39)
!1903 = distinct !DILexicalBlock(scope: !1883, file: !1502, line: 4868, column: 24)
!1904 = !DILocation(line: 4869, column: 27, scope: !1902)
!1905 = !DILocation(line: 4869, column: 33, scope: !1902)
!1906 = !DILocation(line: 4869, column: 36, scope: !1902)
!1907 = !DILocation(line: 4869, column: 16, scope: !1902)
!1908 = !DILocation(line: 4869, column: 9, scope: !1902)
!1909 = distinct !DISubprogram(name: "operator[]", linkageName: "_ZN3aie6vectorIfLj8EEixEj", scope: !188, file: !189, line: 303, type: !364, scopeLine: 304, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !363, retainedNodes: !1910)
!1910 = !{!1911, !1912}
!1911 = !DILocalVariable(name: "this", arg: 1, scope: !1909, type: !1856, flags: DIFlagArtificial | DIFlagObjectPointer)
!1912 = !DILocalVariable(name: "idx", arg: 2, scope: !1909, file: !189, line: 303, type: !15)
!1913 = !DILocation(line: 0, scope: !1909)
!1914 = !DILocation(line: 303, column: 83, scope: !1909)
!1915 = !DILocation(line: 305, column: 9, scope: !1909)
!1916 = !DILocation(line: 305, column: 9, scope: !1917)
!1917 = distinct !DILexicalBlock(scope: !1918, file: !189, line: 305, column: 9)
!1918 = distinct !DILexicalBlock(scope: !1909, file: !189, line: 305, column: 9)
!1919 = !DILocation(line: 305, column: 9, scope: !1918)
!1920 = !DILocation(line: 305, column: 9, scope: !1921)
!1921 = distinct !DILexicalBlock(scope: !1917, file: !189, line: 305, column: 9)
!1922 = !DILocation(line: 305, column: 9, scope: !1923)
!1923 = distinct !DILexicalBlock(scope: !1924, file: !189, line: 305, column: 9)
!1924 = distinct !DILexicalBlock(scope: !1921, file: !189, line: 305, column: 9)
!1925 = !DILocation(line: 305, column: 9, scope: !1924)
!1926 = !{!"idx needs to be a valid element index"}
!1927 = !DILocation(line: 305, column: 9, scope: !1928)
!1928 = distinct !DILexicalBlock(scope: !1917, file: !189, line: 305, column: 9)
!1929 = !DILocation(line: 306, column: 25, scope: !1909)
!1930 = !DILocation(line: 306, column: 16, scope: !1909)
!1931 = !DILocation(line: 306, column: 9, scope: !1909)
!1932 = distinct !DISubprogram(name: "writeincr<accfloat, 8U>", linkageName: "_Z9writeincrI8accfloatLj8EEvP14output_cascadeIT_vERKN3aie5accumIS2_XT0_EEE", scope: !907, file: !907, line: 696, type: !1933, scopeLine: 696, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1938, retainedNodes: !1935)
!1933 = !DISubroutineType(types: !1934)
!1934 = !{null, !144, !447}
!1935 = !{!1936, !1937}
!1936 = !DILocalVariable(name: "w", arg: 1, scope: !1932, file: !907, line: 696, type: !144)
!1937 = !DILocalVariable(name: "value", arg: 2, scope: !1932, file: !907, line: 696, type: !447)
!1938 = !{!1878, !353}
!1939 = !DILocation(line: 696, column: 48, scope: !1932)
!1940 = !DILocation(line: 696, column: 76, scope: !1932)
!1941 = !DILocation(line: 696, column: 162, scope: !1932)
!1942 = !DILocation(line: 696, column: 165, scope: !1932)
!1943 = !DILocation(line: 696, column: 104, scope: !1932)
!1944 = !DILocation(line: 696, column: 175, scope: !1932)
!1945 = distinct !DISubprogram(name: "set_rounding", linkageName: "_ZN3aieL12set_roundingENS_13rounding_modeE", scope: !8, file: !1502, line: 7750, type: !1946, scopeLine: 7751, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1948)
!1946 = !DISubroutineType(types: !1947)
!1947 = !{null, !13}
!1948 = !{!1949}
!1949 = !DILocalVariable(name: "m", arg: 1, scope: !1945, file: !1502, line: 7750, type: !13)
!1950 = !{!1951, !1951, i64 0, i64 4}
!1951 = !{!1544, i64 4, !"_ZTSN3aie13rounding_modeE"}
!1952 = !DILocation(line: 7750, column: 47, scope: !1945)
!1953 = !DILocation(line: 7752, column: 5, scope: !1945)
!1954 = !DILocation(line: 7752, column: 39, scope: !1945)
!1955 = !DILocation(line: 7752, column: 26, scope: !1945)
!1956 = !DILocation(line: 7753, column: 1, scope: !1945)
!1957 = distinct !DISubprogram(name: "current", linkageName: "_ZN3aie4tile7currentEv", scope: !613, file: !614, line: 46, type: !634, scopeLine: 46, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !633, retainedNodes: !137)
!1958 = !DILocation(line: 46, column: 36, scope: !1957)
!1959 = !DILocation(line: 46, column: 29, scope: !1957)
!1960 = distinct !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie4tile12set_roundingENS_13rounding_modeE", scope: !613, file: !614, line: 58, type: !643, scopeLine: 58, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !642, retainedNodes: !1961)
!1961 = !{!1962, !1964}
!1962 = !DILocalVariable(name: "this", arg: 1, scope: !1960, type: !1963, flags: DIFlagArtificial | DIFlagObjectPointer)
!1963 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !613, size: 32)
!1964 = !DILocalVariable(name: "mode", arg: 2, scope: !1960, file: !614, line: 58, type: !13)
!1965 = !DILocation(line: 0, scope: !1960)
!1966 = !DILocation(line: 58, column: 37, scope: !1960)
!1967 = !DILocation(line: 58, column: 69, scope: !1960)
!1968 = !DILocation(line: 58, column: 56, scope: !1960)
!1969 = !DILocation(line: 59, column: 5, scope: !1960)
!1970 = distinct !DISubprogram(name: "current", linkageName: "_ZN3aie6detail4tile7currentEv", scope: !571, file: !572, line: 64, type: !599, scopeLine: 65, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !598, retainedNodes: !137)
!1971 = !DILocation(line: 66, column: 16, scope: !1970)
!1972 = !DILocation(line: 66, column: 9, scope: !1970)
!1973 = distinct !DISubprogram(name: "tile", linkageName: "_ZN3aie4tileC2ERKNS_6detail4tileE", scope: !613, file: !614, line: 30, type: !618, scopeLine: 30, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !617, retainedNodes: !1974)
!1974 = !{!1975, !1976}
!1975 = !DILocalVariable(name: "this", arg: 1, scope: !1973, type: !1963, flags: DIFlagArtificial | DIFlagObjectPointer)
!1976 = !DILocalVariable(name: "t", arg: 2, scope: !1973, file: !614, line: 30, type: !621)
!1977 = !DILocation(line: 0, scope: !1973)
!1978 = !DILocation(line: 30, column: 27, scope: !1973)
!1979 = !DILocation(line: 30, column: 45, scope: !1973)
!1980 = !DILocation(line: 30, column: 49, scope: !1973)
!1981 = distinct !DISubprogram(name: "tile", linkageName: "_ZN3aie6detail4tileC2Ev", scope: !571, file: !572, line: 36, type: !580, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !579, retainedNodes: !1982)
!1982 = !{!1983}
!1983 = !DILocalVariable(name: "this", arg: 1, scope: !1981, type: !1984, flags: DIFlagArtificial | DIFlagObjectPointer)
!1984 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !571, size: 32)
!1985 = !DILocation(line: 0, scope: !1981)
!1986 = !DILocation(line: 36, column: 23, scope: !1981)
!1987 = distinct !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE", scope: !571, file: !572, line: 82, type: !608, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !607, retainedNodes: !1988)
!1988 = !{!1989, !1990}
!1989 = !DILocalVariable(name: "this", arg: 1, scope: !1987, type: !1984, flags: DIFlagArtificial | DIFlagObjectPointer)
!1990 = !DILocalVariable(name: "mode", arg: 2, scope: !1987, file: !572, line: 82, type: !13)
!1991 = !DILocation(line: 0, scope: !1987)
!1992 = !DILocation(line: 82, column: 37, scope: !1987)
!1993 = !DILocation(line: 84, column: 29, scope: !1987)
!1994 = !DILocation(line: 84, column: 9, scope: !1987)
!1995 = !DILocation(line: 85, column: 5, scope: !1987)
!1996 = distinct !DISubprogram(name: "set_saturation", linkageName: "_ZN3aieL14set_saturationENS_15saturation_modeE", scope: !8, file: !1502, line: 7715, type: !1997, scopeLine: 7716, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1999)
!1997 = !DISubroutineType(types: !1998)
!1998 = !{null, !27}
!1999 = !{!2000}
!2000 = !DILocalVariable(name: "m", arg: 1, scope: !1996, file: !1502, line: 7715, type: !27)
!2001 = !{!2002, !2002, i64 0, i64 4}
!2002 = !{!1544, i64 4, !"_ZTSN3aie15saturation_modeE"}
!2003 = !DILocation(line: 7715, column: 51, scope: !1996)
!2004 = !DILocation(line: 7717, column: 5, scope: !1996)
!2005 = !DILocation(line: 7717, column: 41, scope: !1996)
!2006 = !DILocation(line: 7717, column: 26, scope: !1996)
!2007 = !DILocation(line: 7718, column: 1, scope: !1996)
!2008 = distinct !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie4tile14set_saturationENS_15saturation_modeE", scope: !613, file: !614, line: 50, type: !637, scopeLine: 50, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !636, retainedNodes: !2009)
!2009 = !{!2010, !2011}
!2010 = !DILocalVariable(name: "this", arg: 1, scope: !2008, type: !1963, flags: DIFlagArtificial | DIFlagObjectPointer)
!2011 = !DILocalVariable(name: "mode", arg: 2, scope: !2008, file: !614, line: 50, type: !27)
!2012 = !DILocation(line: 0, scope: !2008)
!2013 = !DILocation(line: 50, column: 41, scope: !2008)
!2014 = !DILocation(line: 50, column: 75, scope: !2008)
!2015 = !DILocation(line: 50, column: 60, scope: !2008)
!2016 = !DILocation(line: 50, column: 82, scope: !2008)
!2017 = distinct !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE", scope: !571, file: !572, line: 70, type: !602, scopeLine: 71, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !601, retainedNodes: !2018)
!2018 = !{!2019, !2020}
!2019 = !DILocalVariable(name: "this", arg: 1, scope: !2017, type: !1984, flags: DIFlagArtificial | DIFlagObjectPointer)
!2020 = !DILocalVariable(name: "mode", arg: 2, scope: !2017, file: !572, line: 70, type: !27)
!2021 = !DILocation(line: 0, scope: !2017)
!2022 = !DILocation(line: 70, column: 41, scope: !2017)
!2023 = !DILocation(line: 72, column: 33, scope: !2017)
!2024 = !DILocation(line: 72, column: 9, scope: !2017)
!2025 = !DILocation(line: 73, column: 5, scope: !2017)
!2026 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj8EEC2Ev", scope: !192, file: !193, line: 402, type: !226, scopeLine: 404, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !225, retainedNodes: !2027)
!2027 = !{!2028}
!2028 = !DILocalVariable(name: "this", arg: 1, scope: !2026, type: !2029, flags: DIFlagArtificial | DIFlagObjectPointer)
!2029 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 32)
!2030 = !DILocation(line: 0, scope: !2026)
!2031 = !DILocation(line: 403, column: 9, scope: !2026)
!2032 = !DILocation(line: 403, column: 14, scope: !2026)
!2033 = !DILocation(line: 405, column: 5, scope: !2026)
!2034 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj8EE5undefEv", scope: !203, file: !201, line: 298, type: !206, scopeLine: 298, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !205, retainedNodes: !137)
!2035 = !DILocation(line: 298, column: 138, scope: !2034)
!2036 = !DILocation(line: 298, column: 131, scope: !2034)
!2037 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv", scope: !388, file: !386, line: 166, type: !391, scopeLine: 166, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !390, retainedNodes: !137)
!2038 = !DILocation(line: 166, column: 147, scope: !2037)
!2039 = !DILocation(line: 166, column: 140, scope: !2037)
!2040 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv", scope: !2042, file: !2041, line: 88, type: !2045, scopeLine: 89, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2044, retainedNodes: !137)
!2041 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/../broadcast.hpp", directory: "")
!2042 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "zeros_bits<32U, float, 8U>", scope: !7, file: !2041, line: 83, size: 8, flags: DIFlagTypePassByValue, elements: !2043, templateParams: !2048, identifier: "_ZTSN3aie6detail10zeros_bitsILj32EfLj8EEE")
!2043 = !{!2044}
!2044 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv", scope: !2042, file: !2041, line: 88, type: !2045, scopeLine: 88, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2045 = !DISubroutineType(types: !2046)
!2046 = !{!2047}
!2047 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2042, file: !2041, line: 85, baseType: !188)
!2048 = !{!2049, !209, !210}
!2049 = !DITemplateValueParameter(name: "TypeBits", type: !15, value: i32 32)
!2050 = !DILocation(line: 111, column: 20, scope: !2051)
!2051 = distinct !DILexicalBlock(scope: !2040, file: !2041, line: 108, column: 23)
!2052 = !DILocation(line: 111, column: 13, scope: !2051)
!2053 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv", scope: !2055, file: !2054, line: 292, type: !2058, scopeLine: 293, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2057, retainedNodes: !2061)
!2054 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/broadcast.hpp", directory: "")
!2055 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "zeros_bits_impl<32U, float, 8U>", scope: !7, file: !2054, line: 287, size: 8, flags: DIFlagTypePassByValue, elements: !2056, templateParams: !2048, identifier: "_ZTSN3aie6detail15zeros_bits_implILj32EfLj8EEE")
!2056 = !{!2057}
!2057 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv", scope: !2055, file: !2054, line: 292, type: !2058, scopeLine: 292, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2058 = !DISubroutineType(types: !2059)
!2059 = !{!2060}
!2060 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2055, file: !2054, line: 289, baseType: !188)
!2061 = !{!2062, !2063}
!2062 = !DILocalVariable(name: "native_zeros_elems", scope: !2053, file: !2054, line: 294, type: !101)
!2063 = !DILocalVariable(name: "ret", scope: !2053, file: !2054, line: 297, type: !2060)
!2064 = !DILocation(line: 294, column: 9, scope: !2053)
!2065 = !DILocation(line: 294, column: 28, scope: !2053)
!2066 = !DILocation(line: 297, column: 21, scope: !2053)
!2067 = !DILocation(line: 300, column: 19, scope: !2068)
!2068 = distinct !DILexicalBlock(scope: !2069, file: !2054, line: 299, column: 49)
!2069 = distinct !DILexicalBlock(scope: !2053, file: !2054, line: 299, column: 23)
!2070 = !DILocation(line: 300, column: 53, scope: !2068)
!2071 = !DILocation(line: 300, column: 17, scope: !2068)
!2072 = !DILocation(line: 300, column: 13, scope: !2068)
!2073 = !DILocation(line: 326, column: 5, scope: !2053)
!2074 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv", scope: !2075, file: !2054, line: 292, type: !2078, scopeLine: 293, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2077, retainedNodes: !2082)
!2075 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "zeros_bits_impl<32U, float, 16U>", scope: !7, file: !2054, line: 287, size: 8, flags: DIFlagTypePassByValue, elements: !2076, templateParams: !2081, identifier: "_ZTSN3aie6detail15zeros_bits_implILj32EfLj16EEE")
!2076 = !{!2077}
!2077 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv", scope: !2075, file: !2054, line: 292, type: !2078, scopeLine: 292, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2078 = !DISubroutineType(types: !2079)
!2079 = !{!2080}
!2080 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2075, file: !2054, line: 289, baseType: !742)
!2081 = !{!2049, !209, !511}
!2082 = !{!2083, !2084}
!2083 = !DILocalVariable(name: "native_zeros_elems", scope: !2074, file: !2054, line: 294, type: !101)
!2084 = !DILocalVariable(name: "ret", scope: !2074, file: !2054, line: 297, type: !2080)
!2085 = !DILocation(line: 294, column: 9, scope: !2074)
!2086 = !DILocation(line: 294, column: 28, scope: !2074)
!2087 = !DILocation(line: 297, column: 21, scope: !2074)
!2088 = !{!2089, !2089, i64 0, i64 64}
!2089 = !{!1544, i64 64, !"_ZTSN3aie6vectorIfLj16EEE", !2090, i64 0, i64 64}
!2090 = !{!1544, i64 64, !"_ZTSN3aie6detail11vector_baseIfLj16EEE", !2091, i64 0, i64 64}
!2091 = !{!1544, i64 64, !"v128int4"}
!2092 = !DILocation(line: 311, column: 23, scope: !2093)
!2093 = distinct !DILexicalBlock(scope: !2094, file: !2054, line: 310, column: 32)
!2094 = distinct !DILexicalBlock(scope: !2095, file: !2054, line: 308, column: 27)
!2095 = distinct !DILexicalBlock(scope: !2096, file: !2054, line: 304, column: 27)
!2096 = distinct !DILexicalBlock(scope: !2097, file: !2054, line: 302, column: 41)
!2097 = distinct !DILexicalBlock(scope: !2098, file: !2054, line: 302, column: 28)
!2098 = distinct !DILexicalBlock(scope: !2074, file: !2054, line: 299, column: 23)
!2099 = !{!2091, !2091, i64 0, i64 64}
!2100 = !DILocation(line: 311, column: 21, scope: !2093)
!2101 = !DILocation(line: 326, column: 5, scope: !2074)
!2102 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj", scope: !742, file: !189, line: 427, type: !2103, scopeLine: 428, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2106, declaration: !2105, retainedNodes: !2108)
!2103 = !DISubroutineType(types: !2104)
!2104 = !{!188, !833, !15}
!2105 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj", scope: !742, file: !189, line: 427, type: !2103, scopeLine: 427, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2106)
!2106 = !{!2107}
!2107 = !DITemplateValueParameter(name: "ElemsOut", type: !15, value: i32 8)
!2108 = !{!2109, !2111}
!2109 = !DILocalVariable(name: "this", arg: 1, scope: !2102, type: !2110, flags: DIFlagArtificial | DIFlagObjectPointer)
!2110 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !834, size: 32)
!2111 = !DILocalVariable(name: "idx", arg: 2, scope: !2102, file: !189, line: 427, type: !15)
!2112 = !DILocation(line: 0, scope: !2102)
!2113 = !DILocation(line: 427, column: 51, scope: !2102)
!2114 = !DILocation(line: 429, column: 16, scope: !2102)
!2115 = !DILocation(line: 429, column: 54, scope: !2102)
!2116 = !DILocation(line: 429, column: 36, scope: !2102)
!2117 = !DILocation(line: 429, column: 9, scope: !2102)
!2118 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj16EEC2Ev", scope: !742, file: !189, line: 148, type: !818, scopeLine: 150, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !817, retainedNodes: !2119)
!2119 = !{!2120}
!2120 = !DILocalVariable(name: "this", arg: 1, scope: !2118, type: !2121, flags: DIFlagArtificial | DIFlagObjectPointer)
!2121 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !742, size: 32)
!2122 = !DILocation(line: 0, scope: !2118)
!2123 = !DILocation(line: 149, column: 9, scope: !2118)
!2124 = !DILocation(line: 151, column: 5, scope: !2118)
!2125 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj16EEC2E8v16float", scope: !742, file: !189, line: 159, type: !821, scopeLine: 161, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !820, retainedNodes: !2126)
!2126 = !{!2127, !2128}
!2127 = !DILocalVariable(name: "this", arg: 1, scope: !2125, type: !2121, flags: DIFlagArtificial | DIFlagObjectPointer)
!2128 = !DILocalVariable(name: "v", arg: 2, scope: !2125, file: !189, line: 159, type: !823)
!2129 = !DILocation(line: 0, scope: !2125)
!2130 = !DILocation(line: 159, column: 22, scope: !2125)
!2131 = !DILocation(line: 160, column: 9, scope: !2125)
!2132 = !DILocation(line: 163, column: 5, scope: !2125)
!2133 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj16EE5undefEv", scope: !753, file: !201, line: 299, type: !756, scopeLine: 299, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !755, retainedNodes: !137)
!2134 = !DILocation(line: 299, column: 138, scope: !2133)
!2135 = !DILocation(line: 299, column: 131, scope: !2133)
!2136 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj", scope: !745, file: !193, line: 867, type: !2137, scopeLine: 868, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2106, declaration: !2139, retainedNodes: !2140)
!2137 = !DISubroutineType(types: !2138)
!2138 = !{!192, !795, !15}
!2139 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj", scope: !745, file: !193, line: 867, type: !2137, scopeLine: 867, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2106)
!2140 = !{!2141, !2143}
!2141 = !DILocalVariable(name: "this", arg: 1, scope: !2136, type: !2142, flags: DIFlagArtificial | DIFlagObjectPointer)
!2142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !796, size: 32)
!2143 = !DILocalVariable(name: "idx", arg: 2, scope: !2136, file: !193, line: 867, type: !15)
!2144 = !DILocation(line: 0, scope: !2136)
!2145 = !DILocation(line: 867, column: 47, scope: !2136)
!2146 = !DILocation(line: 869, column: 9, scope: !2136)
!2147 = !DILocation(line: 869, column: 9, scope: !2148)
!2148 = distinct !DILexicalBlock(scope: !2149, file: !193, line: 869, column: 9)
!2149 = distinct !DILexicalBlock(scope: !2136, file: !193, line: 869, column: 9)
!2150 = !DILocation(line: 869, column: 9, scope: !2149)
!2151 = !DILocation(line: 869, column: 9, scope: !2152)
!2152 = distinct !DILexicalBlock(scope: !2148, file: !193, line: 869, column: 9)
!2153 = !DILocation(line: 869, column: 9, scope: !2154)
!2154 = distinct !DILexicalBlock(scope: !2155, file: !193, line: 869, column: 9)
!2155 = distinct !DILexicalBlock(scope: !2152, file: !193, line: 869, column: 9)
!2156 = !DILocation(line: 869, column: 9, scope: !2155)
!2157 = !{!"idx needs to be a valid subvector index"}
!2158 = !DILocation(line: 869, column: 9, scope: !2159)
!2159 = distinct !DILexicalBlock(scope: !2148, file: !193, line: 869, column: 9)
!2160 = !DILocation(line: 871, column: 41, scope: !2136)
!2161 = !DILocation(line: 871, column: 16, scope: !2136)
!2162 = !DILocation(line: 871, column: 9, scope: !2136)
!2163 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE", scope: !188, file: !189, line: 87, type: !260, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !259, retainedNodes: !2164)
!2164 = !{!2165, !2166}
!2165 = !DILocalVariable(name: "this", arg: 1, scope: !2163, type: !1856, flags: DIFlagArtificial | DIFlagObjectPointer)
!2166 = !DILocalVariable(name: "v", arg: 2, scope: !2163, file: !189, line: 87, type: !263)
!2167 = !DILocation(line: 0, scope: !2163)
!2168 = !DILocation(line: 87, column: 29, scope: !2163)
!2169 = !DILocation(line: 87, column: 44, scope: !2163)
!2170 = !DILocation(line: 87, column: 34, scope: !2163)
!2171 = !{!1706, !1706, i64 0, i64 32}
!2172 = !DILocation(line: 87, column: 48, scope: !2163)
!2173 = distinct !DISubprogram(name: "extract_helper<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj", scope: !745, file: !193, line: 1280, type: !2137, scopeLine: 1281, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2175, declaration: !2174, retainedNodes: !2176)
!2174 = !DISubprogram(name: "extract_helper<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj", scope: !745, file: !193, line: 1280, type: !2137, scopeLine: 1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2175)
!2175 = !{!353}
!2176 = !{!2177, !2178, !2179}
!2177 = !DILocalVariable(name: "this", arg: 1, scope: !2173, type: !2142, flags: DIFlagArtificial | DIFlagObjectPointer)
!2178 = !DILocalVariable(name: "idx", arg: 2, scope: !2173, file: !193, line: 1280, type: !15)
!2179 = !DILocalVariable(name: "output_bits", scope: !2173, file: !193, line: 1282, type: !101)
!2180 = !DILocation(line: 0, scope: !2173)
!2181 = !DILocation(line: 1280, column: 56, scope: !2173)
!2182 = !DILocation(line: 1282, column: 9, scope: !2173)
!2183 = !DILocation(line: 1282, column: 28, scope: !2173)
!2184 = !DILocation(line: 1315, column: 46, scope: !2185)
!2185 = distinct !DILexicalBlock(scope: !2186, file: !193, line: 1314, column: 51)
!2186 = distinct !DILexicalBlock(scope: !2187, file: !193, line: 1314, column: 31)
!2187 = distinct !DILexicalBlock(scope: !2188, file: !193, line: 1313, column: 47)
!2188 = distinct !DILexicalBlock(scope: !2189, file: !193, line: 1313, column: 32)
!2189 = distinct !DILexicalBlock(scope: !2190, file: !193, line: 1291, column: 27)
!2190 = distinct !DILexicalBlock(scope: !2191, file: !193, line: 1290, column: 14)
!2191 = distinct !DILexicalBlock(scope: !2173, file: !193, line: 1287, column: 23)
!2192 = !DILocation(line: 1315, column: 52, scope: !2185)
!2193 = !DILocation(line: 1315, column: 28, scope: !2185)
!2194 = !{!1707, !1707, i64 0, i64 32}
!2195 = !DILocation(line: 1328, column: 5, scope: !2173)
!2196 = distinct !DISubprogram(name: "vector_extract<8U, v16float>", linkageName: "_ZN3aie6detailL14vector_extractILj8E8v16floatEEDaRKT0_j", scope: !7, file: !193, line: 99, type: !2197, scopeLine: 99, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2204, retainedNodes: !2201)
!2197 = !DISubroutineType(types: !2198)
!2198 = !{!211, !2199, !15}
!2199 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2200, size: 32)
!2200 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !486)
!2201 = !{!2202, !2203}
!2202 = !DILocalVariable(name: "v", arg: 1, scope: !2196, file: !193, line: 99, type: !2199)
!2203 = !DILocalVariable(name: "idx", arg: 2, scope: !2196, file: !193, line: 99, type: !15)
!2204 = !{!210, !2205}
!2205 = !DITemplateTypeParameter(name: "T", type: !487)
!2206 = !DILocation(line: 99, column: 70, scope: !2196)
!2207 = !DILocation(line: 99, column: 82, scope: !2196)
!2208 = !DILocation(line: 99, column: 114, scope: !2196)
!2209 = !DILocation(line: 99, column: 117, scope: !2196)
!2210 = !DILocation(line: 99, column: 96, scope: !2196)
!2211 = !DILocation(line: 99, column: 89, scope: !2196)
!2212 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float", scope: !192, file: !193, line: 408, type: !230, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !229, retainedNodes: !2213)
!2213 = !{!2214, !2215}
!2214 = !DILocalVariable(name: "this", arg: 1, scope: !2212, type: !2029, flags: DIFlagArtificial | DIFlagObjectPointer)
!2215 = !DILocalVariable(name: "data", arg: 2, scope: !2212, file: !193, line: 408, type: !232)
!2216 = !DILocation(line: 0, scope: !2212)
!2217 = !DILocation(line: 408, column: 27, scope: !2212)
!2218 = !DILocation(line: 409, column: 9, scope: !2212)
!2219 = !DILocation(line: 409, column: 14, scope: !2212)
!2220 = !DILocation(line: 412, column: 5, scope: !2212)
!2221 = distinct !DISubprogram(name: "readincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE", scope: !906, file: !907, line: 215, type: !930, scopeLine: 216, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !929, retainedNodes: !2222)
!2222 = !{!2223, !2224, !2225, !2226, !2230}
!2223 = !DILocalVariable(name: "_w", arg: 1, scope: !2221, file: !907, line: 215, type: !124)
!2224 = !DILocalVariable(name: "w", scope: !2221, file: !907, line: 217, type: !124)
!2225 = !DILocalVariable(name: "ret", scope: !2221, file: !907, line: 218, type: !920)
!2226 = !DILocalVariable(name: "i", scope: !2227, file: !907, line: 230, type: !15)
!2227 = distinct !DILexicalBlock(scope: !2228, file: !907, line: 230, column: 13)
!2228 = distinct !DILexicalBlock(scope: !2229, file: !907, line: 228, column: 9)
!2229 = distinct !DILexicalBlock(scope: !2221, file: !907, line: 221, column: 23)
!2230 = !DILocalVariable(name: "tmp", scope: !2231, file: !907, line: 256, type: !559)
!2231 = distinct !DILexicalBlock(scope: !2232, file: !907, line: 255, column: 63)
!2232 = distinct !DILexicalBlock(scope: !2233, file: !907, line: 255, column: 36)
!2233 = distinct !DILexicalBlock(scope: !2234, file: !907, line: 247, column: 41)
!2234 = distinct !DILexicalBlock(scope: !2235, file: !907, line: 239, column: 36)
!2235 = distinct !DILexicalBlock(scope: !2236, file: !907, line: 230, column: 52)
!2236 = distinct !DILexicalBlock(scope: !2227, file: !907, line: 230, column: 13)
!2237 = !DILocation(line: 215, column: 51, scope: !2221)
!2238 = !DILocation(line: 217, column: 9, scope: !2221)
!2239 = !DILocation(line: 217, column: 36, scope: !2221)
!2240 = !DILocation(line: 217, column: 70, scope: !2221)
!2241 = !DILocation(line: 218, column: 14, scope: !2221)
!2242 = !DILocation(line: 230, column: 18, scope: !2227)
!2243 = !DILocation(line: 230, column: 27, scope: !2227)
!2244 = !DILocation(line: 230, column: 34, scope: !2236)
!2245 = !DILocation(line: 230, column: 36, scope: !2236)
!2246 = !DILocation(line: 230, column: 13, scope: !2227)
!2247 = !DILocation(line: 230, column: 13, scope: !2236)
!2248 = !DILocation(line: 256, column: 21, scope: !2231)
!2249 = !DILocation(line: 256, column: 54, scope: !2231)
!2250 = !DILocation(line: 256, column: 73, scope: !2231)
!2251 = !DILocation(line: 256, column: 60, scope: !2231)
!2252 = !{!2253, !2253, i64 0, i64 64}
!2253 = !{!1544, i64 64, !"v16acc32"}
!2254 = !{!2255, !2255, i64 0, i64 64}
!2255 = !{!1544, i64 64, !"_ZTSN3aie5accumI8accfloatLj16EEE", !2256, i64 0, i64 64}
!2256 = !{!1544, i64 64, !"_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEE", !2253, i64 0, i64 64}
!2257 = !DILocation(line: 259, column: 48, scope: !2258)
!2258 = distinct !DILexicalBlock(scope: !2231, file: !907, line: 258, column: 35)
!2259 = !DILocation(line: 259, column: 51, scope: !2258)
!2260 = !DILocation(line: 259, column: 64, scope: !2258)
!2261 = !DILocation(line: 259, column: 38, scope: !2258)
!2262 = !DILocation(line: 259, column: 25, scope: !2258)
!2263 = !DILocation(line: 262, column: 17, scope: !2232)
!2264 = !DILocation(line: 264, column: 13, scope: !2235)
!2265 = !DILocation(line: 230, column: 47, scope: !2236)
!2266 = distinct !{!2266, !2246, !2267, !1768, !2268}
!2267 = !DILocation(line: 264, column: 13, scope: !2227)
!2268 = !{!"llvm.loop.unroll.enable"}
!2269 = !DILocation(line: 268, column: 5, scope: !2221)
!2270 = distinct !DISubprogram(name: "readincr_v16", linkageName: "_ZL12readincr_v16P13input_cascadeI8accfloatvE", scope: !2271, file: !2271, line: 957, type: !2272, scopeLine: 957, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2274)
!2271 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/stream/me/accessors.h", directory: "")
!2272 = !DISubroutineType(types: !2273)
!2273 = !{!488, !124}
!2274 = !{!2275}
!2275 = !DILocalVariable(name: "str", arg: 1, scope: !2270, file: !2271, line: 957, type: !124)
!2276 = !DILocation(line: 957, column: 1, scope: !2270)
!2277 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat", scope: !494, file: !375, line: 188, type: !561, scopeLine: 190, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !560, retainedNodes: !2278)
!2278 = !{!2279, !2281}
!2279 = !DILocalVariable(name: "this", arg: 1, scope: !2277, type: !2280, flags: DIFlagArtificial | DIFlagObjectPointer)
!2280 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !494, size: 32)
!2281 = !DILocalVariable(name: "data", arg: 2, scope: !2277, file: !375, line: 188, type: !563)
!2282 = !DILocation(line: 0, scope: !2277)
!2283 = !DILocation(line: 188, column: 21, scope: !2277)
!2284 = !DILocation(line: 189, column: 9, scope: !2277)
!2285 = !DILocation(line: 192, column: 5, scope: !2277)
!2286 = distinct !DISubprogram(name: "insert<8U, accfloat>", linkageName: "_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE", scope: !374, file: !375, line: 334, type: !2287, scopeLine: 335, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2291, declaration: !2290, retainedNodes: !2294)
!2287 = !DISubroutineType(types: !2288)
!2288 = !{!2289, !427, !15, !447}
!2289 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !374, size: 32)
!2290 = !DISubprogram(name: "insert<8U, accfloat>", linkageName: "_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE", scope: !374, file: !375, line: 334, type: !2287, scopeLine: 334, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2291)
!2291 = !{!2292, !2293}
!2292 = !DITemplateValueParameter(name: "ElemsIn", type: !15, value: i32 8)
!2293 = !DITemplateTypeParameter(name: "Tag2", type: !459)
!2294 = !{!2295, !2296, !2297}
!2295 = !DILocalVariable(name: "this", arg: 1, scope: !2286, type: !1863, flags: DIFlagArtificial | DIFlagObjectPointer)
!2296 = !DILocalVariable(name: "idx", arg: 2, scope: !2286, file: !375, line: 334, type: !15)
!2297 = !DILocalVariable(name: "acc", arg: 3, scope: !2286, file: !375, line: 334, type: !447)
!2298 = !DILocation(line: 0, scope: !2286)
!2299 = !DILocation(line: 334, column: 28, scope: !2286)
!2300 = !DILocation(line: 334, column: 61, scope: !2286)
!2301 = !DILocation(line: 337, column: 27, scope: !2286)
!2302 = !DILocation(line: 337, column: 63, scope: !2286)
!2303 = !DILocation(line: 337, column: 20, scope: !2286)
!2304 = !DILocation(line: 338, column: 9, scope: !2286)
!2305 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj", scope: !494, file: !375, line: 286, type: !2306, scopeLine: 287, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2106, declaration: !2308, retainedNodes: !2309)
!2306 = !DISubroutineType(types: !2307)
!2307 = !{!374, !567, !15}
!2308 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj", scope: !494, file: !375, line: 286, type: !2306, scopeLine: 286, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2106)
!2309 = !{!2310, !2312}
!2310 = !DILocalVariable(name: "this", arg: 1, scope: !2305, type: !2311, flags: DIFlagArtificial | DIFlagObjectPointer)
!2311 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !559, size: 32)
!2312 = !DILocalVariable(name: "idx", arg: 2, scope: !2305, file: !375, line: 286, type: !15)
!2313 = !DILocation(line: 0, scope: !2305)
!2314 = !DILocation(line: 286, column: 51, scope: !2305)
!2315 = !DILocation(line: 288, column: 45, scope: !2305)
!2316 = !DILocation(line: 288, column: 83, scope: !2305)
!2317 = !DILocation(line: 288, column: 65, scope: !2305)
!2318 = !DILocation(line: 288, column: 16, scope: !2305)
!2319 = !DILocation(line: 288, column: 9, scope: !2305)
!2320 = !{i32 1}
!2321 = !{!2322, !2322, i64 0, i64 4}
!2322 = !{!1544, i64 4, !"uint1_t"}
!2323 = distinct !DISubprogram(name: "insert<8U, 32U>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE", scope: !378, file: !379, line: 463, type: !2324, scopeLine: 464, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2329, declaration: !2328, retainedNodes: !2331)
!2324 = !DISubroutineType(types: !2325)
!2325 = !{!2326, !413, !15, !2327}
!2326 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !378, size: 32)
!2327 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !421, size: 32)
!2328 = !DISubprogram(name: "insert<8U, 32U>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE", scope: !378, file: !379, line: 463, type: !2324, scopeLine: 463, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2329)
!2329 = !{!2292, !2330}
!2330 = !DITemplateValueParameter(name: "Bits2", type: !15, value: i32 32)
!2331 = !{!2332, !2334, !2335, !2336, !2337}
!2332 = !DILocalVariable(name: "this", arg: 1, scope: !2323, type: !2333, flags: DIFlagArtificial | DIFlagObjectPointer)
!2333 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !378, size: 32)
!2334 = !DILocalVariable(name: "idx", arg: 2, scope: !2323, file: !379, line: 463, type: !15)
!2335 = !DILocalVariable(name: "acc", arg: 3, scope: !2323, file: !379, line: 463, type: !2327)
!2336 = !DILocalVariable(name: "in_num_subaccums", scope: !2323, file: !379, line: 468, type: !101)
!2337 = !DILocalVariable(name: "num_subaccums", scope: !2323, file: !379, line: 469, type: !101)
!2338 = !DILocation(line: 0, scope: !2323)
!2339 = !DILocation(line: 463, column: 33, scope: !2323)
!2340 = !DILocation(line: 463, column: 79, scope: !2323)
!2341 = !DILocation(line: 468, column: 9, scope: !2323)
!2342 = !DILocation(line: 468, column: 28, scope: !2323)
!2343 = !DILocation(line: 469, column: 9, scope: !2323)
!2344 = !DILocation(line: 469, column: 31, scope: !2323)
!2345 = !DILocation(line: 474, column: 20, scope: !2346)
!2346 = distinct !DILexicalBlock(scope: !2347, file: !379, line: 473, column: 41)
!2347 = distinct !DILexicalBlock(scope: !2323, file: !379, line: 473, column: 23)
!2348 = !DILocation(line: 474, column: 24, scope: !2346)
!2349 = !DILocation(line: 474, column: 13, scope: !2346)
!2350 = !DILocation(line: 474, column: 18, scope: !2346)
!2351 = !{!1721, !1721, i64 0, i64 32}
!2352 = !DILocation(line: 552, column: 5, scope: !2323)
!2353 = !DILocation(line: 476, column: 13, scope: !2346)
!2354 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj", scope: !497, file: !379, line: 367, type: !2355, scopeLine: 368, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2106, declaration: !2357, retainedNodes: !2358)
!2355 = !DISubroutineType(types: !2356)
!2356 = !{!378, !532, !15}
!2357 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj", scope: !497, file: !379, line: 367, type: !2355, scopeLine: 367, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2106)
!2358 = !{!2359, !2361, !2362, !2363, !2364, !2365, !2368, !2369, !2370}
!2359 = !DILocalVariable(name: "this", arg: 1, scope: !2354, type: !2360, flags: DIFlagArtificial | DIFlagObjectPointer)
!2360 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !533, size: 32)
!2361 = !DILocalVariable(name: "idx", arg: 2, scope: !2354, file: !379, line: 367, type: !15)
!2362 = !DILocalVariable(name: "fpacc_128b", scope: !2354, file: !379, line: 374, type: !198)
!2363 = !DILocalVariable(name: "num_subaccums", scope: !2354, file: !379, line: 380, type: !101)
!2364 = !DILocalVariable(name: "num_subaccums_out", scope: !2354, file: !379, line: 381, type: !101)
!2365 = !DILocalVariable(name: "elems_per_subaccum", scope: !2366, file: !379, line: 387, type: !101)
!2366 = distinct !DILexicalBlock(scope: !2367, file: !379, line: 386, column: 14)
!2367 = distinct !DILexicalBlock(scope: !2354, file: !379, line: 383, column: 23)
!2368 = !DILocalVariable(name: "out_elems_per_subaccum", scope: !2366, file: !379, line: 388, type: !101)
!2369 = !DILocalVariable(name: "ratio", scope: !2366, file: !379, line: 389, type: !101)
!2370 = !DILocalVariable(name: "ret", scope: !2366, file: !379, line: 391, type: !378)
!2371 = !DILocation(line: 0, scope: !2354)
!2372 = !DILocation(line: 367, column: 59, scope: !2354)
!2373 = !DILocation(line: 374, column: 9, scope: !2354)
!2374 = !DILocation(line: 374, column: 24, scope: !2354)
!2375 = !{!2376, !2376, i64 0, i64 1}
!2376 = !{!1544, i64 1, !"bool"}
!2377 = !DILocation(line: 380, column: 9, scope: !2354)
!2378 = !DILocation(line: 380, column: 28, scope: !2354)
!2379 = !DILocation(line: 381, column: 9, scope: !2354)
!2380 = !DILocation(line: 381, column: 28, scope: !2354)
!2381 = !DILocation(line: 387, column: 13, scope: !2366)
!2382 = !DILocation(line: 387, column: 32, scope: !2366)
!2383 = !DILocation(line: 388, column: 13, scope: !2366)
!2384 = !DILocation(line: 388, column: 32, scope: !2366)
!2385 = !DILocation(line: 389, column: 13, scope: !2366)
!2386 = !DILocation(line: 389, column: 32, scope: !2366)
!2387 = !DILocation(line: 391, column: 13, scope: !2366)
!2388 = !DILocation(line: 391, column: 50, scope: !2366)
!2389 = !DILocation(line: 411, column: 31, scope: !2390)
!2390 = distinct !DILexicalBlock(scope: !2391, file: !379, line: 410, column: 26)
!2391 = distinct !DILexicalBlock(scope: !2392, file: !379, line: 399, column: 35)
!2392 = distinct !DILexicalBlock(scope: !2393, file: !379, line: 398, column: 56)
!2393 = distinct !DILexicalBlock(scope: !2394, file: !379, line: 398, column: 36)
!2394 = distinct !DILexicalBlock(scope: !2395, file: !379, line: 394, column: 31)
!2395 = distinct !DILexicalBlock(scope: !2396, file: !379, line: 393, column: 51)
!2396 = distinct !DILexicalBlock(scope: !2366, file: !379, line: 393, column: 27)
!2397 = !DILocation(line: 411, column: 55, scope: !2390)
!2398 = !DILocation(line: 411, column: 61, scope: !2390)
!2399 = !DILocation(line: 411, column: 29, scope: !2390)
!2400 = !{!1720, !1720, i64 0, i64 32}
!2401 = !DILocation(line: 411, column: 25, scope: !2390)
!2402 = !DILocation(line: 414, column: 28, scope: !2392)
!2403 = !DILocation(line: 434, column: 9, scope: !2367)
!2404 = !DILocation(line: 435, column: 5, scope: !2354)
!2405 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE", scope: !374, file: !375, line: 59, type: !425, scopeLine: 59, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !424, retainedNodes: !2406)
!2406 = !{!2407, !2408}
!2407 = !DILocalVariable(name: "this", arg: 1, scope: !2405, type: !1863, flags: DIFlagArtificial | DIFlagObjectPointer)
!2408 = !DILocalVariable(name: "a", arg: 2, scope: !2405, file: !375, line: 59, type: !428)
!2409 = !DILocation(line: 0, scope: !2405)
!2410 = !DILocation(line: 59, column: 37, scope: !2405)
!2411 = !DILocation(line: 59, column: 52, scope: !2405)
!2412 = !DILocation(line: 59, column: 42, scope: !2405)
!2413 = !DILocation(line: 59, column: 56, scope: !2405)
!2414 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev", scope: !378, file: !379, line: 229, type: !411, scopeLine: 231, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !410, retainedNodes: !2415)
!2415 = !{!2416}
!2416 = !DILocalVariable(name: "this", arg: 1, scope: !2414, type: !2333, flags: DIFlagArtificial | DIFlagObjectPointer)
!2417 = !DILocation(line: 0, scope: !2414)
!2418 = !DILocation(line: 230, column: 9, scope: !2414)
!2419 = !DILocation(line: 230, column: 14, scope: !2414)
!2420 = !DILocation(line: 232, column: 5, scope: !2414)
!2421 = distinct !DISubprogram(name: "accum_extract<8U, v16accfloat>", linkageName: "_ZN3aie6detailL13accum_extractILj8E11v16accfloatEEDaRKT0_j", scope: !7, file: !379, line: 123, type: !2422, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2429, retainedNodes: !2426)
!2422 = !DISubroutineType(types: !2423)
!2423 = !{!396, !2424, !15}
!2424 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2425, size: 32)
!2425 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !488)
!2426 = !{!2427, !2428}
!2427 = !DILocalVariable(name: "acc", arg: 1, scope: !2421, file: !379, line: 123, type: !2424)
!2428 = !DILocalVariable(name: "idx", arg: 2, scope: !2421, file: !379, line: 123, type: !15)
!2429 = !{!210, !2430}
!2430 = !DITemplateTypeParameter(name: "T", type: !489)
!2431 = !DILocation(line: 123, column: 88, scope: !2421)
!2432 = !DILocation(line: 123, column: 102, scope: !2421)
!2433 = !DILocation(line: 123, column: 137, scope: !2421)
!2434 = !DILocation(line: 123, column: 142, scope: !2421)
!2435 = !DILocation(line: 123, column: 116, scope: !2421)
!2436 = !DILocation(line: 123, column: 109, scope: !2421)
!2437 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat", scope: !378, file: !379, line: 242, type: !415, scopeLine: 244, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !414, retainedNodes: !2438)
!2438 = !{!2439, !2440}
!2439 = !DILocalVariable(name: "this", arg: 1, scope: !2437, type: !2333, flags: DIFlagArtificial | DIFlagObjectPointer)
!2440 = !DILocalVariable(name: "data", arg: 2, scope: !2437, file: !379, line: 242, type: !384)
!2441 = !DILocation(line: 0, scope: !2437)
!2442 = !DILocation(line: 242, column: 26, scope: !2437)
!2443 = !DILocation(line: 243, column: 9, scope: !2437)
!2444 = !DILocation(line: 243, column: 14, scope: !2437)
!2445 = !DILocation(line: 246, column: 5, scope: !2437)
!2446 = distinct !DISubprogram(name: "mac<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>, aie::vector_elem_ref<float, 8U>, aie::vector<float, 8U> >", linkageName: "_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_", scope: !8, file: !1502, line: 4866, type: !2447, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2463, retainedNodes: !2459)
!2447 = !DISubroutineType(types: !2448)
!2448 = !{!2449, !2458, !322, !1889}
!2449 = !DIDerivedType(tag: DW_TAG_typedef, name: "operand_base_type_t<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1> >", scope: !8, file: !1080, line: 410, baseType: !2450)
!2450 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2451, file: !1502, line: 112, baseType: !2454)
!2451 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "operand_base_type<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1> >", scope: !8, file: !1502, line: 110, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2452, identifier: "_ZTSN3aie17operand_base_typeINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEEEE")
!2452 = !{!2453}
!2453 = !DITemplateTypeParameter(name: "T", type: !1027)
!2454 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !1027, file: !45, line: 459, baseType: !2455)
!2455 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_value_type_t<result_type>", scope: !8, file: !45, line: 355, baseType: !2456)
!2456 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2457, file: !45, line: 242, baseType: !374)
!2457 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_value_type_helper<aie::accum<accfloat, 8U> >", scope: !8, file: !45, line: 240, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !945, identifier: "_ZTSN3aie20op_value_type_helperINS_5accumI8accfloatLj8EEEEE")
!2458 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1039, size: 32)
!2459 = !{!2460, !2461, !2462}
!2460 = !DILocalVariable(name: "acc", arg: 1, scope: !2446, file: !1502, line: 4866, type: !2458)
!2461 = !DILocalVariable(name: "a", arg: 2, scope: !2446, file: !1502, line: 4866, type: !322)
!2462 = !DILocalVariable(name: "v", arg: 3, scope: !2446, file: !1502, line: 4866, type: !1889)
!2463 = !{!2464, !1896, !1897}
!2464 = !DITemplateTypeParameter(name: "Acc", type: !1027)
!2465 = !DILocation(line: 4866, column: 31, scope: !2446)
!2466 = !DILocation(line: 4866, column: 38, scope: !2446)
!2467 = !DILocation(line: 4866, column: 52, scope: !2446)
!2468 = !DILocation(line: 4875, column: 20, scope: !2469)
!2469 = distinct !DILexicalBlock(scope: !2470, file: !1502, line: 4874, column: 37)
!2470 = distinct !DILexicalBlock(scope: !2471, file: !1502, line: 4874, column: 24)
!2471 = distinct !DILexicalBlock(scope: !2472, file: !1502, line: 4871, column: 24)
!2472 = distinct !DILexicalBlock(scope: !2446, file: !1502, line: 4868, column: 24)
!2473 = !DILocation(line: 4875, column: 25, scope: !2469)
!2474 = !DILocation(line: 4875, column: 37, scope: !2469)
!2475 = !DILocation(line: 4875, column: 16, scope: !2469)
!2476 = !{!2477, !2477, i64 0, i64 8}
!2477 = !{!1544, i64 8, !"_ZTSN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE", !2478, i64 0, i64 8}
!2478 = !{!1544, i64 8, !"_ZTSN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE", !1816, i64 0, i64 8}
!2479 = !DILocation(line: 4875, column: 9, scope: !2469)
!2480 = distinct !DISubprogram(name: "op_add<aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_", scope: !8, file: !1502, line: 380, type: !2481, scopeLine: 381, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2485, retainedNodes: !2483)
!2481 = !DISubroutineType(types: !2482)
!2482 = !{!1027, !447}
!2483 = !{!2484}
!2484 = !DILocalVariable(name: "acc", arg: 1, scope: !2480, file: !1502, line: 380, type: !447)
!2485 = !{!1895}
!2486 = !DILocation(line: 380, column: 63, scope: !2480)
!2487 = !DILocation(line: 382, column: 13, scope: !2480)
!2488 = !DILocation(line: 382, column: 12, scope: !2480)
!2489 = !DILocation(line: 382, column: 5, scope: !2480)
!2490 = distinct !DISubprogram(name: "mac<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>, aie::unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>, aie::vector<float, 8U> >", linkageName: "_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_", scope: !8, file: !1502, line: 4866, type: !2491, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2497, retainedNodes: !2493)
!2491 = !DISubroutineType(types: !2492)
!2492 = !{!2449, !2458, !1014, !1889}
!2493 = !{!2494, !2495, !2496}
!2494 = !DILocalVariable(name: "acc", arg: 1, scope: !2490, file: !1502, line: 4866, type: !2458)
!2495 = !DILocalVariable(name: "a", arg: 2, scope: !2490, file: !1502, line: 4866, type: !1014)
!2496 = !DILocalVariable(name: "v", arg: 3, scope: !2490, file: !1502, line: 4866, type: !1889)
!2497 = !{!2464, !2498, !1897}
!2498 = !DITemplateTypeParameter(name: "E", type: !1014)
!2499 = !DILocation(line: 4866, column: 31, scope: !2490)
!2500 = !DILocation(line: 4866, column: 38, scope: !2490)
!2501 = !DILocation(line: 4866, column: 52, scope: !2490)
!2502 = !DILocation(line: 4878, column: 20, scope: !2503)
!2503 = distinct !DILexicalBlock(scope: !2504, file: !1502, line: 4877, column: 39)
!2504 = distinct !DILexicalBlock(scope: !2505, file: !1502, line: 4877, column: 24)
!2505 = distinct !DILexicalBlock(scope: !2506, file: !1502, line: 4874, column: 24)
!2506 = distinct !DILexicalBlock(scope: !2507, file: !1502, line: 4871, column: 24)
!2507 = distinct !DILexicalBlock(scope: !2490, file: !1502, line: 4868, column: 24)
!2508 = !DILocation(line: 4878, column: 25, scope: !2503)
!2509 = !DILocation(line: 4878, column: 28, scope: !2503)
!2510 = !DILocation(line: 4878, column: 36, scope: !2503)
!2511 = !DILocation(line: 4878, column: 16, scope: !2503)
!2512 = !DILocation(line: 4878, column: 9, scope: !2503)
!2513 = distinct !DISubprogram(name: "op_none<aie::vector_elem_ref<float, 8U> >", linkageName: "_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_", scope: !8, file: !1502, line: 409, type: !2514, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !967, retainedNodes: !2516)
!2514 = !DISubroutineType(types: !2515)
!2515 = !{!1014, !320}
!2516 = !{!2517}
!2517 = !DILocalVariable(name: "e", arg: 1, scope: !2513, file: !1502, line: 409, type: !320)
!2518 = !DILocation(line: 409, column: 57, scope: !2513)
!2519 = !DILocation(line: 411, column: 13, scope: !2513)
!2520 = !DILocation(line: 411, column: 12, scope: !2513)
!2521 = !DILocation(line: 411, column: 5, scope: !2513)
!2522 = distinct !DISubprogram(name: "mac<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>, aie::unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>, aie::unary_op<aie::vector<float, 8U>, (aie::Operation)0> >", linkageName: "_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_", scope: !8, file: !1502, line: 4866, type: !2523, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2542, retainedNodes: !2526)
!2523 = !DISubroutineType(types: !2524)
!2524 = !{!2449, !2458, !1014, !2525}
!2525 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1013, size: 32)
!2526 = !{!2527, !2528, !2529, !2530, !2541}
!2527 = !DILocalVariable(name: "acc", arg: 1, scope: !2522, file: !1502, line: 4866, type: !2458)
!2528 = !DILocalVariable(name: "a", arg: 2, scope: !2522, file: !1502, line: 4866, type: !1014)
!2529 = !DILocalVariable(name: "v", arg: 3, scope: !2522, file: !1502, line: 4866, type: !2525)
!2530 = !DILocalVariable(name: "Op1", scope: !2531, file: !1502, line: 4902, type: !937)
!2531 = distinct !DILexicalBlock(scope: !2532, file: !1502, line: 4901, column: 14)
!2532 = distinct !DILexicalBlock(scope: !2533, file: !1502, line: 4898, column: 28)
!2533 = distinct !DILexicalBlock(scope: !2534, file: !1502, line: 4896, column: 28)
!2534 = distinct !DILexicalBlock(scope: !2535, file: !1502, line: 4894, column: 28)
!2535 = distinct !DILexicalBlock(scope: !2536, file: !1502, line: 4892, column: 28)
!2536 = distinct !DILexicalBlock(scope: !2537, file: !1502, line: 4880, column: 10)
!2537 = distinct !DILexicalBlock(scope: !2538, file: !1502, line: 4877, column: 24)
!2538 = distinct !DILexicalBlock(scope: !2539, file: !1502, line: 4874, column: 24)
!2539 = distinct !DILexicalBlock(scope: !2540, file: !1502, line: 4871, column: 24)
!2540 = distinct !DILexicalBlock(scope: !2522, file: !1502, line: 4868, column: 24)
!2541 = !DILocalVariable(name: "Op2", scope: !2531, file: !1502, line: 4903, type: !937)
!2542 = !{!2464, !2498, !2543}
!2543 = !DITemplateTypeParameter(name: "Vec", type: !1001)
!2544 = !DILocation(line: 4866, column: 31, scope: !2522)
!2545 = !DILocation(line: 4866, column: 38, scope: !2522)
!2546 = !DILocation(line: 4866, column: 52, scope: !2522)
!2547 = !DILocation(line: 4902, column: 13, scope: !2531)
!2548 = !DILocation(line: 4902, column: 33, scope: !2531)
!2549 = !{!2550, !2550, i64 0, i64 4}
!2550 = !{!1544, i64 4, !"_ZTSN3aie9OperationE"}
!2551 = !DILocation(line: 4903, column: 13, scope: !2531)
!2552 = !DILocation(line: 4903, column: 33, scope: !2531)
!2553 = !DILocation(line: 4906, column: 156, scope: !2554)
!2554 = distinct !DILexicalBlock(scope: !2531, file: !1502, line: 4905, column: 27)
!2555 = !DILocation(line: 4906, column: 158, scope: !2554)
!2556 = !DILocation(line: 4906, column: 134, scope: !2554)
!2557 = !DILocation(line: 4906, column: 191, scope: !2554)
!2558 = !DILocation(line: 4906, column: 170, scope: !2554)
!2559 = !DILocation(line: 4906, column: 195, scope: !2554)
!2560 = !DILocation(line: 4906, column: 197, scope: !2554)
!2561 = !DILocation(line: 4906, column: 229, scope: !2554)
!2562 = !{!2563, !2563, i64 0, i64 32}
!2563 = !{!1544, i64 32, !"_ZTSN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEE", !2564, i64 0, i64 32}
!2564 = !{!1544, i64 32, !"_ZTSN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEE", !1705, i64 0, i64 32}
!2565 = !DILocation(line: 4906, column: 208, scope: !2554)
!2566 = !DILocation(line: 4906, column: 233, scope: !2554)
!2567 = !DILocation(line: 4906, column: 237, scope: !2554)
!2568 = !DILocation(line: 4906, column: 24, scope: !2554)
!2569 = !{!2570, !2570, i64 0, i64 8}
!2570 = !{!1544, i64 8, !"_ZTSN3aie21vector_elem_const_refIfLj8EEE", !1543, i64 0, i64 4, !1756, i64 4, i64 4}
!2571 = !DILocation(line: 4906, column: 17, scope: !2554)
!2572 = !DILocation(line: 4909, column: 9, scope: !2532)
!2573 = !DILocation(line: 4911, column: 1, scope: !2522)
!2574 = distinct !DISubprogram(name: "op_none<aie::vector<float, 8U> >", linkageName: "_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_", scope: !8, file: !1502, line: 409, type: !2575, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !989, retainedNodes: !2577)
!2575 = !DISubroutineType(types: !2576)
!2576 = !{!1001, !1889}
!2577 = !{!2578}
!2578 = !DILocalVariable(name: "e", arg: 1, scope: !2574, file: !1502, line: 409, type: !1889)
!2579 = !DILocation(line: 409, column: 57, scope: !2574)
!2580 = !DILocation(line: 411, column: 13, scope: !2574)
!2581 = !DILocation(line: 411, column: 12, scope: !2574)
!2582 = !DILocation(line: 411, column: 5, scope: !2574)
!2583 = distinct !DISubprogram(name: "run<8U, 8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_", scope: !2584, file: !58, line: 792, type: !2592, scopeLine: 793, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2601, declaration: !2600, retainedNodes: !2606)
!2584 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "mul_bits<(aie::detail::MulMacroOp)2, 32U, 32U, float, 32U, float>", scope: !7, file: !58, line: 776, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2585, identifier: "_ZTSN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfEE")
!2585 = !{!2586, !2587, !2588, !2589, !2590, !2591}
!2586 = !DITemplateValueParameter(name: "MulOp", type: !57, value: i32 2)
!2587 = !DITemplateValueParameter(name: "AccumBits", type: !15, value: i32 32)
!2588 = !DITemplateValueParameter(name: "Type1Bits", type: !15, value: i32 32)
!2589 = !DITemplateTypeParameter(name: "T1", type: !80)
!2590 = !DITemplateValueParameter(name: "Type2Bits", type: !15, value: i32 32)
!2591 = !DITemplateTypeParameter(name: "T2", type: !80)
!2592 = !DISubroutineType(types: !2593)
!2593 = !{!2594, !308, !176, !2597, !176, !447}
!2594 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_type<8U>", scope: !2596, file: !2595, line: 80, baseType: !374)
!2595 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp", directory: "")
!2596 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "mul_bits_impl<(aie::detail::MulMacroOp)2, 32U, 32U, float, 32U, float>", scope: !7, file: !2595, line: 73, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2585, identifier: "_ZTSN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfEE")
!2597 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2598, size: 32)
!2598 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2599)
!2599 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type2<8U>", scope: !2584, file: !58, line: 781, baseType: !188)
!2600 = !DISubprogram(name: "run<8U, 8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_", scope: !2584, file: !58, line: 792, type: !2592, scopeLine: 792, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2601)
!2601 = !{!210, !2602, !2603}
!2602 = !DITemplateValueParameter(name: "Elems2", type: !15, value: i32 8)
!2603 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "Acc", value: !2604)
!2604 = !{!2605}
!2605 = !DITemplateTypeParameter(type: !374)
!2606 = !{!2607, !2608, !2609, !2610, !2611}
!2607 = !DILocalVariable(name: "a", arg: 1, scope: !2583, file: !58, line: 792, type: !308)
!2608 = !DILocalVariable(name: "a_sign", arg: 2, scope: !2583, file: !58, line: 792, type: !176)
!2609 = !DILocalVariable(name: "v", arg: 3, scope: !2583, file: !58, line: 792, type: !2597)
!2610 = !DILocalVariable(name: "v_sign", arg: 4, scope: !2583, file: !58, line: 792, type: !176)
!2611 = !DILocalVariable(name: "acc", arg: 5, scope: !2583, file: !58, line: 792, type: !447)
!2612 = !DILocation(line: 792, column: 54, scope: !2583)
!2613 = !DILocation(line: 792, column: 62, scope: !2583)
!2614 = !DILocation(line: 792, column: 98, scope: !2583)
!2615 = !DILocation(line: 792, column: 106, scope: !2583)
!2616 = !DILocation(line: 792, column: 129, scope: !2583)
!2617 = !DILocation(line: 794, column: 83, scope: !2583)
!2618 = !DILocation(line: 794, column: 86, scope: !2583)
!2619 = !{i8 0, i8 2}
!2620 = !DILocation(line: 794, column: 94, scope: !2583)
!2621 = !DILocation(line: 794, column: 97, scope: !2583)
!2622 = !DILocation(line: 794, column: 105, scope: !2583)
!2623 = !DILocation(line: 794, column: 16, scope: !2583)
!2624 = !DILocation(line: 794, column: 9, scope: !2583)
!2625 = distinct !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !958, file: !45, line: 413, type: !2626, scopeLine: 414, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2630, retainedNodes: !2631)
!2626 = !DISubroutineType(types: !2627)
!2627 = !{!963, !2628}
!2628 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2629, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2629 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !958)
!2630 = !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !958, file: !45, line: 413, type: !2626, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2631 = !{!2632}
!2632 = !DILocalVariable(name: "this", arg: 1, scope: !2625, type: !2633, flags: DIFlagArtificial | DIFlagObjectPointer)
!2633 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2629, size: 32)
!2634 = !DILocation(line: 0, scope: !2625)
!2635 = !DILocation(line: 418, column: 20, scope: !2636)
!2636 = distinct !DILexicalBlock(scope: !2625, file: !45, line: 415, column: 22)
!2637 = distinct !DISubprogram(name: "vector_elem_const_ref", linkageName: "_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE", scope: !308, file: !309, line: 35, type: !317, scopeLine: 38, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !316, retainedNodes: !2638)
!2638 = !{!2639, !2641}
!2639 = !DILocalVariable(name: "this", arg: 1, scope: !2637, type: !2640, flags: DIFlagArtificial | DIFlagObjectPointer)
!2640 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !308, size: 32)
!2641 = !DILocalVariable(name: "ref", arg: 2, scope: !2637, file: !309, line: 35, type: !320)
!2642 = !DILocation(line: 0, scope: !2637)
!2643 = !DILocation(line: 35, column: 66, scope: !2637)
!2644 = !DILocation(line: 36, column: 9, scope: !2637)
!2645 = !DILocation(line: 36, column: 16, scope: !2637)
!2646 = !DILocation(line: 36, column: 20, scope: !2637)
!2647 = !{!1816, !1543, i64 0, i64 4}
!2648 = !DILocation(line: 37, column: 9, scope: !2637)
!2649 = !DILocation(line: 37, column: 16, scope: !2637)
!2650 = !DILocation(line: 37, column: 20, scope: !2637)
!2651 = !{!1816, !1756, i64 4, i64 4}
!2652 = !{!2570, !1756, i64 4, i64 4}
!2653 = !DILocation(line: 39, column: 5, scope: !2637)
!2654 = distinct !DISubprogram(name: "get_mul_sign<aie::unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0> >", linkageName: "_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_", scope: !7, file: !58, line: 640, type: !2655, scopeLine: 641, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2659, retainedNodes: !2657)
!2655 = !DISubroutineType(types: !2656)
!2656 = !{!176, !1014}
!2657 = !{!2658}
!2658 = !DILocalVariable(name: "v", arg: 1, scope: !2654, file: !58, line: 640, type: !1014)
!2659 = !{!2660}
!2660 = !DITemplateTypeParameter(name: "T", type: !1014)
!2661 = !DILocation(line: 640, column: 31, scope: !2654)
!2662 = !DILocation(line: 645, column: 13, scope: !2663)
!2663 = distinct !DILexicalBlock(scope: !2654, file: !58, line: 642, column: 23)
!2664 = distinct !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !980, file: !45, line: 413, type: !2665, scopeLine: 414, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2669, retainedNodes: !2670)
!2665 = !DISubroutineType(types: !2666)
!2666 = !{!985, !2667}
!2667 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2668, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2668 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !980)
!2669 = !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !980, file: !45, line: 413, type: !2665, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2670 = !{!2671}
!2671 = !DILocalVariable(name: "this", arg: 1, scope: !2664, type: !2672, flags: DIFlagArtificial | DIFlagObjectPointer)
!2672 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2668, size: 32)
!2673 = !DILocation(line: 0, scope: !2664)
!2674 = !DILocation(line: 418, column: 20, scope: !2675)
!2675 = distinct !DILexicalBlock(scope: !2664, file: !45, line: 415, column: 22)
!2676 = distinct !DISubprogram(name: "get_mul_sign<aie::unary_op<aie::vector<float, 8U>, (aie::Operation)0> >", linkageName: "_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_", scope: !7, file: !58, line: 640, type: !2677, scopeLine: 641, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2681, retainedNodes: !2679)
!2677 = !DISubroutineType(types: !2678)
!2678 = !{!176, !1001}
!2679 = !{!2680}
!2680 = !DILocalVariable(name: "v", arg: 1, scope: !2676, file: !58, line: 640, type: !1001)
!2681 = !{!2682}
!2682 = !DITemplateTypeParameter(name: "T", type: !1001)
!2683 = !DILocation(line: 640, column: 31, scope: !2676)
!2684 = !DILocation(line: 645, column: 13, scope: !2685)
!2685 = distinct !DILexicalBlock(scope: !2676, file: !58, line: 642, column: 23)
!2686 = distinct !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev", scope: !934, file: !45, line: 413, type: !2687, scopeLine: 414, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2691, retainedNodes: !2692)
!2687 = !DISubroutineType(types: !2688)
!2688 = !{!940, !2689}
!2689 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2690, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2690 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !934)
!2691 = !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev", scope: !934, file: !45, line: 413, type: !2687, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2692 = !{!2693}
!2693 = !DILocalVariable(name: "this", arg: 1, scope: !2686, type: !2694, flags: DIFlagArtificial | DIFlagObjectPointer)
!2694 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2690, size: 32)
!2695 = !DILocation(line: 0, scope: !2686)
!2696 = !DILocation(line: 418, column: 20, scope: !2697)
!2697 = distinct !DILexicalBlock(scope: !2686, file: !45, line: 415, column: 22)
!2698 = distinct !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_", scope: !2596, file: !2595, line: 113, type: !2699, scopeLine: 114, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2706, declaration: !2705, retainedNodes: !2707)
!2699 = !DISubroutineType(types: !2700)
!2700 = !{!2594, !2701, !198, !2702, !198, !447}
!2701 = !DIDerivedType(tag: DW_TAG_typedef, name: "T", file: !2595, line: 75, baseType: !80)
!2702 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2703, size: 32)
!2703 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2704)
!2704 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type<8U>", scope: !2596, file: !2595, line: 78, baseType: !188)
!2705 = !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_", scope: !2596, file: !2595, line: 113, type: !2699, scopeLine: 113, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2706)
!2706 = !{!210, !2603}
!2707 = !{!2708, !2709, !2710, !2711, !2712}
!2708 = !DILocalVariable(name: "a", arg: 1, scope: !2698, file: !2595, line: 113, type: !2701)
!2709 = !DILocalVariable(name: "a_sign", arg: 2, scope: !2698, file: !2595, line: 113, type: !198)
!2710 = !DILocalVariable(name: "v", arg: 3, scope: !2698, file: !2595, line: 113, type: !2702)
!2711 = !DILocalVariable(name: "v_sign", arg: 4, scope: !2698, file: !2595, line: 113, type: !198)
!2712 = !DILocalVariable(name: "acc", arg: 5, scope: !2698, file: !2595, line: 113, type: !447)
!2713 = !{!2714, !2714, i64 0, i64 4}
!2714 = !{!1544, i64 4, !"float"}
!2715 = !DILocation(line: 113, column: 36, scope: !2698)
!2716 = !DILocation(line: 113, column: 50, scope: !2698)
!2717 = !DILocation(line: 113, column: 84, scope: !2698)
!2718 = !DILocation(line: 113, column: 98, scope: !2698)
!2719 = !DILocation(line: 113, column: 121, scope: !2698)
!2720 = !DILocation(line: 115, column: 20, scope: !2698)
!2721 = !DILocation(line: 115, column: 49, scope: !2698)
!2722 = !DILocation(line: 115, column: 57, scope: !2698)
!2723 = !DILocation(line: 115, column: 60, scope: !2698)
!2724 = !DILocation(line: 115, column: 68, scope: !2698)
!2725 = !DILocation(line: 115, column: 16, scope: !2698)
!2726 = !DILocation(line: 115, column: 9, scope: !2698)
!2727 = distinct !DISubprogram(name: "operator float", linkageName: "_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv", scope: !308, file: !309, line: 52, type: !355, scopeLine: 53, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !359, retainedNodes: !2728)
!2728 = !{!2729}
!2729 = !DILocalVariable(name: "this", arg: 1, scope: !2727, type: !2730, flags: DIFlagArtificial | DIFlagObjectPointer)
!2730 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !348, size: 32)
!2731 = !DILocation(line: 0, scope: !2727)
!2732 = !DILocation(line: 54, column: 16, scope: !2727)
!2733 = !DILocation(line: 54, column: 9, scope: !2727)
!2734 = distinct !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_", scope: !2596, file: !2595, line: 93, type: !2735, scopeLine: 94, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2706, declaration: !2737, retainedNodes: !2738)
!2735 = !DISubroutineType(types: !2736)
!2736 = !{!2594, !2702, !198, !2702, !198, !447}
!2737 = !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_", scope: !2596, file: !2595, line: 93, type: !2735, scopeLine: 93, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2706)
!2738 = !{!2739, !2740, !2741, !2742, !2743, !2744, !2747, !2748}
!2739 = !DILocalVariable(name: "v1", arg: 1, scope: !2734, file: !2595, line: 93, type: !2702)
!2740 = !DILocalVariable(name: "v1_sign", arg: 2, scope: !2734, file: !2595, line: 93, type: !198)
!2741 = !DILocalVariable(name: "v2", arg: 3, scope: !2734, file: !2595, line: 93, type: !2702)
!2742 = !DILocalVariable(name: "v2_sign", arg: 4, scope: !2734, file: !2595, line: 93, type: !198)
!2743 = !DILocalVariable(name: "acc", arg: 5, scope: !2734, file: !2595, line: 93, type: !447)
!2744 = !DILocalVariable(name: "mul_op", scope: !2734, file: !2595, line: 95, type: !2745)
!2745 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2746)
!2746 = distinct !DICompositeType(tag: DW_TAG_class_type, file: !2595, line: 87, size: 8, flags: DIFlagTypePassByValue, elements: !137, identifier: "_ZTSZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavEUlDpOT_E_")
!2747 = !DILocalVariable(name: "num_mul", scope: !2734, file: !2595, line: 97, type: !101)
!2748 = !DILocalVariable(name: "ret", scope: !2734, file: !2595, line: 99, type: !2594)
!2749 = !DILocation(line: 93, column: 60, scope: !2734)
!2750 = !DILocation(line: 93, column: 75, scope: !2734)
!2751 = !DILocation(line: 93, column: 110, scope: !2734)
!2752 = !DILocation(line: 93, column: 125, scope: !2734)
!2753 = !DILocation(line: 93, column: 149, scope: !2734)
!2754 = !DILocation(line: 95, column: 9, scope: !2734)
!2755 = !DILocation(line: 95, column: 24, scope: !2734)
!2756 = !DILocation(line: 97, column: 9, scope: !2734)
!2757 = !DILocation(line: 97, column: 28, scope: !2734)
!2758 = !DILocation(line: 99, column: 27, scope: !2734)
!2759 = !DILocation(line: 101, column: 38, scope: !2734)
!2760 = !DILocation(line: 101, column: 39, scope: !2734)
!2761 = !DILocation(line: 101, column: 9, scope: !2734)
!2762 = !DILocation(line: 109, column: 5, scope: !2734)
!2763 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf", scope: !2764, file: !2041, line: 63, type: !2767, scopeLine: 64, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2766, retainedNodes: !2771)
!2764 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "broadcast_bits<32U, float, 8U>", scope: !7, file: !2041, line: 59, size: 8, flags: DIFlagTypePassByValue, elements: !2765, templateParams: !2048, identifier: "_ZTSN3aie6detail14broadcast_bitsILj32EfLj8EEE")
!2765 = !{!2766}
!2766 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf", scope: !2764, file: !2041, line: 63, type: !2767, scopeLine: 63, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2767 = !DISubroutineType(types: !2768)
!2768 = !{!2769, !2770}
!2769 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2764, file: !2041, line: 61, baseType: !188)
!2770 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !153, size: 32)
!2771 = !{!2772}
!2772 = !DILocalVariable(name: "a", arg: 1, scope: !2763, file: !2041, line: 63, type: !2770)
!2773 = !DILocation(line: 63, column: 37, scope: !2763)
!2774 = !DILocation(line: 65, column: 61, scope: !2763)
!2775 = !DILocation(line: 65, column: 16, scope: !2763)
!2776 = !DILocation(line: 65, column: 9, scope: !2763)
!2777 = distinct !DISubprogram(name: "unroll_times<1U, (lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_", scope: !1501, file: !2778, line: 612, type: !2779, scopeLine: 613, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2793, retainedNodes: !2791)
!2778 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/utils.hpp", directory: "")
!2779 = !DISubroutineType(types: !2780)
!2780 = !{null, !2781}
!2781 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2782, size: 32)
!2782 = distinct !DICompositeType(tag: DW_TAG_class_type, scope: !2734, file: !2595, line: 101, size: 160, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !2783, identifier: "_ZTSZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_EUlT_E_")
!2783 = !{!2784, !2786, !2787, !2788, !2789}
!2784 = !DIDerivedType(tag: DW_TAG_member, name: "mul_op", scope: !2782, file: !2595, line: 102, baseType: !2785, size: 32)
!2785 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2745, size: 32)
!2786 = !DIDerivedType(tag: DW_TAG_member, name: "v1", scope: !2782, file: !2595, line: 102, baseType: !2702, size: 32, offset: 32)
!2787 = !DIDerivedType(tag: DW_TAG_member, name: "v2", scope: !2782, file: !2595, line: 103, baseType: !2702, size: 32, offset: 64)
!2788 = !DIDerivedType(tag: DW_TAG_member, name: "acc", scope: !2782, file: !2595, line: 104, baseType: !447, size: 32, offset: 96)
!2789 = !DIDerivedType(tag: DW_TAG_member, name: "ret", scope: !2782, file: !2595, line: 105, baseType: !2790, size: 32, offset: 128)
!2790 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2594, size: 32)
!2791 = !{!2792}
!2792 = !DILocalVariable(name: "fn", arg: 1, scope: !2777, file: !2778, line: 612, type: !2781)
!2793 = !{!2794, !2795}
!2794 = !DITemplateValueParameter(name: "Times", type: !15, value: i32 1)
!2795 = !DITemplateTypeParameter(name: "Fn", type: !2782)
!2796 = !DILocation(line: 612, column: 24, scope: !2777)
!2797 = !DILocation(line: 614, column: 56, scope: !2777)
!2798 = !DILocation(line: 614, column: 5, scope: !2777)
!2799 = !DILocation(line: 615, column: 1, scope: !2777)
!2800 = distinct !DISubprogram(name: "unroll_for<unsigned int, 0U, 1U, 1U, (lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_", scope: !1501, file: !2778, line: 590, type: !2779, scopeLine: 591, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2803, retainedNodes: !2801)
!2801 = !{!2802}
!2802 = !DILocalVariable(name: "fn", arg: 1, scope: !2800, file: !2778, line: 590, type: !2781)
!2803 = !{!2804, !2805, !2806, !2807, !2795}
!2804 = !DITemplateTypeParameter(name: "T", type: !15)
!2805 = !DITemplateValueParameter(name: "Start", type: !15, value: i32 0)
!2806 = !DITemplateValueParameter(name: "End", type: !15, value: i32 1)
!2807 = !DITemplateValueParameter(name: "Step", type: !15, value: i32 1)
!2808 = !DILocation(line: 590, column: 22, scope: !2800)
!2809 = !DILocation(line: 592, column: 77, scope: !2800)
!2810 = !DILocation(line: 592, column: 5, scope: !2800)
!2811 = !DILocation(line: 593, column: 1, scope: !2800)
!2812 = distinct !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2813, file: !2778, line: 495, type: !2779, scopeLine: 496, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2817, declaration: !2816, retainedNodes: !2818)
!2813 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unroll_for_helper<unsigned int, 0U, 1U, 0U, 1U>", scope: !1501, file: !2778, line: 489, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2814, identifier: "_ZTSN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EEE")
!2814 = !{!2804, !2805, !2806, !2815, !2807}
!2815 = !DITemplateValueParameter(name: "It", type: !15, value: i32 0)
!2816 = !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2813, file: !2778, line: 495, type: !2779, scopeLine: 495, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2817)
!2817 = !{!2795}
!2818 = !{!2819, !2820, !2834}
!2819 = !DILocalVariable(name: "fn", arg: 1, scope: !2812, file: !2778, line: 495, type: !2781)
!2820 = !DILocalVariable(name: "it", scope: !2821, file: !2778, line: 498, type: !2823)
!2821 = distinct !DILexicalBlock(scope: !2822, file: !2778, line: 497, column: 73)
!2822 = distinct !DILexicalBlock(scope: !2812, file: !2778, line: 497, column: 23)
!2823 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2824)
!2824 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iteration_dim<unsigned int, 0U, 1U, 0U>", scope: !1501, file: !2778, line: 465, size: 8, flags: DIFlagTypePassByValue, elements: !2825, templateParams: !2833, identifier: "_ZTSN3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEE")
!2825 = !{!2826, !2830, !2831, !2832}
!2826 = !DISubprogram(name: "operator unsigned int", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv", scope: !2824, file: !2778, line: 467, type: !2827, scopeLine: 467, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2827 = !DISubroutineType(types: !2828)
!2828 = !{!15, !2829}
!2829 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2823, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2830 = !DISubprogram(name: "min", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE3minEv", scope: !2824, file: !2778, line: 472, type: !2827, scopeLine: 472, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2831 = !DISubprogram(name: "max", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE3maxEv", scope: !2824, file: !2778, line: 477, type: !2827, scopeLine: 477, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2832 = !DISubprogram(name: "current", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv", scope: !2824, file: !2778, line: 482, type: !2827, scopeLine: 482, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2833 = !{!2804, !2805, !2806, !2815}
!2834 = !DILocalVariable(name: "next_it", scope: !2821, file: !2778, line: 511, type: !101)
!2835 = !DILocation(line: 495, column: 31, scope: !2812)
!2836 = !DILocation(line: 498, column: 13, scope: !2821)
!2837 = !DILocation(line: 498, column: 56, scope: !2821)
!2838 = !DILocation(line: 505, column: 17, scope: !2839)
!2839 = distinct !DILexicalBlock(scope: !2821, file: !2778, line: 504, column: 27)
!2840 = !DILocation(line: 511, column: 13, scope: !2821)
!2841 = !DILocation(line: 511, column: 25, scope: !2821)
!2842 = !DILocation(line: 517, column: 87, scope: !2821)
!2843 = !DILocation(line: 517, column: 13, scope: !2821)
!2844 = !DILocation(line: 518, column: 9, scope: !2822)
!2845 = !DILocation(line: 519, column: 5, scope: !2812)
!2846 = distinct !DISubprogram(name: "operator()<aie::detail::utils::iteration_dim<unsigned int, 0U, 1U, 0U> >", linkageName: "_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_", scope: !2782, file: !2595, line: 101, type: !2847, scopeLine: 101, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2852, declaration: !2851, retainedNodes: !2854)
!2847 = !DISubroutineType(types: !2848)
!2848 = !{null, !2849, !2824}
!2849 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2850, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2850 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2782)
!2851 = !DISubprogram(name: "operator()<aie::detail::utils::iteration_dim<unsigned int, 0U, 1U, 0U> >", scope: !2782, file: !2595, line: 101, type: !2847, scopeLine: 101, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2852)
!2852 = !{!2853}
!2853 = !DITemplateTypeParameter(name: "idx:auto", type: !2824)
!2854 = !{!2855, !2857, !2858}
!2855 = !DILocalVariable(name: "this", arg: 1, scope: !2846, type: !2856, flags: DIFlagArtificial | DIFlagObjectPointer)
!2856 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2850, size: 32)
!2857 = !DILocalVariable(name: "idx", arg: 2, scope: !2846, file: !2595, line: 101, type: !2824)
!2858 = !DILocalVariable(name: "tmp", scope: !2846, file: !2595, line: 102, type: !2859)
!2859 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2860)
!2860 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_type<16>", file: !2595, line: 80, baseType: !494)
!2861 = !DILocation(line: 0, scope: !2846)
!2862 = !DILocation(line: 101, column: 47, scope: !2846)
!2863 = !DILocation(line: 102, column: 13, scope: !2846)
!2864 = !DILocation(line: 102, column: 34, scope: !2846)
!2865 = !DILocation(line: 102, column: 40, scope: !2846)
!2866 = !{!2867, !1543, i64 0, i64 4}
!2867 = !{!1544, i64 20, !"_ZTSZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_EUlT_E_", !1543, i64 0, i64 4, !1543, i64 4, i64 4, !1543, i64 8, i64 4, !1543, i64 12, i64 4, !1543, i64 16, i64 4}
!2868 = !DILocation(line: 102, column: 47, scope: !2846)
!2869 = !{!2867, !1543, i64 4, i64 4}
!2870 = !DILocation(line: 102, column: 76, scope: !2846)
!2871 = !DILocation(line: 102, column: 59, scope: !2846)
!2872 = !DILocation(line: 103, column: 47, scope: !2846)
!2873 = !{!2867, !1543, i64 8, i64 4}
!2874 = !DILocation(line: 103, column: 76, scope: !2846)
!2875 = !DILocation(line: 103, column: 59, scope: !2846)
!2876 = !DILocation(line: 104, column: 47, scope: !2846)
!2877 = !{!2867, !1543, i64 12, i64 4}
!2878 = !DILocation(line: 104, column: 77, scope: !2846)
!2879 = !DILocation(line: 104, column: 60, scope: !2846)
!2880 = !DILocation(line: 105, column: 13, scope: !2846)
!2881 = !{!2867, !1543, i64 16, i64 4}
!2882 = !DILocation(line: 105, column: 24, scope: !2846)
!2883 = !DILocation(line: 105, column: 29, scope: !2846)
!2884 = !DILocation(line: 105, column: 42, scope: !2846)
!2885 = !DILocation(line: 105, column: 17, scope: !2846)
!2886 = !DILocation(line: 106, column: 9, scope: !2846)
!2887 = distinct !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2888, file: !2778, line: 495, type: !2779, scopeLine: 496, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2817, declaration: !2891, retainedNodes: !2892)
!2888 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unroll_for_helper<unsigned int, 0U, 1U, 1U, 1U>", scope: !1501, file: !2778, line: 489, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2889, identifier: "_ZTSN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EEE")
!2889 = !{!2804, !2805, !2806, !2890, !2807}
!2890 = !DITemplateValueParameter(name: "It", type: !15, value: i32 1)
!2891 = !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2888, file: !2778, line: 495, type: !2779, scopeLine: 495, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2817)
!2892 = !{!2893}
!2893 = !DILocalVariable(name: "fn", arg: 1, scope: !2887, file: !2778, line: 495, type: !2781)
!2894 = !DILocation(line: 495, column: 31, scope: !2887)
!2895 = !DILocation(line: 519, column: 5, scope: !2887)
!2896 = distinct !DISubprogram(name: "operator()<aie::vector<float, 16U>, aie::vector<float, 16U>, aie::accum<accfloat, 16U> >", linkageName: "_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_", scope: !2746, file: !2595, line: 87, type: !2897, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2903, declaration: !2902, retainedNodes: !2908)
!2897 = !DISubroutineType(types: !2898)
!2898 = !{!488, !2899, !2900, !2900, !2901}
!2899 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2745, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2900 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !742, size: 32)
!2901 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !494, size: 32)
!2902 = !DISubprogram(name: "operator()<aie::vector<float, 16U>, aie::vector<float, 16U>, aie::accum<accfloat, 16U> >", scope: !2746, file: !2595, line: 87, type: !2897, scopeLine: 87, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2903)
!2903 = !{!2904}
!2904 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "args:auto", value: !2905)
!2905 = !{!2906, !2906, !2907}
!2906 = !DITemplateTypeParameter(type: !742)
!2907 = !DITemplateTypeParameter(type: !494)
!2908 = !{!2909, !2911, !2912, !2913}
!2909 = !DILocalVariable(name: "this", arg: 1, scope: !2896, type: !2910, flags: DIFlagArtificial | DIFlagObjectPointer)
!2910 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2745, size: 32)
!2911 = !DILocalVariable(name: "args", arg: 2, scope: !2896, file: !2595, line: 87, type: !2900)
!2912 = !DILocalVariable(name: "args", arg: 3, scope: !2896, file: !2595, line: 87, type: !2900)
!2913 = !DILocalVariable(name: "args", arg: 4, scope: !2896, file: !2595, line: 87, type: !2901)
!2914 = !DILocation(line: 0, scope: !2896)
!2915 = !DILocation(line: 87, column: 79, scope: !2896)
!2916 = !DILocation(line: 87, column: 121, scope: !2896)
!2917 = !DILocation(line: 87, column: 107, scope: !2896)
!2918 = !DILocation(line: 87, column: 100, scope: !2896)
!2919 = distinct !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 443, type: !2920, scopeLine: 444, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2923, declaration: !2922, retainedNodes: !2925)
!2920 = !DISubroutineType(types: !2921)
!2921 = !{!742, !291, !15}
!2922 = !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 443, type: !2920, scopeLine: 443, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2923)
!2923 = !{!2924}
!2924 = !DITemplateValueParameter(name: "ElemsOut", type: !15, value: i32 16)
!2925 = !{!2926, !2928}
!2926 = !DILocalVariable(name: "this", arg: 1, scope: !2919, type: !2927, flags: DIFlagArtificial | DIFlagObjectPointer)
!2927 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !292, size: 32)
!2928 = !DILocalVariable(name: "idx", arg: 2, scope: !2919, file: !189, line: 443, type: !15)
!2929 = !DILocation(line: 0, scope: !2919)
!2930 = !DILocation(line: 443, column: 56, scope: !2919)
!2931 = !DILocation(line: 446, column: 20, scope: !2932)
!2932 = distinct !DILexicalBlock(scope: !2919, file: !189, line: 445, column: 23)
!2933 = !DILocation(line: 446, column: 13, scope: !2932)
!2934 = distinct !DISubprogram(name: "operator unsigned int", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv", scope: !2824, file: !2778, line: 467, type: !2827, scopeLine: 468, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2826, retainedNodes: !2935)
!2935 = !{!2936}
!2936 = !DILocalVariable(name: "this", arg: 1, scope: !2934, type: !2937, flags: DIFlagArtificial | DIFlagObjectPointer)
!2937 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2823, size: 32)
!2938 = !DILocation(line: 0, scope: !2934)
!2939 = !DILocation(line: 469, column: 16, scope: !2934)
!2940 = !DILocation(line: 469, column: 9, scope: !2934)
!2941 = distinct !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj", scope: !374, file: !375, line: 302, type: !2942, scopeLine: 303, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2923, declaration: !2944, retainedNodes: !2945)
!2942 = !DISubroutineType(types: !2943)
!2943 = !{!494, !456, !15}
!2944 = !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj", scope: !374, file: !375, line: 302, type: !2942, scopeLine: 302, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2923)
!2945 = !{!2946, !2948}
!2946 = !DILocalVariable(name: "this", arg: 1, scope: !2941, type: !2947, flags: DIFlagArtificial | DIFlagObjectPointer)
!2947 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !448, size: 32)
!2948 = !DILocalVariable(name: "idx", arg: 2, scope: !2941, file: !375, line: 302, type: !15)
!2949 = !DILocation(line: 0, scope: !2941)
!2950 = !DILocation(line: 302, column: 56, scope: !2941)
!2951 = !DILocation(line: 305, column: 20, scope: !2952)
!2952 = distinct !DILexicalBlock(scope: !2941, file: !375, line: 304, column: 23)
!2953 = !DILocation(line: 305, column: 13, scope: !2952)
!2954 = distinct !DISubprogram(name: "mac_elem_16", linkageName: "_Z11mac_elem_168v16floatS_11v16accfloat", scope: !2955, file: !2955, line: 883, type: !2956, scopeLine: 883, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2958)
!2955 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/me_vmult_float_emulated.h", directory: "")
!2956 = !DISubroutineType(types: !2957)
!2957 = !{!488, !486, !486, !488}
!2958 = !{!2959, !2960, !2961}
!2959 = !DILocalVariable(name: "v1", arg: 1, scope: !2954, file: !2955, line: 883, type: !486)
!2960 = !DILocalVariable(name: "v2", arg: 2, scope: !2954, file: !2955, line: 883, type: !486)
!2961 = !DILocalVariable(name: "acc", arg: 3, scope: !2954, file: !2955, line: 883, type: !488)
!2962 = !DILocation(line: 883, column: 1, scope: !2954)
!2963 = distinct !DISubprogram(name: "operator v16float", linkageName: "_ZNK3aie6vectorIfLj16EEcv8v16floatEv", scope: !742, file: !189, line: 205, type: !831, scopeLine: 206, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !835, retainedNodes: !2964)
!2964 = !{!2965}
!2965 = !DILocalVariable(name: "this", arg: 1, scope: !2963, type: !2110, flags: DIFlagArtificial | DIFlagObjectPointer)
!2966 = !DILocation(line: 0, scope: !2963)
!2967 = !DILocation(line: 207, column: 16, scope: !2963)
!2968 = !DILocation(line: 207, column: 9, scope: !2963)
!2969 = distinct !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv", scope: !494, file: !375, line: 234, type: !565, scopeLine: 235, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !564, retainedNodes: !2970)
!2970 = !{!2971}
!2971 = !DILocalVariable(name: "this", arg: 1, scope: !2969, type: !2311, flags: DIFlagArtificial | DIFlagObjectPointer)
!2972 = !DILocation(line: 0, scope: !2969)
!2973 = !DILocation(line: 236, column: 27, scope: !2969)
!2974 = !DILocation(line: 236, column: 9, scope: !2969)
!2975 = distinct !DISubprogram(name: "mac_elem_16_accuracy_fast", linkageName: "_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii", scope: !2955, file: !2955, line: 835, type: !2976, scopeLine: 835, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2978)
!2976 = !DISubroutineType(types: !2977)
!2977 = !{!488, !486, !486, !488, !9, !9, !9}
!2978 = !{!2979, !2980, !2981, !2982, !2983, !2984, !2985}
!2979 = !DILocalVariable(name: "v1", arg: 1, scope: !2975, file: !2955, line: 835, type: !486)
!2980 = !DILocalVariable(name: "v2", arg: 2, scope: !2975, file: !2955, line: 835, type: !486)
!2981 = !DILocalVariable(name: "acc", arg: 3, scope: !2975, file: !2955, line: 835, type: !488)
!2982 = !DILocalVariable(name: "zero_acc", arg: 4, scope: !2975, file: !2955, line: 835, type: !9)
!2983 = !DILocalVariable(name: "sub_mul", arg: 5, scope: !2975, file: !2955, line: 835, type: !9)
!2984 = !DILocalVariable(name: "sub_acc1", arg: 6, scope: !2975, file: !2955, line: 835, type: !9)
!2985 = !DILocalVariable(name: "o", scope: !2975, file: !2955, line: 835, type: !488)
!2986 = !DILocation(line: 835, column: 1, scope: !2975)
!2987 = distinct !DISubprogram(name: "mac_elem_16_accuracy_fast_inner", linkageName: "_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii", scope: !2988, file: !2955, line: 175, type: !2976, scopeLine: 176, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2989)
!2988 = !DINamespace(name: "me_detail", scope: null)
!2989 = !{!2990, !2991, !2992, !2993, !2994, !2995, !2996, !2997, !2998, !2999, !3000, !3001, !3002, !3003, !3004}
!2990 = !DILocalVariable(name: "v1", arg: 1, scope: !2987, file: !2955, line: 175, type: !486)
!2991 = !DILocalVariable(name: "v2", arg: 2, scope: !2987, file: !2955, line: 175, type: !486)
!2992 = !DILocalVariable(name: "acc", arg: 3, scope: !2987, file: !2955, line: 175, type: !488)
!2993 = !DILocalVariable(name: "zero_acc", arg: 4, scope: !2987, file: !2955, line: 175, type: !9)
!2994 = !DILocalVariable(name: "sub_mul", arg: 5, scope: !2987, file: !2955, line: 176, type: !9)
!2995 = !DILocalVariable(name: "sub_acc1", arg: 6, scope: !2987, file: !2955, line: 176, type: !9)
!2996 = !DILocalVariable(name: "a", scope: !2987, file: !2955, line: 177, type: !492)
!2997 = !DILocalVariable(name: "b", scope: !2987, file: !2955, line: 178, type: !492)
!2998 = !DILocalVariable(name: "c", scope: !2987, file: !2955, line: 179, type: !492)
!2999 = !DILocalVariable(name: "d", scope: !2987, file: !2955, line: 180, type: !492)
!3000 = !DILocalVariable(name: "e", scope: !2987, file: !2955, line: 181, type: !492)
!3001 = !DILocalVariable(name: "f", scope: !2987, file: !2955, line: 182, type: !492)
!3002 = !DILocalVariable(name: "dummy0", scope: !2987, file: !2955, line: 183, type: !492)
!3003 = !DILocalVariable(name: "acc0", scope: !2987, file: !2955, line: 186, type: !488)
!3004 = !DILocalVariable(name: "acc1", scope: !2987, file: !2955, line: 191, type: !488)
!3005 = !DILocation(line: 175, column: 69, scope: !2987)
!3006 = !DILocation(line: 175, column: 82, scope: !2987)
!3007 = !DILocation(line: 175, column: 98, scope: !2987)
!3008 = !DILocation(line: 175, column: 107, scope: !2987)
!3009 = !DILocation(line: 176, column: 64, scope: !2987)
!3010 = !DILocation(line: 176, column: 77, scope: !2987)
!3011 = !DILocation(line: 177, column: 3, scope: !2987)
!3012 = !DILocation(line: 177, column: 15, scope: !2987)
!3013 = !DILocation(line: 177, column: 19, scope: !2987)
!3014 = !DILocation(line: 178, column: 3, scope: !2987)
!3015 = !DILocation(line: 178, column: 15, scope: !2987)
!3016 = !DILocation(line: 178, column: 19, scope: !2987)
!3017 = !DILocation(line: 179, column: 3, scope: !2987)
!3018 = !DILocation(line: 179, column: 15, scope: !2987)
!3019 = !DILocation(line: 179, column: 19, scope: !2987)
!3020 = !DILocation(line: 180, column: 3, scope: !2987)
!3021 = !DILocation(line: 180, column: 15, scope: !2987)
!3022 = !DILocation(line: 180, column: 19, scope: !2987)
!3023 = !DILocation(line: 181, column: 3, scope: !2987)
!3024 = !DILocation(line: 181, column: 15, scope: !2987)
!3025 = !DILocation(line: 181, column: 19, scope: !2987)
!3026 = !DILocation(line: 182, column: 3, scope: !2987)
!3027 = !DILocation(line: 182, column: 15, scope: !2987)
!3028 = !DILocation(line: 182, column: 19, scope: !2987)
!3029 = !DILocation(line: 183, column: 3, scope: !2987)
!3030 = !DILocation(line: 183, column: 15, scope: !2987)
!3031 = !DILocation(line: 183, column: 24, scope: !2987)
!3032 = !DILocation(line: 185, column: 35, scope: !2987)
!3033 = !DILocation(line: 185, column: 20, scope: !2987)
!3034 = !DILocation(line: 185, column: 7, scope: !2987)
!3035 = !DILocation(line: 185, column: 5, scope: !2987)
!3036 = !DILocation(line: 186, column: 3, scope: !2987)
!3037 = !DILocation(line: 186, column: 15, scope: !2987)
!3038 = !DILocation(line: 186, column: 47, scope: !2987)
!3039 = !DILocation(line: 186, column: 22, scope: !2987)
!3040 = !DILocation(line: 187, column: 20, scope: !2987)
!3041 = !DILocation(line: 187, column: 7, scope: !2987)
!3042 = !DILocation(line: 187, column: 5, scope: !2987)
!3043 = !DILocation(line: 188, column: 35, scope: !2987)
!3044 = !DILocation(line: 188, column: 20, scope: !2987)
!3045 = !DILocation(line: 188, column: 7, scope: !2987)
!3046 = !DILocation(line: 188, column: 5, scope: !2987)
!3047 = !DILocation(line: 190, column: 35, scope: !2987)
!3048 = !DILocation(line: 190, column: 20, scope: !2987)
!3049 = !DILocation(line: 190, column: 7, scope: !2987)
!3050 = !DILocation(line: 190, column: 5, scope: !2987)
!3051 = !DILocation(line: 191, column: 3, scope: !2987)
!3052 = !DILocation(line: 191, column: 15, scope: !2987)
!3053 = !DILocation(line: 191, column: 47, scope: !2987)
!3054 = !DILocation(line: 191, column: 22, scope: !2987)
!3055 = !DILocation(line: 192, column: 20, scope: !2987)
!3056 = !DILocation(line: 192, column: 7, scope: !2987)
!3057 = !DILocation(line: 192, column: 5, scope: !2987)
!3058 = !DILocation(line: 193, column: 35, scope: !2987)
!3059 = !DILocation(line: 193, column: 20, scope: !2987)
!3060 = !DILocation(line: 193, column: 7, scope: !2987)
!3061 = !DILocation(line: 193, column: 5, scope: !2987)
!3062 = !DILocation(line: 201, column: 90, scope: !2987)
!3063 = !DILocation(line: 201, column: 65, scope: !2987)
!3064 = !DILocation(line: 201, column: 103, scope: !2987)
!3065 = !DILocation(line: 201, column: 40, scope: !2987)
!3066 = !DILocation(line: 202, column: 34, scope: !2987)
!3067 = !DILocation(line: 201, column: 15, scope: !2987)
!3068 = !DILocation(line: 203, column: 18, scope: !2987)
!3069 = !DILocation(line: 199, column: 11, scope: !2987)
!3070 = !DILocation(line: 204, column: 14, scope: !2987)
!3071 = !DILocation(line: 197, column: 7, scope: !2987)
!3072 = !DILocation(line: 205, column: 7, scope: !2987)
!3073 = !DILocation(line: 205, column: 17, scope: !2987)
!3074 = !DILocation(line: 205, column: 26, scope: !2987)
!3075 = !DILocation(line: 195, column: 10, scope: !2987)
!3076 = !DILocation(line: 206, column: 1, scope: !2987)
!3077 = !{!3078, !3078, i64 0, i64 1}
!3078 = !{!1544, i64 1, !"uint4_t"}
!3079 = !{!3080, !3080, i64 0, i64 4}
!3080 = !{!1544, i64 4, !"uint5_t"}
!3081 = !{!3082, !3082, i64 0, i64 2}
!3082 = !{!1544, i64 2, !"short"}
!3083 = !{i32 2}
!3084 = distinct !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6vectorIfLj16EE9to_nativeEv", scope: !742, file: !189, line: 196, type: !831, scopeLine: 197, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !830, retainedNodes: !3085)
!3085 = !{!3086}
!3086 = !DILocalVariable(name: "this", arg: 1, scope: !3084, type: !2110, flags: DIFlagArtificial | DIFlagObjectPointer)
!3087 = !DILocation(line: 0, scope: !3084)
!3088 = !DILocation(line: 198, column: 27, scope: !3084)
!3089 = !DILocation(line: 198, column: 9, scope: !3084)
!3090 = distinct !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv", scope: !745, file: !193, line: 1154, type: !798, scopeLine: 1155, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !797, retainedNodes: !3091)
!3091 = !{!3092}
!3092 = !DILocalVariable(name: "this", arg: 1, scope: !3090, type: !2142, flags: DIFlagArtificial | DIFlagObjectPointer)
!3093 = !DILocation(line: 0, scope: !3090)
!3094 = !DILocation(line: 1160, column: 20, scope: !3095)
!3095 = distinct !DILexicalBlock(scope: !3090, file: !193, line: 1157, column: 23)
!3096 = distinct !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv", scope: !497, file: !379, line: 256, type: !530, scopeLine: 257, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !529, retainedNodes: !3097)
!3097 = !{!3098}
!3098 = !DILocalVariable(name: "this", arg: 1, scope: !3096, type: !2360, flags: DIFlagArtificial | DIFlagObjectPointer)
!3099 = !DILocation(line: 0, scope: !3096)
!3100 = !DILocation(line: 258, column: 16, scope: !3096)
!3101 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 247, type: !2920, scopeLine: 248, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2923, declaration: !3102, retainedNodes: !3103)
!3102 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 247, type: !2920, scopeLine: 247, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2923)
!3103 = !{!3104, !3105}
!3104 = !DILocalVariable(name: "this", arg: 1, scope: !3101, type: !2927, flags: DIFlagArtificial | DIFlagObjectPointer)
!3105 = !DILocalVariable(name: "idx", arg: 2, scope: !3101, file: !189, line: 247, type: !15)
!3106 = !DILocation(line: 0, scope: !3101)
!3107 = !DILocation(line: 247, column: 91, scope: !3101)
!3108 = !DILocation(line: 249, column: 17, scope: !3101)
!3109 = !DILocation(line: 249, column: 52, scope: !3101)
!3110 = !DILocation(line: 249, column: 37, scope: !3101)
!3111 = !DILocation(line: 249, column: 16, scope: !3101)
!3112 = !DILocation(line: 249, column: 9, scope: !3101)
!3113 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 548, type: !3114, scopeLine: 549, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2923, declaration: !3116, retainedNodes: !3117)
!3114 = !DISubroutineType(types: !3115)
!3115 = !{!745, !253, !15}
!3116 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 548, type: !3114, scopeLine: 548, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2923)
!3117 = !{!3118, !3120, !3121, !3122, !3123, !3124, !3125}
!3118 = !DILocalVariable(name: "this", arg: 1, scope: !3113, type: !3119, flags: DIFlagArtificial | DIFlagObjectPointer)
!3119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 32)
!3120 = !DILocalVariable(name: "idx", arg: 2, scope: !3113, file: !193, line: 548, type: !15)
!3121 = !DILocalVariable(name: "output_bits", scope: !3113, file: !193, line: 550, type: !101)
!3122 = !DILocalVariable(name: "growth_ratio", scope: !3113, file: !193, line: 551, type: !101)
!3123 = !DILocalVariable(name: "ret", scope: !3113, file: !193, line: 556, type: !745)
!3124 = !DILocalVariable(name: "in_storage_elems", scope: !3113, file: !193, line: 558, type: !101)
!3125 = !DILocalVariable(name: "out_storage_elems", scope: !3113, file: !193, line: 559, type: !101)
!3126 = !DILocation(line: 0, scope: !3113)
!3127 = !DILocation(line: 548, column: 44, scope: !3113)
!3128 = !DILocation(line: 550, column: 9, scope: !3113)
!3129 = !DILocation(line: 550, column: 28, scope: !3113)
!3130 = !DILocation(line: 551, column: 9, scope: !3113)
!3131 = !DILocation(line: 551, column: 28, scope: !3113)
!3132 = !DILocation(line: 556, column: 34, scope: !3113)
!3133 = !DILocation(line: 558, column: 9, scope: !3113)
!3134 = !DILocation(line: 558, column: 28, scope: !3113)
!3135 = !DILocation(line: 559, column: 9, scope: !3113)
!3136 = !DILocation(line: 559, column: 28, scope: !3113)
!3137 = !DILocation(line: 565, column: 19, scope: !3138)
!3138 = distinct !DILexicalBlock(scope: !3139, file: !193, line: 564, column: 77)
!3139 = distinct !DILexicalBlock(scope: !3140, file: !193, line: 564, column: 28)
!3140 = distinct !DILexicalBlock(scope: !3113, file: !193, line: 561, column: 23)
!3141 = !DILocation(line: 565, column: 57, scope: !3138)
!3142 = !DILocation(line: 565, column: 63, scope: !3138)
!3143 = !DILocation(line: 565, column: 17, scope: !3138)
!3144 = !{!2090, !2090, i64 0, i64 64}
!3145 = !{i64 0, i64 4, !1755, i64 4, i64 4, !1755, i64 8, i64 4, !1755, i64 12, i64 4, !1755, i64 16, i64 4, !1755, i64 20, i64 4, !1755, i64 24, i64 4, !1755, i64 28, i64 4, !1755, i64 32, i64 4, !1755, i64 36, i64 4, !1755, i64 40, i64 4, !1755, i64 44, i64 4, !1755, i64 48, i64 4, !1755, i64 52, i64 4, !1755, i64 56, i64 4, !1755, i64 60, i64 4, !1755}
!3146 = !DILocation(line: 565, column: 13, scope: !3138)
!3147 = !DILocation(line: 584, column: 5, scope: !3113)
!3148 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE", scope: !742, file: !189, line: 87, type: !802, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !801, retainedNodes: !3149)
!3149 = !{!3150, !3151}
!3150 = !DILocalVariable(name: "this", arg: 1, scope: !3148, type: !2121, flags: DIFlagArtificial | DIFlagObjectPointer)
!3151 = !DILocalVariable(name: "v", arg: 2, scope: !3148, file: !189, line: 87, type: !805)
!3152 = !DILocation(line: 0, scope: !3148)
!3153 = !DILocation(line: 87, column: 29, scope: !3148)
!3154 = !DILocation(line: 87, column: 44, scope: !3148)
!3155 = !DILocation(line: 87, column: 34, scope: !3148)
!3156 = !DILocation(line: 87, column: 48, scope: !3148)
!3157 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj16EEC2Ev", scope: !745, file: !193, line: 402, type: !768, scopeLine: 404, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !767, retainedNodes: !3158)
!3158 = !{!3159}
!3159 = !DILocalVariable(name: "this", arg: 1, scope: !3157, type: !3160, flags: DIFlagArtificial | DIFlagObjectPointer)
!3160 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !745, size: 32)
!3161 = !DILocation(line: 0, scope: !3157)
!3162 = !DILocation(line: 403, column: 9, scope: !3157)
!3163 = !DILocation(line: 403, column: 14, scope: !3157)
!3164 = !DILocation(line: 405, column: 5, scope: !3157)
!3165 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj", scope: !3166, file: !193, line: 175, type: !3169, scopeLine: 175, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3168, retainedNodes: !3179)
!3166 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vector_set<float, 16U>", scope: !7, file: !193, line: 175, size: 8, flags: DIFlagTypePassByValue, elements: !3167, templateParams: !758, identifier: "_ZTSN3aie6detail10vector_setIfLj16EEE")
!3167 = !{!3168, !3173}
!3168 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj", scope: !3166, file: !193, line: 175, type: !3169, scopeLine: 175, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3169 = !DISubroutineType(types: !3170)
!3170 = !{!486, !3171, !15}
!3171 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3172, size: 32)
!3172 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !211)
!3173 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10vector_setIfLj16EE3runERK7v4floatj", scope: !3166, file: !193, line: 176, type: !3174, scopeLine: 176, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3174 = !DISubroutineType(types: !3175)
!3175 = !{!486, !3176, !15}
!3176 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3177, size: 32)
!3177 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3178)
!3178 = !DIDerivedType(tag: DW_TAG_typedef, name: "v4float", file: !34, line: 615, baseType: !674)
!3179 = !{!3180, !3181}
!3180 = !DILocalVariable(name: "v", arg: 1, scope: !3165, file: !193, line: 175, type: !3171)
!3181 = !DILocalVariable(name: "idx", arg: 2, scope: !3165, file: !193, line: 175, type: !15)
!3182 = !DILocation(line: 175, column: 90, scope: !3165)
!3183 = !DILocation(line: 175, column: 102, scope: !3165)
!3184 = !DILocation(line: 175, column: 131, scope: !3165)
!3185 = !DILocation(line: 175, column: 136, scope: !3165)
!3186 = !DILocation(line: 175, column: 116, scope: !3165)
!3187 = !DILocation(line: 175, column: 109, scope: !3165)
!3188 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float", scope: !745, file: !193, line: 408, type: !772, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !771, retainedNodes: !3189)
!3189 = !{!3190, !3191}
!3190 = !DILocalVariable(name: "this", arg: 1, scope: !3188, type: !3160, flags: DIFlagArtificial | DIFlagObjectPointer)
!3191 = !DILocalVariable(name: "data", arg: 2, scope: !3188, file: !193, line: 408, type: !774)
!3192 = !DILocation(line: 0, scope: !3188)
!3193 = !DILocation(line: 408, column: 27, scope: !3188)
!3194 = !DILocation(line: 409, column: 9, scope: !3188)
!3195 = !DILocation(line: 409, column: 14, scope: !3188)
!3196 = !DILocation(line: 412, column: 5, scope: !3188)
!3197 = distinct !DISubprogram(name: "current", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv", scope: !2824, file: !2778, line: 482, type: !2827, scopeLine: 483, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2832, retainedNodes: !3198)
!3198 = !{!3199}
!3199 = !DILocalVariable(name: "this", arg: 1, scope: !3197, type: !2937, flags: DIFlagArtificial | DIFlagObjectPointer)
!3200 = !DILocation(line: 0, scope: !3197)
!3201 = !DILocation(line: 484, column: 9, scope: !3197)
!3202 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv", scope: !374, file: !375, line: 248, type: !3203, scopeLine: 249, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2923, declaration: !3205, retainedNodes: !3206)
!3203 = !DISubroutineType(types: !3204)
!3204 = !{!494, !456}
!3205 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv", scope: !374, file: !375, line: 248, type: !3203, scopeLine: 248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2923)
!3206 = !{!3207}
!3207 = !DILocalVariable(name: "this", arg: 1, scope: !3202, type: !2947, flags: DIFlagArtificial | DIFlagObjectPointer)
!3208 = !DILocation(line: 0, scope: !3202)
!3209 = !DILocation(line: 250, column: 45, scope: !3202)
!3210 = !DILocation(line: 250, column: 65, scope: !3202)
!3211 = !DILocation(line: 250, column: 16, scope: !3202)
!3212 = !DILocation(line: 250, column: 9, scope: !3202)
!3213 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv", scope: !378, file: !379, line: 287, type: !3214, scopeLine: 288, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2923, declaration: !3216, retainedNodes: !3217)
!3214 = !DISubroutineType(types: !3215)
!3215 = !{!497, !420}
!3216 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv", scope: !378, file: !379, line: 287, type: !3214, scopeLine: 287, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2923)
!3217 = !{!3218, !3220, !3221, !3222, !3223}
!3218 = !DILocalVariable(name: "this", arg: 1, scope: !3213, type: !3219, flags: DIFlagArtificial | DIFlagObjectPointer)
!3219 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !421, size: 32)
!3220 = !DILocalVariable(name: "in_num_subaccums", scope: !3213, file: !379, line: 293, type: !101)
!3221 = !DILocalVariable(name: "out_num_subaccums", scope: !3213, file: !379, line: 294, type: !101)
!3222 = !DILocalVariable(name: "ret", scope: !3213, file: !379, line: 295, type: !497)
!3223 = !DILocalVariable(name: "growth_ratio", scope: !3213, file: !379, line: 298, type: !101)
!3224 = !DILocation(line: 0, scope: !3213)
!3225 = !DILocation(line: 293, column: 9, scope: !3213)
!3226 = !DILocation(line: 293, column: 28, scope: !3213)
!3227 = !DILocation(line: 294, column: 9, scope: !3213)
!3228 = !DILocation(line: 294, column: 28, scope: !3213)
!3229 = !DILocation(line: 295, column: 46, scope: !3213)
!3230 = !DILocation(line: 298, column: 9, scope: !3213)
!3231 = !DILocation(line: 298, column: 28, scope: !3213)
!3232 = !DILocation(line: 310, column: 23, scope: !3233)
!3233 = distinct !DILexicalBlock(scope: !3234, file: !379, line: 309, column: 27)
!3234 = distinct !DILexicalBlock(scope: !3235, file: !379, line: 308, column: 77)
!3235 = distinct !DILexicalBlock(scope: !3236, file: !379, line: 308, column: 28)
!3236 = distinct !DILexicalBlock(scope: !3213, file: !379, line: 305, column: 23)
!3237 = !DILocation(line: 310, column: 32, scope: !3233)
!3238 = !DILocation(line: 310, column: 38, scope: !3233)
!3239 = !{!1720, !1721, i64 0, i64 32}
!3240 = !DILocation(line: 310, column: 21, scope: !3233)
!3241 = !{!2256, !2256, i64 0, i64 64}
!3242 = !DILocation(line: 310, column: 17, scope: !3233)
!3243 = !DILocation(line: 326, column: 5, scope: !3213)
!3244 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE", scope: !494, file: !375, line: 59, type: !536, scopeLine: 59, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !535, retainedNodes: !3245)
!3245 = !{!3246, !3247}
!3246 = !DILocalVariable(name: "this", arg: 1, scope: !3244, type: !2280, flags: DIFlagArtificial | DIFlagObjectPointer)
!3247 = !DILocalVariable(name: "a", arg: 2, scope: !3244, file: !375, line: 59, type: !539)
!3248 = !DILocation(line: 0, scope: !3244)
!3249 = !DILocation(line: 59, column: 37, scope: !3244)
!3250 = !DILocation(line: 59, column: 52, scope: !3244)
!3251 = !DILocation(line: 59, column: 42, scope: !3244)
!3252 = !DILocation(line: 59, column: 56, scope: !3244)
!3253 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev", scope: !497, file: !379, line: 229, type: !523, scopeLine: 231, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !522, retainedNodes: !3254)
!3254 = !{!3255}
!3255 = !DILocalVariable(name: "this", arg: 1, scope: !3253, type: !3256, flags: DIFlagArtificial | DIFlagObjectPointer)
!3256 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !497, size: 32)
!3257 = !DILocation(line: 0, scope: !3253)
!3258 = !DILocation(line: 230, column: 9, scope: !3253)
!3259 = !DILocation(line: 230, column: 14, scope: !3253)
!3260 = !DILocation(line: 232, column: 5, scope: !3253)
!3261 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat", scope: !497, file: !379, line: 242, type: !527, scopeLine: 244, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !526, retainedNodes: !3262)
!3262 = !{!3263, !3264}
!3263 = !DILocalVariable(name: "this", arg: 1, scope: !3261, type: !3256, flags: DIFlagArtificial | DIFlagObjectPointer)
!3264 = !DILocalVariable(name: "data", arg: 2, scope: !3261, file: !379, line: 242, type: !502)
!3265 = !DILocation(line: 0, scope: !3261)
!3266 = !DILocation(line: 242, column: 26, scope: !3261)
!3267 = !DILocation(line: 243, column: 9, scope: !3261)
!3268 = !DILocation(line: 243, column: 14, scope: !3261)
!3269 = !DILocation(line: 246, column: 5, scope: !3261)
!3270 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv", scope: !505, file: !386, line: 167, type: !508, scopeLine: 167, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !507, retainedNodes: !137)
!3271 = !DILocation(line: 167, column: 147, scope: !3270)
!3272 = !DILocation(line: 167, column: 140, scope: !3270)
!3273 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf", scope: !3274, file: !2054, line: 122, type: !3277, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3276, retainedNodes: !3280)
!3274 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "broadcast_bits_impl<32U, float, 8U>", scope: !7, file: !2054, line: 117, size: 8, flags: DIFlagTypePassByValue, elements: !3275, templateParams: !2048, identifier: "_ZTSN3aie6detail19broadcast_bits_implILj32EfLj8EEE")
!3275 = !{!3276}
!3276 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf", scope: !3274, file: !2054, line: 122, type: !3277, scopeLine: 122, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3277 = !DISubroutineType(types: !3278)
!3278 = !{!3279, !2770}
!3279 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !3274, file: !2054, line: 119, baseType: !188)
!3280 = !{!3281, !3282, !3283}
!3281 = !DILocalVariable(name: "a", arg: 1, scope: !3273, file: !2054, line: 122, type: !2770)
!3282 = !DILocalVariable(name: "native_broadcast_elems", scope: !3273, file: !2054, line: 124, type: !101)
!3283 = !DILocalVariable(name: "ret", scope: !3273, file: !2054, line: 127, type: !3279)
!3284 = !DILocation(line: 122, column: 37, scope: !3273)
!3285 = !DILocation(line: 124, column: 9, scope: !3273)
!3286 = !DILocation(line: 124, column: 28, scope: !3273)
!3287 = !DILocation(line: 127, column: 21, scope: !3273)
!3288 = !DILocation(line: 130, column: 19, scope: !3289)
!3289 = distinct !DILexicalBlock(scope: !3290, file: !2054, line: 129, column: 49)
!3290 = distinct !DILexicalBlock(scope: !3273, file: !2054, line: 129, column: 23)
!3291 = !DILocation(line: 130, column: 46, scope: !3289)
!3292 = !DILocation(line: 130, column: 58, scope: !3289)
!3293 = !DILocation(line: 130, column: 17, scope: !3289)
!3294 = !DILocation(line: 130, column: 13, scope: !3289)
!3295 = !DILocation(line: 156, column: 5, scope: !3273)
!3296 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf", scope: !3297, file: !2054, line: 122, type: !3300, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3299, retainedNodes: !3303)
!3297 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "broadcast_bits_impl<32U, float, 16U>", scope: !7, file: !2054, line: 117, size: 8, flags: DIFlagTypePassByValue, elements: !3298, templateParams: !2081, identifier: "_ZTSN3aie6detail19broadcast_bits_implILj32EfLj16EEE")
!3298 = !{!3299}
!3299 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf", scope: !3297, file: !2054, line: 122, type: !3300, scopeLine: 122, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3300 = !DISubroutineType(types: !3301)
!3301 = !{!3302, !2770}
!3302 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !3297, file: !2054, line: 119, baseType: !742)
!3303 = !{!3304, !3305, !3306}
!3304 = !DILocalVariable(name: "a", arg: 1, scope: !3296, file: !2054, line: 122, type: !2770)
!3305 = !DILocalVariable(name: "native_broadcast_elems", scope: !3296, file: !2054, line: 124, type: !101)
!3306 = !DILocalVariable(name: "ret", scope: !3296, file: !2054, line: 127, type: !3302)
!3307 = !DILocation(line: 122, column: 37, scope: !3296)
!3308 = !DILocation(line: 124, column: 9, scope: !3296)
!3309 = !DILocation(line: 124, column: 28, scope: !3296)
!3310 = !DILocation(line: 127, column: 21, scope: !3296)
!3311 = !DILocation(line: 141, column: 47, scope: !3312)
!3312 = distinct !DILexicalBlock(scope: !3313, file: !2054, line: 140, column: 32)
!3313 = distinct !DILexicalBlock(scope: !3314, file: !2054, line: 138, column: 27)
!3314 = distinct !DILexicalBlock(scope: !3315, file: !2054, line: 134, column: 27)
!3315 = distinct !DILexicalBlock(scope: !3316, file: !2054, line: 132, column: 41)
!3316 = distinct !DILexicalBlock(scope: !3317, file: !2054, line: 132, column: 28)
!3317 = distinct !DILexicalBlock(scope: !3296, file: !2054, line: 129, column: 23)
!3318 = !DILocation(line: 141, column: 23, scope: !3312)
!3319 = !DILocation(line: 141, column: 21, scope: !3312)
!3320 = !DILocation(line: 156, column: 5, scope: !3296)
!3321 = distinct !DISubprogram(name: "get", linkageName: "_ZNK3aie21vector_elem_const_refIfLj8EE3getEv", scope: !308, file: !309, line: 44, type: !355, scopeLine: 45, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !354, retainedNodes: !3322)
!3322 = !{!3323}
!3323 = !DILocalVariable(name: "this", arg: 1, scope: !3321, type: !2730, flags: DIFlagArtificial | DIFlagObjectPointer)
!3324 = !DILocation(line: 0, scope: !3321)
!3325 = !DILocation(line: 46, column: 16, scope: !3321)
!3326 = !{!2570, !1543, i64 0, i64 4}
!3327 = !DILocation(line: 46, column: 27, scope: !3321)
!3328 = !DILocation(line: 46, column: 23, scope: !3321)
!3329 = !DILocation(line: 46, column: 9, scope: !3321)
!3330 = distinct !DISubprogram(name: "get", linkageName: "_ZNK3aie6vectorIfLj8EE3getEj", scope: !188, file: !189, line: 282, type: !303, scopeLine: 283, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !302, retainedNodes: !3331)
!3331 = !{!3332, !3333}
!3332 = !DILocalVariable(name: "this", arg: 1, scope: !3330, type: !2927, flags: DIFlagArtificial | DIFlagObjectPointer)
!3333 = !DILocalVariable(name: "idx", arg: 2, scope: !3330, file: !189, line: 282, type: !15)
!3334 = !DILocation(line: 0, scope: !3330)
!3335 = !DILocation(line: 282, column: 29, scope: !3330)
!3336 = !DILocation(line: 284, column: 31, scope: !3330)
!3337 = !DILocation(line: 284, column: 27, scope: !3330)
!3338 = !DILocation(line: 284, column: 9, scope: !3330)
!3339 = distinct !DISubprogram(name: "get", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE3getEj", scope: !192, file: !193, line: 703, type: !251, scopeLine: 704, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !250, retainedNodes: !3340)
!3340 = !{!3341, !3342}
!3341 = !DILocalVariable(name: "this", arg: 1, scope: !3339, type: !3119, flags: DIFlagArtificial | DIFlagObjectPointer)
!3342 = !DILocalVariable(name: "idx", arg: 2, scope: !3339, file: !193, line: 703, type: !15)
!3343 = !DILocation(line: 0, scope: !3339)
!3344 = !DILocation(line: 703, column: 29, scope: !3339)
!3345 = !DILocation(line: 705, column: 9, scope: !3339)
!3346 = !DILocation(line: 705, column: 9, scope: !3347)
!3347 = distinct !DILexicalBlock(scope: !3348, file: !193, line: 705, column: 9)
!3348 = distinct !DILexicalBlock(scope: !3339, file: !193, line: 705, column: 9)
!3349 = !DILocation(line: 705, column: 9, scope: !3348)
!3350 = !DILocation(line: 705, column: 9, scope: !3351)
!3351 = distinct !DILexicalBlock(scope: !3347, file: !193, line: 705, column: 9)
!3352 = !DILocation(line: 705, column: 9, scope: !3353)
!3353 = distinct !DILexicalBlock(scope: !3354, file: !193, line: 705, column: 9)
!3354 = distinct !DILexicalBlock(scope: !3351, file: !193, line: 705, column: 9)
!3355 = !DILocation(line: 705, column: 9, scope: !3354)
!3356 = !DILocation(line: 705, column: 9, scope: !3357)
!3357 = distinct !DILexicalBlock(scope: !3347, file: !193, line: 705, column: 9)
!3358 = !DILocation(line: 748, column: 79, scope: !3359)
!3359 = distinct !DILexicalBlock(scope: !3360, file: !193, line: 747, column: 47)
!3360 = distinct !DILexicalBlock(scope: !3361, file: !193, line: 747, column: 32)
!3361 = distinct !DILexicalBlock(scope: !3362, file: !193, line: 744, column: 27)
!3362 = distinct !DILexicalBlock(scope: !3363, file: !193, line: 743, column: 14)
!3363 = distinct !DILexicalBlock(scope: !3339, file: !193, line: 707, column: 23)
!3364 = !DILocation(line: 748, column: 39, scope: !3359)
!3365 = !DILocation(line: 748, column: 89, scope: !3359)
!3366 = !DILocation(line: 748, column: 24, scope: !3359)
!3367 = !DILocation(line: 748, column: 17, scope: !3359)
!3368 = !{!"2nd parameter of extract intrinsic should be const in [0,63]"}
!3369 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_", scope: !1001, file: !45, line: 454, type: !3370, scopeLine: 454, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3373, retainedNodes: !3374)
!3370 = !DISubroutineType(types: !3371)
!3371 = !{null, !3372, !984}
!3372 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1001, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3373 = !DISubprogram(name: "unary_op_common", scope: !1001, type: !3370, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3374 = !{!3375, !3377}
!3375 = !DILocalVariable(name: "this", arg: 1, scope: !3369, type: !3376, flags: DIFlagArtificial | DIFlagObjectPointer)
!3376 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1001, size: 32)
!3377 = !DILocalVariable(arg: 2, scope: !3369, type: !984, flags: DIFlagArtificial)
!3378 = !DILocation(line: 0, scope: !3369)
!3379 = !DILocation(line: 454, column: 1, scope: !3369)
!3380 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_", scope: !980, file: !45, line: 424, type: !996, scopeLine: 426, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !995, retainedNodes: !3381)
!3381 = !{!3382, !3384}
!3382 = !DILocalVariable(name: "this", arg: 1, scope: !3380, type: !3383, flags: DIFlagArtificial | DIFlagObjectPointer)
!3383 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !980, size: 32)
!3384 = !DILocalVariable(name: "parent", arg: 2, scope: !3380, file: !45, line: 424, type: !984)
!3385 = !DILocation(line: 0, scope: !3380)
!3386 = !DILocation(line: 424, column: 50, scope: !3380)
!3387 = !DILocation(line: 425, column: 9, scope: !3380)
!3388 = !DILocation(line: 425, column: 17, scope: !3380)
!3389 = !DILocation(line: 427, column: 5, scope: !3380)
!3390 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_", scope: !1014, file: !45, line: 454, type: !3391, scopeLine: 454, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3394, retainedNodes: !3395)
!3391 = !DISubroutineType(types: !3392)
!3392 = !{null, !3393, !962}
!3393 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1014, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3394 = !DISubprogram(name: "unary_op_common", scope: !1014, type: !3391, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3395 = !{!3396, !3398}
!3396 = !DILocalVariable(name: "this", arg: 1, scope: !3390, type: !3397, flags: DIFlagArtificial | DIFlagObjectPointer)
!3397 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1014, size: 32)
!3398 = !DILocalVariable(arg: 2, scope: !3390, type: !962, flags: DIFlagArtificial)
!3399 = !DILocation(line: 0, scope: !3390)
!3400 = !DILocation(line: 454, column: 1, scope: !3390)
!3401 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_", scope: !958, file: !45, line: 424, type: !974, scopeLine: 426, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !973, retainedNodes: !3402)
!3402 = !{!3403, !3405}
!3403 = !DILocalVariable(name: "this", arg: 1, scope: !3401, type: !3404, flags: DIFlagArtificial | DIFlagObjectPointer)
!3404 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !958, size: 32)
!3405 = !DILocalVariable(name: "parent", arg: 2, scope: !3401, file: !45, line: 424, type: !962)
!3406 = !DILocation(line: 0, scope: !3401)
!3407 = !DILocation(line: 424, column: 50, scope: !3401)
!3408 = !DILocation(line: 425, column: 9, scope: !3401)
!3409 = !DILocation(line: 427, column: 5, scope: !3401)
!3410 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_", scope: !1027, file: !45, line: 459, type: !3411, scopeLine: 459, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3414, retainedNodes: !3415)
!3411 = !DISubroutineType(types: !3412)
!3412 = !{null, !3413, !939}
!3413 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1027, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3414 = !DISubprogram(name: "unary_op_common", scope: !1027, type: !3411, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3415 = !{!3416, !3418}
!3416 = !DILocalVariable(name: "this", arg: 1, scope: !3410, type: !3417, flags: DIFlagArtificial | DIFlagObjectPointer)
!3417 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1027, size: 32)
!3418 = !DILocalVariable(arg: 2, scope: !3410, type: !939, flags: DIFlagArtificial)
!3419 = !DILocation(line: 0, scope: !3410)
!3420 = !DILocation(line: 459, column: 1, scope: !3410)
!3421 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_", scope: !934, file: !45, line: 424, type: !952, scopeLine: 426, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !951, retainedNodes: !3422)
!3422 = !{!3423, !3425}
!3423 = !DILocalVariable(name: "this", arg: 1, scope: !3421, type: !3424, flags: DIFlagArtificial | DIFlagObjectPointer)
!3424 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !934, size: 32)
!3425 = !DILocalVariable(name: "parent", arg: 2, scope: !3421, file: !45, line: 424, type: !939)
!3426 = !DILocation(line: 0, scope: !3421)
!3427 = !DILocation(line: 424, column: 50, scope: !3421)
!3428 = !DILocation(line: 425, column: 9, scope: !3421)
!3429 = !DILocation(line: 425, column: 17, scope: !3421)
!3430 = !DILocation(line: 427, column: 5, scope: !3421)
!3431 = distinct !DISubprogram(name: "elem_ref", linkageName: "_ZN3aie6vectorIfLj8EE8elem_refEj", scope: !188, file: !189, line: 336, type: !364, scopeLine: 337, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !368, retainedNodes: !3432)
!3432 = !{!3433, !3434}
!3433 = !DILocalVariable(name: "this", arg: 1, scope: !3431, type: !1856, flags: DIFlagArtificial | DIFlagObjectPointer)
!3434 = !DILocalVariable(name: "idx", arg: 2, scope: !3431, file: !189, line: 336, type: !15)
!3435 = !DILocation(line: 0, scope: !3431)
!3436 = !DILocation(line: 336, column: 81, scope: !3431)
!3437 = !DILocation(line: 338, column: 9, scope: !3431)
!3438 = !DILocation(line: 338, column: 9, scope: !3439)
!3439 = distinct !DILexicalBlock(scope: !3440, file: !189, line: 338, column: 9)
!3440 = distinct !DILexicalBlock(scope: !3431, file: !189, line: 338, column: 9)
!3441 = !DILocation(line: 338, column: 9, scope: !3440)
!3442 = !DILocation(line: 338, column: 9, scope: !3443)
!3443 = distinct !DILexicalBlock(scope: !3439, file: !189, line: 338, column: 9)
!3444 = !DILocation(line: 338, column: 9, scope: !3445)
!3445 = distinct !DILexicalBlock(scope: !3446, file: !189, line: 338, column: 9)
!3446 = distinct !DILexicalBlock(scope: !3443, file: !189, line: 338, column: 9)
!3447 = !DILocation(line: 338, column: 9, scope: !3446)
!3448 = !DILocation(line: 338, column: 9, scope: !3449)
!3449 = distinct !DILexicalBlock(scope: !3439, file: !189, line: 338, column: 9)
!3450 = !DILocation(line: 339, column: 24, scope: !3431)
!3451 = !DILocation(line: 339, column: 16, scope: !3431)
!3452 = !DILocation(line: 339, column: 9, scope: !3431)
!3453 = distinct !DISubprogram(name: "vector_elem_ref", linkageName: "_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj", scope: !322, file: !309, line: 241, type: !350, scopeLine: 244, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !349, retainedNodes: !3454)
!3454 = !{!3455, !3457, !3458}
!3455 = !DILocalVariable(name: "this", arg: 1, scope: !3453, type: !3456, flags: DIFlagArtificial | DIFlagObjectPointer)
!3456 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !322, size: 32)
!3457 = !DILocalVariable(name: "v", arg: 2, scope: !3453, file: !309, line: 241, type: !325)
!3458 = !DILocalVariable(name: "idx", arg: 3, scope: !3453, file: !309, line: 241, type: !15)
!3459 = !DILocation(line: 0, scope: !3453)
!3460 = !DILocation(line: 241, column: 44, scope: !3453)
!3461 = !DILocation(line: 241, column: 56, scope: !3453)
!3462 = !DILocation(line: 242, column: 9, scope: !3453)
!3463 = !DILocation(line: 242, column: 16, scope: !3453)
!3464 = !DILocation(line: 243, column: 9, scope: !3453)
!3465 = !DILocation(line: 243, column: 16, scope: !3453)
!3466 = !DILocation(line: 245, column: 5, scope: !3453)
!3467 = distinct !DISubprogram(name: "writeincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE", scope: !906, file: !907, line: 193, type: !922, scopeLine: 194, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !921, retainedNodes: !3468)
!3468 = !{!3469, !3470, !3471}
!3469 = !DILocalVariable(name: "_w", arg: 1, scope: !3467, file: !907, line: 193, type: !144)
!3470 = !DILocalVariable(name: "value", arg: 2, scope: !3467, file: !907, line: 193, type: !920)
!3471 = !DILocalVariable(name: "w", scope: !3467, file: !907, line: 195, type: !144)
!3472 = !DILocation(line: 193, column: 53, scope: !3467)
!3473 = !DILocation(line: 193, column: 62, scope: !3467)
!3474 = !DILocation(line: 195, column: 9, scope: !3467)
!3475 = !DILocation(line: 195, column: 37, scope: !3467)
!3476 = !DILocation(line: 195, column: 72, scope: !3467)
!3477 = !DILocation(line: 198, column: 25, scope: !3478)
!3478 = distinct !DILexicalBlock(scope: !3479, file: !907, line: 197, column: 59)
!3479 = distinct !DILexicalBlock(scope: !3467, file: !907, line: 197, column: 23)
!3480 = !DILocation(line: 198, column: 28, scope: !3478)
!3481 = !DILocation(line: 198, column: 43, scope: !3478)
!3482 = !DILocation(line: 198, column: 13, scope: !3478)
!3483 = !DILocation(line: 205, column: 5, scope: !3467)
!3484 = distinct !DISubprogram(name: "writeincr", linkageName: "_ZL9writeincrP14output_cascadeI8accfloatvE11v16accfloat", scope: !2271, file: !2271, line: 1035, type: !3485, scopeLine: 1035, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !3487)
!3485 = !DISubroutineType(types: !3486)
!3486 = !{null, !144, !488}
!3487 = !{!3488, !3489}
!3488 = !DILocalVariable(name: "str", arg: 1, scope: !3484, file: !2271, line: 1035, type: !144)
!3489 = !DILocalVariable(name: "value", arg: 2, scope: !3484, file: !2271, line: 1035, type: !488)
!3490 = !DILocation(line: 1035, column: 1, scope: !3484)
!3491 = distinct !DISubprogram(name: "kernelMatVecMulClass", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj9ELb1ELb1EEC2Ev", scope: !85, file: !86, line: 137, type: !157, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !156, retainedNodes: !3492)
!3492 = !{!3493}
!3493 = !DILocalVariable(name: "this", arg: 1, scope: !3491, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!3494 = !DILocation(line: 0, scope: !3491)
!3495 = !DILocation(line: 137, column: 29, scope: !3491)
!3496 = distinct !DISubprogram(linkageName: "_GLOBAL__sub_I_i2_wrap_matrix_vector_mul.cpp", scope: !1397, file: !1397, type: !3497, flags: DIFlagArtificial | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!3497 = !DISubroutineType(types: !137)
!3498 = !DILocation(line: 0, scope: !3496)
