; ModuleID = 'i0_wrap_matrix_vector_mul.ll'
source_filename = "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i0_wrap_matrix_vector_mul.cpp"
target datalayout = "e-i8:8:8-i16:16:16-i32:32:32-i64:32:32-f32:32:32-f64:32:32-p:32:32:32:32:8-s0:256:256-a0:8:8-S256-n32:64-P1-p0:20:32:32:32:8-p1:20:32:32:32:8-p2:20:32:32:32:8-p3:20:32:32:32:8-p4:20:32:32:32:8-p5:20:32:32:32:8-p6:20:32:32:32:8-p7:20:32:32:32:8-p8:20:32:32:32:8-p9:20:32:32:32:8-p10:20:32:32:32:8-p11:20:32:32:32:8-p12:20:32:32:32:8-p13:20:32:32:32:8-p14:20:32:32:32:8-p15:20:32:32:32:8"
target triple = "pdarch-unknown-unknown-elf"

%"class.xf::dsp::aie::blas::matrix_vector_mul::matrix_vector_mul" = type { %"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass" }
%"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass" = type { ptr }
%class.anon = type { i8 }
%"struct.aie::detail::utils::iteration_dim" = type { i8 }
%class.anon.10 = type { i8 }
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
%"class.aie::vector.1" = type { %"class.aie::detail::vector_base.2" }
%"class.aie::detail::vector_base.2" = type { %struct.v16float }
%struct.v16float = type { %struct.ipd.custom_type.v128int4.v128int4 }
%struct.ipd.custom_type.v128int4.v128int4 = type { i512 }
%struct.v16int32 = type { %struct.ipd.custom_type.v128int4.v128int4 }
%"class.aie::accum.3" = type { %"class.aie::detail::accum_base.4" }
%"class.aie::detail::accum_base.4" = type { %struct.v16accfloat }
%struct.v16accfloat = type { %struct.ipd.custom_type.v16acc32.v16acc32 }
%struct.ipd.custom_type.v16acc32.v16acc32 = type { i512 }
%struct.ipd.custom_type.uint1_t.uint1_t = type { i1 }
%"struct.aie::unary_op.5" = type { %"struct.aie::unary_op_common.6" }
%"struct.aie::unary_op_common.6" = type { %"class.aie::vector_elem_ref" }
%"struct.aie::unary_op.7" = type { %"struct.aie::unary_op_common.8" }
%"struct.aie::unary_op_common.8" = type { %"class.aie::vector" }
%"class.aie::vector_elem_const_ref" = type { ptr, i32 }
%class.anon.9 = type { ptr, ptr, ptr, ptr, ptr }
%struct.v32bfloat16 = type { %struct.ipd.custom_type.v128int4.v128int4 }
%struct.v16bfloat16 = type { %struct.ipd.custom_type.v64int4.v64int4 }
%struct.v32uint16 = type { %struct.ipd.custom_type.v128int4.v128int4 }
%struct.ipd.custom_type.uint4_t.uint4_t = type { i4 }
%struct.ipd.custom_type.uint5_t.uint5_t = type { i5 }
%class.anon.12 = type { ptr, ptr, ptr, ptr, ptr }

$_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev = comdat any

$_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv = comdat any

$_ZNK3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEC2Ev = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE = comdat any

$_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv = comdat any

$_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv = comdat any

$_ZN3aie6vectorIfLj8EEC2Ev = comdat any

$_ZN3aie5accumI8accfloatLj8EEC2Ev = comdat any

$_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv = comdat any

$_Z10readincr_vILj8E8accfloatEN3aie5accumIT0_XT_EEEP13input_cascadeIS3_vE = comdat any

$_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_ = comdat any

$_ZN3aie6vectorIfLj8EEixEj = comdat any

$_ZNK3aie5accumI8accfloatLj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi = comdat any

$_ZNK3aie6vectorIfLj8EE7extractILj8EEENS0_IfXT_EEEj = comdat any

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

$_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi = comdat any

$_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbi = comdat any

$_ZN3aie6detail5utils12unroll_timesILj1EZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOT0_ = comdat any

$_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOT3_ = comdat any

$_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_ = comdat any

$_ZZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiENKUljE_clEj = comdat any

$_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_ = comdat any

$_ZN3aie6vectorIfLj8EE6insertI7v8floatEERS1_jT_ = comdat any

$_ZZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_srsIfEEDavENKUlRKT_T0_T1_E_clIS3_ibEEDaS7_S8_S9_ = comdat any

$_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj = comdat any

$_ZN3aie6vectorIfLj8EEC2E7v8float = comdat any

$_ZN3aie6vectorIfLj8EE6insertILj8EEERS1_jRKNS0_IfXT_EEE = comdat any

$_ZN3aie6detail11vector_baseIfLj8EE6insertILj8EEERS2_jRKNS1_IfXT_EEE = comdat any

$_ZN3aie6detail11vector_baseIfLj8EE13insert_helperILj8EEEvjRKNS1_IfXT_EEE = comdat any

$_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEcv10v8accfloatEv = comdat any

$_ZN7v8floatC2E10v8accfloat = comdat any

$_ZNK3aie6detail11vector_baseIfLj8EE7extractILj8EEENS1_IfXT_EEEj = comdat any

$_ZNK3aie6detail11vector_baseIfLj8EE14extract_helperILj8EEENS1_IfXT_EEEj = comdat any

$_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEC2Ev = comdat any

@i0 = dso_local global %"class.xf::dsp::aie::blas::matrix_vector_mul::matrix_vector_mul" zeroinitializer, align 4, !dbg !0
@_ZN12me_primitive11control_rndE = external dso_local global i32, align 4
@_ZN12me_primitive11control_satE = external dso_local global i32, align 4
@__const._ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_.mul_op = private unnamed_addr constant %class.anon undef, align 1
@__const._ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_.it = private unnamed_addr constant %"struct.aie::detail::utils::iteration_dim" undef, align 1
@__const._ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbi.fn = private unnamed_addr constant %class.anon.10 undef, align 1
@__const._ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_.it = private unnamed_addr constant %"struct.aie::detail::utils::iteration_dim" undef, align 1
@llvm.global_ctors = appending global [1 x { i32, ptr addrspace(1), ptr }] [{ i32, ptr addrspace(1), ptr } { i32 65535, ptr addrspace(1) @_GLOBAL__sub_I_i0_wrap_matrix_vector_mul.cpp, ptr null }]

; Function Attrs: mustprogress noinline nounwind
define weak_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE(ptr nonnull align 4 dereferenceable(4) %this, ptr nonnull align 4 dereferenceable(32768) %inMatrixA, ptr chesscopy noalias nonnull align 4 dereferenceable(8) %inWindowB, ptr %inCascade, ptr chesscopy noalias nonnull align 4 dereferenceable(8) %outWindow) addrspace(1) #0 comdat align 2 !dbg !1532 !noalias !1542 {
entry:
  %this.addr = alloca ptr, align 4
  %inMatrixA.addr = alloca ptr, align 4
  %inWindowB.addr = alloca ptr, align 4
  %inCascade.addr = alloca ptr, align 4
  %outWindow.addr = alloca ptr, align 4
  %inInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %agg.tmp = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %agg.tmp6 = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545, !noalias !1549
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1534, metadata !DIExpression()), !dbg !1554
  store ptr %inMatrixA, ptr %inMatrixA.addr, align 4, !tbaa !1545, !noalias !1549
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inMatrixA.addr, metadata !1536, metadata !DIExpression()), !dbg !1555
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inWindowB.addr, i32 0, metadata !1556), !noalias !1549
  store ptr %inWindowB, ptr %inWindowB.addr, align 4, !tbaa !1545, !noalias !1549
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inWindowB.addr, metadata !1537, metadata !DIExpression()), !dbg !1557
  store ptr %inCascade, ptr %inCascade.addr, align 4, !tbaa !1545, !noalias !1549
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inCascade.addr, metadata !1538, metadata !DIExpression()), !dbg !1558
  %1 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outWindow.addr, i32 0, metadata !1559), !noalias !1549
  store ptr %outWindow, ptr %outWindow.addr, align 4, !tbaa !1545, !noalias !1549
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outWindow.addr, metadata !1539, metadata !DIExpression()), !dbg !1560
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1549
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" undef, ptr %inInterface, align 4, !dbg !1561, !noalias !1549
  call addrspace(1) void @llvm.lifetime.start.p0(i64 20, ptr %inInterface) #22, !dbg !1561, !noalias !1549
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !1540, metadata !DIExpression()), !dbg !1562
  %2 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inInterface, i32 0, metadata !1563), !dbg !1561, !noalias !1549
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(20) %inInterface) #23, !dbg !1562, !noalias !1549
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" undef, ptr %outInterface, align 4, !dbg !1564, !noalias !1549
  call addrspace(1) void @llvm.lifetime.start.p0(i64 16, ptr %outInterface) #22, !dbg !1564, !noalias !1549
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !1541, metadata !DIExpression()), !dbg !1565
  %3 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1566), !dbg !1564, !noalias !1549
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(16) %outInterface) #23, !dbg !1565, !noalias !1549
  %4 = load ptr, ptr %inWindowB.addr, align 4, !dbg !1567, !tbaa !1545, !noalias !1549
  %call = call addrspace(1) ptr @_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv(ptr nonnull align 4 dereferenceable(8) %4) #24, !dbg !1568, !noalias !1549
  %inWindowB2 = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 1, !dbg !1569
  store ptr %call, ptr %inWindowB2, align 4, !dbg !1570, !tbaa !1571, !noalias !1549
  %5 = load ptr, ptr %inCascade.addr, align 4, !dbg !1573, !tbaa !1545, !noalias !1549
  %inCascade3 = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 4, !dbg !1574
  store ptr %5, ptr %inCascade3, align 4, !dbg !1575, !tbaa !1576, !noalias !1549
  %6 = load ptr, ptr %outWindow.addr, align 4, !dbg !1577, !tbaa !1545, !noalias !1549
  %call4 = call addrspace(1) ptr @_ZNK3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv(ptr nonnull align 4 dereferenceable(8) %6) #24, !dbg !1578, !noalias !1549
  %outWindow5 = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %outInterface, i32 0, i32 0, !dbg !1579
  store ptr %call4, ptr %outWindow5, align 4, !dbg !1580, !tbaa !1581, !noalias !1549
  %7 = load ptr, ptr %inMatrixA.addr, align 4, !dbg !1583, !tbaa !1545, !noalias !1549
  %arraydecay = getelementptr inbounds [8192 x float], ptr %7, i32 0, i32 0, !dbg !1583
  %m_inMatrixPtr = getelementptr inbounds %"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass", ptr %this1, i32 0, i32 0, !dbg !1584
  store ptr %arraydecay, ptr %m_inMatrixPtr, align 4, !dbg !1585, !tbaa !1586, !noalias !1549
  %8 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %inInterface, ptr %2, metadata !1588, metadata !1563), !dbg !1589
  %9 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %8, align 4, !dbg !1589, !tbaa !1590, !noalias !1549
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" %9, ptr %agg.tmp, align 4, !dbg !1589, !tbaa !1590, !noalias !1549
  %10 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %outInterface, ptr %3, metadata !1591, metadata !1566), !dbg !1592
  %11 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %10, align 4, !dbg !1592, !tbaa !1593, !noalias !1549
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %11, ptr %agg.tmp6, align 4, !dbg !1592, !tbaa !1593, !noalias !1549
  %12 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %agg.tmp6, ptr null, metadata !1591, metadata !1542), !dbg !1594
  %13 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %12, align 4, !dbg !1594, !tbaa !1593, !noalias !1549
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this1, ptr %agg.tmp, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %13) #24, !dbg !1594, !noalias !1549
  call addrspace(1) void @llvm.lifetime.end.p0(i64 16, ptr %outInterface) #22, !dbg !1595
  call addrspace(1) void @llvm.lifetime.end.p0(i64 20, ptr %inInterface) #22, !dbg !1595
  ret void, !dbg !1595
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) addrspace(1) #1

; Function Attrs: nounwind willreturn memory(inaccessiblemem: readwrite)
declare ptr @llvm.noalias.decl.p0.p0.i32(ptr, i32, metadata) addrspace(1) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) addrspace(1) #3

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(20) %this) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !1596 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1602, metadata !DIExpression()), !dbg !1604
  %this1 = load ptr, ptr %this.addr, align 4
  %inCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %this1, i32 0, i32 4, !dbg !1605
  store ptr null, ptr %inCascade, align 4, !dbg !1605, !tbaa !1576
  ret void, !dbg !1606
}

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev(ptr nonnull align 4 dereferenceable(16) %this) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !1607 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1613, metadata !DIExpression()), !dbg !1615
  %this1 = load ptr, ptr %this.addr, align 4
  %outCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %this1, i32 0, i32 3, !dbg !1616
  store ptr null, ptr %outCascade, align 4, !dbg !1616, !tbaa !1617
  ret void, !dbg !1618
}

; Function Attrs: inlinehint mustprogress nounwind
define linkonce_odr dso_local ptr @_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #5 comdat align 2 !dbg !1619 !noalias !1631 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545, !noalias !1631
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1629, metadata !DIExpression()), !dbg !1634
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1631
  %_base = getelementptr inbounds %"struct.adf::detail::io_buffer_base", ptr %this1, i32 0, i32 0, !dbg !1635
  %0 = load ptr, ptr %_base, align 4, !dbg !1635, !tbaa !1637, !noalias !1631
  %1 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %0, ptr null, ptr %_base, i32 0, metadata !1631), !dbg !1635, !tbaa !1637, !noalias !1631
  ret ptr %1, !dbg !1639
}

; Function Attrs: inlinehint mustprogress nounwind
define linkonce_odr dso_local ptr @_ZNK3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #5 comdat align 2 !dbg !1640 !noalias !1652 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545, !noalias !1652
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1650, metadata !DIExpression()), !dbg !1655
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1652
  %_base = getelementptr inbounds %"struct.adf::detail::io_buffer_base", ptr %this1, i32 0, i32 0, !dbg !1656
  %0 = load ptr, ptr %_base, align 4, !dbg !1656, !tbaa !1637, !noalias !1652
  %1 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %0, ptr null, ptr %_base, i32 0, metadata !1652), !dbg !1656, !tbaa !1637, !noalias !1652
  ret ptr %1, !dbg !1658
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this, ptr %inInterface, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce) addrspace(1) #6 comdat align 2 !dbg !1659 !noalias !1664 {
entry:
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %this.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %agg.tmp2 = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce, ptr %outInterface, align 4, !noalias !1667
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545, !noalias !1667
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1661, metadata !DIExpression()), !dbg !1669
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !1662, metadata !DIExpression()), !dbg !1670
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1671), !noalias !1667
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !1663, metadata !DIExpression()), !dbg !1672
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1667
  %1 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %inInterface, ptr null, metadata !1588, metadata !1664), !dbg !1673
  %2 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %1, align 4, !dbg !1673, !tbaa !1590, !noalias !1667
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" %2, ptr %agg.tmp, align 4, !dbg !1673, !tbaa !1590, !noalias !1667
  %3 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %outInterface, ptr %0, metadata !1591, metadata !1671), !dbg !1674
  %4 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %3, align 4, !dbg !1674, !tbaa !1593, !noalias !1667
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %4, ptr %agg.tmp2, align 4, !dbg !1674, !tbaa !1593, !noalias !1667
  %5 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %agg.tmp2, ptr null, metadata !1591, metadata !1664), !dbg !1675
  %6 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %5, align 4, !dbg !1675, !tbaa !1593, !noalias !1667
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this1, ptr %agg.tmp, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %6) #24, !dbg !1675, !noalias !1667
  ret void, !dbg !1676
}

; Function Attrs: nounwind willreturn memory(none)
declare ptr @llvm.noalias.copy.guard.p0.p0(ptr, ptr, metadata, metadata) addrspace(1) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) addrspace(1) #3

; Function Attrs: nounwind
define internal void @__cxx_global_var_init() addrspace(1) #8 !dbg !1677 {
entry:
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEC2Ev(ptr nonnull align 4 dereferenceable(4) @i0) #24, !dbg !1678
  ret void, !dbg !1678
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEC2Ev(ptr nonnull align 4 dereferenceable(4) %this) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !1679 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1681, metadata !DIExpression()), !dbg !1682
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEC2Ev(ptr nonnull align 4 dereferenceable(4) %this1) #24, !dbg !1683
  ret void, !dbg !1684
}

; Function Attrs: mustprogress nounwind
define dso_local ptr @_Z7i0_userv() addrspace(1) #9 !dbg !1685 {
entry:
  ret ptr @i0, !dbg !1688
}

; Function Attrs: nounwind speculatable willreturn memory(argmem: readwrite)
declare ptr @llvm.noalias.p0.p0.p0.i32(ptr, ptr, ptr, i32, metadata) addrspace(1) #10

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this, ptr %inInterface, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce) addrspace(1) #6 comdat align 2 !dbg !1689 !noalias !1694 {
entry:
  %outInterface = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  %this.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", align 4
  %agg.tmp2 = alloca %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", align 4
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce, ptr %outInterface, align 4, !noalias !1697
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545, !noalias !1697
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1691, metadata !DIExpression()), !dbg !1699
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !1692, metadata !DIExpression()), !dbg !1700
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1701), !noalias !1697
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !1693, metadata !DIExpression()), !dbg !1702
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1697
  %1 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %inInterface, ptr null, metadata !1588, metadata !1694), !dbg !1703
  %2 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %1, align 4, !dbg !1703, !tbaa !1590, !noalias !1697
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF" %2, ptr %agg.tmp, align 4, !dbg !1703, !tbaa !1590, !noalias !1697
  %3 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %outInterface, ptr %0, metadata !1591, metadata !1701), !dbg !1706
  %4 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %3, align 4, !dbg !1706, !tbaa !1593, !noalias !1697
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %4, ptr %agg.tmp2, align 4, !dbg !1706, !tbaa !1593, !noalias !1697
  %5 = call addrspace(1) ptr @llvm.noalias.copy.guard.p0.p0(ptr %agg.tmp2, ptr null, metadata !1591, metadata !1694), !dbg !1707
  %6 = load %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %5, align 4, !dbg !1707, !tbaa !1593, !noalias !1697
  call addrspace(1) void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this1, ptr %agg.tmp, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %6) #24, !dbg !1707, !noalias !1697
  ret void, !dbg !1708
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE(ptr nonnull align 4 dereferenceable(4) %this, ptr %inInterface, %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce) addrspace(1) #6 comdat align 2 !dbg !84 !noalias !1709 {
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
  %agg.tmp31 = alloca %"class.aie::vector", align 32
  %n = alloca i32, align 4
  %agg.tmp37 = alloca %"class.aie::vector", align 32
  store %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF" %outInterface.coerce, ptr %outInterface, align 4, !noalias !1712
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !179, metadata !DIExpression()), !dbg !1722
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inInterface, metadata !181, metadata !DIExpression()), !dbg !1723
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outInterface, i32 0, metadata !1724), !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outInterface, metadata !182, metadata !DIExpression()), !dbg !1725
  %this1 = load ptr, ptr %this.addr, align 4, !noalias !1712
  call addrspace(1) void @_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv() #24, !dbg !1726, !noalias !1712
  call addrspace(1) void @_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv() #24, !dbg !1727, !noalias !1712
  store %"class.aie::vector" undef, ptr %dataA, align 32, !dbg !1728, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %dataA) #22, !dbg !1728, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %dataA, metadata !183, metadata !DIExpression()), !dbg !1729
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !1729, !noalias !1712
  %1 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !1729, !tbaa !1730, !noalias !1712
  store %"class.aie::vector" %1, ptr %dataA, align 32, !dbg !1729, !tbaa !1730, !noalias !1712
  store ptr undef, ptr %inPtrA, align 4, !dbg !1734, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inPtrA) #22, !dbg !1734, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inPtrA, metadata !184, metadata !DIExpression()), !dbg !1735
  %2 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inPtrA, i32 0, metadata !1736), !dbg !1734, !noalias !1712
  store %"class.aie::vector" undef, ptr %dataB, align 32, !dbg !1737, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %dataB) #22, !dbg !1737, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %dataB, metadata !186, metadata !DIExpression()), !dbg !1738
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp2) #24, !dbg !1738, !noalias !1712
  %3 = load %"class.aie::vector", ptr %custom_type.tmp2, align 32, !dbg !1738, !tbaa !1730, !noalias !1712
  store %"class.aie::vector" %3, ptr %dataB, align 32, !dbg !1738, !tbaa !1730, !noalias !1712
  store ptr undef, ptr %inPtrB, align 4, !dbg !1739, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inPtrB) #22, !dbg !1739, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inPtrB, metadata !369, metadata !DIExpression()), !dbg !1740
  %4 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inPtrB, i32 0, metadata !1741), !dbg !1739, !noalias !1712
  store %"class.aie::accum" undef, ptr %acc, align 32, !dbg !1742, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %acc) #22, !dbg !1742, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !372, metadata !DIExpression()), !dbg !1743
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp3) #24, !dbg !1743, !noalias !1712
  %5 = load %"class.aie::accum", ptr %custom_type.tmp3, align 32, !dbg !1743, !tbaa !1744, !noalias !1712
  store %"class.aie::accum" %5, ptr %acc, align 32, !dbg !1743, !tbaa !1744, !noalias !1712
  store %"class.aie::vector" undef, ptr %blankVect, align 32, !dbg !1748, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %blankVect) #22, !dbg !1748, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %blankVect, metadata !460, metadata !DIExpression()), !dbg !1749
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv() #24, !dbg !1750, !noalias !1712
  %6 = getelementptr inbounds %"class.aie::vector", ptr %blankVect, i32 0, i32 0, !dbg !1750
  %7 = extractvalue %"class.aie::vector" %call, 0, !dbg !1750
  store %"class.aie::detail::vector_base" %7, ptr %6, align 32, !dbg !1750, !noalias !1712
  store %"class.aie::vector" undef, ptr %outVect, align 32, !dbg !1751, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %outVect) #22, !dbg !1751, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outVect, metadata !462, metadata !DIExpression()), !dbg !1752
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp4) #24, !dbg !1752, !noalias !1712
  %8 = load %"class.aie::vector", ptr %custom_type.tmp4, align 32, !dbg !1752, !tbaa !1730, !noalias !1712
  store %"class.aie::vector" %8, ptr %outVect, align 32, !dbg !1752, !tbaa !1730, !noalias !1712
  store ptr undef, ptr %inMatrixBuff, align 4, !dbg !1753, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inMatrixBuff) #22, !dbg !1753, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inMatrixBuff, metadata !463, metadata !DIExpression()), !dbg !1754
  %9 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inMatrixBuff, i32 0, metadata !1755), !dbg !1753, !noalias !1712
  %inWindowA = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 0, !dbg !1756
  %10 = load ptr, ptr %inWindowA, align 4, !dbg !1756, !tbaa !1757, !noalias !1712
  %11 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %10, ptr null, ptr %inWindowA, i32 0, metadata !1709), !dbg !1756, !tbaa !1757, !noalias !1712
  %12 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %11), !dbg !1754
  store ptr %12, ptr %inMatrixBuff, align 4, !dbg !1754, !tbaa !1545, !noalias !1712
  store ptr undef, ptr %inMatrixPtrRtp, align 4, !dbg !1758, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %inMatrixPtrRtp) #22, !dbg !1758, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inMatrixPtrRtp, metadata !464, metadata !DIExpression()), !dbg !1759
  %13 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %inMatrixPtrRtp, i32 0, metadata !1760), !dbg !1758, !noalias !1712
  %m_inMatrixPtr = getelementptr inbounds %"class.xf::dsp::aie::blas::matrix_vector_mul::kernelMatVecMulClass", ptr %this1, i32 0, i32 0, !dbg !1761
  %14 = load ptr, ptr %m_inMatrixPtr, align 4, !dbg !1761, !tbaa !1586, !noalias !1712
  %15 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %14, ptr null, ptr %m_inMatrixPtr, i32 0, metadata !1709), !dbg !1761, !tbaa !1586, !noalias !1712
  %16 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %15), !dbg !1759
  store ptr %16, ptr %inMatrixPtrRtp, align 4, !dbg !1759, !tbaa !1545, !noalias !1712
  store ptr undef, ptr %matrixPtr, align 4, !dbg !1762, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %matrixPtr) #22, !dbg !1762, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %matrixPtr, metadata !465, metadata !DIExpression()), !dbg !1763
  %17 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %matrixPtr, i32 0, metadata !1764), !dbg !1762, !noalias !1712
  %18 = load ptr, ptr %inMatrixPtrRtp, align 4, !dbg !1765, !tbaa !1545, !noalias !1712
  %19 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %18, ptr %13, ptr %inMatrixPtrRtp, i32 0, metadata !1760), !dbg !1765, !tbaa !1545, !noalias !1712
  %20 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %19), !dbg !1763
  store ptr %20, ptr %matrixPtr, align 4, !dbg !1763, !tbaa !1545, !noalias !1712
  store ptr undef, ptr %matrixStartPtr, align 4, !dbg !1766, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %matrixStartPtr) #22, !dbg !1766, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %matrixStartPtr, metadata !466, metadata !DIExpression()), !dbg !1767
  %21 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %matrixStartPtr, i32 0, metadata !1768), !dbg !1766, !noalias !1712
  %22 = load ptr, ptr %matrixPtr, align 4, !dbg !1769, !tbaa !1545, !noalias !1712
  %23 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %22, ptr %17, ptr %matrixPtr, i32 0, metadata !1764), !dbg !1769, !tbaa !1545, !noalias !1712
  %24 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %23), !dbg !1767
  store ptr %24, ptr %matrixStartPtr, align 4, !dbg !1767, !tbaa !1545, !noalias !1712
  store ptr undef, ptr %vectorStartPtr, align 4, !dbg !1770, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %vectorStartPtr) #22, !dbg !1770, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %vectorStartPtr, metadata !467, metadata !DIExpression()), !dbg !1771
  %25 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %vectorStartPtr, i32 0, metadata !1772), !dbg !1770, !noalias !1712
  %inWindowB = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 1, !dbg !1773
  %26 = load ptr, ptr %inWindowB, align 4, !dbg !1773, !tbaa !1571, !noalias !1712
  %27 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %26, ptr null, ptr %inWindowB, i32 0, metadata !1709), !dbg !1773, !tbaa !1571, !noalias !1712
  %28 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %27), !dbg !1771
  store ptr %28, ptr %vectorStartPtr, align 4, !dbg !1771, !tbaa !1545, !noalias !1712
  store ptr undef, ptr %outPtr, align 4, !dbg !1774, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %outPtr) #22, !dbg !1774, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %outPtr, metadata !468, metadata !DIExpression()), !dbg !1775
  %29 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %outPtr, i32 0, metadata !1776), !dbg !1774, !noalias !1712
  %outWindow = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_outputIF", ptr %outInterface, i32 0, i32 0, !dbg !1777
  %30 = load ptr, ptr %outWindow, align 4, !dbg !1777, !tbaa !1581, !noalias !1712
  %31 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %30, ptr %0, ptr %outWindow, i32 0, metadata !1724), !dbg !1777, !tbaa !1581, !noalias !1712
  %32 = call addrspace(1) ptr @llvm.chess.copy.p0(ptr %31), !dbg !1775
  store ptr %32, ptr %outPtr, align 4, !dbg !1775, !tbaa !1545, !noalias !1712
  store i32 undef, ptr %frame, align 4, !dbg !1778, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %frame) #22, !dbg !1778, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %frame, metadata !472, metadata !DIExpression()), !dbg !1779
  store i32 0, ptr %frame, align 4, !dbg !1779, !tbaa !1780, !noalias !1712
  br label %for.cond, !dbg !1778

for.cond:                                         ; preds = %for.inc45, %entry
  %33 = load i32, ptr %frame, align 4, !dbg !1782, !tbaa !1780, !noalias !1712
  %cmp = icmp ult i32 %33, 1, !dbg !1783
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !1784

for.cond.cleanup:                                 ; preds = %for.cond
  store i32 2, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %frame) #22, !dbg !1785, !noalias !1712
  br label %for.end47

for.body:                                         ; preds = %for.cond
  store i32 undef, ptr %idx, align 4, !dbg !1786, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %idx) #22, !dbg !1786, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx, metadata !474, metadata !DIExpression()), !dbg !1787
  store i32 0, ptr %idx, align 4, !dbg !1787, !tbaa !1780, !noalias !1712
  br label %for.pre_assume, !dbg !1786

for.pre_assume:                                   ; preds = %for.body
  %34 = load i32, ptr %idx, align 4, !dbg !1788, !tbaa !1780, !noalias !1712
  %cmp7 = icmp slt i32 %34, 16, !dbg !1789
  call addrspace(1) void @llvm.assume(i1 %cmp7), !dbg !1790, !noalias !1712
  br label %for.body9, !dbg !1790

for.cond5:                                        ; preds = %for.inc42
  %35 = load i32, ptr %idx, align 4, !dbg !1788, !tbaa !1780, !noalias !1712
  %cmp6 = icmp slt i32 %35, 16, !dbg !1789
  br i1 %cmp6, label %for.body9, label %for.cond.cleanup8, !dbg !1790, !llvm.loop !1791

for.cond.cleanup8:                                ; preds = %for.cond5
  store i32 5, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %idx) #22, !dbg !1798, !noalias !1712
  br label %for.end44

for.body9:                                        ; preds = %for.cond5, %for.pre_assume
  %36 = load ptr, ptr %matrixStartPtr, align 4, !dbg !1799, !tbaa !1545, !noalias !1712
  %37 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %36, ptr %21, ptr %matrixStartPtr, i32 0, metadata !1768), !dbg !1799, !tbaa !1545, !noalias !1712
  %38 = load i32, ptr %frame, align 4, !dbg !1800, !tbaa !1780, !noalias !1712
  %mul = mul nsw i32 %38, 1024, !dbg !1801
  %add.ptr = getelementptr inbounds %"class.aie::vector", ptr %37, i32 %mul, !dbg !1802
  %39 = load i32, ptr %idx, align 4, !dbg !1803, !tbaa !1780, !noalias !1712
  %add.ptr10 = getelementptr inbounds %"class.aie::vector", ptr %add.ptr, i32 %39, !dbg !1804
  store ptr %add.ptr10, ptr %inPtrA, align 4, !dbg !1805, !tbaa !1545, !noalias !1712
  %40 = load ptr, ptr %vectorStartPtr, align 4, !dbg !1806, !tbaa !1545, !noalias !1712
  %41 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %40, ptr %25, ptr %vectorStartPtr, i32 0, metadata !1772), !dbg !1806, !tbaa !1545, !noalias !1712
  %42 = load i32, ptr %frame, align 4, !dbg !1807, !tbaa !1780, !noalias !1712
  %mul11 = mul nsw i32 %42, 8, !dbg !1808
  %add.ptr12 = getelementptr inbounds %"class.aie::vector", ptr %41, i32 %mul11, !dbg !1809
  store ptr %add.ptr12, ptr %inPtrB, align 4, !dbg !1810, !tbaa !1545, !noalias !1712
  %inCascade = getelementptr inbounds %"struct.xf::dsp::aie::blas::matrix_vector_mul::T_inputIF", ptr %inInterface, i32 0, i32 4, !dbg !1811
  %43 = load ptr, ptr %inCascade, align 4, !dbg !1811, !tbaa !1576, !noalias !1712
  %call13 = call addrspace(1) %"class.aie::accum" @_Z10readincr_vILj8E8accfloatEN3aie5accumIT0_XT_EEEP13input_cascadeIS3_vE(ptr %43) #24, !dbg !1814, !noalias !1712
  %44 = getelementptr inbounds %"class.aie::accum", ptr %agg.tmp, i32 0, i32 0, !dbg !1814
  %45 = extractvalue %"class.aie::accum" %call13, 0, !dbg !1814
  store %"class.aie::detail::accum_base" %45, ptr %44, align 32, !dbg !1814, !noalias !1712
  %46 = load %"class.aie::accum", ptr %agg.tmp, align 32, !dbg !1815, !tbaa !1744, !noalias !1712
  store %"class.aie::accum" %46, ptr %acc, align 32, !dbg !1815, !tbaa !1744, !noalias !1712
  store i32 undef, ptr %vecInB, align 4, !dbg !1816, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %vecInB) #22, !dbg !1816, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %vecInB, metadata !478, metadata !DIExpression()), !dbg !1817
  store i32 0, ptr %vecInB, align 4, !dbg !1817, !tbaa !1780, !noalias !1712
  br label %for.cond14, !dbg !1816

for.cond14:                                       ; preds = %for.inc27, %for.body9
  %47 = load i32, ptr %vecInB, align 4, !dbg !1818, !tbaa !1780, !noalias !1712
  %cmp15 = icmp slt i32 %47, 8, !dbg !1819
  br i1 %cmp15, label %for.body17, label %for.cond.cleanup16, !dbg !1820

for.cond.cleanup16:                               ; preds = %for.cond14
  store i32 8, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %vecInB) #22, !dbg !1821, !noalias !1712
  br label %for.end29

for.body17:                                       ; preds = %for.cond14
  %48 = load ptr, ptr %inPtrB, align 4, !dbg !1822, !tbaa !1545, !noalias !1712
  %49 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %48, ptr %4, ptr %inPtrB, i32 0, metadata !1741), !dbg !1822, !tbaa !1545, !noalias !1712
  %incdec.ptr = getelementptr inbounds %"class.aie::vector", ptr %49, i32 1, !dbg !1822
  store ptr %incdec.ptr, ptr %inPtrB, align 4, !dbg !1822, !tbaa !1545, !noalias !1712
  %50 = load %"class.aie::vector", ptr %49, align 32, !dbg !1823, !tbaa !1730, !noalias !1712
  store %"class.aie::vector" %50, ptr %dataB, align 32, !dbg !1823, !tbaa !1730, !noalias !1712
  store i32 undef, ptr %jdx, align 4, !dbg !1824, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %jdx) #22, !dbg !1824, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %jdx, metadata !482, metadata !DIExpression()), !dbg !1825
  store i32 0, ptr %jdx, align 4, !dbg !1825, !tbaa !1780, !noalias !1712
  br label %for.cond18, !dbg !1824

for.cond18:                                       ; preds = %for.inc, %for.body17
  %51 = load i32, ptr %jdx, align 4, !dbg !1826, !tbaa !1780, !noalias !1712
  %cmp19 = icmp slt i32 %51, 8, !dbg !1828
  br i1 %cmp19, label %for.body21, label %for.cond.cleanup20, !dbg !1829

for.cond.cleanup20:                               ; preds = %for.cond18
  store i32 11, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %jdx) #22, !dbg !1830, !noalias !1712
  br label %for.end

for.body21:                                       ; preds = %for.cond18
  %52 = load ptr, ptr %inPtrA, align 4, !dbg !1831, !tbaa !1545, !noalias !1712
  %53 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %52, ptr %2, ptr %inPtrA, i32 0, metadata !1736), !dbg !1831, !tbaa !1545, !noalias !1712
  %54 = load %"class.aie::vector", ptr %53, align 32, !dbg !1833, !tbaa !1730, !noalias !1712
  store %"class.aie::vector" %54, ptr %dataA, align 32, !dbg !1833, !tbaa !1730, !noalias !1712
  %55 = load ptr, ptr %inPtrA, align 4, !dbg !1834, !tbaa !1545, !noalias !1712
  %56 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %55, ptr %2, ptr %inPtrA, i32 0, metadata !1736), !dbg !1834, !tbaa !1545, !noalias !1712
  %add.ptr22 = getelementptr inbounds %"class.aie::vector", ptr %56, i32 16, !dbg !1834
  store ptr %add.ptr22, ptr %inPtrA, align 4, !dbg !1834, !tbaa !1545, !noalias !1712
  %57 = load i32, ptr %jdx, align 4, !dbg !1835, !tbaa !1780, !noalias !1712
  %call24 = call addrspace(1) %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EEixEj(ptr nonnull align 32 dereferenceable(32) %dataB, i32 %57) #24, !dbg !1838, !noalias !1712
  %58 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %agg.tmp23, i32 0, i32 0, !dbg !1838
  %59 = extractvalue %"class.aie::vector_elem_ref" %call24, 0, !dbg !1838
  store ptr %59, ptr %58, align 4, !dbg !1838, !noalias !1712
  %60 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %agg.tmp23, i32 0, i32 1, !dbg !1838
  %61 = extractvalue %"class.aie::vector_elem_ref" %call24, 1, !dbg !1838
  store i32 %61, ptr %60, align 4, !dbg !1838, !noalias !1712
  %62 = load %"class.aie::vector_elem_ref", ptr %agg.tmp23, align 4, !dbg !1839, !tbaa !1840, !noalias !1712
  %call25 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"class.aie::vector_elem_ref" %62, ptr nonnull align 32 dereferenceable(32) %dataA) #24, !dbg !1839, !noalias !1712
  %63 = getelementptr inbounds %"class.aie::accum", ptr %agg.tmp26, i32 0, i32 0, !dbg !1839
  %64 = extractvalue %"class.aie::accum" %call25, 0, !dbg !1839
  store %"class.aie::detail::accum_base" %64, ptr %63, align 32, !dbg !1839, !noalias !1712
  %65 = load %"class.aie::accum", ptr %agg.tmp26, align 32, !dbg !1842, !tbaa !1744, !noalias !1712
  store %"class.aie::accum" %65, ptr %acc, align 32, !dbg !1842, !tbaa !1744, !noalias !1712
  br label %for.inc, !dbg !1843

for.inc:                                          ; preds = %for.body21
  %66 = load i32, ptr %jdx, align 4, !dbg !1844, !tbaa !1780, !noalias !1712
  %inc = add nsw i32 %66, 1, !dbg !1844
  store i32 %inc, ptr %jdx, align 4, !dbg !1844, !tbaa !1780, !noalias !1712
  br label %for.cond18, !dbg !1830, !llvm.loop !1845

for.end:                                          ; preds = %for.cond.cleanup20
  br label %for.inc27, !dbg !1848

for.inc27:                                        ; preds = %for.end
  %67 = load i32, ptr %vecInB, align 4, !dbg !1849, !tbaa !1780, !noalias !1712
  %inc28 = add nsw i32 %67, 1, !dbg !1849
  store i32 %inc28, ptr %vecInB, align 4, !dbg !1849, !tbaa !1780, !noalias !1712
  br label %for.cond14, !dbg !1821, !llvm.loop !1850

for.end29:                                        ; preds = %for.cond.cleanup16
  %call30 = call addrspace(1) %"class.aie::vector" @_ZNK3aie5accumI8accfloatLj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %acc, i32 0) #24, !dbg !1852, !noalias !1712
  %68 = getelementptr inbounds %"class.aie::vector", ptr %agg.tmp31, i32 0, i32 0, !dbg !1852
  %69 = extractvalue %"class.aie::vector" %call30, 0, !dbg !1852
  store %"class.aie::detail::vector_base" %69, ptr %68, align 32, !dbg !1852, !noalias !1712
  %70 = load %"class.aie::vector", ptr %agg.tmp31, align 32, !dbg !1853, !tbaa !1730, !noalias !1712
  store %"class.aie::vector" %70, ptr %outVect, align 32, !dbg !1853, !tbaa !1730, !noalias !1712
  store i32 undef, ptr %n, align 4, !dbg !1854, !noalias !1712
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %n) #22, !dbg !1854, !noalias !1712
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %n, metadata !486, metadata !DIExpression()), !dbg !1855
  store i32 0, ptr %n, align 4, !dbg !1855, !tbaa !1780, !noalias !1712
  br label %for.cond32, !dbg !1854

for.cond32:                                       ; preds = %for.inc39, %for.end29
  %71 = load i32, ptr %n, align 4, !dbg !1856, !tbaa !1780, !noalias !1712
  %cmp33 = icmp slt i32 %71, 1, !dbg !1858
  br i1 %cmp33, label %for.body35, label %for.cond.cleanup34, !dbg !1859

for.cond.cleanup34:                               ; preds = %for.cond32
  store i32 14, ptr %cleanup.dest.slot, align 4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %n) #22, !dbg !1860, !noalias !1712
  br label %for.end41

for.body35:                                       ; preds = %for.cond32
  %72 = load i32, ptr %n, align 4, !dbg !1861, !tbaa !1780, !noalias !1712
  %call36 = call addrspace(1) %"class.aie::vector" @_ZNK3aie6vectorIfLj8EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %outVect, i32 %72) #24, !dbg !1863, !noalias !1712
  %73 = getelementptr inbounds %"class.aie::vector", ptr %agg.tmp37, i32 0, i32 0, !dbg !1863
  %74 = extractvalue %"class.aie::vector" %call36, 0, !dbg !1863
  store %"class.aie::detail::vector_base" %74, ptr %73, align 32, !dbg !1863, !noalias !1712
  %75 = load ptr, ptr %outPtr, align 4, !dbg !1864, !tbaa !1545, !noalias !1712
  %76 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %75, ptr %29, ptr %outPtr, i32 0, metadata !1776), !dbg !1864, !tbaa !1545, !noalias !1712
  %incdec.ptr38 = getelementptr inbounds %"class.aie::vector", ptr %76, i32 1, !dbg !1864
  store ptr %incdec.ptr38, ptr %outPtr, align 4, !dbg !1864, !tbaa !1545, !noalias !1712
  %77 = load %"class.aie::vector", ptr %agg.tmp37, align 32, !dbg !1865, !tbaa !1730, !noalias !1712
  store %"class.aie::vector" %77, ptr %76, align 32, !dbg !1865, !tbaa !1730, !noalias !1712
  br label %for.inc39, !dbg !1866

for.inc39:                                        ; preds = %for.body35
  %78 = load i32, ptr %n, align 4, !dbg !1867, !tbaa !1780, !noalias !1712
  %inc40 = add nsw i32 %78, 1, !dbg !1867
  store i32 %inc40, ptr %n, align 4, !dbg !1867, !tbaa !1780, !noalias !1712
  br label %for.cond32, !dbg !1860, !llvm.loop !1868

for.end41:                                        ; preds = %for.cond.cleanup34
  br label %for.inc42, !dbg !1871

for.inc42:                                        ; preds = %for.end41
  %79 = load i32, ptr %idx, align 4, !dbg !1872, !tbaa !1780, !noalias !1712
  %inc43 = add nsw i32 %79, 1, !dbg !1872
  store i32 %inc43, ptr %idx, align 4, !dbg !1872, !tbaa !1780, !noalias !1712
  br label %for.cond5, !dbg !1798, !llvm.loop !1791

for.end44:                                        ; preds = %for.cond.cleanup8
  br label %for.inc45, !dbg !1873

for.inc45:                                        ; preds = %for.end44
  %80 = load i32, ptr %frame, align 4, !dbg !1874, !tbaa !1780, !noalias !1712
  %inc46 = add nsw i32 %80, 1, !dbg !1874
  store i32 %inc46, ptr %frame, align 4, !dbg !1874, !tbaa !1780, !noalias !1712
  br label %for.cond, !dbg !1785, !llvm.loop !1875

for.end47:                                        ; preds = %for.cond.cleanup
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %outPtr) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %vectorStartPtr) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %matrixStartPtr) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %matrixPtr) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inMatrixPtrRtp) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inMatrixBuff) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %outVect) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %blankVect) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %acc) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inPtrB) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %dataB) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %inPtrA) #22, !dbg !1877
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %dataA) #22, !dbg !1877
  ret void, !dbg !1877
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv() addrspace(1) #6 comdat !dbg !1878 {
entry:
  call addrspace(1) void @_ZN3aieL12set_roundingENS_13rounding_modeE(i32 0) #24, !dbg !1882
  ret void, !dbg !1885
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv() addrspace(1) #6 comdat !dbg !1886 {
entry:
  call addrspace(1) void @_ZN3aieL14set_saturationENS_15saturation_modeE(i32 0) #24, !dbg !1889
  ret void, !dbg !1892
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1893 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1895, metadata !DIExpression()), !dbg !1897
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this1) #24, !dbg !1898
  ret void, !dbg !1899
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !1900 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1902, metadata !DIExpression()), !dbg !1904
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this1) #24, !dbg !1905
  ret void, !dbg !1906
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv() addrspace(1) #6 comdat !dbg !1907 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv() #24, !dbg !1910
  %0 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !1910
  %1 = extractvalue %"class.aie::vector" %call, 0, !dbg !1910
  store %"class.aie::detail::vector_base" %1, ptr %0, align 32, !dbg !1910
  %2 = load %"class.aie::vector", ptr %retval, align 32, !dbg !1911
  ret %"class.aie::vector" %2, !dbg !1911
}

; Function Attrs: nocse nounwind willreturn memory(none)
declare ptr @llvm.chess.copy.p0(ptr) addrspace(1) #12

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) addrspace(1) #13

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_Z10readincr_vILj8E8accfloatEN3aie5accumIT0_XT_EEEP13input_cascadeIS3_vE(ptr %w) addrspace(1) #6 comdat !dbg !1912 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %w.addr = alloca ptr, align 4
  store ptr %w, ptr %w.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w.addr, metadata !1916, metadata !DIExpression()), !dbg !1919
  %0 = load ptr, ptr %w.addr, align 4, !dbg !1920, !tbaa !1545
  %call = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE(ptr %0) #24, !dbg !1921
  %1 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !1921
  %2 = extractvalue %"class.aie::accum" %call, 0, !dbg !1921
  store %"class.aie::detail::accum_base" %2, ptr %1, align 32, !dbg !1921
  %3 = load %"class.aie::accum", ptr %retval, align 32, !dbg !1922
  ret %"class.aie::accum" %3, !dbg !1922
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"class.aie::vector_elem_ref" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !1923 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"class.aie::vector_elem_ref", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %ref.tmp = alloca %"struct.aie::unary_op", align 32
  %agg.tmp = alloca %"class.aie::vector_elem_ref", align 4
  store %"class.aie::vector_elem_ref" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !1931, metadata !DIExpression()), !dbg !1938
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !1932, metadata !DIExpression()), !dbg !1939
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !1933, metadata !DIExpression()), !dbg !1940
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !1941
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !1944, !tbaa !1545
  %call = call addrspace(1) %"struct.aie::unary_op" @_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_(ptr nonnull align 32 dereferenceable(32) %0) #24, !dbg !1941
  %1 = getelementptr inbounds %"struct.aie::unary_op", ptr %ref.tmp, i32 0, i32 0, !dbg !1941
  %2 = extractvalue %"struct.aie::unary_op" %call, 0, !dbg !1941
  store %"struct.aie::unary_op_common" %2, ptr %1, align 32, !dbg !1941
  %3 = load %"class.aie::vector_elem_ref", ptr %a, align 4, !dbg !1945, !tbaa !1840
  store %"class.aie::vector_elem_ref" %3, ptr %agg.tmp, align 4, !dbg !1945, !tbaa !1840
  %4 = load ptr, ptr %v.addr, align 4, !dbg !1946, !tbaa !1545
  %5 = load %"class.aie::vector_elem_ref", ptr %agg.tmp, align 4, !dbg !1947, !tbaa !1840
  %call1 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %ref.tmp, %"class.aie::vector_elem_ref" %5, ptr nonnull align 32 dereferenceable(32) %4) #24, !dbg !1947
  %6 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !1947
  %7 = extractvalue %"class.aie::accum" %call1, 0, !dbg !1947
  store %"class.aie::detail::accum_base" %7, ptr %6, align 32, !dbg !1947
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !1948
  %8 = load %"class.aie::accum", ptr %retval, align 32, !dbg !1948
  ret %"class.aie::accum" %8, !dbg !1948
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EEixEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !1949 {
entry:
  %retval = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1951, metadata !DIExpression()), !dbg !1953
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !1952, metadata !DIExpression()), !dbg !1954
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !1955

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !1956, !tbaa !1780
  %cmp = icmp ult i32 %0, 8, !dbg !1956
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !1956
  br i1 %1, label %if.then, label %if.else, !dbg !1959

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !1960

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !1962, !tbaa !1780
  %cmp3 = icmp ult i32 %2, 8, !dbg !1962
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !1962
  br i1 %3, label %if.end, label %if.then4, !dbg !1965

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !1966), !dbg !1962
  br label %if.end, !dbg !1962

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !1965

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !1960

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !1967, !tbaa !1780
  %cmp5 = icmp ult i32 %4, 8, !dbg !1967
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !1967
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !1959

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !1969, !tbaa !1780
  %call = call addrspace(1) %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EE8elem_refEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %5) #24, !dbg !1970
  %6 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %retval, i32 0, i32 0, !dbg !1970
  %7 = extractvalue %"class.aie::vector_elem_ref" %call, 0, !dbg !1970
  store ptr %7, ptr %6, align 4, !dbg !1970
  %8 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %retval, i32 0, i32 1, !dbg !1970
  %9 = extractvalue %"class.aie::vector_elem_ref" %call, 1, !dbg !1970
  store i32 %9, ptr %8, align 4, !dbg !1970
  %10 = load %"class.aie::vector_elem_ref", ptr %retval, align 4, !dbg !1971
  ret %"class.aie::vector_elem_ref" %10, !dbg !1971
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie5accumI8accfloatLj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %this, i32 %shift) addrspace(1) #6 comdat align 2 !dbg !1972 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %this.addr = alloca ptr, align 4
  %shift.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1977, metadata !DIExpression()), !dbg !1980
  store i32 %shift, ptr %shift.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %shift.addr, metadata !1979, metadata !DIExpression()), !dbg !1981
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %shift.addr, align 4, !dbg !1982, !tbaa !1780
  %call = call addrspace(1) %"class.aie::vector" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0) #24, !dbg !1983
  %1 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !1983
  %2 = extractvalue %"class.aie::vector" %call, 0, !dbg !1983
  store %"class.aie::detail::vector_base" %2, ptr %1, align 32, !dbg !1983
  %3 = load %"class.aie::vector", ptr %retval, align 32, !dbg !1984
  ret %"class.aie::vector" %3, !dbg !1984
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie6vectorIfLj8EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !1985 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::detail::vector_base", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !1992, metadata !DIExpression()), !dbg !1995
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !1994, metadata !DIExpression()), !dbg !1996
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !1997
  %0 = load i32, ptr %idx.addr, align 4, !dbg !1998, !tbaa !1780
  %call = call addrspace(1) %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj8EE7extractILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0) #24, !dbg !1999
  %1 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %ref.tmp, i32 0, i32 0, !dbg !1999
  %2 = extractvalue %"class.aie::detail::vector_base" %call, 0, !dbg !1999
  store %struct.v8float %2, ptr %1, align 32, !dbg !1999
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #24, !dbg !1997
  %3 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !1997, !tbaa !1730
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2000
  ret %"class.aie::vector" %3, !dbg !1997
}

; Function Attrs: alwaysinline mustprogress nounwind
define internal void @_ZN3aieL12set_roundingENS_13rounding_modeE(i32 %m) addrspace(1) #6 !dbg !2001 {
entry:
  %m.addr = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::tile", align 1
  %undef.agg.tmp = alloca %"class.aie::tile", align 1
  store i32 %m, ptr %m.addr, align 4, !tbaa !2006
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %m.addr, metadata !2005, metadata !DIExpression()), !dbg !2008
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %ref.tmp) #22, !dbg !2009
  call addrspace(1) void @_ZN3aie4tile7currentEv() #24, !dbg !2009
  %0 = load i32, ptr %m.addr, align 4, !dbg !2010, !tbaa !2006
  call addrspace(1) void @_ZN3aie4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %ref.tmp, i32 %0) #24, !dbg !2011
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %ref.tmp) #22, !dbg !2009
  ret void, !dbg !2012
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie4tile7currentEv() addrspace(1) #6 comdat align 2 !dbg !2013 {
entry:
  %retval = alloca %"class.aie::tile", align 1
  %ref.tmp = alloca %"class.aie::detail::tile", align 1
  %undef.agg.tmp = alloca %"class.aie::detail::tile", align 1
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %ref.tmp) #22, !dbg !2014
  call addrspace(1) void @_ZN3aie6detail4tile7currentEv() #24, !dbg !2014
  call addrspace(1) void @_ZN3aie4tileC2ERKNS_6detail4tileE(ptr nonnull align 1 dereferenceable(1) %retval, ptr nonnull align 1 dereferenceable(1) %ref.tmp) #24, !dbg !2014
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %ref.tmp) #22, !dbg !2015
  ret void, !dbg !2015
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !2016 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2018, metadata !DIExpression()), !dbg !2021
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !2006
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !2020, metadata !DIExpression()), !dbg !2022
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !2023, !tbaa !2006
  call addrspace(1) void @_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %this1, i32 %0) #24, !dbg !2024
  ret void, !dbg !2025
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tile7currentEv() addrspace(1) #6 comdat align 2 !dbg !2026 {
entry:
  %retval = alloca %"class.aie::detail::tile", align 1
  call addrspace(1) void @_ZN3aie6detail4tileC2Ev(ptr nonnull align 1 dereferenceable(1) %retval) #24, !dbg !2027
  ret void, !dbg !2028
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN3aie4tileC2ERKNS_6detail4tileE(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 1 dereferenceable(1) %t) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !2029 {
entry:
  %this.addr = alloca ptr, align 4
  %t.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2031, metadata !DIExpression()), !dbg !2033
  store ptr %t, ptr %t.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %t.addr, metadata !2032, metadata !DIExpression()), !dbg !2034
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %t.addr, align 4, !dbg !2035, !tbaa !1545
  ret void, !dbg !2036
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tileC2Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2037 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2039, metadata !DIExpression()), !dbg !2041
  %this1 = load ptr, ptr %this.addr, align 4
  ret void, !dbg !2042
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !2043 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2045, metadata !DIExpression()), !dbg !2047
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !2006
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !2046, metadata !DIExpression()), !dbg !2048
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !2049, !tbaa !2006
  call addrspace(1) void @_Z7set_rndj(i32 %0) #24, !dbg !2050
  ret void, !dbg !2051
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z7set_rndj(i32 %val) addrspace(1) #6 comdat {
entry:
  %val.addr = alloca i32, align 4
  store i32 %val, ptr %val.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %val.addr, align 4, !tbaa !1780
  store i32 %0, ptr @_ZN12me_primitive11control_rndE, align 4, !tbaa !1780
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define internal void @_ZN3aieL14set_saturationENS_15saturation_modeE(i32 %m) addrspace(1) #6 !dbg !2052 {
entry:
  %m.addr = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::tile", align 1
  %undef.agg.tmp = alloca %"class.aie::tile", align 1
  store i32 %m, ptr %m.addr, align 4, !tbaa !2057
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %m.addr, metadata !2056, metadata !DIExpression()), !dbg !2059
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %ref.tmp) #22, !dbg !2060
  call addrspace(1) void @_ZN3aie4tile7currentEv() #24, !dbg !2060
  %0 = load i32, ptr %m.addr, align 4, !dbg !2061, !tbaa !2057
  call addrspace(1) void @_ZN3aie4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %ref.tmp, i32 %0) #24, !dbg !2062
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %ref.tmp) #22, !dbg !2060
  ret void, !dbg !2063
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !2064 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2066, metadata !DIExpression()), !dbg !2068
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !2057
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !2067, metadata !DIExpression()), !dbg !2069
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !2070, !tbaa !2057
  call addrspace(1) void @_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %this1, i32 %0) #24, !dbg !2071
  ret void, !dbg !2072
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE(ptr nonnull align 1 dereferenceable(1) %this, i32 %mode) addrspace(1) #6 comdat align 2 !dbg !2073 {
entry:
  %this.addr = alloca ptr, align 4
  %mode.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2075, metadata !DIExpression()), !dbg !2077
  store i32 %mode, ptr %mode.addr, align 4, !tbaa !2057
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mode.addr, metadata !2076, metadata !DIExpression()), !dbg !2078
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %mode.addr, align 4, !dbg !2079, !tbaa !2057
  call addrspace(1) void @_Z11set_satmodej(i32 %0) #24, !dbg !2080
  ret void, !dbg !2081
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_Z11set_satmodej(i32 %val) addrspace(1) #6 comdat {
entry:
  %val.addr = alloca i32, align 4
  store i32 %val, ptr %val.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %val.addr, align 4, !tbaa !1780
  store i32 %0, ptr @_ZN12me_primitive11control_satE, align 4, !tbaa !1780
  ret void
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2082 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2084, metadata !DIExpression()), !dbg !2086
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !2087
  %call = call addrspace(1) %struct.v8float @_ZN3aie6detail14vector_storageIfLj8EE5undefEv() #24, !dbg !2088
  %0 = getelementptr inbounds %struct.v8float, ptr %data, i32 0, i32 0, !dbg !2088
  %1 = extractvalue %struct.v8float %call, 0, !dbg !2088
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32, !dbg !2088
  ret void, !dbg !2089
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_ZN3aie6detail14vector_storageIfLj8EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !2090 {
entry:
  %retval = alloca %struct.v8float, align 32
  %call = call addrspace(1) %struct.v8float @_Z13undef_v8floatv() #24, !dbg !2091
  %0 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0, !dbg !2091
  %1 = extractvalue %struct.v8float %call, 0, !dbg !2091
  store %struct.ipd.custom_type.v64int4.v64int4 %1, ptr %0, align 32, !dbg !2091
  %2 = load %struct.v8float, ptr %retval, align 32, !dbg !2092
  ret %struct.v8float %2, !dbg !2092
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
define linkonce_odr dso_local %struct.v8accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !2093 {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %call = call addrspace(1) %struct.v8accfloat @_Z16undef_v8accfloatv() #24, !dbg !2094
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0, !dbg !2094
  %1 = extractvalue %struct.v8accfloat %call, 0, !dbg !2094
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32, !dbg !2094
  %2 = load %struct.v8accfloat, ptr %retval, align 32, !dbg !2095
  ret %struct.v8accfloat %2, !dbg !2095
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
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv() addrspace(1) #6 comdat align 2 !dbg !2096 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv() #24, !dbg !2106
  %0 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !2106
  %1 = extractvalue %"class.aie::vector" %call, 0, !dbg !2106
  store %"class.aie::detail::vector_base" %1, ptr %0, align 32, !dbg !2106
  %2 = load %"class.aie::vector", ptr %retval, align 32, !dbg !2108
  ret %"class.aie::vector" %2, !dbg !2108
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv() addrspace(1) #6 comdat align 2 !dbg !2109 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %native_zeros_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::vector.1", align 32
  %agg.tmp = alloca %"class.aie::vector", align 32
  store i32 undef, ptr %native_zeros_elems, align 4, !dbg !2120
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_zeros_elems) #22, !dbg !2120
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_zeros_elems, metadata !2118, metadata !DIExpression()), !dbg !2121
  store i32 16, ptr %native_zeros_elems, align 4, !dbg !2121, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2119, metadata !DIExpression()), !dbg !2122
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !2122
  %0 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !2122, !tbaa !1730
  store %"class.aie::vector" %0, ptr %retval, align 32, !dbg !2122, !tbaa !1730
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !2123
  %call = call addrspace(1) %"class.aie::vector.1" @_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv() #24, !dbg !2123
  %1 = getelementptr inbounds %"class.aie::vector.1", ptr %ref.tmp, i32 0, i32 0, !dbg !2123
  %2 = extractvalue %"class.aie::vector.1" %call, 0, !dbg !2123
  store %"class.aie::detail::vector_base.2" %2, ptr %1, align 32, !dbg !2123
  %call1 = call addrspace(1) %"class.aie::vector" @_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %ref.tmp, i32 0) #24, !dbg !2126
  %3 = getelementptr inbounds %"class.aie::vector", ptr %agg.tmp, i32 0, i32 0, !dbg !2126
  %4 = extractvalue %"class.aie::vector" %call1, 0, !dbg !2126
  store %"class.aie::detail::vector_base" %4, ptr %3, align 32, !dbg !2126
  %5 = load %"class.aie::vector", ptr %agg.tmp, align 32, !dbg !2127, !tbaa !1730
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !2128
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_zeros_elems) #22, !dbg !2129
  ret %"class.aie::vector" %5, !dbg !2127
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.1" @_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv() addrspace(1) #6 comdat align 2 !dbg !2130 {
entry:
  %retval = alloca %"class.aie::vector.1", align 32
  %native_zeros_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector.1", align 32
  %tmp = alloca %"class.aie::vector.1", align 32
  %agg.tmp = alloca %struct.v16float, align 32
  store i32 undef, ptr %native_zeros_elems, align 4, !dbg !2141
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_zeros_elems) #22, !dbg !2141
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_zeros_elems, metadata !2139, metadata !DIExpression()), !dbg !2142
  store i32 16, ptr %native_zeros_elems, align 4, !dbg !2142, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2140, metadata !DIExpression()), !dbg !2143
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp) #24, !dbg !2143
  %0 = load %"class.aie::vector.1", ptr %custom_type.tmp, align 32, !dbg !2143, !tbaa !2144
  store %"class.aie::vector.1" %0, ptr %retval, align 32, !dbg !2143, !tbaa !2144
  %call = call addrspace(1) %struct.v16float @_Z26broadcast_zero_to_v16floatv() #24, !dbg !2148
  %1 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !2148
  %2 = extractvalue %struct.v16float %call, 0, !dbg !2148
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32, !dbg !2148
  %3 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !2148, !tbaa !2155
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %tmp, %struct.v16float %3) #24, !dbg !2148
  %4 = load %"class.aie::vector.1", ptr %tmp, align 32, !dbg !2156, !tbaa !2144
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_zeros_elems) #22, !dbg !2157
  ret %"class.aie::vector.1" %4, !dbg !2156
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2158 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::detail::vector_base", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2163, metadata !DIExpression()), !dbg !2166
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2165, metadata !DIExpression()), !dbg !2167
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2168
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2169, !tbaa !1780
  %call = call addrspace(1) %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this1, i32 %0) #24, !dbg !2170
  %1 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %ref.tmp, i32 0, i32 0, !dbg !2170
  %2 = extractvalue %"class.aie::detail::vector_base" %call, 0, !dbg !2170
  store %struct.v8float %2, ptr %1, align 32, !dbg !2170
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #24, !dbg !2168
  %3 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !2168, !tbaa !1730
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2171
  ret %"class.aie::vector" %3, !dbg !2168
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2172 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2174, metadata !DIExpression()), !dbg !2176
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this1) #24, !dbg !2177
  ret void, !dbg !2178
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
  %2 = load %struct.v16int32, ptr %agg.tmp, align 32, !tbaa !2155
  call addrspace(1) void @_ZN8v16floatC2E8v16int32(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16int32 %2) #27
  %3 = load %struct.v16float, ptr %custom_type.tmp, align 32, !tbaa !2155
  ret %struct.v16float %3
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16float %v.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2179 {
entry:
  %v = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16float %v.coerce, ptr %v, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2181, metadata !DIExpression()), !dbg !2183
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !2182, metadata !DIExpression()), !dbg !2184
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load %struct.v16float, ptr %v, align 32, !dbg !2185, !tbaa !2155
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this1, %struct.v16float %0) #24, !dbg !2185
  ret void, !dbg !2186
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZN3aie6detail14vector_storageIfLj16EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !2187 {
entry:
  %retval = alloca %struct.v16float, align 32
  %call = call addrspace(1) %struct.v16float @_Z14undef_v16floatv() #24, !dbg !2188
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !2188
  %1 = extractvalue %struct.v16float %call, 0, !dbg !2188
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !2188
  %2 = load %struct.v16float, ptr %retval, align 32, !dbg !2189
  ret %struct.v16float %2, !dbg !2189
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
  store i32 %a0, ptr %a0.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %a0.addr, align 4, !tbaa !1780
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v16float, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v128int4.v128int4, ptr %custom_type.tmp, align 32, !tbaa !2155
  store %struct.ipd.custom_type.v128int4.v128int4 %0, ptr %mw, align 32, !tbaa !2155
  %1 = load %struct.v16int32, ptr %a0, align 32, !tbaa !2155
  %call = call x86_regcallcc addrspace(1) %struct.v16float @__regcall3__chessintr_v16float_v16float_v16int32(%struct.v16int32 %1) #25
  %2 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  %4 = load %struct.v16float, ptr %agg.tmp, align 32, !tbaa !2155
  store %struct.v16float %4, ptr %this1, align 32, !tbaa !2155
  ret void
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16int32 @__regcall3__chessintr_v16int32_broadcast_s32___sint(i32 signext) addrspace(1) #14

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v16float @__regcall3__chessintr_v16float_v16float_v16int32(%struct.v16int32) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2190 {
entry:
  %retval = alloca %"class.aie::detail::vector_base", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2195, metadata !DIExpression()), !dbg !2198
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2197, metadata !DIExpression()), !dbg !2199
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !2200

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2201, !tbaa !1780
  %cmp = icmp ult i32 %0, 2, !dbg !2201
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !2201
  br i1 %1, label %if.then, label %if.else, !dbg !2204

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !2205

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !2207, !tbaa !1780
  %cmp3 = icmp ult i32 %2, 2, !dbg !2207
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !2207
  br i1 %3, label %if.end, label %if.then4, !dbg !2210

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !2211), !dbg !2207
  br label %if.end, !dbg !2207

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !2210

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !2205

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !2212, !tbaa !1780
  %cmp5 = icmp ult i32 %4, 2, !dbg !2212
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !2212
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !2204

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !2214, !tbaa !1780
  %call = call addrspace(1) %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this1, i32 %5) #24, !dbg !2215
  %6 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %retval, i32 0, i32 0, !dbg !2215
  %7 = extractvalue %"class.aie::detail::vector_base" %call, 0, !dbg !2215
  store %struct.v8float %7, ptr %6, align 32, !dbg !2215
  %8 = load %"class.aie::detail::vector_base", ptr %retval, align 32, !dbg !2216
  ret %"class.aie::detail::vector_base" %8, !dbg !2216
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %v) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2217 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2219, metadata !DIExpression()), !dbg !2221
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2220, metadata !DIExpression()), !dbg !2222
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2223, !tbaa !1545
  %1 = load %"class.aie::detail::vector_base", ptr %0, align 32, !dbg !2224, !tbaa !2225
  store %"class.aie::detail::vector_base" %1, ptr %this1, align 32, !dbg !2224, !tbaa !2225
  ret void, !dbg !2226
}

; Function Attrs: convergent nocallback nofree nosync nounwind willreturn memory(none)
declare i1 @llvm.is.constant.i1(i1) addrspace(1) #17

; Function Attrs: nounwind willreturn memory(none)
declare i1 @llvm.chess_manifest(i1) addrspace(1) #7

; Function Attrs: nounwind willreturn
declare void @llvm.chess_error(metadata) addrspace(1) #18

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2227 {
entry:
  %retval = alloca %"class.aie::detail::vector_base", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %output_bits = alloca i32, align 4
  %agg.tmp = alloca %struct.v8float, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2231, metadata !DIExpression()), !dbg !2234
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2232, metadata !DIExpression()), !dbg !2235
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %output_bits, align 4, !dbg !2236
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %output_bits) #22, !dbg !2236
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %output_bits, metadata !2233, metadata !DIExpression()), !dbg !2237
  store i32 256, ptr %output_bits, align 4, !dbg !2237, !tbaa !1780
  %data = getelementptr inbounds %"class.aie::detail::vector_base.2", ptr %this1, i32 0, i32 0, !dbg !2238
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2246, !tbaa !1780
  %call = call addrspace(1) %struct.v8float @_ZN3aie6detailL14vector_extractILj8E8v16floatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %data, i32 noundef %0) #24, !dbg !2247
  %1 = getelementptr inbounds %struct.v8float, ptr %agg.tmp, i32 0, i32 0, !dbg !2247
  %2 = extractvalue %struct.v8float %call, 0, !dbg !2247
  store %struct.ipd.custom_type.v64int4.v64int4 %2, ptr %1, align 32, !dbg !2247
  %3 = load %struct.v8float, ptr %agg.tmp, align 32, !dbg !2247, !tbaa !2248
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float(ptr nonnull align 32 dereferenceable(32) %retval, %struct.v8float %3) #24, !dbg !2247
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %output_bits) #22, !dbg !2249
  %4 = load %"class.aie::detail::vector_base", ptr %retval, align 32, !dbg !2249
  ret %"class.aie::detail::vector_base" %4, !dbg !2249
}

; Function Attrs: inlinehint mustprogress nounwind
define internal %struct.v8float @_ZN3aie6detailL14vector_extractILj8E8v16floatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %v, i32 noundef %idx) addrspace(1) #5 !dbg !2250 {
entry:
  %retval = alloca %struct.v8float, align 32
  %v.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2256, metadata !DIExpression()), !dbg !2260
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2257, metadata !DIExpression()), !dbg !2261
  %0 = load ptr, ptr %v.addr, align 4, !dbg !2262, !tbaa !1545
  %1 = load i32, ptr %idx.addr, align 4, !dbg !2263, !tbaa !1780
  %2 = load %struct.v16float, ptr %0, align 32, !dbg !2264, !tbaa !2155
  %call = call addrspace(1) %struct.v8float @_Z15extract_v8float8v16floati(%struct.v16float %2, i32 %1) #24, !dbg !2264
  %3 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0, !dbg !2264
  %4 = extractvalue %struct.v8float %call, 0, !dbg !2264
  store %struct.ipd.custom_type.v64int4.v64int4 %4, ptr %3, align 32, !dbg !2264
  %5 = load %struct.v8float, ptr %retval, align 32, !dbg !2265
  ret %struct.v8float %5, !dbg !2265
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float(ptr nonnull align 32 dereferenceable(32) %this, %struct.v8float %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2266 {
entry:
  %data = alloca %struct.v8float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v8float %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2268, metadata !DIExpression()), !dbg !2270
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !2269, metadata !DIExpression()), !dbg !2271
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !2272
  %0 = load %struct.v8float, ptr %data, align 32, !dbg !2273, !tbaa !2248
  store %struct.v8float %0, ptr %data2, align 32, !dbg !2273, !tbaa !2248
  ret void, !dbg !2274
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_Z15extract_v8float8v16floati(%struct.v16float %a.coerce, i32 %idx) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8float, align 32
  %a = alloca %struct.v16float, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v16float %a.coerce, ptr %a, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1780
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v16float, ptr %a, align 32, !tbaa !2155
  %call = call addrspace(1) %struct.v8float @_ZN12me_primitive6ext_xlE8v16float(%struct.v16float %1) #26
  %2 = getelementptr inbounds %struct.v8float, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v8float %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %3, ptr %2, align 32
  br label %return

if.else:                                          ; preds = %entry
  %4 = load %struct.v16float, ptr %a, align 32, !tbaa !2155
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
  %0 = load %struct.v16float, ptr %a0, align 32, !tbaa !2155
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
  %0 = load %struct.v16float, ptr %a0, align 32, !tbaa !2155
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
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE(ptr %_w) addrspace(1) #6 comdat align 2 !dbg !2275 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %_w.addr = alloca ptr, align 4
  %w = alloca ptr, align 4
  %custom_type.tmp = alloca %"class.aie::accum", align 32
  %i = alloca i32, align 4
  %tmp = alloca %"class.aie::accum.3", align 32
  %custom_type.tmp1 = alloca %"class.aie::accum.3", align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %ref.tmp = alloca %"class.aie::accum", align 32
  store ptr %_w, ptr %_w.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %_w.addr, metadata !2277, metadata !DIExpression()), !dbg !2291
  store ptr undef, ptr %w, align 4, !dbg !2292
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %w) #22, !dbg !2292
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w, metadata !2278, metadata !DIExpression()), !dbg !2293
  %0 = load ptr, ptr %_w.addr, align 4, !dbg !2294, !tbaa !1545
  store ptr %0, ptr %w, align 4, !dbg !2293, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2279, metadata !DIExpression()), !dbg !2295
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !2295
  %1 = load %"class.aie::accum", ptr %custom_type.tmp, align 32, !dbg !2295, !tbaa !1744
  store %"class.aie::accum" %1, ptr %retval, align 32, !dbg !2295, !tbaa !1744
  store i32 undef, ptr %i, align 4, !dbg !2296
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %i) #22, !dbg !2296
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %i, metadata !2280, metadata !DIExpression()), !dbg !2297
  store i32 0, ptr %i, align 4, !dbg !2297, !tbaa !1780
  br label %for.cond, !dbg !2296

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, ptr %i, align 4, !dbg !2298, !tbaa !1780
  %cmp = icmp ult i32 %2, 1, !dbg !2299
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !2300

for.cond.cleanup:                                 ; preds = %for.cond
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %i) #22, !dbg !2301
  br label %for.end

for.body:                                         ; preds = %for.cond
  store %"class.aie::accum.3" undef, ptr %tmp, align 32, !dbg !2302
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %tmp) #22, !dbg !2302
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %tmp, metadata !2284, metadata !DIExpression()), !dbg !2303
  %3 = load ptr, ptr %w, align 4, !dbg !2304, !tbaa !1545
  %call = call addrspace(1) %struct.v16accfloat @_ZL12readincr_v16P13input_cascadeI8accfloatvE(ptr %3) #24, !dbg !2305
  %4 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !2305
  %5 = extractvalue %struct.v16accfloat %call, 0, !dbg !2305
  store %struct.ipd.custom_type.v16acc32.v16acc32 %5, ptr %4, align 32, !dbg !2305
  %6 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !2305, !tbaa !2306
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp1, %struct.v16accfloat %6) #24, !dbg !2305
  %7 = load %"class.aie::accum.3", ptr %custom_type.tmp1, align 32, !dbg !2305, !tbaa !2308
  store %"class.aie::accum.3" %7, ptr %tmp, align 32, !dbg !2305, !tbaa !2308
  %8 = load i32, ptr %i, align 4, !dbg !2311, !tbaa !1780
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2313
  %call2 = call addrspace(1) %"class.aie::accum" @_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(64) %tmp, i32 0) #24, !dbg !2314
  %9 = getelementptr inbounds %"class.aie::accum", ptr %ref.tmp, i32 0, i32 0, !dbg !2314
  %10 = extractvalue %"class.aie::accum" %call2, 0, !dbg !2314
  store %"class.aie::detail::accum_base" %10, ptr %9, align 32, !dbg !2314
  %call3 = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE(ptr nonnull align 32 dereferenceable(32) %retval, i32 %8, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #24, !dbg !2315
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2316
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %tmp) #22, !dbg !2317
  br label %for.inc, !dbg !2318

for.inc:                                          ; preds = %for.body
  %11 = load i32, ptr %i, align 4, !dbg !2319, !tbaa !1780
  %inc = add i32 %11, 1, !dbg !2319
  store i32 %inc, ptr %i, align 4, !dbg !2319, !tbaa !1780
  br label %for.cond, !dbg !2301, !llvm.loop !2320

for.end:                                          ; preds = %for.cond.cleanup
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %w) #22, !dbg !2323
  %12 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2323
  ret %"class.aie::accum" %12, !dbg !2323
}

; Function Attrs: inlinehint mustprogress nounwind
define internal %struct.v16accfloat @_ZL12readincr_v16P13input_cascadeI8accfloatvE(ptr %str) addrspace(1) #5 !dbg !2324 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %str.addr = alloca ptr, align 4
  store ptr %str, ptr %str.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %str.addr, metadata !2329, metadata !DIExpression()), !dbg !2330
  %call = call addrspace(1) %struct.v16accfloat @_Z19get_scd_v16accfloatv() #24, !dbg !2330
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2330
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !2330
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !2330
  %2 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2330
  ret %struct.v16accfloat %2, !dbg !2330
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16accfloat %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2331 {
entry:
  %data = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16accfloat %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2333, metadata !DIExpression()), !dbg !2336
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !2335, metadata !DIExpression()), !dbg !2337
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load %struct.v16accfloat, ptr %data, align 32, !dbg !2338, !tbaa !2306
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this1, %struct.v16accfloat %0) #24, !dbg !2338
  ret void, !dbg !2339
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local nonnull align 32 dereferenceable(32) ptr @_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2340 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %acc.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2349, metadata !DIExpression()), !dbg !2352
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2350, metadata !DIExpression()), !dbg !2353
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2351, metadata !DIExpression()), !dbg !2354
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2355, !tbaa !1780
  %1 = load ptr, ptr %acc.addr, align 4, !dbg !2356, !tbaa !1545
  %call = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0, ptr nonnull align 32 dereferenceable(32) %1) #24, !dbg !2357
  ret ptr %this1, !dbg !2358
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2359 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::accum", align 32
  %ref.tmp = alloca %"class.aie::detail::accum_base", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2364, metadata !DIExpression()), !dbg !2367
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2366, metadata !DIExpression()), !dbg !2368
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2369
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2370, !tbaa !1780
  %call = call addrspace(1) %"class.aie::detail::accum_base" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this1, i32 %0) #24, !dbg !2371
  %1 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %ref.tmp, i32 0, i32 0, !dbg !2371
  %2 = extractvalue %"class.aie::detail::accum_base" %call, 0, !dbg !2371
  store %struct.v8accfloat %2, ptr %1, align 32, !dbg !2371
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #24, !dbg !2372
  %3 = load %"class.aie::accum", ptr %custom_type.tmp, align 32, !dbg !2372, !tbaa !1744
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2373
  ret %"class.aie::accum" %3, !dbg !2372
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
  store i32 %en, ptr %en.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %en.addr, align 4, !tbaa !1780
  %call = call addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @_Z16get_scd_v16acc32i(i32 %0) #28
  store %struct.ipd.custom_type.v16acc32.v16acc32 %call, ptr %agg.tmp, align 32
  %1 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp, align 32, !tbaa !2306
  call addrspace(1) void @_ZN11v16accfloatC2E8v16acc32(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.ipd.custom_type.v16acc32.v16acc32 %1) #27
  %2 = load %struct.v16accfloat, ptr %custom_type.tmp, align 32, !tbaa !2306
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
  store i32 %en, ptr %en.addr, align 4, !tbaa !1780
  %0 = load volatile %struct.ipd.custom_type.v16acc32.v16acc32, ptr !register !1510, align 32, !tbaa !2306, !chess_protect_access !2374
  store %struct.ipd.custom_type.v16acc32.v16acc32 %0, ptr %agg.tmp1, align 32, !tbaa !2306
  %1 = load i32, ptr %en.addr, align 4, !tbaa !1780
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 %1) #24
  %2 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2375
  store %struct.ipd.custom_type.uint1_t.uint1_t %2, ptr %agg.tmp2, align 4, !tbaa !2375
  %3 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp1, align 32, !tbaa !2306
  %4 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp2, align 4, !tbaa !2375
  %call = call addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @_ZN12me_primitive8scd_readE8v16acc327uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %3, %struct.ipd.custom_type.uint1_t.uint1_t %4) #26
  store %struct.ipd.custom_type.v16acc32.v16acc32 %call, ptr %agg.tmp, align 32
  %5 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %agg.tmp, align 32, !tbaa !2306
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v16accfloat, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %custom_type.tmp, align 32, !tbaa !2306
  store %struct.ipd.custom_type.v16acc32.v16acc32 %0, ptr %mw, align 32, !tbaa !2306
  %1 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %a0, align 32, !tbaa !2306
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_v16accfloat_v16acc32(%struct.ipd.custom_type.v16acc32.v16acc32 %1) #25
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !tbaa !2306
  store %struct.v16accfloat %4, ptr %this1, align 32, !tbaa !2306
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
  %0 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %a0, align 32, !tbaa !2306
  %1 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a1, align 4, !tbaa !2375
  %call = call x86_regcallcc addrspace(1) %struct.ipd.custom_type.v16acc32.v16acc32 @__regcall3__chessintr_v16acc32_scd_read_v16acc32_uint1_t(%struct.ipd.custom_type.v16acc32.v16acc32 %0, %struct.ipd.custom_type.uint1_t.uint1_t %1) #25
  ret %struct.ipd.custom_type.v16acc32.v16acc32 %call
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %this, i32 %a) unnamed_addr addrspace(1) #11 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  store i32 %a, ptr %a.addr, align 4, !tbaa !1780
  %this1 = load ptr, ptr %this.addr, align 4
  store i1 false, ptr %this1, align 4
  %0 = load i32, ptr %a.addr, align 4, !tbaa !1780
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
define linkonce_odr dso_local nonnull align 32 dereferenceable(32) ptr @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2377 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %acc.addr = alloca ptr, align 4
  %in_num_subaccums = alloca i32, align 4
  %num_subaccums = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2386, metadata !DIExpression()), !dbg !2392
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2388, metadata !DIExpression()), !dbg !2393
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2389, metadata !DIExpression()), !dbg !2394
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %in_num_subaccums, align 4, !dbg !2395
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %in_num_subaccums) #22, !dbg !2395
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in_num_subaccums, metadata !2390, metadata !DIExpression()), !dbg !2396
  store i32 1, ptr %in_num_subaccums, align 4, !dbg !2396, !tbaa !1780
  store i32 undef, ptr %num_subaccums, align 4, !dbg !2397
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums) #22, !dbg !2397
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums, metadata !2391, metadata !DIExpression()), !dbg !2398
  store i32 1, ptr %num_subaccums, align 4, !dbg !2398, !tbaa !1780
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2399, !tbaa !1545
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %0, i32 0, i32 0, !dbg !2402
  %data2 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !2403
  %1 = load %struct.v8accfloat, ptr %data, align 32, !dbg !2404, !tbaa !2405
  store %struct.v8accfloat %1, ptr %data2, align 32, !dbg !2404, !tbaa !2405
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums) #22, !dbg !2406
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %in_num_subaccums) #22, !dbg !2406
  ret ptr %this1, !dbg !2407
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::accum_base" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj(ptr nonnull align 32 dereferenceable(64) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2408 {
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2413, metadata !DIExpression()), !dbg !2425
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2415, metadata !DIExpression()), !dbg !2426
  %this1 = load ptr, ptr %this.addr, align 4
  store i8 undef, ptr %fpacc_128b, align 1, !dbg !2427
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %fpacc_128b) #22, !dbg !2427
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fpacc_128b, metadata !2416, metadata !DIExpression()), !dbg !2428
  store i8 0, ptr %fpacc_128b, align 1, !dbg !2428, !tbaa !2429
  store i32 undef, ptr %num_subaccums, align 4, !dbg !2431
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums) #22, !dbg !2431
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums, metadata !2417, metadata !DIExpression()), !dbg !2432
  store i32 1, ptr %num_subaccums, align 4, !dbg !2432, !tbaa !1780
  store i32 undef, ptr %num_subaccums_out, align 4, !dbg !2433
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums_out) #22, !dbg !2433
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums_out, metadata !2418, metadata !DIExpression()), !dbg !2434
  store i32 1, ptr %num_subaccums_out, align 4, !dbg !2434, !tbaa !1780
  store i32 undef, ptr %elems_per_subaccum, align 4, !dbg !2435
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %elems_per_subaccum) #22, !dbg !2435
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %elems_per_subaccum, metadata !2419, metadata !DIExpression()), !dbg !2436
  store i32 16, ptr %elems_per_subaccum, align 4, !dbg !2436, !tbaa !1780
  store i32 undef, ptr %out_elems_per_subaccum, align 4, !dbg !2437
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %out_elems_per_subaccum) #22, !dbg !2437
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out_elems_per_subaccum, metadata !2422, metadata !DIExpression()), !dbg !2438
  store i32 8, ptr %out_elems_per_subaccum, align 4, !dbg !2438, !tbaa !1780
  store i32 undef, ptr %ratio, align 4, !dbg !2439
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %ratio) #22, !dbg !2439
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ratio, metadata !2423, metadata !DIExpression()), !dbg !2440
  store i32 2, ptr %ratio, align 4, !dbg !2440, !tbaa !1780
  store %"class.aie::detail::accum_base" undef, ptr %ret, align 32, !dbg !2441
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ret) #22, !dbg !2441
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ret, metadata !2424, metadata !DIExpression()), !dbg !2442
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %ret) #24, !dbg !2442
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2443
  %data = getelementptr inbounds %"class.aie::detail::accum_base.4", ptr %this1, i32 0, i32 0, !dbg !2451
  %0 = load i32, ptr %idx.addr, align 4, !dbg !2452, !tbaa !1780
  %call = call addrspace(1) %struct.v8accfloat @_ZN3aie6detailL13accum_extractILj8E11v16accfloatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %data, i32 %0) #24, !dbg !2443
  %1 = getelementptr inbounds %struct.v8accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !2443
  %2 = extractvalue %struct.v8accfloat %call, 0, !dbg !2443
  store %struct.ipd.custom_type.v8acc32.v8acc32 %2, ptr %1, align 32, !dbg !2443
  %3 = load %struct.v8accfloat, ptr %agg.tmp, align 32, !dbg !2443, !tbaa !2405
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat(ptr nonnull align 32 dereferenceable(32) %ref.tmp, %struct.v8accfloat %3) #24, !dbg !2443
  %4 = load %"class.aie::detail::accum_base", ptr %ref.tmp, align 32, !dbg !2453, !tbaa !2454
  store %"class.aie::detail::accum_base" %4, ptr %ret, align 32, !dbg !2453, !tbaa !2454
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2455
  %5 = load %"class.aie::detail::accum_base", ptr %ret, align 32, !dbg !2456, !tbaa !2454
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ret) #22, !dbg !2457
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %ratio) #22, !dbg !2457
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %out_elems_per_subaccum) #22, !dbg !2457
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %elems_per_subaccum) #22, !dbg !2457
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums_out) #22, !dbg !2458
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums) #22, !dbg !2458
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %fpacc_128b) #22, !dbg !2458
  ret %"class.aie::detail::accum_base" %5, !dbg !2456
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE(ptr nonnull align 32 dereferenceable(32) %this, ptr nonnull align 32 dereferenceable(32) %a) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2459 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2461, metadata !DIExpression()), !dbg !2463
  store ptr %a, ptr %a.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !2462, metadata !DIExpression()), !dbg !2464
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %a.addr, align 4, !dbg !2465, !tbaa !1545
  %1 = load %"class.aie::detail::accum_base", ptr %0, align 32, !dbg !2466, !tbaa !2454
  store %"class.aie::detail::accum_base" %1, ptr %this1, align 32, !dbg !2466, !tbaa !2454
  ret void, !dbg !2467
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2468 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2470, metadata !DIExpression()), !dbg !2471
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !2472
  %call = call addrspace(1) %struct.v8accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv() #24, !dbg !2473
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %data, i32 0, i32 0, !dbg !2473
  %1 = extractvalue %struct.v8accfloat %call, 0, !dbg !2473
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32, !dbg !2473
  ret void, !dbg !2474
}

; Function Attrs: alwaysinline mustprogress nounwind
define internal %struct.v8accfloat @_ZN3aie6detailL13accum_extractILj8E11v16accfloatEEDaRKT0_j(ptr nonnull align 32 dereferenceable(64) %acc, i32 %idx) addrspace(1) #6 !dbg !2475 {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %acc.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2481, metadata !DIExpression()), !dbg !2485
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2482, metadata !DIExpression()), !dbg !2486
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2487, !tbaa !1545
  %1 = load i32, ptr %idx.addr, align 4, !dbg !2488, !tbaa !1780
  %2 = load %struct.v16accfloat, ptr %0, align 32, !dbg !2489, !tbaa !2306
  %call = call addrspace(1) %struct.v8accfloat @_Z18extract_v8accfloat11v16accfloati(%struct.v16accfloat %2, i32 %1) #24, !dbg !2489
  %3 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0, !dbg !2489
  %4 = extractvalue %struct.v8accfloat %call, 0, !dbg !2489
  store %struct.ipd.custom_type.v8acc32.v8acc32 %4, ptr %3, align 32, !dbg !2489
  %5 = load %struct.v8accfloat, ptr %retval, align 32, !dbg !2490
  ret %struct.v8accfloat %5, !dbg !2490
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat(ptr nonnull align 32 dereferenceable(32) %this, %struct.v8accfloat %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !2491 {
entry:
  %data = alloca %struct.v8accfloat, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v8accfloat %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2493, metadata !DIExpression()), !dbg !2495
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !2494, metadata !DIExpression()), !dbg !2496
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !2497
  %0 = load %struct.v8accfloat, ptr %data, align 32, !dbg !2498, !tbaa !2405
  store %struct.v8accfloat %0, ptr %data2, align 32, !dbg !2498, !tbaa !2405
  ret void, !dbg !2499
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_Z18extract_v8accfloat11v16accfloati(%struct.v16accfloat %a.coerce, i32 %idx) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v8accfloat, align 32
  %a = alloca %struct.v16accfloat, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v16accfloat %a.coerce, ptr %a, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1780
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2306
  %call = call addrspace(1) %struct.v8accfloat @_ZN12me_primitive6ext_blE11v16accfloat(%struct.v16accfloat %1) #26
  %2 = getelementptr inbounds %struct.v8accfloat, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v8accfloat %call, 0
  store %struct.ipd.custom_type.v8acc32.v8acc32 %3, ptr %2, align 32
  br label %return

if.else:                                          ; preds = %entry
  %4 = load %struct.v16accfloat, ptr %a, align 32, !tbaa !2306
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
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2306
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
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2306
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
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"class.aie::vector_elem_ref" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !2500 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"class.aie::vector_elem_ref", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.aie::unary_op.5", align 4
  store %"class.aie::vector_elem_ref" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2514, metadata !DIExpression()), !dbg !2519
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2515, metadata !DIExpression()), !dbg !2520
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2516, metadata !DIExpression()), !dbg !2521
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2522, !tbaa !1545
  %call = call addrspace(1) %"struct.aie::unary_op.5" @_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 4 dereferenceable(8) %a) #24, !dbg !2527
  %1 = getelementptr inbounds %"struct.aie::unary_op.5", ptr %agg.tmp, i32 0, i32 0, !dbg !2527
  %2 = extractvalue %"struct.aie::unary_op.5" %call, 0, !dbg !2527
  store %"struct.aie::unary_op_common.6" %2, ptr %1, align 4, !dbg !2527
  %3 = load ptr, ptr %v.addr, align 4, !dbg !2528, !tbaa !1545
  %4 = load %"struct.aie::unary_op.5", ptr %agg.tmp, align 4, !dbg !2529, !tbaa !2530
  %call1 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %0, %"struct.aie::unary_op.5" %4, ptr nonnull align 32 dereferenceable(32) %3) #24, !dbg !2529
  %5 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2529
  %6 = extractvalue %"class.aie::accum" %call1, 0, !dbg !2529
  store %"class.aie::detail::accum_base" %6, ptr %5, align 32, !dbg !2529
  %7 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2533
  ret %"class.aie::accum" %7, !dbg !2533
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"struct.aie::unary_op" @_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_(ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat !dbg !2534 {
entry:
  %retval = alloca %"struct.aie::unary_op", align 32
  %acc.addr = alloca ptr, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2538, metadata !DIExpression()), !dbg !2540
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2541, !tbaa !1545
  %1 = load %"class.aie::accum", ptr %0, align 32, !dbg !2542, !tbaa !1744
  call addrspace(1) void @_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_(ptr nonnull align 32 dereferenceable(32) %retval, %"class.aie::accum" noundef %1) #24, !dbg !2542
  %2 = load %"struct.aie::unary_op", ptr %retval, align 32, !dbg !2543
  ret %"struct.aie::unary_op" %2, !dbg !2543
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"struct.aie::unary_op.5" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !2544 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"struct.aie::unary_op.5", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %agg.tmp = alloca %"struct.aie::unary_op.5", align 4
  %ref.tmp = alloca %"struct.aie::unary_op.7", align 32
  store %"struct.aie::unary_op.5" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2548, metadata !DIExpression()), !dbg !2553
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2549, metadata !DIExpression()), !dbg !2554
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2550, metadata !DIExpression()), !dbg !2555
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !2556, !tbaa !1545
  %1 = load %"struct.aie::unary_op.5", ptr %a, align 4, !dbg !2562, !tbaa !2530
  store %"struct.aie::unary_op.5" %1, ptr %agg.tmp, align 4, !dbg !2562, !tbaa !2530
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2563
  %2 = load ptr, ptr %v.addr, align 4, !dbg !2564, !tbaa !1545
  %call = call addrspace(1) %"struct.aie::unary_op.7" @_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 32 dereferenceable(32) %2) #24, !dbg !2563
  %3 = getelementptr inbounds %"struct.aie::unary_op.7", ptr %ref.tmp, i32 0, i32 0, !dbg !2563
  %4 = extractvalue %"struct.aie::unary_op.7" %call, 0, !dbg !2563
  store %"struct.aie::unary_op_common.8" %4, ptr %3, align 32, !dbg !2563
  %5 = load %"struct.aie::unary_op.5", ptr %agg.tmp, align 4, !dbg !2565, !tbaa !2530
  %call1 = call addrspace(1) %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %0, %"struct.aie::unary_op.5" %5, ptr nonnull align 32 dereferenceable(32) %ref.tmp) #24, !dbg !2565
  %6 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2565
  %7 = extractvalue %"class.aie::accum" %call1, 0, !dbg !2565
  store %"class.aie::detail::accum_base" %7, ptr %6, align 32, !dbg !2565
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2566
  %8 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2566
  ret %"class.aie::accum" %8, !dbg !2566
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"struct.aie::unary_op.5" @_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 4 dereferenceable(8) %e) addrspace(1) #6 comdat !dbg !2567 {
entry:
  %retval = alloca %"struct.aie::unary_op.5", align 4
  %e.addr = alloca ptr, align 4
  %agg.tmp = alloca %"class.aie::vector_elem_ref", align 4
  store ptr %e, ptr %e.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %e.addr, metadata !2571, metadata !DIExpression()), !dbg !2572
  %0 = load ptr, ptr %e.addr, align 4, !dbg !2573, !tbaa !1545
  %1 = load %"class.aie::vector_elem_ref", ptr %0, align 4, !dbg !2573, !tbaa !1840
  store %"class.aie::vector_elem_ref" %1, ptr %agg.tmp, align 4, !dbg !2573, !tbaa !1840
  %2 = load %"class.aie::vector_elem_ref", ptr %agg.tmp, align 4, !dbg !2574, !tbaa !1840
  call addrspace(1) void @_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 4 dereferenceable(8) %retval, %"class.aie::vector_elem_ref" noundef %2) #24, !dbg !2574
  %3 = load %"struct.aie::unary_op.5", ptr %retval, align 4, !dbg !2575
  ret %"struct.aie::unary_op.5" %3, !dbg !2575
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_(ptr nonnull align 32 dereferenceable(32) %acc, %"struct.aie::unary_op.5" %a.coerce, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat !dbg !2576 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"struct.aie::unary_op.5", align 4
  %acc.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %Op1 = alloca i32, align 4
  %Op2 = alloca i32, align 4
  %agg.tmp = alloca %"class.aie::vector_elem_const_ref", align 4
  %ref.tmp = alloca %"class.aie::vector_elem_ref", align 4
  %agg.tmp1 = alloca %"struct.aie::unary_op.5", align 4
  %ref.tmp3 = alloca %"class.aie::vector", align 32
  %agg.tmp5 = alloca %"struct.aie::unary_op.7", align 32
  %ref.tmp7 = alloca %"class.aie::accum", align 32
  store %"struct.aie::unary_op.5" %a.coerce, ptr %a, align 4
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2581, metadata !DIExpression()), !dbg !2598
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2582, metadata !DIExpression()), !dbg !2599
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2583, metadata !DIExpression()), !dbg !2600
  store i32 undef, ptr %Op1, align 4, !dbg !2601
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %Op1) #22, !dbg !2601
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %Op1, metadata !2584, metadata !DIExpression()), !dbg !2602
  store i32 0, ptr %Op1, align 4, !dbg !2602, !tbaa !2603
  store i32 undef, ptr %Op2, align 4, !dbg !2605
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %Op2) #22, !dbg !2605
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %Op2, metadata !2595, metadata !DIExpression()), !dbg !2606
  store i32 0, ptr %Op2, align 4, !dbg !2606, !tbaa !2603
  call addrspace(1) void @llvm.lifetime.start.p0(i64 8, ptr %ref.tmp) #22, !dbg !2607
  %call = call addrspace(1) %"class.aie::vector_elem_ref" @_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 4 dereferenceable(8) %a) #24, !dbg !2609
  %0 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %ref.tmp, i32 0, i32 0, !dbg !2609
  %1 = extractvalue %"class.aie::vector_elem_ref" %call, 0, !dbg !2609
  store ptr %1, ptr %0, align 4, !dbg !2609
  %2 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %ref.tmp, i32 0, i32 1, !dbg !2609
  %3 = extractvalue %"class.aie::vector_elem_ref" %call, 1, !dbg !2609
  store i32 %3, ptr %2, align 4, !dbg !2609
  call addrspace(1) void @_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE(ptr nonnull align 4 dereferenceable(8) %agg.tmp, ptr nonnull align 4 dereferenceable(8) %ref.tmp) #24, !dbg !2610
  %4 = load %"struct.aie::unary_op.5", ptr %a, align 4, !dbg !2611, !tbaa !2530
  store %"struct.aie::unary_op.5" %4, ptr %agg.tmp1, align 4, !dbg !2611, !tbaa !2530
  %5 = load %"struct.aie::unary_op.5", ptr %agg.tmp1, align 4, !dbg !2612, !tbaa !2530
  %call2 = call zeroext addrspace(1) i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.5" %5) #24, !dbg !2612
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp3) #22, !dbg !2613
  %6 = load ptr, ptr %v.addr, align 4, !dbg !2613, !tbaa !1545
  %call4 = call addrspace(1) %"class.aie::vector" @_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %6) #24, !dbg !2614
  %7 = getelementptr inbounds %"class.aie::vector", ptr %ref.tmp3, i32 0, i32 0, !dbg !2614
  %8 = extractvalue %"class.aie::vector" %call4, 0, !dbg !2614
  store %"class.aie::detail::vector_base" %8, ptr %7, align 32, !dbg !2614
  %9 = load ptr, ptr %v.addr, align 4, !dbg !2615, !tbaa !1545
  %10 = load %"struct.aie::unary_op.7", ptr %9, align 32, !dbg !2615, !tbaa !2616
  store %"struct.aie::unary_op.7" %10, ptr %agg.tmp5, align 32, !dbg !2615, !tbaa !2616
  %11 = load %"struct.aie::unary_op.7", ptr %agg.tmp5, align 32, !dbg !2619, !tbaa !2616
  %call6 = call zeroext addrspace(1) i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.7" %11) #24, !dbg !2619
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp7) #22, !dbg !2620
  %12 = load ptr, ptr %acc.addr, align 4, !dbg !2620, !tbaa !1545
  %call8 = call addrspace(1) %"class.aie::accum" @_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %12) #24, !dbg !2621
  %13 = getelementptr inbounds %"class.aie::accum", ptr %ref.tmp7, i32 0, i32 0, !dbg !2621
  %14 = extractvalue %"class.aie::accum" %call8, 0, !dbg !2621
  store %"class.aie::detail::accum_base" %14, ptr %13, align 32, !dbg !2621
  %15 = load %"class.aie::vector_elem_const_ref", ptr %agg.tmp, align 4, !dbg !2622, !tbaa !2623
  %call9 = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_(%"class.aie::vector_elem_const_ref" %15, i1 zeroext %call2, ptr nonnull align 32 dereferenceable(32) %ref.tmp3, i1 zeroext %call6, ptr nonnull align 32 dereferenceable(32) %ref.tmp7) #24, !dbg !2622
  %16 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2622
  %17 = extractvalue %"class.aie::accum" %call9, 0, !dbg !2622
  store %"class.aie::detail::accum_base" %17, ptr %16, align 32, !dbg !2622
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp7) #22, !dbg !2625
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp3) #22, !dbg !2625
  call addrspace(1) void @llvm.lifetime.end.p0(i64 8, ptr %ref.tmp) #22, !dbg !2625
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %Op2) #22, !dbg !2626
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %Op1) #22, !dbg !2626
  %18 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2627
  ret %"class.aie::accum" %18, !dbg !2627
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"struct.aie::unary_op.7" @_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_(ptr nonnull align 32 dereferenceable(32) %e) addrspace(1) #6 comdat !dbg !2628 {
entry:
  %retval = alloca %"struct.aie::unary_op.7", align 32
  %e.addr = alloca ptr, align 4
  store ptr %e, ptr %e.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %e.addr, metadata !2632, metadata !DIExpression()), !dbg !2633
  %0 = load ptr, ptr %e.addr, align 4, !dbg !2634, !tbaa !1545
  %1 = load %"class.aie::vector", ptr %0, align 32, !dbg !2635, !tbaa !1730
  call addrspace(1) void @_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 32 dereferenceable(32) %retval, %"class.aie::vector" noundef %1) #24, !dbg !2635
  %2 = load %"struct.aie::unary_op.7", ptr %retval, align 32, !dbg !2636
  ret %"struct.aie::unary_op.7" %2, !dbg !2636
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_(%"class.aie::vector_elem_const_ref" %a.coerce, i1 zeroext %a_sign, ptr nonnull align 32 dereferenceable(32) %v, i1 zeroext %v_sign, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2637 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a = alloca %"class.aie::vector_elem_const_ref", align 4
  %a_sign.addr = alloca i8, align 1
  %v.addr = alloca ptr, align 4
  %v_sign.addr = alloca i8, align 1
  %acc.addr = alloca ptr, align 4
  store %"class.aie::vector_elem_const_ref" %a.coerce, ptr %a, align 4
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !2661, metadata !DIExpression()), !dbg !2666
  %frombool = zext i1 %a_sign to i8
  store i8 %frombool, ptr %a_sign.addr, align 1, !tbaa !2429
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a_sign.addr, metadata !2662, metadata !DIExpression()), !dbg !2667
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2663, metadata !DIExpression()), !dbg !2668
  %frombool1 = zext i1 %v_sign to i8
  store i8 %frombool1, ptr %v_sign.addr, align 1, !tbaa !2429
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v_sign.addr, metadata !2664, metadata !DIExpression()), !dbg !2669
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2665, metadata !DIExpression()), !dbg !2670
  %call = call noundef addrspace(1) float @_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv(ptr nonnull align 4 dereferenceable(8) %a) #24, !dbg !2671
  %0 = load i8, ptr %a_sign.addr, align 1, !dbg !2672, !tbaa !2429, !range !2673, !noundef !137
  %tobool = trunc i8 %0 to i1, !dbg !2672
  %1 = load ptr, ptr %v.addr, align 4, !dbg !2674, !tbaa !1545
  %2 = load i8, ptr %v_sign.addr, align 1, !dbg !2675, !tbaa !2429, !range !2673, !noundef !137
  %tobool2 = trunc i8 %2 to i1, !dbg !2675
  %3 = load ptr, ptr %acc.addr, align 4, !dbg !2676, !tbaa !1545
  %call3 = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_(float %call, i1 zeroext %tobool, ptr nonnull align 32 dereferenceable(32) %1, i1 zeroext %tobool2, ptr nonnull align 32 dereferenceable(32) %3) #24, !dbg !2677
  %4 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2677
  %5 = extractvalue %"class.aie::accum" %call3, 0, !dbg !2677
  store %"class.aie::detail::accum_base" %5, ptr %4, align 32, !dbg !2677
  %6 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2678
  ret %"class.aie::accum" %6, !dbg !2678
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector_elem_ref" @_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #6 comdat align 2 !dbg !2679 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2686, metadata !DIExpression()), !dbg !2688
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.6", ptr %this1, i32 0, i32 0, !dbg !2689
  %0 = load %"class.aie::vector_elem_ref", ptr %parent_, align 4, !dbg !2689, !tbaa !1840
  ret %"class.aie::vector_elem_ref" %0, !dbg !2689
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE(ptr nonnull align 4 dereferenceable(8) %this, ptr nonnull align 4 dereferenceable(8) %ref) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !2691 {
entry:
  %this.addr = alloca ptr, align 4
  %ref.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2693, metadata !DIExpression()), !dbg !2696
  store ptr %ref, ptr %ref.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ref.addr, metadata !2695, metadata !DIExpression()), !dbg !2697
  %this1 = load ptr, ptr %this.addr, align 4
  %parent = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 0, !dbg !2698
  %0 = load ptr, ptr %ref.addr, align 4, !dbg !2699, !tbaa !1545
  %parent2 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %0, i32 0, i32 0, !dbg !2700
  %1 = load ptr, ptr %parent2, align 4, !dbg !2700, !tbaa !2701
  store ptr %1, ptr %parent, align 4, !dbg !2698, !tbaa !1545
  %offset = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 1, !dbg !2702
  %2 = load ptr, ptr %ref.addr, align 4, !dbg !2703, !tbaa !1545
  %offset3 = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %2, i32 0, i32 1, !dbg !2704
  %3 = load i32, ptr %offset3, align 4, !dbg !2704, !tbaa !2705
  store i32 %3, ptr %offset, align 4, !dbg !2702, !tbaa !2706
  ret void, !dbg !2707
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local zeroext i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.5" %v.coerce) addrspace(1) #6 comdat !dbg !2708 {
entry:
  %v = alloca %"struct.aie::unary_op.5", align 4
  store %"struct.aie::unary_op.5" %v.coerce, ptr %v, align 4
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !2712, metadata !DIExpression()), !dbg !2715
  ret i1 true, !dbg !2716
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !2718 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2725, metadata !DIExpression()), !dbg !2727
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.8", ptr %this1, i32 0, i32 0, !dbg !2728
  %0 = load %"class.aie::vector", ptr %parent_, align 32, !dbg !2728, !tbaa !1730
  ret %"class.aie::vector" %0, !dbg !2728
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local zeroext i1 @_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_(%"struct.aie::unary_op.7" %v.coerce) addrspace(1) #6 comdat !dbg !2730 {
entry:
  %v = alloca %"struct.aie::unary_op.7", align 32
  store %"struct.aie::unary_op.7" %v.coerce, ptr %v, align 32
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !2734, metadata !DIExpression()), !dbg !2737
  ret i1 true, !dbg !2738
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !2740 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2747, metadata !DIExpression()), !dbg !2749
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common", ptr %this1, i32 0, i32 0, !dbg !2750
  %0 = load %"class.aie::accum", ptr %parent_, align 32, !dbg !2750, !tbaa !1744
  ret %"class.aie::accum" %0, !dbg !2750
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_(float %a, i1 zeroext %a_sign, ptr nonnull align 32 dereferenceable(32) %v, i1 zeroext %v_sign, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2752 {
entry:
  %retval = alloca %"class.aie::accum", align 32
  %a.addr = alloca float, align 4
  %a_sign.addr = alloca i8, align 1
  %v.addr = alloca ptr, align 4
  %v_sign.addr = alloca i8, align 1
  %acc.addr = alloca ptr, align 4
  %ref.tmp = alloca %"class.aie::vector", align 32
  store float %a, ptr %a.addr, align 4, !tbaa !2767
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !2762, metadata !DIExpression()), !dbg !2769
  %frombool = zext i1 %a_sign to i8
  store i8 %frombool, ptr %a_sign.addr, align 1, !tbaa !2429
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a_sign.addr, metadata !2763, metadata !DIExpression()), !dbg !2770
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !2764, metadata !DIExpression()), !dbg !2771
  %frombool1 = zext i1 %v_sign to i8
  store i8 %frombool1, ptr %v_sign.addr, align 1, !tbaa !2429
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v_sign.addr, metadata !2765, metadata !DIExpression()), !dbg !2772
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2766, metadata !DIExpression()), !dbg !2773
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !2774
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a.addr) #24, !dbg !2774
  %0 = getelementptr inbounds %"class.aie::vector", ptr %ref.tmp, i32 0, i32 0, !dbg !2774
  %1 = extractvalue %"class.aie::vector" %call, 0, !dbg !2774
  store %"class.aie::detail::vector_base" %1, ptr %0, align 32, !dbg !2774
  %2 = load i8, ptr %a_sign.addr, align 1, !dbg !2775, !tbaa !2429, !range !2673, !noundef !137
  %tobool = trunc i8 %2 to i1, !dbg !2775
  %3 = load ptr, ptr %v.addr, align 4, !dbg !2776, !tbaa !1545
  %4 = load i8, ptr %v_sign.addr, align 1, !dbg !2777, !tbaa !2429, !range !2673, !noundef !137
  %tobool2 = trunc i8 %4 to i1, !dbg !2777
  %5 = load ptr, ptr %acc.addr, align 4, !dbg !2778, !tbaa !1545
  %call3 = call addrspace(1) %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_(ptr nonnull align 32 dereferenceable(32) %ref.tmp, i1 zeroext %tobool, ptr nonnull align 32 dereferenceable(32) %3, i1 zeroext %tobool2, ptr nonnull align 32 dereferenceable(32) %5) #24, !dbg !2779
  %6 = getelementptr inbounds %"class.aie::accum", ptr %retval, i32 0, i32 0, !dbg !2779
  %7 = extractvalue %"class.aie::accum" %call3, 0, !dbg !2779
  store %"class.aie::detail::accum_base" %7, ptr %6, align 32, !dbg !2779
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !2780
  %8 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2780
  ret %"class.aie::accum" %8, !dbg !2780
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local noundef float @_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #9 comdat align 2 !dbg !2781 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2783, metadata !DIExpression()), !dbg !2785
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call noundef addrspace(1) float @_ZNK3aie21vector_elem_const_refIfLj8EE3getEv(ptr nonnull align 4 dereferenceable(8) %this1) #24, !dbg !2786
  ret float %call, !dbg !2787
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum" @_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_(ptr nonnull align 32 dereferenceable(32) %v1, i1 zeroext %v1_sign, ptr nonnull align 32 dereferenceable(32) %v2, i1 zeroext %v2_sign, ptr nonnull align 32 dereferenceable(32) %acc) addrspace(1) #6 comdat align 2 !dbg !2788 {
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
  %ref.tmp = alloca %class.anon.9, align 4
  store ptr %v1, ptr %v1.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1.addr, metadata !2793, metadata !DIExpression()), !dbg !2803
  %frombool = zext i1 %v1_sign to i8
  store i8 %frombool, ptr %v1_sign.addr, align 1, !tbaa !2429
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1_sign.addr, metadata !2794, metadata !DIExpression()), !dbg !2804
  store ptr %v2, ptr %v2.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2.addr, metadata !2795, metadata !DIExpression()), !dbg !2805
  %frombool1 = zext i1 %v2_sign to i8
  store i8 %frombool1, ptr %v2_sign.addr, align 1, !tbaa !2429
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2_sign.addr, metadata !2796, metadata !DIExpression()), !dbg !2806
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !2797, metadata !DIExpression()), !dbg !2807
  store %class.anon undef, ptr %mul_op, align 1, !dbg !2808
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %mul_op) #22, !dbg !2808
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %mul_op, metadata !2798, metadata !DIExpression()), !dbg !2809
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 1 %mul_op, ptr align 1 @__const._ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_.mul_op, i32 1, i1 false), !dbg !2809
  store i32 undef, ptr %num_mul, align 4, !dbg !2810
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_mul) #22, !dbg !2810
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_mul, metadata !2801, metadata !DIExpression()), !dbg !2811
  store i32 1, ptr %num_mul, align 4, !dbg !2811, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !2802, metadata !DIExpression()), !dbg !2812
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !2812
  %0 = load %"class.aie::accum", ptr %custom_type.tmp, align 32, !dbg !2812, !tbaa !1744
  store %"class.aie::accum" %0, ptr %retval, align 32, !dbg !2812, !tbaa !1744
  call addrspace(1) void @llvm.lifetime.start.p0(i64 20, ptr %ref.tmp) #22, !dbg !2813
  %1 = getelementptr inbounds %class.anon.9, ptr %ref.tmp, i32 0, i32 0, !dbg !2813
  store ptr %mul_op, ptr %1, align 4, !dbg !2813, !tbaa !1545
  %2 = getelementptr inbounds %class.anon.9, ptr %ref.tmp, i32 0, i32 1, !dbg !2813
  %3 = load ptr, ptr %v1.addr, align 4, !dbg !2814, !tbaa !1545
  store ptr %3, ptr %2, align 4, !dbg !2813, !tbaa !1545
  %4 = getelementptr inbounds %class.anon.9, ptr %ref.tmp, i32 0, i32 2, !dbg !2813
  %5 = load ptr, ptr %v2.addr, align 4, !dbg !2814, !tbaa !1545
  store ptr %5, ptr %4, align 4, !dbg !2813, !tbaa !1545
  %6 = getelementptr inbounds %class.anon.9, ptr %ref.tmp, i32 0, i32 3, !dbg !2813
  %7 = load ptr, ptr %acc.addr, align 4, !dbg !2814, !tbaa !1545
  store ptr %7, ptr %6, align 4, !dbg !2813, !tbaa !1545
  %8 = getelementptr inbounds %class.anon.9, ptr %ref.tmp, i32 0, i32 4, !dbg !2813
  store ptr %retval, ptr %8, align 4, !dbg !2813, !tbaa !1545
  call addrspace(1) void @_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_(ptr nonnull align 4 dereferenceable(20) %ref.tmp) #24, !dbg !2815
  call addrspace(1) void @llvm.lifetime.end.p0(i64 20, ptr %ref.tmp) #22, !dbg !2815
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_mul) #22, !dbg !2816
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %mul_op) #22, !dbg !2816
  %9 = load %"class.aie::accum", ptr %retval, align 32, !dbg !2816
  ret %"class.aie::accum" %9, !dbg !2816
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a) addrspace(1) #9 comdat align 2 !dbg !2817 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %a.addr = alloca ptr, align 4
  store ptr %a, ptr %a.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !2826, metadata !DIExpression()), !dbg !2827
  %0 = load ptr, ptr %a.addr, align 4, !dbg !2828, !tbaa !1545
  %call = call addrspace(1) %"class.aie::vector" @_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %0) #24, !dbg !2829
  %1 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !2829
  %2 = extractvalue %"class.aie::vector" %call, 0, !dbg !2829
  store %"class.aie::detail::vector_base" %2, ptr %1, align 32, !dbg !2829
  %3 = load %"class.aie::vector", ptr %retval, align 32, !dbg !2830
  ret %"class.aie::vector" %3, !dbg !2830
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i32(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i32, i1 immarg) addrspace(1) #21

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat !dbg !2831 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2846, metadata !DIExpression()), !dbg !2850
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !2851, !tbaa !1545
  call addrspace(1) void @_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_(ptr nonnull align 4 dereferenceable(20) %0) #24, !dbg !2852
  ret void, !dbg !2853
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat !dbg !2854 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2856, metadata !DIExpression()), !dbg !2862
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !2863, !tbaa !1545
  call addrspace(1) void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %0) #24, !dbg !2864
  ret void, !dbg !2865
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat align 2 !dbg !2866 {
entry:
  %fn.addr = alloca ptr, align 4
  %it = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %agg.tmp = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %next_it = alloca i32, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2873, metadata !DIExpression()), !dbg !2889
  store %"struct.aie::detail::utils::iteration_dim" undef, ptr %it, align 1, !dbg !2890
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %it) #22, !dbg !2890
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %it, metadata !2874, metadata !DIExpression()), !dbg !2891
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 1 %it, ptr align 1 @__const._ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_.it, i32 1, i1 false), !dbg !2891
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !2892, !tbaa !1545
  call addrspace(1) void @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_(ptr nonnull align 4 dereferenceable(20) %0) #24, !dbg !2892
  store i32 undef, ptr %next_it, align 4, !dbg !2894
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %next_it) #22, !dbg !2894
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %next_it, metadata !2888, metadata !DIExpression()), !dbg !2895
  store i32 1, ptr %next_it, align 4, !dbg !2895, !tbaa !1780
  %1 = load ptr, ptr %fn.addr, align 4, !dbg !2896, !tbaa !1545
  call addrspace(1) void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %1) #24, !dbg !2897
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %next_it) #22, !dbg !2898
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %it) #22, !dbg !2898
  ret void, !dbg !2899
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_(ptr nonnull align 4 dereferenceable(20) %this) addrspace(1) #6 comdat align 2 !dbg !2900 {
entry:
  %idx = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %this.addr = alloca ptr, align 4
  %tmp = alloca %"class.aie::accum.3", align 32
  %custom_type.tmp = alloca %"class.aie::accum.3", align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %ref.tmp = alloca %"class.aie::vector.1", align 32
  %ref.tmp3 = alloca %"class.aie::vector.1", align 32
  %ref.tmp6 = alloca %"class.aie::accum.3", align 32
  %ref.tmp11 = alloca %"class.aie::accum", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2909, metadata !DIExpression()), !dbg !2915
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx, metadata !2911, metadata !DIExpression()), !dbg !2916
  %this1 = load ptr, ptr %this.addr, align 4
  store %"class.aie::accum.3" undef, ptr %tmp, align 32, !dbg !2917
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %tmp) #22, !dbg !2917
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %tmp, metadata !2912, metadata !DIExpression()), !dbg !2918
  %0 = getelementptr inbounds %class.anon.9, ptr %this1, i32 0, i32 0, !dbg !2919
  %1 = load ptr, ptr %0, align 4, !dbg !2919, !tbaa !2920
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !2922
  %2 = getelementptr inbounds %class.anon.9, ptr %this1, i32 0, i32 1, !dbg !2922
  %3 = load ptr, ptr %2, align 4, !dbg !2922, !tbaa !2923
  %call = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #24, !dbg !2924
  %call2 = call addrspace(1) %"class.aie::vector.1" @_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %3, i32 %call) #24, !dbg !2925
  %4 = getelementptr inbounds %"class.aie::vector.1", ptr %ref.tmp, i32 0, i32 0, !dbg !2925
  %5 = extractvalue %"class.aie::vector.1" %call2, 0, !dbg !2925
  store %"class.aie::detail::vector_base.2" %5, ptr %4, align 32, !dbg !2925
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp3) #22, !dbg !2926
  %6 = getelementptr inbounds %class.anon.9, ptr %this1, i32 0, i32 2, !dbg !2926
  %7 = load ptr, ptr %6, align 4, !dbg !2926, !tbaa !2927
  %call4 = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #24, !dbg !2928
  %call5 = call addrspace(1) %"class.aie::vector.1" @_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %7, i32 %call4) #24, !dbg !2929
  %8 = getelementptr inbounds %"class.aie::vector.1", ptr %ref.tmp3, i32 0, i32 0, !dbg !2929
  %9 = extractvalue %"class.aie::vector.1" %call5, 0, !dbg !2929
  store %"class.aie::detail::vector_base.2" %9, ptr %8, align 32, !dbg !2929
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp6) #22, !dbg !2930
  %10 = getelementptr inbounds %class.anon.9, ptr %this1, i32 0, i32 3, !dbg !2930
  %11 = load ptr, ptr %10, align 4, !dbg !2930, !tbaa !2931
  %call7 = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #24, !dbg !2932
  %call8 = call addrspace(1) %"class.aie::accum.3" @_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(32) %11, i32 %call7) #24, !dbg !2933
  %12 = getelementptr inbounds %"class.aie::accum.3", ptr %ref.tmp6, i32 0, i32 0, !dbg !2933
  %13 = extractvalue %"class.aie::accum.3" %call8, 0, !dbg !2933
  store %"class.aie::detail::accum_base.4" %13, ptr %12, align 32, !dbg !2933
  %call9 = call addrspace(1) %struct.v16accfloat @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_(ptr nonnull align 1 dereferenceable(1) %1, ptr nonnull align 32 dereferenceable(64) %ref.tmp, ptr nonnull align 32 dereferenceable(64) %ref.tmp3, ptr nonnull align 32 dereferenceable(64) %ref.tmp6) #24, !dbg !2919
  %14 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !2919
  %15 = extractvalue %struct.v16accfloat %call9, 0, !dbg !2919
  store %struct.ipd.custom_type.v16acc32.v16acc32 %15, ptr %14, align 32, !dbg !2919
  %16 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !2919, !tbaa !2306
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16accfloat %16) #24, !dbg !2919
  %17 = load %"class.aie::accum.3", ptr %custom_type.tmp, align 32, !dbg !2919, !tbaa !2308
  store %"class.aie::accum.3" %17, ptr %tmp, align 32, !dbg !2919, !tbaa !2308
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp6) #22, !dbg !2919
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp3) #22, !dbg !2919
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !2919
  %18 = getelementptr inbounds %class.anon.9, ptr %this1, i32 0, i32 4, !dbg !2934
  %19 = load ptr, ptr %18, align 4, !dbg !2934, !tbaa !2935
  %call10 = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %idx) #24, !dbg !2936
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp11) #22, !dbg !2937
  %call12 = call addrspace(1) %"class.aie::accum" @_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(64) %tmp, i32 0) #24, !dbg !2938
  %20 = getelementptr inbounds %"class.aie::accum", ptr %ref.tmp11, i32 0, i32 0, !dbg !2938
  %21 = extractvalue %"class.aie::accum" %call12, 0, !dbg !2938
  store %"class.aie::detail::accum_base" %21, ptr %20, align 32, !dbg !2938
  %call13 = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE(ptr nonnull align 32 dereferenceable(32) %19, i32 %call10, ptr nonnull align 32 dereferenceable(32) %ref.tmp11) #24, !dbg !2939
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp11) #22, !dbg !2934
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %tmp) #22, !dbg !2940
  ret void, !dbg !2940
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat align 2 !dbg !2941 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !2947, metadata !DIExpression()), !dbg !2948
  ret void, !dbg !2949
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 32 dereferenceable(64) %args, ptr nonnull align 32 dereferenceable(64) %args1, ptr nonnull align 32 dereferenceable(64) %args3) addrspace(1) #6 comdat align 2 !dbg !2950 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  %args.addr = alloca ptr, align 4
  %args.addr2 = alloca ptr, align 4
  %args.addr4 = alloca ptr, align 4
  %agg.tmp = alloca %struct.v16float, align 32
  %agg.tmp6 = alloca %struct.v16float, align 32
  %agg.tmp8 = alloca %struct.v16accfloat, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2963, metadata !DIExpression()), !dbg !2968
  store ptr %args, ptr %args.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %args.addr, metadata !2965, metadata !DIExpression()), !dbg !2969
  store ptr %args1, ptr %args.addr2, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %args.addr2, metadata !2966, metadata !DIExpression()), !dbg !2969
  store ptr %args3, ptr %args.addr4, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %args.addr4, metadata !2967, metadata !DIExpression()), !dbg !2969
  %this5 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %args.addr, align 4, !dbg !2970, !tbaa !1545
  %call = call addrspace(1) %struct.v16float @_ZNK3aie6vectorIfLj16EEcv8v16floatEv(ptr nonnull align 32 dereferenceable(64) %0) #24, !dbg !2970
  %1 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !2970
  %2 = extractvalue %struct.v16float %call, 0, !dbg !2970
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32, !dbg !2970
  %3 = load ptr, ptr %args.addr2, align 4, !dbg !2970, !tbaa !1545
  %call7 = call addrspace(1) %struct.v16float @_ZNK3aie6vectorIfLj16EEcv8v16floatEv(ptr nonnull align 32 dereferenceable(64) %3) #24, !dbg !2970
  %4 = getelementptr inbounds %struct.v16float, ptr %agg.tmp6, i32 0, i32 0, !dbg !2970
  %5 = extractvalue %struct.v16float %call7, 0, !dbg !2970
  store %struct.ipd.custom_type.v128int4.v128int4 %5, ptr %4, align 32, !dbg !2970
  %6 = load ptr, ptr %args.addr4, align 4, !dbg !2970, !tbaa !1545
  %call9 = call addrspace(1) %struct.v16accfloat @_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %6) #24, !dbg !2970
  %7 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp8, i32 0, i32 0, !dbg !2970
  %8 = extractvalue %struct.v16accfloat %call9, 0, !dbg !2970
  store %struct.ipd.custom_type.v16acc32.v16acc32 %8, ptr %7, align 32, !dbg !2970
  %9 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !2971, !tbaa !2155
  %10 = load %struct.v16float, ptr %agg.tmp6, align 32, !dbg !2971, !tbaa !2155
  %11 = load %struct.v16accfloat, ptr %agg.tmp8, align 32, !dbg !2971, !tbaa !2306
  %call10 = call addrspace(1) %struct.v16accfloat @_Z11mac_elem_168v16floatS_11v16accfloat(%struct.v16float %9, %struct.v16float %10, %struct.v16accfloat %11) #24, !dbg !2971
  %12 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !2971
  %13 = extractvalue %struct.v16accfloat %call10, 0, !dbg !2971
  store %struct.ipd.custom_type.v16acc32.v16acc32 %13, ptr %12, align 32, !dbg !2971
  %14 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !2972
  ret %struct.v16accfloat %14, !dbg !2972
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.1" @_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2973 {
entry:
  %retval = alloca %"class.aie::vector.1", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2980, metadata !DIExpression()), !dbg !2982
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !2981, metadata !DIExpression()), !dbg !2983
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %"class.aie::vector.1" @_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 0) #24, !dbg !2984
  %0 = getelementptr inbounds %"class.aie::vector.1", ptr %retval, i32 0, i32 0, !dbg !2984
  %1 = extractvalue %"class.aie::vector.1" %call, 0, !dbg !2984
  store %"class.aie::detail::vector_base.2" %1, ptr %0, align 32, !dbg !2984
  %2 = load %"class.aie::vector.1", ptr %retval, align 32, !dbg !2986
  ret %"class.aie::vector.1" %2, !dbg !2986
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local noundef i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %this) addrspace(1) #9 comdat align 2 !dbg !2987 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2989, metadata !DIExpression()), !dbg !2991
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv(ptr nonnull align 1 dereferenceable(1) %this1) #24, !dbg !2992
  ret i32 %call, !dbg !2993
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum.3" @_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !2994 {
entry:
  %retval = alloca %"class.aie::accum.3", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !2999, metadata !DIExpression()), !dbg !3001
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3000, metadata !DIExpression()), !dbg !3002
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %"class.aie::accum.3" @_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv(ptr nonnull align 32 dereferenceable(32) %this1) #24, !dbg !3003
  %0 = getelementptr inbounds %"class.aie::accum.3", ptr %retval, i32 0, i32 0, !dbg !3003
  %1 = extractvalue %"class.aie::accum.3" %call, 0, !dbg !3003
  store %"class.aie::detail::accum_base.4" %1, ptr %0, align 32, !dbg !3003
  %2 = load %"class.aie::accum.3", ptr %retval, align 32, !dbg !3005
  ret %"class.aie::accum.3" %2, !dbg !3005
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z11mac_elem_168v16floatS_11v16accfloat(%struct.v16float %v1.coerce, %struct.v16float %v2.coerce, %struct.v16accfloat %acc.coerce) addrspace(1) #6 comdat !dbg !3006 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %v1 = alloca %struct.v16float, align 32
  %v2 = alloca %struct.v16float, align 32
  %acc = alloca %struct.v16accfloat, align 32
  store %struct.v16float %v1.coerce, ptr %v1, align 32
  store %struct.v16float %v2.coerce, ptr %v2, align 32
  store %struct.v16accfloat %acc.coerce, ptr %acc, align 32
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1, metadata !3011, metadata !DIExpression()), !dbg !3014
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2, metadata !3012, metadata !DIExpression()), !dbg !3014
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !3013, metadata !DIExpression()), !dbg !3014
  %0 = load %struct.v16float, ptr %v1, align 32, !dbg !3014, !tbaa !2155
  %1 = load %struct.v16float, ptr %v2, align 32, !dbg !3014, !tbaa !2155
  %2 = load %struct.v16accfloat, ptr %acc, align 32, !dbg !3014, !tbaa !2306
  %call = call addrspace(1) %struct.v16accfloat @_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii(%struct.v16float %0, %struct.v16float %1, %struct.v16accfloat %2, i32 0, i32 0, i32 0) #24, !dbg !3014
  %3 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !3014
  %4 = extractvalue %struct.v16accfloat %call, 0, !dbg !3014
  store %struct.ipd.custom_type.v16acc32.v16acc32 %4, ptr %3, align 32, !dbg !3014
  %5 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !3014
  ret %struct.v16accfloat %5, !dbg !3014
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZNK3aie6vectorIfLj16EEcv8v16floatEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !3015 {
entry:
  %retval = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3017, metadata !DIExpression()), !dbg !3018
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v16float @_ZNK3aie6vectorIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this1) #24, !dbg !3019
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !3019
  %1 = extractvalue %struct.v16float %call, 0, !dbg !3019
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !3019
  %2 = load %struct.v16float, ptr %retval, align 32, !dbg !3020
  ret %struct.v16float %2, !dbg !3020
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !3021 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3023, metadata !DIExpression()), !dbg !3024
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v16accfloat @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %this1) #24, !dbg !3025
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !3025
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !3025
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !3025
  %2 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !3026
  ret %struct.v16accfloat %2, !dbg !3026
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii(%struct.v16float %v1.coerce, %struct.v16float %v2.coerce, %struct.v16accfloat %acc.coerce, i32 %zero_acc, i32 %sub_mul, i32 %sub_acc1) addrspace(1) #6 comdat !dbg !3027 {
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
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1, metadata !3031, metadata !DIExpression()), !dbg !3038
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2, metadata !3032, metadata !DIExpression()), !dbg !3038
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !3033, metadata !DIExpression()), !dbg !3038
  store i32 %zero_acc, ptr %zero_acc.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %zero_acc.addr, metadata !3034, metadata !DIExpression()), !dbg !3038
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_mul.addr, metadata !3035, metadata !DIExpression()), !dbg !3038
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_acc1.addr, metadata !3036, metadata !DIExpression()), !dbg !3038
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3037, metadata !DIExpression()), !dbg !3038
  %0 = load i32, ptr %zero_acc.addr, align 4, !dbg !3038, !tbaa !1780
  %1 = load i32, ptr %sub_mul.addr, align 4, !dbg !3038, !tbaa !1780
  %2 = load i32, ptr %sub_acc1.addr, align 4, !dbg !3038, !tbaa !1780
  %3 = load %struct.v16float, ptr %v1, align 32, !dbg !3038, !tbaa !2155
  %4 = load %struct.v16float, ptr %v2, align 32, !dbg !3038, !tbaa !2155
  %5 = load %struct.v16accfloat, ptr %acc, align 32, !dbg !3038, !tbaa !2306
  %call = call addrspace(1) %struct.v16accfloat @_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii(%struct.v16float %3, %struct.v16float %4, %struct.v16accfloat %5, i32 %0, i32 %1, i32 %2) #24, !dbg !3038
  %6 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !3038
  %7 = extractvalue %struct.v16accfloat %call, 0, !dbg !3038
  store %struct.ipd.custom_type.v16acc32.v16acc32 %7, ptr %6, align 32, !dbg !3038
  %8 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !3038
  ret %struct.v16accfloat %8, !dbg !3038
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii(%struct.v16float %v1.coerce, %struct.v16float %v2.coerce, %struct.v16accfloat %acc.coerce, i32 %zero_acc, i32 %sub_mul, i32 %sub_acc1) addrspace(1) #6 comdat !dbg !3039 {
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
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v1, metadata !3042, metadata !DIExpression()), !dbg !3057
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v2, metadata !3043, metadata !DIExpression()), !dbg !3058
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc, metadata !3044, metadata !DIExpression()), !dbg !3059
  store i32 %zero_acc, ptr %zero_acc.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %zero_acc.addr, metadata !3045, metadata !DIExpression()), !dbg !3060
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_mul.addr, metadata !3046, metadata !DIExpression()), !dbg !3061
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sub_acc1.addr, metadata !3047, metadata !DIExpression()), !dbg !3062
  store %struct.v32bfloat16 undef, ptr %a, align 32, !dbg !3063
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %a) #22, !dbg !3063
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a, metadata !3048, metadata !DIExpression()), !dbg !3064
  %call = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3065
  %0 = getelementptr inbounds %struct.v32bfloat16, ptr %a, i32 0, i32 0, !dbg !3065
  %1 = extractvalue %struct.v32bfloat16 %call, 0, !dbg !3065
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !3065
  store %struct.v32bfloat16 undef, ptr %b, align 32, !dbg !3066
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %b) #22, !dbg !3066
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %b, metadata !3049, metadata !DIExpression()), !dbg !3067
  %call1 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3068
  %2 = getelementptr inbounds %struct.v32bfloat16, ptr %b, i32 0, i32 0, !dbg !3068
  %3 = extractvalue %struct.v32bfloat16 %call1, 0, !dbg !3068
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32, !dbg !3068
  store %struct.v32bfloat16 undef, ptr %c, align 32, !dbg !3069
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %c) #22, !dbg !3069
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %c, metadata !3050, metadata !DIExpression()), !dbg !3070
  %call2 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3071
  %4 = getelementptr inbounds %struct.v32bfloat16, ptr %c, i32 0, i32 0, !dbg !3071
  %5 = extractvalue %struct.v32bfloat16 %call2, 0, !dbg !3071
  store %struct.ipd.custom_type.v128int4.v128int4 %5, ptr %4, align 32, !dbg !3071
  store %struct.v32bfloat16 undef, ptr %d, align 32, !dbg !3072
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %d) #22, !dbg !3072
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %d, metadata !3051, metadata !DIExpression()), !dbg !3073
  %call3 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3074
  %6 = getelementptr inbounds %struct.v32bfloat16, ptr %d, i32 0, i32 0, !dbg !3074
  %7 = extractvalue %struct.v32bfloat16 %call3, 0, !dbg !3074
  store %struct.ipd.custom_type.v128int4.v128int4 %7, ptr %6, align 32, !dbg !3074
  store %struct.v32bfloat16 undef, ptr %e, align 32, !dbg !3075
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %e) #22, !dbg !3075
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %e, metadata !3052, metadata !DIExpression()), !dbg !3076
  %call4 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3077
  %8 = getelementptr inbounds %struct.v32bfloat16, ptr %e, i32 0, i32 0, !dbg !3077
  %9 = extractvalue %struct.v32bfloat16 %call4, 0, !dbg !3077
  store %struct.ipd.custom_type.v128int4.v128int4 %9, ptr %8, align 32, !dbg !3077
  store %struct.v32bfloat16 undef, ptr %f, align 32, !dbg !3078
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %f) #22, !dbg !3078
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %f, metadata !3053, metadata !DIExpression()), !dbg !3079
  %call5 = call addrspace(1) %struct.v32bfloat16 @_Z29broadcast_zero_to_v32bfloat16v() #24, !dbg !3080
  %10 = getelementptr inbounds %struct.v32bfloat16, ptr %f, i32 0, i32 0, !dbg !3080
  %11 = extractvalue %struct.v32bfloat16 %call5, 0, !dbg !3080
  store %struct.ipd.custom_type.v128int4.v128int4 %11, ptr %10, align 32, !dbg !3080
  store %struct.v32bfloat16 undef, ptr %dummy0, align 32, !dbg !3081
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %dummy0) #22, !dbg !3081
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %dummy0, metadata !3054, metadata !DIExpression()), !dbg !3082
  %call6 = call addrspace(1) %struct.v32bfloat16 @_Z28broadcast_one_to_v32bfloat16v() #24, !dbg !3083
  %12 = getelementptr inbounds %struct.v32bfloat16, ptr %dummy0, i32 0, i32 0, !dbg !3083
  %13 = extractvalue %struct.v32bfloat16 %call6, 0, !dbg !3083
  store %struct.ipd.custom_type.v128int4.v128int4 %13, ptr %12, align 32, !dbg !3083
  %14 = load %struct.v16float, ptr %v1, align 32, !dbg !3084, !tbaa !2155
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v16float %14) #27, !dbg !3084
  %15 = load %struct.v16accfloat, ptr %custom_type.tmp, align 32, !dbg !3084, !tbaa !2306
  store %struct.v16accfloat %15, ptr %agg.tmp7, align 32, !dbg !3084, !tbaa !2306
  %16 = load %struct.v16accfloat, ptr %agg.tmp7, align 32, !dbg !3085, !tbaa !2306
  %call8 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %16) #24, !dbg !3085
  %17 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp, i32 0, i32 0, !dbg !3085
  %18 = extractvalue %struct.v16bfloat16 %call8, 0, !dbg !3085
  store %struct.ipd.custom_type.v64int4.v64int4 %18, ptr %17, align 32, !dbg !3085
  %19 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3086, !tbaa !2155
  %20 = load %struct.v16bfloat16, ptr %agg.tmp, align 32, !dbg !3086, !tbaa !2248
  %call9 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %19, i32 0, %struct.v16bfloat16 %20) #24, !dbg !3086
  %21 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp10, i32 0, i32 0, !dbg !3086
  %22 = extractvalue %struct.v32bfloat16 %call9, 0, !dbg !3086
  store %struct.ipd.custom_type.v128int4.v128int4 %22, ptr %21, align 32, !dbg !3086
  %23 = load %struct.v32bfloat16, ptr %agg.tmp10, align 32, !dbg !3087, !tbaa !2155
  store %struct.v32bfloat16 %23, ptr %a, align 32, !dbg !3087, !tbaa !2155
  store %struct.v16accfloat undef, ptr %acc0, align 32, !dbg !3088
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %acc0) #22, !dbg !3088
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc0, metadata !3055, metadata !DIExpression()), !dbg !3089
  %24 = load %struct.v16float, ptr %v1, align 32, !dbg !3090, !tbaa !2155
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp12, %struct.v16float %24) #27, !dbg !3090
  %25 = load %struct.v16accfloat, ptr %custom_type.tmp12, align 32, !dbg !3090, !tbaa !2306
  store %struct.v16accfloat %25, ptr %agg.tmp11, align 32, !dbg !3090, !tbaa !2306
  %26 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3091, !tbaa !2155
  %27 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !3091, !tbaa !2155
  %28 = load %struct.v16accfloat, ptr %agg.tmp11, align 32, !dbg !3091, !tbaa !2306
  %call13 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %26, %struct.v32bfloat16 %27, %struct.v16accfloat %28) #24, !dbg !3091
  %29 = getelementptr inbounds %struct.v16accfloat, ptr %acc0, i32 0, i32 0, !dbg !3091
  %30 = extractvalue %struct.v16accfloat %call13, 0, !dbg !3091
  store %struct.ipd.custom_type.v16acc32.v16acc32 %30, ptr %29, align 32, !dbg !3091
  %31 = load %struct.v16accfloat, ptr %acc0, align 32, !dbg !3092, !tbaa !2306
  %call15 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %31) #24, !dbg !3092
  %32 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp14, i32 0, i32 0, !dbg !3092
  %33 = extractvalue %struct.v16bfloat16 %call15, 0, !dbg !3092
  store %struct.ipd.custom_type.v64int4.v64int4 %33, ptr %32, align 32, !dbg !3092
  %34 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !3093, !tbaa !2155
  %35 = load %struct.v16bfloat16, ptr %agg.tmp14, align 32, !dbg !3093, !tbaa !2248
  %call16 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %34, i32 0, %struct.v16bfloat16 %35) #24, !dbg !3093
  %36 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp17, i32 0, i32 0, !dbg !3093
  %37 = extractvalue %struct.v32bfloat16 %call16, 0, !dbg !3093
  store %struct.ipd.custom_type.v128int4.v128int4 %37, ptr %36, align 32, !dbg !3093
  %38 = load %struct.v32bfloat16, ptr %agg.tmp17, align 32, !dbg !3094, !tbaa !2155
  store %struct.v32bfloat16 %38, ptr %b, align 32, !dbg !3094, !tbaa !2155
  %39 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !3095, !tbaa !2155
  %40 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !3095, !tbaa !2155
  %41 = load %struct.v16accfloat, ptr %acc0, align 32, !dbg !3095, !tbaa !2306
  %call20 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %39, %struct.v32bfloat16 %40, %struct.v16accfloat %41) #24, !dbg !3095
  %42 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp19, i32 0, i32 0, !dbg !3095
  %43 = extractvalue %struct.v16accfloat %call20, 0, !dbg !3095
  store %struct.ipd.custom_type.v16acc32.v16acc32 %43, ptr %42, align 32, !dbg !3095
  %44 = load %struct.v16accfloat, ptr %agg.tmp19, align 32, !dbg !3096, !tbaa !2306
  %call21 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %44) #24, !dbg !3096
  %45 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp18, i32 0, i32 0, !dbg !3096
  %46 = extractvalue %struct.v16bfloat16 %call21, 0, !dbg !3096
  store %struct.ipd.custom_type.v64int4.v64int4 %46, ptr %45, align 32, !dbg !3096
  %47 = load %struct.v32bfloat16, ptr %c, align 32, !dbg !3097, !tbaa !2155
  %48 = load %struct.v16bfloat16, ptr %agg.tmp18, align 32, !dbg !3097, !tbaa !2248
  %call22 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %47, i32 0, %struct.v16bfloat16 %48) #24, !dbg !3097
  %49 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp23, i32 0, i32 0, !dbg !3097
  %50 = extractvalue %struct.v32bfloat16 %call22, 0, !dbg !3097
  store %struct.ipd.custom_type.v128int4.v128int4 %50, ptr %49, align 32, !dbg !3097
  %51 = load %struct.v32bfloat16, ptr %agg.tmp23, align 32, !dbg !3098, !tbaa !2155
  store %struct.v32bfloat16 %51, ptr %c, align 32, !dbg !3098, !tbaa !2155
  %52 = load %struct.v16float, ptr %v2, align 32, !dbg !3099, !tbaa !2155
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp26, %struct.v16float %52) #27, !dbg !3099
  %53 = load %struct.v16accfloat, ptr %custom_type.tmp26, align 32, !dbg !3099, !tbaa !2306
  store %struct.v16accfloat %53, ptr %agg.tmp25, align 32, !dbg !3099, !tbaa !2306
  %54 = load %struct.v16accfloat, ptr %agg.tmp25, align 32, !dbg !3100, !tbaa !2306
  %call27 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %54) #24, !dbg !3100
  %55 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp24, i32 0, i32 0, !dbg !3100
  %56 = extractvalue %struct.v16bfloat16 %call27, 0, !dbg !3100
  store %struct.ipd.custom_type.v64int4.v64int4 %56, ptr %55, align 32, !dbg !3100
  %57 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3101, !tbaa !2155
  %58 = load %struct.v16bfloat16, ptr %agg.tmp24, align 32, !dbg !3101, !tbaa !2248
  %call28 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %57, i32 0, %struct.v16bfloat16 %58) #24, !dbg !3101
  %59 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp29, i32 0, i32 0, !dbg !3101
  %60 = extractvalue %struct.v32bfloat16 %call28, 0, !dbg !3101
  store %struct.ipd.custom_type.v128int4.v128int4 %60, ptr %59, align 32, !dbg !3101
  %61 = load %struct.v32bfloat16, ptr %agg.tmp29, align 32, !dbg !3102, !tbaa !2155
  store %struct.v32bfloat16 %61, ptr %d, align 32, !dbg !3102, !tbaa !2155
  store %struct.v16accfloat undef, ptr %acc1, align 32, !dbg !3103
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %acc1) #22, !dbg !3103
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc1, metadata !3056, metadata !DIExpression()), !dbg !3104
  %62 = load %struct.v16float, ptr %v2, align 32, !dbg !3105, !tbaa !2155
  call addrspace(1) void @_ZN11v16accfloatC2E8v16float(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp31, %struct.v16float %62) #27, !dbg !3105
  %63 = load %struct.v16accfloat, ptr %custom_type.tmp31, align 32, !dbg !3105, !tbaa !2306
  store %struct.v16accfloat %63, ptr %agg.tmp30, align 32, !dbg !3105, !tbaa !2306
  %64 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3106, !tbaa !2155
  %65 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !3106, !tbaa !2155
  %66 = load %struct.v16accfloat, ptr %agg.tmp30, align 32, !dbg !3106, !tbaa !2306
  %call32 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %64, %struct.v32bfloat16 %65, %struct.v16accfloat %66) #24, !dbg !3106
  %67 = getelementptr inbounds %struct.v16accfloat, ptr %acc1, i32 0, i32 0, !dbg !3106
  %68 = extractvalue %struct.v16accfloat %call32, 0, !dbg !3106
  store %struct.ipd.custom_type.v16acc32.v16acc32 %68, ptr %67, align 32, !dbg !3106
  %69 = load %struct.v16accfloat, ptr %acc1, align 32, !dbg !3107, !tbaa !2306
  %call34 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %69) #24, !dbg !3107
  %70 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp33, i32 0, i32 0, !dbg !3107
  %71 = extractvalue %struct.v16bfloat16 %call34, 0, !dbg !3107
  store %struct.ipd.custom_type.v64int4.v64int4 %71, ptr %70, align 32, !dbg !3107
  %72 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !3108, !tbaa !2155
  %73 = load %struct.v16bfloat16, ptr %agg.tmp33, align 32, !dbg !3108, !tbaa !2248
  %call35 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %72, i32 0, %struct.v16bfloat16 %73) #24, !dbg !3108
  %74 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp36, i32 0, i32 0, !dbg !3108
  %75 = extractvalue %struct.v32bfloat16 %call35, 0, !dbg !3108
  store %struct.ipd.custom_type.v128int4.v128int4 %75, ptr %74, align 32, !dbg !3108
  %76 = load %struct.v32bfloat16, ptr %agg.tmp36, align 32, !dbg !3109, !tbaa !2155
  store %struct.v32bfloat16 %76, ptr %e, align 32, !dbg !3109, !tbaa !2155
  %77 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !3110, !tbaa !2155
  %78 = load %struct.v32bfloat16, ptr %dummy0, align 32, !dbg !3110, !tbaa !2155
  %79 = load %struct.v16accfloat, ptr %acc1, align 32, !dbg !3110, !tbaa !2306
  %call39 = call addrspace(1) %struct.v16accfloat @_Z13msc_elem_16_211v32bfloat16S_11v16accfloat(%struct.v32bfloat16 %77, %struct.v32bfloat16 %78, %struct.v16accfloat %79) #24, !dbg !3110
  %80 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp38, i32 0, i32 0, !dbg !3110
  %81 = extractvalue %struct.v16accfloat %call39, 0, !dbg !3110
  store %struct.ipd.custom_type.v16acc32.v16acc32 %81, ptr %80, align 32, !dbg !3110
  %82 = load %struct.v16accfloat, ptr %agg.tmp38, align 32, !dbg !3111, !tbaa !2306
  %call40 = call addrspace(1) %struct.v16bfloat16 @_Z14to_v16bfloat1611v16accfloat(%struct.v16accfloat %82) #24, !dbg !3111
  %83 = getelementptr inbounds %struct.v16bfloat16, ptr %agg.tmp37, i32 0, i32 0, !dbg !3111
  %84 = extractvalue %struct.v16bfloat16 %call40, 0, !dbg !3111
  store %struct.ipd.custom_type.v64int4.v64int4 %84, ptr %83, align 32, !dbg !3111
  %85 = load %struct.v32bfloat16, ptr %f, align 32, !dbg !3112, !tbaa !2155
  %86 = load %struct.v16bfloat16, ptr %agg.tmp37, align 32, !dbg !3112, !tbaa !2248
  %call41 = call addrspace(1) %struct.v32bfloat16 @_Z6insert11v32bfloat16i11v16bfloat16(%struct.v32bfloat16 %85, i32 0, %struct.v16bfloat16 %86) #24, !dbg !3112
  %87 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp42, i32 0, i32 0, !dbg !3112
  %88 = extractvalue %struct.v32bfloat16 %call41, 0, !dbg !3112
  store %struct.ipd.custom_type.v128int4.v128int4 %88, ptr %87, align 32, !dbg !3112
  %89 = load %struct.v32bfloat16, ptr %agg.tmp42, align 32, !dbg !3113, !tbaa !2155
  store %struct.v32bfloat16 %89, ptr %f, align 32, !dbg !3113, !tbaa !2155
  %90 = load i32, ptr %sub_mul.addr, align 4, !dbg !3114, !tbaa !1780
  %91 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3115, !tbaa !2155
  %92 = load %struct.v32bfloat16, ptr %f, align 32, !dbg !3115, !tbaa !2155
  %call48 = call addrspace(1) %struct.v16accfloat @_Z18mul_elem_16_2_conf11v32bfloat16S_i(%struct.v32bfloat16 %91, %struct.v32bfloat16 %92, i32 %90) #24, !dbg !3115
  %93 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp47, i32 0, i32 0, !dbg !3115
  %94 = extractvalue %struct.v16accfloat %call48, 0, !dbg !3115
  store %struct.ipd.custom_type.v16acc32.v16acc32 %94, ptr %93, align 32, !dbg !3115
  %95 = load i32, ptr %sub_mul.addr, align 4, !dbg !3116, !tbaa !1780
  %96 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !3117, !tbaa !2155
  %97 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !3117, !tbaa !2155
  %98 = load %struct.v16accfloat, ptr %agg.tmp47, align 32, !dbg !3117, !tbaa !2306
  %call49 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %96, %struct.v32bfloat16 %97, %struct.v16accfloat %98, i32 0, i32 %95, i32 0) #24, !dbg !3117
  %99 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp46, i32 0, i32 0, !dbg !3117
  %100 = extractvalue %struct.v16accfloat %call49, 0, !dbg !3117
  store %struct.ipd.custom_type.v16acc32.v16acc32 %100, ptr %99, align 32, !dbg !3117
  %101 = load i32, ptr %sub_mul.addr, align 4, !dbg !3118, !tbaa !1780
  %102 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3119, !tbaa !2155
  %103 = load %struct.v32bfloat16, ptr %c, align 32, !dbg !3119, !tbaa !2155
  %104 = load %struct.v16accfloat, ptr %agg.tmp46, align 32, !dbg !3119, !tbaa !2306
  %call50 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %102, %struct.v32bfloat16 %103, %struct.v16accfloat %104, i32 0, i32 %101, i32 0) #24, !dbg !3119
  %105 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp45, i32 0, i32 0, !dbg !3119
  %106 = extractvalue %struct.v16accfloat %call50, 0, !dbg !3119
  store %struct.ipd.custom_type.v16acc32.v16acc32 %106, ptr %105, align 32, !dbg !3119
  %107 = load i32, ptr %sub_mul.addr, align 4, !dbg !3120, !tbaa !1780
  %108 = load %struct.v32bfloat16, ptr %b, align 32, !dbg !3121, !tbaa !2155
  %109 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3121, !tbaa !2155
  %110 = load %struct.v16accfloat, ptr %agg.tmp45, align 32, !dbg !3121, !tbaa !2306
  %call51 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %108, %struct.v32bfloat16 %109, %struct.v16accfloat %110, i32 0, i32 %107, i32 0) #24, !dbg !3121
  %111 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp44, i32 0, i32 0, !dbg !3121
  %112 = extractvalue %struct.v16accfloat %call51, 0, !dbg !3121
  store %struct.ipd.custom_type.v16acc32.v16acc32 %112, ptr %111, align 32, !dbg !3121
  %113 = load i32, ptr %sub_mul.addr, align 4, !dbg !3122, !tbaa !1780
  %114 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3123, !tbaa !2155
  %115 = load %struct.v32bfloat16, ptr %e, align 32, !dbg !3123, !tbaa !2155
  %116 = load %struct.v16accfloat, ptr %agg.tmp44, align 32, !dbg !3123, !tbaa !2306
  %call52 = call addrspace(1) %struct.v16accfloat @_Z18mac_elem_16_2_conf11v32bfloat16S_11v16accfloatiii(%struct.v32bfloat16 %114, %struct.v32bfloat16 %115, %struct.v16accfloat %116, i32 0, i32 %113, i32 0) #24, !dbg !3123
  %117 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp43, i32 0, i32 0, !dbg !3123
  %118 = extractvalue %struct.v16accfloat %call52, 0, !dbg !3123
  store %struct.ipd.custom_type.v16acc32.v16acc32 %118, ptr %117, align 32, !dbg !3123
  %119 = load i32, ptr %zero_acc.addr, align 4, !dbg !3124, !tbaa !1780
  %120 = load i32, ptr %sub_mul.addr, align 4, !dbg !3125, !tbaa !1780
  %121 = load i32, ptr %sub_acc1.addr, align 4, !dbg !3126, !tbaa !1780
  %122 = load %struct.v32bfloat16, ptr %a, align 32, !dbg !3127, !tbaa !2155
  %123 = load %struct.v32bfloat16, ptr %d, align 32, !dbg !3127, !tbaa !2155
  %124 = load %struct.v16accfloat, ptr %acc, align 32, !dbg !3127, !tbaa !2306
  %125 = load %struct.v16accfloat, ptr %agg.tmp43, align 32, !dbg !3127, !tbaa !2306
  %call53 = call addrspace(1) %struct.v16accfloat @_Z21addmac_elem_16_2_conf11v32bfloat16S_11v16accfloatS0_iiii(%struct.v32bfloat16 %122, %struct.v32bfloat16 %123, %struct.v16accfloat %124, %struct.v16accfloat %125, i32 %119, i32 %120, i32 %121, i32 0) #24, !dbg !3127
  %126 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !3127
  %127 = extractvalue %struct.v16accfloat %call53, 0, !dbg !3127
  store %struct.ipd.custom_type.v16acc32.v16acc32 %127, ptr %126, align 32, !dbg !3127
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %acc1) #22, !dbg !3128
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %acc0) #22, !dbg !3128
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %dummy0) #22, !dbg !3128
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %f) #22, !dbg !3128
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %e) #22, !dbg !3128
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %d) #22, !dbg !3128
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %c) #22, !dbg !3128
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %b) #22, !dbg !3128
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %a) #22, !dbg !3128
  %128 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !3128
  ret %struct.v16accfloat %128, !dbg !3128
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
  %2 = load %struct.v32uint16, ptr %agg.tmp, align 32, !tbaa !2155
  call addrspace(1) void @_ZN11v32bfloat16C2E9v32uint16(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v32uint16 %2) #27
  %3 = load %struct.v32bfloat16, ptr %custom_type.tmp, align 32, !tbaa !2155
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
  %2 = load %struct.v32uint16, ptr %agg.tmp, align 32, !tbaa !2155
  call addrspace(1) void @_ZN11v32bfloat16C2E9v32uint16(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, %struct.v32uint16 %2) #27
  %3 = load %struct.v32bfloat16, ptr %custom_type.tmp, align 32, !tbaa !2155
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
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1780
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2155
  %2 = load %struct.v16bfloat16, ptr %b, align 32, !tbaa !2248
  %call = call addrspace(1) %struct.v32bfloat16 @_ZN12me_primitive6upd_xlE11v32bfloat1611v16bfloat16(%struct.v32bfloat16 %1, %struct.v16bfloat16 %2) #26
  %3 = getelementptr inbounds %struct.v32bfloat16, ptr %retval, i32 0, i32 0
  %4 = extractvalue %struct.v32bfloat16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %4, ptr %3, align 32
  br label %return

if.else:                                          ; preds = %entry
  %5 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2155
  %6 = load %struct.v16bfloat16, ptr %b, align 32, !tbaa !2248
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
  %0 = load %struct.ipd.custom_type.uint4_t.uint4_t, ptr %custom_type.tmp, align 1, !tbaa !3129
  store %struct.ipd.custom_type.uint4_t.uint4_t %0, ptr %agg.tmp, align 1, !tbaa !3129
  %call3 = call addrspace(1) i32 @_Z14get_fp2bf_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %1 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3131
  store %struct.ipd.custom_type.uint5_t.uint5_t %1, ptr %agg.tmp1, align 4, !tbaa !3131
  %2 = load %struct.v16accfloat, ptr %acc, align 32, !tbaa !2306
  %3 = load %struct.ipd.custom_type.uint4_t.uint4_t, ptr %agg.tmp, align 1, !tbaa !3129
  %4 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3131
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v16accfloat, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v16acc32.v16acc32, ptr %custom_type.tmp, align 32, !tbaa !2306
  store %struct.ipd.custom_type.v16acc32.v16acc32 %0, ptr %mw, align 32, !tbaa !2306
  %1 = load %struct.v16float, ptr %a0, align 32, !tbaa !2155
  %call = call x86_regcallcc addrspace(1) %struct.v16accfloat @__regcall3__chessintr_v16accfloat_v16accfloat_v16float(%struct.v16float %1) #25
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !tbaa !2306
  store %struct.v16accfloat %4, ptr %this1, align 32, !tbaa !2306
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
  store i32 %call, ptr %conf, align 4, !tbaa !1780
  %0 = load i32, ptr %conf, align 4, !tbaa !1780
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 1) #24
  %1 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2375
  store %struct.ipd.custom_type.uint1_t.uint1_t %1, ptr %agg.tmp, align 4, !tbaa !2375
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %2 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3131
  store %struct.ipd.custom_type.uint5_t.uint5_t %2, ptr %agg.tmp1, align 4, !tbaa !3131
  %3 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2155
  %4 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2155
  %5 = load %struct.v16accfloat, ptr %acc1, align 32, !tbaa !2306
  %6 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2375
  %7 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3131
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
  store i32 %zero_acc1, ptr %zero_acc1.addr, align 4, !tbaa !1780
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1780
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1780
  store i32 %sub_acc2, ptr %sub_acc2.addr, align 4, !tbaa !1780
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #22
  %0 = load i32, ptr %zero_acc1.addr, align 4, !tbaa !1780
  %1 = load i32, ptr %sub_mul.addr, align 4, !tbaa !1780
  %2 = load i32, ptr %sub_acc1.addr, align 4, !tbaa !1780
  %3 = load i32, ptr %sub_acc2.addr, align 4, !tbaa !1780
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 %0, i32 0, i32 %1, i32 %2, i32 %3, i32 0) #24
  store i32 %call, ptr %conf, align 4, !tbaa !1780
  %4 = load i32, ptr %conf, align 4, !tbaa !1780
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 0) #24
  %5 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2375
  store %struct.ipd.custom_type.uint1_t.uint1_t %5, ptr %agg.tmp, align 4, !tbaa !2375
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %6 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3131
  store %struct.ipd.custom_type.uint5_t.uint5_t %6, ptr %agg.tmp1, align 4, !tbaa !3131
  %7 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2155
  %8 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2155
  %9 = load %struct.v16accfloat, ptr %acc1, align 32, !tbaa !2306
  %10 = load %struct.v16accfloat, ptr %acc2, align 32, !tbaa !2306
  %11 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2375
  %12 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3131
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
  store i32 %zero_acc1, ptr %zero_acc1.addr, align 4, !tbaa !1780
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1780
  store i32 %sub_acc1, ptr %sub_acc1.addr, align 4, !tbaa !1780
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #22
  %0 = load i32, ptr %zero_acc1.addr, align 4, !tbaa !1780
  %1 = load i32, ptr %sub_mul.addr, align 4, !tbaa !1780
  %2 = load i32, ptr %sub_acc1.addr, align 4, !tbaa !1780
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 %0, i32 0, i32 %1, i32 %2, i32 0, i32 0) #24
  store i32 %call, ptr %conf, align 4, !tbaa !1780
  %3 = load i32, ptr %conf, align 4, !tbaa !1780
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 0) #24
  %4 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2375
  store %struct.ipd.custom_type.uint1_t.uint1_t %4, ptr %agg.tmp, align 4, !tbaa !2375
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %5 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3131
  store %struct.ipd.custom_type.uint5_t.uint5_t %5, ptr %agg.tmp1, align 4, !tbaa !3131
  %6 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2155
  %7 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2155
  %8 = load %struct.v16accfloat, ptr %acc1, align 32, !tbaa !2306
  %9 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2375
  %10 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3131
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
  store i32 %sub_mul, ptr %sub_mul.addr, align 4, !tbaa !1780
  store i32 undef, ptr %conf, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %conf) #22
  %0 = load i32, ptr %sub_mul.addr, align 4, !tbaa !1780
  %call = call addrspace(1) i32 @_ZN9me_detail15compute_controlEiiiiiiiiiii(i32 0, i32 0, i32 2, i32 3, i32 1, i32 0, i32 0, i32 %0, i32 0, i32 0, i32 0) #24
  store i32 %call, ptr %conf, align 4, !tbaa !1780
  %1 = load i32, ptr %conf, align 4, !tbaa !1780
  call addrspace(1) void @_ZN7uint1_tC2Ei(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp, i32 0) #24
  %2 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %custom_type.tmp, align 4, !tbaa !2375
  store %struct.ipd.custom_type.uint1_t.uint1_t %2, ptr %agg.tmp, align 4, !tbaa !2375
  %call3 = call addrspace(1) i32 @_Z17get_fpmulmac_maskv() #24
  call addrspace(1) void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %custom_type.tmp2, i32 %call3) #24
  %3 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %custom_type.tmp2, align 4, !tbaa !3131
  store %struct.ipd.custom_type.uint5_t.uint5_t %3, ptr %agg.tmp1, align 4, !tbaa !3131
  %4 = load %struct.v32bfloat16, ptr %a, align 32, !tbaa !2155
  %5 = load %struct.v32bfloat16, ptr %b, align 32, !tbaa !2155
  %6 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %agg.tmp, align 4, !tbaa !2375
  %7 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %agg.tmp1, align 4, !tbaa !3131
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
  store i16 %a0, ptr %a0.addr, align 2, !tbaa !3133
  %0 = load i16, ptr %a0.addr, align 2, !tbaa !3133
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v32bfloat16, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v128int4.v128int4, ptr %custom_type.tmp, align 32, !tbaa !2155
  store %struct.ipd.custom_type.v128int4.v128int4 %0, ptr %mw, align 32, !tbaa !2155
  %1 = load %struct.v32uint16, ptr %a0, align 32, !tbaa !2155
  %call = call x86_regcallcc addrspace(1) %struct.v32bfloat16 @__regcall3__chessintr_v32bfloat16_v32bfloat16_v32uint16(%struct.v32uint16 %1) #25
  %2 = getelementptr inbounds %struct.v32bfloat16, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v32bfloat16 %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  %4 = load %struct.v32bfloat16, ptr %agg.tmp, align 32, !tbaa !2155
  store %struct.v32bfloat16 %4, ptr %this1, align 32, !tbaa !2155
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
  %0 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2155
  %1 = load %struct.v16bfloat16, ptr %a1, align 32, !tbaa !2248
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
  %0 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2155
  %1 = load %struct.v16bfloat16, ptr %a1, align 32, !tbaa !2248
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
  %0 = load %struct.v16accfloat, ptr %a0, align 32, !tbaa !2306
  %1 = load %struct.ipd.custom_type.uint4_t.uint4_t, ptr %a1, align 1, !tbaa !3129
  %2 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a2, align 4, !tbaa !3131
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
  %0 = load i32, ptr @_ZN12me_primitive11control_rndE, align 4, !tbaa !1780
  ret i32 %0
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7uint4_tC2Ej(ptr nonnull align 1 dereferenceable(1) %this, i32 %a) unnamed_addr addrspace(1) #11 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  store i32 %a, ptr %a.addr, align 4, !tbaa !1780
  %this1 = load ptr, ptr %this.addr, align 4
  store i4 0, ptr %this1, align 1
  %0 = load i32, ptr %a.addr, align 4, !tbaa !1780
  %1 = call addrspace(1) %struct.ipd.custom_type.uint4_t.uint4_t @llvm.chess.init.customint.s_struct.ipd.custom_type.uint4_t.uint4_ts.i32.p1(%struct.ipd.custom_type.uint4_t.uint4_t undef, i32 %0, i32 4, i32 32, i1 false, i32 0, ptr addrspace(1) @__regcall3__chessintr_uint4_t_uint4_t___uint)
  store %struct.ipd.custom_type.uint4_t.uint4_t %1, ptr %this1, align 1
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local i32 @_Z14get_fp2bf_maskv() addrspace(1) #6 comdat {
entry:
  %ref.tmp = alloca %struct.ipd.custom_type.uint5_t.uint5_t, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %ref.tmp) #22
  %0 = load volatile %struct.ipd.custom_type.uint5_t.uint5_t, ptr !register !1511, align 4, !tbaa !3131, !chess_protect_access !3135
  store %struct.ipd.custom_type.uint5_t.uint5_t %0, ptr %ref.tmp, align 4, !tbaa !3131
  %call = call noundef addrspace(1) i32 @_ZNK7uint5_tcvjEv(ptr nonnull align 4 dereferenceable(1) %ref.tmp) #24
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %ref.tmp) #22
  ret i32 %call
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7uint5_tC2Ej(ptr nonnull align 4 dereferenceable(1) %this, i32 %a) unnamed_addr addrspace(1) #11 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  store i32 %a, ptr %a.addr, align 4, !tbaa !1780
  %this1 = load ptr, ptr %this.addr, align 4
  store i5 0, ptr %this1, align 4
  %0 = load i32, ptr %a.addr, align 4, !tbaa !1780
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
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %r, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %r) #22
  store i32 0, ptr %r, align 4, !tbaa !1780
  %0 = load i32, ptr %r, align 4, !tbaa !1780
  %1 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %this1, align 4, !tbaa !3131
  store %struct.ipd.custom_type.uint5_t.uint5_t %1, ptr %tmp, align 4, !tbaa !3131
  %2 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %tmp, align 4
  %3 = call addrspace(1) i32 @llvm.chess.convert.customint.i32.s_struct.ipd.custom_type.uint5_t.uint5_ts.p1(i32 undef, %struct.ipd.custom_type.uint5_t.uint5_t %2, i32 32, i32 5, i1 false, i32 0, ptr addrspace(1) @__regcall3__chessintr___uint___uint_uint5_t)
  store i32 %3, ptr %r, align 4
  %4 = load i32, ptr %r, align 4, !tbaa !1780
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
  store i32 %sgn_x, ptr %sgn_x.addr, align 4, !tbaa !1780
  store i32 %sgn_y, ptr %sgn_y.addr, align 4, !tbaa !1780
  store i32 %amode, ptr %amode.addr, align 4, !tbaa !1780
  store i32 %bmode, ptr %bmode.addr, align 4, !tbaa !1780
  store i32 %variant, ptr %variant.addr, align 4, !tbaa !1780
  store i32 %zero_acc, ptr %zero_acc.addr, align 4, !tbaa !1780
  store i32 %shift16, ptr %shift16.addr, align 4, !tbaa !1780
  store i32 %sub0, ptr %sub0.addr, align 4, !tbaa !1780
  store i32 %sub1, ptr %sub1.addr, align 4, !tbaa !1780
  store i32 %sub2, ptr %sub2.addr, align 4, !tbaa !1780
  store i32 %sub_mask, ptr %sub_mask.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %sub_mask.addr, align 4, !tbaa !1780
  %shl = shl i32 %0, 16
  %1 = load i32, ptr %shift16.addr, align 4, !tbaa !1780
  %shl1 = shl i32 %1, 10
  %or = or i32 %shl, %shl1
  %2 = load i32, ptr %sub0.addr, align 4, !tbaa !1780
  %shl2 = shl i32 %2, 11
  %or3 = or i32 %or, %shl2
  %3 = load i32, ptr %sub1.addr, align 4, !tbaa !1780
  %shl4 = shl i32 %3, 12
  %or5 = or i32 %or3, %shl4
  %4 = load i32, ptr %sub2.addr, align 4, !tbaa !1780
  %shl6 = shl i32 %4, 13
  %or7 = or i32 %or5, %shl6
  %5 = load i32, ptr %amode.addr, align 4, !tbaa !1780
  %shl8 = shl i32 %5, 1
  %or9 = or i32 %or7, %shl8
  %6 = load i32, ptr %bmode.addr, align 4, !tbaa !1780
  %shl10 = shl i32 %6, 3
  %or11 = or i32 %or9, %shl10
  %7 = load i32, ptr %variant.addr, align 4, !tbaa !1780
  %shl12 = shl i32 %7, 5
  %or13 = or i32 %or11, %shl12
  %8 = load i32, ptr %sgn_x.addr, align 4, !tbaa !1780
  %shl14 = shl i32 %8, 9
  %9 = load i32, ptr %sgn_y.addr, align 4, !tbaa !1780
  %shl15 = shl i32 %9, 8
  %or16 = or i32 %shl14, %shl15
  %or17 = or i32 %or13, %or16
  %10 = load i32, ptr %zero_acc.addr, align 4, !tbaa !1780
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
  store i32 %a3, ptr %a3.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %a3.addr, align 4, !tbaa !1780
  %1 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2155
  %2 = load %struct.v32bfloat16, ptr %a1, align 32, !tbaa !2155
  %3 = load %struct.v16accfloat, ptr %a2, align 32, !tbaa !2306
  %4 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a4, align 4, !tbaa !2375
  %5 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a5, align 4, !tbaa !3131
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
  %0 = load volatile %struct.ipd.custom_type.uint5_t.uint5_t, ptr !register !1512, align 4, !tbaa !3131, !chess_protect_access !3135
  store %struct.ipd.custom_type.uint5_t.uint5_t %0, ptr %ref.tmp, align 4, !tbaa !3131
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
  store i32 %a4, ptr %a4.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %a4.addr, align 4, !tbaa !1780
  %1 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2155
  %2 = load %struct.v32bfloat16, ptr %a1, align 32, !tbaa !2155
  %3 = load %struct.v16accfloat, ptr %a2, align 32, !tbaa !2306
  %4 = load %struct.v16accfloat, ptr %a3, align 32, !tbaa !2306
  %5 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a5, align 4, !tbaa !2375
  %6 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a6, align 4, !tbaa !3131
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
  store i32 %a2, ptr %a2.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %a2.addr, align 4, !tbaa !1780
  %1 = load %struct.v32bfloat16, ptr %a0, align 32, !tbaa !2155
  %2 = load %struct.v32bfloat16, ptr %a1, align 32, !tbaa !2155
  %3 = load %struct.ipd.custom_type.uint1_t.uint1_t, ptr %a3, align 4, !tbaa !2375
  %4 = load %struct.ipd.custom_type.uint5_t.uint5_t, ptr %a4, align 4, !tbaa !3131
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
define linkonce_odr dso_local %struct.v16float @_ZNK3aie6vectorIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !3136 {
entry:
  %retval = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3138, metadata !DIExpression()), !dbg !3139
  %this1 = load ptr, ptr %this.addr, align 4
  %call = call addrspace(1) %struct.v16float @_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this1) #24, !dbg !3140
  %0 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !3140
  %1 = extractvalue %struct.v16float %call, 0, !dbg !3140
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !3140
  %2 = load %struct.v16float, ptr %retval, align 32, !dbg !3141
  ret %struct.v16float %2, !dbg !3141
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !3142 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3144, metadata !DIExpression()), !dbg !3145
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base.2", ptr %this1, i32 0, i32 0, !dbg !3146
  %0 = load %struct.v16float, ptr %data, align 32, !dbg !3146, !tbaa !2155
  ret %struct.v16float %0, !dbg !3146
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv(ptr nonnull align 32 dereferenceable(64) %this) addrspace(1) #6 comdat align 2 !dbg !3148 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3150, metadata !DIExpression()), !dbg !3151
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base.4", ptr %this1, i32 0, i32 0, !dbg !3152
  %0 = load %struct.v16accfloat, ptr %data, align 32, !dbg !3152, !tbaa !2306
  ret %struct.v16accfloat %0, !dbg !3152
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.1" @_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3153 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector.1", align 32
  %ref.tmp = alloca %"class.aie::detail::vector_base.2", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3156, metadata !DIExpression()), !dbg !3158
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3157, metadata !DIExpression()), !dbg !3159
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3160
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3161, !tbaa !1780
  %call = call addrspace(1) %"class.aie::detail::vector_base.2" @_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0) #24, !dbg !3162
  %1 = getelementptr inbounds %"class.aie::detail::vector_base.2", ptr %ref.tmp, i32 0, i32 0, !dbg !3162
  %2 = extractvalue %"class.aie::detail::vector_base.2" %call, 0, !dbg !3162
  store %struct.v16float %2, ptr %1, align 32, !dbg !3162
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, ptr nonnull align 32 dereferenceable(64) %ref.tmp) #24, !dbg !3163
  %3 = load %"class.aie::vector.1", ptr %custom_type.tmp, align 32, !dbg !3163, !tbaa !2144
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3164
  ret %"class.aie::vector.1" %3, !dbg !3163
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base.2" @_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3165 {
entry:
  %retval = alloca %"class.aie::detail::vector_base.2", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %output_bits = alloca i32, align 4
  %growth_ratio = alloca i32, align 4
  %in_storage_elems = alloca i32, align 4
  %out_storage_elems = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::detail::vector_base.2", align 32
  %agg.tmp = alloca %struct.v16float, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3170, metadata !DIExpression()), !dbg !3178
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3172, metadata !DIExpression()), !dbg !3179
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %output_bits, align 4, !dbg !3180
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %output_bits) #22, !dbg !3180
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %output_bits, metadata !3173, metadata !DIExpression()), !dbg !3181
  store i32 512, ptr %output_bits, align 4, !dbg !3181, !tbaa !1780
  store i32 undef, ptr %growth_ratio, align 4, !dbg !3182
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %growth_ratio) #22, !dbg !3182
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %growth_ratio, metadata !3174, metadata !DIExpression()), !dbg !3183
  store i32 2, ptr %growth_ratio, align 4, !dbg !3183, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3175, metadata !DIExpression()), !dbg !3184
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %retval) #24, !dbg !3184
  store i32 undef, ptr %in_storage_elems, align 4, !dbg !3185
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %in_storage_elems) #22, !dbg !3185
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in_storage_elems, metadata !3176, metadata !DIExpression()), !dbg !3186
  store i32 1, ptr %in_storage_elems, align 4, !dbg !3186, !tbaa !1780
  store i32 undef, ptr %out_storage_elems, align 4, !dbg !3187
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %out_storage_elems) #22, !dbg !3187
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out_storage_elems, metadata !3177, metadata !DIExpression()), !dbg !3188
  store i32 1, ptr %out_storage_elems, align 4, !dbg !3188, !tbaa !1780
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3189
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !3193
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3194, !tbaa !1780
  %call = call addrspace(1) %struct.v16float @_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj(ptr nonnull align 32 dereferenceable(32) %data, i32 noundef %0) #24, !dbg !3189
  %1 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !3189
  %2 = extractvalue %struct.v16float %call, 0, !dbg !3189
  store %struct.ipd.custom_type.v128int4.v128int4 %2, ptr %1, align 32, !dbg !3189
  %3 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !3189, !tbaa !2155
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %ref.tmp, %struct.v16float %3) #24, !dbg !3189
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %retval, ptr align 32 %ref.tmp, i32 64, i1 false), !dbg !3195, !tbaa !3196, !tbaa.struct !3197
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3198
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %out_storage_elems) #22, !dbg !3199
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %in_storage_elems) #22, !dbg !3199
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %growth_ratio) #22, !dbg !3199
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %output_bits) #22, !dbg !3199
  %4 = load %"class.aie::detail::vector_base.2", ptr %retval, align 32, !dbg !3199
  ret %"class.aie::detail::vector_base.2" %4, !dbg !3199
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE(ptr nonnull align 32 dereferenceable(64) %this, ptr nonnull align 32 dereferenceable(64) %v) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3200 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3202, metadata !DIExpression()), !dbg !3204
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3203, metadata !DIExpression()), !dbg !3205
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %v.addr, align 4, !dbg !3206, !tbaa !1545
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %this1, ptr align 32 %0, i32 64, i1 false), !dbg !3207, !tbaa !3196, !tbaa.struct !3197
  ret void, !dbg !3208
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3209 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3211, metadata !DIExpression()), !dbg !3213
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::vector_base.2", ptr %this1, i32 0, i32 0, !dbg !3214
  %call = call addrspace(1) %struct.v16float @_ZN3aie6detail14vector_storageIfLj16EE5undefEv() #24, !dbg !3215
  %0 = getelementptr inbounds %struct.v16float, ptr %data, i32 0, i32 0, !dbg !3215
  %1 = extractvalue %struct.v16float %call, 0, !dbg !3215
  store %struct.ipd.custom_type.v128int4.v128int4 %1, ptr %0, align 32, !dbg !3215
  ret void, !dbg !3216
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj(ptr nonnull align 32 dereferenceable(32) %v, i32 noundef %idx) addrspace(1) #9 comdat align 2 !dbg !3217 {
entry:
  %retval = alloca %struct.v16float, align 32
  %v.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3232, metadata !DIExpression()), !dbg !3234
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3233, metadata !DIExpression()), !dbg !3235
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3236, !tbaa !1780
  %1 = load ptr, ptr %v.addr, align 4, !dbg !3237, !tbaa !1545
  %2 = load %struct.v8float, ptr %1, align 32, !dbg !3238, !tbaa !2248
  %call = call addrspace(1) %struct.v16float @_Z12set_v16floati7v8float(i32 %0, %struct.v8float %2) #24, !dbg !3238
  %3 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0, !dbg !3238
  %4 = extractvalue %struct.v16float %call, 0, !dbg !3238
  store %struct.ipd.custom_type.v128int4.v128int4 %4, ptr %3, align 32, !dbg !3238
  %5 = load %struct.v16float, ptr %retval, align 32, !dbg !3239
  ret %struct.v16float %5, !dbg !3239
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16float %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3240 {
entry:
  %data = alloca %struct.v16float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16float %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3242, metadata !DIExpression()), !dbg !3244
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !3243, metadata !DIExpression()), !dbg !3245
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::vector_base.2", ptr %this1, i32 0, i32 0, !dbg !3246
  %0 = load %struct.v16float, ptr %data, align 32, !dbg !3247, !tbaa !2155
  store %struct.v16float %0, ptr %data2, align 32, !dbg !3247, !tbaa !2155
  ret void, !dbg !3248
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z12set_v16floati7v8float(i32 %idx, %struct.v8float %b.coerce) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %b = alloca %struct.v8float, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v8float %b.coerce, ptr %b, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1780
  %rem = srem i32 %0, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.v8float, ptr %b, align 32, !tbaa !2248
  %call = call addrspace(1) %struct.v16float @_ZN12me_primitive6set_xlE7v8float(%struct.v8float %1) #26
  %2 = getelementptr inbounds %struct.v16float, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v16float %call, 0
  store %struct.ipd.custom_type.v128int4.v128int4 %3, ptr %2, align 32
  br label %return

if.else:                                          ; preds = %entry
  %4 = load %struct.v8float, ptr %b, align 32, !tbaa !2248
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
  %0 = load %struct.v8float, ptr %a0, align 32, !tbaa !2248
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
  %0 = load %struct.v8float, ptr %a0, align 32, !tbaa !2248
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
define linkonce_odr dso_local noundef i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv(ptr nonnull align 1 dereferenceable(1) %this) addrspace(1) #9 comdat align 2 !dbg !3249 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3251, metadata !DIExpression()), !dbg !3252
  %this1 = load ptr, ptr %this.addr, align 4
  ret i32 0, !dbg !3253
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::accum.3" @_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !3254 {
entry:
  %this.addr = alloca ptr, align 4
  %custom_type.tmp = alloca %"class.aie::accum.3", align 32
  %ref.tmp = alloca %"class.aie::detail::accum_base.4", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3259, metadata !DIExpression()), !dbg !3260
  %this1 = load ptr, ptr %this.addr, align 4
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3261
  %call = call addrspace(1) %"class.aie::detail::accum_base.4" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv(ptr nonnull align 32 dereferenceable(32) %this1) #24, !dbg !3262
  %0 = getelementptr inbounds %"class.aie::detail::accum_base.4", ptr %ref.tmp, i32 0, i32 0, !dbg !3262
  %1 = extractvalue %"class.aie::detail::accum_base.4" %call, 0, !dbg !3262
  store %struct.v16accfloat %1, ptr %0, align 32, !dbg !3262
  call addrspace(1) void @_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp, ptr nonnull align 32 dereferenceable(64) %ref.tmp) #24, !dbg !3263
  %2 = load %"class.aie::accum.3", ptr %custom_type.tmp, align 32, !dbg !3263, !tbaa !2308
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3264
  ret %"class.aie::accum.3" %2, !dbg !3263
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::accum_base.4" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !3265 {
entry:
  %retval = alloca %"class.aie::detail::accum_base.4", align 32
  %this.addr = alloca ptr, align 4
  %in_num_subaccums = alloca i32, align 4
  %out_num_subaccums = alloca i32, align 4
  %growth_ratio = alloca i32, align 4
  %ref.tmp = alloca %"class.aie::detail::accum_base.4", align 32
  %agg.tmp = alloca %struct.v16accfloat, align 32
  %agg.tmp2 = alloca %struct.v8accfloat, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3270, metadata !DIExpression()), !dbg !3276
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %in_num_subaccums, align 4, !dbg !3277
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %in_num_subaccums) #22, !dbg !3277
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in_num_subaccums, metadata !3272, metadata !DIExpression()), !dbg !3278
  store i32 1, ptr %in_num_subaccums, align 4, !dbg !3278, !tbaa !1780
  store i32 undef, ptr %out_num_subaccums, align 4, !dbg !3279
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %out_num_subaccums) #22, !dbg !3279
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out_num_subaccums, metadata !3273, metadata !DIExpression()), !dbg !3280
  store i32 1, ptr %out_num_subaccums, align 4, !dbg !3280, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3274, metadata !DIExpression()), !dbg !3281
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %retval) #24, !dbg !3281
  store i32 undef, ptr %growth_ratio, align 4, !dbg !3282
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %growth_ratio) #22, !dbg !3282
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %growth_ratio, metadata !3275, metadata !DIExpression()), !dbg !3283
  store i32 2, ptr %growth_ratio, align 4, !dbg !3283, !tbaa !1780
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3284
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !3289
  %call = call addrspace(1) %struct.v8accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv() #24, !dbg !3290
  %0 = getelementptr inbounds %struct.v8accfloat, ptr %agg.tmp2, i32 0, i32 0, !dbg !3290
  %1 = extractvalue %struct.v8accfloat %call, 0, !dbg !3290
  store %struct.ipd.custom_type.v8acc32.v8acc32 %1, ptr %0, align 32, !dbg !3290
  %2 = load %struct.v8accfloat, ptr %data, align 32, !dbg !3284, !tbaa !3291
  %3 = load %struct.v8accfloat, ptr %agg.tmp2, align 32, !dbg !3284, !tbaa !2405
  %call3 = call addrspace(1) %struct.v16accfloat @_Z6concat10v8accfloatS_(%struct.v8accfloat %2, %struct.v8accfloat %3) #24, !dbg !3284
  %4 = getelementptr inbounds %struct.v16accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !3284
  %5 = extractvalue %struct.v16accfloat %call3, 0, !dbg !3284
  store %struct.ipd.custom_type.v16acc32.v16acc32 %5, ptr %4, align 32, !dbg !3284
  %6 = load %struct.v16accfloat, ptr %agg.tmp, align 32, !dbg !3284, !tbaa !2306
  call addrspace(1) void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %ref.tmp, %struct.v16accfloat %6) #24, !dbg !3284
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %retval, ptr align 32 %ref.tmp, i32 64, i1 false), !dbg !3292, !tbaa !3293, !tbaa.struct !3197
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3294
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %growth_ratio) #22, !dbg !3295
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %out_num_subaccums) #22, !dbg !3295
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %in_num_subaccums) #22, !dbg !3295
  %7 = load %"class.aie::detail::accum_base.4", ptr %retval, align 32, !dbg !3295
  ret %"class.aie::detail::accum_base.4" %7, !dbg !3295
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE(ptr nonnull align 32 dereferenceable(64) %this, ptr nonnull align 32 dereferenceable(64) %a) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3296 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3298, metadata !DIExpression()), !dbg !3300
  store ptr %a, ptr %a.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3299, metadata !DIExpression()), !dbg !3301
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %a.addr, align 4, !dbg !3302, !tbaa !1545
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 32 %this1, ptr align 32 %0, i32 64, i1 false), !dbg !3303, !tbaa !3293, !tbaa.struct !3197
  ret void, !dbg !3304
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %this) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3305 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3307, metadata !DIExpression()), !dbg !3309
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base.4", ptr %this1, i32 0, i32 0, !dbg !3310
  %call = call addrspace(1) %struct.v16accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv() #24, !dbg !3311
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %data, i32 0, i32 0, !dbg !3311
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !3311
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !3311
  ret void, !dbg !3312
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_Z6concat10v8accfloatS_(%struct.v8accfloat %a0.coerce, %struct.v8accfloat %a1.coerce) addrspace(1) #6 comdat {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %a0 = alloca %struct.v8accfloat, align 32
  %a1 = alloca %struct.v8accfloat, align 32
  store %struct.v8accfloat %a0.coerce, ptr %a0, align 32
  store %struct.v8accfloat %a1.coerce, ptr %a1, align 32
  %0 = load %struct.v8accfloat, ptr %a0, align 32, !tbaa !2405
  %1 = load %struct.v8accfloat, ptr %a1, align 32, !tbaa !2405
  %call = call addrspace(1) %struct.v16accfloat @_ZN12me_primitive12concat_bm_amE10v8accfloatS0_(%struct.v8accfloat %0, %struct.v8accfloat %1) #26
  %2 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0
  %3 = extractvalue %struct.v16accfloat %call, 0
  store %struct.ipd.custom_type.v16acc32.v16acc32 %3, ptr %2, align 32
  %4 = load %struct.v16accfloat, ptr %retval, align 32
  ret %struct.v16accfloat %4
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat(ptr nonnull align 32 dereferenceable(64) %this, %struct.v16accfloat %data.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3313 {
entry:
  %data = alloca %struct.v16accfloat, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v16accfloat %data.coerce, ptr %data, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3315, metadata !DIExpression()), !dbg !3317
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %data, metadata !3316, metadata !DIExpression()), !dbg !3318
  %this1 = load ptr, ptr %this.addr, align 4
  %data2 = getelementptr inbounds %"class.aie::detail::accum_base.4", ptr %this1, i32 0, i32 0, !dbg !3319
  %0 = load %struct.v16accfloat, ptr %data, align 32, !dbg !3320, !tbaa !2306
  store %struct.v16accfloat %0, ptr %data2, align 32, !dbg !3320, !tbaa !2306
  ret void, !dbg !3321
}

; Function Attrs: mustprogress nounwind
define linkonce_odr dso_local %struct.v16accfloat @_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv() addrspace(1) #9 comdat align 2 !dbg !3322 {
entry:
  %retval = alloca %struct.v16accfloat, align 32
  %call = call addrspace(1) %struct.v16accfloat @_Z17undef_v16accfloatv() #24, !dbg !3323
  %0 = getelementptr inbounds %struct.v16accfloat, ptr %retval, i32 0, i32 0, !dbg !3323
  %1 = extractvalue %struct.v16accfloat %call, 0, !dbg !3323
  store %struct.ipd.custom_type.v16acc32.v16acc32 %1, ptr %0, align 32, !dbg !3323
  %2 = load %struct.v16accfloat, ptr %retval, align 32, !dbg !3324
  ret %struct.v16accfloat %2, !dbg !3324
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
  %0 = load %struct.v8accfloat, ptr %a0, align 32, !tbaa !2405
  %1 = load %struct.v8accfloat, ptr %a1, align 32, !tbaa !2405
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
define linkonce_odr dso_local %"class.aie::vector" @_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a) addrspace(1) #6 comdat align 2 !dbg !3325 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %a.addr = alloca ptr, align 4
  %native_broadcast_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %"class.aie::vector.1", align 32
  %agg.tmp = alloca %"class.aie::vector", align 32
  store ptr %a, ptr %a.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3333, metadata !DIExpression()), !dbg !3336
  store i32 undef, ptr %native_broadcast_elems, align 4, !dbg !3337
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_broadcast_elems) #22, !dbg !3337
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_broadcast_elems, metadata !3334, metadata !DIExpression()), !dbg !3338
  store i32 16, ptr %native_broadcast_elems, align 4, !dbg !3338, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3335, metadata !DIExpression()), !dbg !3339
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !3339
  %0 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !3339, !tbaa !1730
  store %"class.aie::vector" %0, ptr %retval, align 32, !dbg !3339, !tbaa !1730
  call addrspace(1) void @llvm.lifetime.start.p0(i64 64, ptr %ref.tmp) #22, !dbg !3340
  %1 = load ptr, ptr %a.addr, align 4, !dbg !3343, !tbaa !1545
  %call = call addrspace(1) %"class.aie::vector.1" @_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf(ptr nonnull align 4 dereferenceable(4) %1) #24, !dbg !3340
  %2 = getelementptr inbounds %"class.aie::vector.1", ptr %ref.tmp, i32 0, i32 0, !dbg !3340
  %3 = extractvalue %"class.aie::vector.1" %call, 0, !dbg !3340
  store %"class.aie::detail::vector_base.2" %3, ptr %2, align 32, !dbg !3340
  %call1 = call addrspace(1) %"class.aie::vector" @_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj(ptr nonnull align 32 dereferenceable(64) %ref.tmp, i32 0) #24, !dbg !3344
  %4 = getelementptr inbounds %"class.aie::vector", ptr %agg.tmp, i32 0, i32 0, !dbg !3344
  %5 = extractvalue %"class.aie::vector" %call1, 0, !dbg !3344
  store %"class.aie::detail::vector_base" %5, ptr %4, align 32, !dbg !3344
  %6 = load %"class.aie::vector", ptr %agg.tmp, align 32, !dbg !3345, !tbaa !1730
  call addrspace(1) void @llvm.lifetime.end.p0(i64 64, ptr %ref.tmp) #22, !dbg !3346
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_broadcast_elems) #22, !dbg !3347
  ret %"class.aie::vector" %6, !dbg !3345
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector.1" @_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf(ptr nonnull align 4 dereferenceable(4) %a) addrspace(1) #6 comdat align 2 !dbg !3348 {
entry:
  %retval = alloca %"class.aie::vector.1", align 32
  %a.addr = alloca ptr, align 4
  %native_broadcast_elems = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector.1", align 32
  %tmp = alloca %"class.aie::vector.1", align 32
  %agg.tmp = alloca %struct.v16float, align 32
  store ptr %a, ptr %a.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !3356, metadata !DIExpression()), !dbg !3359
  store i32 undef, ptr %native_broadcast_elems, align 4, !dbg !3360
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_broadcast_elems) #22, !dbg !3360
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_broadcast_elems, metadata !3357, metadata !DIExpression()), !dbg !3361
  store i32 16, ptr %native_broadcast_elems, align 4, !dbg !3361, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3358, metadata !DIExpression()), !dbg !3362
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2Ev(ptr nonnull align 32 dereferenceable(64) %custom_type.tmp) #24, !dbg !3362
  %0 = load %"class.aie::vector.1", ptr %custom_type.tmp, align 32, !dbg !3362, !tbaa !2144
  store %"class.aie::vector.1" %0, ptr %retval, align 32, !dbg !3362, !tbaa !2144
  %1 = load ptr, ptr %a.addr, align 4, !dbg !3363, !tbaa !1545
  %2 = load float, ptr %1, align 4, !dbg !3363, !tbaa !2767
  %call = call addrspace(1) %struct.v16float @_Z21broadcast_to_v16floatf(float %2) #26, !dbg !3370
  %3 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !3370
  %4 = extractvalue %struct.v16float %call, 0, !dbg !3370
  store %struct.ipd.custom_type.v128int4.v128int4 %4, ptr %3, align 32, !dbg !3370
  %5 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !3370, !tbaa !2155
  call addrspace(1) void @_ZN3aie6vectorIfLj16EEC2E8v16float(ptr nonnull align 32 dereferenceable(64) %tmp, %struct.v16float %5) #24, !dbg !3370
  %6 = load %"class.aie::vector.1", ptr %tmp, align 32, !dbg !3371, !tbaa !2144
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_broadcast_elems) #22, !dbg !3372
  ret %"class.aie::vector.1" %6, !dbg !3371
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v16float @_Z21broadcast_to_v16floatf(float %a0) addrspace(1) #15 comdat {
entry:
  %retval = alloca %struct.v16float, align 32
  %a0.addr = alloca float, align 4
  store float %a0, ptr %a0.addr, align 4, !tbaa !2767
  %0 = load float, ptr %a0.addr, align 4, !tbaa !2767
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
define linkonce_odr dso_local noundef float @_ZNK3aie21vector_elem_const_refIfLj8EE3getEv(ptr nonnull align 4 dereferenceable(8) %this) addrspace(1) #9 comdat align 2 !dbg !3373 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3375, metadata !DIExpression()), !dbg !3376
  %this1 = load ptr, ptr %this.addr, align 4
  %parent = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 0, !dbg !3377
  %0 = load ptr, ptr %parent, align 4, !dbg !3377, !tbaa !3378
  %offset = getelementptr inbounds %"class.aie::vector_elem_const_ref", ptr %this1, i32 0, i32 1, !dbg !3379
  %1 = load i32, ptr %offset, align 4, !dbg !3379, !tbaa !2706
  %call = call addrspace(1) float @_ZNK3aie6vectorIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %0, i32 %1) #24, !dbg !3380
  ret float %call, !dbg !3381
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_ZNK3aie6vectorIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3382 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3384, metadata !DIExpression()), !dbg !3386
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3385, metadata !DIExpression()), !dbg !3387
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3388, !tbaa !1780
  %call = call addrspace(1) float @_ZNK3aie6detail11vector_baseIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0) #24, !dbg !3389
  ret float %call, !dbg !3390
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_ZNK3aie6detail11vector_baseIfLj8EE3getEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3391 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %agg.tmp = alloca %struct.v16float, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3393, metadata !DIExpression()), !dbg !3395
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3394, metadata !DIExpression()), !dbg !3396
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !3397

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3398, !tbaa !1780
  %cmp = icmp ult i32 %0, 8, !dbg !3398
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !3398
  br i1 %1, label %if.then, label %if.else, !dbg !3401

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !3402

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !3404, !tbaa !1780
  %cmp3 = icmp ult i32 %2, 8, !dbg !3404
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !3404
  br i1 %3, label %if.end, label %if.then4, !dbg !3407

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !1966), !dbg !3404
  br label %if.end, !dbg !3404

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !3407

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !3402

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3408, !tbaa !1780
  %cmp5 = icmp ult i32 %4, 8, !dbg !3408
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !3408
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !3401

do.end7:                                          ; preds = %if.end6
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !3410
  %call = call addrspace(1) %struct.v16float @_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj(ptr nonnull align 32 dereferenceable(32) %data, i32 noundef 0) #24, !dbg !3416
  %5 = getelementptr inbounds %struct.v16float, ptr %agg.tmp, i32 0, i32 0, !dbg !3416
  %6 = extractvalue %struct.v16float %call, 0, !dbg !3416
  store %struct.ipd.custom_type.v128int4.v128int4 %6, ptr %5, align 32, !dbg !3416
  %7 = load i32, ptr %idx.addr, align 4, !dbg !3417, !tbaa !1780
  %8 = load %struct.v16float, ptr %agg.tmp, align 32, !dbg !3418, !tbaa !2155
  %call8 = call addrspace(1) float @_Z12extract_elem8v16floati(%struct.v16float %8, i32 %7) #24, !dbg !3418
  ret float %call8, !dbg !3419
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local float @_Z12extract_elem8v16floati(%struct.v16float %v.coerce, i32 %idx) addrspace(1) #6 comdat {
entry:
  %v = alloca %struct.v16float, align 32
  %idx.addr = alloca i32, align 4
  store %struct.v16float %v.coerce, ptr %v, align 32
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !1780
  %cmp = icmp slt i32 %0, 0
  br i1 %cmp, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  %1 = load i32, ptr %idx.addr, align 4, !tbaa !1780
  %cmp1 = icmp sge i32 %1, 64
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %entry
  %2 = phi i1 [ true, %entry ], [ %cmp1, %lor.rhs ]
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %2)
  br i1 %3, label %if.then, label %if.else

if.then:                                          ; preds = %lor.end
  call addrspace(1) void @llvm.chess_error(metadata !3420)
  br label %if.end

if.else:                                          ; preds = %lor.end
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %4 = load i32, ptr %idx.addr, align 4, !tbaa !1780
  %5 = load %struct.v16float, ptr %v, align 32, !tbaa !2155
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
  store i32 %a1, ptr %a1.addr, align 4, !tbaa !1780
  store i32 %a2, ptr %a2.addr, align 4, !tbaa !1780
  %0 = load i32, ptr %a1.addr, align 4, !tbaa !1780
  %1 = load i32, ptr %a2.addr, align 4, !tbaa !1780
  %2 = load %struct.v16float, ptr %a0, align 32, !tbaa !2155
  %call = call x86_regcallcc addrspace(1) float @__regcall3__chessintr___ffloat_ext_elem__v16float___sint___sint(%struct.v16float %2, i32 signext %0, i32 signext %1) #25
  ret float %call
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc float @__regcall3__chessintr___ffloat_ext_elem__v16float___sint___sint(%struct.v16float, i32 signext, i32 signext) addrspace(1) #14

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::vector" noundef %.coerce) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !3421 {
entry:
  %0 = alloca %"class.aie::vector", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector" %.coerce, ptr %0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3427, metadata !DIExpression()), !dbg !3430
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %0, metadata !3429, metadata !DIExpression()), !dbg !3430
  %this1 = load ptr, ptr %this.addr, align 4
  %1 = load %"class.aie::vector", ptr %0, align 32, !dbg !3431, !tbaa !1730
  call addrspace(1) void @_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 32 dereferenceable(32) %this1, %"class.aie::vector" %1) #24, !dbg !3431
  ret void, !dbg !3431
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::vector" %parent.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3432 {
entry:
  %parent = alloca %"class.aie::vector", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector" %parent.coerce, ptr %parent, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3434, metadata !DIExpression()), !dbg !3437
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %parent, metadata !3436, metadata !DIExpression()), !dbg !3438
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.8", ptr %this1, i32 0, i32 0, !dbg !3439
  %0 = load %"class.aie::vector", ptr %parent, align 32, !dbg !3440, !tbaa !1730
  store %"class.aie::vector" %0, ptr %parent_, align 32, !dbg !3440, !tbaa !1730
  ret void, !dbg !3441
}

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_(ptr nonnull align 4 dereferenceable(8) %this, %"class.aie::vector_elem_ref" noundef %.coerce) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !3442 {
entry:
  %0 = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector_elem_ref" %.coerce, ptr %0, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3448, metadata !DIExpression()), !dbg !3451
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %0, metadata !3450, metadata !DIExpression()), !dbg !3451
  %this1 = load ptr, ptr %this.addr, align 4
  %1 = load %"class.aie::vector_elem_ref", ptr %0, align 4, !dbg !3452, !tbaa !1840
  call addrspace(1) void @_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 4 dereferenceable(8) %this1, %"class.aie::vector_elem_ref" %1) #24, !dbg !3452
  ret void, !dbg !3452
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_(ptr nonnull align 4 dereferenceable(8) %this, %"class.aie::vector_elem_ref" %parent.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3453 {
entry:
  %parent = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  store %"class.aie::vector_elem_ref" %parent.coerce, ptr %parent, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3455, metadata !DIExpression()), !dbg !3458
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %parent, metadata !3457, metadata !DIExpression()), !dbg !3459
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common.6", ptr %this1, i32 0, i32 0, !dbg !3460
  %0 = load %"class.aie::vector_elem_ref", ptr %parent, align 4, !dbg !3460, !tbaa !1840
  store %"class.aie::vector_elem_ref" %0, ptr %parent_, align 4, !dbg !3460, !tbaa !1840
  ret void, !dbg !3461
}

; Function Attrs: inlinehint nounwind
define linkonce_odr dso_local void @_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::accum" noundef %.coerce) unnamed_addr addrspace(1) #4 comdat align 2 !dbg !3462 {
entry:
  %0 = alloca %"class.aie::accum", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::accum" %.coerce, ptr %0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3468, metadata !DIExpression()), !dbg !3471
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %0, metadata !3470, metadata !DIExpression()), !dbg !3471
  %this1 = load ptr, ptr %this.addr, align 4
  %1 = load %"class.aie::accum", ptr %0, align 32, !dbg !3472, !tbaa !1744
  call addrspace(1) void @_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_(ptr nonnull align 32 dereferenceable(32) %this1, %"class.aie::accum" %1) #24, !dbg !3472
  ret void, !dbg !3472
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_(ptr nonnull align 32 dereferenceable(32) %this, %"class.aie::accum" %parent.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3473 {
entry:
  %parent = alloca %"class.aie::accum", align 32
  %this.addr = alloca ptr, align 4
  store %"class.aie::accum" %parent.coerce, ptr %parent, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3475, metadata !DIExpression()), !dbg !3478
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %parent, metadata !3477, metadata !DIExpression()), !dbg !3479
  %this1 = load ptr, ptr %this.addr, align 4
  %parent_ = getelementptr inbounds %"struct.aie::unary_op_common", ptr %this1, i32 0, i32 0, !dbg !3480
  %0 = load %"class.aie::accum", ptr %parent, align 32, !dbg !3481, !tbaa !1744
  store %"class.aie::accum" %0, ptr %parent_, align 32, !dbg !3481, !tbaa !1744
  ret void, !dbg !3482
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector_elem_ref" @_ZN3aie6vectorIfLj8EE8elem_refEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3483 {
entry:
  %retval = alloca %"class.aie::vector_elem_ref", align 4
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3485, metadata !DIExpression()), !dbg !3487
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3486, metadata !DIExpression()), !dbg !3488
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !3489

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3490, !tbaa !1780
  %cmp = icmp ult i32 %0, 8, !dbg !3490
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !3490
  br i1 %1, label %if.then, label %if.else, !dbg !3493

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !3494

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !3496, !tbaa !1780
  %cmp3 = icmp ult i32 %2, 8, !dbg !3496
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !3496
  br i1 %3, label %if.end, label %if.then4, !dbg !3499

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !1966), !dbg !3496
  br label %if.end, !dbg !3496

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !3499

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !3494

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3500, !tbaa !1780
  %cmp5 = icmp ult i32 %4, 8, !dbg !3500
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !3500
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !3493

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !3502, !tbaa !1780
  call addrspace(1) void @_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj(ptr nonnull align 4 dereferenceable(8) %retval, ptr nonnull align 32 dereferenceable(32) %this1, i32 noundef %5) #24, !dbg !3503
  %6 = load %"class.aie::vector_elem_ref", ptr %retval, align 4, !dbg !3504
  ret %"class.aie::vector_elem_ref" %6, !dbg !3504
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj(ptr nonnull align 4 dereferenceable(8) %this, ptr nonnull align 32 dereferenceable(32) %v, i32 noundef %idx) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !3505 {
entry:
  %this.addr = alloca ptr, align 4
  %v.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3507, metadata !DIExpression()), !dbg !3511
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3509, metadata !DIExpression()), !dbg !3512
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3510, metadata !DIExpression()), !dbg !3513
  %this1 = load ptr, ptr %this.addr, align 4
  %parent = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %this1, i32 0, i32 0, !dbg !3514
  %0 = load ptr, ptr %v.addr, align 4, !dbg !3515, !tbaa !1545
  store ptr %0, ptr %parent, align 4, !dbg !3514, !tbaa !1545
  %offset = getelementptr inbounds %"class.aie::vector_elem_ref", ptr %this1, i32 0, i32 1, !dbg !3516
  %1 = load i32, ptr %idx.addr, align 4, !dbg !3517, !tbaa !1780
  store i32 %1, ptr %offset, align 4, !dbg !3516, !tbaa !2705
  ret void, !dbg !3518
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi(ptr nonnull align 32 dereferenceable(32) %this, i32 %shift) addrspace(1) #6 comdat align 2 !dbg !3519 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %this.addr = alloca ptr, align 4
  %shift.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3524, metadata !DIExpression()), !dbg !3526
  store i32 %shift, ptr %shift.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %shift.addr, metadata !3525, metadata !DIExpression()), !dbg !3527
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %shift.addr, align 4, !dbg !3528, !tbaa !1780
  %call = call addrspace(1) %"class.aie::vector" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbi(ptr nonnull align 32 dereferenceable(32) %this1, i1 zeroext true, i32 %0) #24, !dbg !3529
  %1 = getelementptr inbounds %"class.aie::vector", ptr %retval, i32 0, i32 0, !dbg !3529
  %2 = extractvalue %"class.aie::vector" %call, 0, !dbg !3529
  store %"class.aie::detail::vector_base" %2, ptr %1, align 32, !dbg !3529
  %3 = load %"class.aie::vector", ptr %retval, align 32, !dbg !3530
  ret %"class.aie::vector" %3, !dbg !3530
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::vector" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbi(ptr nonnull align 32 dereferenceable(32) %this, i1 zeroext %v_sign, i32 %shift) addrspace(1) #6 comdat align 2 !dbg !3531 {
entry:
  %retval = alloca %"class.aie::vector", align 32
  %this.addr = alloca ptr, align 4
  %v_sign.addr = alloca i8, align 1
  %shift.addr = alloca i32, align 4
  %fn = alloca %class.anon.10, align 1
  %native_vector_elems = alloca i32, align 4
  %max_elems_per_srs = alloca i32, align 4
  %native_elems = alloca i32, align 4
  %elems_per_srs = alloca i32, align 4
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  %ref.tmp = alloca %class.anon.12, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3536, metadata !DIExpression()), !dbg !3549
  %frombool = zext i1 %v_sign to i8
  store i8 %frombool, ptr %v_sign.addr, align 1, !tbaa !2429
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v_sign.addr, metadata !3537, metadata !DIExpression()), !dbg !3550
  store i32 %shift, ptr %shift.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %shift.addr, metadata !3538, metadata !DIExpression()), !dbg !3551
  %this1 = load ptr, ptr %this.addr, align 4
  store %class.anon.10 undef, ptr %fn, align 1, !dbg !3552
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %fn) #22, !dbg !3552
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn, metadata !3539, metadata !DIExpression()), !dbg !3553
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 1 %fn, ptr align 1 @__const._ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbi.fn, i32 1, i1 false), !dbg !3553
  store i32 undef, ptr %native_vector_elems, align 4, !dbg !3554
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_vector_elems) #22, !dbg !3554
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_vector_elems, metadata !3544, metadata !DIExpression()), !dbg !3555
  store i32 16, ptr %native_vector_elems, align 4, !dbg !3555, !tbaa !1780
  store i32 undef, ptr %max_elems_per_srs, align 4, !dbg !3556
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %max_elems_per_srs) #22, !dbg !3556
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %max_elems_per_srs, metadata !3545, metadata !DIExpression()), !dbg !3557
  store i32 32, ptr %max_elems_per_srs, align 4, !dbg !3557, !tbaa !1780
  store i32 undef, ptr %native_elems, align 4, !dbg !3558
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %native_elems) #22, !dbg !3558
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %native_elems, metadata !3546, metadata !DIExpression()), !dbg !3559
  store i32 16, ptr %native_elems, align 4, !dbg !3559, !tbaa !1780
  store i32 undef, ptr %elems_per_srs, align 4, !dbg !3560
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %elems_per_srs) #22, !dbg !3560
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %elems_per_srs, metadata !3547, metadata !DIExpression()), !dbg !3561
  store i32 8, ptr %elems_per_srs, align 4, !dbg !3561, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %retval, metadata !3548, metadata !DIExpression()), !dbg !3562
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2Ev(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp) #24, !dbg !3562
  %0 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !3562, !tbaa !1730
  store %"class.aie::vector" %0, ptr %retval, align 32, !dbg !3562, !tbaa !1730
  call addrspace(1) void @llvm.lifetime.start.p0(i64 20, ptr %ref.tmp) #22, !dbg !3563
  %1 = getelementptr inbounds %class.anon.12, ptr %ref.tmp, i32 0, i32 0, !dbg !3563
  store ptr %retval, ptr %1, align 4, !dbg !3563, !tbaa !1545
  %2 = getelementptr inbounds %class.anon.12, ptr %ref.tmp, i32 0, i32 1, !dbg !3563
  store ptr %this1, ptr %2, align 4, !dbg !3563, !tbaa !3564
  %3 = getelementptr inbounds %class.anon.12, ptr %ref.tmp, i32 0, i32 2, !dbg !3563
  store ptr %shift.addr, ptr %3, align 4, !dbg !3563, !tbaa !1545
  %4 = getelementptr inbounds %class.anon.12, ptr %ref.tmp, i32 0, i32 3, !dbg !3563
  store ptr %v_sign.addr, ptr %4, align 4, !dbg !3563, !tbaa !1545
  %5 = getelementptr inbounds %class.anon.12, ptr %ref.tmp, i32 0, i32 4, !dbg !3563
  store ptr %fn, ptr %5, align 4, !dbg !3563, !tbaa !1545
  call addrspace(1) void @_ZN3aie6detail5utils12unroll_timesILj1EZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOT0_(ptr nonnull align 4 dereferenceable(20) %ref.tmp) #24, !dbg !3566
  call addrspace(1) void @llvm.lifetime.end.p0(i64 20, ptr %ref.tmp) #22, !dbg !3566
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %elems_per_srs) #22, !dbg !3567
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_elems) #22, !dbg !3567
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %max_elems_per_srs) #22, !dbg !3567
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %native_vector_elems) #22, !dbg !3567
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %fn) #22, !dbg !3567
  %6 = load %"class.aie::vector", ptr %retval, align 32, !dbg !3568
  ret %"class.aie::vector" %6, !dbg !3568
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils12unroll_timesILj1EZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOT0_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat !dbg !3569 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !3584, metadata !DIExpression()), !dbg !3587
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !3588, !tbaa !1545
  call addrspace(1) void @_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOT3_(ptr nonnull align 4 dereferenceable(20) %0) #24, !dbg !3589
  ret void, !dbg !3590
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOT3_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat !dbg !3591 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !3593, metadata !DIExpression()), !dbg !3595
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !3596, !tbaa !1545
  call addrspace(1) void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_(ptr nonnull align 4 dereferenceable(20) %0) #24, !dbg !3597
  ret void, !dbg !3598
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat align 2 !dbg !3599 {
entry:
  %fn.addr = alloca ptr, align 4
  %it = alloca %"struct.aie::detail::utils::iteration_dim", align 1
  %next_it = alloca i32, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !3603, metadata !DIExpression()), !dbg !3608
  store %"struct.aie::detail::utils::iteration_dim" undef, ptr %it, align 1, !dbg !3609
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %it) #22, !dbg !3609
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %it, metadata !3604, metadata !DIExpression()), !dbg !3610
  call addrspace(1) void @llvm.memcpy.p0.p0.i32(ptr align 1 %it, ptr align 1 @__const._ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_.it, i32 1, i1 false), !dbg !3610
  %0 = load ptr, ptr %fn.addr, align 4, !dbg !3611, !tbaa !1545
  %call = call noundef addrspace(1) i32 @_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv(ptr nonnull align 1 dereferenceable(1) %it) #24, !dbg !3613
  call addrspace(1) void @_ZZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiENKUljE_clEj(ptr nonnull align 4 dereferenceable(20) %0, i32 %call) #24, !dbg !3611
  store i32 undef, ptr %next_it, align 4, !dbg !3614
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %next_it) #22, !dbg !3614
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %next_it, metadata !3607, metadata !DIExpression()), !dbg !3615
  store i32 1, ptr %next_it, align 4, !dbg !3615, !tbaa !1780
  %1 = load ptr, ptr %fn.addr, align 4, !dbg !3616, !tbaa !1545
  call addrspace(1) void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_(ptr nonnull align 4 dereferenceable(20) %1) #24, !dbg !3617
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %next_it) #22, !dbg !3618
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %it) #22, !dbg !3618
  ret void, !dbg !3619
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiENKUljE_clEj(ptr nonnull align 4 dereferenceable(20) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3620 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %agg.tmp = alloca %struct.v8float, align 32
  %ref.tmp = alloca %"class.aie::detail::accum_base", align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3627, metadata !DIExpression()), !dbg !3630
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3629, metadata !DIExpression()), !dbg !3631
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = getelementptr inbounds %class.anon.12, ptr %this1, i32 0, i32 1
  %1 = load ptr, ptr %0, align 4, !tbaa !3564
  %2 = getelementptr inbounds %class.anon.12, ptr %this1, i32 0, i32 0, !dbg !3632
  %3 = load ptr, ptr %2, align 4, !dbg !3632, !tbaa !3633
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3634, !tbaa !1780
  %5 = getelementptr inbounds %class.anon.12, ptr %this1, i32 0, i32 4, !dbg !3635
  %6 = load ptr, ptr %5, align 4, !dbg !3635, !tbaa !3636
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %ref.tmp) #22, !dbg !3637
  %7 = load i32, ptr %idx.addr, align 4, !dbg !3638, !tbaa !1780
  %call = call addrspace(1) %"class.aie::detail::accum_base" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj(ptr nonnull align 32 dereferenceable(32) %1, i32 %7) #24, !dbg !3637
  %8 = getelementptr inbounds %"class.aie::detail::accum_base", ptr %ref.tmp, i32 0, i32 0, !dbg !3637
  %9 = extractvalue %"class.aie::detail::accum_base" %call, 0, !dbg !3637
  store %struct.v8accfloat %9, ptr %8, align 32, !dbg !3637
  %10 = getelementptr inbounds %class.anon.12, ptr %this1, i32 0, i32 2, !dbg !3639
  %11 = load ptr, ptr %10, align 4, !dbg !3639, !tbaa !3640
  %12 = load i32, ptr %11, align 4, !dbg !3639, !tbaa !1780
  %13 = getelementptr inbounds %class.anon.12, ptr %this1, i32 0, i32 3, !dbg !3641
  %14 = load ptr, ptr %13, align 4, !dbg !3641, !tbaa !3642
  %15 = load i8, ptr %14, align 1, !dbg !3641, !tbaa !2429, !range !2673, !noundef !137
  %tobool = trunc i8 %15 to i1, !dbg !3641
  %call2 = call addrspace(1) %struct.v8float @_ZZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_srsIfEEDavENKUlRKT_T0_T1_E_clIS3_ibEEDaS7_S8_S9_(ptr nonnull align 1 dereferenceable(1) %6, ptr nonnull align 32 dereferenceable(32) %ref.tmp, i32 %12, i1 zeroext %tobool) #24, !dbg !3635
  %16 = getelementptr inbounds %struct.v8float, ptr %agg.tmp, i32 0, i32 0, !dbg !3635
  %17 = extractvalue %struct.v8float %call2, 0, !dbg !3635
  store %struct.ipd.custom_type.v64int4.v64int4 %17, ptr %16, align 32, !dbg !3635
  %18 = load %struct.v8float, ptr %agg.tmp, align 32, !dbg !3643, !tbaa !2248
  %call3 = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie6vectorIfLj8EE6insertI7v8floatEERS1_jT_(ptr nonnull align 32 dereferenceable(32) %3, i32 %4, %struct.v8float %18) #24, !dbg !3643
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %ref.tmp) #22, !dbg !3632
  ret void, !dbg !3644
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_(ptr nonnull align 4 dereferenceable(20) %fn) addrspace(1) #6 comdat align 2 !dbg !3645 {
entry:
  %fn.addr = alloca ptr, align 4
  store ptr %fn, ptr %fn.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fn.addr, metadata !3648, metadata !DIExpression()), !dbg !3649
  ret void, !dbg !3650
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local nonnull align 32 dereferenceable(32) ptr @_ZN3aie6vectorIfLj8EE6insertI7v8floatEERS1_jT_(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, %struct.v8float %v.coerce) addrspace(1) #6 comdat align 2 !dbg !3651 {
entry:
  %v = alloca %struct.v8float, align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %ElemsIn = alloca i32, align 4
  %in = alloca %"class.aie::vector", align 32
  %custom_type.tmp = alloca %"class.aie::vector", align 32
  store %struct.v8float %v.coerce, ptr %v, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3658, metadata !DIExpression()), !dbg !3663
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3659, metadata !DIExpression()), !dbg !3664
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !3660, metadata !DIExpression()), !dbg !3665
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %ElemsIn, align 4, !dbg !3666
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %ElemsIn) #22, !dbg !3666
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ElemsIn, metadata !3661, metadata !DIExpression()), !dbg !3667
  store i32 8, ptr %ElemsIn, align 4, !dbg !3667, !tbaa !1780
  br label %do.body, !dbg !3668

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3669, !tbaa !1780
  %cmp = icmp ult i32 %0, 1, !dbg !3669
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !3669
  br i1 %1, label %if.then, label %if.else, !dbg !3672

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !3673

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !3675, !tbaa !1780
  %cmp3 = icmp ult i32 %2, 1, !dbg !3675
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !3675
  br i1 %3, label %if.end, label %if.then4, !dbg !3678

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !2211), !dbg !3675
  br label %if.end, !dbg !3675

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.cond, !dbg !3678

do.cond:                                          ; preds = %if.end
  br label %do.end, !dbg !3678

do.end:                                           ; preds = %do.cond
  br label %if.end6, !dbg !3673

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3679, !tbaa !1780
  %cmp5 = icmp ult i32 %4, 1, !dbg !3679
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !3679
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.cond7, !dbg !3672

do.cond7:                                         ; preds = %if.end6
  br label %do.end8, !dbg !3672

do.end8:                                          ; preds = %do.cond7
  store %"class.aie::vector" undef, ptr %in, align 32, !dbg !3681
  call addrspace(1) void @llvm.lifetime.start.p0(i64 32, ptr %in) #22, !dbg !3681
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in, metadata !3662, metadata !DIExpression()), !dbg !3682
  %5 = load %struct.v8float, ptr %v, align 32, !dbg !3683, !tbaa !2248
  call addrspace(1) void @_ZN3aie6vectorIfLj8EEC2E7v8float(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, %struct.v8float %5) #24, !dbg !3683
  %6 = load %"class.aie::vector", ptr %custom_type.tmp, align 32, !dbg !3683, !tbaa !1730
  store %"class.aie::vector" %6, ptr %in, align 32, !dbg !3683, !tbaa !1730
  %7 = load i32, ptr %idx.addr, align 4, !dbg !3684, !tbaa !1780
  %call = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie6vectorIfLj8EE6insertILj8EEERS1_jRKNS0_IfXT_EEE(ptr nonnull align 32 dereferenceable(32) %this1, i32 %7, ptr nonnull align 32 dereferenceable(32) %in) #24, !dbg !3685
  call addrspace(1) void @llvm.lifetime.end.p0(i64 32, ptr %in) #22, !dbg !3686
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %ElemsIn) #22, !dbg !3686
  ret ptr %call, !dbg !3687
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8float @_ZZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_srsIfEEDavENKUlRKT_T0_T1_E_clIS3_ibEEDaS7_S8_S9_(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 32 dereferenceable(32) %acc, i32 %shift_dummy, i1 zeroext %sign_dummy) addrspace(1) #6 comdat align 2 !dbg !3688 {
entry:
  %this.addr = alloca ptr, align 4
  %acc.addr = alloca ptr, align 4
  %shift_dummy.addr = alloca i32, align 4
  %sign_dummy.addr = alloca i8, align 1
  %custom_type.tmp = alloca %struct.v8float, align 32
  %agg.tmp = alloca %struct.v8accfloat, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3698, metadata !DIExpression()), !dbg !3703
  store ptr %acc, ptr %acc.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %acc.addr, metadata !3700, metadata !DIExpression()), !dbg !3704
  store i32 %shift_dummy, ptr %shift_dummy.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %shift_dummy.addr, metadata !3701, metadata !DIExpression()), !dbg !3705
  %frombool = zext i1 %sign_dummy to i8
  store i8 %frombool, ptr %sign_dummy.addr, align 1, !tbaa !2429
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %sign_dummy.addr, metadata !3702, metadata !DIExpression()), !dbg !3706
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load ptr, ptr %acc.addr, align 4, !dbg !3707, !tbaa !1545
  %call = call addrspace(1) %struct.v8accfloat @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEcv10v8accfloatEv(ptr nonnull align 32 dereferenceable(32) %0) #24, !dbg !3707
  %1 = getelementptr inbounds %struct.v8accfloat, ptr %agg.tmp, i32 0, i32 0, !dbg !3707
  %2 = extractvalue %struct.v8accfloat %call, 0, !dbg !3707
  store %struct.ipd.custom_type.v8acc32.v8acc32 %2, ptr %1, align 32, !dbg !3707
  %3 = load %struct.v8accfloat, ptr %agg.tmp, align 32, !dbg !3708, !tbaa !2405
  call addrspace(1) void @_ZN7v8floatC2E10v8accfloat(ptr nonnull align 32 dereferenceable(32) %custom_type.tmp, %struct.v8accfloat %3) #27, !dbg !3708
  %4 = load %struct.v8float, ptr %custom_type.tmp, align 32, !dbg !3708, !tbaa !2248
  ret %struct.v8float %4, !dbg !3708
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::accum_base" @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3709 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %fpacc_128b = alloca i8, align 1
  %num_subaccums = alloca i32, align 4
  %num_subaccums_out = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3714, metadata !DIExpression()), !dbg !3719
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3715, metadata !DIExpression()), !dbg !3720
  %this1 = load ptr, ptr %this.addr, align 4
  store i8 undef, ptr %fpacc_128b, align 1, !dbg !3721
  call addrspace(1) void @llvm.lifetime.start.p0(i64 1, ptr %fpacc_128b) #22, !dbg !3721
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %fpacc_128b, metadata !3716, metadata !DIExpression()), !dbg !3722
  store i8 0, ptr %fpacc_128b, align 1, !dbg !3722, !tbaa !2429
  store i32 undef, ptr %num_subaccums, align 4, !dbg !3723
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums) #22, !dbg !3723
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums, metadata !3717, metadata !DIExpression()), !dbg !3724
  store i32 1, ptr %num_subaccums, align 4, !dbg !3724, !tbaa !1780
  store i32 undef, ptr %num_subaccums_out, align 4, !dbg !3725
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %num_subaccums_out) #22, !dbg !3725
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %num_subaccums_out, metadata !3718, metadata !DIExpression()), !dbg !3726
  store i32 1, ptr %num_subaccums_out, align 4, !dbg !3726, !tbaa !1780
  %0 = load %"class.aie::detail::accum_base", ptr %this1, align 32, !dbg !3727, !tbaa !2454
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums_out) #22, !dbg !3730
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %num_subaccums) #22, !dbg !3730
  call addrspace(1) void @llvm.lifetime.end.p0(i64 1, ptr %fpacc_128b) #22, !dbg !3730
  ret %"class.aie::detail::accum_base" %0, !dbg !3727
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN3aie6vectorIfLj8EEC2E7v8float(ptr nonnull align 32 dereferenceable(32) %this, %struct.v8float %v.coerce) unnamed_addr addrspace(1) #11 comdat align 2 !dbg !3731 {
entry:
  %v = alloca %struct.v8float, align 32
  %this.addr = alloca ptr, align 4
  store %struct.v8float %v.coerce, ptr %v, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3733, metadata !DIExpression()), !dbg !3735
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v, metadata !3734, metadata !DIExpression()), !dbg !3736
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load %struct.v8float, ptr %v, align 32, !dbg !3737, !tbaa !2248
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float(ptr nonnull align 32 dereferenceable(32) %this1, %struct.v8float %0) #24, !dbg !3737
  ret void, !dbg !3738
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local nonnull align 32 dereferenceable(32) ptr @_ZN3aie6vectorIfLj8EE6insertILj8EEERS1_jRKNS0_IfXT_EEE(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat align 2 !dbg !3739 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %v.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3745, metadata !DIExpression()), !dbg !3748
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3746, metadata !DIExpression()), !dbg !3749
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3747, metadata !DIExpression()), !dbg !3750
  %this1 = load ptr, ptr %this.addr, align 4
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3751, !tbaa !1780
  %1 = load ptr, ptr %v.addr, align 4, !dbg !3752, !tbaa !1545
  %call = call nonnull align 32 dereferenceable(32) addrspace(1) ptr @_ZN3aie6detail11vector_baseIfLj8EE6insertILj8EEERS2_jRKNS1_IfXT_EEE(ptr nonnull align 32 dereferenceable(32) %this1, i32 %0, ptr nonnull align 32 dereferenceable(32) %1) #24, !dbg !3753
  ret ptr %this1, !dbg !3754
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local nonnull align 32 dereferenceable(32) ptr @_ZN3aie6detail11vector_baseIfLj8EE6insertILj8EEERS2_jRKNS1_IfXT_EEE(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat align 2 !dbg !3755 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %v.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3761, metadata !DIExpression()), !dbg !3764
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3762, metadata !DIExpression()), !dbg !3765
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3763, metadata !DIExpression()), !dbg !3766
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !3767

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3768, !tbaa !1780
  %cmp = icmp ult i32 %0, 1, !dbg !3768
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !3768
  br i1 %1, label %if.then, label %if.else, !dbg !3771

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !3772

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !3774, !tbaa !1780
  %cmp3 = icmp ult i32 %2, 1, !dbg !3774
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !3774
  br i1 %3, label %if.end, label %if.then4, !dbg !3777

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !2211), !dbg !3774
  br label %if.end, !dbg !3774

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !3777

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !3772

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3778, !tbaa !1780
  %cmp5 = icmp ult i32 %4, 1, !dbg !3778
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !3778
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !3771

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !3780, !tbaa !1780
  %6 = load ptr, ptr %v.addr, align 4, !dbg !3781, !tbaa !1545
  call addrspace(1) void @_ZN3aie6detail11vector_baseIfLj8EE13insert_helperILj8EEEvjRKNS1_IfXT_EEE(ptr nonnull align 32 dereferenceable(32) %this1, i32 %5, ptr nonnull align 32 dereferenceable(32) %6) #24, !dbg !3782
  ret ptr %this1, !dbg !3783
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local void @_ZN3aie6detail11vector_baseIfLj8EE13insert_helperILj8EEEvjRKNS1_IfXT_EEE(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx, ptr nonnull align 32 dereferenceable(32) %v) addrspace(1) #6 comdat align 2 !dbg !3784 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %v.addr = alloca ptr, align 4
  %input_bits = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3790, metadata !DIExpression()), !dbg !3794
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3791, metadata !DIExpression()), !dbg !3795
  store ptr %v, ptr %v.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %v.addr, metadata !3792, metadata !DIExpression()), !dbg !3796
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %input_bits, align 4, !dbg !3797
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %input_bits) #22, !dbg !3797
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %input_bits, metadata !3793, metadata !DIExpression()), !dbg !3798
  store i32 256, ptr %input_bits, align 4, !dbg !3798, !tbaa !1780
  %0 = load ptr, ptr %v.addr, align 4, !dbg !3799, !tbaa !1545
  %data = getelementptr inbounds %"class.aie::detail::vector_base", ptr %0, i32 0, i32 0, !dbg !3802
  %data2 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %this1, i32 0, i32 0, !dbg !3803
  %1 = load %struct.v8float, ptr %data, align 32, !dbg !3804, !tbaa !2248
  store %struct.v8float %1, ptr %data2, align 32, !dbg !3804, !tbaa !2248
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %input_bits) #22, !dbg !3805
  ret void, !dbg !3805
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %struct.v8accfloat @_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEcv10v8accfloatEv(ptr nonnull align 32 dereferenceable(32) %this) addrspace(1) #6 comdat align 2 !dbg !3806 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3808, metadata !DIExpression()), !dbg !3809
  %this1 = load ptr, ptr %this.addr, align 4
  %data = getelementptr inbounds %"class.aie::detail::accum_base", ptr %this1, i32 0, i32 0, !dbg !3810
  %0 = load %struct.v8accfloat, ptr %data, align 32, !dbg !3810, !tbaa !2405
  ret %struct.v8accfloat %0, !dbg !3810
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN7v8floatC2E10v8accfloat(ptr nonnull align 32 dereferenceable(32) %this, %struct.v8accfloat %a0.coerce) unnamed_addr addrspace(1) #16 comdat align 2 {
entry:
  %a0 = alloca %struct.v8accfloat, align 32
  %this.addr = alloca ptr, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.v64int4.v64int4, align 32
  %agg.tmp = alloca %struct.v8float, align 32
  store %struct.v8accfloat %a0.coerce, ptr %a0, align 32
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  %this1 = load ptr, ptr %this.addr, align 4
  %mw = getelementptr inbounds %struct.v8float, ptr %this1, i32 0, i32 0
  %0 = load %struct.ipd.custom_type.v64int4.v64int4, ptr %custom_type.tmp, align 32, !tbaa !2248
  store %struct.ipd.custom_type.v64int4.v64int4 %0, ptr %mw, align 32, !tbaa !2248
  %1 = load %struct.v8accfloat, ptr %a0, align 32, !tbaa !2405
  %call = call x86_regcallcc addrspace(1) %struct.v8float @__regcall3__chessintr_v8float_v8float_v8accfloat(%struct.v8accfloat %1) #25
  %2 = getelementptr inbounds %struct.v8float, ptr %agg.tmp, i32 0, i32 0
  %3 = extractvalue %struct.v8float %call, 0
  store %struct.ipd.custom_type.v64int4.v64int4 %3, ptr %2, align 32
  %4 = load %struct.v8float, ptr %agg.tmp, align 32, !tbaa !2248
  store %struct.v8float %4, ptr %this1, align 32, !tbaa !2248
  ret void
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.v8float @__regcall3__chessintr_v8float_v8float_v8accfloat(%struct.v8accfloat) addrspace(1) #14

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj8EE7extractILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3811 {
entry:
  %retval = alloca %"class.aie::detail::vector_base", align 32
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3816, metadata !DIExpression()), !dbg !3818
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3817, metadata !DIExpression()), !dbg !3819
  %this1 = load ptr, ptr %this.addr, align 4
  br label %do.body, !dbg !3820

do.body:                                          ; preds = %entry
  %0 = load i32, ptr %idx.addr, align 4, !dbg !3821, !tbaa !1780
  %cmp = icmp ult i32 %0, 1, !dbg !3821
  %1 = call addrspace(1) i1 @llvm.is.constant.i1(i1 %cmp), !dbg !3821
  br i1 %1, label %if.then, label %if.else, !dbg !3824

if.then:                                          ; preds = %do.body
  br label %do.body2, !dbg !3825

do.body2:                                         ; preds = %if.then
  %2 = load i32, ptr %idx.addr, align 4, !dbg !3827, !tbaa !1780
  %cmp3 = icmp ult i32 %2, 1, !dbg !3827
  %3 = call addrspace(1) i1 @llvm.chess_manifest(i1 %cmp3), !dbg !3827
  br i1 %3, label %if.end, label %if.then4, !dbg !3830

if.then4:                                         ; preds = %do.body2
  call addrspace(1) void @llvm.chess_error(metadata !2211), !dbg !3827
  br label %if.end, !dbg !3827

if.end:                                           ; preds = %if.then4, %do.body2
  br label %do.end, !dbg !3830

do.end:                                           ; preds = %if.end
  br label %if.end6, !dbg !3825

if.else:                                          ; preds = %do.body
  %4 = load i32, ptr %idx.addr, align 4, !dbg !3831, !tbaa !1780
  %cmp5 = icmp ult i32 %4, 1, !dbg !3831
  call addrspace(1) void @llvm.assume(i1 %cmp5), !dbg !3831
  br label %if.end6

if.end6:                                          ; preds = %if.else, %do.end
  br label %do.end7, !dbg !3824

do.end7:                                          ; preds = %if.end6
  %5 = load i32, ptr %idx.addr, align 4, !dbg !3833, !tbaa !1780
  %call = call addrspace(1) %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj8EE14extract_helperILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this1, i32 %5) #24, !dbg !3834
  %6 = getelementptr inbounds %"class.aie::detail::vector_base", ptr %retval, i32 0, i32 0, !dbg !3834
  %7 = extractvalue %"class.aie::detail::vector_base" %call, 0, !dbg !3834
  store %struct.v8float %7, ptr %6, align 32, !dbg !3834
  %8 = load %"class.aie::detail::vector_base", ptr %retval, align 32, !dbg !3835
  ret %"class.aie::detail::vector_base" %8, !dbg !3835
}

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local %"class.aie::detail::vector_base" @_ZNK3aie6detail11vector_baseIfLj8EE14extract_helperILj8EEENS1_IfXT_EEEj(ptr nonnull align 32 dereferenceable(32) %this, i32 %idx) addrspace(1) #6 comdat align 2 !dbg !3836 {
entry:
  %this.addr = alloca ptr, align 4
  %idx.addr = alloca i32, align 4
  %output_bits = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3839, metadata !DIExpression()), !dbg !3842
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !1780
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %idx.addr, metadata !3840, metadata !DIExpression()), !dbg !3843
  %this1 = load ptr, ptr %this.addr, align 4
  store i32 undef, ptr %output_bits, align 4, !dbg !3844
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %output_bits) #22, !dbg !3844
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %output_bits, metadata !3841, metadata !DIExpression()), !dbg !3845
  store i32 256, ptr %output_bits, align 4, !dbg !3845, !tbaa !1780
  %0 = load %"class.aie::detail::vector_base", ptr %this1, align 32, !dbg !3846, !tbaa !2225
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %output_bits) #22, !dbg !3849
  ret %"class.aie::detail::vector_base" %0, !dbg !3846
}

; Function Attrs: nounwind
define linkonce_odr dso_local void @_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEC2Ev(ptr nonnull align 4 dereferenceable(4) %this) unnamed_addr addrspace(1) #8 comdat align 2 !dbg !3850 {
entry:
  %this.addr = alloca ptr, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !1545
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %this.addr, metadata !3852, metadata !DIExpression()), !dbg !3853
  %this1 = load ptr, ptr %this.addr, align 4
  ret void, !dbg !3854
}

; Function Attrs: nounwind
define internal void @_GLOBAL__sub_I_i0_wrap_matrix_vector_mul.cpp() addrspace(1) #8 !dbg !3855 {
entry:
  call addrspace(1) void @__cxx_global_var_init(), !dbg !3857
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
!llvm.named.register.SCD = !{!1510}
!llvm.named.register.crF2FMask = !{!1511}
!llvm.named.register.crFPMask = !{!1512}
!llvm.linker.options = !{}
!llvm.chess.memory-units = !{!1513, !1514, !1515, !1516, !1517, !1518, !1519, !1520, !1521, !1522, !1523, !1524, !1525, !1526}
!llvm.module.flags = !{!1527, !1528, !1529, !1530}
!llvm.ident = !{!1531}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "i0", scope: !2, file: !1401, line: 7, type: !1043, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !3, producer: "clang version 16.0.3 (/u/sgasip/ipd/repositories/llvm_ipd 6a0b186d7c0e25173296a8e19f630e71bd7e8ed9)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !78, globals: !1081, imports: !1086, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir/i0_wrap_matrix_vector_mul.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir")
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
!78 = !{!79, !81, !371, !470, !15, !490, !124, !492, !494, !374, !308, !496, !498, !211, !112, !129, !85, !573, !615, !188, !650, !651, !652, !653, !654, !655, !656, !657, !658, !659, !660, !661, !662, !663, !664, !665, !666, !667, !668, !669, !670, !671, !672, !673, !674, !675, !676, !677, !678, !679, !680, !681, !693, !738, !739, !740, !741, !742, !397, !743, !212, !322, !192, !378, !744, !893, !894, !895, !896, !897, !898, !899, !900, !901, !497, !902, !903, !904, !905, !906, !907, !493, !908, !491, !856, !747, !909, !495, !501, !937, !961, !983, !1004, !1017, !1030, !1043}
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 32)
!80 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 32)
!82 = !DIDerivedType(tag: DW_TAG_typedef, name: "dataA_t", scope: !84, file: !83, line: 161, baseType: !188)
!83 = !DIFile(filename: "dsp_lib/L1/src/aie/matrix_vector_mul.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!84 = distinct !DISubprogram(name: "matVecMulBasic", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !83, line: 158, type: !109, scopeLine: 159, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !146, retainedNodes: !178)
!85 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "kernelMatVecMulClass<float, float, 128U, 768U, 0U, 0U, 0U, 1U, 12U, 1U, 0U, 0U, 1U, 11U, true, false>", scope: !87, file: !86, line: 77, size: 32, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !92, templateParams: !160, identifier: "_ZTSN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEE")
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
!108 = !DISubprogram(name: "matVecMulSelectArch", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 123, type: !109, scopeLine: 123, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
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
!146 = !DISubprogram(name: "matVecMulBasic", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 126, type: !109, scopeLine: 126, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!147 = !DISubprogram(name: "matVecMulStream", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE15matVecMulStreamENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 128, type: !109, scopeLine: 128, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!148 = !DISubprogram(name: "setInMatrixPtr", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14setInMatrixPtrERA8192_Kf", scope: !85, file: !86, line: 132, type: !149, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
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
!159 = !DISubprogram(name: "matVecMulKernel", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !86, line: 140, type: !109, scopeLine: 140, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
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
!174 = !DITemplateValueParameter(name: "TP_KERNEL_POSITION", type: !15, value: i32 11)
!175 = !DITemplateValueParameter(name: "TP_CASC_IN", type: !176, value: i1 true)
!176 = !DIBasicType(name: "bool", size: 8, encoding: DW_ATE_boolean)
!177 = !DITemplateValueParameter(name: "TP_CASC_OUT", type: !176, defaulted: true, value: i1 false)
!178 = !{!179, !181, !182, !183, !184, !186, !369, !372, !460, !462, !463, !464, !465, !466, !467, !468, !472, !474, !478, !482, !486}
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
!486 = !DILocalVariable(name: "n", scope: !487, file: !83, line: 220, type: !9)
!487 = distinct !DILexicalBlock(scope: !488, file: !83, line: 220, column: 25)
!488 = distinct !DILexicalBlock(scope: !489, file: !83, line: 217, column: 62)
!489 = distinct !DILexicalBlock(scope: !480, file: !83, line: 217, column: 31)
!490 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16float", file: !34, line: 617, baseType: !491)
!491 = !DIBasicType(name: "v16float", size: 512, encoding: DW_ATE_unsigned)
!492 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16accfloat", file: !34, line: 629, baseType: !493)
!493 = !DIBasicType(name: "v16accfloat", size: 512, encoding: DW_ATE_unsigned)
!494 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint1_t", file: !34, line: 464, baseType: !495)
!495 = !DIBasicType(name: "uint1_t", size: 32, encoding: DW_ATE_unsigned)
!496 = !DIDerivedType(tag: DW_TAG_typedef, name: "v32bfloat16", file: !34, line: 613, baseType: !497)
!497 = !DIBasicType(name: "v32bfloat16", size: 512, encoding: DW_ATE_unsigned)
!498 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "accum<accfloat, 16U>", scope: !8, file: !375, line: 47, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !499, templateParams: !572, identifier: "_ZTSN3aie5accumI8accfloatLj16EEE")
!499 = !{!500, !539, !546, !547, !548, !549, !550, !551, !552, !553, !554, !555, !556, !559, !564, !568}
!500 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !498, baseType: !501, extraData: i32 0)
!501 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "accum_base<(aie::detail::AccumClass)2, 32U, 16U>", scope: !7, file: !379, line: 144, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !502, templateParams: !538, identifier: "_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEE")
!502 = !{!503, !504, !505, !516, !517, !518, !519, !520, !521, !522, !523, !524, !525, !526, !530, !533}
!503 = !DIDerivedType(tag: DW_TAG_member, name: "Bits", scope: !501, file: !379, line: 146, baseType: !101, flags: DIFlagStaticMember, extraData: i32 32)
!504 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems", scope: !501, file: !379, line: 985, baseType: !101, flags: DIFlagStaticMember)
!505 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !501, file: !379, line: 991, baseType: !506, size: 512)
!506 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !501, file: !379, line: 155, baseType: !507, flags: DIFlagPublic)
!507 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_storage_t<(aie::detail::AccumClass)2, Bits, 16U>", scope: !7, file: !386, line: 135, baseType: !508)
!508 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !509, file: !386, line: 167, baseType: !492)
!509 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "accum_storage<(aie::detail::AccumClass)2, 32U, 16U>", scope: !7, file: !386, line: 167, size: 8, flags: DIFlagTypePassByValue, elements: !510, templateParams: !514, identifier: "_ZTSN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EEE")
!510 = !{!511}
!511 = !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv", scope: !509, file: !386, line: 167, type: !512, scopeLine: 167, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!512 = !DISubroutineType(types: !513)
!513 = !{!508}
!514 = !{!394, !395, !515}
!515 = !DITemplateValueParameter(name: "Elems", type: !15, value: i32 16)
!516 = !DISubprogram(name: "value_class", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE11value_classEv", scope: !501, file: !379, line: 157, type: !399, scopeLine: 157, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!517 = !DISubprogram(name: "accum_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE10accum_bitsEv", scope: !501, file: !379, line: 162, type: !214, scopeLine: 162, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!518 = !DISubprogram(name: "accum_min_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE14accum_min_bitsEv", scope: !501, file: !379, line: 167, type: !214, scopeLine: 167, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!519 = !DISubprogram(name: "value_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE10value_bitsEv", scope: !501, file: !379, line: 172, type: !214, scopeLine: 172, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!520 = !DISubprogram(name: "memory_bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE11memory_bitsEv", scope: !501, file: !379, line: 180, type: !214, scopeLine: 180, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!521 = !DISubprogram(name: "size", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE4sizeEv", scope: !501, file: !379, line: 192, type: !214, scopeLine: 192, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!522 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE4bitsEv", scope: !501, file: !379, line: 197, type: !214, scopeLine: 197, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!523 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE10is_complexEv", scope: !501, file: !379, line: 205, type: !219, scopeLine: 205, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!524 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7is_realEv", scope: !501, file: !379, line: 214, type: !219, scopeLine: 214, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!525 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE17is_floating_pointEv", scope: !501, file: !379, line: 219, type: !219, scopeLine: 219, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!526 = !DISubprogram(name: "accum_base", scope: !501, file: !379, line: 229, type: !527, scopeLine: 229, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!527 = !DISubroutineType(types: !528)
!528 = !{null, !529}
!529 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !501, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!530 = !DISubprogram(name: "accum_base", scope: !501, file: !379, line: 242, type: !531, scopeLine: 242, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!531 = !DISubroutineType(types: !532)
!532 = !{null, !529, !506}
!533 = !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv", scope: !501, file: !379, line: 256, type: !534, scopeLine: 256, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!534 = !DISubroutineType(types: !535)
!535 = !{!506, !536}
!536 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !537, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!537 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !501)
!538 = !{!394, !423, !515}
!539 = !DISubprogram(name: "accum", scope: !498, file: !375, line: 59, type: !540, scopeLine: 59, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!540 = !DISubroutineType(types: !541)
!541 = !{null, !542, !543}
!542 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !498, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!543 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !544, size: 32)
!544 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !545)
!545 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !498, file: !375, line: 51, baseType: !501)
!546 = !DISubprogram(name: "value_class", linkageName: "_ZN3aie5accumI8accfloatLj16EE11value_classEv", scope: !498, file: !375, line: 78, type: !399, scopeLine: 78, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!547 = !DISubprogram(name: "accum_min_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE14accum_min_bitsEv", scope: !498, file: !375, line: 83, type: !214, scopeLine: 83, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!548 = !DISubprogram(name: "accum_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE10accum_bitsEv", scope: !498, file: !375, line: 90, type: !214, scopeLine: 90, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!549 = !DISubprogram(name: "value_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE10value_bitsEv", scope: !498, file: !375, line: 97, type: !214, scopeLine: 97, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!550 = !DISubprogram(name: "memory_bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE11memory_bitsEv", scope: !498, file: !375, line: 104, type: !214, scopeLine: 104, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!551 = !DISubprogram(name: "size", linkageName: "_ZN3aie5accumI8accfloatLj16EE4sizeEv", scope: !498, file: !375, line: 109, type: !214, scopeLine: 109, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!552 = !DISubprogram(name: "bits", linkageName: "_ZN3aie5accumI8accfloatLj16EE4bitsEv", scope: !498, file: !375, line: 114, type: !214, scopeLine: 114, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!553 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie5accumI8accfloatLj16EE10is_complexEv", scope: !498, file: !375, line: 119, type: !219, scopeLine: 119, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!554 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie5accumI8accfloatLj16EE7is_realEv", scope: !498, file: !375, line: 124, type: !219, scopeLine: 124, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!555 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie5accumI8accfloatLj16EE17is_floating_pointEv", scope: !498, file: !375, line: 129, type: !219, scopeLine: 129, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!556 = !DISubprogram(name: "accum", scope: !498, file: !375, line: 163, type: !557, scopeLine: 163, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!557 = !DISubroutineType(types: !558)
!558 = !{null, !542}
!559 = !DISubprogram(name: "accum", scope: !498, file: !375, line: 168, type: !560, scopeLine: 168, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!560 = !DISubroutineType(types: !561)
!561 = !{null, !542, !562}
!562 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !563, size: 32)
!563 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !498)
!564 = !DISubprogram(name: "accum", scope: !498, file: !375, line: 188, type: !565, scopeLine: 188, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!565 = !DISubroutineType(types: !566)
!566 = !{null, !542, !567}
!567 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !498, file: !375, line: 73, baseType: !506, flags: DIFlagPublic)
!568 = !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv", scope: !498, file: !375, line: 234, type: !569, scopeLine: 234, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!569 = !DISubroutineType(types: !570)
!570 = !{!567, !571}
!571 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !563, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!572 = !{!458, !515}
!573 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tile", scope: !7, file: !574, line: 30, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !575, identifier: "_ZTSN3aie6detail4tileE")
!574 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/tile.hpp", directory: "")
!575 = !{!576, !581, !585, !594, !595, !600, !603, !606, !609, !612}
!576 = !DIDerivedType(tag: DW_TAG_member, name: "compute_row_offset", scope: !573, file: !574, line: 33, baseType: !577, flags: DIFlagStaticMember, extraData: i16 3)
!577 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !578)
!578 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !579, line: 30, baseType: !580)
!579 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdint.h", directory: "")
!580 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!581 = !DISubprogram(name: "tile", scope: !573, file: !574, line: 36, type: !582, scopeLine: 36, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!582 = !DISubroutineType(types: !583)
!583 = !{null, !584}
!584 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !573, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!585 = !DISubprogram(name: "global_id", linkageName: "_ZNK3aie6detail4tile9global_idEv", scope: !573, file: !574, line: 40, type: !586, scopeLine: 40, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!586 = !DISubroutineType(types: !587)
!587 = !{!588, !592}
!588 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tile_id", scope: !8, file: !14, line: 52, size: 32, flags: DIFlagTypePassByValue, elements: !589, identifier: "_ZTSN3aie7tile_idE")
!589 = !{!590, !591}
!590 = !DIDerivedType(tag: DW_TAG_member, name: "row", scope: !588, file: !14, line: 54, baseType: !578, size: 16)
!591 = !DIDerivedType(tag: DW_TAG_member, name: "col", scope: !588, file: !14, line: 55, baseType: !578, size: 16, offset: 16)
!592 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !593, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!593 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !573)
!594 = !DISubprogram(name: "id", linkageName: "_ZNK3aie6detail4tile2idEv", scope: !573, file: !574, line: 49, type: !586, scopeLine: 49, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!595 = !DISubprogram(name: "cycles", linkageName: "_ZNK3aie6detail4tile6cyclesEv", scope: !573, file: !574, line: 58, type: !596, scopeLine: 58, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!596 = !DISubroutineType(types: !597)
!597 = !{!598, !592}
!598 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !579, line: 32, baseType: !599)
!599 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!600 = !DISubprogram(name: "current", linkageName: "_ZN3aie6detail4tile7currentEv", scope: !573, file: !574, line: 64, type: !601, scopeLine: 64, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!601 = !DISubroutineType(types: !602)
!602 = !{!573}
!603 = !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE", scope: !573, file: !574, line: 70, type: !604, scopeLine: 70, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!604 = !DISubroutineType(types: !605)
!605 = !{null, !584, !27}
!606 = !DISubprogram(name: "get_saturation", linkageName: "_ZNK3aie6detail4tile14get_saturationEv", scope: !573, file: !574, line: 76, type: !607, scopeLine: 76, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!607 = !DISubroutineType(types: !608)
!608 = !{!27, !592}
!609 = !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE", scope: !573, file: !574, line: 82, type: !610, scopeLine: 82, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!610 = !DISubroutineType(types: !611)
!611 = !{null, !584, !13}
!612 = !DISubprogram(name: "get_rounding", linkageName: "_ZNK3aie6detail4tile12get_roundingEv", scope: !573, file: !574, line: 88, type: !613, scopeLine: 88, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!613 = !DISubroutineType(types: !614)
!614 = !{!13, !592}
!615 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tile", scope: !8, file: !616, line: 25, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !617, identifier: "_ZTSN3aie4tileE")
!616 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/tile.hpp", directory: "")
!617 = !{!618, !619, !626, !631, !632, !635, !638, !641, !644, !647}
!618 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !615, baseType: !573, extraData: i32 0)
!619 = !DISubprogram(name: "tile", scope: !615, file: !616, line: 30, type: !620, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!620 = !DISubroutineType(types: !621)
!621 = !{null, !622, !623}
!622 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !615, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!623 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !624, size: 32)
!624 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !625)
!625 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !615, file: !616, line: 28, baseType: !573)
!626 = !DISubprogram(name: "global_id", linkageName: "_ZNK3aie4tile9global_idEv", scope: !615, file: !616, line: 34, type: !627, scopeLine: 34, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!627 = !DISubroutineType(types: !628)
!628 = !{!588, !629}
!629 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !630, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!630 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !615)
!631 = !DISubprogram(name: "id", linkageName: "_ZNK3aie4tile2idEv", scope: !615, file: !616, line: 38, type: !627, scopeLine: 38, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!632 = !DISubprogram(name: "cycles", linkageName: "_ZNK3aie4tile6cyclesEv", scope: !615, file: !616, line: 42, type: !633, scopeLine: 42, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!633 = !DISubroutineType(types: !634)
!634 = !{!598, !629}
!635 = !DISubprogram(name: "current", linkageName: "_ZN3aie4tile7currentEv", scope: !615, file: !616, line: 46, type: !636, scopeLine: 46, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!636 = !DISubroutineType(types: !637)
!637 = !{!615}
!638 = !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie4tile14set_saturationENS_15saturation_modeE", scope: !615, file: !616, line: 50, type: !639, scopeLine: 50, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!639 = !DISubroutineType(types: !640)
!640 = !{null, !622, !27}
!641 = !DISubprogram(name: "get_saturation", linkageName: "_ZNK3aie4tile14get_saturationEv", scope: !615, file: !616, line: 54, type: !642, scopeLine: 54, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!642 = !DISubroutineType(types: !643)
!643 = !{!27, !629}
!644 = !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie4tile12set_roundingENS_13rounding_modeE", scope: !615, file: !616, line: 58, type: !645, scopeLine: 58, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!645 = !DISubroutineType(types: !646)
!646 = !{null, !622, !13}
!647 = !DISubprogram(name: "get_rounding", linkageName: "_ZNK3aie4tile12get_roundingEv", scope: !615, file: !616, line: 63, type: !648, scopeLine: 63, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!648 = !DISubroutineType(types: !649)
!649 = !{!13, !629}
!650 = !DIBasicType(name: "v64uint4", size: 256, encoding: DW_ATE_unsigned)
!651 = !DIBasicType(name: "v32uint8", size: 256, encoding: DW_ATE_unsigned)
!652 = !DIBasicType(name: "v32int8", size: 256, encoding: DW_ATE_unsigned)
!653 = !DIBasicType(name: "v16uint16", size: 256, encoding: DW_ATE_unsigned)
!654 = !DIBasicType(name: "v16int16", size: 256, encoding: DW_ATE_unsigned)
!655 = !DIBasicType(name: "v8cint16", size: 256, encoding: DW_ATE_unsigned)
!656 = !DIBasicType(name: "v8uint32", size: 256, encoding: DW_ATE_unsigned)
!657 = !DIBasicType(name: "v8int32", size: 256, encoding: DW_ATE_unsigned)
!658 = !DIBasicType(name: "v4cint32", size: 256, encoding: DW_ATE_unsigned)
!659 = !DIBasicType(name: "v16bfloat16", size: 256, encoding: DW_ATE_unsigned)
!660 = !DIBasicType(name: "v8acc32", size: 256, encoding: DW_ATE_unsigned)
!661 = !DIBasicType(name: "v4acc64", size: 256, encoding: DW_ATE_unsigned)
!662 = !DIBasicType(name: "v2cacc64", size: 256, encoding: DW_ATE_unsigned)
!663 = !DIBasicType(name: "v4caccfloat", size: 256, encoding: DW_ATE_unsigned)
!664 = !DIBasicType(name: "v4cfloat", size: 256, encoding: DW_ATE_unsigned)
!665 = !DIBasicType(name: "v8cbfloat16", size: 256, encoding: DW_ATE_unsigned)
!666 = !DIBasicType(name: "v32uint4", size: 128, encoding: DW_ATE_unsigned)
!667 = !DIBasicType(name: "v16uint8", size: 128, encoding: DW_ATE_unsigned)
!668 = !DIBasicType(name: "v16int8", size: 128, encoding: DW_ATE_unsigned)
!669 = !DIBasicType(name: "v8uint16", size: 128, encoding: DW_ATE_unsigned)
!670 = !DIBasicType(name: "v8int16", size: 128, encoding: DW_ATE_unsigned)
!671 = !DIBasicType(name: "v4cint16", size: 128, encoding: DW_ATE_unsigned)
!672 = !DIBasicType(name: "v4uint32", size: 128, encoding: DW_ATE_unsigned)
!673 = !DIBasicType(name: "v4int32", size: 128, encoding: DW_ATE_unsigned)
!674 = !DIBasicType(name: "v2cint32", size: 128, encoding: DW_ATE_unsigned)
!675 = !DIBasicType(name: "v8bfloat16", size: 128, encoding: DW_ATE_unsigned)
!676 = !DIBasicType(name: "v4float", size: 128, encoding: DW_ATE_unsigned)
!677 = !DIBasicType(name: "v2cfloat", size: 128, encoding: DW_ATE_unsigned)
!678 = !DIBasicType(name: "v16uint4", size: 64, encoding: DW_ATE_unsigned)
!679 = !DIBasicType(name: "v16int4", size: 64, encoding: DW_ATE_unsigned)
!680 = !DIBasicType(name: "cint32_w64", size: 64, encoding: DW_ATE_unsigned)
!681 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cint32", file: !34, line: 5738, size: 64, flags: DIFlagTypePassByValue, elements: !682, identifier: "_ZTS6cint32")
!682 = !{!683, !684, !685, !689, !694, !735}
!683 = !DIDerivedType(tag: DW_TAG_member, name: "real", scope: !681, file: !34, line: 5739, baseType: !9, size: 32)
!684 = !DIDerivedType(tag: DW_TAG_member, name: "imag", scope: !681, file: !34, line: 5740, baseType: !9, size: 32, offset: 32)
!685 = !DISubprogram(name: "cint32", scope: !681, file: !34, line: 5743, type: !686, scopeLine: 5743, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!686 = !DISubroutineType(types: !687)
!687 = !{null, !688, !9, !9}
!688 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !681, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!689 = !DISubprogram(name: "cint32", scope: !681, file: !34, line: 5744, type: !690, scopeLine: 5744, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!690 = !DISubroutineType(types: !691)
!691 = !{null, !688, !692}
!692 = !DIDerivedType(tag: DW_TAG_typedef, name: "cint16", file: !34, line: 476, baseType: !693)
!693 = !DIBasicType(name: "cint16", size: 32, encoding: DW_ATE_unsigned)
!694 = !DISubprogram(name: "cint32", scope: !681, file: !34, line: 5745, type: !695, scopeLine: 5745, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!695 = !DISubroutineType(types: !696)
!696 = !{null, !688, !697}
!697 = !DIDerivedType(tag: DW_TAG_typedef, name: "cint32_w64", file: !34, line: 635, baseType: !698)
!698 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cint32_w64", file: !34, line: 5714, size: 64, flags: DIFlagTypePassByValue, elements: !699, identifier: "_ZTS10cint32_w64")
!699 = !{!700, !702, !706, !709, !713, !716}
!700 = !DIDerivedType(tag: DW_TAG_member, name: "mw", scope: !698, file: !34, line: 5723, baseType: !701, size: 64)
!701 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16int4", file: !34, line: 509, baseType: !679)
!702 = !DISubprogram(name: "cint32_w64", scope: !698, file: !34, line: 5716, type: !703, scopeLine: 5716, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!703 = !DISubroutineType(types: !704)
!704 = !{null, !705, !9}
!705 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !698, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!706 = !DISubprogram(name: "cint32_w64", scope: !698, file: !34, line: 5717, type: !707, scopeLine: 5717, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!707 = !DISubroutineType(types: !708)
!708 = !{null, !705, !9, !9}
!709 = !DISubprogram(name: "cint32_w64", scope: !698, file: !34, line: 5718, type: !710, scopeLine: 5718, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!710 = !DISubroutineType(types: !711)
!711 = !{null, !705, !712}
!712 = !DIDerivedType(tag: DW_TAG_typedef, name: "cint32", file: !34, line: 862, baseType: !681)
!713 = !DISubprogram(name: "cint32_w64", scope: !698, file: !34, line: 5719, type: !714, scopeLine: 5719, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!714 = !DISubroutineType(types: !715)
!715 = !{null, !705}
!716 = !DISubprogram(name: "cint32_w64", scope: !698, file: !34, line: 5720, type: !717, scopeLine: 5720, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!717 = !DISubroutineType(types: !718)
!718 = !{null, !705, !33, !719}
!719 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16int4", file: !34, line: 509, baseType: !720)
!720 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "v16int4", file: !34, line: 1831, size: 64, flags: DIFlagTypePassByValue, elements: !721, identifier: "_ZTS7v16int4")
!721 = !{!722, !723, !724, !729, !732}
!722 = !DIDerivedType(tag: DW_TAG_member, name: "m1", scope: !720, file: !34, line: 1839, baseType: !15, size: 32, flags: DIFlagBitField, extraData: i64 0)
!723 = !DIDerivedType(tag: DW_TAG_member, name: "m0", scope: !720, file: !34, line: 1840, baseType: !15, size: 32, offset: 32, flags: DIFlagBitField, extraData: i64 0)
!724 = !DISubprogram(name: "v16int4", scope: !720, file: !34, line: 1833, type: !725, scopeLine: 1833, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!725 = !DISubroutineType(types: !726)
!726 = !{null, !727, !728}
!727 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !720, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!728 = !DIDerivedType(tag: DW_TAG_typedef, name: "v16uint4", file: !34, line: 510, baseType: !678)
!729 = !DISubprogram(name: "v16int4", scope: !720, file: !34, line: 1834, type: !730, scopeLine: 1834, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!730 = !DISubroutineType(types: !731)
!731 = !{null, !727}
!732 = !DISubprogram(name: "v16int4", scope: !720, file: !34, line: 1835, type: !733, scopeLine: 1835, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!733 = !DISubroutineType(types: !734)
!734 = !{null, !727, !33, !15, !15}
!735 = !DISubprogram(name: "cint32", scope: !681, file: !34, line: 5746, type: !736, scopeLine: 5746, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!736 = !DISubroutineType(types: !737)
!737 = !{null, !688}
!738 = !DIBasicType(name: "bfloat16", size: 16, encoding: DW_ATE_unsigned)
!739 = !DIBasicType(name: "uint4_t", size: 8, encoding: DW_ATE_unsigned)
!740 = !DIBasicType(name: "int4_t", size: 8, encoding: DW_ATE_signed)
!741 = !DIBasicType(name: "v32int4", size: 128, encoding: DW_ATE_unsigned)
!742 = !DIBasicType(name: "v4cbfloat16", size: 128, encoding: DW_ATE_unsigned)
!743 = !DIBasicType(name: "v64int4", size: 256, encoding: DW_ATE_unsigned)
!744 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector<float, 16U>", scope: !8, file: !189, line: 77, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !745, templateParams: !760, identifier: "_ZTSN3aie6vectorIfLj16EEE")
!745 = !{!746, !803, !810, !811, !812, !813, !814, !815, !816, !817, !818, !819, !822, !826, !832, !837, !838, !843, !846, !849, !853, !890, !891, !892}
!746 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !744, baseType: !747, extraData: i32 0)
!747 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_base<float, 16U>", scope: !7, file: !193, line: 348, size: 512, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !748, templateParams: !760, identifier: "_ZTSN3aie6detail11vector_baseIfLj16EEE")
!748 = !{!749, !750, !751, !752, !761, !762, !763, !764, !765, !766, !767, !768, !769, !773, !777, !786, !791, !794, !799, !802}
!749 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems", scope: !747, file: !193, line: 1350, baseType: !101, flags: DIFlagStaticMember)
!750 = !DIDerivedType(tag: DW_TAG_member, name: "num_storage_elems", scope: !747, file: !193, line: 1351, baseType: !101, flags: DIFlagStaticMember, extraData: i32 1)
!751 = !DIDerivedType(tag: DW_TAG_member, name: "is_compound_storage", scope: !747, file: !193, line: 1352, baseType: !198, flags: DIFlagStaticMember)
!752 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !747, file: !193, line: 1357, baseType: !753, size: 512)
!753 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_storage_t<float, 16U>", scope: !7, file: !201, line: 205, baseType: !754)
!754 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !755, file: !201, line: 299, baseType: !490)
!755 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vector_storage<float, 16U>", scope: !7, file: !201, line: 299, size: 8, flags: DIFlagTypePassByValue, elements: !756, templateParams: !760, identifier: "_ZTSN3aie6detail14vector_storageIfLj16EEE")
!756 = !{!757}
!757 = !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj16EE5undefEv", scope: !755, file: !201, line: 299, type: !758, scopeLine: 299, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!758 = !DISubroutineType(types: !759)
!759 = !{!754}
!760 = !{!209, !515}
!761 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE9type_bitsEv", scope: !747, file: !193, line: 361, type: !214, scopeLine: 361, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!762 = !DISubprogram(name: "size", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE4sizeEv", scope: !747, file: !193, line: 366, type: !214, scopeLine: 366, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!763 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE4bitsEv", scope: !747, file: !193, line: 371, type: !214, scopeLine: 371, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!764 = !DISubprogram(name: "is_signed", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE9is_signedEv", scope: !747, file: !193, line: 376, type: !219, scopeLine: 376, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!765 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE10is_complexEv", scope: !747, file: !193, line: 381, type: !219, scopeLine: 381, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!766 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE7is_realEv", scope: !747, file: !193, line: 386, type: !219, scopeLine: 386, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!767 = !DISubprogram(name: "is_integral", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE11is_integralEv", scope: !747, file: !193, line: 391, type: !219, scopeLine: 391, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!768 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE17is_floating_pointEv", scope: !747, file: !193, line: 396, type: !219, scopeLine: 396, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!769 = !DISubprogram(name: "vector_base", scope: !747, file: !193, line: 402, type: !770, scopeLine: 402, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!770 = !DISubroutineType(types: !771)
!771 = !{null, !772}
!772 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !747, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!773 = !DISubprogram(name: "vector_base", scope: !747, file: !193, line: 408, type: !774, scopeLine: 408, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!774 = !DISubroutineType(types: !775)
!775 = !{null, !772, !776}
!776 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !747, file: !193, line: 359, baseType: !754, flags: DIFlagPublic)
!777 = !DISubprogram(name: "vector_base", scope: !747, file: !193, line: 421, type: !778, scopeLine: 421, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!778 = !DISubroutineType(types: !779)
!779 = !{null, !772, !780}
!780 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !781, size: 32)
!781 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !782)
!782 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_type", scope: !747, file: !193, line: 357, baseType: !783, flags: DIFlagPublic)
!783 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_vector_type_t<float, 16U>", scope: !7, file: !201, line: 116, baseType: !784)
!784 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !785, file: !201, line: 97, baseType: !490)
!785 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "native_vector_type<float, 16U>", scope: !7, file: !201, line: 97, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !760, identifier: "_ZTSN3aie6detail18native_vector_typeIfLj16EEE")
!786 = !DISubprogram(name: "push", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE4pushEf", scope: !747, file: !193, line: 494, type: !787, scopeLine: 494, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!787 = !DISubroutineType(types: !788)
!788 = !{!789, !772, !790}
!789 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !747, size: 32)
!790 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !747, file: !193, line: 358, baseType: !80, flags: DIFlagPublic)
!791 = !DISubprogram(name: "set", linkageName: "_ZN3aie6detail11vector_baseIfLj16EE3setEfj", scope: !747, file: !193, line: 652, type: !792, scopeLine: 652, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!792 = !DISubroutineType(types: !793)
!793 = !{null, !772, !790, !15}
!794 = !DISubprogram(name: "get", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE3getEj", scope: !747, file: !193, line: 703, type: !795, scopeLine: 703, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!795 = !DISubroutineType(types: !796)
!796 = !{!790, !797, !15}
!797 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !798, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!798 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !747)
!799 = !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv", scope: !747, file: !193, line: 1154, type: !800, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!800 = !DISubroutineType(types: !801)
!801 = !{!782, !797}
!802 = !DISubprogram(name: "operator v16float", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EEcv8v16floatEv", scope: !747, file: !193, line: 1164, type: !800, scopeLine: 1164, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!803 = !DISubprogram(name: "vector", scope: !744, file: !189, line: 87, type: !804, scopeLine: 87, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!804 = !DISubroutineType(types: !805)
!805 = !{null, !806, !807}
!806 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !744, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!807 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !808, size: 32)
!808 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !809)
!809 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_type", scope: !744, file: !189, line: 80, baseType: !747)
!810 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie6vectorIfLj16EE9type_bitsEv", scope: !744, file: !189, line: 102, type: !214, scopeLine: 102, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!811 = !DISubprogram(name: "size", linkageName: "_ZN3aie6vectorIfLj16EE4sizeEv", scope: !744, file: !189, line: 107, type: !214, scopeLine: 107, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!812 = !DISubprogram(name: "bits", linkageName: "_ZN3aie6vectorIfLj16EE4bitsEv", scope: !744, file: !189, line: 112, type: !214, scopeLine: 112, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!813 = !DISubprogram(name: "bytes", linkageName: "_ZN3aie6vectorIfLj16EE5bytesEv", scope: !744, file: !189, line: 117, type: !214, scopeLine: 117, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!814 = !DISubprogram(name: "is_signed", linkageName: "_ZN3aie6vectorIfLj16EE9is_signedEv", scope: !744, file: !189, line: 122, type: !219, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!815 = !DISubprogram(name: "is_complex", linkageName: "_ZN3aie6vectorIfLj16EE10is_complexEv", scope: !744, file: !189, line: 127, type: !219, scopeLine: 127, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!816 = !DISubprogram(name: "is_real", linkageName: "_ZN3aie6vectorIfLj16EE7is_realEv", scope: !744, file: !189, line: 132, type: !219, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!817 = !DISubprogram(name: "is_integral", linkageName: "_ZN3aie6vectorIfLj16EE11is_integralEv", scope: !744, file: !189, line: 137, type: !219, scopeLine: 137, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!818 = !DISubprogram(name: "is_floating_point", linkageName: "_ZN3aie6vectorIfLj16EE17is_floating_pointEv", scope: !744, file: !189, line: 142, type: !219, scopeLine: 142, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!819 = !DISubprogram(name: "vector", scope: !744, file: !189, line: 148, type: !820, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!820 = !DISubroutineType(types: !821)
!821 = !{null, !806}
!822 = !DISubprogram(name: "vector", scope: !744, file: !189, line: 159, type: !823, scopeLine: 159, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!823 = !DISubroutineType(types: !824)
!824 = !{null, !806, !825}
!825 = !DIDerivedType(tag: DW_TAG_typedef, name: "storage_t", scope: !744, file: !189, line: 97, baseType: !776, flags: DIFlagPublic)
!826 = !DISubprogram(name: "vector", scope: !744, file: !189, line: 173, type: !827, scopeLine: 173, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!827 = !DISubroutineType(types: !828)
!828 = !{null, !806, !829}
!829 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !830, size: 32)
!830 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !831)
!831 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_type", scope: !744, file: !189, line: 91, baseType: !782, flags: DIFlagPublic)
!832 = !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6vectorIfLj16EE9to_nativeEv", scope: !744, file: !189, line: 196, type: !833, scopeLine: 196, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!833 = !DISubroutineType(types: !834)
!834 = !{!831, !835}
!835 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !836, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!836 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !744)
!837 = !DISubprogram(name: "operator v16float", linkageName: "_ZNK3aie6vectorIfLj16EEcv8v16floatEv", scope: !744, file: !189, line: 205, type: !833, scopeLine: 205, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!838 = !DISubprogram(name: "push", linkageName: "_ZN3aie6vectorIfLj16EE4pushEf", scope: !744, file: !189, line: 233, type: !839, scopeLine: 233, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!839 = !DISubroutineType(types: !840)
!840 = !{!841, !806, !842}
!841 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !744, size: 32)
!842 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !744, file: !189, line: 94, baseType: !790, flags: DIFlagPublic)
!843 = !DISubprogram(name: "set", linkageName: "_ZN3aie6vectorIfLj16EE3setEfj", scope: !744, file: !189, line: 271, type: !844, scopeLine: 271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!844 = !DISubroutineType(types: !845)
!845 = !{null, !806, !842, !15}
!846 = !DISubprogram(name: "get", linkageName: "_ZNK3aie6vectorIfLj16EE3getEj", scope: !744, file: !189, line: 282, type: !847, scopeLine: 282, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!847 = !DISubroutineType(types: !848)
!848 = !{!842, !835, !15}
!849 = !DISubprogram(name: "operator[]", linkageName: "_ZNK3aie6vectorIfLj16EEixEj", scope: !744, file: !189, line: 292, type: !850, scopeLine: 292, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!850 = !DISubroutineType(types: !851)
!851 = !{!852, !835, !15}
!852 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_elem_const_ref<float, 16U>", scope: !8, file: !309, line: 25, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3aie21vector_elem_const_refIfLj16EEE")
!853 = !DISubprogram(name: "operator[]", linkageName: "_ZN3aie6vectorIfLj16EEixEj", scope: !744, file: !189, line: 303, type: !854, scopeLine: 303, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!854 = !DISubroutineType(types: !855)
!855 = !{!856, !806, !15}
!856 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector_elem_ref<float, 16U>", scope: !8, file: !309, line: 133, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !857, templateParams: !888, identifier: "_ZTSN3aie15vector_elem_refIfLj16EEE")
!857 = !{!858, !861, !862, !868, !869, !876, !880, !885}
!858 = !DIDerivedType(tag: DW_TAG_member, name: "parent", scope: !856, file: !309, line: 237, baseType: !859, size: 32, flags: DIFlagPublic)
!859 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !860, size: 32)
!860 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !856, file: !309, line: 136, baseType: !744, flags: DIFlagPublic)
!861 = !DIDerivedType(tag: DW_TAG_member, name: "offset", scope: !856, file: !309, line: 238, baseType: !15, size: 32, offset: 32, flags: DIFlagPublic)
!862 = !DISubprogram(name: "get", linkageName: "_ZNK3aie15vector_elem_refIfLj16EE3getEv", scope: !856, file: !309, line: 143, type: !863, scopeLine: 143, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!863 = !DISubroutineType(types: !864)
!864 = !{!865, !866}
!865 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !856, file: !309, line: 138, baseType: !80, flags: DIFlagPublic)
!866 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !867, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!867 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !856)
!868 = !DISubprogram(name: "operator float", linkageName: "_ZNK3aie15vector_elem_refIfLj16EEcvfEv", scope: !856, file: !309, line: 151, type: !863, scopeLine: 151, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!869 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj16EEaSERKf", scope: !856, file: !309, line: 159, type: !870, scopeLine: 159, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!870 = !DISubroutineType(types: !871)
!871 = !{!872, !873, !874}
!872 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !856, size: 32)
!873 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !856, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!874 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !875, size: 32)
!875 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !865)
!876 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj16EEaSERKS1_", scope: !856, file: !309, line: 168, type: !877, scopeLine: 168, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!877 = !DISubroutineType(types: !878)
!878 = !{!872, !873, !879}
!879 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !867, size: 32)
!880 = !DISubprogram(name: "operator=", linkageName: "_ZN3aie15vector_elem_refIfLj16EEaSERKNS_21vector_elem_const_refIfLj16EEE", scope: !856, file: !309, line: 177, type: !881, scopeLine: 177, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!881 = !DISubroutineType(types: !882)
!882 = !{!872, !873, !883}
!883 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !884, size: 32)
!884 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !852)
!885 = !DISubprogram(name: "vector_elem_ref", scope: !856, file: !309, line: 241, type: !886, scopeLine: 241, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!886 = !DISubroutineType(types: !887)
!887 = !{null, !873, !859, !15}
!888 = !{!209, !889}
!889 = !DITemplateValueParameter(name: "N", type: !15, value: i32 16)
!890 = !DISubprogram(name: "elem_const_ref", linkageName: "_ZNK3aie6vectorIfLj16EE14elem_const_refEj", scope: !744, file: !189, line: 314, type: !850, scopeLine: 314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!891 = !DISubprogram(name: "elem_ref", linkageName: "_ZNK3aie6vectorIfLj16EE8elem_refEj", scope: !744, file: !189, line: 325, type: !850, scopeLine: 325, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!892 = !DISubprogram(name: "elem_ref", linkageName: "_ZN3aie6vectorIfLj16EE8elem_refEj", scope: !744, file: !189, line: 336, type: !854, scopeLine: 336, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!893 = !DIBasicType(name: "v128uint4", size: 512, encoding: DW_ATE_unsigned)
!894 = !DIBasicType(name: "v64uint8", size: 512, encoding: DW_ATE_unsigned)
!895 = !DIBasicType(name: "v64int8", size: 512, encoding: DW_ATE_unsigned)
!896 = !DIBasicType(name: "v32uint16", size: 512, encoding: DW_ATE_unsigned)
!897 = !DIBasicType(name: "v32int16", size: 512, encoding: DW_ATE_unsigned)
!898 = !DIBasicType(name: "v16cint16", size: 512, encoding: DW_ATE_unsigned)
!899 = !DIBasicType(name: "v16uint32", size: 512, encoding: DW_ATE_unsigned)
!900 = !DIBasicType(name: "v16int32", size: 512, encoding: DW_ATE_unsigned)
!901 = !DIBasicType(name: "v8cint32", size: 512, encoding: DW_ATE_unsigned)
!902 = !DIBasicType(name: "v16acc32", size: 512, encoding: DW_ATE_unsigned)
!903 = !DIBasicType(name: "v8acc64", size: 512, encoding: DW_ATE_unsigned)
!904 = !DIBasicType(name: "v4cacc64", size: 512, encoding: DW_ATE_unsigned)
!905 = !DIBasicType(name: "v8caccfloat", size: 512, encoding: DW_ATE_unsigned)
!906 = !DIBasicType(name: "v8cfloat", size: 512, encoding: DW_ATE_unsigned)
!907 = !DIBasicType(name: "v16cbfloat16", size: 512, encoding: DW_ATE_unsigned)
!908 = !DIBasicType(name: "v128int4", size: 512, encoding: DW_ATE_unsigned)
!909 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cascade_stream_helper<accfloat, 8U>", scope: !911, file: !910, line: 151, size: 8, flags: DIFlagTypePassByValue, elements: !912, templateParams: !935, identifier: "_ZTSN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EEE")
!910 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/adf/stream.hpp", directory: "")
!911 = !DINamespace(name: "adf", scope: !7)
!912 = !{!913, !914, !915, !916, !917, !918, !924, !927, !932}
!913 = !DIDerivedType(tag: DW_TAG_member, name: "cascade_width", scope: !909, file: !910, line: 179, baseType: !101, flags: DIFlagStaticMember, extraData: i32 512)
!914 = !DIDerivedType(tag: DW_TAG_member, name: "num_ops", scope: !909, file: !910, line: 180, baseType: !101, flags: DIFlagStaticMember, extraData: i32 1)
!915 = !DIDerivedType(tag: DW_TAG_member, name: "elems_per_op", scope: !909, file: !910, line: 181, baseType: !101, flags: DIFlagStaticMember, extraData: i32 8)
!916 = !DIDerivedType(tag: DW_TAG_member, name: "native_elems_per_op", scope: !909, file: !910, line: 182, baseType: !101, flags: DIFlagStaticMember, extraData: i32 16)
!917 = !DISubprogram(name: "compute_native_elems_per_op", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE27compute_native_elems_per_opEv", scope: !909, file: !910, line: 169, type: !214, scopeLine: 169, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!918 = !DISubprogram(name: "writeincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP13output_streamIS3_ENS_5accumIS3_Lj8EEE", scope: !909, file: !910, line: 186, type: !919, scopeLine: 186, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!919 = !DISubroutineType(types: !920)
!920 = !{null, !921, !923}
!921 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !922, size: 32)
!922 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "output_stream<accfloat>", file: !121, line: 150, size: 32, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS13output_streamI8accfloatE")
!923 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !909, file: !910, line: 154, baseType: !374)
!924 = !DISubprogram(name: "writeincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE9writeincrEP14output_cascadeIS3_vENS_5accumIS3_Lj8EEE", scope: !909, file: !910, line: 193, type: !925, scopeLine: 193, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!925 = !DISubroutineType(types: !926)
!926 = !{null, !144, !923}
!927 = !DISubprogram(name: "readincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP12input_streamIS3_E", scope: !909, file: !910, line: 208, type: !928, scopeLine: 208, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!928 = !DISubroutineType(types: !929)
!929 = !{!923, !930}
!930 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !931, size: 32)
!931 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "input_stream<accfloat>", file: !121, line: 144, size: 32, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS12input_streamI8accfloatE")
!932 = !DISubprogram(name: "readincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE", scope: !909, file: !910, line: 215, type: !933, scopeLine: 215, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!933 = !DISubroutineType(types: !934)
!934 = !{!923, !124}
!935 = !{!936, !353}
!936 = !DITemplateTypeParameter(name: "AccumTag", type: !459)
!937 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op_common<aie::accum<accfloat, 8U>, (aie::Operation)1>", scope: !8, file: !45, line: 358, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !938, templateParams: !958, identifier: "_ZTSN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEE")
!938 = !{!939, !941, !950, !951, !952, !953, !954}
!939 = !DIDerivedType(tag: DW_TAG_member, name: "operation", scope: !937, file: !45, line: 421, baseType: !940, flags: DIFlagStaticMember, extraData: i32 1)
!940 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !44)
!941 = !DIDerivedType(tag: DW_TAG_member, name: "parent_", scope: !937, file: !45, line: 430, baseType: !942, size: 256, flags: DIFlagPrivate)
!942 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !943)
!943 = !DIDerivedType(tag: DW_TAG_typedef, name: "parent1_type", scope: !937, file: !45, line: 360, baseType: !944)
!944 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_remove_t<aie::accum<accfloat, 8U> >", file: !945, line: 210, baseType: !946)
!945 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/aie_core.h", directory: "")
!946 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !947, file: !945, line: 187, baseType: !374)
!947 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_remove<aie::accum<accfloat, 8U> >", file: !945, line: 185, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !948, identifier: "_ZTS22aie_dm_resource_removeIN3aie5accumI8accfloatLj8EEEE")
!948 = !{!949}
!949 = !DITemplateTypeParameter(name: "T", type: !374)
!950 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE9type_bitsEv", scope: !937, file: !45, line: 364, type: !214, scopeLine: 364, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!951 = !DISubprogram(name: "size", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE4sizeEv", scope: !937, file: !45, line: 372, type: !214, scopeLine: 372, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!952 = !DISubprogram(name: "bits", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE4bitsEv", scope: !937, file: !45, line: 380, type: !214, scopeLine: 380, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!953 = !DISubprogram(name: "is_operation_none", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE17is_operation_noneEv", scope: !937, file: !45, line: 407, type: !219, scopeLine: 407, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!954 = !DISubprogram(name: "unary_op_common", scope: !937, file: !45, line: 424, type: !955, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!955 = !DISubroutineType(types: !956)
!956 = !{null, !957, !942}
!957 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !937, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!958 = !{!959, !960}
!959 = !DITemplateTypeParameter(name: "Parent", type: !374)
!960 = !DITemplateValueParameter(name: "Op", type: !44, value: i32 1)
!961 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op_common<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 358, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !962, templateParams: !980, identifier: "_ZTSN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE")
!962 = !{!963, !964, !972, !973, !974, !975, !976}
!963 = !DIDerivedType(tag: DW_TAG_member, name: "operation", scope: !961, file: !45, line: 421, baseType: !940, flags: DIFlagStaticMember, extraData: i32 0)
!964 = !DIDerivedType(tag: DW_TAG_member, name: "parent_", scope: !961, file: !45, line: 430, baseType: !965, size: 64, flags: DIFlagPrivate)
!965 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !966)
!966 = !DIDerivedType(tag: DW_TAG_typedef, name: "parent1_type", scope: !961, file: !45, line: 360, baseType: !967)
!967 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_remove_t<aie::vector_elem_ref<float, 8U> >", file: !945, line: 210, baseType: !968)
!968 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !969, file: !945, line: 187, baseType: !322)
!969 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_remove<aie::vector_elem_ref<float, 8U> >", file: !945, line: 185, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !970, identifier: "_ZTS22aie_dm_resource_removeIN3aie15vector_elem_refIfLj8EEEE")
!970 = !{!971}
!971 = !DITemplateTypeParameter(name: "T", type: !322)
!972 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE9type_bitsEv", scope: !961, file: !45, line: 364, type: !214, scopeLine: 364, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!973 = !DISubprogram(name: "size", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE4sizeEv", scope: !961, file: !45, line: 372, type: !214, scopeLine: 372, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!974 = !DISubprogram(name: "bits", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE4bitsEv", scope: !961, file: !45, line: 380, type: !214, scopeLine: 380, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!975 = !DISubprogram(name: "is_operation_none", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE17is_operation_noneEv", scope: !961, file: !45, line: 407, type: !219, scopeLine: 407, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!976 = !DISubprogram(name: "unary_op_common", scope: !961, file: !45, line: 424, type: !977, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!977 = !DISubroutineType(types: !978)
!978 = !{null, !979, !965}
!979 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !961, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!980 = !{!981, !982}
!981 = !DITemplateTypeParameter(name: "Parent", type: !322)
!982 = !DITemplateValueParameter(name: "Op", type: !44, value: i32 0)
!983 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op_common<aie::vector<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 358, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !984, templateParams: !1002, identifier: "_ZTSN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEE")
!984 = !{!985, !986, !994, !995, !996, !997, !998}
!985 = !DIDerivedType(tag: DW_TAG_member, name: "operation", scope: !983, file: !45, line: 421, baseType: !940, flags: DIFlagStaticMember, extraData: i32 0)
!986 = !DIDerivedType(tag: DW_TAG_member, name: "parent_", scope: !983, file: !45, line: 430, baseType: !987, size: 256, flags: DIFlagPrivate)
!987 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !988)
!988 = !DIDerivedType(tag: DW_TAG_typedef, name: "parent1_type", scope: !983, file: !45, line: 360, baseType: !989)
!989 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_remove_t<aie::vector<float, 8U> >", file: !945, line: 210, baseType: !990)
!990 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !991, file: !945, line: 187, baseType: !188)
!991 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_remove<aie::vector<float, 8U> >", file: !945, line: 185, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !992, identifier: "_ZTS22aie_dm_resource_removeIN3aie6vectorIfLj8EEEE")
!992 = !{!993}
!993 = !DITemplateTypeParameter(name: "T", type: !188)
!994 = !DISubprogram(name: "type_bits", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE9type_bitsEv", scope: !983, file: !45, line: 364, type: !214, scopeLine: 364, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!995 = !DISubprogram(name: "size", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE4sizeEv", scope: !983, file: !45, line: 372, type: !214, scopeLine: 372, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!996 = !DISubprogram(name: "bits", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE4bitsEv", scope: !983, file: !45, line: 380, type: !214, scopeLine: 380, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!997 = !DISubprogram(name: "is_operation_none", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE17is_operation_noneEv", scope: !983, file: !45, line: 407, type: !219, scopeLine: 407, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!998 = !DISubprogram(name: "unary_op_common", scope: !983, file: !45, line: 424, type: !999, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!999 = !DISubroutineType(types: !1000)
!1000 = !{null, !1001, !987}
!1001 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !983, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1002 = !{!1003, !982}
!1003 = !DITemplateTypeParameter(name: "Parent", type: !188)
!1004 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op<aie::vector<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 454, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1005, templateParams: !1002, identifier: "_ZTSN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEE")
!1005 = !{!1006, !1007}
!1006 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1004, baseType: !983, extraData: i32 0)
!1007 = !DISubprogram(name: "operator()", linkageName: "_ZNK3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEclEv", scope: !1004, file: !45, line: 454, type: !1008, scopeLine: 454, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1008 = !DISubroutineType(types: !1009)
!1009 = !{!1010, !1015}
!1010 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_type", scope: !1004, file: !45, line: 454, baseType: !1011)
!1011 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_result_type_t<parent1_type, Operation::None>", scope: !8, file: !45, line: 352, baseType: !1012)
!1012 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1013, file: !45, line: 312, baseType: !188)
!1013 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_result_helper<aie::vector<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 310, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !1014, identifier: "_ZTSN3aie16op_result_helperINS_6vectorIfLj8EEELNS_9OperationE0EEE")
!1014 = !{!993, !982}
!1015 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1016, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1016 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1004)
!1017 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 454, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1018, templateParams: !980, identifier: "_ZTSN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE")
!1018 = !{!1019, !1020}
!1019 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1017, baseType: !961, extraData: i32 0)
!1020 = !DISubprogram(name: "operator()", linkageName: "_ZNK3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEclEv", scope: !1017, file: !45, line: 454, type: !1021, scopeLine: 454, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1021 = !DISubroutineType(types: !1022)
!1022 = !{!1023, !1028}
!1023 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_type", scope: !1017, file: !45, line: 454, baseType: !1024)
!1024 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_result_type_t<parent1_type, Operation::None>", scope: !8, file: !45, line: 352, baseType: !1025)
!1025 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1026, file: !45, line: 312, baseType: !322)
!1026 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_result_helper<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>", scope: !8, file: !45, line: 310, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !1027, identifier: "_ZTSN3aie16op_result_helperINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE")
!1027 = !{!971, !982}
!1028 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1029, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1029 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1017)
!1030 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>", scope: !8, file: !45, line: 459, size: 256, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1031, templateParams: !958, identifier: "_ZTSN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEE")
!1031 = !{!1032, !1033}
!1032 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1030, baseType: !937, extraData: i32 0)
!1033 = !DISubprogram(name: "operator()", linkageName: "_ZNK3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEclEv", scope: !1030, file: !45, line: 459, type: !1034, scopeLine: 459, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1034 = !DISubroutineType(types: !1035)
!1035 = !{!1036, !1041}
!1036 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_type", scope: !1030, file: !45, line: 459, baseType: !1037)
!1037 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_result_type_t<parent1_type, Operation::Acc_Add>", scope: !8, file: !45, line: 352, baseType: !1038)
!1038 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1039, file: !45, line: 306, baseType: !374)
!1039 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_result_helper<aie::accum<accfloat, 8U>, (aie::Operation)1>", scope: !8, file: !45, line: 304, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !1040, identifier: "_ZTSN3aie16op_result_helperINS_5accumI8accfloatLj8EEELNS_9OperationE1EEE")
!1040 = !{!949, !960}
!1041 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1042, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1042 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1030)
!1043 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "matrix_vector_mul<float, float, 128U, 768U, 0U, 0U, 0U, 1U, 12U, 1U, 0U, 0U, 1U, 11U, true, false>", scope: !87, file: !86, line: 233, size: 32, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1044, templateParams: !1077, identifier: "_ZTSN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEE")
!1044 = !{!1045, !1046, !1047, !1051, !1054, !1068, !1071, !1074}
!1045 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1043, baseType: !85, flags: DIFlagPublic, extraData: i32 0)
!1046 = !DIDerivedType(tag: DW_TAG_member, name: "matrixASize", scope: !1043, file: !86, line: 266, baseType: !101, flags: DIFlagPublic | DIFlagStaticMember, extraData: i32 8192)
!1047 = !DISubprogram(name: "matrix_vector_mul", scope: !1043, file: !86, line: 268, type: !1048, scopeLine: 268, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1048 = !DISubroutineType(types: !1049)
!1049 = !{null, !1050}
!1050 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1043, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1051 = !DISubprogram(name: "registerKernelClass", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE19registerKernelClassEv", scope: !1043, file: !86, line: 270, type: !1052, scopeLine: 270, flags: DIFlagPublic | DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!1052 = !DISubroutineType(types: !1053)
!1053 = !{null}
!1054 = !DISubprogram(name: "matVecMulRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE12matVecMulRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEERNSA_IfNSB_3outESM_EE", scope: !1043, file: !86, line: 284, type: !1055, scopeLine: 284, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1055 = !DISubroutineType(types: !1056)
!1056 = !{null, !1050, !151, !1057, !1064}
!1057 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1058)
!1058 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1059, size: 32)
!1059 = !DIDerivedType(tag: DW_TAG_typedef, name: "input_buffer<float>", scope: !1061, file: !1060, line: 104, baseType: !1062)
!1060 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/io_buffer/io_buffer_types.h", directory: "")
!1061 = !DINamespace(name: "adf", scope: null)
!1062 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "io_buffer<float, adf::direction::in, adf::io_buffer_config<adf::extents<4294967295U>, adf::locking::sync, adf::addressing::linear, adf::margin<0U> > >", scope: !1061, file: !1063, line: 33, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEEE")
!1063 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/io_buffer/io_buffer_main.h", directory: "")
!1064 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1065)
!1065 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1066, size: 32)
!1066 = !DIDerivedType(tag: DW_TAG_typedef, name: "output_buffer<TT_OUT>", scope: !1061, file: !1060, line: 144, baseType: !1067)
!1067 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "io_buffer<float, adf::direction::out, adf::io_buffer_config<adf::extents<4294967295U>, adf::locking::sync, adf::addressing::linear, adf::margin<0U> > >", scope: !1061, file: !1063, line: 33, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEEE")
!1068 = !DISubprogram(name: "matVecMulFirstRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE17matVecMulFirstRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP14output_cascadeI8accfloatvE", scope: !1043, file: !86, line: 288, type: !1069, scopeLine: 288, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1069 = !DISubroutineType(types: !1070)
!1070 = !{null, !1050, !151, !1057, !144}
!1071 = !DISubprogram(name: "matVecMulMiddleRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE18matVecMulMiddleRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvEP14output_cascadeISQ_vE", scope: !1043, file: !86, line: 292, type: !1072, scopeLine: 292, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1072 = !DISubroutineType(types: !1073)
!1073 = !{null, !1050, !151, !1057, !124, !144}
!1074 = !DISubprogram(name: "matVecMulLastRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE", scope: !1043, file: !86, line: 297, type: !1075, scopeLine: 297, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1075 = !DISubroutineType(types: !1076)
!1076 = !{null, !1050, !151, !1057, !124, !1064}
!1077 = !{!161, !162, !163, !164, !165, !166, !167, !168, !169, !170, !1078, !1079, !173, !174, !175, !1080}
!1078 = !DITemplateValueParameter(name: "TP_API", type: !15, value: i32 0)
!1079 = !DITemplateValueParameter(name: "TP_DUAL_IP", type: !15, value: i32 0)
!1080 = !DITemplateValueParameter(name: "TP_CASC_OUT", type: !176, value: i1 false)
!1081 = !{!0, !1082}
!1082 = !DIGlobalVariableExpression(var: !1083, expr: !DIExpression(DW_OP_constu, 1, DW_OP_stack_value))
!1083 = distinct !DIGlobalVariable(name: "is_signed_v", scope: !7, file: !1084, line: 117, type: !198, isLocal: true, isDefinition: true, templateParams: !1085)
!1084 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/concepts.hpp", directory: "")
!1085 = !{!209}
!1086 = !{!1087, !1093, !1095, !1099, !1103, !1106, !1108, !1111, !1114, !1115, !1117, !1118, !1120, !1122, !1124, !1126, !1128, !1130, !1132, !1134, !1136, !1138, !1140, !1142, !1144, !1146, !1148, !1150, !1152, !1154, !1156, !1158, !1160, !1170, !1174, !1184, !1188, !1190, !1192, !1196, !1200, !1204, !1206, !1210, !1215, !1219, !1223, !1227, !1229, !1231, !1233, !1235, !1237, !1241, !1243, !1248, !1253, !1259, !1264, !1268, !1272, !1277, !1281, !1285, !1289, !1291, !1296, !1300, !1302, !1309, !1315, !1317, !1319, !1323, !1325, !1327, !1329, !1331, !1333, !1338, !1343, !1347, !1349, !1351, !1353, !1355, !1357, !1359, !1361, !1363, !1368, !1369, !1374, !1376, !1380, !1382, !1386, !1390, !1394, !1402, !1404, !1408, !1412, !1416, !1418, !1422, !1426, !1430, !1432, !1434, !1436, !1441, !1446, !1450, !1454, !1458, !1460, !1462, !1464, !1468, !1472, !1476, !1478, !1480, !1484, !1486, !1490, !1494, !1496, !1500, !1502, !1504, !1507, !1508}
!1087 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1090, file: !1092, line: 57)
!1088 = !DINamespace(name: "__2", scope: !1089, exportSymbols: true)
!1089 = !DINamespace(name: "std", scope: null)
!1090 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", file: !1091, line: 35, baseType: !9)
!1091 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/stddef.h", directory: "")
!1092 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstddef", directory: "")
!1093 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1094, file: !1092, line: 58)
!1094 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !1091, line: 46, baseType: !15)
!1095 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1096, file: !1092, line: 63)
!1096 = !DIDerivedType(tag: DW_TAG_typedef, name: "max_align_t", file: !1097, line: 24, baseType: !1098)
!1097 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/__stddef_max_align_t.h", directory: "")
!1098 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1097, line: 19, size: 128, flags: DIFlagFwdDecl, identifier: "_ZTS11max_align_t")
!1099 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1100, file: !1102, line: 161)
!1100 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !579, line: 24, baseType: !1101)
!1101 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!1102 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdint", directory: "")
!1103 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1104, file: !1102, line: 163)
!1104 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !579, line: 25, baseType: !1105)
!1105 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!1106 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1107, file: !1102, line: 164)
!1107 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !579, line: 26, baseType: !9)
!1108 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1109, file: !1102, line: 166)
!1109 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !579, line: 27, baseType: !1110)
!1110 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!1111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1112, file: !1102, line: 170)
!1112 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !579, line: 29, baseType: !1113)
!1113 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!1114 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !578, file: !1102, line: 172)
!1115 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1116, file: !1102, line: 173)
!1116 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !579, line: 31, baseType: !15)
!1117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !598, file: !1102, line: 175)
!1118 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1119, file: !1102, line: 178)
!1119 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !579, line: 35, baseType: !1101)
!1120 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1121, file: !1102, line: 179)
!1121 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !579, line: 36, baseType: !1105)
!1122 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1123, file: !1102, line: 180)
!1123 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !579, line: 37, baseType: !9)
!1124 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1125, file: !1102, line: 182)
!1125 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !579, line: 38, baseType: !1110)
!1126 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1127, file: !1102, line: 185)
!1127 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !579, line: 40, baseType: !1113)
!1128 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1129, file: !1102, line: 186)
!1129 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !579, line: 41, baseType: !580)
!1130 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1131, file: !1102, line: 187)
!1131 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !579, line: 42, baseType: !15)
!1132 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1133, file: !1102, line: 189)
!1133 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !579, line: 43, baseType: !599)
!1134 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1135, file: !1102, line: 192)
!1135 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !579, line: 46, baseType: !9)
!1136 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1137, file: !1102, line: 193)
!1137 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !579, line: 47, baseType: !9)
!1138 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1139, file: !1102, line: 194)
!1139 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !579, line: 48, baseType: !9)
!1140 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1141, file: !1102, line: 196)
!1141 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !579, line: 49, baseType: !1110)
!1142 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1143, file: !1102, line: 199)
!1143 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !579, line: 51, baseType: !15)
!1144 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1145, file: !1102, line: 200)
!1145 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !579, line: 52, baseType: !15)
!1146 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1147, file: !1102, line: 201)
!1147 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !579, line: 53, baseType: !15)
!1148 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1149, file: !1102, line: 203)
!1149 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !579, line: 54, baseType: !599)
!1150 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1151, file: !1102, line: 206)
!1151 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !579, line: 57, baseType: !9)
!1152 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1153, file: !1102, line: 207)
!1153 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !579, line: 58, baseType: !15)
!1154 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1155, file: !1102, line: 209)
!1155 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !579, line: 61, baseType: !9)
!1156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1157, file: !1102, line: 210)
!1157 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !579, line: 62, baseType: !15)
!1158 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1094, file: !1159, line: 76)
!1159 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstring", directory: "")
!1160 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1161, file: !1159, line: 77)
!1161 = !DISubprogram(name: "memcpy", scope: !1162, file: !1162, line: 28, type: !1163, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1162 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/string.h", directory: "")
!1163 = !DISubroutineType(types: !1164)
!1164 = !{!1165, !1166, !1167, !1094}
!1165 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 32)
!1166 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1165)
!1167 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1168)
!1168 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1169, size: 32)
!1169 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1170 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1171, file: !1159, line: 78)
!1171 = !DISubprogram(name: "memmove", scope: !1162, file: !1162, line: 29, type: !1172, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1172 = !DISubroutineType(types: !1173)
!1173 = !{!1165, !1165, !1168, !1094}
!1174 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1175, file: !1159, line: 79)
!1175 = !DISubprogram(name: "strcpy", scope: !1162, file: !1162, line: 30, type: !1176, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1176 = !DISubroutineType(types: !1177)
!1177 = !{!1178, !1180, !1181}
!1178 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1179, size: 32)
!1179 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!1180 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1178)
!1181 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1182)
!1182 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1183, size: 32)
!1183 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1179)
!1184 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1185, file: !1159, line: 80)
!1185 = !DISubprogram(name: "strncpy", scope: !1162, file: !1162, line: 31, type: !1186, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1186 = !DISubroutineType(types: !1187)
!1187 = !{!1178, !1180, !1181, !1094}
!1188 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1189, file: !1159, line: 81)
!1189 = !DISubprogram(name: "strcat", scope: !1162, file: !1162, line: 34, type: !1176, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1190 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1191, file: !1159, line: 82)
!1191 = !DISubprogram(name: "strncat", scope: !1162, file: !1162, line: 35, type: !1186, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1192 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1193, file: !1159, line: 83)
!1193 = !DISubprogram(name: "memcmp", scope: !1162, file: !1162, line: 38, type: !1194, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1194 = !DISubroutineType(types: !1195)
!1195 = !{!9, !1168, !1168, !1094}
!1196 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1197, file: !1159, line: 84)
!1197 = !DISubprogram(name: "strcmp", scope: !1162, file: !1162, line: 39, type: !1198, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1198 = !DISubroutineType(types: !1199)
!1199 = !{!9, !1182, !1182}
!1200 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1201, file: !1159, line: 85)
!1201 = !DISubprogram(name: "strncmp", scope: !1162, file: !1162, line: 41, type: !1202, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1202 = !DISubroutineType(types: !1203)
!1203 = !{!9, !1182, !1182, !1094}
!1204 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1205, file: !1159, line: 86)
!1205 = !DISubprogram(name: "strcoll", scope: !1162, file: !1162, line: 40, type: !1198, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1206 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1207, file: !1159, line: 87)
!1207 = !DISubprogram(name: "strxfrm", scope: !1162, file: !1162, line: 42, type: !1208, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1208 = !DISubroutineType(types: !1209)
!1209 = !{!1094, !1180, !1181, !1094}
!1210 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1211, file: !1159, line: 88)
!1211 = !DISubprogram(name: "memchr", linkageName: "_Z6memchrUa9enable_ifILb1EEPvij", scope: !1212, file: !1212, line: 107, type: !1213, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1212 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/string.h", directory: "")
!1213 = !DISubroutineType(types: !1214)
!1214 = !{!1165, !1165, !9, !1094}
!1215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1216, file: !1159, line: 89)
!1216 = !DISubprogram(name: "strchr", linkageName: "_Z6strchrUa9enable_ifILb1EEPci", scope: !1212, file: !1212, line: 86, type: !1217, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1217 = !DISubroutineType(types: !1218)
!1218 = !{!1178, !1178, !9}
!1219 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1220, file: !1159, line: 90)
!1220 = !DISubprogram(name: "strcspn", scope: !1162, file: !1162, line: 47, type: !1221, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1221 = !DISubroutineType(types: !1222)
!1222 = !{!1094, !1182, !1182}
!1223 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1224, file: !1159, line: 91)
!1224 = !DISubprogram(name: "strpbrk", linkageName: "_Z7strpbrkUa9enable_ifILb1EEPcPKc", scope: !1212, file: !1212, line: 93, type: !1225, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1225 = !DISubroutineType(types: !1226)
!1226 = !{!1178, !1178, !1182}
!1227 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1228, file: !1159, line: 92)
!1228 = !DISubprogram(name: "strrchr", linkageName: "_Z7strrchrUa9enable_ifILb1EEPci", scope: !1212, file: !1212, line: 100, type: !1217, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1229 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1230, file: !1159, line: 93)
!1230 = !DISubprogram(name: "strspn", scope: !1162, file: !1162, line: 50, type: !1221, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1231 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1232, file: !1159, line: 94)
!1232 = !DISubprogram(name: "strstr", linkageName: "_Z6strstrUa9enable_ifILb1EEPcPKc", scope: !1212, file: !1212, line: 114, type: !1225, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1233 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1234, file: !1159, line: 96)
!1234 = !DISubprogram(name: "strtok", scope: !1162, file: !1162, line: 52, type: !1176, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1235 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1236, file: !1159, line: 98)
!1236 = !DISubprogram(name: "memset", scope: !1162, file: !1162, line: 55, type: !1213, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1237 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1238, file: !1159, line: 102)
!1238 = !DISubprogram(name: "strlen", scope: !1162, file: !1162, line: 57, type: !1239, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1239 = !DISubroutineType(types: !1240)
!1240 = !{!1094, !1182}
!1241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1094, file: !1242, line: 107)
!1242 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdlib", directory: "")
!1243 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1244, file: !1242, line: 118)
!1244 = !DISubprogram(name: "atoi", scope: !1245, file: !1245, line: 38, type: !1246, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1245 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdlib.h", directory: "")
!1246 = !DISubroutineType(types: !1247)
!1247 = !{!9, !1182}
!1248 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1249, file: !1242, line: 119)
!1249 = !DISubprogram(name: "atol", scope: !1245, file: !1245, line: 43, type: !1250, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1250 = !DISubroutineType(types: !1251)
!1251 = !{!1252, !1182}
!1252 = !DIBasicType(name: "long", size: 32, encoding: DW_ATE_signed)
!1253 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1254, file: !1242, line: 128)
!1254 = !DISubprogram(name: "strtol", scope: !1245, file: !1245, line: 30, type: !1255, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1255 = !DISubroutineType(types: !1256)
!1256 = !{!1252, !1181, !1257, !9}
!1257 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1258)
!1258 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1178, size: 32)
!1259 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1260, file: !1242, line: 134)
!1260 = !DISubprogram(name: "strtoul", scope: !1245, file: !1245, line: 34, type: !1261, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1261 = !DISubroutineType(types: !1262)
!1262 = !{!1263, !1181, !1257, !9}
!1263 = !DIBasicType(name: "unsigned long", size: 32, encoding: DW_ATE_unsigned)
!1264 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1265, file: !1242, line: 140)
!1265 = !DISubprogram(name: "rand", scope: !1245, file: !1245, line: 52, type: !1266, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1266 = !DISubroutineType(types: !1267)
!1267 = !{!9}
!1268 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1269, file: !1242, line: 141)
!1269 = !DISubprogram(name: "srand", scope: !1245, file: !1245, line: 53, type: !1270, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1270 = !DISubroutineType(types: !1271)
!1271 = !{null, !15}
!1272 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1273, file: !1242, line: 142)
!1273 = !DISubprogram(name: "calloc", scope: !1274, file: !1274, line: 33, type: !1275, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1274 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/malloc.h", directory: "")
!1275 = !DISubroutineType(types: !1276)
!1276 = !{!1165, !1094, !1094}
!1277 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1278, file: !1242, line: 143)
!1278 = !DISubprogram(name: "free", scope: !1274, file: !1274, line: 31, type: !1279, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1279 = !DISubroutineType(types: !1280)
!1280 = !{null, !1165}
!1281 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1282, file: !1242, line: 144)
!1282 = !DISubprogram(name: "malloc", scope: !1274, file: !1274, line: 29, type: !1283, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1283 = !DISubroutineType(types: !1284)
!1284 = !{!1165, !1094}
!1285 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1286, file: !1242, line: 145)
!1286 = !DISubprogram(name: "realloc", scope: !1274, file: !1274, line: 35, type: !1287, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1287 = !DISubroutineType(types: !1288)
!1288 = !{!1165, !1165, !1094}
!1289 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1290, file: !1242, line: 146)
!1290 = !DISubprogram(name: "abort", scope: !1245, file: !1245, line: 91, type: !1052, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1291 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1292, file: !1242, line: 147)
!1292 = !DISubprogram(name: "atexit", scope: !1245, file: !1245, line: 98, type: !1293, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1293 = !DISubroutineType(types: !1294)
!1294 = !{!9, !1295}
!1295 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1052, size: 32, dwarfAddressSpace: 61)
!1296 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1297, file: !1242, line: 148)
!1297 = !DISubprogram(name: "exit", scope: !1245, file: !1245, line: 83, type: !1298, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1298 = !DISubroutineType(types: !1299)
!1299 = !{null, !9}
!1300 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1301, file: !1242, line: 149)
!1301 = !DISubprogram(name: "_Exit", scope: !1245, file: !1245, line: 96, type: !1298, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1302 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1303, file: !1242, line: 157)
!1303 = !DISubprogram(name: "qsort", scope: !1245, file: !1245, line: 104, type: !1304, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1304 = !DISubroutineType(types: !1305)
!1305 = !{null, !1165, !1094, !1094, !1306}
!1306 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1307, size: 32, dwarfAddressSpace: 61)
!1307 = !DISubroutineType(types: !1308)
!1308 = !{!9, !1168, !1168}
!1309 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1310, file: !1314, line: 351)
!1310 = !DISubprogram(name: "acosf", scope: !1311, file: !1311, line: 93, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1311 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/math.h", directory: "")
!1312 = !DISubroutineType(types: !1313)
!1313 = !{!80, !80}
!1314 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cmath", directory: "")
!1315 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1316, file: !1314, line: 353)
!1316 = !DISubprogram(name: "asinf", scope: !1311, file: !1311, line: 95, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1317 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1318, file: !1314, line: 355)
!1318 = !DISubprogram(name: "atanf", scope: !1311, file: !1311, line: 101, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1319 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1320, file: !1314, line: 357)
!1320 = !DISubprogram(name: "atan2f", scope: !1311, file: !1311, line: 98, type: !1321, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1321 = !DISubroutineType(types: !1322)
!1322 = !{!80, !80, !80}
!1323 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1324, file: !1314, line: 359)
!1324 = !DISubprogram(name: "ceilf", scope: !1311, file: !1311, line: 68, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1325 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1326, file: !1314, line: 361)
!1326 = !DISubprogram(name: "cosf", scope: !1311, file: !1311, line: 74, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1327 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1328, file: !1314, line: 368)
!1328 = !DISubprogram(name: "expf", scope: !1311, file: !1311, line: 78, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1329 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1330, file: !1314, line: 371)
!1330 = !DISubprogram(name: "fabsf", scope: !1311, file: !1311, line: 31, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1331 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1332, file: !1314, line: 373)
!1332 = !DISubprogram(name: "floorf", scope: !1311, file: !1311, line: 70, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1333 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1334, file: !1314, line: 375)
!1334 = !DISubprogram(name: "fmod", scope: !1311, file: !1311, line: 92, type: !1335, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1335 = !DISubroutineType(types: !1336)
!1336 = !{!1337, !1337, !1337}
!1337 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!1338 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1339, file: !1314, line: 381)
!1339 = !DISubprogram(name: "frexpf", scope: !1311, file: !1311, line: 108, type: !1340, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1340 = !DISubroutineType(types: !1341)
!1341 = !{!80, !80, !1342}
!1342 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 32)
!1343 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1344, file: !1314, line: 383)
!1344 = !DISubprogram(name: "ldexpf", scope: !1311, file: !1311, line: 66, type: !1345, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1345 = !DISubroutineType(types: !1346)
!1346 = !{!80, !80, !9}
!1347 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1348, file: !1314, line: 386)
!1348 = !DISubprogram(name: "logf", scope: !1311, file: !1311, line: 80, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1349 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1350, file: !1314, line: 389)
!1350 = !DISubprogram(name: "log10f", scope: !1311, file: !1311, line: 82, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1351 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1352, file: !1314, line: 396)
!1352 = !DISubprogram(name: "powf", scope: !1311, file: !1311, line: 90, type: !1321, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1353 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1354, file: !1314, line: 399)
!1354 = !DISubprogram(name: "sinf", scope: !1311, file: !1311, line: 76, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1355 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1356, file: !1314, line: 406)
!1356 = !DISubprogram(name: "sqrtf", scope: !1311, file: !1311, line: 85, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1357 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1358, file: !1314, line: 427)
!1358 = !DISubprogram(name: "copysignf", scope: !1311, file: !1311, line: 36, type: !1321, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1359 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1360, file: !1314, line: 484)
!1360 = !DISubprogram(name: "roundf", scope: !1311, file: !1311, line: 72, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1361 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1362, file: !1314, line: 494)
!1362 = !DISubprogram(name: "truncf", scope: !1311, file: !1311, line: 104, type: !1312, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1363 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1364, file: !1367, line: 115)
!1364 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !1365, line: 31, baseType: !1366)
!1365 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdio.h", directory: "")
!1366 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "FILE", file: !1365, line: 30, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS4FILE")
!1367 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdio", directory: "")
!1368 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1094, file: !1367, line: 119)
!1369 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1370, file: !1367, line: 121)
!1370 = !DISubprogram(name: "fclose", scope: !1365, file: !1365, line: 78, type: !1371, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1371 = !DISubroutineType(types: !1372)
!1372 = !{!9, !1373}
!1373 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1364, size: 32)
!1374 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1375, file: !1367, line: 122)
!1375 = !DISubprogram(name: "fflush", scope: !1365, file: !1365, line: 79, type: !1371, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1376 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1377, file: !1367, line: 127)
!1377 = !DISubprogram(name: "fprintf", scope: !1365, file: !1365, line: 88, type: !1378, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1378 = !DISubroutineType(types: !1379)
!1379 = !{!9, !1373, !1182, null}
!1380 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1381, file: !1367, line: 128)
!1381 = !DISubprogram(name: "fscanf", scope: !1365, file: !1365, line: 93, type: !1378, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1382 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1383, file: !1367, line: 129)
!1383 = !DISubprogram(name: "snprintf", scope: !1365, file: !1365, line: 97, type: !1384, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1384 = !DISubroutineType(types: !1385)
!1385 = !{!9, !1178, !1094, !1182, null}
!1386 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1387, file: !1367, line: 130)
!1387 = !DISubprogram(name: "sprintf", scope: !1365, file: !1365, line: 96, type: !1388, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1388 = !DISubroutineType(types: !1389)
!1389 = !{!9, !1178, !1182, null}
!1390 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1391, file: !1367, line: 131)
!1391 = !DISubprogram(name: "sscanf", scope: !1365, file: !1365, line: 101, type: !1392, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1392 = !DISubroutineType(types: !1393)
!1393 = !{!9, !1182, !1182, null}
!1394 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1395, file: !1367, line: 132)
!1395 = !DISubprogram(name: "vfprintf", scope: !1365, file: !1365, line: 86, type: !1396, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1396 = !DISubroutineType(types: !1397)
!1397 = !{!9, !1373, !1182, !1398}
!1398 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1399, line: 22, baseType: !1400)
!1399 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/stdarg.h", directory: "")
!1400 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !1401, baseType: !1178)
!1401 = !DIFile(filename: "i0_wrap_matrix_vector_mul.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir")
!1402 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1403, file: !1367, line: 133)
!1403 = !DISubprogram(name: "vfscanf", scope: !1365, file: !1365, line: 91, type: !1396, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1404 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1405, file: !1367, line: 134)
!1405 = !DISubprogram(name: "vsscanf", scope: !1365, file: !1365, line: 102, type: !1406, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1406 = !DISubroutineType(types: !1407)
!1407 = !{!9, !1182, !1182, !1398}
!1408 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1409, file: !1367, line: 135)
!1409 = !DISubprogram(name: "vsnprintf", scope: !1365, file: !1365, line: 99, type: !1410, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1410 = !DISubroutineType(types: !1411)
!1411 = !{!9, !1178, !1094, !1182, !1398}
!1412 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1413, file: !1367, line: 136)
!1413 = !DISubprogram(name: "vsprintf", scope: !1365, file: !1365, line: 98, type: !1414, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1414 = !DISubroutineType(types: !1415)
!1415 = !{!9, !1178, !1182, !1398}
!1416 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1417, file: !1367, line: 137)
!1417 = !DISubprogram(name: "fgetc", scope: !1365, file: !1365, line: 113, type: !1371, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1418 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1419, file: !1367, line: 138)
!1419 = !DISubprogram(name: "fgets", scope: !1365, file: !1365, line: 116, type: !1420, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1420 = !DISubroutineType(types: !1421)
!1421 = !{!1178, !1178, !9, !1373}
!1422 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1423, file: !1367, line: 139)
!1423 = !DISubprogram(name: "fputc", scope: !1365, file: !1365, line: 107, type: !1424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1424 = !DISubroutineType(types: !1425)
!1425 = !{!9, !9, !1373}
!1426 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1427, file: !1367, line: 140)
!1427 = !DISubprogram(name: "fputs", scope: !1365, file: !1365, line: 110, type: !1428, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1428 = !DISubroutineType(types: !1429)
!1429 = !{!9, !1182, !1373}
!1430 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1431, file: !1367, line: 141)
!1431 = !DISubprogram(name: "getc", scope: !1365, file: !1365, line: 187, type: !1371, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1432 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1433, file: !1367, line: 142)
!1433 = !DISubprogram(name: "putc", scope: !1365, file: !1365, line: 169, type: !1424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1434 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1435, file: !1367, line: 143)
!1435 = !DISubprogram(name: "ungetc", scope: !1365, file: !1365, line: 119, type: !1424, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1436 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1437, file: !1367, line: 144)
!1437 = !DISubprogram(name: "fread", scope: !1365, file: !1365, line: 126, type: !1438, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1438 = !DISubroutineType(types: !1439)
!1439 = !{!1094, !1440, !1094, !1094, !1373}
!1440 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 32, dwarfAddressSpace: 12)
!1441 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1442, file: !1367, line: 145)
!1442 = !DISubprogram(name: "fwrite", scope: !1365, file: !1365, line: 124, type: !1443, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1443 = !DISubroutineType(types: !1444)
!1444 = !{!1094, !1445, !1094, !1094, !1373}
!1445 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1169, size: 32, dwarfAddressSpace: 12)
!1446 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1447, file: !1367, line: 149)
!1447 = !DISubprogram(name: "fseek", scope: !1365, file: !1365, line: 139, type: !1448, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1448 = !DISubroutineType(types: !1449)
!1449 = !{!9, !1373, !1252, !9}
!1450 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1451, file: !1367, line: 153)
!1451 = !DISubprogram(name: "ftell", scope: !1365, file: !1365, line: 141, type: !1452, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1452 = !DISubroutineType(types: !1453)
!1453 = !{!1252, !1373}
!1454 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1455, file: !1367, line: 154)
!1455 = !DISubprogram(name: "rewind", scope: !1365, file: !1365, line: 164, type: !1456, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1456 = !DISubroutineType(types: !1457)
!1457 = !{null, !1373}
!1458 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1459, file: !1367, line: 155)
!1459 = !DISubprogram(name: "clearerr", scope: !1365, file: !1365, line: 148, type: !1456, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1460 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1461, file: !1367, line: 156)
!1461 = !DISubprogram(name: "feof", scope: !1365, file: !1365, line: 146, type: !1371, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1462 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1463, file: !1367, line: 157)
!1463 = !DISubprogram(name: "ferror", scope: !1365, file: !1365, line: 147, type: !1371, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1464 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1465, file: !1367, line: 158)
!1465 = !DISubprogram(name: "perror", scope: !1365, file: !1365, line: 149, type: !1466, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1466 = !DISubroutineType(types: !1467)
!1467 = !{null, !1182}
!1468 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1469, file: !1367, line: 161)
!1469 = !DISubprogram(name: "fopen", scope: !1365, file: !1365, line: 77, type: !1470, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1470 = !DISubroutineType(types: !1471)
!1471 = !{!1373, !1182, !1182}
!1472 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1473, file: !1367, line: 162)
!1473 = !DISubprogram(name: "freopen", scope: !1365, file: !1365, line: 81, type: !1474, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1474 = !DISubroutineType(types: !1475)
!1475 = !{!1373, !1182, !1182, !1373}
!1476 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1477, file: !1367, line: 163)
!1477 = !DISubprogram(name: "remove", scope: !1365, file: !1365, line: 67, type: !1246, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1478 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1479, file: !1367, line: 164)
!1479 = !DISubprogram(name: "rename", scope: !1365, file: !1365, line: 68, type: !1198, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1480 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1481, file: !1367, line: 165)
!1481 = !DISubprogram(name: "tmpfile", scope: !1365, file: !1365, line: 69, type: !1482, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1482 = !DISubroutineType(types: !1483)
!1483 = !{!1373}
!1484 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1485, file: !1367, line: 172)
!1485 = !DISubprogram(name: "getchar", scope: !1365, file: !1365, line: 192, type: !1266, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1486 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1487, file: !1367, line: 176)
!1487 = !DISubprogram(name: "scanf", scope: !1365, file: !1365, line: 94, type: !1488, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1488 = !DISubroutineType(types: !1489)
!1489 = !{!9, !1182, null}
!1490 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1491, file: !1367, line: 177)
!1491 = !DISubprogram(name: "vscanf", scope: !1365, file: !1365, line: 159, type: !1492, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1492 = !DISubroutineType(types: !1493)
!1493 = !{!9, !1182, !1398}
!1494 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1495, file: !1367, line: 181)
!1495 = !DISubprogram(name: "printf", scope: !1365, file: !1365, line: 89, type: !1488, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1496 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1497, file: !1367, line: 182)
!1497 = !DISubprogram(name: "putchar", scope: !1365, file: !1365, line: 174, type: !1498, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1498 = !DISubroutineType(types: !1499)
!1499 = !{!9, !9}
!1500 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1501, file: !1367, line: 183)
!1501 = !DISubprogram(name: "puts", scope: !1365, file: !1365, line: 179, type: !1246, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1502 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !1088, entity: !1503, file: !1367, line: 184)
!1503 = !DISubprogram(name: "vprintf", scope: !1365, file: !1365, line: 154, type: !1492, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1504 = !DIImportedEntity(tag: DW_TAG_imported_declaration, name: "Utils", scope: !8, entity: !1505, file: !1506, line: 89)
!1505 = !DINamespace(name: "utils", scope: !7)
!1506 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/adf/../aie.hpp", directory: "")
!1507 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !5, file: !1506, line: 6158)
!1508 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !2, entity: !1061, file: !1509, line: 32)
!1509 = !DIFile(filename: "dsp_lib/L1/include/aie/fir_utils.hpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!1510 = !{!"SCD"}
!1511 = !{!"crF2FMask"}
!1512 = !{!"crFPMask"}
!1513 = !{i32 0, i8 undef}
!1514 = !{i32 2, i8 undef}
!1515 = !{i32 3, i8 undef}
!1516 = !{i32 4, i8 undef}
!1517 = !{i32 5, i8 undef}
!1518 = !{i32 6, i8 undef}
!1519 = !{i32 7, i8 undef}
!1520 = !{i32 8, i8 undef}
!1521 = !{i32 9, i8 undef}
!1522 = !{i32 10, i8 undef}
!1523 = !{i32 11, i8 undef}
!1524 = !{i32 12, i8 undef}
!1525 = !{i32 13, i8 undef}
!1526 = !{i32 14, i8 undef}
!1527 = !{i32 7, !"Dwarf Version", i32 4}
!1528 = !{i32 2, !"Debug Info Version", i32 3}
!1529 = !{i32 1, !"wchar_size", i32 4}
!1530 = !{i32 7, !"frame-pointer", i32 2}
!1531 = !{!"clang version 16.0.3 (/u/sgasip/ipd/repositories/llvm_ipd 6a0b186d7c0e25173296a8e19f630e71bd7e8ed9)"}
!1532 = distinct !DISubprogram(name: "matVecMulLastRtp", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE", scope: !1043, file: !83, line: 700, type: !1075, scopeLine: 703, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1074, retainedNodes: !1533)
!1533 = !{!1534, !1536, !1537, !1538, !1539, !1540, !1541}
!1534 = !DILocalVariable(name: "this", arg: 1, scope: !1532, type: !1535, flags: DIFlagArtificial | DIFlagObjectPointer)
!1535 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1043, size: 32)
!1536 = !DILocalVariable(name: "inMatrixA", arg: 2, scope: !1532, file: !86, line: 297, type: !151)
!1537 = !DILocalVariable(name: "inWindowB", arg: 3, scope: !1532, file: !86, line: 298, type: !1057)
!1538 = !DILocalVariable(name: "inCascade", arg: 4, scope: !1532, file: !86, line: 299, type: !124)
!1539 = !DILocalVariable(name: "outWindow", arg: 5, scope: !1532, file: !86, line: 300, type: !1064)
!1540 = !DILocalVariable(name: "inInterface", scope: !1532, file: !83, line: 704, type: !112)
!1541 = !DILocalVariable(name: "outInterface", scope: !1532, file: !83, line: 705, type: !129)
!1542 = !{!1543}
!1543 = distinct !{!1543, !1544, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE: unknown scope"}
!1544 = distinct !{!1544, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE"}
!1545 = !{!1546, !1546, i64 0, i64 4}
!1546 = !{!1547, i64 4, !"any pointer"}
!1547 = !{!1548, i64 1, !"omnipotent char"}
!1548 = !{!"Simple C++ TBAA"}
!1549 = !{!1550, !1551, !1552, !1553, !1543}
!1550 = distinct !{!1550, !1544, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE: inWindowB"}
!1551 = distinct !{!1551, !1544, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE: outWindow"}
!1552 = distinct !{!1552, !1544, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE: inInterface"}
!1553 = distinct !{!1553, !1544, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE16matVecMulLastRtpERA8192_KfRN3adf9io_bufferIfNS9_9direction2inENS9_16io_buffer_configINS9_7extentsIJLj4294967295EEEENS9_7locking4syncENS9_10addressing6linearENS9_6marginILj0EEEEEEEP13input_cascadeI8accfloatvERNSA_IfNSB_3outESM_EE: outInterface"}
!1554 = !DILocation(line: 0, scope: !1532)
!1555 = !DILocation(line: 297, column: 45, scope: !1532)
!1556 = !{!1550}
!1557 = !DILocation(line: 298, column: 63, scope: !1532)
!1558 = !DILocation(line: 299, column: 76, scope: !1532)
!1559 = !{!1551}
!1560 = !DILocation(line: 300, column: 61, scope: !1532)
!1561 = !DILocation(line: 704, column: 5, scope: !1532)
!1562 = !DILocation(line: 704, column: 37, scope: !1532)
!1563 = !{!1552}
!1564 = !DILocation(line: 705, column: 5, scope: !1532)
!1565 = !DILocation(line: 705, column: 38, scope: !1532)
!1566 = !{!1553}
!1567 = !DILocation(line: 707, column: 29, scope: !1532)
!1568 = !DILocation(line: 707, column: 39, scope: !1532)
!1569 = !DILocation(line: 707, column: 17, scope: !1532)
!1570 = !DILocation(line: 707, column: 27, scope: !1532)
!1571 = !{!1572, !1546, i64 4, i64 4}
!1572 = !{!1547, i64 20, !"_ZTSN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEE", !1546, i64 0, i64 4, !1546, i64 4, i64 4, !1546, i64 8, i64 4, !1546, i64 12, i64 4, !1546, i64 16, i64 4}
!1573 = !DILocation(line: 708, column: 29, scope: !1532)
!1574 = !DILocation(line: 708, column: 17, scope: !1532)
!1575 = !DILocation(line: 708, column: 27, scope: !1532)
!1576 = !{!1572, !1546, i64 16, i64 4}
!1577 = !DILocation(line: 709, column: 30, scope: !1532)
!1578 = !DILocation(line: 709, column: 40, scope: !1532)
!1579 = !DILocation(line: 709, column: 18, scope: !1532)
!1580 = !DILocation(line: 709, column: 28, scope: !1532)
!1581 = !{!1582, !1546, i64 0, i64 4}
!1582 = !{!1547, i64 16, !"_ZTSN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEE", !1546, i64 0, i64 4, !1546, i64 4, i64 4, !1546, i64 8, i64 4, !1546, i64 12, i64 4}
!1583 = !DILocation(line: 711, column: 39, scope: !1532)
!1584 = !DILocation(line: 711, column: 11, scope: !1532)
!1585 = !DILocation(line: 711, column: 25, scope: !1532)
!1586 = !{!1587, !1546, i64 0, i64 4}
!1587 = !{!1547, i64 4, !"_ZTSN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEE", !1546, i64 0, i64 4}
!1588 = !{i64 20, i64 0, i64 4, i64 4}
!1589 = !DILocation(line: 712, column: 27, scope: !1532)
!1590 = !{!1572, !1572, i64 0, i64 20}
!1591 = !{i64 16, i64 0, i64 4, i64 3}
!1592 = !DILocation(line: 712, column: 40, scope: !1532)
!1593 = !{!1582, !1582, i64 0, i64 16}
!1594 = !DILocation(line: 712, column: 11, scope: !1532)
!1595 = !DILocation(line: 713, column: 1, scope: !1532)
!1596 = distinct !DISubprogram(name: "T_inputIF", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul9T_inputIFIffEC2Ev", scope: !112, file: !113, line: 305, type: !1597, scopeLine: 305, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1600, retainedNodes: !1601)
!1597 = !DISubroutineType(types: !1598)
!1598 = !{null, !1599}
!1599 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1600 = !DISubprogram(name: "T_inputIF", scope: !112, type: !1597, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1601 = !{!1602}
!1602 = !DILocalVariable(name: "this", arg: 1, scope: !1596, type: !1603, flags: DIFlagArtificial | DIFlagObjectPointer)
!1603 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 32)
!1604 = !DILocation(line: 0, scope: !1596)
!1605 = !DILocation(line: 310, column: 42, scope: !1596)
!1606 = !DILocation(line: 305, column: 8, scope: !1596)
!1607 = distinct !DISubprogram(name: "T_outputIF", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul10T_outputIFIffEC2Ev", scope: !129, file: !113, line: 314, type: !1608, scopeLine: 314, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1611, retainedNodes: !1612)
!1608 = !DISubroutineType(types: !1609)
!1609 = !{null, !1610}
!1610 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1611 = !DISubprogram(name: "T_outputIF", scope: !129, type: !1608, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1612 = !{!1613}
!1613 = !DILocalVariable(name: "this", arg: 1, scope: !1607, type: !1614, flags: DIFlagArtificial | DIFlagObjectPointer)
!1614 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 32)
!1615 = !DILocation(line: 0, scope: !1607)
!1616 = !DILocation(line: 318, column: 43, scope: !1607)
!1617 = !{!1582, !1546, i64 12, i64 4}
!1618 = !DILocation(line: 314, column: 8, scope: !1607)
!1619 = distinct !DISubprogram(name: "data", linkageName: "_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv", scope: !1062, file: !1063, line: 122, type: !1620, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1627, retainedNodes: !1628)
!1620 = !DISubroutineType(types: !1621)
!1621 = !{!1622, !1625}
!1622 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1623)
!1623 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1624, size: 32)
!1624 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !1062, file: !1063, line: 47, baseType: !80, flags: DIFlagPublic)
!1625 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1626, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1626 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1062)
!1627 = !DISubprogram(name: "data", linkageName: "_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv", scope: !1062, file: !1063, line: 122, type: !1620, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1628 = !{!1629}
!1629 = !DILocalVariable(name: "this", arg: 1, scope: !1619, type: !1630, flags: DIFlagArtificial | DIFlagObjectPointer)
!1630 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1626, size: 32)
!1631 = !{!1632}
!1632 = distinct !{!1632, !1633, !"_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv: unknown scope"}
!1633 = distinct !{!1633, !"_ZNK3adf9io_bufferIfNS_9direction2inENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv"}
!1634 = !DILocation(line: 0, scope: !1619)
!1635 = !DILocation(line: 125, column: 26, scope: !1636)
!1636 = distinct !DILexicalBlock(scope: !1619, file: !1063, line: 124, column: 23)
!1637 = !{!1638, !1546, i64 0, i64 4}
!1638 = !{!1547, i64 4, !"_ZTSN3adf6detail14io_buffer_baseIfNS_7locking4syncEEE", !1546, i64 0, i64 4}
!1639 = !DILocation(line: 125, column: 13, scope: !1636)
!1640 = distinct !DISubprogram(name: "data", linkageName: "_ZNK3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv", scope: !1067, file: !1063, line: 122, type: !1641, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1648, retainedNodes: !1649)
!1641 = !DISubroutineType(types: !1642)
!1642 = !{!1643, !1646}
!1643 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1644)
!1644 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1645, size: 32)
!1645 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !1067, file: !1063, line: 47, baseType: !80, flags: DIFlagPublic)
!1646 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1647, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!1647 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1067)
!1648 = !DISubprogram(name: "data", linkageName: "_ZNK3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv", scope: !1067, file: !1063, line: 122, type: !1641, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1649 = !{!1650}
!1650 = !DILocalVariable(name: "this", arg: 1, scope: !1640, type: !1651, flags: DIFlagArtificial | DIFlagObjectPointer)
!1651 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1647, size: 32)
!1652 = !{!1653}
!1653 = distinct !{!1653, !1654, !"_ZNK3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv: unknown scope"}
!1654 = distinct !{!1654, !"_ZNK3adf9io_bufferIfNS_9direction3outENS_16io_buffer_configINS_7extentsIJLj4294967295EEEENS_7locking4syncENS_10addressing6linearENS_6marginILj0EEEEEE4dataEv"}
!1655 = !DILocation(line: 0, scope: !1640)
!1656 = !DILocation(line: 125, column: 26, scope: !1657)
!1657 = distinct !DILexicalBlock(scope: !1640, file: !1063, line: 124, column: 23)
!1658 = !DILocation(line: 125, column: 13, scope: !1657)
!1659 = distinct !DISubprogram(name: "matVecMulKernel", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !83, line: 78, type: !109, scopeLine: 79, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !159, retainedNodes: !1660)
!1660 = !{!1661, !1662, !1663}
!1661 = !DILocalVariable(name: "this", arg: 1, scope: !1659, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!1662 = !DILocalVariable(name: "inInterface", arg: 2, scope: !1659, file: !86, line: 140, type: !112)
!1663 = !DILocalVariable(name: "outInterface", arg: 3, scope: !1659, file: !86, line: 140, type: !129)
!1664 = !{!1665}
!1665 = distinct !{!1665, !1666, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: unknown scope"}
!1666 = distinct !{!1666, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE"}
!1667 = !{!1668, !1665}
!1668 = distinct !{!1668, !1666, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE15matVecMulKernelENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outInterface"}
!1669 = !DILocation(line: 0, scope: !1659)
!1670 = !DILocation(line: 140, column: 58, scope: !1659)
!1671 = !{!1668}
!1672 = !DILocation(line: 140, column: 104, scope: !1659)
!1673 = !DILocation(line: 81, column: 25, scope: !1659)
!1674 = !DILocation(line: 81, column: 38, scope: !1659)
!1675 = !DILocation(line: 81, column: 5, scope: !1659)
!1676 = !DILocation(line: 82, column: 1, scope: !1659)
!1677 = distinct !DISubprogram(name: "__cxx_global_var_init", scope: !1401, file: !1401, type: !1052, flags: DIFlagArtificial | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!1678 = !DILocation(line: 7, column: 127, scope: !1677)
!1679 = distinct !DISubprogram(name: "matrix_vector_mul", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul17matrix_vector_mulIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEC2Ev", scope: !1043, file: !86, line: 268, type: !1048, scopeLine: 268, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !1047, retainedNodes: !1680)
!1680 = !{!1681}
!1681 = !DILocalVariable(name: "this", arg: 1, scope: !1679, type: !1535, flags: DIFlagArtificial | DIFlagObjectPointer)
!1682 = !DILocation(line: 0, scope: !1679)
!1683 = !DILocation(line: 268, column: 5, scope: !1679)
!1684 = !DILocation(line: 268, column: 25, scope: !1679)
!1685 = distinct !DISubprogram(name: "i0_user", linkageName: "_Z7i0_userv", scope: !1401, file: !1401, line: 8, type: !1686, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!1686 = !DISubroutineType(types: !1687)
!1687 = !{!1165}
!1688 = !DILocation(line: 8, column: 18, scope: !1685)
!1689 = distinct !DISubprogram(name: "matVecMulSelectArch", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE", scope: !85, file: !83, line: 117, type: !109, scopeLine: 118, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !108, retainedNodes: !1690)
!1690 = !{!1691, !1692, !1693}
!1691 = !DILocalVariable(name: "this", arg: 1, scope: !1689, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!1692 = !DILocalVariable(name: "inInterface", arg: 2, scope: !1689, file: !86, line: 123, type: !112)
!1693 = !DILocalVariable(name: "outInterface", arg: 3, scope: !1689, file: !86, line: 124, type: !129)
!1694 = !{!1695}
!1695 = distinct !{!1695, !1696, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: unknown scope"}
!1696 = distinct !{!1696, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE"}
!1697 = !{!1698, !1695}
!1698 = distinct !{!1698, !1696, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE19matVecMulSelectArchENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outInterface"}
!1699 = !DILocation(line: 0, scope: !1689)
!1700 = !DILocation(line: 123, column: 62, scope: !1689)
!1701 = !{!1698}
!1702 = !DILocation(line: 124, column: 63, scope: !1689)
!1703 = !DILocation(line: 120, column: 49, scope: !1704)
!1704 = distinct !DILexicalBlock(scope: !1705, file: !83, line: 120, column: 32)
!1705 = distinct !DILexicalBlock(scope: !1689, file: !83, line: 120, column: 19)
!1706 = !DILocation(line: 120, column: 62, scope: !1704)
!1707 = !DILocation(line: 120, column: 34, scope: !1704)
!1708 = !DILocation(line: 124, column: 1, scope: !1689)
!1709 = !{!1710}
!1710 = distinct !{!1710, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: unknown scope"}
!1711 = distinct !{!1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE"}
!1712 = !{!1713, !1714, !1715, !1716, !1710, !1717, !1718, !1719, !1720, !1721}
!1713 = distinct !{!1713, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outInterface"}
!1714 = distinct !{!1714, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inPtrA"}
!1715 = distinct !{!1715, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inPtrB"}
!1716 = distinct !{!1716, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inMatrixBuff"}
!1717 = distinct !{!1717, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: inMatrixPtrRtp"}
!1718 = distinct !{!1718, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: matrixPtr"}
!1719 = distinct !{!1719, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: matrixStartPtr"}
!1720 = distinct !{!1720, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: vectorStartPtr"}
!1721 = distinct !{!1721, !1711, !"_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EE14matVecMulBasicENS3_9T_inputIFIffEENS3_10T_outputIFIffEE: outPtr"}
!1722 = !DILocation(line: 0, scope: !84)
!1723 = !DILocation(line: 126, column: 57, scope: !84)
!1724 = !{!1713}
!1725 = !DILocation(line: 126, column: 103, scope: !84)
!1726 = !DILocation(line: 167, column: 5, scope: !84)
!1727 = !DILocation(line: 168, column: 5, scope: !84)
!1728 = !DILocation(line: 170, column: 5, scope: !84)
!1729 = !DILocation(line: 170, column: 13, scope: !84)
!1730 = !{!1731, !1731, i64 0, i64 32}
!1731 = !{!1547, i64 32, !"_ZTSN3aie6vectorIfLj8EEE", !1732, i64 0, i64 32}
!1732 = !{!1547, i64 32, !"_ZTSN3aie6detail11vector_baseIfLj8EEE", !1733, i64 0, i64 32}
!1733 = !{!1547, i64 32, !"v64int4"}
!1734 = !DILocation(line: 171, column: 5, scope: !84)
!1735 = !DILocation(line: 171, column: 25, scope: !84)
!1736 = !{!1714}
!1737 = !DILocation(line: 172, column: 5, scope: !84)
!1738 = !DILocation(line: 172, column: 13, scope: !84)
!1739 = !DILocation(line: 173, column: 5, scope: !84)
!1740 = !DILocation(line: 173, column: 25, scope: !84)
!1741 = !{!1715}
!1742 = !DILocation(line: 175, column: 5, scope: !84)
!1743 = !DILocation(line: 175, column: 15, scope: !84)
!1744 = !{!1745, !1745, i64 0, i64 32}
!1745 = !{!1547, i64 32, !"_ZTSN3aie5accumI8accfloatLj8EEE", !1746, i64 0, i64 32}
!1746 = !{!1547, i64 32, !"_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEE", !1747, i64 0, i64 32}
!1747 = !{!1547, i64 32, !"v8acc32"}
!1748 = !DILocation(line: 176, column: 5, scope: !84)
!1749 = !DILocation(line: 176, column: 15, scope: !84)
!1750 = !DILocation(line: 176, column: 27, scope: !84)
!1751 = !DILocation(line: 177, column: 5, scope: !84)
!1752 = !DILocation(line: 177, column: 15, scope: !84)
!1753 = !DILocation(line: 180, column: 5, scope: !84)
!1754 = !DILocation(line: 180, column: 27, scope: !84)
!1755 = !{!1716}
!1756 = !DILocation(line: 180, column: 66, scope: !84)
!1757 = !{!1572, !1546, i64 0, i64 4}
!1758 = !DILocation(line: 181, column: 5, scope: !84)
!1759 = !DILocation(line: 181, column: 27, scope: !84)
!1760 = !{!1717}
!1761 = !DILocation(line: 181, column: 44, scope: !84)
!1762 = !DILocation(line: 182, column: 5, scope: !84)
!1763 = !DILocation(line: 182, column: 27, scope: !84)
!1764 = !{!1718}
!1765 = !DILocation(line: 182, column: 69, scope: !84)
!1766 = !DILocation(line: 184, column: 5, scope: !84)
!1767 = !DILocation(line: 184, column: 25, scope: !84)
!1768 = !{!1719}
!1769 = !DILocation(line: 184, column: 53, scope: !84)
!1770 = !DILocation(line: 185, column: 5, scope: !84)
!1771 = !DILocation(line: 185, column: 25, scope: !84)
!1772 = !{!1720}
!1773 = !DILocation(line: 185, column: 64, scope: !84)
!1774 = !DILocation(line: 186, column: 5, scope: !84)
!1775 = !DILocation(line: 186, column: 27, scope: !84)
!1776 = !{!1721}
!1777 = !DILocation(line: 186, column: 61, scope: !84)
!1778 = !DILocation(line: 189, column: 10, scope: !473)
!1779 = !DILocation(line: 189, column: 14, scope: !473)
!1780 = !{!1781, !1781, i64 0, i64 4}
!1781 = !{!1547, i64 4, !"int"}
!1782 = !DILocation(line: 189, column: 25, scope: !477)
!1783 = !DILocation(line: 189, column: 31, scope: !477)
!1784 = !DILocation(line: 189, column: 5, scope: !473)
!1785 = !DILocation(line: 189, column: 5, scope: !477)
!1786 = !DILocation(line: 191, column: 14, scope: !475)
!1787 = !DILocation(line: 191, column: 18, scope: !475)
!1788 = !DILocation(line: 191, column: 27, scope: !481)
!1789 = !DILocation(line: 191, column: 31, scope: !481)
!1790 = !DILocation(line: 191, column: 9, scope: !475)
!1791 = distinct !{!1791, !1790, !1792, !1793, !1794, !1795, !1796, !1797}
!1792 = !DILocation(line: 227, column: 13, scope: !475)
!1793 = !{!"llvm.loop.mustprogress"}
!1794 = !{!"llvm.loop.chess.prepare_for_pipelining"}
!1795 = !{!"llvm.loop.chess.min_loop_count", i32 16}
!1796 = !{!"llvm.loop.chess.max_loop_count", i32 16}
!1797 = !{!"llvm.loop.disable_llvm_transforms"}
!1798 = !DILocation(line: 191, column: 9, scope: !481)
!1799 = !DILocation(line: 192, column: 27, scope: !480)
!1800 = !DILocation(line: 192, column: 46, scope: !480)
!1801 = !DILocation(line: 192, column: 52, scope: !480)
!1802 = !DILocation(line: 192, column: 43, scope: !480)
!1803 = !DILocation(line: 192, column: 73, scope: !480)
!1804 = !DILocation(line: 192, column: 70, scope: !480)
!1805 = !DILocation(line: 192, column: 24, scope: !480)
!1806 = !DILocation(line: 193, column: 27, scope: !480)
!1807 = !DILocation(line: 193, column: 46, scope: !480)
!1808 = !DILocation(line: 193, column: 52, scope: !480)
!1809 = !DILocation(line: 193, column: 43, scope: !480)
!1810 = !DILocation(line: 193, column: 24, scope: !480)
!1811 = !DILocation(line: 197, column: 80, scope: !1812)
!1812 = distinct !DILexicalBlock(scope: !1813, file: !83, line: 196, column: 59)
!1813 = distinct !DILexicalBlock(scope: !480, file: !83, line: 196, column: 31)
!1814 = !DILocation(line: 197, column: 42, scope: !1812)
!1815 = !DILocation(line: 197, column: 29, scope: !1812)
!1816 = !DILocation(line: 202, column: 22, scope: !479)
!1817 = !DILocation(line: 202, column: 26, scope: !479)
!1818 = !DILocation(line: 202, column: 38, scope: !485)
!1819 = !DILocation(line: 202, column: 45, scope: !485)
!1820 = !DILocation(line: 202, column: 17, scope: !479)
!1821 = !DILocation(line: 202, column: 17, scope: !485)
!1822 = !DILocation(line: 203, column: 36, scope: !484)
!1823 = !DILocation(line: 203, column: 27, scope: !484)
!1824 = !DILocation(line: 205, column: 26, scope: !483)
!1825 = !DILocation(line: 205, column: 30, scope: !483)
!1826 = !DILocation(line: 205, column: 39, scope: !1827)
!1827 = distinct !DILexicalBlock(scope: !483, file: !83, line: 205, column: 21)
!1828 = !DILocation(line: 205, column: 43, scope: !1827)
!1829 = !DILocation(line: 205, column: 21, scope: !483)
!1830 = !DILocation(line: 205, column: 21, scope: !1827)
!1831 = !DILocation(line: 206, column: 34, scope: !1832)
!1832 = distinct !DILexicalBlock(scope: !1827, file: !83, line: 205, column: 67)
!1833 = !DILocation(line: 206, column: 31, scope: !1832)
!1834 = !DILocation(line: 207, column: 32, scope: !1832)
!1835 = !DILocation(line: 211, column: 57, scope: !1836)
!1836 = distinct !DILexicalBlock(scope: !1837, file: !83, line: 210, column: 30)
!1837 = distinct !DILexicalBlock(scope: !1832, file: !83, line: 209, column: 39)
!1838 = !DILocation(line: 211, column: 51, scope: !1836)
!1839 = !DILocation(line: 211, column: 35, scope: !1836)
!1840 = !{!1841, !1841, i64 0, i64 8}
!1841 = !{!1547, i64 8, !"_ZTSN3aie15vector_elem_refIfLj8EEE", !1546, i64 0, i64 4, !1781, i64 4, i64 4}
!1842 = !DILocation(line: 211, column: 33, scope: !1836)
!1843 = !DILocation(line: 213, column: 21, scope: !1832)
!1844 = !DILocation(line: 205, column: 63, scope: !1827)
!1845 = distinct !{!1845, !1829, !1846, !1793, !1847}
!1846 = !DILocation(line: 213, column: 21, scope: !483)
!1847 = !{!"llvm.loop.unroll.count", i32 8}
!1848 = !DILocation(line: 214, column: 17, scope: !484)
!1849 = !DILocation(line: 202, column: 70, scope: !485)
!1850 = distinct !{!1850, !1820, !1851, !1793}
!1851 = !DILocation(line: 214, column: 17, scope: !479)
!1852 = !DILocation(line: 218, column: 48, scope: !488)
!1853 = !DILocation(line: 218, column: 33, scope: !488)
!1854 = !DILocation(line: 220, column: 30, scope: !487)
!1855 = !DILocation(line: 220, column: 34, scope: !487)
!1856 = !DILocation(line: 220, column: 41, scope: !1857)
!1857 = distinct !DILexicalBlock(scope: !487, file: !83, line: 220, column: 25)
!1858 = !DILocation(line: 220, column: 43, scope: !1857)
!1859 = !DILocation(line: 220, column: 25, scope: !487)
!1860 = !DILocation(line: 220, column: 25, scope: !1857)
!1861 = !DILocation(line: 221, column: 83, scope: !1862)
!1862 = distinct !DILexicalBlock(scope: !1857, file: !83, line: 220, column: 83)
!1863 = !DILocation(line: 221, column: 58, scope: !1862)
!1864 = !DILocation(line: 221, column: 36, scope: !1862)
!1865 = !DILocation(line: 221, column: 39, scope: !1862)
!1866 = !DILocation(line: 222, column: 25, scope: !1862)
!1867 = !DILocation(line: 220, column: 79, scope: !1857)
!1868 = distinct !{!1868, !1859, !1869, !1793, !1870}
!1869 = !DILocation(line: 222, column: 25, scope: !487)
!1870 = !{!"llvm.loop.unroll.count", i32 1}
!1871 = !DILocation(line: 227, column: 13, scope: !480)
!1872 = !DILocation(line: 191, column: 50, scope: !481)
!1873 = !DILocation(line: 228, column: 5, scope: !476)
!1874 = !DILocation(line: 189, column: 53, scope: !477)
!1875 = distinct !{!1875, !1784, !1876, !1793}
!1876 = !DILocation(line: 228, column: 5, scope: !473)
!1877 = !DILocation(line: 229, column: 1, scope: !84)
!1878 = distinct !DISubprogram(name: "set_rnd_mode<0U>", linkageName: "_ZN2xf3dsp3aie12set_rnd_modeILj0EEEvv", scope: !89, file: !1879, line: 42, type: !1052, scopeLine: 42, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1880, retainedNodes: !137)
!1879 = !DIFile(filename: "dsp_lib/L1/include/aie/kernel_api_utils.hpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo")
!1880 = !{!1881}
!1881 = !DITemplateValueParameter(name: "rndMode", type: !15, value: i32 0)
!1882 = !DILocation(line: 45, column: 43, scope: !1883)
!1883 = distinct !DILexicalBlock(scope: !1884, file: !1879, line: 45, column: 41)
!1884 = distinct !DILexicalBlock(scope: !1878, file: !1879, line: 45, column: 19)
!1885 = !DILocation(line: 76, column: 1, scope: !1878)
!1886 = distinct !DISubprogram(name: "set_sat_mode<0U>", linkageName: "_ZN2xf3dsp3aie12set_sat_modeILj0EEEvv", scope: !89, file: !1879, line: 80, type: !1052, scopeLine: 80, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1887, retainedNodes: !137)
!1887 = !{!1888}
!1888 = !DITemplateValueParameter(name: "satMode", type: !15, value: i32 0)
!1889 = !DILocation(line: 83, column: 35, scope: !1890)
!1890 = distinct !DILexicalBlock(scope: !1891, file: !1879, line: 83, column: 33)
!1891 = distinct !DILexicalBlock(scope: !1886, file: !1879, line: 83, column: 19)
!1892 = !DILocation(line: 93, column: 1, scope: !1886)
!1893 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj8EEC2Ev", scope: !188, file: !189, line: 148, type: !276, scopeLine: 150, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !275, retainedNodes: !1894)
!1894 = !{!1895}
!1895 = !DILocalVariable(name: "this", arg: 1, scope: !1893, type: !1896, flags: DIFlagArtificial | DIFlagObjectPointer)
!1896 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !188, size: 32)
!1897 = !DILocation(line: 0, scope: !1893)
!1898 = !DILocation(line: 149, column: 9, scope: !1893)
!1899 = !DILocation(line: 151, column: 5, scope: !1893)
!1900 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj8EEC2Ev", scope: !374, file: !375, line: 163, type: !442, scopeLine: 163, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !441, retainedNodes: !1901)
!1901 = !{!1902}
!1902 = !DILocalVariable(name: "this", arg: 1, scope: !1900, type: !1903, flags: DIFlagArtificial | DIFlagObjectPointer)
!1903 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !374, size: 32)
!1904 = !DILocation(line: 0, scope: !1900)
!1905 = !DILocation(line: 163, column: 5, scope: !1900)
!1906 = !DILocation(line: 163, column: 21, scope: !1900)
!1907 = distinct !DISubprogram(name: "zeros<float, 8U>", linkageName: "_ZN3aie5zerosIfLj8EEENS_6vectorIT_XT0_EEEv", scope: !8, file: !1506, line: 1084, type: !1908, scopeLine: 1085, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !208, retainedNodes: !137)
!1908 = !DISubroutineType(types: !1909)
!1909 = !{!188}
!1910 = !DILocation(line: 1086, column: 12, scope: !1907)
!1911 = !DILocation(line: 1086, column: 5, scope: !1907)
!1912 = distinct !DISubprogram(name: "readincr_v<8U, accfloat>", linkageName: "_Z10readincr_vILj8E8accfloatEN3aie5accumIT0_XT_EEEP13input_cascadeIS3_vE", scope: !910, file: !910, line: 718, type: !1913, scopeLine: 718, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1917, retainedNodes: !1915)
!1913 = !DISubroutineType(types: !1914)
!1914 = !{!374, !124}
!1915 = !{!1916}
!1916 = !DILocalVariable(name: "w", arg: 1, scope: !1912, file: !910, line: 718, type: !124)
!1917 = !{!353, !1918}
!1918 = !DITemplateTypeParameter(name: "T", type: !459)
!1919 = !DILocation(line: 718, column: 49, scope: !1912)
!1920 = !DILocation(line: 718, column: 160, scope: !1912)
!1921 = !DILocation(line: 718, column: 104, scope: !1912)
!1922 = !DILocation(line: 718, column: 97, scope: !1912)
!1923 = distinct !DISubprogram(name: "mac<aie::accum<accfloat, 8U>, aie::vector_elem_ref<float, 8U>, aie::vector<float, 8U> >", linkageName: "_ZN3aie3macINS_5accumI8accfloatLj8EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSC_T0_RKT1_", scope: !8, file: !1506, line: 4866, type: !1924, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1934, retainedNodes: !1930)
!1924 = !DISubroutineType(types: !1925)
!1925 = !{!1926, !447, !322, !1929}
!1926 = !DIDerivedType(tag: DW_TAG_typedef, name: "operand_base_type_t<aie::accum<accfloat, 8U> >", scope: !8, file: !1084, line: 410, baseType: !1927)
!1927 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1928, file: !1506, line: 94, baseType: !944)
!1928 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "operand_base_type<aie::accum<accfloat, 8U> >", scope: !8, file: !1506, line: 92, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !948, identifier: "_ZTSN3aie17operand_base_typeINS_5accumI8accfloatLj8EEEEE")
!1929 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !292, size: 32)
!1930 = !{!1931, !1932, !1933}
!1931 = !DILocalVariable(name: "acc", arg: 1, scope: !1923, file: !1506, line: 4866, type: !447)
!1932 = !DILocalVariable(name: "a", arg: 2, scope: !1923, file: !1506, line: 4866, type: !322)
!1933 = !DILocalVariable(name: "v", arg: 3, scope: !1923, file: !1506, line: 4866, type: !1929)
!1934 = !{!1935, !1936, !1937}
!1935 = !DITemplateTypeParameter(name: "Acc", type: !374)
!1936 = !DITemplateTypeParameter(name: "E", type: !322)
!1937 = !DITemplateTypeParameter(name: "Vec", type: !188)
!1938 = !DILocation(line: 4866, column: 31, scope: !1923)
!1939 = !DILocation(line: 4866, column: 38, scope: !1923)
!1940 = !DILocation(line: 4866, column: 52, scope: !1923)
!1941 = !DILocation(line: 4869, column: 20, scope: !1942)
!1942 = distinct !DILexicalBlock(scope: !1943, file: !1506, line: 4868, column: 39)
!1943 = distinct !DILexicalBlock(scope: !1923, file: !1506, line: 4868, column: 24)
!1944 = !DILocation(line: 4869, column: 27, scope: !1942)
!1945 = !DILocation(line: 4869, column: 33, scope: !1942)
!1946 = !DILocation(line: 4869, column: 36, scope: !1942)
!1947 = !DILocation(line: 4869, column: 16, scope: !1942)
!1948 = !DILocation(line: 4869, column: 9, scope: !1942)
!1949 = distinct !DISubprogram(name: "operator[]", linkageName: "_ZN3aie6vectorIfLj8EEixEj", scope: !188, file: !189, line: 303, type: !364, scopeLine: 304, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !363, retainedNodes: !1950)
!1950 = !{!1951, !1952}
!1951 = !DILocalVariable(name: "this", arg: 1, scope: !1949, type: !1896, flags: DIFlagArtificial | DIFlagObjectPointer)
!1952 = !DILocalVariable(name: "idx", arg: 2, scope: !1949, file: !189, line: 303, type: !15)
!1953 = !DILocation(line: 0, scope: !1949)
!1954 = !DILocation(line: 303, column: 83, scope: !1949)
!1955 = !DILocation(line: 305, column: 9, scope: !1949)
!1956 = !DILocation(line: 305, column: 9, scope: !1957)
!1957 = distinct !DILexicalBlock(scope: !1958, file: !189, line: 305, column: 9)
!1958 = distinct !DILexicalBlock(scope: !1949, file: !189, line: 305, column: 9)
!1959 = !DILocation(line: 305, column: 9, scope: !1958)
!1960 = !DILocation(line: 305, column: 9, scope: !1961)
!1961 = distinct !DILexicalBlock(scope: !1957, file: !189, line: 305, column: 9)
!1962 = !DILocation(line: 305, column: 9, scope: !1963)
!1963 = distinct !DILexicalBlock(scope: !1964, file: !189, line: 305, column: 9)
!1964 = distinct !DILexicalBlock(scope: !1961, file: !189, line: 305, column: 9)
!1965 = !DILocation(line: 305, column: 9, scope: !1964)
!1966 = !{!"idx needs to be a valid element index"}
!1967 = !DILocation(line: 305, column: 9, scope: !1968)
!1968 = distinct !DILexicalBlock(scope: !1957, file: !189, line: 305, column: 9)
!1969 = !DILocation(line: 306, column: 25, scope: !1949)
!1970 = !DILocation(line: 306, column: 16, scope: !1949)
!1971 = !DILocation(line: 306, column: 9, scope: !1949)
!1972 = distinct !DISubprogram(name: "to_vector<float>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi", scope: !374, file: !375, line: 392, type: !1973, scopeLine: 393, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1085, declaration: !1975, retainedNodes: !1976)
!1973 = !DISubroutineType(types: !1974)
!1974 = !{!188, !456, !9}
!1975 = !DISubprogram(name: "to_vector<float>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi", scope: !374, file: !375, line: 392, type: !1973, scopeLine: 392, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1085)
!1976 = !{!1977, !1979}
!1977 = !DILocalVariable(name: "this", arg: 1, scope: !1972, type: !1978, flags: DIFlagArtificial | DIFlagObjectPointer)
!1978 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !448, size: 32)
!1979 = !DILocalVariable(name: "shift", arg: 2, scope: !1972, file: !375, line: 392, type: !9)
!1980 = !DILocation(line: 0, scope: !1972)
!1981 = !DILocation(line: 392, column: 36, scope: !1972)
!1982 = !DILocation(line: 394, column: 49, scope: !1972)
!1983 = !DILocation(line: 394, column: 36, scope: !1972)
!1984 = !DILocation(line: 394, column: 9, scope: !1972)
!1985 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6vectorIfLj8EE7extractILj8EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 427, type: !1986, scopeLine: 428, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1989, declaration: !1988, retainedNodes: !1991)
!1986 = !DISubroutineType(types: !1987)
!1987 = !{!188, !291, !15}
!1988 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6vectorIfLj8EE7extractILj8EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 427, type: !1986, scopeLine: 427, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1989)
!1989 = !{!1990}
!1990 = !DITemplateValueParameter(name: "ElemsOut", type: !15, value: i32 8)
!1991 = !{!1992, !1994}
!1992 = !DILocalVariable(name: "this", arg: 1, scope: !1985, type: !1993, flags: DIFlagArtificial | DIFlagObjectPointer)
!1993 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !292, size: 32)
!1994 = !DILocalVariable(name: "idx", arg: 2, scope: !1985, file: !189, line: 427, type: !15)
!1995 = !DILocation(line: 0, scope: !1985)
!1996 = !DILocation(line: 427, column: 51, scope: !1985)
!1997 = !DILocation(line: 429, column: 16, scope: !1985)
!1998 = !DILocation(line: 429, column: 54, scope: !1985)
!1999 = !DILocation(line: 429, column: 36, scope: !1985)
!2000 = !DILocation(line: 429, column: 9, scope: !1985)
!2001 = distinct !DISubprogram(name: "set_rounding", linkageName: "_ZN3aieL12set_roundingENS_13rounding_modeE", scope: !8, file: !1506, line: 7750, type: !2002, scopeLine: 7751, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2004)
!2002 = !DISubroutineType(types: !2003)
!2003 = !{null, !13}
!2004 = !{!2005}
!2005 = !DILocalVariable(name: "m", arg: 1, scope: !2001, file: !1506, line: 7750, type: !13)
!2006 = !{!2007, !2007, i64 0, i64 4}
!2007 = !{!1547, i64 4, !"_ZTSN3aie13rounding_modeE"}
!2008 = !DILocation(line: 7750, column: 47, scope: !2001)
!2009 = !DILocation(line: 7752, column: 5, scope: !2001)
!2010 = !DILocation(line: 7752, column: 39, scope: !2001)
!2011 = !DILocation(line: 7752, column: 26, scope: !2001)
!2012 = !DILocation(line: 7753, column: 1, scope: !2001)
!2013 = distinct !DISubprogram(name: "current", linkageName: "_ZN3aie4tile7currentEv", scope: !615, file: !616, line: 46, type: !636, scopeLine: 46, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !635, retainedNodes: !137)
!2014 = !DILocation(line: 46, column: 36, scope: !2013)
!2015 = !DILocation(line: 46, column: 29, scope: !2013)
!2016 = distinct !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie4tile12set_roundingENS_13rounding_modeE", scope: !615, file: !616, line: 58, type: !645, scopeLine: 58, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !644, retainedNodes: !2017)
!2017 = !{!2018, !2020}
!2018 = !DILocalVariable(name: "this", arg: 1, scope: !2016, type: !2019, flags: DIFlagArtificial | DIFlagObjectPointer)
!2019 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !615, size: 32)
!2020 = !DILocalVariable(name: "mode", arg: 2, scope: !2016, file: !616, line: 58, type: !13)
!2021 = !DILocation(line: 0, scope: !2016)
!2022 = !DILocation(line: 58, column: 37, scope: !2016)
!2023 = !DILocation(line: 58, column: 69, scope: !2016)
!2024 = !DILocation(line: 58, column: 56, scope: !2016)
!2025 = !DILocation(line: 59, column: 5, scope: !2016)
!2026 = distinct !DISubprogram(name: "current", linkageName: "_ZN3aie6detail4tile7currentEv", scope: !573, file: !574, line: 64, type: !601, scopeLine: 65, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !600, retainedNodes: !137)
!2027 = !DILocation(line: 66, column: 16, scope: !2026)
!2028 = !DILocation(line: 66, column: 9, scope: !2026)
!2029 = distinct !DISubprogram(name: "tile", linkageName: "_ZN3aie4tileC2ERKNS_6detail4tileE", scope: !615, file: !616, line: 30, type: !620, scopeLine: 30, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !619, retainedNodes: !2030)
!2030 = !{!2031, !2032}
!2031 = !DILocalVariable(name: "this", arg: 1, scope: !2029, type: !2019, flags: DIFlagArtificial | DIFlagObjectPointer)
!2032 = !DILocalVariable(name: "t", arg: 2, scope: !2029, file: !616, line: 30, type: !623)
!2033 = !DILocation(line: 0, scope: !2029)
!2034 = !DILocation(line: 30, column: 27, scope: !2029)
!2035 = !DILocation(line: 30, column: 45, scope: !2029)
!2036 = !DILocation(line: 30, column: 49, scope: !2029)
!2037 = distinct !DISubprogram(name: "tile", linkageName: "_ZN3aie6detail4tileC2Ev", scope: !573, file: !574, line: 36, type: !582, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !581, retainedNodes: !2038)
!2038 = !{!2039}
!2039 = !DILocalVariable(name: "this", arg: 1, scope: !2037, type: !2040, flags: DIFlagArtificial | DIFlagObjectPointer)
!2040 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !573, size: 32)
!2041 = !DILocation(line: 0, scope: !2037)
!2042 = !DILocation(line: 36, column: 23, scope: !2037)
!2043 = distinct !DISubprogram(name: "set_rounding", linkageName: "_ZN3aie6detail4tile12set_roundingENS_13rounding_modeE", scope: !573, file: !574, line: 82, type: !610, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !609, retainedNodes: !2044)
!2044 = !{!2045, !2046}
!2045 = !DILocalVariable(name: "this", arg: 1, scope: !2043, type: !2040, flags: DIFlagArtificial | DIFlagObjectPointer)
!2046 = !DILocalVariable(name: "mode", arg: 2, scope: !2043, file: !574, line: 82, type: !13)
!2047 = !DILocation(line: 0, scope: !2043)
!2048 = !DILocation(line: 82, column: 37, scope: !2043)
!2049 = !DILocation(line: 84, column: 29, scope: !2043)
!2050 = !DILocation(line: 84, column: 9, scope: !2043)
!2051 = !DILocation(line: 85, column: 5, scope: !2043)
!2052 = distinct !DISubprogram(name: "set_saturation", linkageName: "_ZN3aieL14set_saturationENS_15saturation_modeE", scope: !8, file: !1506, line: 7715, type: !2053, scopeLine: 7716, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2055)
!2053 = !DISubroutineType(types: !2054)
!2054 = !{null, !27}
!2055 = !{!2056}
!2056 = !DILocalVariable(name: "m", arg: 1, scope: !2052, file: !1506, line: 7715, type: !27)
!2057 = !{!2058, !2058, i64 0, i64 4}
!2058 = !{!1547, i64 4, !"_ZTSN3aie15saturation_modeE"}
!2059 = !DILocation(line: 7715, column: 51, scope: !2052)
!2060 = !DILocation(line: 7717, column: 5, scope: !2052)
!2061 = !DILocation(line: 7717, column: 41, scope: !2052)
!2062 = !DILocation(line: 7717, column: 26, scope: !2052)
!2063 = !DILocation(line: 7718, column: 1, scope: !2052)
!2064 = distinct !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie4tile14set_saturationENS_15saturation_modeE", scope: !615, file: !616, line: 50, type: !639, scopeLine: 50, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !638, retainedNodes: !2065)
!2065 = !{!2066, !2067}
!2066 = !DILocalVariable(name: "this", arg: 1, scope: !2064, type: !2019, flags: DIFlagArtificial | DIFlagObjectPointer)
!2067 = !DILocalVariable(name: "mode", arg: 2, scope: !2064, file: !616, line: 50, type: !27)
!2068 = !DILocation(line: 0, scope: !2064)
!2069 = !DILocation(line: 50, column: 41, scope: !2064)
!2070 = !DILocation(line: 50, column: 75, scope: !2064)
!2071 = !DILocation(line: 50, column: 60, scope: !2064)
!2072 = !DILocation(line: 50, column: 82, scope: !2064)
!2073 = distinct !DISubprogram(name: "set_saturation", linkageName: "_ZN3aie6detail4tile14set_saturationENS_15saturation_modeE", scope: !573, file: !574, line: 70, type: !604, scopeLine: 71, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !603, retainedNodes: !2074)
!2074 = !{!2075, !2076}
!2075 = !DILocalVariable(name: "this", arg: 1, scope: !2073, type: !2040, flags: DIFlagArtificial | DIFlagObjectPointer)
!2076 = !DILocalVariable(name: "mode", arg: 2, scope: !2073, file: !574, line: 70, type: !27)
!2077 = !DILocation(line: 0, scope: !2073)
!2078 = !DILocation(line: 70, column: 41, scope: !2073)
!2079 = !DILocation(line: 72, column: 33, scope: !2073)
!2080 = !DILocation(line: 72, column: 9, scope: !2073)
!2081 = !DILocation(line: 73, column: 5, scope: !2073)
!2082 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj8EEC2Ev", scope: !192, file: !193, line: 402, type: !226, scopeLine: 404, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !225, retainedNodes: !2083)
!2083 = !{!2084}
!2084 = !DILocalVariable(name: "this", arg: 1, scope: !2082, type: !2085, flags: DIFlagArtificial | DIFlagObjectPointer)
!2085 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 32)
!2086 = !DILocation(line: 0, scope: !2082)
!2087 = !DILocation(line: 403, column: 9, scope: !2082)
!2088 = !DILocation(line: 403, column: 14, scope: !2082)
!2089 = !DILocation(line: 405, column: 5, scope: !2082)
!2090 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj8EE5undefEv", scope: !203, file: !201, line: 298, type: !206, scopeLine: 298, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !205, retainedNodes: !137)
!2091 = !DILocation(line: 298, column: 138, scope: !2090)
!2092 = !DILocation(line: 298, column: 131, scope: !2090)
!2093 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj8EE5undefEv", scope: !388, file: !386, line: 166, type: !391, scopeLine: 166, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !390, retainedNodes: !137)
!2094 = !DILocation(line: 166, column: 147, scope: !2093)
!2095 = !DILocation(line: 166, column: 140, scope: !2093)
!2096 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv", scope: !2098, file: !2097, line: 88, type: !2101, scopeLine: 89, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2100, retainedNodes: !137)
!2097 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/../broadcast.hpp", directory: "")
!2098 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "zeros_bits<32U, float, 8U>", scope: !7, file: !2097, line: 83, size: 8, flags: DIFlagTypePassByValue, elements: !2099, templateParams: !2104, identifier: "_ZTSN3aie6detail10zeros_bitsILj32EfLj8EEE")
!2099 = !{!2100}
!2100 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10zeros_bitsILj32EfLj8EE3runEv", scope: !2098, file: !2097, line: 88, type: !2101, scopeLine: 88, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2101 = !DISubroutineType(types: !2102)
!2102 = !{!2103}
!2103 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2098, file: !2097, line: 85, baseType: !188)
!2104 = !{!2105, !209, !210}
!2105 = !DITemplateValueParameter(name: "TypeBits", type: !15, value: i32 32)
!2106 = !DILocation(line: 111, column: 20, scope: !2107)
!2107 = distinct !DILexicalBlock(scope: !2096, file: !2097, line: 108, column: 23)
!2108 = !DILocation(line: 111, column: 13, scope: !2107)
!2109 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv", scope: !2111, file: !2110, line: 292, type: !2114, scopeLine: 293, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2113, retainedNodes: !2117)
!2110 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/broadcast.hpp", directory: "")
!2111 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "zeros_bits_impl<32U, float, 8U>", scope: !7, file: !2110, line: 287, size: 8, flags: DIFlagTypePassByValue, elements: !2112, templateParams: !2104, identifier: "_ZTSN3aie6detail15zeros_bits_implILj32EfLj8EEE")
!2112 = !{!2113}
!2113 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj8EE3runEv", scope: !2111, file: !2110, line: 292, type: !2114, scopeLine: 292, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2114 = !DISubroutineType(types: !2115)
!2115 = !{!2116}
!2116 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2111, file: !2110, line: 289, baseType: !188)
!2117 = !{!2118, !2119}
!2118 = !DILocalVariable(name: "native_zeros_elems", scope: !2109, file: !2110, line: 294, type: !101)
!2119 = !DILocalVariable(name: "ret", scope: !2109, file: !2110, line: 297, type: !2116)
!2120 = !DILocation(line: 294, column: 9, scope: !2109)
!2121 = !DILocation(line: 294, column: 28, scope: !2109)
!2122 = !DILocation(line: 297, column: 21, scope: !2109)
!2123 = !DILocation(line: 300, column: 19, scope: !2124)
!2124 = distinct !DILexicalBlock(scope: !2125, file: !2110, line: 299, column: 49)
!2125 = distinct !DILexicalBlock(scope: !2109, file: !2110, line: 299, column: 23)
!2126 = !DILocation(line: 300, column: 53, scope: !2124)
!2127 = !DILocation(line: 300, column: 17, scope: !2124)
!2128 = !DILocation(line: 300, column: 13, scope: !2124)
!2129 = !DILocation(line: 326, column: 5, scope: !2109)
!2130 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv", scope: !2131, file: !2110, line: 292, type: !2134, scopeLine: 293, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2133, retainedNodes: !2138)
!2131 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "zeros_bits_impl<32U, float, 16U>", scope: !7, file: !2110, line: 287, size: 8, flags: DIFlagTypePassByValue, elements: !2132, templateParams: !2137, identifier: "_ZTSN3aie6detail15zeros_bits_implILj32EfLj16EEE")
!2132 = !{!2133}
!2133 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail15zeros_bits_implILj32EfLj16EE3runEv", scope: !2131, file: !2110, line: 292, type: !2134, scopeLine: 292, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2134 = !DISubroutineType(types: !2135)
!2135 = !{!2136}
!2136 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2131, file: !2110, line: 289, baseType: !744)
!2137 = !{!2105, !209, !515}
!2138 = !{!2139, !2140}
!2139 = !DILocalVariable(name: "native_zeros_elems", scope: !2130, file: !2110, line: 294, type: !101)
!2140 = !DILocalVariable(name: "ret", scope: !2130, file: !2110, line: 297, type: !2136)
!2141 = !DILocation(line: 294, column: 9, scope: !2130)
!2142 = !DILocation(line: 294, column: 28, scope: !2130)
!2143 = !DILocation(line: 297, column: 21, scope: !2130)
!2144 = !{!2145, !2145, i64 0, i64 64}
!2145 = !{!1547, i64 64, !"_ZTSN3aie6vectorIfLj16EEE", !2146, i64 0, i64 64}
!2146 = !{!1547, i64 64, !"_ZTSN3aie6detail11vector_baseIfLj16EEE", !2147, i64 0, i64 64}
!2147 = !{!1547, i64 64, !"v128int4"}
!2148 = !DILocation(line: 311, column: 23, scope: !2149)
!2149 = distinct !DILexicalBlock(scope: !2150, file: !2110, line: 310, column: 32)
!2150 = distinct !DILexicalBlock(scope: !2151, file: !2110, line: 308, column: 27)
!2151 = distinct !DILexicalBlock(scope: !2152, file: !2110, line: 304, column: 27)
!2152 = distinct !DILexicalBlock(scope: !2153, file: !2110, line: 302, column: 41)
!2153 = distinct !DILexicalBlock(scope: !2154, file: !2110, line: 302, column: 28)
!2154 = distinct !DILexicalBlock(scope: !2130, file: !2110, line: 299, column: 23)
!2155 = !{!2147, !2147, i64 0, i64 64}
!2156 = !DILocation(line: 311, column: 21, scope: !2149)
!2157 = !DILocation(line: 326, column: 5, scope: !2130)
!2158 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj", scope: !744, file: !189, line: 427, type: !2159, scopeLine: 428, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1989, declaration: !2161, retainedNodes: !2162)
!2159 = !DISubroutineType(types: !2160)
!2160 = !{!188, !835, !15}
!2161 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6vectorIfLj16EE7extractILj8EEENS0_IfXT_EEEj", scope: !744, file: !189, line: 427, type: !2159, scopeLine: 427, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1989)
!2162 = !{!2163, !2165}
!2163 = !DILocalVariable(name: "this", arg: 1, scope: !2158, type: !2164, flags: DIFlagArtificial | DIFlagObjectPointer)
!2164 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !836, size: 32)
!2165 = !DILocalVariable(name: "idx", arg: 2, scope: !2158, file: !189, line: 427, type: !15)
!2166 = !DILocation(line: 0, scope: !2158)
!2167 = !DILocation(line: 427, column: 51, scope: !2158)
!2168 = !DILocation(line: 429, column: 16, scope: !2158)
!2169 = !DILocation(line: 429, column: 54, scope: !2158)
!2170 = !DILocation(line: 429, column: 36, scope: !2158)
!2171 = !DILocation(line: 429, column: 9, scope: !2158)
!2172 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj16EEC2Ev", scope: !744, file: !189, line: 148, type: !820, scopeLine: 150, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !819, retainedNodes: !2173)
!2173 = !{!2174}
!2174 = !DILocalVariable(name: "this", arg: 1, scope: !2172, type: !2175, flags: DIFlagArtificial | DIFlagObjectPointer)
!2175 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !744, size: 32)
!2176 = !DILocation(line: 0, scope: !2172)
!2177 = !DILocation(line: 149, column: 9, scope: !2172)
!2178 = !DILocation(line: 151, column: 5, scope: !2172)
!2179 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj16EEC2E8v16float", scope: !744, file: !189, line: 159, type: !823, scopeLine: 161, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !822, retainedNodes: !2180)
!2180 = !{!2181, !2182}
!2181 = !DILocalVariable(name: "this", arg: 1, scope: !2179, type: !2175, flags: DIFlagArtificial | DIFlagObjectPointer)
!2182 = !DILocalVariable(name: "v", arg: 2, scope: !2179, file: !189, line: 159, type: !825)
!2183 = !DILocation(line: 0, scope: !2179)
!2184 = !DILocation(line: 159, column: 22, scope: !2179)
!2185 = !DILocation(line: 160, column: 9, scope: !2179)
!2186 = !DILocation(line: 163, column: 5, scope: !2179)
!2187 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail14vector_storageIfLj16EE5undefEv", scope: !755, file: !201, line: 299, type: !758, scopeLine: 299, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !757, retainedNodes: !137)
!2188 = !DILocation(line: 299, column: 138, scope: !2187)
!2189 = !DILocation(line: 299, column: 131, scope: !2187)
!2190 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj", scope: !747, file: !193, line: 867, type: !2191, scopeLine: 868, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1989, declaration: !2193, retainedNodes: !2194)
!2191 = !DISubroutineType(types: !2192)
!2192 = !{!192, !797, !15}
!2193 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE7extractILj8EEENS1_IfXT_EEEj", scope: !747, file: !193, line: 867, type: !2191, scopeLine: 867, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1989)
!2194 = !{!2195, !2197}
!2195 = !DILocalVariable(name: "this", arg: 1, scope: !2190, type: !2196, flags: DIFlagArtificial | DIFlagObjectPointer)
!2196 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !798, size: 32)
!2197 = !DILocalVariable(name: "idx", arg: 2, scope: !2190, file: !193, line: 867, type: !15)
!2198 = !DILocation(line: 0, scope: !2190)
!2199 = !DILocation(line: 867, column: 47, scope: !2190)
!2200 = !DILocation(line: 869, column: 9, scope: !2190)
!2201 = !DILocation(line: 869, column: 9, scope: !2202)
!2202 = distinct !DILexicalBlock(scope: !2203, file: !193, line: 869, column: 9)
!2203 = distinct !DILexicalBlock(scope: !2190, file: !193, line: 869, column: 9)
!2204 = !DILocation(line: 869, column: 9, scope: !2203)
!2205 = !DILocation(line: 869, column: 9, scope: !2206)
!2206 = distinct !DILexicalBlock(scope: !2202, file: !193, line: 869, column: 9)
!2207 = !DILocation(line: 869, column: 9, scope: !2208)
!2208 = distinct !DILexicalBlock(scope: !2209, file: !193, line: 869, column: 9)
!2209 = distinct !DILexicalBlock(scope: !2206, file: !193, line: 869, column: 9)
!2210 = !DILocation(line: 869, column: 9, scope: !2209)
!2211 = !{!"idx needs to be a valid subvector index"}
!2212 = !DILocation(line: 869, column: 9, scope: !2213)
!2213 = distinct !DILexicalBlock(scope: !2202, file: !193, line: 869, column: 9)
!2214 = !DILocation(line: 871, column: 41, scope: !2190)
!2215 = !DILocation(line: 871, column: 16, scope: !2190)
!2216 = !DILocation(line: 871, column: 9, scope: !2190)
!2217 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj8EEC2ERKNS_6detail11vector_baseIfLj8EEE", scope: !188, file: !189, line: 87, type: !260, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !259, retainedNodes: !2218)
!2218 = !{!2219, !2220}
!2219 = !DILocalVariable(name: "this", arg: 1, scope: !2217, type: !1896, flags: DIFlagArtificial | DIFlagObjectPointer)
!2220 = !DILocalVariable(name: "v", arg: 2, scope: !2217, file: !189, line: 87, type: !263)
!2221 = !DILocation(line: 0, scope: !2217)
!2222 = !DILocation(line: 87, column: 29, scope: !2217)
!2223 = !DILocation(line: 87, column: 44, scope: !2217)
!2224 = !DILocation(line: 87, column: 34, scope: !2217)
!2225 = !{!1732, !1732, i64 0, i64 32}
!2226 = !DILocation(line: 87, column: 48, scope: !2217)
!2227 = distinct !DISubprogram(name: "extract_helper<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj", scope: !747, file: !193, line: 1280, type: !2191, scopeLine: 1281, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2229, declaration: !2228, retainedNodes: !2230)
!2228 = !DISubprogram(name: "extract_helper<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE14extract_helperILj8EEENS1_IfXT_EEEj", scope: !747, file: !193, line: 1280, type: !2191, scopeLine: 1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2229)
!2229 = !{!353}
!2230 = !{!2231, !2232, !2233}
!2231 = !DILocalVariable(name: "this", arg: 1, scope: !2227, type: !2196, flags: DIFlagArtificial | DIFlagObjectPointer)
!2232 = !DILocalVariable(name: "idx", arg: 2, scope: !2227, file: !193, line: 1280, type: !15)
!2233 = !DILocalVariable(name: "output_bits", scope: !2227, file: !193, line: 1282, type: !101)
!2234 = !DILocation(line: 0, scope: !2227)
!2235 = !DILocation(line: 1280, column: 56, scope: !2227)
!2236 = !DILocation(line: 1282, column: 9, scope: !2227)
!2237 = !DILocation(line: 1282, column: 28, scope: !2227)
!2238 = !DILocation(line: 1315, column: 46, scope: !2239)
!2239 = distinct !DILexicalBlock(scope: !2240, file: !193, line: 1314, column: 51)
!2240 = distinct !DILexicalBlock(scope: !2241, file: !193, line: 1314, column: 31)
!2241 = distinct !DILexicalBlock(scope: !2242, file: !193, line: 1313, column: 47)
!2242 = distinct !DILexicalBlock(scope: !2243, file: !193, line: 1313, column: 32)
!2243 = distinct !DILexicalBlock(scope: !2244, file: !193, line: 1291, column: 27)
!2244 = distinct !DILexicalBlock(scope: !2245, file: !193, line: 1290, column: 14)
!2245 = distinct !DILexicalBlock(scope: !2227, file: !193, line: 1287, column: 23)
!2246 = !DILocation(line: 1315, column: 52, scope: !2239)
!2247 = !DILocation(line: 1315, column: 28, scope: !2239)
!2248 = !{!1733, !1733, i64 0, i64 32}
!2249 = !DILocation(line: 1328, column: 5, scope: !2227)
!2250 = distinct !DISubprogram(name: "vector_extract<8U, v16float>", linkageName: "_ZN3aie6detailL14vector_extractILj8E8v16floatEEDaRKT0_j", scope: !7, file: !193, line: 99, type: !2251, scopeLine: 99, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2258, retainedNodes: !2255)
!2251 = !DISubroutineType(types: !2252)
!2252 = !{!211, !2253, !15}
!2253 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2254, size: 32)
!2254 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !490)
!2255 = !{!2256, !2257}
!2256 = !DILocalVariable(name: "v", arg: 1, scope: !2250, file: !193, line: 99, type: !2253)
!2257 = !DILocalVariable(name: "idx", arg: 2, scope: !2250, file: !193, line: 99, type: !15)
!2258 = !{!210, !2259}
!2259 = !DITemplateTypeParameter(name: "T", type: !491)
!2260 = !DILocation(line: 99, column: 70, scope: !2250)
!2261 = !DILocation(line: 99, column: 82, scope: !2250)
!2262 = !DILocation(line: 99, column: 114, scope: !2250)
!2263 = !DILocation(line: 99, column: 117, scope: !2250)
!2264 = !DILocation(line: 99, column: 96, scope: !2250)
!2265 = !DILocation(line: 99, column: 89, scope: !2250)
!2266 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj8EEC2E7v8float", scope: !192, file: !193, line: 408, type: !230, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !229, retainedNodes: !2267)
!2267 = !{!2268, !2269}
!2268 = !DILocalVariable(name: "this", arg: 1, scope: !2266, type: !2085, flags: DIFlagArtificial | DIFlagObjectPointer)
!2269 = !DILocalVariable(name: "data", arg: 2, scope: !2266, file: !193, line: 408, type: !232)
!2270 = !DILocation(line: 0, scope: !2266)
!2271 = !DILocation(line: 408, column: 27, scope: !2266)
!2272 = !DILocation(line: 409, column: 9, scope: !2266)
!2273 = !DILocation(line: 409, column: 14, scope: !2266)
!2274 = !DILocation(line: 412, column: 5, scope: !2266)
!2275 = distinct !DISubprogram(name: "readincr", linkageName: "_ZN3aie6detail3adf21cascade_stream_helperI8accfloatLj8EE8readincrEP13input_cascadeIS3_vE", scope: !909, file: !910, line: 215, type: !933, scopeLine: 216, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !932, retainedNodes: !2276)
!2276 = !{!2277, !2278, !2279, !2280, !2284}
!2277 = !DILocalVariable(name: "_w", arg: 1, scope: !2275, file: !910, line: 215, type: !124)
!2278 = !DILocalVariable(name: "w", scope: !2275, file: !910, line: 217, type: !124)
!2279 = !DILocalVariable(name: "ret", scope: !2275, file: !910, line: 218, type: !923)
!2280 = !DILocalVariable(name: "i", scope: !2281, file: !910, line: 230, type: !15)
!2281 = distinct !DILexicalBlock(scope: !2282, file: !910, line: 230, column: 13)
!2282 = distinct !DILexicalBlock(scope: !2283, file: !910, line: 228, column: 9)
!2283 = distinct !DILexicalBlock(scope: !2275, file: !910, line: 221, column: 23)
!2284 = !DILocalVariable(name: "tmp", scope: !2285, file: !910, line: 256, type: !563)
!2285 = distinct !DILexicalBlock(scope: !2286, file: !910, line: 255, column: 63)
!2286 = distinct !DILexicalBlock(scope: !2287, file: !910, line: 255, column: 36)
!2287 = distinct !DILexicalBlock(scope: !2288, file: !910, line: 247, column: 41)
!2288 = distinct !DILexicalBlock(scope: !2289, file: !910, line: 239, column: 36)
!2289 = distinct !DILexicalBlock(scope: !2290, file: !910, line: 230, column: 52)
!2290 = distinct !DILexicalBlock(scope: !2281, file: !910, line: 230, column: 13)
!2291 = !DILocation(line: 215, column: 51, scope: !2275)
!2292 = !DILocation(line: 217, column: 9, scope: !2275)
!2293 = !DILocation(line: 217, column: 36, scope: !2275)
!2294 = !DILocation(line: 217, column: 70, scope: !2275)
!2295 = !DILocation(line: 218, column: 14, scope: !2275)
!2296 = !DILocation(line: 230, column: 18, scope: !2281)
!2297 = !DILocation(line: 230, column: 27, scope: !2281)
!2298 = !DILocation(line: 230, column: 34, scope: !2290)
!2299 = !DILocation(line: 230, column: 36, scope: !2290)
!2300 = !DILocation(line: 230, column: 13, scope: !2281)
!2301 = !DILocation(line: 230, column: 13, scope: !2290)
!2302 = !DILocation(line: 256, column: 21, scope: !2285)
!2303 = !DILocation(line: 256, column: 54, scope: !2285)
!2304 = !DILocation(line: 256, column: 73, scope: !2285)
!2305 = !DILocation(line: 256, column: 60, scope: !2285)
!2306 = !{!2307, !2307, i64 0, i64 64}
!2307 = !{!1547, i64 64, !"v16acc32"}
!2308 = !{!2309, !2309, i64 0, i64 64}
!2309 = !{!1547, i64 64, !"_ZTSN3aie5accumI8accfloatLj16EEE", !2310, i64 0, i64 64}
!2310 = !{!1547, i64 64, !"_ZTSN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEE", !2307, i64 0, i64 64}
!2311 = !DILocation(line: 259, column: 48, scope: !2312)
!2312 = distinct !DILexicalBlock(scope: !2285, file: !910, line: 258, column: 35)
!2313 = !DILocation(line: 259, column: 51, scope: !2312)
!2314 = !DILocation(line: 259, column: 64, scope: !2312)
!2315 = !DILocation(line: 259, column: 38, scope: !2312)
!2316 = !DILocation(line: 259, column: 25, scope: !2312)
!2317 = !DILocation(line: 262, column: 17, scope: !2286)
!2318 = !DILocation(line: 264, column: 13, scope: !2289)
!2319 = !DILocation(line: 230, column: 47, scope: !2290)
!2320 = distinct !{!2320, !2300, !2321, !1793, !2322}
!2321 = !DILocation(line: 264, column: 13, scope: !2281)
!2322 = !{!"llvm.loop.unroll.enable"}
!2323 = !DILocation(line: 268, column: 5, scope: !2275)
!2324 = distinct !DISubprogram(name: "readincr_v16", linkageName: "_ZL12readincr_v16P13input_cascadeI8accfloatvE", scope: !2325, file: !2325, line: 957, type: !2326, scopeLine: 957, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !2328)
!2325 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/stream/me/accessors.h", directory: "")
!2326 = !DISubroutineType(types: !2327)
!2327 = !{!492, !124}
!2328 = !{!2329}
!2329 = !DILocalVariable(name: "str", arg: 1, scope: !2324, file: !2325, line: 957, type: !124)
!2330 = !DILocation(line: 957, column: 1, scope: !2324)
!2331 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj16EEC2E11v16accfloat", scope: !498, file: !375, line: 188, type: !565, scopeLine: 190, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !564, retainedNodes: !2332)
!2332 = !{!2333, !2335}
!2333 = !DILocalVariable(name: "this", arg: 1, scope: !2331, type: !2334, flags: DIFlagArtificial | DIFlagObjectPointer)
!2334 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !498, size: 32)
!2335 = !DILocalVariable(name: "data", arg: 2, scope: !2331, file: !375, line: 188, type: !567)
!2336 = !DILocation(line: 0, scope: !2331)
!2337 = !DILocation(line: 188, column: 21, scope: !2331)
!2338 = !DILocation(line: 189, column: 9, scope: !2331)
!2339 = !DILocation(line: 192, column: 5, scope: !2331)
!2340 = distinct !DISubprogram(name: "insert<8U, accfloat>", linkageName: "_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE", scope: !374, file: !375, line: 334, type: !2341, scopeLine: 335, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2345, declaration: !2344, retainedNodes: !2348)
!2341 = !DISubroutineType(types: !2342)
!2342 = !{!2343, !427, !15, !447}
!2343 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !374, size: 32)
!2344 = !DISubprogram(name: "insert<8U, accfloat>", linkageName: "_ZN3aie5accumI8accfloatLj8EE6insertILj8ES1_EERS2_jRKNS0_IT0_XT_EEE", scope: !374, file: !375, line: 334, type: !2341, scopeLine: 334, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2345)
!2345 = !{!2346, !2347}
!2346 = !DITemplateValueParameter(name: "ElemsIn", type: !15, value: i32 8)
!2347 = !DITemplateTypeParameter(name: "Tag2", type: !459)
!2348 = !{!2349, !2350, !2351}
!2349 = !DILocalVariable(name: "this", arg: 1, scope: !2340, type: !1903, flags: DIFlagArtificial | DIFlagObjectPointer)
!2350 = !DILocalVariable(name: "idx", arg: 2, scope: !2340, file: !375, line: 334, type: !15)
!2351 = !DILocalVariable(name: "acc", arg: 3, scope: !2340, file: !375, line: 334, type: !447)
!2352 = !DILocation(line: 0, scope: !2340)
!2353 = !DILocation(line: 334, column: 28, scope: !2340)
!2354 = !DILocation(line: 334, column: 61, scope: !2340)
!2355 = !DILocation(line: 337, column: 27, scope: !2340)
!2356 = !DILocation(line: 337, column: 63, scope: !2340)
!2357 = !DILocation(line: 337, column: 20, scope: !2340)
!2358 = !DILocation(line: 338, column: 9, scope: !2340)
!2359 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj", scope: !498, file: !375, line: 286, type: !2360, scopeLine: 287, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1989, declaration: !2362, retainedNodes: !2363)
!2360 = !DISubroutineType(types: !2361)
!2361 = !{!374, !571, !15}
!2362 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie5accumI8accfloatLj16EE7extractILj8EEENS0_IS1_XT_EEEj", scope: !498, file: !375, line: 286, type: !2360, scopeLine: 286, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1989)
!2363 = !{!2364, !2366}
!2364 = !DILocalVariable(name: "this", arg: 1, scope: !2359, type: !2365, flags: DIFlagArtificial | DIFlagObjectPointer)
!2365 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !563, size: 32)
!2366 = !DILocalVariable(name: "idx", arg: 2, scope: !2359, file: !375, line: 286, type: !15)
!2367 = !DILocation(line: 0, scope: !2359)
!2368 = !DILocation(line: 286, column: 51, scope: !2359)
!2369 = !DILocation(line: 288, column: 45, scope: !2359)
!2370 = !DILocation(line: 288, column: 83, scope: !2359)
!2371 = !DILocation(line: 288, column: 65, scope: !2359)
!2372 = !DILocation(line: 288, column: 16, scope: !2359)
!2373 = !DILocation(line: 288, column: 9, scope: !2359)
!2374 = !{i32 1}
!2375 = !{!2376, !2376, i64 0, i64 4}
!2376 = !{!1547, i64 4, !"uint1_t"}
!2377 = distinct !DISubprogram(name: "insert<8U, 32U>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE", scope: !378, file: !379, line: 463, type: !2378, scopeLine: 464, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2383, declaration: !2382, retainedNodes: !2385)
!2378 = !DISubroutineType(types: !2379)
!2379 = !{!2380, !413, !15, !2381}
!2380 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !378, size: 32)
!2381 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !421, size: 32)
!2382 = !DISubprogram(name: "insert<8U, 32U>", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE6insertILj8ELj32EEERS3_jRKNS1_ILS2_2EXT0_EXT_EEE", scope: !378, file: !379, line: 463, type: !2378, scopeLine: 463, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2383)
!2383 = !{!2346, !2384}
!2384 = !DITemplateValueParameter(name: "Bits2", type: !15, value: i32 32)
!2385 = !{!2386, !2388, !2389, !2390, !2391}
!2386 = !DILocalVariable(name: "this", arg: 1, scope: !2377, type: !2387, flags: DIFlagArtificial | DIFlagObjectPointer)
!2387 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !378, size: 32)
!2388 = !DILocalVariable(name: "idx", arg: 2, scope: !2377, file: !379, line: 463, type: !15)
!2389 = !DILocalVariable(name: "acc", arg: 3, scope: !2377, file: !379, line: 463, type: !2381)
!2390 = !DILocalVariable(name: "in_num_subaccums", scope: !2377, file: !379, line: 468, type: !101)
!2391 = !DILocalVariable(name: "num_subaccums", scope: !2377, file: !379, line: 469, type: !101)
!2392 = !DILocation(line: 0, scope: !2377)
!2393 = !DILocation(line: 463, column: 33, scope: !2377)
!2394 = !DILocation(line: 463, column: 79, scope: !2377)
!2395 = !DILocation(line: 468, column: 9, scope: !2377)
!2396 = !DILocation(line: 468, column: 28, scope: !2377)
!2397 = !DILocation(line: 469, column: 9, scope: !2377)
!2398 = !DILocation(line: 469, column: 31, scope: !2377)
!2399 = !DILocation(line: 474, column: 20, scope: !2400)
!2400 = distinct !DILexicalBlock(scope: !2401, file: !379, line: 473, column: 41)
!2401 = distinct !DILexicalBlock(scope: !2377, file: !379, line: 473, column: 23)
!2402 = !DILocation(line: 474, column: 24, scope: !2400)
!2403 = !DILocation(line: 474, column: 13, scope: !2400)
!2404 = !DILocation(line: 474, column: 18, scope: !2400)
!2405 = !{!1747, !1747, i64 0, i64 32}
!2406 = !DILocation(line: 552, column: 5, scope: !2377)
!2407 = !DILocation(line: 476, column: 13, scope: !2400)
!2408 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj", scope: !501, file: !379, line: 367, type: !2409, scopeLine: 368, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1989, declaration: !2411, retainedNodes: !2412)
!2409 = !DISubroutineType(types: !2410)
!2410 = !{!378, !536, !15}
!2411 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj", scope: !501, file: !379, line: 367, type: !2409, scopeLine: 367, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1989)
!2412 = !{!2413, !2415, !2416, !2417, !2418, !2419, !2422, !2423, !2424}
!2413 = !DILocalVariable(name: "this", arg: 1, scope: !2408, type: !2414, flags: DIFlagArtificial | DIFlagObjectPointer)
!2414 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !537, size: 32)
!2415 = !DILocalVariable(name: "idx", arg: 2, scope: !2408, file: !379, line: 367, type: !15)
!2416 = !DILocalVariable(name: "fpacc_128b", scope: !2408, file: !379, line: 374, type: !198)
!2417 = !DILocalVariable(name: "num_subaccums", scope: !2408, file: !379, line: 380, type: !101)
!2418 = !DILocalVariable(name: "num_subaccums_out", scope: !2408, file: !379, line: 381, type: !101)
!2419 = !DILocalVariable(name: "elems_per_subaccum", scope: !2420, file: !379, line: 387, type: !101)
!2420 = distinct !DILexicalBlock(scope: !2421, file: !379, line: 386, column: 14)
!2421 = distinct !DILexicalBlock(scope: !2408, file: !379, line: 383, column: 23)
!2422 = !DILocalVariable(name: "out_elems_per_subaccum", scope: !2420, file: !379, line: 388, type: !101)
!2423 = !DILocalVariable(name: "ratio", scope: !2420, file: !379, line: 389, type: !101)
!2424 = !DILocalVariable(name: "ret", scope: !2420, file: !379, line: 391, type: !378)
!2425 = !DILocation(line: 0, scope: !2408)
!2426 = !DILocation(line: 367, column: 59, scope: !2408)
!2427 = !DILocation(line: 374, column: 9, scope: !2408)
!2428 = !DILocation(line: 374, column: 24, scope: !2408)
!2429 = !{!2430, !2430, i64 0, i64 1}
!2430 = !{!1547, i64 1, !"bool"}
!2431 = !DILocation(line: 380, column: 9, scope: !2408)
!2432 = !DILocation(line: 380, column: 28, scope: !2408)
!2433 = !DILocation(line: 381, column: 9, scope: !2408)
!2434 = !DILocation(line: 381, column: 28, scope: !2408)
!2435 = !DILocation(line: 387, column: 13, scope: !2420)
!2436 = !DILocation(line: 387, column: 32, scope: !2420)
!2437 = !DILocation(line: 388, column: 13, scope: !2420)
!2438 = !DILocation(line: 388, column: 32, scope: !2420)
!2439 = !DILocation(line: 389, column: 13, scope: !2420)
!2440 = !DILocation(line: 389, column: 32, scope: !2420)
!2441 = !DILocation(line: 391, column: 13, scope: !2420)
!2442 = !DILocation(line: 391, column: 50, scope: !2420)
!2443 = !DILocation(line: 411, column: 31, scope: !2444)
!2444 = distinct !DILexicalBlock(scope: !2445, file: !379, line: 410, column: 26)
!2445 = distinct !DILexicalBlock(scope: !2446, file: !379, line: 399, column: 35)
!2446 = distinct !DILexicalBlock(scope: !2447, file: !379, line: 398, column: 56)
!2447 = distinct !DILexicalBlock(scope: !2448, file: !379, line: 398, column: 36)
!2448 = distinct !DILexicalBlock(scope: !2449, file: !379, line: 394, column: 31)
!2449 = distinct !DILexicalBlock(scope: !2450, file: !379, line: 393, column: 51)
!2450 = distinct !DILexicalBlock(scope: !2420, file: !379, line: 393, column: 27)
!2451 = !DILocation(line: 411, column: 55, scope: !2444)
!2452 = !DILocation(line: 411, column: 61, scope: !2444)
!2453 = !DILocation(line: 411, column: 29, scope: !2444)
!2454 = !{!1746, !1746, i64 0, i64 32}
!2455 = !DILocation(line: 411, column: 25, scope: !2444)
!2456 = !DILocation(line: 414, column: 28, scope: !2446)
!2457 = !DILocation(line: 434, column: 9, scope: !2421)
!2458 = !DILocation(line: 435, column: 5, scope: !2408)
!2459 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj8EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj8EEE", scope: !374, file: !375, line: 59, type: !425, scopeLine: 59, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !424, retainedNodes: !2460)
!2460 = !{!2461, !2462}
!2461 = !DILocalVariable(name: "this", arg: 1, scope: !2459, type: !1903, flags: DIFlagArtificial | DIFlagObjectPointer)
!2462 = !DILocalVariable(name: "a", arg: 2, scope: !2459, file: !375, line: 59, type: !428)
!2463 = !DILocation(line: 0, scope: !2459)
!2464 = !DILocation(line: 59, column: 37, scope: !2459)
!2465 = !DILocation(line: 59, column: 52, scope: !2459)
!2466 = !DILocation(line: 59, column: 42, scope: !2459)
!2467 = !DILocation(line: 59, column: 56, scope: !2459)
!2468 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2Ev", scope: !378, file: !379, line: 229, type: !411, scopeLine: 231, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !410, retainedNodes: !2469)
!2469 = !{!2470}
!2470 = !DILocalVariable(name: "this", arg: 1, scope: !2468, type: !2387, flags: DIFlagArtificial | DIFlagObjectPointer)
!2471 = !DILocation(line: 0, scope: !2468)
!2472 = !DILocation(line: 230, column: 9, scope: !2468)
!2473 = !DILocation(line: 230, column: 14, scope: !2468)
!2474 = !DILocation(line: 232, column: 5, scope: !2468)
!2475 = distinct !DISubprogram(name: "accum_extract<8U, v16accfloat>", linkageName: "_ZN3aie6detailL13accum_extractILj8E11v16accfloatEEDaRKT0_j", scope: !7, file: !379, line: 123, type: !2476, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2483, retainedNodes: !2480)
!2476 = !DISubroutineType(types: !2477)
!2477 = !{!396, !2478, !15}
!2478 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2479, size: 32)
!2479 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !492)
!2480 = !{!2481, !2482}
!2481 = !DILocalVariable(name: "acc", arg: 1, scope: !2475, file: !379, line: 123, type: !2478)
!2482 = !DILocalVariable(name: "idx", arg: 2, scope: !2475, file: !379, line: 123, type: !15)
!2483 = !{!210, !2484}
!2484 = !DITemplateTypeParameter(name: "T", type: !493)
!2485 = !DILocation(line: 123, column: 88, scope: !2475)
!2486 = !DILocation(line: 123, column: 102, scope: !2475)
!2487 = !DILocation(line: 123, column: 137, scope: !2475)
!2488 = !DILocation(line: 123, column: 142, scope: !2475)
!2489 = !DILocation(line: 123, column: 116, scope: !2475)
!2490 = !DILocation(line: 123, column: 109, scope: !2475)
!2491 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEC2E10v8accfloat", scope: !378, file: !379, line: 242, type: !415, scopeLine: 244, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !414, retainedNodes: !2492)
!2492 = !{!2493, !2494}
!2493 = !DILocalVariable(name: "this", arg: 1, scope: !2491, type: !2387, flags: DIFlagArtificial | DIFlagObjectPointer)
!2494 = !DILocalVariable(name: "data", arg: 2, scope: !2491, file: !379, line: 242, type: !384)
!2495 = !DILocation(line: 0, scope: !2491)
!2496 = !DILocation(line: 242, column: 26, scope: !2491)
!2497 = !DILocation(line: 243, column: 9, scope: !2491)
!2498 = !DILocation(line: 243, column: 14, scope: !2491)
!2499 = !DILocation(line: 246, column: 5, scope: !2491)
!2500 = distinct !DISubprogram(name: "mac<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>, aie::vector_elem_ref<float, 8U>, aie::vector<float, 8U> >", linkageName: "_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS_15vector_elem_refIfLj8EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSF_T0_RKT1_", scope: !8, file: !1506, line: 4866, type: !2501, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2517, retainedNodes: !2513)
!2501 = !DISubroutineType(types: !2502)
!2502 = !{!2503, !2512, !322, !1929}
!2503 = !DIDerivedType(tag: DW_TAG_typedef, name: "operand_base_type_t<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1> >", scope: !8, file: !1084, line: 410, baseType: !2504)
!2504 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2505, file: !1506, line: 112, baseType: !2508)
!2505 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "operand_base_type<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1> >", scope: !8, file: !1506, line: 110, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2506, identifier: "_ZTSN3aie17operand_base_typeINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEEEE")
!2506 = !{!2507}
!2507 = !DITemplateTypeParameter(name: "T", type: !1030)
!2508 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !1030, file: !45, line: 459, baseType: !2509)
!2509 = !DIDerivedType(tag: DW_TAG_typedef, name: "op_value_type_t<result_type>", scope: !8, file: !45, line: 355, baseType: !2510)
!2510 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2511, file: !45, line: 242, baseType: !374)
!2511 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "op_value_type_helper<aie::accum<accfloat, 8U> >", scope: !8, file: !45, line: 240, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !948, identifier: "_ZTSN3aie20op_value_type_helperINS_5accumI8accfloatLj8EEEEE")
!2512 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1042, size: 32)
!2513 = !{!2514, !2515, !2516}
!2514 = !DILocalVariable(name: "acc", arg: 1, scope: !2500, file: !1506, line: 4866, type: !2512)
!2515 = !DILocalVariable(name: "a", arg: 2, scope: !2500, file: !1506, line: 4866, type: !322)
!2516 = !DILocalVariable(name: "v", arg: 3, scope: !2500, file: !1506, line: 4866, type: !1929)
!2517 = !{!2518, !1936, !1937}
!2518 = !DITemplateTypeParameter(name: "Acc", type: !1030)
!2519 = !DILocation(line: 4866, column: 31, scope: !2500)
!2520 = !DILocation(line: 4866, column: 38, scope: !2500)
!2521 = !DILocation(line: 4866, column: 52, scope: !2500)
!2522 = !DILocation(line: 4875, column: 20, scope: !2523)
!2523 = distinct !DILexicalBlock(scope: !2524, file: !1506, line: 4874, column: 37)
!2524 = distinct !DILexicalBlock(scope: !2525, file: !1506, line: 4874, column: 24)
!2525 = distinct !DILexicalBlock(scope: !2526, file: !1506, line: 4871, column: 24)
!2526 = distinct !DILexicalBlock(scope: !2500, file: !1506, line: 4868, column: 24)
!2527 = !DILocation(line: 4875, column: 25, scope: !2523)
!2528 = !DILocation(line: 4875, column: 37, scope: !2523)
!2529 = !DILocation(line: 4875, column: 16, scope: !2523)
!2530 = !{!2531, !2531, i64 0, i64 8}
!2531 = !{!1547, i64 8, !"_ZTSN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE", !2532, i64 0, i64 8}
!2532 = !{!1547, i64 8, !"_ZTSN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEE", !1841, i64 0, i64 8}
!2533 = !DILocation(line: 4875, column: 9, scope: !2523)
!2534 = distinct !DISubprogram(name: "op_add<aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6op_addINS_5accumI8accfloatLj8EEEEENS_8unary_opIT_LNS_9OperationE1EEERKS5_", scope: !8, file: !1506, line: 380, type: !2535, scopeLine: 381, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2539, retainedNodes: !2537)
!2535 = !DISubroutineType(types: !2536)
!2536 = !{!1030, !447}
!2537 = !{!2538}
!2538 = !DILocalVariable(name: "acc", arg: 1, scope: !2534, file: !1506, line: 380, type: !447)
!2539 = !{!1935}
!2540 = !DILocation(line: 380, column: 63, scope: !2534)
!2541 = !DILocation(line: 382, column: 13, scope: !2534)
!2542 = !DILocation(line: 382, column: 12, scope: !2534)
!2543 = !DILocation(line: 382, column: 5, scope: !2534)
!2544 = distinct !DISubprogram(name: "mac<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>, aie::unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>, aie::vector<float, 8U> >", linkageName: "_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS_6vectorIfLj8EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSG_T0_RKT1_", scope: !8, file: !1506, line: 4866, type: !2545, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2551, retainedNodes: !2547)
!2545 = !DISubroutineType(types: !2546)
!2546 = !{!2503, !2512, !1017, !1929}
!2547 = !{!2548, !2549, !2550}
!2548 = !DILocalVariable(name: "acc", arg: 1, scope: !2544, file: !1506, line: 4866, type: !2512)
!2549 = !DILocalVariable(name: "a", arg: 2, scope: !2544, file: !1506, line: 4866, type: !1017)
!2550 = !DILocalVariable(name: "v", arg: 3, scope: !2544, file: !1506, line: 4866, type: !1929)
!2551 = !{!2518, !2552, !1937}
!2552 = !DITemplateTypeParameter(name: "E", type: !1017)
!2553 = !DILocation(line: 4866, column: 31, scope: !2544)
!2554 = !DILocation(line: 4866, column: 38, scope: !2544)
!2555 = !DILocation(line: 4866, column: 52, scope: !2544)
!2556 = !DILocation(line: 4878, column: 20, scope: !2557)
!2557 = distinct !DILexicalBlock(scope: !2558, file: !1506, line: 4877, column: 39)
!2558 = distinct !DILexicalBlock(scope: !2559, file: !1506, line: 4877, column: 24)
!2559 = distinct !DILexicalBlock(scope: !2560, file: !1506, line: 4874, column: 24)
!2560 = distinct !DILexicalBlock(scope: !2561, file: !1506, line: 4871, column: 24)
!2561 = distinct !DILexicalBlock(scope: !2544, file: !1506, line: 4868, column: 24)
!2562 = !DILocation(line: 4878, column: 25, scope: !2557)
!2563 = !DILocation(line: 4878, column: 28, scope: !2557)
!2564 = !DILocation(line: 4878, column: 36, scope: !2557)
!2565 = !DILocation(line: 4878, column: 16, scope: !2557)
!2566 = !DILocation(line: 4878, column: 9, scope: !2557)
!2567 = distinct !DISubprogram(name: "op_none<aie::vector_elem_ref<float, 8U> >", linkageName: "_ZN3aie7op_noneINS_15vector_elem_refIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_", scope: !8, file: !1506, line: 409, type: !2568, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !970, retainedNodes: !2570)
!2568 = !DISubroutineType(types: !2569)
!2569 = !{!1017, !320}
!2570 = !{!2571}
!2571 = !DILocalVariable(name: "e", arg: 1, scope: !2567, file: !1506, line: 409, type: !320)
!2572 = !DILocation(line: 409, column: 57, scope: !2567)
!2573 = !DILocation(line: 411, column: 13, scope: !2567)
!2574 = !DILocation(line: 411, column: 12, scope: !2567)
!2575 = !DILocation(line: 411, column: 5, scope: !2567)
!2576 = distinct !DISubprogram(name: "mac<aie::unary_op<aie::accum<accfloat, 8U>, (aie::Operation)1>, aie::unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0>, aie::unary_op<aie::vector<float, 8U>, (aie::Operation)0> >", linkageName: "_ZN3aie3macINS_8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EEENS1_INS_15vector_elem_refIfLj8EEELS5_0EEENS1_INS_6vectorIfLj8EEELS5_0EEEEENS_17operand_base_typeINS_6detail5utils10remove_allIT_E4typeEE4typeERKSH_T0_RKT1_", scope: !8, file: !1506, line: 4866, type: !2577, scopeLine: 4867, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2596, retainedNodes: !2580)
!2577 = !DISubroutineType(types: !2578)
!2578 = !{!2503, !2512, !1017, !2579}
!2579 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1016, size: 32)
!2580 = !{!2581, !2582, !2583, !2584, !2595}
!2581 = !DILocalVariable(name: "acc", arg: 1, scope: !2576, file: !1506, line: 4866, type: !2512)
!2582 = !DILocalVariable(name: "a", arg: 2, scope: !2576, file: !1506, line: 4866, type: !1017)
!2583 = !DILocalVariable(name: "v", arg: 3, scope: !2576, file: !1506, line: 4866, type: !2579)
!2584 = !DILocalVariable(name: "Op1", scope: !2585, file: !1506, line: 4902, type: !940)
!2585 = distinct !DILexicalBlock(scope: !2586, file: !1506, line: 4901, column: 14)
!2586 = distinct !DILexicalBlock(scope: !2587, file: !1506, line: 4898, column: 28)
!2587 = distinct !DILexicalBlock(scope: !2588, file: !1506, line: 4896, column: 28)
!2588 = distinct !DILexicalBlock(scope: !2589, file: !1506, line: 4894, column: 28)
!2589 = distinct !DILexicalBlock(scope: !2590, file: !1506, line: 4892, column: 28)
!2590 = distinct !DILexicalBlock(scope: !2591, file: !1506, line: 4880, column: 10)
!2591 = distinct !DILexicalBlock(scope: !2592, file: !1506, line: 4877, column: 24)
!2592 = distinct !DILexicalBlock(scope: !2593, file: !1506, line: 4874, column: 24)
!2593 = distinct !DILexicalBlock(scope: !2594, file: !1506, line: 4871, column: 24)
!2594 = distinct !DILexicalBlock(scope: !2576, file: !1506, line: 4868, column: 24)
!2595 = !DILocalVariable(name: "Op2", scope: !2585, file: !1506, line: 4903, type: !940)
!2596 = !{!2518, !2552, !2597}
!2597 = !DITemplateTypeParameter(name: "Vec", type: !1004)
!2598 = !DILocation(line: 4866, column: 31, scope: !2576)
!2599 = !DILocation(line: 4866, column: 38, scope: !2576)
!2600 = !DILocation(line: 4866, column: 52, scope: !2576)
!2601 = !DILocation(line: 4902, column: 13, scope: !2585)
!2602 = !DILocation(line: 4902, column: 33, scope: !2585)
!2603 = !{!2604, !2604, i64 0, i64 4}
!2604 = !{!1547, i64 4, !"_ZTSN3aie9OperationE"}
!2605 = !DILocation(line: 4903, column: 13, scope: !2585)
!2606 = !DILocation(line: 4903, column: 33, scope: !2585)
!2607 = !DILocation(line: 4906, column: 156, scope: !2608)
!2608 = distinct !DILexicalBlock(scope: !2585, file: !1506, line: 4905, column: 27)
!2609 = !DILocation(line: 4906, column: 158, scope: !2608)
!2610 = !DILocation(line: 4906, column: 134, scope: !2608)
!2611 = !DILocation(line: 4906, column: 191, scope: !2608)
!2612 = !DILocation(line: 4906, column: 170, scope: !2608)
!2613 = !DILocation(line: 4906, column: 195, scope: !2608)
!2614 = !DILocation(line: 4906, column: 197, scope: !2608)
!2615 = !DILocation(line: 4906, column: 229, scope: !2608)
!2616 = !{!2617, !2617, i64 0, i64 32}
!2617 = !{!1547, i64 32, !"_ZTSN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEE", !2618, i64 0, i64 32}
!2618 = !{!1547, i64 32, !"_ZTSN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEE", !1731, i64 0, i64 32}
!2619 = !DILocation(line: 4906, column: 208, scope: !2608)
!2620 = !DILocation(line: 4906, column: 233, scope: !2608)
!2621 = !DILocation(line: 4906, column: 237, scope: !2608)
!2622 = !DILocation(line: 4906, column: 24, scope: !2608)
!2623 = !{!2624, !2624, i64 0, i64 8}
!2624 = !{!1547, i64 8, !"_ZTSN3aie21vector_elem_const_refIfLj8EEE", !1546, i64 0, i64 4, !1781, i64 4, i64 4}
!2625 = !DILocation(line: 4906, column: 17, scope: !2608)
!2626 = !DILocation(line: 4909, column: 9, scope: !2586)
!2627 = !DILocation(line: 4911, column: 1, scope: !2576)
!2628 = distinct !DISubprogram(name: "op_none<aie::vector<float, 8U> >", linkageName: "_ZN3aie7op_noneINS_6vectorIfLj8EEEEENS_8unary_opIT_LNS_9OperationE0EEERKS4_", scope: !8, file: !1506, line: 409, type: !2629, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !992, retainedNodes: !2631)
!2629 = !DISubroutineType(types: !2630)
!2630 = !{!1004, !1929}
!2631 = !{!2632}
!2632 = !DILocalVariable(name: "e", arg: 1, scope: !2628, file: !1506, line: 409, type: !1929)
!2633 = !DILocation(line: 409, column: 57, scope: !2628)
!2634 = !DILocation(line: 411, column: 13, scope: !2628)
!2635 = !DILocation(line: 411, column: 12, scope: !2628)
!2636 = !DILocation(line: 411, column: 5, scope: !2628)
!2637 = distinct !DISubprogram(name: "run<8U, 8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_", scope: !2638, file: !58, line: 792, type: !2646, scopeLine: 793, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2655, declaration: !2654, retainedNodes: !2660)
!2638 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "mul_bits<(aie::detail::MulMacroOp)2, 32U, 32U, float, 32U, float>", scope: !7, file: !58, line: 776, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2639, identifier: "_ZTSN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfEE")
!2639 = !{!2640, !2641, !2642, !2643, !2644, !2645}
!2640 = !DITemplateValueParameter(name: "MulOp", type: !57, value: i32 2)
!2641 = !DITemplateValueParameter(name: "AccumBits", type: !15, value: i32 32)
!2642 = !DITemplateValueParameter(name: "Type1Bits", type: !15, value: i32 32)
!2643 = !DITemplateTypeParameter(name: "T1", type: !80)
!2644 = !DITemplateValueParameter(name: "Type2Bits", type: !15, value: i32 32)
!2645 = !DITemplateTypeParameter(name: "T2", type: !80)
!2646 = !DISubroutineType(types: !2647)
!2647 = !{!2648, !308, !176, !2651, !176, !447}
!2648 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_type<8U>", scope: !2650, file: !2649, line: 80, baseType: !374)
!2649 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp", directory: "")
!2650 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "mul_bits_impl<(aie::detail::MulMacroOp)2, 32U, 32U, float, 32U, float>", scope: !7, file: !2649, line: 73, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2639, identifier: "_ZTSN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfEE")
!2651 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2652, size: 32)
!2652 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2653)
!2653 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type2<8U>", scope: !2638, file: !58, line: 781, baseType: !188)
!2654 = !DISubprogram(name: "run<8U, 8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail8mul_bitsILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8ELj8EJNS_5accumI8accfloatLj8EEEEEEDaNS_21vector_elem_const_refIfXT_EEEbRKNS_6vectorIfXT0_EEEbDpRKT1_", scope: !2638, file: !58, line: 792, type: !2646, scopeLine: 792, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2655)
!2655 = !{!210, !2656, !2657}
!2656 = !DITemplateValueParameter(name: "Elems2", type: !15, value: i32 8)
!2657 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "Acc", value: !2658)
!2658 = !{!2659}
!2659 = !DITemplateTypeParameter(type: !374)
!2660 = !{!2661, !2662, !2663, !2664, !2665}
!2661 = !DILocalVariable(name: "a", arg: 1, scope: !2637, file: !58, line: 792, type: !308)
!2662 = !DILocalVariable(name: "a_sign", arg: 2, scope: !2637, file: !58, line: 792, type: !176)
!2663 = !DILocalVariable(name: "v", arg: 3, scope: !2637, file: !58, line: 792, type: !2651)
!2664 = !DILocalVariable(name: "v_sign", arg: 4, scope: !2637, file: !58, line: 792, type: !176)
!2665 = !DILocalVariable(name: "acc", arg: 5, scope: !2637, file: !58, line: 792, type: !447)
!2666 = !DILocation(line: 792, column: 54, scope: !2637)
!2667 = !DILocation(line: 792, column: 62, scope: !2637)
!2668 = !DILocation(line: 792, column: 98, scope: !2637)
!2669 = !DILocation(line: 792, column: 106, scope: !2637)
!2670 = !DILocation(line: 792, column: 129, scope: !2637)
!2671 = !DILocation(line: 794, column: 83, scope: !2637)
!2672 = !DILocation(line: 794, column: 86, scope: !2637)
!2673 = !{i8 0, i8 2}
!2674 = !DILocation(line: 794, column: 94, scope: !2637)
!2675 = !DILocation(line: 794, column: 97, scope: !2637)
!2676 = !DILocation(line: 794, column: 105, scope: !2637)
!2677 = !DILocation(line: 794, column: 16, scope: !2637)
!2678 = !DILocation(line: 794, column: 9, scope: !2637)
!2679 = distinct !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !961, file: !45, line: 413, type: !2680, scopeLine: 414, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2684, retainedNodes: !2685)
!2680 = !DISubroutineType(types: !2681)
!2681 = !{!966, !2682}
!2682 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2683, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2683 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !961)
!2684 = !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !961, file: !45, line: 413, type: !2680, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2685 = !{!2686}
!2686 = !DILocalVariable(name: "this", arg: 1, scope: !2679, type: !2687, flags: DIFlagArtificial | DIFlagObjectPointer)
!2687 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2683, size: 32)
!2688 = !DILocation(line: 0, scope: !2679)
!2689 = !DILocation(line: 418, column: 20, scope: !2690)
!2690 = distinct !DILexicalBlock(scope: !2679, file: !45, line: 415, column: 22)
!2691 = distinct !DISubprogram(name: "vector_elem_const_ref", linkageName: "_ZN3aie21vector_elem_const_refIfLj8EEC2ERKNS_15vector_elem_refIfLj8EEE", scope: !308, file: !309, line: 35, type: !317, scopeLine: 38, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !316, retainedNodes: !2692)
!2692 = !{!2693, !2695}
!2693 = !DILocalVariable(name: "this", arg: 1, scope: !2691, type: !2694, flags: DIFlagArtificial | DIFlagObjectPointer)
!2694 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !308, size: 32)
!2695 = !DILocalVariable(name: "ref", arg: 2, scope: !2691, file: !309, line: 35, type: !320)
!2696 = !DILocation(line: 0, scope: !2691)
!2697 = !DILocation(line: 35, column: 66, scope: !2691)
!2698 = !DILocation(line: 36, column: 9, scope: !2691)
!2699 = !DILocation(line: 36, column: 16, scope: !2691)
!2700 = !DILocation(line: 36, column: 20, scope: !2691)
!2701 = !{!1841, !1546, i64 0, i64 4}
!2702 = !DILocation(line: 37, column: 9, scope: !2691)
!2703 = !DILocation(line: 37, column: 16, scope: !2691)
!2704 = !DILocation(line: 37, column: 20, scope: !2691)
!2705 = !{!1841, !1781, i64 4, i64 4}
!2706 = !{!2624, !1781, i64 4, i64 4}
!2707 = !DILocation(line: 39, column: 5, scope: !2691)
!2708 = distinct !DISubprogram(name: "get_mul_sign<aie::unary_op<aie::vector_elem_ref<float, 8U>, (aie::Operation)0> >", linkageName: "_ZN3aie6detail12get_mul_signINS_8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEEEEbT_", scope: !7, file: !58, line: 640, type: !2709, scopeLine: 641, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2713, retainedNodes: !2711)
!2709 = !DISubroutineType(types: !2710)
!2710 = !{!176, !1017}
!2711 = !{!2712}
!2712 = !DILocalVariable(name: "v", arg: 1, scope: !2708, file: !58, line: 640, type: !1017)
!2713 = !{!2714}
!2714 = !DITemplateTypeParameter(name: "T", type: !1017)
!2715 = !DILocation(line: 640, column: 31, scope: !2708)
!2716 = !DILocation(line: 645, column: 13, scope: !2717)
!2717 = distinct !DILexicalBlock(scope: !2708, file: !58, line: 642, column: 23)
!2718 = distinct !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !983, file: !45, line: 413, type: !2719, scopeLine: 414, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2723, retainedNodes: !2724)
!2719 = !DISubroutineType(types: !2720)
!2720 = !{!988, !2721}
!2721 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2722, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2722 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !983)
!2723 = !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EE7parent1Ev", scope: !983, file: !45, line: 413, type: !2719, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2724 = !{!2725}
!2725 = !DILocalVariable(name: "this", arg: 1, scope: !2718, type: !2726, flags: DIFlagArtificial | DIFlagObjectPointer)
!2726 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2722, size: 32)
!2727 = !DILocation(line: 0, scope: !2718)
!2728 = !DILocation(line: 418, column: 20, scope: !2729)
!2729 = distinct !DILexicalBlock(scope: !2718, file: !45, line: 415, column: 22)
!2730 = distinct !DISubprogram(name: "get_mul_sign<aie::unary_op<aie::vector<float, 8U>, (aie::Operation)0> >", linkageName: "_ZN3aie6detail12get_mul_signINS_8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EEEEEbT_", scope: !7, file: !58, line: 640, type: !2731, scopeLine: 641, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2735, retainedNodes: !2733)
!2731 = !DISubroutineType(types: !2732)
!2732 = !{!176, !1004}
!2733 = !{!2734}
!2734 = !DILocalVariable(name: "v", arg: 1, scope: !2730, file: !58, line: 640, type: !1004)
!2735 = !{!2736}
!2736 = !DITemplateTypeParameter(name: "T", type: !1004)
!2737 = !DILocation(line: 640, column: 31, scope: !2730)
!2738 = !DILocation(line: 645, column: 13, scope: !2739)
!2739 = distinct !DILexicalBlock(scope: !2730, file: !58, line: 642, column: 23)
!2740 = distinct !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev", scope: !937, file: !45, line: 413, type: !2741, scopeLine: 414, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2745, retainedNodes: !2746)
!2741 = !DISubroutineType(types: !2742)
!2742 = !{!943, !2743}
!2743 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2744, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2744 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !937)
!2745 = !DISubprogram(name: "parent1", linkageName: "_ZNK3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EE7parent1Ev", scope: !937, file: !45, line: 413, type: !2741, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2746 = !{!2747}
!2747 = !DILocalVariable(name: "this", arg: 1, scope: !2740, type: !2748, flags: DIFlagArtificial | DIFlagObjectPointer)
!2748 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2744, size: 32)
!2749 = !DILocation(line: 0, scope: !2740)
!2750 = !DILocation(line: 418, column: 20, scope: !2751)
!2751 = distinct !DILexicalBlock(scope: !2740, file: !45, line: 415, column: 22)
!2752 = distinct !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_", scope: !2650, file: !2649, line: 113, type: !2753, scopeLine: 114, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2760, declaration: !2759, retainedNodes: !2761)
!2753 = !DISubroutineType(types: !2754)
!2754 = !{!2648, !2755, !198, !2756, !198, !447}
!2755 = !DIDerivedType(tag: DW_TAG_typedef, name: "T", file: !2649, line: 75, baseType: !80)
!2756 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2757, size: 32)
!2757 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2758)
!2758 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type<8U>", scope: !2650, file: !2649, line: 78, baseType: !188)
!2759 = !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEEfbRKNS_6vectorIfXT_EEEbDpRKT0_", scope: !2650, file: !2649, line: 113, type: !2753, scopeLine: 113, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2760)
!2760 = !{!210, !2657}
!2761 = !{!2762, !2763, !2764, !2765, !2766}
!2762 = !DILocalVariable(name: "a", arg: 1, scope: !2752, file: !2649, line: 113, type: !2755)
!2763 = !DILocalVariable(name: "a_sign", arg: 2, scope: !2752, file: !2649, line: 113, type: !198)
!2764 = !DILocalVariable(name: "v", arg: 3, scope: !2752, file: !2649, line: 113, type: !2756)
!2765 = !DILocalVariable(name: "v_sign", arg: 4, scope: !2752, file: !2649, line: 113, type: !198)
!2766 = !DILocalVariable(name: "acc", arg: 5, scope: !2752, file: !2649, line: 113, type: !447)
!2767 = !{!2768, !2768, i64 0, i64 4}
!2768 = !{!1547, i64 4, !"float"}
!2769 = !DILocation(line: 113, column: 36, scope: !2752)
!2770 = !DILocation(line: 113, column: 50, scope: !2752)
!2771 = !DILocation(line: 113, column: 84, scope: !2752)
!2772 = !DILocation(line: 113, column: 98, scope: !2752)
!2773 = !DILocation(line: 113, column: 121, scope: !2752)
!2774 = !DILocation(line: 115, column: 20, scope: !2752)
!2775 = !DILocation(line: 115, column: 49, scope: !2752)
!2776 = !DILocation(line: 115, column: 57, scope: !2752)
!2777 = !DILocation(line: 115, column: 60, scope: !2752)
!2778 = !DILocation(line: 115, column: 68, scope: !2752)
!2779 = !DILocation(line: 115, column: 16, scope: !2752)
!2780 = !DILocation(line: 115, column: 9, scope: !2752)
!2781 = distinct !DISubprogram(name: "operator float", linkageName: "_ZNK3aie21vector_elem_const_refIfLj8EEcvfEv", scope: !308, file: !309, line: 52, type: !355, scopeLine: 53, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !359, retainedNodes: !2782)
!2782 = !{!2783}
!2783 = !DILocalVariable(name: "this", arg: 1, scope: !2781, type: !2784, flags: DIFlagArtificial | DIFlagObjectPointer)
!2784 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !348, size: 32)
!2785 = !DILocation(line: 0, scope: !2781)
!2786 = !DILocation(line: 54, column: 16, scope: !2781)
!2787 = !DILocation(line: 54, column: 9, scope: !2781)
!2788 = distinct !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_", scope: !2650, file: !2649, line: 93, type: !2789, scopeLine: 94, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2760, declaration: !2791, retainedNodes: !2792)
!2789 = !DISubroutineType(types: !2790)
!2790 = !{!2648, !2756, !198, !2756, !198, !447}
!2791 = !DISubprogram(name: "run<8U, aie::accum<accfloat, 8U> >", linkageName: "_ZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_", scope: !2650, file: !2649, line: 93, type: !2789, scopeLine: 93, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2760)
!2792 = !{!2793, !2794, !2795, !2796, !2797, !2798, !2801, !2802}
!2793 = !DILocalVariable(name: "v1", arg: 1, scope: !2788, file: !2649, line: 93, type: !2756)
!2794 = !DILocalVariable(name: "v1_sign", arg: 2, scope: !2788, file: !2649, line: 93, type: !198)
!2795 = !DILocalVariable(name: "v2", arg: 3, scope: !2788, file: !2649, line: 93, type: !2756)
!2796 = !DILocalVariable(name: "v2_sign", arg: 4, scope: !2788, file: !2649, line: 93, type: !198)
!2797 = !DILocalVariable(name: "acc", arg: 5, scope: !2788, file: !2649, line: 93, type: !447)
!2798 = !DILocalVariable(name: "mul_op", scope: !2788, file: !2649, line: 95, type: !2799)
!2799 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2800)
!2800 = distinct !DICompositeType(tag: DW_TAG_class_type, file: !2649, line: 87, size: 8, flags: DIFlagTypePassByValue, elements: !137, identifier: "_ZTSZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavEUlDpOT_E_")
!2801 = !DILocalVariable(name: "num_mul", scope: !2788, file: !2649, line: 97, type: !101)
!2802 = !DILocalVariable(name: "ret", scope: !2788, file: !2649, line: 99, type: !2648)
!2803 = !DILocation(line: 93, column: 60, scope: !2788)
!2804 = !DILocation(line: 93, column: 75, scope: !2788)
!2805 = !DILocation(line: 93, column: 110, scope: !2788)
!2806 = !DILocation(line: 93, column: 125, scope: !2788)
!2807 = !DILocation(line: 93, column: 149, scope: !2788)
!2808 = !DILocation(line: 95, column: 9, scope: !2788)
!2809 = !DILocation(line: 95, column: 24, scope: !2788)
!2810 = !DILocation(line: 97, column: 9, scope: !2788)
!2811 = !DILocation(line: 97, column: 28, scope: !2788)
!2812 = !DILocation(line: 99, column: 27, scope: !2788)
!2813 = !DILocation(line: 101, column: 38, scope: !2788)
!2814 = !DILocation(line: 101, column: 39, scope: !2788)
!2815 = !DILocation(line: 101, column: 9, scope: !2788)
!2816 = !DILocation(line: 109, column: 5, scope: !2788)
!2817 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf", scope: !2818, file: !2097, line: 63, type: !2821, scopeLine: 64, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2820, retainedNodes: !2825)
!2818 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "broadcast_bits<32U, float, 8U>", scope: !7, file: !2097, line: 59, size: 8, flags: DIFlagTypePassByValue, elements: !2819, templateParams: !2104, identifier: "_ZTSN3aie6detail14broadcast_bitsILj32EfLj8EEE")
!2819 = !{!2820}
!2820 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail14broadcast_bitsILj32EfLj8EE3runERKf", scope: !2818, file: !2097, line: 63, type: !2821, scopeLine: 63, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!2821 = !DISubroutineType(types: !2822)
!2822 = !{!2823, !2824}
!2823 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !2818, file: !2097, line: 61, baseType: !188)
!2824 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !153, size: 32)
!2825 = !{!2826}
!2826 = !DILocalVariable(name: "a", arg: 1, scope: !2817, file: !2097, line: 63, type: !2824)
!2827 = !DILocation(line: 63, column: 37, scope: !2817)
!2828 = !DILocation(line: 65, column: 61, scope: !2817)
!2829 = !DILocation(line: 65, column: 16, scope: !2817)
!2830 = !DILocation(line: 65, column: 9, scope: !2817)
!2831 = distinct !DISubprogram(name: "unroll_times<1U, (lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils12unroll_timesILj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT0_", scope: !1505, file: !2832, line: 612, type: !2833, scopeLine: 613, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2847, retainedNodes: !2845)
!2832 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/utils.hpp", directory: "")
!2833 = !DISubroutineType(types: !2834)
!2834 = !{null, !2835}
!2835 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2836, size: 32)
!2836 = distinct !DICompositeType(tag: DW_TAG_class_type, scope: !2788, file: !2649, line: 101, size: 160, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !2837, identifier: "_ZTSZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_EUlT_E_")
!2837 = !{!2838, !2840, !2841, !2842, !2843}
!2838 = !DIDerivedType(tag: DW_TAG_member, name: "mul_op", scope: !2836, file: !2649, line: 102, baseType: !2839, size: 32)
!2839 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2799, size: 32)
!2840 = !DIDerivedType(tag: DW_TAG_member, name: "v1", scope: !2836, file: !2649, line: 102, baseType: !2756, size: 32, offset: 32)
!2841 = !DIDerivedType(tag: DW_TAG_member, name: "v2", scope: !2836, file: !2649, line: 103, baseType: !2756, size: 32, offset: 64)
!2842 = !DIDerivedType(tag: DW_TAG_member, name: "acc", scope: !2836, file: !2649, line: 104, baseType: !447, size: 32, offset: 96)
!2843 = !DIDerivedType(tag: DW_TAG_member, name: "ret", scope: !2836, file: !2649, line: 105, baseType: !2844, size: 32, offset: 128)
!2844 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2648, size: 32)
!2845 = !{!2846}
!2846 = !DILocalVariable(name: "fn", arg: 1, scope: !2831, file: !2832, line: 612, type: !2835)
!2847 = !{!2848, !2849}
!2848 = !DITemplateValueParameter(name: "Times", type: !15, value: i32 1)
!2849 = !DITemplateTypeParameter(name: "Fn", type: !2836)
!2850 = !DILocation(line: 612, column: 24, scope: !2831)
!2851 = !DILocation(line: 614, column: 56, scope: !2831)
!2852 = !DILocation(line: 614, column: 5, scope: !2831)
!2853 = !DILocation(line: 615, column: 1, scope: !2831)
!2854 = distinct !DISubprogram(name: "unroll_for<unsigned int, 0U, 1U, 1U, (lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS7_IS8_XT_EEERKNS_6vectorIfXT_EEEbSE_bDpRKT0_EUlT_E_EEvOT3_", scope: !1505, file: !2832, line: 590, type: !2833, scopeLine: 591, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2857, retainedNodes: !2855)
!2855 = !{!2856}
!2856 = !DILocalVariable(name: "fn", arg: 1, scope: !2854, file: !2832, line: 590, type: !2835)
!2857 = !{!2858, !2859, !2860, !2861, !2849}
!2858 = !DITemplateTypeParameter(name: "T", type: !15)
!2859 = !DITemplateValueParameter(name: "Start", type: !15, value: i32 0)
!2860 = !DITemplateValueParameter(name: "End", type: !15, value: i32 1)
!2861 = !DITemplateValueParameter(name: "Step", type: !15, value: i32 1)
!2862 = !DILocation(line: 590, column: 22, scope: !2854)
!2863 = !DILocation(line: 592, column: 77, scope: !2854)
!2864 = !DILocation(line: 592, column: 5, scope: !2854)
!2865 = !DILocation(line: 593, column: 1, scope: !2854)
!2866 = distinct !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2867, file: !2832, line: 495, type: !2833, scopeLine: 496, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2871, declaration: !2870, retainedNodes: !2872)
!2867 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unroll_for_helper<unsigned int, 0U, 1U, 0U, 1U>", scope: !1505, file: !2832, line: 489, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2868, identifier: "_ZTSN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EEE")
!2868 = !{!2858, !2859, !2860, !2869, !2861}
!2869 = !DITemplateValueParameter(name: "It", type: !15, value: i32 0)
!2870 = !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2867, file: !2832, line: 495, type: !2833, scopeLine: 495, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2871)
!2871 = !{!2849}
!2872 = !{!2873, !2874, !2888}
!2873 = !DILocalVariable(name: "fn", arg: 1, scope: !2866, file: !2832, line: 495, type: !2835)
!2874 = !DILocalVariable(name: "it", scope: !2875, file: !2832, line: 498, type: !2877)
!2875 = distinct !DILexicalBlock(scope: !2876, file: !2832, line: 497, column: 73)
!2876 = distinct !DILexicalBlock(scope: !2866, file: !2832, line: 497, column: 23)
!2877 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2878)
!2878 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iteration_dim<unsigned int, 0U, 1U, 0U>", scope: !1505, file: !2832, line: 465, size: 8, flags: DIFlagTypePassByValue, elements: !2879, templateParams: !2887, identifier: "_ZTSN3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEE")
!2879 = !{!2880, !2884, !2885, !2886}
!2880 = !DISubprogram(name: "operator unsigned int", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv", scope: !2878, file: !2832, line: 467, type: !2881, scopeLine: 467, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2881 = !DISubroutineType(types: !2882)
!2882 = !{!15, !2883}
!2883 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2877, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2884 = !DISubprogram(name: "min", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE3minEv", scope: !2878, file: !2832, line: 472, type: !2881, scopeLine: 472, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2885 = !DISubprogram(name: "max", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE3maxEv", scope: !2878, file: !2832, line: 477, type: !2881, scopeLine: 477, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2886 = !DISubprogram(name: "current", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv", scope: !2878, file: !2832, line: 482, type: !2881, scopeLine: 482, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2887 = !{!2858, !2859, !2860, !2869}
!2888 = !DILocalVariable(name: "next_it", scope: !2875, file: !2832, line: 511, type: !101)
!2889 = !DILocation(line: 495, column: 31, scope: !2866)
!2890 = !DILocation(line: 498, column: 13, scope: !2875)
!2891 = !DILocation(line: 498, column: 56, scope: !2875)
!2892 = !DILocation(line: 505, column: 17, scope: !2893)
!2893 = distinct !DILexicalBlock(scope: !2875, file: !2832, line: 504, column: 27)
!2894 = !DILocation(line: 511, column: 13, scope: !2875)
!2895 = !DILocation(line: 511, column: 25, scope: !2875)
!2896 = !DILocation(line: 517, column: 87, scope: !2875)
!2897 = !DILocation(line: 517, column: 13, scope: !2875)
!2898 = !DILocation(line: 518, column: 9, scope: !2876)
!2899 = !DILocation(line: 519, column: 5, scope: !2866)
!2900 = distinct !DISubprogram(name: "operator()<aie::detail::utils::iteration_dim<unsigned int, 0U, 1U, 0U> >", linkageName: "_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_ENKUlT_E_clINS0_5utils13iteration_dimIjLj0ELj1ELj0EEEEEDaSH_", scope: !2836, file: !2649, line: 101, type: !2901, scopeLine: 101, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2906, declaration: !2905, retainedNodes: !2908)
!2901 = !DISubroutineType(types: !2902)
!2902 = !{null, !2903, !2878}
!2903 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2904, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2904 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2836)
!2905 = !DISubprogram(name: "operator()<aie::detail::utils::iteration_dim<unsigned int, 0U, 1U, 0U> >", scope: !2836, file: !2649, line: 101, type: !2901, scopeLine: 101, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2906)
!2906 = !{!2907}
!2907 = !DITemplateTypeParameter(name: "idx:auto", type: !2878)
!2908 = !{!2909, !2911, !2912}
!2909 = !DILocalVariable(name: "this", arg: 1, scope: !2900, type: !2910, flags: DIFlagArtificial | DIFlagObjectPointer)
!2910 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2904, size: 32)
!2911 = !DILocalVariable(name: "idx", arg: 2, scope: !2900, file: !2649, line: 101, type: !2878)
!2912 = !DILocalVariable(name: "tmp", scope: !2900, file: !2649, line: 102, type: !2913)
!2913 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2914)
!2914 = !DIDerivedType(tag: DW_TAG_typedef, name: "accum_type<16>", file: !2649, line: 80, baseType: !498)
!2915 = !DILocation(line: 0, scope: !2900)
!2916 = !DILocation(line: 101, column: 47, scope: !2900)
!2917 = !DILocation(line: 102, column: 13, scope: !2900)
!2918 = !DILocation(line: 102, column: 34, scope: !2900)
!2919 = !DILocation(line: 102, column: 40, scope: !2900)
!2920 = !{!2921, !1546, i64 0, i64 4}
!2921 = !{!1547, i64 20, !"_ZTSZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS5_IS6_XT_EEERKNS_6vectorIfXT_EEEbSC_bDpRKT0_EUlT_E_", !1546, i64 0, i64 4, !1546, i64 4, i64 4, !1546, i64 8, i64 4, !1546, i64 12, i64 4, !1546, i64 16, i64 4}
!2922 = !DILocation(line: 102, column: 47, scope: !2900)
!2923 = !{!2921, !1546, i64 4, i64 4}
!2924 = !DILocation(line: 102, column: 76, scope: !2900)
!2925 = !DILocation(line: 102, column: 59, scope: !2900)
!2926 = !DILocation(line: 103, column: 47, scope: !2900)
!2927 = !{!2921, !1546, i64 8, i64 4}
!2928 = !DILocation(line: 103, column: 76, scope: !2900)
!2929 = !DILocation(line: 103, column: 59, scope: !2900)
!2930 = !DILocation(line: 104, column: 47, scope: !2900)
!2931 = !{!2921, !1546, i64 12, i64 4}
!2932 = !DILocation(line: 104, column: 77, scope: !2900)
!2933 = !DILocation(line: 104, column: 60, scope: !2900)
!2934 = !DILocation(line: 105, column: 13, scope: !2900)
!2935 = !{!2921, !1546, i64 16, i64 4}
!2936 = !DILocation(line: 105, column: 24, scope: !2900)
!2937 = !DILocation(line: 105, column: 29, scope: !2900)
!2938 = !DILocation(line: 105, column: 42, scope: !2900)
!2939 = !DILocation(line: 105, column: 17, scope: !2900)
!2940 = !DILocation(line: 106, column: 9, scope: !2900)
!2941 = distinct !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2942, file: !2832, line: 495, type: !2833, scopeLine: 496, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2871, declaration: !2945, retainedNodes: !2946)
!2942 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unroll_for_helper<unsigned int, 0U, 1U, 1U, 1U>", scope: !1505, file: !2832, line: 489, size: 8, flags: DIFlagTypePassByValue, elements: !137, templateParams: !2943, identifier: "_ZTSN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EEE")
!2943 = !{!2858, !2859, !2860, !2944, !2861}
!2944 = !DITemplateValueParameter(name: "It", type: !15, value: i32 1)
!2945 = !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/mul_acc32_fp.hpp:101:38)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNS0_13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE3runILj8EJNS_5accumI8accfloatLj8EEEEEENS9_ISA_XT_EEERKNS_6vectorIfXT_EEEbSG_bDpRKT0_EUlT_E_EEvOSL_", scope: !2942, file: !2832, line: 495, type: !2833, scopeLine: 495, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !2871)
!2946 = !{!2947}
!2947 = !DILocalVariable(name: "fn", arg: 1, scope: !2941, file: !2832, line: 495, type: !2835)
!2948 = !DILocation(line: 495, column: 31, scope: !2941)
!2949 = !DILocation(line: 519, column: 5, scope: !2941)
!2950 = distinct !DISubprogram(name: "operator()<aie::vector<float, 16U>, aie::vector<float, 16U>, aie::accum<accfloat, 16U> >", linkageName: "_ZZN3aie6detail13mul_bits_implILNS0_10MulMacroOpE2ELj32ELj32EfLj32EfE10get_mul_opILj8EEEDavENKUlDpOT_E_clIJNS_6vectorIfLj16EEESB_NS_5accumI8accfloatLj16EEEEEEDaS7_", scope: !2800, file: !2649, line: 87, type: !2951, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2957, declaration: !2956, retainedNodes: !2962)
!2951 = !DISubroutineType(types: !2952)
!2952 = !{!492, !2953, !2954, !2954, !2955}
!2953 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2799, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!2954 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !744, size: 32)
!2955 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !498, size: 32)
!2956 = !DISubprogram(name: "operator()<aie::vector<float, 16U>, aie::vector<float, 16U>, aie::accum<accfloat, 16U> >", scope: !2800, file: !2649, line: 87, type: !2951, scopeLine: 87, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2957)
!2957 = !{!2958}
!2958 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "args:auto", value: !2959)
!2959 = !{!2960, !2960, !2961}
!2960 = !DITemplateTypeParameter(type: !744)
!2961 = !DITemplateTypeParameter(type: !498)
!2962 = !{!2963, !2965, !2966, !2967}
!2963 = !DILocalVariable(name: "this", arg: 1, scope: !2950, type: !2964, flags: DIFlagArtificial | DIFlagObjectPointer)
!2964 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2799, size: 32)
!2965 = !DILocalVariable(name: "args", arg: 2, scope: !2950, file: !2649, line: 87, type: !2954)
!2966 = !DILocalVariable(name: "args", arg: 3, scope: !2950, file: !2649, line: 87, type: !2954)
!2967 = !DILocalVariable(name: "args", arg: 4, scope: !2950, file: !2649, line: 87, type: !2955)
!2968 = !DILocation(line: 0, scope: !2950)
!2969 = !DILocation(line: 87, column: 79, scope: !2950)
!2970 = !DILocation(line: 87, column: 121, scope: !2950)
!2971 = !DILocation(line: 87, column: 107, scope: !2950)
!2972 = !DILocation(line: 87, column: 100, scope: !2950)
!2973 = distinct !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 443, type: !2974, scopeLine: 444, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2977, declaration: !2976, retainedNodes: !2979)
!2974 = !DISubroutineType(types: !2975)
!2975 = !{!744, !291, !15}
!2976 = !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE12grow_extractILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 443, type: !2974, scopeLine: 443, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2977)
!2977 = !{!2978}
!2978 = !DITemplateValueParameter(name: "ElemsOut", type: !15, value: i32 16)
!2979 = !{!2980, !2981}
!2980 = !DILocalVariable(name: "this", arg: 1, scope: !2973, type: !1993, flags: DIFlagArtificial | DIFlagObjectPointer)
!2981 = !DILocalVariable(name: "idx", arg: 2, scope: !2973, file: !189, line: 443, type: !15)
!2982 = !DILocation(line: 0, scope: !2973)
!2983 = !DILocation(line: 443, column: 56, scope: !2973)
!2984 = !DILocation(line: 446, column: 20, scope: !2985)
!2985 = distinct !DILexicalBlock(scope: !2973, file: !189, line: 445, column: 23)
!2986 = !DILocation(line: 446, column: 13, scope: !2985)
!2987 = distinct !DISubprogram(name: "operator unsigned int", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EEcvjEv", scope: !2878, file: !2832, line: 467, type: !2881, scopeLine: 468, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2880, retainedNodes: !2988)
!2988 = !{!2989}
!2989 = !DILocalVariable(name: "this", arg: 1, scope: !2987, type: !2990, flags: DIFlagArtificial | DIFlagObjectPointer)
!2990 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2877, size: 32)
!2991 = !DILocation(line: 0, scope: !2987)
!2992 = !DILocation(line: 469, column: 16, scope: !2987)
!2993 = !DILocation(line: 469, column: 9, scope: !2987)
!2994 = distinct !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj", scope: !374, file: !375, line: 302, type: !2995, scopeLine: 303, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2977, declaration: !2997, retainedNodes: !2998)
!2995 = !DISubroutineType(types: !2996)
!2996 = !{!498, !456, !15}
!2997 = !DISubprogram(name: "grow_extract<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE12grow_extractILj16EEENS0_IS1_XT_EEEj", scope: !374, file: !375, line: 302, type: !2995, scopeLine: 302, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2977)
!2998 = !{!2999, !3000}
!2999 = !DILocalVariable(name: "this", arg: 1, scope: !2994, type: !1978, flags: DIFlagArtificial | DIFlagObjectPointer)
!3000 = !DILocalVariable(name: "idx", arg: 2, scope: !2994, file: !375, line: 302, type: !15)
!3001 = !DILocation(line: 0, scope: !2994)
!3002 = !DILocation(line: 302, column: 56, scope: !2994)
!3003 = !DILocation(line: 305, column: 20, scope: !3004)
!3004 = distinct !DILexicalBlock(scope: !2994, file: !375, line: 304, column: 23)
!3005 = !DILocation(line: 305, column: 13, scope: !3004)
!3006 = distinct !DISubprogram(name: "mac_elem_16", linkageName: "_Z11mac_elem_168v16floatS_11v16accfloat", scope: !3007, file: !3007, line: 883, type: !3008, scopeLine: 883, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !3010)
!3007 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/me_vmult_float_emulated.h", directory: "")
!3008 = !DISubroutineType(types: !3009)
!3009 = !{!492, !490, !490, !492}
!3010 = !{!3011, !3012, !3013}
!3011 = !DILocalVariable(name: "v1", arg: 1, scope: !3006, file: !3007, line: 883, type: !490)
!3012 = !DILocalVariable(name: "v2", arg: 2, scope: !3006, file: !3007, line: 883, type: !490)
!3013 = !DILocalVariable(name: "acc", arg: 3, scope: !3006, file: !3007, line: 883, type: !492)
!3014 = !DILocation(line: 883, column: 1, scope: !3006)
!3015 = distinct !DISubprogram(name: "operator v16float", linkageName: "_ZNK3aie6vectorIfLj16EEcv8v16floatEv", scope: !744, file: !189, line: 205, type: !833, scopeLine: 206, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !837, retainedNodes: !3016)
!3016 = !{!3017}
!3017 = !DILocalVariable(name: "this", arg: 1, scope: !3015, type: !2164, flags: DIFlagArtificial | DIFlagObjectPointer)
!3018 = !DILocation(line: 0, scope: !3015)
!3019 = !DILocation(line: 207, column: 16, scope: !3015)
!3020 = !DILocation(line: 207, column: 9, scope: !3015)
!3021 = distinct !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie5accumI8accfloatLj16EEcv11v16accfloatEv", scope: !498, file: !375, line: 234, type: !569, scopeLine: 235, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !568, retainedNodes: !3022)
!3022 = !{!3023}
!3023 = !DILocalVariable(name: "this", arg: 1, scope: !3021, type: !2365, flags: DIFlagArtificial | DIFlagObjectPointer)
!3024 = !DILocation(line: 0, scope: !3021)
!3025 = !DILocation(line: 236, column: 27, scope: !3021)
!3026 = !DILocation(line: 236, column: 9, scope: !3021)
!3027 = distinct !DISubprogram(name: "mac_elem_16_accuracy_fast", linkageName: "_Z25mac_elem_16_accuracy_fast8v16floatS_11v16accfloatiii", scope: !3007, file: !3007, line: 835, type: !3028, scopeLine: 835, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !3030)
!3028 = !DISubroutineType(types: !3029)
!3029 = !{!492, !490, !490, !492, !9, !9, !9}
!3030 = !{!3031, !3032, !3033, !3034, !3035, !3036, !3037}
!3031 = !DILocalVariable(name: "v1", arg: 1, scope: !3027, file: !3007, line: 835, type: !490)
!3032 = !DILocalVariable(name: "v2", arg: 2, scope: !3027, file: !3007, line: 835, type: !490)
!3033 = !DILocalVariable(name: "acc", arg: 3, scope: !3027, file: !3007, line: 835, type: !492)
!3034 = !DILocalVariable(name: "zero_acc", arg: 4, scope: !3027, file: !3007, line: 835, type: !9)
!3035 = !DILocalVariable(name: "sub_mul", arg: 5, scope: !3027, file: !3007, line: 835, type: !9)
!3036 = !DILocalVariable(name: "sub_acc1", arg: 6, scope: !3027, file: !3007, line: 835, type: !9)
!3037 = !DILocalVariable(name: "o", scope: !3027, file: !3007, line: 835, type: !492)
!3038 = !DILocation(line: 835, column: 1, scope: !3027)
!3039 = distinct !DISubprogram(name: "mac_elem_16_accuracy_fast_inner", linkageName: "_ZN9me_detail31mac_elem_16_accuracy_fast_innerE8v16floatS0_11v16accfloatiii", scope: !3040, file: !3007, line: 175, type: !3028, scopeLine: 176, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !3041)
!3040 = !DINamespace(name: "me_detail", scope: null)
!3041 = !{!3042, !3043, !3044, !3045, !3046, !3047, !3048, !3049, !3050, !3051, !3052, !3053, !3054, !3055, !3056}
!3042 = !DILocalVariable(name: "v1", arg: 1, scope: !3039, file: !3007, line: 175, type: !490)
!3043 = !DILocalVariable(name: "v2", arg: 2, scope: !3039, file: !3007, line: 175, type: !490)
!3044 = !DILocalVariable(name: "acc", arg: 3, scope: !3039, file: !3007, line: 175, type: !492)
!3045 = !DILocalVariable(name: "zero_acc", arg: 4, scope: !3039, file: !3007, line: 175, type: !9)
!3046 = !DILocalVariable(name: "sub_mul", arg: 5, scope: !3039, file: !3007, line: 176, type: !9)
!3047 = !DILocalVariable(name: "sub_acc1", arg: 6, scope: !3039, file: !3007, line: 176, type: !9)
!3048 = !DILocalVariable(name: "a", scope: !3039, file: !3007, line: 177, type: !496)
!3049 = !DILocalVariable(name: "b", scope: !3039, file: !3007, line: 178, type: !496)
!3050 = !DILocalVariable(name: "c", scope: !3039, file: !3007, line: 179, type: !496)
!3051 = !DILocalVariable(name: "d", scope: !3039, file: !3007, line: 180, type: !496)
!3052 = !DILocalVariable(name: "e", scope: !3039, file: !3007, line: 181, type: !496)
!3053 = !DILocalVariable(name: "f", scope: !3039, file: !3007, line: 182, type: !496)
!3054 = !DILocalVariable(name: "dummy0", scope: !3039, file: !3007, line: 183, type: !496)
!3055 = !DILocalVariable(name: "acc0", scope: !3039, file: !3007, line: 186, type: !492)
!3056 = !DILocalVariable(name: "acc1", scope: !3039, file: !3007, line: 191, type: !492)
!3057 = !DILocation(line: 175, column: 69, scope: !3039)
!3058 = !DILocation(line: 175, column: 82, scope: !3039)
!3059 = !DILocation(line: 175, column: 98, scope: !3039)
!3060 = !DILocation(line: 175, column: 107, scope: !3039)
!3061 = !DILocation(line: 176, column: 64, scope: !3039)
!3062 = !DILocation(line: 176, column: 77, scope: !3039)
!3063 = !DILocation(line: 177, column: 3, scope: !3039)
!3064 = !DILocation(line: 177, column: 15, scope: !3039)
!3065 = !DILocation(line: 177, column: 19, scope: !3039)
!3066 = !DILocation(line: 178, column: 3, scope: !3039)
!3067 = !DILocation(line: 178, column: 15, scope: !3039)
!3068 = !DILocation(line: 178, column: 19, scope: !3039)
!3069 = !DILocation(line: 179, column: 3, scope: !3039)
!3070 = !DILocation(line: 179, column: 15, scope: !3039)
!3071 = !DILocation(line: 179, column: 19, scope: !3039)
!3072 = !DILocation(line: 180, column: 3, scope: !3039)
!3073 = !DILocation(line: 180, column: 15, scope: !3039)
!3074 = !DILocation(line: 180, column: 19, scope: !3039)
!3075 = !DILocation(line: 181, column: 3, scope: !3039)
!3076 = !DILocation(line: 181, column: 15, scope: !3039)
!3077 = !DILocation(line: 181, column: 19, scope: !3039)
!3078 = !DILocation(line: 182, column: 3, scope: !3039)
!3079 = !DILocation(line: 182, column: 15, scope: !3039)
!3080 = !DILocation(line: 182, column: 19, scope: !3039)
!3081 = !DILocation(line: 183, column: 3, scope: !3039)
!3082 = !DILocation(line: 183, column: 15, scope: !3039)
!3083 = !DILocation(line: 183, column: 24, scope: !3039)
!3084 = !DILocation(line: 185, column: 35, scope: !3039)
!3085 = !DILocation(line: 185, column: 20, scope: !3039)
!3086 = !DILocation(line: 185, column: 7, scope: !3039)
!3087 = !DILocation(line: 185, column: 5, scope: !3039)
!3088 = !DILocation(line: 186, column: 3, scope: !3039)
!3089 = !DILocation(line: 186, column: 15, scope: !3039)
!3090 = !DILocation(line: 186, column: 47, scope: !3039)
!3091 = !DILocation(line: 186, column: 22, scope: !3039)
!3092 = !DILocation(line: 187, column: 20, scope: !3039)
!3093 = !DILocation(line: 187, column: 7, scope: !3039)
!3094 = !DILocation(line: 187, column: 5, scope: !3039)
!3095 = !DILocation(line: 188, column: 35, scope: !3039)
!3096 = !DILocation(line: 188, column: 20, scope: !3039)
!3097 = !DILocation(line: 188, column: 7, scope: !3039)
!3098 = !DILocation(line: 188, column: 5, scope: !3039)
!3099 = !DILocation(line: 190, column: 35, scope: !3039)
!3100 = !DILocation(line: 190, column: 20, scope: !3039)
!3101 = !DILocation(line: 190, column: 7, scope: !3039)
!3102 = !DILocation(line: 190, column: 5, scope: !3039)
!3103 = !DILocation(line: 191, column: 3, scope: !3039)
!3104 = !DILocation(line: 191, column: 15, scope: !3039)
!3105 = !DILocation(line: 191, column: 47, scope: !3039)
!3106 = !DILocation(line: 191, column: 22, scope: !3039)
!3107 = !DILocation(line: 192, column: 20, scope: !3039)
!3108 = !DILocation(line: 192, column: 7, scope: !3039)
!3109 = !DILocation(line: 192, column: 5, scope: !3039)
!3110 = !DILocation(line: 193, column: 35, scope: !3039)
!3111 = !DILocation(line: 193, column: 20, scope: !3039)
!3112 = !DILocation(line: 193, column: 7, scope: !3039)
!3113 = !DILocation(line: 193, column: 5, scope: !3039)
!3114 = !DILocation(line: 201, column: 90, scope: !3039)
!3115 = !DILocation(line: 201, column: 65, scope: !3039)
!3116 = !DILocation(line: 201, column: 103, scope: !3039)
!3117 = !DILocation(line: 201, column: 40, scope: !3039)
!3118 = !DILocation(line: 202, column: 34, scope: !3039)
!3119 = !DILocation(line: 201, column: 15, scope: !3039)
!3120 = !DILocation(line: 203, column: 18, scope: !3039)
!3121 = !DILocation(line: 199, column: 11, scope: !3039)
!3122 = !DILocation(line: 204, column: 14, scope: !3039)
!3123 = !DILocation(line: 197, column: 7, scope: !3039)
!3124 = !DILocation(line: 205, column: 7, scope: !3039)
!3125 = !DILocation(line: 205, column: 17, scope: !3039)
!3126 = !DILocation(line: 205, column: 26, scope: !3039)
!3127 = !DILocation(line: 195, column: 10, scope: !3039)
!3128 = !DILocation(line: 206, column: 1, scope: !3039)
!3129 = !{!3130, !3130, i64 0, i64 1}
!3130 = !{!1547, i64 1, !"uint4_t"}
!3131 = !{!3132, !3132, i64 0, i64 4}
!3132 = !{!1547, i64 4, !"uint5_t"}
!3133 = !{!3134, !3134, i64 0, i64 2}
!3134 = !{!1547, i64 2, !"short"}
!3135 = !{i32 2}
!3136 = distinct !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6vectorIfLj16EE9to_nativeEv", scope: !744, file: !189, line: 196, type: !833, scopeLine: 197, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !832, retainedNodes: !3137)
!3137 = !{!3138}
!3138 = !DILocalVariable(name: "this", arg: 1, scope: !3136, type: !2164, flags: DIFlagArtificial | DIFlagObjectPointer)
!3139 = !DILocation(line: 0, scope: !3136)
!3140 = !DILocation(line: 198, column: 27, scope: !3136)
!3141 = !DILocation(line: 198, column: 9, scope: !3136)
!3142 = distinct !DISubprogram(name: "to_native", linkageName: "_ZNK3aie6detail11vector_baseIfLj16EE9to_nativeEv", scope: !747, file: !193, line: 1154, type: !800, scopeLine: 1155, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !799, retainedNodes: !3143)
!3143 = !{!3144}
!3144 = !DILocalVariable(name: "this", arg: 1, scope: !3142, type: !2196, flags: DIFlagArtificial | DIFlagObjectPointer)
!3145 = !DILocation(line: 0, scope: !3142)
!3146 = !DILocation(line: 1160, column: 20, scope: !3147)
!3147 = distinct !DILexicalBlock(scope: !3142, file: !193, line: 1157, column: 23)
!3148 = distinct !DISubprogram(name: "operator v16accfloat", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEcv11v16accfloatEv", scope: !501, file: !379, line: 256, type: !534, scopeLine: 257, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !533, retainedNodes: !3149)
!3149 = !{!3150}
!3150 = !DILocalVariable(name: "this", arg: 1, scope: !3148, type: !2414, flags: DIFlagArtificial | DIFlagObjectPointer)
!3151 = !DILocation(line: 0, scope: !3148)
!3152 = !DILocation(line: 258, column: 16, scope: !3148)
!3153 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 247, type: !2974, scopeLine: 248, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2977, declaration: !3154, retainedNodes: !3155)
!3154 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6vectorIfLj8EE4growILj16EEENS0_IfXT_EEEj", scope: !188, file: !189, line: 247, type: !2974, scopeLine: 247, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2977)
!3155 = !{!3156, !3157}
!3156 = !DILocalVariable(name: "this", arg: 1, scope: !3153, type: !1993, flags: DIFlagArtificial | DIFlagObjectPointer)
!3157 = !DILocalVariable(name: "idx", arg: 2, scope: !3153, file: !189, line: 247, type: !15)
!3158 = !DILocation(line: 0, scope: !3153)
!3159 = !DILocation(line: 247, column: 91, scope: !3153)
!3160 = !DILocation(line: 249, column: 17, scope: !3153)
!3161 = !DILocation(line: 249, column: 52, scope: !3153)
!3162 = !DILocation(line: 249, column: 37, scope: !3153)
!3163 = !DILocation(line: 249, column: 16, scope: !3153)
!3164 = !DILocation(line: 249, column: 9, scope: !3153)
!3165 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 548, type: !3166, scopeLine: 549, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2977, declaration: !3168, retainedNodes: !3169)
!3166 = !DISubroutineType(types: !3167)
!3167 = !{!747, !253, !15}
!3168 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE4growILj16EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 548, type: !3166, scopeLine: 548, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2977)
!3169 = !{!3170, !3172, !3173, !3174, !3175, !3176, !3177}
!3170 = !DILocalVariable(name: "this", arg: 1, scope: !3165, type: !3171, flags: DIFlagArtificial | DIFlagObjectPointer)
!3171 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 32)
!3172 = !DILocalVariable(name: "idx", arg: 2, scope: !3165, file: !193, line: 548, type: !15)
!3173 = !DILocalVariable(name: "output_bits", scope: !3165, file: !193, line: 550, type: !101)
!3174 = !DILocalVariable(name: "growth_ratio", scope: !3165, file: !193, line: 551, type: !101)
!3175 = !DILocalVariable(name: "ret", scope: !3165, file: !193, line: 556, type: !747)
!3176 = !DILocalVariable(name: "in_storage_elems", scope: !3165, file: !193, line: 558, type: !101)
!3177 = !DILocalVariable(name: "out_storage_elems", scope: !3165, file: !193, line: 559, type: !101)
!3178 = !DILocation(line: 0, scope: !3165)
!3179 = !DILocation(line: 548, column: 44, scope: !3165)
!3180 = !DILocation(line: 550, column: 9, scope: !3165)
!3181 = !DILocation(line: 550, column: 28, scope: !3165)
!3182 = !DILocation(line: 551, column: 9, scope: !3165)
!3183 = !DILocation(line: 551, column: 28, scope: !3165)
!3184 = !DILocation(line: 556, column: 34, scope: !3165)
!3185 = !DILocation(line: 558, column: 9, scope: !3165)
!3186 = !DILocation(line: 558, column: 28, scope: !3165)
!3187 = !DILocation(line: 559, column: 9, scope: !3165)
!3188 = !DILocation(line: 559, column: 28, scope: !3165)
!3189 = !DILocation(line: 565, column: 19, scope: !3190)
!3190 = distinct !DILexicalBlock(scope: !3191, file: !193, line: 564, column: 77)
!3191 = distinct !DILexicalBlock(scope: !3192, file: !193, line: 564, column: 28)
!3192 = distinct !DILexicalBlock(scope: !3165, file: !193, line: 561, column: 23)
!3193 = !DILocation(line: 565, column: 57, scope: !3190)
!3194 = !DILocation(line: 565, column: 63, scope: !3190)
!3195 = !DILocation(line: 565, column: 17, scope: !3190)
!3196 = !{!2146, !2146, i64 0, i64 64}
!3197 = !{i64 0, i64 4, !1780, i64 4, i64 4, !1780, i64 8, i64 4, !1780, i64 12, i64 4, !1780, i64 16, i64 4, !1780, i64 20, i64 4, !1780, i64 24, i64 4, !1780, i64 28, i64 4, !1780, i64 32, i64 4, !1780, i64 36, i64 4, !1780, i64 40, i64 4, !1780, i64 44, i64 4, !1780, i64 48, i64 4, !1780, i64 52, i64 4, !1780, i64 56, i64 4, !1780, i64 60, i64 4, !1780}
!3198 = !DILocation(line: 565, column: 13, scope: !3190)
!3199 = !DILocation(line: 584, column: 5, scope: !3165)
!3200 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj16EEC2ERKNS_6detail11vector_baseIfLj16EEE", scope: !744, file: !189, line: 87, type: !804, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !803, retainedNodes: !3201)
!3201 = !{!3202, !3203}
!3202 = !DILocalVariable(name: "this", arg: 1, scope: !3200, type: !2175, flags: DIFlagArtificial | DIFlagObjectPointer)
!3203 = !DILocalVariable(name: "v", arg: 2, scope: !3200, file: !189, line: 87, type: !807)
!3204 = !DILocation(line: 0, scope: !3200)
!3205 = !DILocation(line: 87, column: 29, scope: !3200)
!3206 = !DILocation(line: 87, column: 44, scope: !3200)
!3207 = !DILocation(line: 87, column: 34, scope: !3200)
!3208 = !DILocation(line: 87, column: 48, scope: !3200)
!3209 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj16EEC2Ev", scope: !747, file: !193, line: 402, type: !770, scopeLine: 404, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !769, retainedNodes: !3210)
!3210 = !{!3211}
!3211 = !DILocalVariable(name: "this", arg: 1, scope: !3209, type: !3212, flags: DIFlagArtificial | DIFlagObjectPointer)
!3212 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !747, size: 32)
!3213 = !DILocation(line: 0, scope: !3209)
!3214 = !DILocation(line: 403, column: 9, scope: !3209)
!3215 = !DILocation(line: 403, column: 14, scope: !3209)
!3216 = !DILocation(line: 405, column: 5, scope: !3209)
!3217 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj", scope: !3218, file: !193, line: 175, type: !3221, scopeLine: 175, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3220, retainedNodes: !3231)
!3218 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vector_set<float, 16U>", scope: !7, file: !193, line: 175, size: 8, flags: DIFlagTypePassByValue, elements: !3219, templateParams: !760, identifier: "_ZTSN3aie6detail10vector_setIfLj16EEE")
!3219 = !{!3220, !3225}
!3220 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10vector_setIfLj16EE3runERK7v8floatj", scope: !3218, file: !193, line: 175, type: !3221, scopeLine: 175, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3221 = !DISubroutineType(types: !3222)
!3222 = !{!490, !3223, !15}
!3223 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3224, size: 32)
!3224 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !211)
!3225 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail10vector_setIfLj16EE3runERK7v4floatj", scope: !3218, file: !193, line: 176, type: !3226, scopeLine: 176, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3226 = !DISubroutineType(types: !3227)
!3227 = !{!490, !3228, !15}
!3228 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3229, size: 32)
!3229 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3230)
!3230 = !DIDerivedType(tag: DW_TAG_typedef, name: "v4float", file: !34, line: 615, baseType: !676)
!3231 = !{!3232, !3233}
!3232 = !DILocalVariable(name: "v", arg: 1, scope: !3217, file: !193, line: 175, type: !3223)
!3233 = !DILocalVariable(name: "idx", arg: 2, scope: !3217, file: !193, line: 175, type: !15)
!3234 = !DILocation(line: 175, column: 90, scope: !3217)
!3235 = !DILocation(line: 175, column: 102, scope: !3217)
!3236 = !DILocation(line: 175, column: 131, scope: !3217)
!3237 = !DILocation(line: 175, column: 136, scope: !3217)
!3238 = !DILocation(line: 175, column: 116, scope: !3217)
!3239 = !DILocation(line: 175, column: 109, scope: !3217)
!3240 = distinct !DISubprogram(name: "vector_base", linkageName: "_ZN3aie6detail11vector_baseIfLj16EEC2E8v16float", scope: !747, file: !193, line: 408, type: !774, scopeLine: 410, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !773, retainedNodes: !3241)
!3241 = !{!3242, !3243}
!3242 = !DILocalVariable(name: "this", arg: 1, scope: !3240, type: !3212, flags: DIFlagArtificial | DIFlagObjectPointer)
!3243 = !DILocalVariable(name: "data", arg: 2, scope: !3240, file: !193, line: 408, type: !776)
!3244 = !DILocation(line: 0, scope: !3240)
!3245 = !DILocation(line: 408, column: 27, scope: !3240)
!3246 = !DILocation(line: 409, column: 9, scope: !3240)
!3247 = !DILocation(line: 409, column: 14, scope: !3240)
!3248 = !DILocation(line: 412, column: 5, scope: !3240)
!3249 = distinct !DISubprogram(name: "current", linkageName: "_ZNK3aie6detail5utils13iteration_dimIjLj0ELj1ELj0EE7currentEv", scope: !2878, file: !2832, line: 482, type: !2881, scopeLine: 483, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !2886, retainedNodes: !3250)
!3250 = !{!3251}
!3251 = !DILocalVariable(name: "this", arg: 1, scope: !3249, type: !2990, flags: DIFlagArtificial | DIFlagObjectPointer)
!3252 = !DILocation(line: 0, scope: !3249)
!3253 = !DILocation(line: 484, column: 9, scope: !3249)
!3254 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv", scope: !374, file: !375, line: 248, type: !3255, scopeLine: 249, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2977, declaration: !3257, retainedNodes: !3258)
!3255 = !DISubroutineType(types: !3256)
!3256 = !{!498, !456}
!3257 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie5accumI8accfloatLj8EE4growILj16EEENS0_IS1_XT_EEEv", scope: !374, file: !375, line: 248, type: !3255, scopeLine: 248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2977)
!3258 = !{!3259}
!3259 = !DILocalVariable(name: "this", arg: 1, scope: !3254, type: !1978, flags: DIFlagArtificial | DIFlagObjectPointer)
!3260 = !DILocation(line: 0, scope: !3254)
!3261 = !DILocation(line: 250, column: 45, scope: !3254)
!3262 = !DILocation(line: 250, column: 65, scope: !3254)
!3263 = !DILocation(line: 250, column: 16, scope: !3254)
!3264 = !DILocation(line: 250, column: 9, scope: !3254)
!3265 = distinct !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv", scope: !378, file: !379, line: 287, type: !3266, scopeLine: 288, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2977, declaration: !3268, retainedNodes: !3269)
!3266 = !DISubroutineType(types: !3267)
!3267 = !{!501, !420}
!3268 = !DISubprogram(name: "grow<16U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE4growILj16EEENS1_ILS2_2ELj32EXT_EEEv", scope: !378, file: !379, line: 287, type: !3266, scopeLine: 287, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2977)
!3269 = !{!3270, !3272, !3273, !3274, !3275}
!3270 = !DILocalVariable(name: "this", arg: 1, scope: !3265, type: !3271, flags: DIFlagArtificial | DIFlagObjectPointer)
!3271 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !421, size: 32)
!3272 = !DILocalVariable(name: "in_num_subaccums", scope: !3265, file: !379, line: 293, type: !101)
!3273 = !DILocalVariable(name: "out_num_subaccums", scope: !3265, file: !379, line: 294, type: !101)
!3274 = !DILocalVariable(name: "ret", scope: !3265, file: !379, line: 295, type: !501)
!3275 = !DILocalVariable(name: "growth_ratio", scope: !3265, file: !379, line: 298, type: !101)
!3276 = !DILocation(line: 0, scope: !3265)
!3277 = !DILocation(line: 293, column: 9, scope: !3265)
!3278 = !DILocation(line: 293, column: 28, scope: !3265)
!3279 = !DILocation(line: 294, column: 9, scope: !3265)
!3280 = !DILocation(line: 294, column: 28, scope: !3265)
!3281 = !DILocation(line: 295, column: 46, scope: !3265)
!3282 = !DILocation(line: 298, column: 9, scope: !3265)
!3283 = !DILocation(line: 298, column: 28, scope: !3265)
!3284 = !DILocation(line: 310, column: 23, scope: !3285)
!3285 = distinct !DILexicalBlock(scope: !3286, file: !379, line: 309, column: 27)
!3286 = distinct !DILexicalBlock(scope: !3287, file: !379, line: 308, column: 77)
!3287 = distinct !DILexicalBlock(scope: !3288, file: !379, line: 308, column: 28)
!3288 = distinct !DILexicalBlock(scope: !3265, file: !379, line: 305, column: 23)
!3289 = !DILocation(line: 310, column: 32, scope: !3285)
!3290 = !DILocation(line: 310, column: 38, scope: !3285)
!3291 = !{!1746, !1747, i64 0, i64 32}
!3292 = !DILocation(line: 310, column: 21, scope: !3285)
!3293 = !{!2310, !2310, i64 0, i64 64}
!3294 = !DILocation(line: 310, column: 17, scope: !3285)
!3295 = !DILocation(line: 326, column: 5, scope: !3265)
!3296 = distinct !DISubprogram(name: "accum", linkageName: "_ZN3aie5accumI8accfloatLj16EEC2ERKNS_6detail10accum_baseILNS3_10AccumClassE2ELj32ELj16EEE", scope: !498, file: !375, line: 59, type: !540, scopeLine: 59, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !539, retainedNodes: !3297)
!3297 = !{!3298, !3299}
!3298 = !DILocalVariable(name: "this", arg: 1, scope: !3296, type: !2334, flags: DIFlagArtificial | DIFlagObjectPointer)
!3299 = !DILocalVariable(name: "a", arg: 2, scope: !3296, file: !375, line: 59, type: !543)
!3300 = !DILocation(line: 0, scope: !3296)
!3301 = !DILocation(line: 59, column: 37, scope: !3296)
!3302 = !DILocation(line: 59, column: 52, scope: !3296)
!3303 = !DILocation(line: 59, column: 42, scope: !3296)
!3304 = !DILocation(line: 59, column: 56, scope: !3296)
!3305 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2Ev", scope: !501, file: !379, line: 229, type: !527, scopeLine: 231, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !526, retainedNodes: !3306)
!3306 = !{!3307}
!3307 = !DILocalVariable(name: "this", arg: 1, scope: !3305, type: !3308, flags: DIFlagArtificial | DIFlagObjectPointer)
!3308 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !501, size: 32)
!3309 = !DILocation(line: 0, scope: !3305)
!3310 = !DILocation(line: 230, column: 9, scope: !3305)
!3311 = !DILocation(line: 230, column: 14, scope: !3305)
!3312 = !DILocation(line: 232, column: 5, scope: !3305)
!3313 = distinct !DISubprogram(name: "accum_base", linkageName: "_ZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj16EEC2E11v16accfloat", scope: !501, file: !379, line: 242, type: !531, scopeLine: 244, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !530, retainedNodes: !3314)
!3314 = !{!3315, !3316}
!3315 = !DILocalVariable(name: "this", arg: 1, scope: !3313, type: !3308, flags: DIFlagArtificial | DIFlagObjectPointer)
!3316 = !DILocalVariable(name: "data", arg: 2, scope: !3313, file: !379, line: 242, type: !506)
!3317 = !DILocation(line: 0, scope: !3313)
!3318 = !DILocation(line: 242, column: 26, scope: !3313)
!3319 = !DILocation(line: 243, column: 9, scope: !3313)
!3320 = !DILocation(line: 243, column: 14, scope: !3313)
!3321 = !DILocation(line: 246, column: 5, scope: !3313)
!3322 = distinct !DISubprogram(name: "undef", linkageName: "_ZN3aie6detail13accum_storageILNS0_10AccumClassE2ELj32ELj16EE5undefEv", scope: !509, file: !386, line: 167, type: !512, scopeLine: 167, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !511, retainedNodes: !137)
!3323 = !DILocation(line: 167, column: 147, scope: !3322)
!3324 = !DILocation(line: 167, column: 140, scope: !3322)
!3325 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf", scope: !3326, file: !2110, line: 122, type: !3329, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3328, retainedNodes: !3332)
!3326 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "broadcast_bits_impl<32U, float, 8U>", scope: !7, file: !2110, line: 117, size: 8, flags: DIFlagTypePassByValue, elements: !3327, templateParams: !2104, identifier: "_ZTSN3aie6detail19broadcast_bits_implILj32EfLj8EEE")
!3327 = !{!3328}
!3328 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj8EE3runERKf", scope: !3326, file: !2110, line: 122, type: !3329, scopeLine: 122, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3329 = !DISubroutineType(types: !3330)
!3330 = !{!3331, !2824}
!3331 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !3326, file: !2110, line: 119, baseType: !188)
!3332 = !{!3333, !3334, !3335}
!3333 = !DILocalVariable(name: "a", arg: 1, scope: !3325, file: !2110, line: 122, type: !2824)
!3334 = !DILocalVariable(name: "native_broadcast_elems", scope: !3325, file: !2110, line: 124, type: !101)
!3335 = !DILocalVariable(name: "ret", scope: !3325, file: !2110, line: 127, type: !3331)
!3336 = !DILocation(line: 122, column: 37, scope: !3325)
!3337 = !DILocation(line: 124, column: 9, scope: !3325)
!3338 = !DILocation(line: 124, column: 28, scope: !3325)
!3339 = !DILocation(line: 127, column: 21, scope: !3325)
!3340 = !DILocation(line: 130, column: 19, scope: !3341)
!3341 = distinct !DILexicalBlock(scope: !3342, file: !2110, line: 129, column: 49)
!3342 = distinct !DILexicalBlock(scope: !3325, file: !2110, line: 129, column: 23)
!3343 = !DILocation(line: 130, column: 46, scope: !3341)
!3344 = !DILocation(line: 130, column: 58, scope: !3341)
!3345 = !DILocation(line: 130, column: 17, scope: !3341)
!3346 = !DILocation(line: 130, column: 13, scope: !3341)
!3347 = !DILocation(line: 156, column: 5, scope: !3325)
!3348 = distinct !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf", scope: !3349, file: !2110, line: 122, type: !3352, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3351, retainedNodes: !3355)
!3349 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "broadcast_bits_impl<32U, float, 16U>", scope: !7, file: !2110, line: 117, size: 8, flags: DIFlagTypePassByValue, elements: !3350, templateParams: !2137, identifier: "_ZTSN3aie6detail19broadcast_bits_implILj32EfLj16EEE")
!3350 = !{!3351}
!3351 = !DISubprogram(name: "run", linkageName: "_ZN3aie6detail19broadcast_bits_implILj32EfLj16EE3runERKf", scope: !3349, file: !2110, line: 122, type: !3352, scopeLine: 122, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized)
!3352 = !DISubroutineType(types: !3353)
!3353 = !{!3354, !2824}
!3354 = !DIDerivedType(tag: DW_TAG_typedef, name: "vector_type", scope: !3349, file: !2110, line: 119, baseType: !744)
!3355 = !{!3356, !3357, !3358}
!3356 = !DILocalVariable(name: "a", arg: 1, scope: !3348, file: !2110, line: 122, type: !2824)
!3357 = !DILocalVariable(name: "native_broadcast_elems", scope: !3348, file: !2110, line: 124, type: !101)
!3358 = !DILocalVariable(name: "ret", scope: !3348, file: !2110, line: 127, type: !3354)
!3359 = !DILocation(line: 122, column: 37, scope: !3348)
!3360 = !DILocation(line: 124, column: 9, scope: !3348)
!3361 = !DILocation(line: 124, column: 28, scope: !3348)
!3362 = !DILocation(line: 127, column: 21, scope: !3348)
!3363 = !DILocation(line: 141, column: 47, scope: !3364)
!3364 = distinct !DILexicalBlock(scope: !3365, file: !2110, line: 140, column: 32)
!3365 = distinct !DILexicalBlock(scope: !3366, file: !2110, line: 138, column: 27)
!3366 = distinct !DILexicalBlock(scope: !3367, file: !2110, line: 134, column: 27)
!3367 = distinct !DILexicalBlock(scope: !3368, file: !2110, line: 132, column: 41)
!3368 = distinct !DILexicalBlock(scope: !3369, file: !2110, line: 132, column: 28)
!3369 = distinct !DILexicalBlock(scope: !3348, file: !2110, line: 129, column: 23)
!3370 = !DILocation(line: 141, column: 23, scope: !3364)
!3371 = !DILocation(line: 141, column: 21, scope: !3364)
!3372 = !DILocation(line: 156, column: 5, scope: !3348)
!3373 = distinct !DISubprogram(name: "get", linkageName: "_ZNK3aie21vector_elem_const_refIfLj8EE3getEv", scope: !308, file: !309, line: 44, type: !355, scopeLine: 45, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !354, retainedNodes: !3374)
!3374 = !{!3375}
!3375 = !DILocalVariable(name: "this", arg: 1, scope: !3373, type: !2784, flags: DIFlagArtificial | DIFlagObjectPointer)
!3376 = !DILocation(line: 0, scope: !3373)
!3377 = !DILocation(line: 46, column: 16, scope: !3373)
!3378 = !{!2624, !1546, i64 0, i64 4}
!3379 = !DILocation(line: 46, column: 27, scope: !3373)
!3380 = !DILocation(line: 46, column: 23, scope: !3373)
!3381 = !DILocation(line: 46, column: 9, scope: !3373)
!3382 = distinct !DISubprogram(name: "get", linkageName: "_ZNK3aie6vectorIfLj8EE3getEj", scope: !188, file: !189, line: 282, type: !303, scopeLine: 283, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !302, retainedNodes: !3383)
!3383 = !{!3384, !3385}
!3384 = !DILocalVariable(name: "this", arg: 1, scope: !3382, type: !1993, flags: DIFlagArtificial | DIFlagObjectPointer)
!3385 = !DILocalVariable(name: "idx", arg: 2, scope: !3382, file: !189, line: 282, type: !15)
!3386 = !DILocation(line: 0, scope: !3382)
!3387 = !DILocation(line: 282, column: 29, scope: !3382)
!3388 = !DILocation(line: 284, column: 31, scope: !3382)
!3389 = !DILocation(line: 284, column: 27, scope: !3382)
!3390 = !DILocation(line: 284, column: 9, scope: !3382)
!3391 = distinct !DISubprogram(name: "get", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE3getEj", scope: !192, file: !193, line: 703, type: !251, scopeLine: 704, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !250, retainedNodes: !3392)
!3392 = !{!3393, !3394}
!3393 = !DILocalVariable(name: "this", arg: 1, scope: !3391, type: !3171, flags: DIFlagArtificial | DIFlagObjectPointer)
!3394 = !DILocalVariable(name: "idx", arg: 2, scope: !3391, file: !193, line: 703, type: !15)
!3395 = !DILocation(line: 0, scope: !3391)
!3396 = !DILocation(line: 703, column: 29, scope: !3391)
!3397 = !DILocation(line: 705, column: 9, scope: !3391)
!3398 = !DILocation(line: 705, column: 9, scope: !3399)
!3399 = distinct !DILexicalBlock(scope: !3400, file: !193, line: 705, column: 9)
!3400 = distinct !DILexicalBlock(scope: !3391, file: !193, line: 705, column: 9)
!3401 = !DILocation(line: 705, column: 9, scope: !3400)
!3402 = !DILocation(line: 705, column: 9, scope: !3403)
!3403 = distinct !DILexicalBlock(scope: !3399, file: !193, line: 705, column: 9)
!3404 = !DILocation(line: 705, column: 9, scope: !3405)
!3405 = distinct !DILexicalBlock(scope: !3406, file: !193, line: 705, column: 9)
!3406 = distinct !DILexicalBlock(scope: !3403, file: !193, line: 705, column: 9)
!3407 = !DILocation(line: 705, column: 9, scope: !3406)
!3408 = !DILocation(line: 705, column: 9, scope: !3409)
!3409 = distinct !DILexicalBlock(scope: !3399, file: !193, line: 705, column: 9)
!3410 = !DILocation(line: 748, column: 79, scope: !3411)
!3411 = distinct !DILexicalBlock(scope: !3412, file: !193, line: 747, column: 47)
!3412 = distinct !DILexicalBlock(scope: !3413, file: !193, line: 747, column: 32)
!3413 = distinct !DILexicalBlock(scope: !3414, file: !193, line: 744, column: 27)
!3414 = distinct !DILexicalBlock(scope: !3415, file: !193, line: 743, column: 14)
!3415 = distinct !DILexicalBlock(scope: !3391, file: !193, line: 707, column: 23)
!3416 = !DILocation(line: 748, column: 39, scope: !3411)
!3417 = !DILocation(line: 748, column: 89, scope: !3411)
!3418 = !DILocation(line: 748, column: 24, scope: !3411)
!3419 = !DILocation(line: 748, column: 17, scope: !3411)
!3420 = !{!"2nd parameter of extract intrinsic should be const in [0,63]"}
!3421 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie8unary_opINS_6vectorIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_", scope: !1004, file: !45, line: 454, type: !3422, scopeLine: 454, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3425, retainedNodes: !3426)
!3422 = !DISubroutineType(types: !3423)
!3423 = !{null, !3424, !987}
!3424 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1004, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3425 = !DISubprogram(name: "unary_op_common", scope: !1004, type: !3422, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3426 = !{!3427, !3429}
!3427 = !DILocalVariable(name: "this", arg: 1, scope: !3421, type: !3428, flags: DIFlagArtificial | DIFlagObjectPointer)
!3428 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1004, size: 32)
!3429 = !DILocalVariable(arg: 2, scope: !3421, type: !987, flags: DIFlagArtificial)
!3430 = !DILocation(line: 0, scope: !3421)
!3431 = !DILocation(line: 454, column: 1, scope: !3421)
!3432 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie15unary_op_commonINS_6vectorIfLj8EEELNS_9OperationE0EEC2ES2_", scope: !983, file: !45, line: 424, type: !999, scopeLine: 426, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !998, retainedNodes: !3433)
!3433 = !{!3434, !3436}
!3434 = !DILocalVariable(name: "this", arg: 1, scope: !3432, type: !3435, flags: DIFlagArtificial | DIFlagObjectPointer)
!3435 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !983, size: 32)
!3436 = !DILocalVariable(name: "parent", arg: 2, scope: !3432, file: !45, line: 424, type: !987)
!3437 = !DILocation(line: 0, scope: !3432)
!3438 = !DILocation(line: 424, column: 50, scope: !3432)
!3439 = !DILocation(line: 425, column: 9, scope: !3432)
!3440 = !DILocation(line: 425, column: 17, scope: !3432)
!3441 = !DILocation(line: 427, column: 5, scope: !3432)
!3442 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie8unary_opINS_15vector_elem_refIfLj8EEELNS_9OperationE0EECI2NS_15unary_op_commonIS2_LS3_0EEEES2_", scope: !1017, file: !45, line: 454, type: !3443, scopeLine: 454, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3446, retainedNodes: !3447)
!3443 = !DISubroutineType(types: !3444)
!3444 = !{null, !3445, !965}
!3445 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1017, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3446 = !DISubprogram(name: "unary_op_common", scope: !1017, type: !3443, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3447 = !{!3448, !3450}
!3448 = !DILocalVariable(name: "this", arg: 1, scope: !3442, type: !3449, flags: DIFlagArtificial | DIFlagObjectPointer)
!3449 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1017, size: 32)
!3450 = !DILocalVariable(arg: 2, scope: !3442, type: !965, flags: DIFlagArtificial)
!3451 = !DILocation(line: 0, scope: !3442)
!3452 = !DILocation(line: 454, column: 1, scope: !3442)
!3453 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie15unary_op_commonINS_15vector_elem_refIfLj8EEELNS_9OperationE0EEC2ES2_", scope: !961, file: !45, line: 424, type: !977, scopeLine: 426, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !976, retainedNodes: !3454)
!3454 = !{!3455, !3457}
!3455 = !DILocalVariable(name: "this", arg: 1, scope: !3453, type: !3456, flags: DIFlagArtificial | DIFlagObjectPointer)
!3456 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !961, size: 32)
!3457 = !DILocalVariable(name: "parent", arg: 2, scope: !3453, file: !45, line: 424, type: !965)
!3458 = !DILocation(line: 0, scope: !3453)
!3459 = !DILocation(line: 424, column: 50, scope: !3453)
!3460 = !DILocation(line: 425, column: 9, scope: !3453)
!3461 = !DILocation(line: 427, column: 5, scope: !3453)
!3462 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie8unary_opINS_5accumI8accfloatLj8EEELNS_9OperationE1EECI2NS_15unary_op_commonIS3_LS4_1EEEES3_", scope: !1030, file: !45, line: 459, type: !3463, scopeLine: 459, flags: DIFlagArtificial | DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3466, retainedNodes: !3467)
!3463 = !DISubroutineType(types: !3464)
!3464 = !{null, !3465, !942}
!3465 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1030, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3466 = !DISubprogram(name: "unary_op_common", scope: !1030, type: !3463, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3467 = !{!3468, !3470}
!3468 = !DILocalVariable(name: "this", arg: 1, scope: !3462, type: !3469, flags: DIFlagArtificial | DIFlagObjectPointer)
!3469 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1030, size: 32)
!3470 = !DILocalVariable(arg: 2, scope: !3462, type: !942, flags: DIFlagArtificial)
!3471 = !DILocation(line: 0, scope: !3462)
!3472 = !DILocation(line: 459, column: 1, scope: !3462)
!3473 = distinct !DISubprogram(name: "unary_op_common", linkageName: "_ZN3aie15unary_op_commonINS_5accumI8accfloatLj8EEELNS_9OperationE1EEC2ES3_", scope: !937, file: !45, line: 424, type: !955, scopeLine: 426, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !954, retainedNodes: !3474)
!3474 = !{!3475, !3477}
!3475 = !DILocalVariable(name: "this", arg: 1, scope: !3473, type: !3476, flags: DIFlagArtificial | DIFlagObjectPointer)
!3476 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !937, size: 32)
!3477 = !DILocalVariable(name: "parent", arg: 2, scope: !3473, file: !45, line: 424, type: !942)
!3478 = !DILocation(line: 0, scope: !3473)
!3479 = !DILocation(line: 424, column: 50, scope: !3473)
!3480 = !DILocation(line: 425, column: 9, scope: !3473)
!3481 = !DILocation(line: 425, column: 17, scope: !3473)
!3482 = !DILocation(line: 427, column: 5, scope: !3473)
!3483 = distinct !DISubprogram(name: "elem_ref", linkageName: "_ZN3aie6vectorIfLj8EE8elem_refEj", scope: !188, file: !189, line: 336, type: !364, scopeLine: 337, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !368, retainedNodes: !3484)
!3484 = !{!3485, !3486}
!3485 = !DILocalVariable(name: "this", arg: 1, scope: !3483, type: !1896, flags: DIFlagArtificial | DIFlagObjectPointer)
!3486 = !DILocalVariable(name: "idx", arg: 2, scope: !3483, file: !189, line: 336, type: !15)
!3487 = !DILocation(line: 0, scope: !3483)
!3488 = !DILocation(line: 336, column: 81, scope: !3483)
!3489 = !DILocation(line: 338, column: 9, scope: !3483)
!3490 = !DILocation(line: 338, column: 9, scope: !3491)
!3491 = distinct !DILexicalBlock(scope: !3492, file: !189, line: 338, column: 9)
!3492 = distinct !DILexicalBlock(scope: !3483, file: !189, line: 338, column: 9)
!3493 = !DILocation(line: 338, column: 9, scope: !3492)
!3494 = !DILocation(line: 338, column: 9, scope: !3495)
!3495 = distinct !DILexicalBlock(scope: !3491, file: !189, line: 338, column: 9)
!3496 = !DILocation(line: 338, column: 9, scope: !3497)
!3497 = distinct !DILexicalBlock(scope: !3498, file: !189, line: 338, column: 9)
!3498 = distinct !DILexicalBlock(scope: !3495, file: !189, line: 338, column: 9)
!3499 = !DILocation(line: 338, column: 9, scope: !3498)
!3500 = !DILocation(line: 338, column: 9, scope: !3501)
!3501 = distinct !DILexicalBlock(scope: !3491, file: !189, line: 338, column: 9)
!3502 = !DILocation(line: 339, column: 24, scope: !3483)
!3503 = !DILocation(line: 339, column: 16, scope: !3483)
!3504 = !DILocation(line: 339, column: 9, scope: !3483)
!3505 = distinct !DISubprogram(name: "vector_elem_ref", linkageName: "_ZN3aie15vector_elem_refIfLj8EEC2ERNS_6vectorIfLj8EEEj", scope: !322, file: !309, line: 241, type: !350, scopeLine: 244, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !349, retainedNodes: !3506)
!3506 = !{!3507, !3509, !3510}
!3507 = !DILocalVariable(name: "this", arg: 1, scope: !3505, type: !3508, flags: DIFlagArtificial | DIFlagObjectPointer)
!3508 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !322, size: 32)
!3509 = !DILocalVariable(name: "v", arg: 2, scope: !3505, file: !309, line: 241, type: !325)
!3510 = !DILocalVariable(name: "idx", arg: 3, scope: !3505, file: !309, line: 241, type: !15)
!3511 = !DILocation(line: 0, scope: !3505)
!3512 = !DILocation(line: 241, column: 44, scope: !3505)
!3513 = !DILocation(line: 241, column: 56, scope: !3505)
!3514 = !DILocation(line: 242, column: 9, scope: !3505)
!3515 = !DILocation(line: 242, column: 16, scope: !3505)
!3516 = !DILocation(line: 243, column: 9, scope: !3505)
!3517 = !DILocation(line: 243, column: 16, scope: !3505)
!3518 = !DILocation(line: 245, column: 5, scope: !3505)
!3519 = distinct !DISubprogram(name: "to_vector<float>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi", scope: !378, file: !379, line: 624, type: !3520, scopeLine: 625, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1085, declaration: !3522, retainedNodes: !3523)
!3520 = !DISubroutineType(types: !3521)
!3521 = !{!188, !420, !9}
!3522 = !DISubprogram(name: "to_vector<float>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE9to_vectorIfEENS_6vectorIT_Lj8EEEi", scope: !378, file: !379, line: 624, type: !3520, scopeLine: 624, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1085)
!3523 = !{!3524, !3525}
!3524 = !DILocalVariable(name: "this", arg: 1, scope: !3519, type: !3271, flags: DIFlagArtificial | DIFlagObjectPointer)
!3525 = !DILocalVariable(name: "shift", arg: 2, scope: !3519, file: !379, line: 624, type: !9)
!3526 = !DILocation(line: 0, scope: !3519)
!3527 = !DILocation(line: 624, column: 36, scope: !3519)
!3528 = !DILocation(line: 626, column: 50, scope: !3519)
!3529 = !DILocation(line: 626, column: 16, scope: !3519)
!3530 = !DILocation(line: 626, column: 9, scope: !3519)
!3531 = distinct !DISubprogram(name: "to_vector_sign<float>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbi", scope: !378, file: !379, line: 565, type: !3532, scopeLine: 566, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1085, declaration: !3534, retainedNodes: !3535)
!3532 = !DISubroutineType(types: !3533)
!3533 = !{!188, !420, !176, !9}
!3534 = !DISubprogram(name: "to_vector_sign<float>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbi", scope: !378, file: !379, line: 565, type: !3532, scopeLine: 565, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1085)
!3535 = !{!3536, !3537, !3538, !3539, !3544, !3545, !3546, !3547, !3548}
!3536 = !DILocalVariable(name: "this", arg: 1, scope: !3531, type: !3271, flags: DIFlagArtificial | DIFlagObjectPointer)
!3537 = !DILocalVariable(name: "v_sign", arg: 2, scope: !3531, file: !379, line: 565, type: !176)
!3538 = !DILocalVariable(name: "shift", arg: 3, scope: !3531, file: !379, line: 565, type: !9)
!3539 = !DILocalVariable(name: "fn", scope: !3540, file: !379, line: 571, type: !3542)
!3540 = distinct !DILexicalBlock(scope: !3541, file: !379, line: 570, column: 14)
!3541 = distinct !DILexicalBlock(scope: !3531, file: !379, line: 567, column: 23)
!3542 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3543)
!3543 = distinct !DICompositeType(tag: DW_TAG_class_type, file: !379, line: 850, size: 8, flags: DIFlagTypePassByValue, elements: !137, identifier: "_ZTSZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_srsIfEEDavEUlRKT_T0_T1_E_")
!3544 = !DILocalVariable(name: "native_vector_elems", scope: !3540, file: !379, line: 574, type: !101)
!3545 = !DILocalVariable(name: "max_elems_per_srs", scope: !3540, file: !379, line: 575, type: !101)
!3546 = !DILocalVariable(name: "native_elems", scope: !3540, file: !379, line: 576, type: !101)
!3547 = !DILocalVariable(name: "elems_per_srs", scope: !3540, file: !379, line: 577, type: !101)
!3548 = !DILocalVariable(name: "ret", scope: !3540, file: !379, line: 579, type: !188)
!3549 = !DILocation(line: 0, scope: !3531)
!3550 = !DILocation(line: 565, column: 42, scope: !3531)
!3551 = !DILocation(line: 565, column: 54, scope: !3531)
!3552 = !DILocation(line: 571, column: 13, scope: !3540)
!3553 = !DILocation(line: 571, column: 28, scope: !3540)
!3554 = !DILocation(line: 574, column: 13, scope: !3540)
!3555 = !DILocation(line: 574, column: 32, scope: !3540)
!3556 = !DILocation(line: 575, column: 13, scope: !3540)
!3557 = !DILocation(line: 575, column: 32, scope: !3540)
!3558 = !DILocation(line: 576, column: 13, scope: !3540)
!3559 = !DILocation(line: 576, column: 32, scope: !3540)
!3560 = !DILocation(line: 577, column: 13, scope: !3540)
!3561 = !DILocation(line: 577, column: 32, scope: !3540)
!3562 = !DILocation(line: 579, column: 30, scope: !3540)
!3563 = !DILocation(line: 581, column: 56, scope: !3540)
!3564 = !{!3565, !1546, i64 4, i64 4}
!3565 = !{!1547, i64 20, !"_ZTSZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_", !1546, i64 0, i64 4, !1546, i64 4, i64 4, !1546, i64 8, i64 4, !1546, i64 12, i64 4, !1546, i64 16, i64 4}
!3566 = !DILocation(line: 581, column: 13, scope: !3540)
!3567 = !DILocation(line: 619, column: 9, scope: !3541)
!3568 = !DILocation(line: 620, column: 5, scope: !3531)
!3569 = distinct !DISubprogram(name: "unroll_times<1U, (lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/accum.hpp:581:56)>", linkageName: "_ZN3aie6detail5utils12unroll_timesILj1EZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOT0_", scope: !1505, file: !2832, line: 612, type: !3570, scopeLine: 613, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3585, retainedNodes: !3583)
!3570 = !DISubroutineType(types: !3571)
!3571 = !{null, !3572}
!3572 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3573, size: 32)
!3573 = distinct !DICompositeType(tag: DW_TAG_class_type, scope: !3531, file: !379, line: 581, size: 160, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !3574, identifier: "_ZTSZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_")
!3574 = !{!3575, !3576, !3577, !3579, !3581}
!3575 = !DIDerivedType(tag: DW_TAG_member, name: "ret", scope: !3573, file: !379, line: 582, baseType: !297, size: 32)
!3576 = !DIDerivedType(tag: DW_TAG_member, name: "this", scope: !3573, file: !379, line: 582, baseType: !3271, size: 32, offset: 32)
!3577 = !DIDerivedType(tag: DW_TAG_member, name: "shift", scope: !3573, file: !379, line: 582, baseType: !3578, size: 32, offset: 64)
!3578 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !9, size: 32)
!3579 = !DIDerivedType(tag: DW_TAG_member, name: "v_sign", scope: !3573, file: !379, line: 582, baseType: !3580, size: 32, offset: 96)
!3580 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !176, size: 32)
!3581 = !DIDerivedType(tag: DW_TAG_member, name: "fn", scope: !3573, file: !379, line: 582, baseType: !3582, size: 32, offset: 128)
!3582 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3542, size: 32)
!3583 = !{!3584}
!3584 = !DILocalVariable(name: "fn", arg: 1, scope: !3569, file: !2832, line: 612, type: !3572)
!3585 = !{!2848, !3586}
!3586 = !DITemplateTypeParameter(name: "Fn", type: !3573)
!3587 = !DILocation(line: 612, column: 24, scope: !3569)
!3588 = !DILocation(line: 614, column: 56, scope: !3569)
!3589 = !DILocation(line: 614, column: 5, scope: !3569)
!3590 = !DILocation(line: 615, column: 1, scope: !3569)
!3591 = distinct !DISubprogram(name: "unroll_for<unsigned int, 0U, 1U, 1U, (lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/accum.hpp:581:56)>", linkageName: "_ZN3aie6detail5utils10unroll_forIjLj0ELj1ELj1EZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOT3_", scope: !1505, file: !2832, line: 590, type: !3570, scopeLine: 591, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3594, retainedNodes: !3592)
!3592 = !{!3593}
!3593 = !DILocalVariable(name: "fn", arg: 1, scope: !3591, file: !2832, line: 590, type: !3572)
!3594 = !{!2858, !2859, !2860, !2861, !3586}
!3595 = !DILocation(line: 590, column: 22, scope: !3591)
!3596 = !DILocation(line: 592, column: 77, scope: !3591)
!3597 = !DILocation(line: 592, column: 5, scope: !3591)
!3598 = !DILocation(line: 593, column: 1, scope: !3591)
!3599 = distinct !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/accum.hpp:581:56)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_", scope: !2867, file: !2832, line: 495, type: !3570, scopeLine: 496, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3601, declaration: !3600, retainedNodes: !3602)
!3600 = !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/accum.hpp:581:56)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj0ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_", scope: !2867, file: !2832, line: 495, type: !3570, scopeLine: 495, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !3601)
!3601 = !{!3586}
!3602 = !{!3603, !3604, !3607}
!3603 = !DILocalVariable(name: "fn", arg: 1, scope: !3599, file: !2832, line: 495, type: !3572)
!3604 = !DILocalVariable(name: "it", scope: !3605, file: !2832, line: 498, type: !2877)
!3605 = distinct !DILexicalBlock(scope: !3606, file: !2832, line: 497, column: 73)
!3606 = distinct !DILexicalBlock(scope: !3599, file: !2832, line: 497, column: 23)
!3607 = !DILocalVariable(name: "next_it", scope: !3605, file: !2832, line: 511, type: !101)
!3608 = !DILocation(line: 495, column: 31, scope: !3599)
!3609 = !DILocation(line: 498, column: 13, scope: !3605)
!3610 = !DILocation(line: 498, column: 56, scope: !3605)
!3611 = !DILocation(line: 505, column: 17, scope: !3612)
!3612 = distinct !DILexicalBlock(scope: !3605, file: !2832, line: 504, column: 27)
!3613 = !DILocation(line: 505, column: 20, scope: !3612)
!3614 = !DILocation(line: 511, column: 13, scope: !3605)
!3615 = !DILocation(line: 511, column: 25, scope: !3605)
!3616 = !DILocation(line: 517, column: 87, scope: !3605)
!3617 = !DILocation(line: 517, column: 13, scope: !3605)
!3618 = !DILocation(line: 518, column: 9, scope: !3606)
!3619 = !DILocation(line: 519, column: 5, scope: !3599)
!3620 = distinct !DISubprogram(name: "operator()", linkageName: "_ZZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiENKUljE_clEj", scope: !3573, file: !379, line: 581, type: !3621, scopeLine: 581, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !3625, retainedNodes: !3626)
!3621 = !DISubroutineType(types: !3622)
!3622 = !{null, !3623, !15}
!3623 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3624, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3624 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3573)
!3625 = !DISubprogram(name: "operator()", scope: !3573, file: !379, line: 581, type: !3621, scopeLine: 581, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!3626 = !{!3627, !3629}
!3627 = !DILocalVariable(name: "this", arg: 1, scope: !3620, type: !3628, flags: DIFlagArtificial | DIFlagObjectPointer)
!3628 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3624, size: 32)
!3629 = !DILocalVariable(name: "idx", arg: 2, scope: !3620, file: !379, line: 581, type: !15)
!3630 = !DILocation(line: 0, scope: !3620)
!3631 = !DILocation(line: 581, column: 69, scope: !3620)
!3632 = !DILocation(line: 582, column: 17, scope: !3620)
!3633 = !{!3565, !1546, i64 0, i64 4}
!3634 = !DILocation(line: 582, column: 28, scope: !3620)
!3635 = !DILocation(line: 582, column: 33, scope: !3620)
!3636 = !{!3565, !1546, i64 16, i64 4}
!3637 = !DILocation(line: 582, column: 36, scope: !3620)
!3638 = !DILocation(line: 582, column: 59, scope: !3620)
!3639 = !DILocation(line: 582, column: 65, scope: !3620)
!3640 = !{!3565, !1546, i64 8, i64 4}
!3641 = !DILocation(line: 582, column: 72, scope: !3620)
!3642 = !{!3565, !1546, i64 12, i64 4}
!3643 = !DILocation(line: 582, column: 21, scope: !3620)
!3644 = !DILocation(line: 583, column: 13, scope: !3620)
!3645 = distinct !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/accum.hpp:581:56)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_", scope: !2942, file: !2832, line: 495, type: !3570, scopeLine: 496, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3601, declaration: !3646, retainedNodes: !3647)
!3646 = !DISubprogram(name: "execute<(lambda at /tools/Xilinx/Vitis/2024.2/aietools/include/aie_api/detail/aie2/accum.hpp:581:56)>", linkageName: "_ZN3aie6detail5utils17unroll_for_helperIjLj0ELj1ELj1ELj1EE7executeIZNKS0_10accum_baseILNS0_10AccumClassE2ELj32ELj8EE14to_vector_signIfEENS_6vectorIT_Lj8EEEbiEUljE_EEvOSA_", scope: !2942, file: !2832, line: 495, type: !3570, scopeLine: 495, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: DISPFlagOptimized, templateParams: !3601)
!3647 = !{!3648}
!3648 = !DILocalVariable(name: "fn", arg: 1, scope: !3645, file: !2832, line: 495, type: !3572)
!3649 = !DILocation(line: 495, column: 31, scope: !3645)
!3650 = !DILocation(line: 519, column: 5, scope: !3645)
!3651 = distinct !DISubprogram(name: "insert<v8float>", linkageName: "_ZN3aie6vectorIfLj8EE6insertI7v8floatEERS1_jT_", scope: !188, file: !189, line: 405, type: !3652, scopeLine: 406, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3655, declaration: !3654, retainedNodes: !3657)
!3652 = !DISubroutineType(types: !3653)
!3653 = !{!297, !262, !15, !212}
!3654 = !DISubprogram(name: "insert<v8float>", linkageName: "_ZN3aie6vectorIfLj8EE6insertI7v8floatEERS1_jT_", scope: !188, file: !189, line: 405, type: !3652, scopeLine: 405, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !3655)
!3655 = !{!3656}
!3656 = !DITemplateTypeParameter(name: "T2", type: !212)
!3657 = !{!3658, !3659, !3660, !3661, !3662}
!3658 = !DILocalVariable(name: "this", arg: 1, scope: !3651, type: !1896, flags: DIFlagArtificial | DIFlagObjectPointer)
!3659 = !DILocalVariable(name: "idx", arg: 2, scope: !3651, file: !189, line: 405, type: !15)
!3660 = !DILocalVariable(name: "v", arg: 3, scope: !3651, file: !189, line: 405, type: !212)
!3661 = !DILocalVariable(name: "ElemsIn", scope: !3651, file: !189, line: 408, type: !101)
!3662 = !DILocalVariable(name: "in", scope: !3651, file: !189, line: 414, type: !292)
!3663 = !DILocation(line: 0, scope: !3651)
!3664 = !DILocation(line: 405, column: 29, scope: !3651)
!3665 = !DILocation(line: 405, column: 37, scope: !3651)
!3666 = !DILocation(line: 408, column: 9, scope: !3651)
!3667 = !DILocation(line: 408, column: 28, scope: !3651)
!3668 = !DILocation(line: 412, column: 9, scope: !3651)
!3669 = !DILocation(line: 412, column: 9, scope: !3670)
!3670 = distinct !DILexicalBlock(scope: !3671, file: !189, line: 412, column: 9)
!3671 = distinct !DILexicalBlock(scope: !3651, file: !189, line: 412, column: 9)
!3672 = !DILocation(line: 412, column: 9, scope: !3671)
!3673 = !DILocation(line: 412, column: 9, scope: !3674)
!3674 = distinct !DILexicalBlock(scope: !3670, file: !189, line: 412, column: 9)
!3675 = !DILocation(line: 412, column: 9, scope: !3676)
!3676 = distinct !DILexicalBlock(scope: !3677, file: !189, line: 412, column: 9)
!3677 = distinct !DILexicalBlock(scope: !3674, file: !189, line: 412, column: 9)
!3678 = !DILocation(line: 412, column: 9, scope: !3677)
!3679 = !DILocation(line: 412, column: 9, scope: !3680)
!3680 = distinct !DILexicalBlock(scope: !3670, file: !189, line: 412, column: 9)
!3681 = !DILocation(line: 414, column: 9, scope: !3651)
!3682 = !DILocation(line: 414, column: 34, scope: !3651)
!3683 = !DILocation(line: 414, column: 39, scope: !3651)
!3684 = !DILocation(line: 416, column: 23, scope: !3651)
!3685 = !DILocation(line: 416, column: 16, scope: !3651)
!3686 = !DILocation(line: 417, column: 5, scope: !3651)
!3687 = !DILocation(line: 416, column: 9, scope: !3651)
!3688 = distinct !DISubprogram(name: "operator()<aie::detail::accum_base<(aie::detail::AccumClass)2, 32U, 8U>, int, bool>", linkageName: "_ZZN3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7get_srsIfEEDavENKUlRKT_T0_T1_E_clIS3_ibEEDaS7_S8_S9_", scope: !3543, file: !379, line: 850, type: !3689, scopeLine: 850, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3693, declaration: !3692, retainedNodes: !3697)
!3689 = !DISubroutineType(types: !3690)
!3690 = !{!211, !3691, !2381, !9, !176}
!3691 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3542, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!3692 = !DISubprogram(name: "operator()<aie::detail::accum_base<(aie::detail::AccumClass)2, 32U, 8U>, int, bool>", scope: !3543, file: !379, line: 850, type: !3689, scopeLine: 850, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !3693)
!3693 = !{!3694, !3695, !3696}
!3694 = !DITemplateTypeParameter(name: "acc:auto", type: !378)
!3695 = !DITemplateTypeParameter(name: "shift_dummy:auto", type: !9)
!3696 = !DITemplateTypeParameter(name: "sign_dummy:auto", type: !176)
!3697 = !{!3698, !3700, !3701, !3702}
!3698 = !DILocalVariable(name: "this", arg: 1, scope: !3688, type: !3699, flags: DIFlagArtificial | DIFlagObjectPointer)
!3699 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3542, size: 32)
!3700 = !DILocalVariable(name: "acc", arg: 2, scope: !3688, file: !379, line: 850, type: !2381)
!3701 = !DILocalVariable(name: "shift_dummy", arg: 3, scope: !3688, file: !379, line: 850, type: !9)
!3702 = !DILocalVariable(name: "sign_dummy", arg: 4, scope: !3688, file: !379, line: 850, type: !176)
!3703 = !DILocation(line: 0, scope: !3688)
!3704 = !DILocation(line: 850, column: 39, scope: !3688)
!3705 = !DILocation(line: 850, column: 49, scope: !3688)
!3706 = !DILocation(line: 850, column: 67, scope: !3688)
!3707 = !DILocation(line: 850, column: 111, scope: !3688)
!3708 = !DILocation(line: 850, column: 101, scope: !3688)
!3709 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj", scope: !378, file: !379, line: 367, type: !3710, scopeLine: 368, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1989, declaration: !3712, retainedNodes: !3713)
!3710 = !DISubroutineType(types: !3711)
!3711 = !{!378, !420, !15}
!3712 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EE7extractILj8EEENS1_ILS2_2ELj32EXT_EEEj", scope: !378, file: !379, line: 367, type: !3710, scopeLine: 367, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1989)
!3713 = !{!3714, !3715, !3716, !3717, !3718}
!3714 = !DILocalVariable(name: "this", arg: 1, scope: !3709, type: !3271, flags: DIFlagArtificial | DIFlagObjectPointer)
!3715 = !DILocalVariable(name: "idx", arg: 2, scope: !3709, file: !379, line: 367, type: !15)
!3716 = !DILocalVariable(name: "fpacc_128b", scope: !3709, file: !379, line: 374, type: !198)
!3717 = !DILocalVariable(name: "num_subaccums", scope: !3709, file: !379, line: 380, type: !101)
!3718 = !DILocalVariable(name: "num_subaccums_out", scope: !3709, file: !379, line: 381, type: !101)
!3719 = !DILocation(line: 0, scope: !3709)
!3720 = !DILocation(line: 367, column: 59, scope: !3709)
!3721 = !DILocation(line: 374, column: 9, scope: !3709)
!3722 = !DILocation(line: 374, column: 24, scope: !3709)
!3723 = !DILocation(line: 380, column: 9, scope: !3709)
!3724 = !DILocation(line: 380, column: 28, scope: !3709)
!3725 = !DILocation(line: 381, column: 9, scope: !3709)
!3726 = !DILocation(line: 381, column: 28, scope: !3709)
!3727 = !DILocation(line: 384, column: 20, scope: !3728)
!3728 = distinct !DILexicalBlock(scope: !3729, file: !379, line: 383, column: 43)
!3729 = distinct !DILexicalBlock(scope: !3709, file: !379, line: 383, column: 23)
!3730 = !DILocation(line: 435, column: 5, scope: !3709)
!3731 = distinct !DISubprogram(name: "vector", linkageName: "_ZN3aie6vectorIfLj8EEC2E7v8float", scope: !188, file: !189, line: 159, type: !279, scopeLine: 161, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !278, retainedNodes: !3732)
!3732 = !{!3733, !3734}
!3733 = !DILocalVariable(name: "this", arg: 1, scope: !3731, type: !1896, flags: DIFlagArtificial | DIFlagObjectPointer)
!3734 = !DILocalVariable(name: "v", arg: 2, scope: !3731, file: !189, line: 159, type: !281)
!3735 = !DILocation(line: 0, scope: !3731)
!3736 = !DILocation(line: 159, column: 22, scope: !3731)
!3737 = !DILocation(line: 160, column: 9, scope: !3731)
!3738 = !DILocation(line: 163, column: 5, scope: !3731)
!3739 = distinct !DISubprogram(name: "insert<8U>", linkageName: "_ZN3aie6vectorIfLj8EE6insertILj8EEERS1_jRKNS0_IfXT_EEE", scope: !188, file: !189, line: 368, type: !3740, scopeLine: 369, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3743, declaration: !3742, retainedNodes: !3744)
!3740 = !DISubroutineType(types: !3741)
!3741 = !{!297, !262, !15, !1929}
!3742 = !DISubprogram(name: "insert<8U>", linkageName: "_ZN3aie6vectorIfLj8EE6insertILj8EEERS1_jRKNS0_IfXT_EEE", scope: !188, file: !189, line: 368, type: !3740, scopeLine: 368, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !3743)
!3743 = !{!2346}
!3744 = !{!3745, !3746, !3747}
!3745 = !DILocalVariable(name: "this", arg: 1, scope: !3739, type: !1896, flags: DIFlagArtificial | DIFlagObjectPointer)
!3746 = !DILocalVariable(name: "idx", arg: 2, scope: !3739, file: !189, line: 368, type: !15)
!3747 = !DILocalVariable(name: "v", arg: 3, scope: !3739, file: !189, line: 368, type: !1929)
!3748 = !DILocation(line: 0, scope: !3739)
!3749 = !DILocation(line: 368, column: 29, scope: !3739)
!3750 = !DILocation(line: 368, column: 60, scope: !3739)
!3751 = !DILocation(line: 370, column: 45, scope: !3739)
!3752 = !DILocation(line: 370, column: 50, scope: !3739)
!3753 = !DILocation(line: 370, column: 29, scope: !3739)
!3754 = !DILocation(line: 371, column: 9, scope: !3739)
!3755 = distinct !DISubprogram(name: "insert<8U>", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE6insertILj8EEERS2_jRKNS1_IfXT_EEE", scope: !192, file: !193, line: 847, type: !3756, scopeLine: 848, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3743, declaration: !3759, retainedNodes: !3760)
!3756 = !DISubroutineType(types: !3757)
!3757 = !{!245, !228, !15, !3758}
!3758 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !254, size: 32)
!3759 = !DISubprogram(name: "insert<8U>", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE6insertILj8EEERS2_jRKNS1_IfXT_EEE", scope: !192, file: !193, line: 847, type: !3756, scopeLine: 847, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !3743)
!3760 = !{!3761, !3762, !3763}
!3761 = !DILocalVariable(name: "this", arg: 1, scope: !3755, type: !2085, flags: DIFlagArtificial | DIFlagObjectPointer)
!3762 = !DILocalVariable(name: "idx", arg: 2, scope: !3755, file: !193, line: 847, type: !15)
!3763 = !DILocalVariable(name: "v", arg: 3, scope: !3755, file: !193, line: 847, type: !3758)
!3764 = !DILocation(line: 0, scope: !3755)
!3765 = !DILocation(line: 847, column: 34, scope: !3755)
!3766 = !DILocation(line: 847, column: 70, scope: !3755)
!3767 = !DILocation(line: 849, column: 9, scope: !3755)
!3768 = !DILocation(line: 849, column: 9, scope: !3769)
!3769 = distinct !DILexicalBlock(scope: !3770, file: !193, line: 849, column: 9)
!3770 = distinct !DILexicalBlock(scope: !3755, file: !193, line: 849, column: 9)
!3771 = !DILocation(line: 849, column: 9, scope: !3770)
!3772 = !DILocation(line: 849, column: 9, scope: !3773)
!3773 = distinct !DILexicalBlock(scope: !3769, file: !193, line: 849, column: 9)
!3774 = !DILocation(line: 849, column: 9, scope: !3775)
!3775 = distinct !DILexicalBlock(scope: !3776, file: !193, line: 849, column: 9)
!3776 = distinct !DILexicalBlock(scope: !3773, file: !193, line: 849, column: 9)
!3777 = !DILocation(line: 849, column: 9, scope: !3776)
!3778 = !DILocation(line: 849, column: 9, scope: !3779)
!3779 = distinct !DILexicalBlock(scope: !3769, file: !193, line: 849, column: 9)
!3780 = !DILocation(line: 851, column: 32, scope: !3755)
!3781 = !DILocation(line: 851, column: 37, scope: !3755)
!3782 = !DILocation(line: 851, column: 9, scope: !3755)
!3783 = !DILocation(line: 853, column: 9, scope: !3755)
!3784 = distinct !DISubprogram(name: "insert_helper<8U>", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE13insert_helperILj8EEEvjRKNS1_IfXT_EEE", scope: !192, file: !193, line: 1200, type: !3785, scopeLine: 1201, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !3788, declaration: !3787, retainedNodes: !3789)
!3785 = !DISubroutineType(types: !3786)
!3786 = !{null, !228, !15, !3758}
!3787 = !DISubprogram(name: "insert_helper<8U>", linkageName: "_ZN3aie6detail11vector_baseIfLj8EE13insert_helperILj8EEEvjRKNS1_IfXT_EEE", scope: !192, file: !193, line: 1200, type: !3785, scopeLine: 1200, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !3788)
!3788 = !{!2656}
!3789 = !{!3790, !3791, !3792, !3793}
!3790 = !DILocalVariable(name: "this", arg: 1, scope: !3784, type: !2085, flags: DIFlagArtificial | DIFlagObjectPointer)
!3791 = !DILocalVariable(name: "idx", arg: 2, scope: !3784, file: !193, line: 1200, type: !15)
!3792 = !DILocalVariable(name: "v", arg: 3, scope: !3784, file: !193, line: 1200, type: !3758)
!3793 = !DILocalVariable(name: "input_bits", scope: !3784, file: !193, line: 1202, type: !101)
!3794 = !DILocation(line: 0, scope: !3784)
!3795 = !DILocation(line: 1200, column: 33, scope: !3784)
!3796 = !DILocation(line: 1200, column: 68, scope: !3784)
!3797 = !DILocation(line: 1202, column: 9, scope: !3784)
!3798 = !DILocation(line: 1202, column: 28, scope: !3784)
!3799 = !DILocation(line: 1208, column: 20, scope: !3800)
!3800 = distinct !DILexicalBlock(scope: !3801, file: !193, line: 1207, column: 45)
!3801 = distinct !DILexicalBlock(scope: !3784, file: !193, line: 1207, column: 23)
!3802 = !DILocation(line: 1208, column: 22, scope: !3800)
!3803 = !DILocation(line: 1208, column: 13, scope: !3800)
!3804 = !DILocation(line: 1208, column: 18, scope: !3800)
!3805 = !DILocation(line: 1276, column: 5, scope: !3784)
!3806 = distinct !DISubprogram(name: "operator v8accfloat", linkageName: "_ZNK3aie6detail10accum_baseILNS0_10AccumClassE2ELj32ELj8EEcv10v8accfloatEv", scope: !378, file: !379, line: 256, type: !418, scopeLine: 257, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !417, retainedNodes: !3807)
!3807 = !{!3808}
!3808 = !DILocalVariable(name: "this", arg: 1, scope: !3806, type: !3271, flags: DIFlagArtificial | DIFlagObjectPointer)
!3809 = !DILocation(line: 0, scope: !3806)
!3810 = !DILocation(line: 258, column: 16, scope: !3806)
!3811 = distinct !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE7extractILj8EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 867, type: !3812, scopeLine: 868, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !1989, declaration: !3814, retainedNodes: !3815)
!3812 = !DISubroutineType(types: !3813)
!3813 = !{!192, !253, !15}
!3814 = !DISubprogram(name: "extract<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE7extractILj8EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 867, type: !3812, scopeLine: 867, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !1989)
!3815 = !{!3816, !3817}
!3816 = !DILocalVariable(name: "this", arg: 1, scope: !3811, type: !3171, flags: DIFlagArtificial | DIFlagObjectPointer)
!3817 = !DILocalVariable(name: "idx", arg: 2, scope: !3811, file: !193, line: 867, type: !15)
!3818 = !DILocation(line: 0, scope: !3811)
!3819 = !DILocation(line: 867, column: 47, scope: !3811)
!3820 = !DILocation(line: 869, column: 9, scope: !3811)
!3821 = !DILocation(line: 869, column: 9, scope: !3822)
!3822 = distinct !DILexicalBlock(scope: !3823, file: !193, line: 869, column: 9)
!3823 = distinct !DILexicalBlock(scope: !3811, file: !193, line: 869, column: 9)
!3824 = !DILocation(line: 869, column: 9, scope: !3823)
!3825 = !DILocation(line: 869, column: 9, scope: !3826)
!3826 = distinct !DILexicalBlock(scope: !3822, file: !193, line: 869, column: 9)
!3827 = !DILocation(line: 869, column: 9, scope: !3828)
!3828 = distinct !DILexicalBlock(scope: !3829, file: !193, line: 869, column: 9)
!3829 = distinct !DILexicalBlock(scope: !3826, file: !193, line: 869, column: 9)
!3830 = !DILocation(line: 869, column: 9, scope: !3829)
!3831 = !DILocation(line: 869, column: 9, scope: !3832)
!3832 = distinct !DILexicalBlock(scope: !3822, file: !193, line: 869, column: 9)
!3833 = !DILocation(line: 871, column: 41, scope: !3811)
!3834 = !DILocation(line: 871, column: 16, scope: !3811)
!3835 = !DILocation(line: 871, column: 9, scope: !3811)
!3836 = distinct !DISubprogram(name: "extract_helper<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE14extract_helperILj8EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 1280, type: !3812, scopeLine: 1281, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, templateParams: !2229, declaration: !3837, retainedNodes: !3838)
!3837 = !DISubprogram(name: "extract_helper<8U>", linkageName: "_ZNK3aie6detail11vector_baseIfLj8EE14extract_helperILj8EEENS1_IfXT_EEEj", scope: !192, file: !193, line: 1280, type: !3812, scopeLine: 1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, templateParams: !2229)
!3838 = !{!3839, !3840, !3841}
!3839 = !DILocalVariable(name: "this", arg: 1, scope: !3836, type: !3171, flags: DIFlagArtificial | DIFlagObjectPointer)
!3840 = !DILocalVariable(name: "idx", arg: 2, scope: !3836, file: !193, line: 1280, type: !15)
!3841 = !DILocalVariable(name: "output_bits", scope: !3836, file: !193, line: 1282, type: !101)
!3842 = !DILocation(line: 0, scope: !3836)
!3843 = !DILocation(line: 1280, column: 56, scope: !3836)
!3844 = !DILocation(line: 1282, column: 9, scope: !3836)
!3845 = !DILocation(line: 1282, column: 28, scope: !3836)
!3846 = !DILocation(line: 1288, column: 20, scope: !3847)
!3847 = distinct !DILexicalBlock(scope: !3848, file: !193, line: 1287, column: 46)
!3848 = distinct !DILexicalBlock(scope: !3836, file: !193, line: 1287, column: 23)
!3849 = !DILocation(line: 1328, column: 5, scope: !3836)
!3850 = distinct !DISubprogram(name: "kernelMatVecMulClass", linkageName: "_ZN2xf3dsp3aie4blas17matrix_vector_mul20kernelMatVecMulClassIffLj128ELj768ELj0ELj0ELj0ELj1ELj12ELj1ELj0ELj0ELj1ELj11ELb1ELb0EEC2Ev", scope: !85, file: !86, line: 137, type: !157, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !156, retainedNodes: !3851)
!3851 = !{!3852}
!3852 = !DILocalVariable(name: "this", arg: 1, scope: !3850, type: !180, flags: DIFlagArtificial | DIFlagObjectPointer)
!3853 = !DILocation(line: 0, scope: !3850)
!3854 = !DILocation(line: 137, column: 29, scope: !3850)
!3855 = distinct !DISubprogram(linkageName: "_GLOBAL__sub_I_i0_wrap_matrix_vector_mul.cpp", scope: !1401, file: !1401, type: !3856, flags: DIFlagArtificial | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!3856 = !DISubroutineType(types: !137)
!3857 = !DILocation(line: 0, scope: !3855)
