; ModuleID = 'i19_window_split_128_to_64x2.ll'
source_filename = "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/window_split_128_to_64x2.cpp"
target datalayout = "e-i8:8:8-i16:16:16-i32:32:32-i64:32:32-f32:32:32-f64:32:32-p:32:32:32:32:8-s0:256:256-a0:8:8-S256-n32:64-P1-p0:20:32:32:32:8-p1:20:32:32:32:8-p2:20:32:32:32:8-p3:20:32:32:32:8-p4:20:32:32:32:8-p5:20:32:32:32:8-p6:20:32:32:32:8-p7:20:32:32:32:8-p8:20:32:32:32:8-p9:20:32:32:32:8-p10:20:32:32:32:8-p11:20:32:32:32:8-p12:20:32:32:32:8-p13:20:32:32:32:8-p14:20:32:32:32:8-p15:20:32:32:32:8"
target triple = "pdarch-unknown-unknown-elf"

%struct.output_window = type { i32, i32, ptr, ptr, [2 x ptr], ptr, [2 x ptr], i32, i32, [2 x i32] }
%struct.input_window = type { i32, i32, ptr, ptr, [2 x ptr], ptr, [2 x ptr], i32, i32, [2 x i32] }
%struct.ipd.custom_type.addr_t.addr_t = type { i20 }
%struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t = type { ptr, %struct.ipd.custom_type.addr_t.addr_t, %struct.ipd.custom_type.addr_t.addr_t }

$_Z10cyclic_addPaiS_j = comdat any

$_ZN6addr_tC2Ei = comdat any

$_Z11add_3d_byteIaEPT_S1_iiR6addr_tiiS3_i = comdat any

$_Z15add_3d_byte_intIa6addr_tS0_EN13chessEnableIfIXaasr17chessIsCompatibleIN15chessRemoveQualIT0_E4typeES0_EE5valuesr17chessIsCompatibleINS2_IT1_E4typeES0_EE5valueEPT_E4typeESA_iiiS0_S0_RS3_S0_S0_RS6_ = comdat any

; Function Attrs: mustprogress noinline nounwind
define dso_local void @_Z24window_split_128_to_64x2P12input_windowIfEP13output_windowIfES4_(ptr chesscopy noalias %in, ptr chesscopy noalias %out0, ptr chesscopy noalias %out1) addrspace(1) #0 !dbg !275 {
entry:
  %in.addr = alloca ptr, align 4
  %out0.addr = alloca ptr, align 4
  %out1.addr = alloca ptr, align 4
  %N = alloca i32, align 4
  %H = alloca i32, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  %0 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %in.addr, i32 0, metadata !294), !noalias !297
  store ptr %in, ptr %in.addr, align 4, !tbaa !300, !noalias !297
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %in.addr, metadata !284, metadata !DIExpression()), !dbg !304
  %1 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %out0.addr, i32 0, metadata !305), !noalias !297
  store ptr %out0, ptr %out0.addr, align 4, !tbaa !300, !noalias !297
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out0.addr, metadata !285, metadata !DIExpression()), !dbg !306
  %2 = call addrspace(1) ptr @llvm.noalias.decl.p0.p0.i32(ptr %out1.addr, i32 0, metadata !307), !noalias !297
  store ptr %out1, ptr %out1.addr, align 4, !tbaa !300, !noalias !297
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %out1.addr, metadata !286, metadata !DIExpression()), !dbg !308
  store i32 undef, ptr %N, align 4, !dbg !309, !noalias !297
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %N) #11, !dbg !309, !noalias !297
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %N, metadata !287, metadata !DIExpression()), !dbg !310
  store i32 128, ptr %N, align 4, !dbg !310, !tbaa !311, !noalias !297
  store i32 undef, ptr %H, align 4, !dbg !313, !noalias !297
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %H) #11, !dbg !313, !noalias !297
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %H, metadata !289, metadata !DIExpression()), !dbg !314
  store i32 64, ptr %H, align 4, !dbg !314, !tbaa !311, !noalias !297
  store i32 undef, ptr %i, align 4, !dbg !315, !noalias !297
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %i) #11, !dbg !315, !noalias !297
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %i, metadata !290, metadata !DIExpression()), !dbg !316
  store i32 0, ptr %i, align 4, !dbg !316, !tbaa !311, !noalias !297
  br label %for.cond, !dbg !315

for.cond:                                         ; preds = %for.inc, %entry
  %3 = load i32, ptr %i, align 4, !dbg !317, !tbaa !311, !noalias !297
  %cmp = icmp slt i32 %3, 64, !dbg !319
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !320

for.cond.cleanup:                                 ; preds = %for.cond
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %i) #11, !dbg !321, !noalias !297
  br label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load ptr, ptr %out0.addr, align 4, !dbg !322, !tbaa !300, !noalias !297
  %5 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %4, ptr %1, ptr %out0.addr, i32 0, metadata !305), !dbg !322, !tbaa !300, !noalias !297
  %6 = load ptr, ptr %in.addr, align 4, !dbg !323, !tbaa !300, !noalias !297
  %7 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %6, ptr %0, ptr %in.addr, i32 0, metadata !294), !dbg !323, !tbaa !300, !noalias !297
  %call = call noundef addrspace(1) float @_ZL15window_readincrIL15aie_dm_resource0EEfP12input_windowIfE(ptr %7) #12, !dbg !324, !noalias !297
  call addrspace(1) void @_ZL16window_writeincrIL15aie_dm_resource0EEvP13output_windowIfEf(ptr %5, float noundef %call) #12, !dbg !325, !noalias !297
  br label %for.inc, !dbg !325

for.inc:                                          ; preds = %for.body
  %8 = load i32, ptr %i, align 4, !dbg !326, !tbaa !311, !noalias !297
  %inc = add nsw i32 %8, 1, !dbg !326
  store i32 %inc, ptr %i, align 4, !dbg !326, !tbaa !311, !noalias !297
  br label %for.cond, !dbg !321, !llvm.loop !327

for.end:                                          ; preds = %for.cond.cleanup
  store i32 undef, ptr %i1, align 4, !dbg !330, !noalias !297
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %i1) #11, !dbg !330, !noalias !297
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %i1, metadata !292, metadata !DIExpression()), !dbg !331
  store i32 0, ptr %i1, align 4, !dbg !331, !tbaa !311, !noalias !297
  br label %for.cond2, !dbg !330

for.cond2:                                        ; preds = %for.inc7, %for.end
  %9 = load i32, ptr %i1, align 4, !dbg !332, !tbaa !311, !noalias !297
  %cmp3 = icmp slt i32 %9, 64, !dbg !334
  br i1 %cmp3, label %for.body5, label %for.cond.cleanup4, !dbg !335

for.cond.cleanup4:                                ; preds = %for.cond2
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %i1) #11, !dbg !336, !noalias !297
  br label %for.end9

for.body5:                                        ; preds = %for.cond2
  %10 = load ptr, ptr %out1.addr, align 4, !dbg !337, !tbaa !300, !noalias !297
  %11 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %10, ptr %2, ptr %out1.addr, i32 0, metadata !307), !dbg !337, !tbaa !300, !noalias !297
  %12 = load ptr, ptr %in.addr, align 4, !dbg !338, !tbaa !300, !noalias !297
  %13 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %12, ptr %0, ptr %in.addr, i32 0, metadata !294), !dbg !338, !tbaa !300, !noalias !297
  %call6 = call noundef addrspace(1) float @_ZL15window_readincrIL15aie_dm_resource0EEfP12input_windowIfE(ptr %13) #12, !dbg !339, !noalias !297
  call addrspace(1) void @_ZL16window_writeincrIL15aie_dm_resource0EEvP13output_windowIfEf(ptr %11, float noundef %call6) #12, !dbg !340, !noalias !297
  br label %for.inc7, !dbg !340

for.inc7:                                         ; preds = %for.body5
  %14 = load i32, ptr %i1, align 4, !dbg !341, !tbaa !311, !noalias !297
  %inc8 = add nsw i32 %14, 1, !dbg !341
  store i32 %inc8, ptr %i1, align 4, !dbg !341, !tbaa !311, !noalias !297
  br label %for.cond2, !dbg !336, !llvm.loop !342

for.end9:                                         ; preds = %for.cond.cleanup4
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %H) #11, !dbg !344
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %N) #11, !dbg !344
  ret void, !dbg !344
}

; Function Attrs: nounwind willreturn memory(inaccessiblemem: readwrite)
declare ptr @llvm.noalias.decl.p0.p0.i32(ptr, i32, metadata) addrspace(1) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) addrspace(1) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) addrspace(1) #3

; Function Attrs: inlinehint mustprogress nounwind
define internal void @_ZL16window_writeincrIL15aie_dm_resource0EEvP13output_windowIfEf(ptr %w, float noundef %value) addrspace(1) #4 !dbg !76 !noalias !345 {
entry:
  %w.addr = alloca ptr, align 4
  %value.addr = alloca float, align 4
  store ptr %w, ptr %w.addr, align 4, !tbaa !300, !noalias !345
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w.addr, metadata !94, metadata !DIExpression()), !dbg !348
  store float %value, ptr %value.addr, align 4, !tbaa !349, !noalias !345
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %value.addr, metadata !95, metadata !DIExpression()), !dbg !348
  %0 = load float, ptr %value.addr, align 4, !dbg !348, !tbaa !349, !noalias !345
  %1 = load ptr, ptr %w.addr, align 4, !dbg !348, !tbaa !300, !noalias !345
  %ptr = getelementptr inbounds %struct.output_window, ptr %1, i32 0, i32 2, !dbg !348
  %2 = load ptr, ptr %ptr, align 4, !dbg !348, !tbaa !351, !noalias !345
  %3 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %2, ptr null, ptr %ptr, i32 0, metadata !345), !dbg !348, !tbaa !351, !noalias !345
  store float %0, ptr %3, align 4, !dbg !348, !tbaa !349, !noalias !345
  %4 = load ptr, ptr %w.addr, align 4, !dbg !348, !tbaa !300, !noalias !345
  call addrspace(1) void @_ZL11window_incrP13output_windowIfEi(ptr %4, i32 noundef 1) #12, !dbg !348, !noalias !345
  ret void, !dbg !348
}

; Function Attrs: nounwind speculatable willreturn memory(argmem: readwrite)
declare ptr @llvm.noalias.p0.p0.p0.i32(ptr, ptr, ptr, i32, metadata) addrspace(1) #5

; Function Attrs: inlinehint mustprogress nounwind
define internal noundef float @_ZL15window_readincrIL15aie_dm_resource0EEfP12input_windowIfE(ptr %w) addrspace(1) #4 !dbg !353 {
entry:
  %w.addr = alloca ptr, align 4
  %value = alloca float, align 4
  store ptr %w, ptr %w.addr, align 4, !tbaa !300
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w.addr, metadata !357, metadata !DIExpression()), !dbg !359
  store float undef, ptr %value, align 4, !dbg !359
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %value) #11, !dbg !359
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %value, metadata !358, metadata !DIExpression()), !dbg !359
  %0 = load ptr, ptr %w.addr, align 4, !dbg !359, !tbaa !300
  call addrspace(1) void @_ZL15window_readincrIL15aie_dm_resource0EEvP12input_windowIfERf(ptr %0, ptr nonnull align 4 dereferenceable(4) %value) #12, !dbg !359
  %1 = load float, ptr %value, align 4, !dbg !359, !tbaa !349
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %value) #11, !dbg !359
  ret float %1, !dbg !359
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) addrspace(1) #3

; Function Attrs: inlinehint mustprogress nounwind
define internal void @_ZL15window_readincrIL15aie_dm_resource0EEvP12input_windowIfERf(ptr %w, ptr nonnull align 4 dereferenceable(4) %value) addrspace(1) #4 !dbg !28 !noalias !360 {
entry:
  %w.addr = alloca ptr, align 4
  %value.addr = alloca ptr, align 4
  store ptr %w, ptr %w.addr, align 4, !tbaa !300, !noalias !360
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w.addr, metadata !61, metadata !DIExpression()), !dbg !363
  store ptr %value, ptr %value.addr, align 4, !tbaa !300, !noalias !360
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %value.addr, metadata !62, metadata !DIExpression()), !dbg !363
  %0 = load ptr, ptr %w.addr, align 4, !dbg !363, !tbaa !300, !noalias !360
  %ptr = getelementptr inbounds %struct.input_window, ptr %0, i32 0, i32 2, !dbg !363
  %1 = load ptr, ptr %ptr, align 4, !dbg !363, !tbaa !364, !noalias !360
  %2 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %1, ptr null, ptr %ptr, i32 0, metadata !360), !dbg !363, !tbaa !364, !noalias !360
  %3 = load float, ptr %2, align 4, !dbg !363, !tbaa !349, !noalias !360
  %4 = load ptr, ptr %value.addr, align 4, !dbg !363, !tbaa !300, !noalias !360
  store float %3, ptr %4, align 4, !dbg !363, !tbaa !349, !noalias !360
  %5 = load ptr, ptr %w.addr, align 4, !dbg !363, !tbaa !300, !noalias !360
  call addrspace(1) void @_ZL11window_incrP12input_windowIfEi(ptr %5, i32 noundef 1) #12, !dbg !363, !noalias !360
  ret void, !dbg !363
}

; Function Attrs: inlinehint mustprogress nounwind
define internal void @_ZL11window_incrP12input_windowIfEi(ptr %w, i32 noundef %count) addrspace(1) #4 !dbg !366 !noalias !372 {
entry:
  %w.addr = alloca ptr, align 4
  %count.addr = alloca i32, align 4
  store ptr %w, ptr %w.addr, align 4, !tbaa !300, !noalias !372
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w.addr, metadata !370, metadata !DIExpression()), !dbg !375
  store i32 %count, ptr %count.addr, align 4, !tbaa !311, !noalias !372
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %count.addr, metadata !371, metadata !DIExpression()), !dbg !375
  %0 = load i32, ptr %count.addr, align 4, !dbg !375, !tbaa !311, !noalias !372
  %mul = mul i32 %0, 4, !dbg !375
  store i32 %mul, ptr %count.addr, align 4, !dbg !375, !tbaa !311, !noalias !372
  %1 = load ptr, ptr %w.addr, align 4, !dbg !375, !tbaa !300, !noalias !372
  %ptr = getelementptr inbounds %struct.input_window, ptr %1, i32 0, i32 2, !dbg !375
  %2 = load ptr, ptr %ptr, align 4, !dbg !375, !tbaa !364, !noalias !372
  %3 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %2, ptr null, ptr %ptr, i32 0, metadata !372), !dbg !375, !tbaa !364, !noalias !372
  %4 = load i32, ptr %count.addr, align 4, !dbg !375, !tbaa !311, !noalias !372
  %5 = load ptr, ptr %w.addr, align 4, !dbg !375, !tbaa !300, !noalias !372
  %buffer = getelementptr inbounds %struct.input_window, ptr %5, i32 0, i32 5, !dbg !375
  %6 = load ptr, ptr %buffer, align 4, !dbg !375, !tbaa !376, !noalias !372
  %7 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %6, ptr null, ptr %buffer, i32 0, metadata !372), !dbg !375, !tbaa !376, !noalias !372
  %8 = load ptr, ptr %w.addr, align 4, !dbg !375, !tbaa !300, !noalias !372
  %size = getelementptr inbounds %struct.input_window, ptr %8, i32 0, i32 7, !dbg !375
  %9 = load i32, ptr %size, align 4, !dbg !375, !tbaa !377, !noalias !372
  %call = call addrspace(1) ptr @_Z10cyclic_addPaiS_j(ptr %3, i32 noundef %4, ptr %7, i32 noundef %9) #12, !dbg !375, !noalias !372
  %10 = load ptr, ptr %w.addr, align 4, !dbg !375, !tbaa !300, !noalias !372
  %ptr1 = getelementptr inbounds %struct.input_window, ptr %10, i32 0, i32 2, !dbg !375
  store ptr %call, ptr %ptr1, align 4, !dbg !375, !tbaa !364, !noalias !372
  ret void, !dbg !375
}

; Function Attrs: inlinehint mustprogress nounwind
define linkonce_odr dso_local ptr @_Z10cyclic_addPaiS_j(ptr %ptr, i32 noundef %count, ptr %base, i32 noundef %size) addrspace(1) #4 comdat !dbg !378 {
entry:
  %ptr.addr = alloca ptr, align 4
  %count.addr = alloca i32, align 4
  %base.addr = alloca ptr, align 4
  %size.addr = alloca i32, align 4
  %c0 = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %c1 = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %custom_type.tmp1 = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  store ptr %ptr, ptr %ptr.addr, align 4, !tbaa !300
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %ptr.addr, metadata !382, metadata !DIExpression()), !dbg !389
  store i32 %count, ptr %count.addr, align 4, !tbaa !311
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %count.addr, metadata !383, metadata !DIExpression()), !dbg !390
  store ptr %base, ptr %base.addr, align 4, !tbaa !300
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %base.addr, metadata !384, metadata !DIExpression()), !dbg !391
  store i32 %size, ptr %size.addr, align 4, !tbaa !311
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %size.addr, metadata !385, metadata !DIExpression()), !dbg !392
  store %struct.ipd.custom_type.addr_t.addr_t undef, ptr %c0, align 4, !dbg !393
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %c0) #11, !dbg !393
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %c0, metadata !386, metadata !DIExpression()), !dbg !394
  %0 = load ptr, ptr %ptr.addr, align 4, !dbg !395, !tbaa !300
  %1 = ptrtoint ptr %0 to i32, !dbg !396
  call addrspace(1) void @_ZN6addr_tC2Ei(ptr nonnull align 4 dereferenceable(3) %custom_type.tmp, i32 %1) #12, !dbg !396
  %2 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %custom_type.tmp, align 4, !dbg !396, !tbaa !397
  store %struct.ipd.custom_type.addr_t.addr_t %2, ptr %c0, align 4, !dbg !396, !tbaa !397
  store %struct.ipd.custom_type.addr_t.addr_t undef, ptr %c1, align 4, !dbg !399
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %c1) #11, !dbg !399
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %c1, metadata !388, metadata !DIExpression()), !dbg !400
  %3 = load ptr, ptr %ptr.addr, align 4, !dbg !401, !tbaa !300
  %4 = ptrtoint ptr %3 to i32, !dbg !402
  call addrspace(1) void @_ZN6addr_tC2Ei(ptr nonnull align 4 dereferenceable(3) %custom_type.tmp1, i32 %4) #12, !dbg !402
  %5 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %custom_type.tmp1, align 4, !dbg !402, !tbaa !397
  store %struct.ipd.custom_type.addr_t.addr_t %5, ptr %c1, align 4, !dbg !402, !tbaa !397
  %6 = load ptr, ptr %ptr.addr, align 4, !dbg !403, !tbaa !300
  %7 = load i32, ptr %count.addr, align 4, !dbg !404, !tbaa !311
  %8 = load i32, ptr %size.addr, align 4, !dbg !405, !tbaa !311
  %sub = sub i32 %7, %8, !dbg !406
  %9 = load ptr, ptr %base.addr, align 4, !dbg !407, !tbaa !300
  %10 = load i32, ptr %count.addr, align 4, !dbg !408, !tbaa !311
  %idx.neg = sub i32 0, %10, !dbg !409
  %add.ptr = getelementptr inbounds i8, ptr %9, i32 %idx.neg, !dbg !409
  %11 = ptrtoint ptr %add.ptr to i32, !dbg !410
  %12 = load i32, ptr %count.addr, align 4, !dbg !411, !tbaa !311
  %13 = load i32, ptr %size.addr, align 4, !dbg !412, !tbaa !311
  %add = add i32 %12, %13, !dbg !413
  %14 = load ptr, ptr %base.addr, align 4, !dbg !414, !tbaa !300
  %15 = load i32, ptr %count.addr, align 4, !dbg !415, !tbaa !311
  %idx.neg2 = sub i32 0, %15, !dbg !416
  %add.ptr3 = getelementptr inbounds i8, ptr %14, i32 %idx.neg2, !dbg !416
  %16 = load i32, ptr %size.addr, align 4, !dbg !417, !tbaa !311
  %add.ptr4 = getelementptr inbounds i8, ptr %add.ptr3, i32 %16, !dbg !418
  %17 = ptrtoint ptr %add.ptr4 to i32, !dbg !419
  %18 = load i32, ptr %count.addr, align 4, !dbg !420, !tbaa !311
  %call = call addrspace(1) ptr @_Z11add_3d_byteIaEPT_S1_iiR6addr_tiiS3_i(ptr %6, i32 noundef %sub, i32 noundef %11, ptr nonnull align 4 dereferenceable(3) %c0, i32 noundef %add, i32 noundef %17, ptr nonnull align 4 dereferenceable(3) %c1, i32 noundef %18) #12, !dbg !421
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %c1) #11, !dbg !422
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %c0) #11, !dbg !422
  ret ptr %call, !dbg !423
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr dso_local void @_ZN6addr_tC2Ei(ptr nonnull align 4 dereferenceable(3) %this, i32 %a) unnamed_addr addrspace(1) #6 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 4
  %a.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 4, !tbaa !300
  store i32 %a, ptr %a.addr, align 4, !tbaa !311
  %this1 = load ptr, ptr %this.addr, align 4
  store i20 0, ptr %this1, align 4
  %0 = load i32, ptr %a.addr, align 4, !tbaa !311
  %1 = call addrspace(1) %struct.ipd.custom_type.addr_t.addr_t @llvm.chess.init.customint.s_struct.ipd.custom_type.addr_t.addr_ts.i32.p1(%struct.ipd.custom_type.addr_t.addr_t undef, i32 %0, i32 20, i32 32, i1 true, i32 0, ptr addrspace(1) @__regcall3__chessintr_addr_t_addr_t___sint)
  store %struct.ipd.custom_type.addr_t.addr_t %1, ptr %this1, align 4
  ret void
}

; Function Attrs: inlinehint mustprogress nounwind
define linkonce_odr dso_local ptr @_Z11add_3d_byteIaEPT_S1_iiR6addr_tiiS3_i(ptr %a, i32 noundef %off, i32 noundef %size1, ptr nonnull align 4 dereferenceable(3) %count1, i32 noundef %inc1, i32 noundef %size2, ptr nonnull align 4 dereferenceable(3) %count2, i32 noundef %inc2) addrspace(1) #4 comdat !dbg !424 {
entry:
  %a.addr = alloca ptr, align 4
  %off.addr = alloca i32, align 4
  %size1.addr = alloca i32, align 4
  %count1.addr = alloca ptr, align 4
  %inc1.addr = alloca i32, align 4
  %size2.addr = alloca i32, align 4
  %count2.addr = alloca ptr, align 4
  %inc2.addr = alloca i32, align 4
  %c = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %c2 = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %r = alloca ptr, align 4
  %agg.tmp = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %custom_type.tmp = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %agg.tmp1 = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %custom_type.tmp2 = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  store ptr %a, ptr %a.addr, align 4, !tbaa !300
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %a.addr, metadata !429, metadata !DIExpression()), !dbg !442
  store i32 %off, ptr %off.addr, align 4, !tbaa !311
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %off.addr, metadata !430, metadata !DIExpression()), !dbg !443
  store i32 %size1, ptr %size1.addr, align 4, !tbaa !311
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %size1.addr, metadata !431, metadata !DIExpression()), !dbg !444
  store ptr %count1, ptr %count1.addr, align 4, !tbaa !300
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %count1.addr, metadata !432, metadata !DIExpression()), !dbg !445
  store i32 %inc1, ptr %inc1.addr, align 4, !tbaa !311
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inc1.addr, metadata !433, metadata !DIExpression()), !dbg !446
  store i32 %size2, ptr %size2.addr, align 4, !tbaa !311
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %size2.addr, metadata !434, metadata !DIExpression()), !dbg !447
  store ptr %count2, ptr %count2.addr, align 4, !tbaa !300
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %count2.addr, metadata !435, metadata !DIExpression()), !dbg !448
  store i32 %inc2, ptr %inc2.addr, align 4, !tbaa !311
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %inc2.addr, metadata !436, metadata !DIExpression()), !dbg !449
  store %struct.ipd.custom_type.addr_t.addr_t undef, ptr %c, align 4, !dbg !450
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %c) #11, !dbg !450
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %c, metadata !437, metadata !DIExpression()), !dbg !451
  store %struct.ipd.custom_type.addr_t.addr_t undef, ptr %c2, align 4, !dbg !452
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %c2) #11, !dbg !452
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %c2, metadata !438, metadata !DIExpression()), !dbg !453
  store ptr undef, ptr %r, align 4, !dbg !454
  call addrspace(1) void @llvm.lifetime.start.p0(i64 4, ptr %r) #11, !dbg !454
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %r, metadata !439, metadata !DIExpression()), !dbg !455
  %0 = load ptr, ptr %a.addr, align 4, !dbg !456, !tbaa !300
  %1 = load i32, ptr %off.addr, align 4, !dbg !457, !tbaa !311
  %2 = load i32, ptr %inc1.addr, align 4, !dbg !458, !tbaa !311
  %3 = load i32, ptr %inc2.addr, align 4, !dbg !459, !tbaa !311
  %4 = load i32, ptr %size1.addr, align 4, !dbg !460, !tbaa !311
  call addrspace(1) void @_ZN6addr_tC2Ei(ptr nonnull align 4 dereferenceable(3) %custom_type.tmp, i32 %4) #12, !dbg !460
  %5 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %custom_type.tmp, align 4, !dbg !460, !tbaa !397
  store %struct.ipd.custom_type.addr_t.addr_t %5, ptr %agg.tmp, align 4, !dbg !460, !tbaa !397
  %6 = load ptr, ptr %count1.addr, align 4, !dbg !461, !tbaa !300
  %7 = load i32, ptr %size2.addr, align 4, !dbg !462, !tbaa !311
  call addrspace(1) void @_ZN6addr_tC2Ei(ptr nonnull align 4 dereferenceable(3) %custom_type.tmp2, i32 %7) #12, !dbg !462
  %8 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %custom_type.tmp2, align 4, !dbg !462, !tbaa !397
  store %struct.ipd.custom_type.addr_t.addr_t %8, ptr %agg.tmp1, align 4, !dbg !462, !tbaa !397
  %9 = load ptr, ptr %count2.addr, align 4, !dbg !463, !tbaa !300
  %10 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %agg.tmp, align 4, !dbg !464, !tbaa !397
  %11 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %6, align 4, !dbg !464, !tbaa !397
  %12 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %agg.tmp1, align 4, !dbg !464, !tbaa !397
  %13 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %9, align 4, !dbg !464, !tbaa !397
  %call = call addrspace(1) ptr @_Z15add_3d_byte_intIa6addr_tS0_EN13chessEnableIfIXaasr17chessIsCompatibleIN15chessRemoveQualIT0_E4typeES0_EE5valuesr17chessIsCompatibleINS2_IT1_E4typeES0_EE5valueEPT_E4typeESA_iiiS0_S0_RS3_S0_S0_RS6_(ptr %0, i32 %1, i32 %2, i32 %3, %struct.ipd.custom_type.addr_t.addr_t %10, %struct.ipd.custom_type.addr_t.addr_t %11, ptr nonnull align 4 dereferenceable(3) %c, %struct.ipd.custom_type.addr_t.addr_t %12, %struct.ipd.custom_type.addr_t.addr_t %13, ptr nonnull align 4 dereferenceable(3) %c2) #12, !dbg !464
  store ptr %call, ptr %r, align 4, !dbg !455, !tbaa !300
  %14 = load ptr, ptr %count1.addr, align 4, !dbg !465, !tbaa !300
  %15 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %c, align 4, !dbg !466, !tbaa !397
  store %struct.ipd.custom_type.addr_t.addr_t %15, ptr %14, align 4, !dbg !466, !tbaa !397
  %16 = load ptr, ptr %count2.addr, align 4, !dbg !467, !tbaa !300
  %17 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %c2, align 4, !dbg !468, !tbaa !397
  store %struct.ipd.custom_type.addr_t.addr_t %17, ptr %16, align 4, !dbg !468, !tbaa !397
  %18 = load ptr, ptr %r, align 4, !dbg !469, !tbaa !300
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %r) #11, !dbg !470
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %c2) #11, !dbg !470
  call addrspace(1) void @llvm.lifetime.end.p0(i64 4, ptr %c) #11, !dbg !470
  ret ptr %18, !dbg !471
}

; Function Attrs: nounwind willreturn memory(none)
declare dso_local x86_regcallcc %struct.ipd.custom_type.addr_t.addr_t @__regcall3__chessintr_addr_t_addr_t___sint(i32 signext) addrspace(1) #7

; Function Attrs: nounwind willreturn memory(none)
declare %struct.ipd.custom_type.addr_t.addr_t @llvm.chess.init.customint.s_struct.ipd.custom_type.addr_t.addr_ts.i32.p1(%struct.ipd.custom_type.addr_t.addr_t, i32, i32, i32, i1, i32, ptr addrspace(1)) addrspace(1) #8

; Function Attrs: alwaysinline mustprogress nounwind
define linkonce_odr dso_local ptr @_Z15add_3d_byte_intIa6addr_tS0_EN13chessEnableIfIXaasr17chessIsCompatibleIN15chessRemoveQualIT0_E4typeES0_EE5valuesr17chessIsCompatibleINS2_IT1_E4typeES0_EE5valueEPT_E4typeESA_iiiS0_S0_RS3_S0_S0_RS6_(ptr %a, i32 %off, i32 %inc1, i32 %inc2, %struct.ipd.custom_type.addr_t.addr_t %size1.coerce, %struct.ipd.custom_type.addr_t.addr_t %count1_in.coerce, ptr nonnull align 4 dereferenceable(3) %count1_out, %struct.ipd.custom_type.addr_t.addr_t %size2.coerce, %struct.ipd.custom_type.addr_t.addr_t %count2_in.coerce, ptr nonnull align 4 dereferenceable(3) %count2_out) addrspace(1) #9 comdat {
entry:
  %size1 = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %count1_in = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %size2 = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %count2_in = alloca %struct.ipd.custom_type.addr_t.addr_t, align 4
  %a.addr = alloca ptr, align 4
  %off.addr = alloca i32, align 4
  %inc1.addr = alloca i32, align 4
  %inc2.addr = alloca i32, align 4
  %count1_out.addr = alloca ptr, align 4
  %count2_out.addr = alloca ptr, align 4
  %chessLout = alloca %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t, align 1
  store %struct.ipd.custom_type.addr_t.addr_t %size1.coerce, ptr %size1, align 4
  store %struct.ipd.custom_type.addr_t.addr_t %count1_in.coerce, ptr %count1_in, align 4
  store %struct.ipd.custom_type.addr_t.addr_t %size2.coerce, ptr %size2, align 4
  store %struct.ipd.custom_type.addr_t.addr_t %count2_in.coerce, ptr %count2_in, align 4
  store ptr %a, ptr %a.addr, align 4, !tbaa !300
  store i32 %off, ptr %off.addr, align 4, !tbaa !311
  store i32 %inc1, ptr %inc1.addr, align 4, !tbaa !311
  store i32 %inc2, ptr %inc2.addr, align 4, !tbaa !311
  store ptr %count1_out, ptr %count1_out.addr, align 4, !tbaa !300
  store ptr %count2_out, ptr %count2_out.addr, align 4, !tbaa !300
  store %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t undef, ptr %chessLout, align 1
  call addrspace(1) void @llvm.lifetime.start.p0(i64 12, ptr %chessLout) #11
  %0 = load ptr, ptr %a.addr, align 4, !tbaa !300
  %1 = load i32, ptr %off.addr, align 4, !tbaa !311
  %2 = load i32, ptr %inc1.addr, align 4, !tbaa !311
  %3 = load i32, ptr %inc2.addr, align 4, !tbaa !311
  %4 = load ptr, ptr %count1_out.addr, align 4, !tbaa !300
  %5 = load ptr, ptr %count2_out.addr, align 4, !tbaa !300
  %6 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %size1, align 4, !tbaa !397
  %7 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %count1_in, align 4, !tbaa !397
  %8 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %4, align 4, !tbaa !397
  %9 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %size2, align 4, !tbaa !397
  %10 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %count2_in, align 4, !tbaa !397
  %11 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %5, align 4, !tbaa !397
  %call = call x86_regcallcc addrspace(1) %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t @__regcall3__chessintr___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t(ptr %0, i32 signext %1, i32 signext %2, i32 signext %3, %struct.ipd.custom_type.addr_t.addr_t %6, %struct.ipd.custom_type.addr_t.addr_t %7, %struct.ipd.custom_type.addr_t.addr_t %8, %struct.ipd.custom_type.addr_t.addr_t %9, %struct.ipd.custom_type.addr_t.addr_t %10, %struct.ipd.custom_type.addr_t.addr_t %11) #13
  %12 = getelementptr inbounds %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t, ptr %chessLout, i32 0, i32 0
  %13 = extractvalue %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t %call, 0
  store ptr %13, ptr %12, align 1
  %14 = getelementptr inbounds %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t, ptr %chessLout, i32 0, i32 1
  %15 = extractvalue %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t %call, 1
  store %struct.ipd.custom_type.addr_t.addr_t %15, ptr %14, align 1
  %16 = getelementptr inbounds %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t, ptr %chessLout, i32 0, i32 2
  %17 = extractvalue %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t %call, 2
  store %struct.ipd.custom_type.addr_t.addr_t %17, ptr %16, align 1
  %o1 = getelementptr inbounds %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t, ptr %chessLout, i32 0, i32 1
  %18 = load ptr, ptr %count1_out.addr, align 4, !tbaa !300
  %19 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %o1, align 1, !tbaa !397
  store %struct.ipd.custom_type.addr_t.addr_t %19, ptr %18, align 4, !tbaa !397
  %o2 = getelementptr inbounds %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t, ptr %chessLout, i32 0, i32 2
  %20 = load ptr, ptr %count2_out.addr, align 4, !tbaa !300
  %21 = load %struct.ipd.custom_type.addr_t.addr_t, ptr %o2, align 1, !tbaa !397
  store %struct.ipd.custom_type.addr_t.addr_t %21, ptr %20, align 4, !tbaa !397
  %o0 = getelementptr inbounds %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t, ptr %chessLout, i32 0, i32 0
  %22 = load ptr, ptr %o0, align 1, !tbaa !472
  call addrspace(1) void @llvm.lifetime.end.p0(i64 12, ptr %chessLout) #11
  ret ptr %22
}

; Function Attrs: nounwind positionalaliasingreturns willreturn memory(none)
declare dso_local x86_regcallcc %struct.chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t @__regcall3__chessintr___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t(ptr, i32 signext, i32 signext, i32 signext, %struct.ipd.custom_type.addr_t.addr_t, %struct.ipd.custom_type.addr_t.addr_t, %struct.ipd.custom_type.addr_t.addr_t, %struct.ipd.custom_type.addr_t.addr_t, %struct.ipd.custom_type.addr_t.addr_t, %struct.ipd.custom_type.addr_t.addr_t) addrspace(1) #10

; Function Attrs: inlinehint mustprogress nounwind
define internal void @_ZL11window_incrP13output_windowIfEi(ptr %w, i32 noundef %count) addrspace(1) #4 !dbg !474 !noalias !480 {
entry:
  %w.addr = alloca ptr, align 4
  %count.addr = alloca i32, align 4
  store ptr %w, ptr %w.addr, align 4, !tbaa !300, !noalias !480
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %w.addr, metadata !478, metadata !DIExpression()), !dbg !483
  store i32 %count, ptr %count.addr, align 4, !tbaa !311, !noalias !480
  call addrspace(1) void @llvm.dbg.declare(metadata ptr %count.addr, metadata !479, metadata !DIExpression()), !dbg !483
  %0 = load i32, ptr %count.addr, align 4, !dbg !483, !tbaa !311, !noalias !480
  %mul = mul i32 %0, 4, !dbg !483
  store i32 %mul, ptr %count.addr, align 4, !dbg !483, !tbaa !311, !noalias !480
  %1 = load ptr, ptr %w.addr, align 4, !dbg !483, !tbaa !300, !noalias !480
  %ptr = getelementptr inbounds %struct.output_window, ptr %1, i32 0, i32 2, !dbg !483
  %2 = load ptr, ptr %ptr, align 4, !dbg !483, !tbaa !351, !noalias !480
  %3 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %2, ptr null, ptr %ptr, i32 0, metadata !480), !dbg !483, !tbaa !351, !noalias !480
  %4 = load i32, ptr %count.addr, align 4, !dbg !483, !tbaa !311, !noalias !480
  %5 = load ptr, ptr %w.addr, align 4, !dbg !483, !tbaa !300, !noalias !480
  %buffer = getelementptr inbounds %struct.output_window, ptr %5, i32 0, i32 5, !dbg !483
  %6 = load ptr, ptr %buffer, align 4, !dbg !483, !tbaa !484, !noalias !480
  %7 = call addrspace(1) ptr @llvm.noalias.p0.p0.p0.i32(ptr %6, ptr null, ptr %buffer, i32 0, metadata !480), !dbg !483, !tbaa !484, !noalias !480
  %8 = load ptr, ptr %w.addr, align 4, !dbg !483, !tbaa !300, !noalias !480
  %size = getelementptr inbounds %struct.output_window, ptr %8, i32 0, i32 7, !dbg !483
  %9 = load i32, ptr %size, align 4, !dbg !483, !tbaa !485, !noalias !480
  %call = call addrspace(1) ptr @_Z10cyclic_addPaiS_j(ptr %3, i32 noundef %4, ptr %7, i32 noundef %9) #12, !dbg !483, !noalias !480
  %10 = load ptr, ptr %w.addr, align 4, !dbg !483, !tbaa !300, !noalias !480
  %ptr1 = getelementptr inbounds %struct.output_window, ptr %10, i32 0, i32 2, !dbg !483
  store ptr %call, ptr %ptr1, align 4, !dbg !483, !tbaa !351, !noalias !480
  ret void, !dbg !483
}

attributes #0 = { mustprogress noinline nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { inlinehint mustprogress nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #5 = { nounwind speculatable willreturn memory(argmem: readwrite) }
attributes #6 = { alwaysinline nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #7 = { nounwind willreturn memory(none) "frame-pointer"="all" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #8 = { nounwind willreturn memory(none) }
attributes #9 = { alwaysinline mustprogress nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #10 = { nounwind positionalaliasingreturns willreturn memory(none) "frame-pointer"="all" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #11 = { nounwind }
attributes #12 = { "no-builtin-memcpy" }
attributes #13 = { nounwind positionalaliasingreturns willreturn memory(none) "no-builtin-memcpy" }

!llvm.dbg.cu = !{!0}
!llvm.linker.options = !{}
!llvm.chess.memory-units = !{!256, !257, !258, !259, !260, !261, !262, !263, !264, !265, !266, !267, !268, !269}
!llvm.module.flags = !{!270, !271, !272, !273}
!llvm.ident = !{!274}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 16.0.3 (/u/sgasip/ipd/repositories/llvm_ipd 6a0b186d7c0e25173296a8e19f630e71bd7e8ed9)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !24, imports: !97, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/window_split_128_to_64x2.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir")
!2 = !{!3, !19}
!3 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "aie_dm_resource", file: !4, line: 177, baseType: !5, size: 32, flags: DIFlagEnumClass, elements: !6, identifier: "_ZTS15aie_dm_resource")
!4 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/me_defines.h", directory: "")
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18}
!7 = !DIEnumerator(name: "none", value: 0)
!8 = !DIEnumerator(name: "a", value: 1)
!9 = !DIEnumerator(name: "b", value: 2)
!10 = !DIEnumerator(name: "c", value: 3)
!11 = !DIEnumerator(name: "d", value: 4)
!12 = !DIEnumerator(name: "stack", value: 5)
!13 = !DIEnumerator(name: "ab", value: 6)
!14 = !DIEnumerator(name: "ac", value: 7)
!15 = !DIEnumerator(name: "ad", value: 8)
!16 = !DIEnumerator(name: "bc", value: 9)
!17 = !DIEnumerator(name: "bd", value: 10)
!18 = !DIEnumerator(name: "cd", value: 11)
!19 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "chessllvmInternal", file: !20, line: 23, baseType: !21, size: 32, elements: !22, identifier: "_ZTS17chessllvmInternal")
!20 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/isg/me_chess_llvm.h", directory: "")
!21 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!22 = !{!23}
!23 = !DIEnumerator(name: "chessllvm_reinterpret", value: 0, isUnsigned: true)
!24 = !{!25, !71, !72, !73, !74, !96}
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 32)
!26 = !DIDerivedType(tag: DW_TAG_typedef, name: "T", scope: !28, file: !27, line: 903, baseType: !65)
!27 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/window/window.h", directory: "")
!28 = distinct !DISubprogram(name: "window_readincr<(aie_dm_resource)0>", linkageName: "_ZL15window_readincrIL15aie_dm_resource0EEvP12input_windowIfERf", scope: !27, file: !27, line: 903, type: !29, scopeLine: 903, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, templateParams: !63, retainedNodes: !60)
!29 = !DISubroutineType(types: !30)
!30 = !{null, !31, !59}
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 32)
!32 = !DIDerivedType(tag: DW_TAG_typedef, name: "input_window_float", file: !27, line: 83, baseType: !33)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "input_window<float>", file: !27, line: 38, size: 416, flags: DIFlagTypePassByValue, elements: !34, templateParams: !56, identifier: "_ZTS12input_windowIfE")
!34 = !{!35, !36, !37, !45, !46, !50, !51, !52, !53, !54}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "current_bufid", scope: !33, file: !27, line: 40, baseType: !21, size: 32)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "instanceId", scope: !33, file: !27, line: 41, baseType: !21, size: 32, offset: 32)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !33, file: !27, line: 42, baseType: !38, size: 32, offset: 64)
!38 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !39)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 32)
!40 = !DIDerivedType(tag: DW_TAG_typedef, name: "window_datatype", file: !41, line: 8, baseType: !42)
!41 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/include/adf/window/window_internal.h", directory: "")
!42 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !43, line: 24, baseType: !44)
!43 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/stdint.h", directory: "")
!44 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "head", scope: !33, file: !27, line: 43, baseType: !38, size: 32, offset: 96)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "heads", scope: !33, file: !27, line: 44, baseType: !47, size: 64, offset: 128)
!47 = !DICompositeType(tag: DW_TAG_array_type, baseType: !38, size: 64, elements: !48)
!48 = !{!49}
!49 = !DISubrange(count: 2)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "buffer", scope: !33, file: !27, line: 45, baseType: !38, size: 32, offset: 192)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "buffers", scope: !33, file: !27, line: 46, baseType: !47, size: 64, offset: 224)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !33, file: !27, line: 47, baseType: !21, size: 32, offset: 288)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "winsize", scope: !33, file: !27, line: 48, baseType: !21, size: 32, offset: 320)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "lockids", scope: !33, file: !27, line: 52, baseType: !55, size: 64, offset: 352)
!55 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 64, elements: !48)
!56 = !{!57}
!57 = !DITemplateTypeParameter(name: "T", type: !58)
!58 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!59 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !58, size: 32)
!60 = !{!61, !62}
!61 = !DILocalVariable(name: "w", arg: 1, scope: !28, file: !27, line: 903, type: !31)
!62 = !DILocalVariable(name: "value", arg: 2, scope: !28, file: !27, line: 903, type: !59)
!63 = !{!64}
!64 = !DITemplateValueParameter(name: "Resource", type: !3, value: i32 0)
!65 = !DIDerivedType(tag: DW_TAG_typedef, name: "aie_dm_resource_set_t<float, (aie_dm_resource)0>", file: !66, line: 235, baseType: !67)
!66 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/aie_core.h", directory: "")
!67 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !68, file: !66, line: 219, baseType: !58)
!68 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "aie_dm_resource_set<float, (aie_dm_resource)0>", file: !66, line: 217, size: 8, flags: DIFlagTypePassByValue, elements: !69, templateParams: !70, identifier: "_ZTS19aie_dm_resource_setIfL15aie_dm_resource0EE")
!69 = !{}
!70 = !{!57, !64}
!71 = !DIBasicType(name: "long", size: 32, encoding: DW_ATE_signed)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 32)
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 32)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 32)
!75 = !DIDerivedType(tag: DW_TAG_typedef, name: "T", scope: !76, file: !27, line: 903, baseType: !65)
!76 = distinct !DISubprogram(name: "window_writeincr<(aie_dm_resource)0>", linkageName: "_ZL16window_writeincrIL15aie_dm_resource0EEvP13output_windowIfEf", scope: !27, file: !27, line: 903, type: !77, scopeLine: 903, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, templateParams: !63, retainedNodes: !93)
!77 = !DISubroutineType(types: !78)
!78 = !{null, !79, !58}
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 32)
!80 = !DIDerivedType(tag: DW_TAG_typedef, name: "output_window_float", file: !27, line: 93, baseType: !81)
!81 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "output_window<float>", file: !27, line: 57, size: 416, flags: DIFlagTypePassByValue, elements: !82, templateParams: !56, identifier: "_ZTS13output_windowIfE")
!82 = !{!83, !84, !85, !86, !87, !88, !89, !90, !91, !92}
!83 = !DIDerivedType(tag: DW_TAG_member, name: "current_bufid", scope: !81, file: !27, line: 59, baseType: !21, size: 32)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "instanceId", scope: !81, file: !27, line: 60, baseType: !21, size: 32, offset: 32)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !81, file: !27, line: 61, baseType: !38, size: 32, offset: 64)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "head", scope: !81, file: !27, line: 62, baseType: !38, size: 32, offset: 96)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "heads", scope: !81, file: !27, line: 63, baseType: !47, size: 64, offset: 128)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "buffer", scope: !81, file: !27, line: 64, baseType: !38, size: 32, offset: 192)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "buffers", scope: !81, file: !27, line: 65, baseType: !47, size: 64, offset: 224)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !81, file: !27, line: 66, baseType: !21, size: 32, offset: 288)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "winsize", scope: !81, file: !27, line: 67, baseType: !21, size: 32, offset: 320)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "lockids", scope: !81, file: !27, line: 71, baseType: !55, size: 64, offset: 352)
!93 = !{!94, !95}
!94 = !DILocalVariable(name: "w", arg: 1, scope: !76, file: !27, line: 903, type: !79)
!95 = !DILocalVariable(name: "value", arg: 2, scope: !76, file: !27, line: 903, type: !58)
!96 = !DIBasicType(name: "addr_t", size: 32, encoding: DW_ATE_unsigned)
!97 = !{!98, !104, !106, !110, !112, !115, !117, !120, !123, !126, !128, !131, !133, !135, !137, !139, !141, !143, !145, !147, !149, !151, !153, !155, !157, !159, !161, !163, !165, !167, !169, !171, !173, !182, !186, !196, !200, !202, !204, !208, !212, !216, !218, !222, !227, !231, !235, !239, !241, !243, !245, !247, !249, !253}
!98 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !101, file: !103, line: 57)
!99 = !DINamespace(name: "__2", scope: !100, exportSymbols: true)
!100 = !DINamespace(name: "std", scope: null)
!101 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", file: !102, line: 35, baseType: !5)
!102 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/stddef.h", directory: "")
!103 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstddef", directory: "")
!104 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !105, file: !103, line: 58)
!105 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !102, line: 46, baseType: !21)
!106 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !107, file: !103, line: 63)
!107 = !DIDerivedType(tag: DW_TAG_typedef, name: "max_align_t", file: !108, line: 24, baseType: !109)
!108 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/tps/lnx64/target_aie_ml/bin/LNa64bin/../../chessdir/clangdir/16/include/__stddef_max_align_t.h", directory: "")
!109 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !108, line: 19, size: 128, flags: DIFlagFwdDecl, identifier: "_ZTS11max_align_t")
!110 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !42, file: !111, line: 161)
!111 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstdint", directory: "")
!112 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !113, file: !111, line: 163)
!113 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !43, line: 25, baseType: !114)
!114 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!115 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !116, file: !111, line: 164)
!116 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !43, line: 26, baseType: !5)
!117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !118, file: !111, line: 166)
!118 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !43, line: 27, baseType: !119)
!119 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!120 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !121, file: !111, line: 170)
!121 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !43, line: 29, baseType: !122)
!122 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!123 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !124, file: !111, line: 172)
!124 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !43, line: 30, baseType: !125)
!125 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!126 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !127, file: !111, line: 173)
!127 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !43, line: 31, baseType: !21)
!128 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !129, file: !111, line: 175)
!129 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !43, line: 32, baseType: !130)
!130 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!131 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !132, file: !111, line: 178)
!132 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !43, line: 35, baseType: !44)
!133 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !134, file: !111, line: 179)
!134 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !43, line: 36, baseType: !114)
!135 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !136, file: !111, line: 180)
!136 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !43, line: 37, baseType: !5)
!137 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !138, file: !111, line: 182)
!138 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !43, line: 38, baseType: !119)
!139 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !140, file: !111, line: 185)
!140 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !43, line: 40, baseType: !122)
!141 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !142, file: !111, line: 186)
!142 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !43, line: 41, baseType: !125)
!143 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !144, file: !111, line: 187)
!144 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !43, line: 42, baseType: !21)
!145 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !146, file: !111, line: 189)
!146 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !43, line: 43, baseType: !130)
!147 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !148, file: !111, line: 192)
!148 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !43, line: 46, baseType: !5)
!149 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !150, file: !111, line: 193)
!150 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !43, line: 47, baseType: !5)
!151 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !152, file: !111, line: 194)
!152 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !43, line: 48, baseType: !5)
!153 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !154, file: !111, line: 196)
!154 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !43, line: 49, baseType: !119)
!155 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !156, file: !111, line: 199)
!156 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !43, line: 51, baseType: !21)
!157 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !158, file: !111, line: 200)
!158 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !43, line: 52, baseType: !21)
!159 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !160, file: !111, line: 201)
!160 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !43, line: 53, baseType: !21)
!161 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !162, file: !111, line: 203)
!162 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !43, line: 54, baseType: !130)
!163 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !164, file: !111, line: 206)
!164 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !43, line: 57, baseType: !5)
!165 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !166, file: !111, line: 207)
!166 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !43, line: 58, baseType: !21)
!167 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !168, file: !111, line: 209)
!168 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !43, line: 61, baseType: !5)
!169 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !170, file: !111, line: 210)
!170 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !43, line: 62, baseType: !21)
!171 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !105, file: !172, line: 76)
!172 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/cstring", directory: "")
!173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !174, file: !172, line: 77)
!174 = !DISubprogram(name: "memcpy", scope: !175, file: !175, line: 28, type: !176, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!175 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime/include/string.h", directory: "")
!176 = !DISubroutineType(types: !177)
!177 = !{!73, !178, !179, !105}
!178 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !73)
!179 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !180)
!180 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !181, size: 32)
!181 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!182 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !183, file: !172, line: 78)
!183 = !DISubprogram(name: "memmove", scope: !175, file: !175, line: 29, type: !184, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!184 = !DISubroutineType(types: !185)
!185 = !{!73, !73, !180, !105}
!186 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !187, file: !172, line: 79)
!187 = !DISubprogram(name: "strcpy", scope: !175, file: !175, line: 30, type: !188, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!188 = !DISubroutineType(types: !189)
!189 = !{!190, !192, !193}
!190 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !191, size: 32)
!191 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!192 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !190)
!193 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !194)
!194 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !195, size: 32)
!195 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !191)
!196 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !197, file: !172, line: 80)
!197 = !DISubprogram(name: "strncpy", scope: !175, file: !175, line: 31, type: !198, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!198 = !DISubroutineType(types: !199)
!199 = !{!190, !192, !193, !105}
!200 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !201, file: !172, line: 81)
!201 = !DISubprogram(name: "strcat", scope: !175, file: !175, line: 34, type: !188, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!202 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !203, file: !172, line: 82)
!203 = !DISubprogram(name: "strncat", scope: !175, file: !175, line: 35, type: !198, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!204 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !205, file: !172, line: 83)
!205 = !DISubprogram(name: "memcmp", scope: !175, file: !175, line: 38, type: !206, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!206 = !DISubroutineType(types: !207)
!207 = !{!5, !180, !180, !105}
!208 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !209, file: !172, line: 84)
!209 = !DISubprogram(name: "strcmp", scope: !175, file: !175, line: 39, type: !210, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!210 = !DISubroutineType(types: !211)
!211 = !{!5, !194, !194}
!212 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !213, file: !172, line: 85)
!213 = !DISubprogram(name: "strncmp", scope: !175, file: !175, line: 41, type: !214, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!214 = !DISubroutineType(types: !215)
!215 = !{!5, !194, !194, !105}
!216 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !217, file: !172, line: 86)
!217 = !DISubprogram(name: "strcoll", scope: !175, file: !175, line: 40, type: !210, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!218 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !219, file: !172, line: 87)
!219 = !DISubprogram(name: "strxfrm", scope: !175, file: !175, line: 42, type: !220, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!220 = !DISubroutineType(types: !221)
!221 = !{!105, !192, !193, !105}
!222 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !223, file: !172, line: 88)
!223 = !DISubprogram(name: "memchr", linkageName: "_Z6memchrUa9enable_ifILb1EEPvij", scope: !224, file: !224, line: 107, type: !225, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!224 = !DIFile(filename: "/tools/Xilinx/Vitis/2024.2/aietools/data/aie_ml/lib/runtime_cxx/libs/libcxx-9.0.0/include-lite/../include/string.h", directory: "")
!225 = !DISubroutineType(types: !226)
!226 = !{!73, !73, !5, !105}
!227 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !228, file: !172, line: 89)
!228 = !DISubprogram(name: "strchr", linkageName: "_Z6strchrUa9enable_ifILb1EEPci", scope: !224, file: !224, line: 86, type: !229, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!229 = !DISubroutineType(types: !230)
!230 = !{!190, !190, !5}
!231 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !232, file: !172, line: 90)
!232 = !DISubprogram(name: "strcspn", scope: !175, file: !175, line: 47, type: !233, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!233 = !DISubroutineType(types: !234)
!234 = !{!105, !194, !194}
!235 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !236, file: !172, line: 91)
!236 = !DISubprogram(name: "strpbrk", linkageName: "_Z7strpbrkUa9enable_ifILb1EEPcPKc", scope: !224, file: !224, line: 93, type: !237, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!237 = !DISubroutineType(types: !238)
!238 = !{!190, !190, !194}
!239 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !240, file: !172, line: 92)
!240 = !DISubprogram(name: "strrchr", linkageName: "_Z7strrchrUa9enable_ifILb1EEPci", scope: !224, file: !224, line: 100, type: !229, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !242, file: !172, line: 93)
!242 = !DISubprogram(name: "strspn", scope: !175, file: !175, line: 50, type: !233, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!243 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !244, file: !172, line: 94)
!244 = !DISubprogram(name: "strstr", linkageName: "_Z6strstrUa9enable_ifILb1EEPcPKc", scope: !224, file: !224, line: 114, type: !237, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !246, file: !172, line: 96)
!246 = !DISubprogram(name: "strtok", scope: !175, file: !175, line: 52, type: !188, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!247 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !248, file: !172, line: 98)
!248 = !DISubprogram(name: "memset", scope: !175, file: !175, line: 55, type: !225, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !99, entity: !250, file: !172, line: 102)
!250 = !DISubprogram(name: "strlen", scope: !175, file: !175, line: 57, type: !251, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!251 = !DISubroutineType(types: !252)
!252 = !{!105, !194}
!253 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !0, entity: !254, file: !255, line: 3)
!254 = !DINamespace(name: "adf", scope: null)
!255 = !DIFile(filename: "../../../window_split_128_to_64x2.h", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/Work/aie/ir")
!256 = !{i32 0, i8 undef}
!257 = !{i32 2, i8 undef}
!258 = !{i32 3, i8 undef}
!259 = !{i32 4, i8 undef}
!260 = !{i32 5, i8 undef}
!261 = !{i32 6, i8 undef}
!262 = !{i32 7, i8 undef}
!263 = !{i32 8, i8 undef}
!264 = !{i32 9, i8 undef}
!265 = !{i32 10, i8 undef}
!266 = !{i32 11, i8 undef}
!267 = !{i32 12, i8 undef}
!268 = !{i32 13, i8 undef}
!269 = !{i32 14, i8 undef}
!270 = !{i32 7, !"Dwarf Version", i32 4}
!271 = !{i32 2, !"Debug Info Version", i32 3}
!272 = !{i32 1, !"wchar_size", i32 4}
!273 = !{i32 7, !"frame-pointer", i32 2}
!274 = !{!"clang version 16.0.3 (/u/sgasip/ipd/repositories/llvm_ipd 6a0b186d7c0e25173296a8e19f630e71bd7e8ed9)"}
!275 = distinct !DISubprogram(name: "window_split_128_to_64x2", linkageName: "_Z24window_split_128_to_64x2P12input_windowIfEP13output_windowIfES4_", scope: !276, file: !276, line: 3, type: !277, scopeLine: 5, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !283)
!276 = !DIFile(filename: "window_split_128_to_64x2.cpp", directory: "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7")
!277 = !DISubroutineType(types: !278)
!278 = !{null, !279, !281, !281}
!279 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !280)
!280 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 32)
!281 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !282)
!282 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 32)
!283 = !{!284, !285, !286, !287, !289, !290, !292}
!284 = !DILocalVariable(name: "in", arg: 1, scope: !275, file: !276, line: 3, type: !279)
!285 = !DILocalVariable(name: "out0", arg: 2, scope: !275, file: !276, line: 4, type: !281)
!286 = !DILocalVariable(name: "out1", arg: 3, scope: !275, file: !276, line: 5, type: !281)
!287 = !DILocalVariable(name: "N", scope: !275, file: !276, line: 6, type: !288)
!288 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5)
!289 = !DILocalVariable(name: "H", scope: !275, file: !276, line: 7, type: !288)
!290 = !DILocalVariable(name: "i", scope: !291, file: !276, line: 10, type: !5)
!291 = distinct !DILexicalBlock(scope: !275, file: !276, line: 10, column: 3)
!292 = !DILocalVariable(name: "i", scope: !293, file: !276, line: 14, type: !5)
!293 = distinct !DILexicalBlock(scope: !275, file: !276, line: 14, column: 3)
!294 = !{!295}
!295 = distinct !{!295, !296, !"_Z24window_split_128_to_64x2P12input_windowIfEP13output_windowIfES4_: in"}
!296 = distinct !{!296, !"_Z24window_split_128_to_64x2P12input_windowIfEP13output_windowIfES4_"}
!297 = !{!295, !298, !299}
!298 = distinct !{!298, !296, !"_Z24window_split_128_to_64x2P12input_windowIfEP13output_windowIfES4_: out0"}
!299 = distinct !{!299, !296, !"_Z24window_split_128_to_64x2P12input_windowIfEP13output_windowIfES4_: out1"}
!300 = !{!301, !301, i64 0, i64 4}
!301 = !{!302, i64 4, !"any pointer"}
!302 = !{!303, i64 1, !"omnipotent char"}
!303 = !{!"Simple C++ TBAA"}
!304 = !DILocation(line: 3, column: 63, scope: !275)
!305 = !{!298}
!306 = !DILocation(line: 4, column: 64, scope: !275)
!307 = !{!299}
!308 = !DILocation(line: 5, column: 64, scope: !275)
!309 = !DILocation(line: 6, column: 3, scope: !275)
!310 = !DILocation(line: 6, column: 17, scope: !275)
!311 = !{!312, !312, i64 0, i64 4}
!312 = !{!302, i64 4, !"int"}
!313 = !DILocation(line: 7, column: 3, scope: !275)
!314 = !DILocation(line: 7, column: 17, scope: !275)
!315 = !DILocation(line: 10, column: 8, scope: !291)
!316 = !DILocation(line: 10, column: 12, scope: !291)
!317 = !DILocation(line: 10, column: 19, scope: !318)
!318 = distinct !DILexicalBlock(scope: !291, file: !276, line: 10, column: 3)
!319 = !DILocation(line: 10, column: 21, scope: !318)
!320 = !DILocation(line: 10, column: 3, scope: !291)
!321 = !DILocation(line: 10, column: 3, scope: !318)
!322 = !DILocation(line: 11, column: 22, scope: !318)
!323 = !DILocation(line: 11, column: 44, scope: !318)
!324 = !DILocation(line: 11, column: 28, scope: !318)
!325 = !DILocation(line: 11, column: 5, scope: !318)
!326 = !DILocation(line: 10, column: 26, scope: !318)
!327 = distinct !{!327, !320, !328, !329}
!328 = !DILocation(line: 11, column: 47, scope: !291)
!329 = !{!"llvm.loop.mustprogress"}
!330 = !DILocation(line: 14, column: 8, scope: !293)
!331 = !DILocation(line: 14, column: 12, scope: !293)
!332 = !DILocation(line: 14, column: 19, scope: !333)
!333 = distinct !DILexicalBlock(scope: !293, file: !276, line: 14, column: 3)
!334 = !DILocation(line: 14, column: 21, scope: !333)
!335 = !DILocation(line: 14, column: 3, scope: !293)
!336 = !DILocation(line: 14, column: 3, scope: !333)
!337 = !DILocation(line: 15, column: 22, scope: !333)
!338 = !DILocation(line: 15, column: 44, scope: !333)
!339 = !DILocation(line: 15, column: 28, scope: !333)
!340 = !DILocation(line: 15, column: 5, scope: !333)
!341 = !DILocation(line: 14, column: 26, scope: !333)
!342 = distinct !{!342, !335, !343, !329}
!343 = !DILocation(line: 15, column: 47, scope: !293)
!344 = !DILocation(line: 16, column: 1, scope: !275)
!345 = !{!346}
!346 = distinct !{!346, !347, !"_ZL16window_writeincrIL15aie_dm_resource0EEvP13output_windowIfEf: unknown scope"}
!347 = distinct !{!347, !"_ZL16window_writeincrIL15aie_dm_resource0EEvP13output_windowIfEf"}
!348 = !DILocation(line: 903, column: 3, scope: !76)
!349 = !{!350, !350, i64 0, i64 4}
!350 = !{!302, i64 4, !"float"}
!351 = !{!352, !301, i64 8, i64 4}
!352 = !{!302, i64 52, !"_ZTS13output_windowIfE", !312, i64 0, i64 4, !312, i64 4, i64 4, !301, i64 8, i64 4, !301, i64 12, i64 4, !301, i64 16, i64 8, !301, i64 24, i64 4, !301, i64 28, i64 8, !312, i64 36, i64 4, !312, i64 40, i64 4, !312, i64 44, i64 8}
!353 = distinct !DISubprogram(name: "window_readincr<(aie_dm_resource)0>", linkageName: "_ZL15window_readincrIL15aie_dm_resource0EEfP12input_windowIfE", scope: !27, file: !27, line: 903, type: !354, scopeLine: 903, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, templateParams: !63, retainedNodes: !356)
!354 = !DISubroutineType(types: !355)
!355 = !{!58, !31}
!356 = !{!357, !358}
!357 = !DILocalVariable(name: "w", arg: 1, scope: !353, file: !27, line: 903, type: !31)
!358 = !DILocalVariable(name: "value", scope: !353, file: !27, line: 903, type: !58)
!359 = !DILocation(line: 903, column: 3, scope: !353)
!360 = !{!361}
!361 = distinct !{!361, !362, !"_ZL15window_readincrIL15aie_dm_resource0EEvP12input_windowIfERf: unknown scope"}
!362 = distinct !{!362, !"_ZL15window_readincrIL15aie_dm_resource0EEvP12input_windowIfERf"}
!363 = !DILocation(line: 903, column: 3, scope: !28)
!364 = !{!365, !301, i64 8, i64 4}
!365 = !{!302, i64 52, !"_ZTS12input_windowIfE", !312, i64 0, i64 4, !312, i64 4, i64 4, !301, i64 8, i64 4, !301, i64 12, i64 4, !301, i64 16, i64 8, !301, i64 24, i64 4, !301, i64 28, i64 8, !312, i64 36, i64 4, !312, i64 40, i64 4, !312, i64 44, i64 8}
!366 = distinct !DISubprogram(name: "window_incr", linkageName: "_ZL11window_incrP12input_windowIfEi", scope: !27, file: !27, line: 520, type: !367, scopeLine: 520, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !369)
!367 = !DISubroutineType(types: !368)
!368 = !{null, !31, !5}
!369 = !{!370, !371}
!370 = !DILocalVariable(name: "w", arg: 1, scope: !366, file: !27, line: 520, type: !31)
!371 = !DILocalVariable(name: "count", arg: 2, scope: !366, file: !27, line: 520, type: !5)
!372 = !{!373}
!373 = distinct !{!373, !374, !"_ZL11window_incrP12input_windowIfEi: unknown scope"}
!374 = distinct !{!374, !"_ZL11window_incrP12input_windowIfEi"}
!375 = !DILocation(line: 520, column: 3, scope: !366)
!376 = !{!365, !301, i64 24, i64 4}
!377 = !{!365, !312, i64 36, i64 4}
!378 = distinct !DISubprogram(name: "cyclic_add", linkageName: "_Z10cyclic_addPaiS_j", scope: !41, file: !41, line: 12, type: !379, scopeLine: 12, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !381)
!379 = !DISubroutineType(types: !380)
!380 = !{!39, !39, !5, !39, !21}
!381 = !{!382, !383, !384, !385, !386, !388}
!382 = !DILocalVariable(name: "ptr", arg: 1, scope: !378, file: !41, line: 12, type: !39)
!383 = !DILocalVariable(name: "count", arg: 2, scope: !378, file: !41, line: 12, type: !5)
!384 = !DILocalVariable(name: "base", arg: 3, scope: !378, file: !41, line: 12, type: !39)
!385 = !DILocalVariable(name: "size", arg: 4, scope: !378, file: !41, line: 12, type: !21)
!386 = !DILocalVariable(name: "c0", scope: !378, file: !41, line: 13, type: !387)
!387 = !DIDerivedType(tag: DW_TAG_typedef, name: "addr_t", file: !20, line: 474, baseType: !96)
!388 = !DILocalVariable(name: "c1", scope: !378, file: !41, line: 14, type: !387)
!389 = !DILocation(line: 12, column: 54, scope: !378)
!390 = !DILocation(line: 12, column: 63, scope: !378)
!391 = !DILocation(line: 12, column: 87, scope: !378)
!392 = !DILocation(line: 12, column: 106, scope: !378)
!393 = !DILocation(line: 13, column: 5, scope: !378)
!394 = !DILocation(line: 13, column: 12, scope: !378)
!395 = !DILocation(line: 13, column: 23, scope: !378)
!396 = !DILocation(line: 13, column: 17, scope: !378)
!397 = !{!398, !398, i64 0, i64 4}
!398 = !{!302, i64 4, !"addr_t"}
!399 = !DILocation(line: 14, column: 5, scope: !378)
!400 = !DILocation(line: 14, column: 12, scope: !378)
!401 = !DILocation(line: 14, column: 23, scope: !378)
!402 = !DILocation(line: 14, column: 17, scope: !378)
!403 = !DILocation(line: 15, column: 24, scope: !378)
!404 = !DILocation(line: 15, column: 29, scope: !378)
!405 = !DILocation(line: 15, column: 35, scope: !378)
!406 = !DILocation(line: 15, column: 34, scope: !378)
!407 = !DILocation(line: 15, column: 48, scope: !378)
!408 = !DILocation(line: 15, column: 53, scope: !378)
!409 = !DILocation(line: 15, column: 52, scope: !378)
!410 = !DILocation(line: 15, column: 41, scope: !378)
!411 = !DILocation(line: 15, column: 65, scope: !378)
!412 = !DILocation(line: 15, column: 71, scope: !378)
!413 = !DILocation(line: 15, column: 70, scope: !378)
!414 = !DILocation(line: 15, column: 84, scope: !378)
!415 = !DILocation(line: 15, column: 89, scope: !378)
!416 = !DILocation(line: 15, column: 88, scope: !378)
!417 = !DILocation(line: 15, column: 95, scope: !378)
!418 = !DILocation(line: 15, column: 94, scope: !378)
!419 = !DILocation(line: 15, column: 77, scope: !378)
!420 = !DILocation(line: 15, column: 106, scope: !378)
!421 = !DILocation(line: 15, column: 12, scope: !378)
!422 = !DILocation(line: 16, column: 1, scope: !378)
!423 = !DILocation(line: 15, column: 5, scope: !378)
!424 = distinct !DISubprogram(name: "add_3d_byte<signed char>", linkageName: "_Z11add_3d_byteIaEPT_S1_iiR6addr_tiiS3_i", scope: !66, file: !66, line: 123, type: !425, scopeLine: 123, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, templateParams: !440, retainedNodes: !428)
!425 = !DISubroutineType(types: !426)
!426 = !{!72, !72, !5, !5, !427, !5, !5, !427, !5}
!427 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !387, size: 32)
!428 = !{!429, !430, !431, !432, !433, !434, !435, !436, !437, !438, !439}
!429 = !DILocalVariable(name: "a", arg: 1, scope: !424, file: !66, line: 123, type: !72)
!430 = !DILocalVariable(name: "off", arg: 2, scope: !424, file: !66, line: 123, type: !5)
!431 = !DILocalVariable(name: "size1", arg: 3, scope: !424, file: !66, line: 123, type: !5)
!432 = !DILocalVariable(name: "count1", arg: 4, scope: !424, file: !66, line: 123, type: !427)
!433 = !DILocalVariable(name: "inc1", arg: 5, scope: !424, file: !66, line: 123, type: !5)
!434 = !DILocalVariable(name: "size2", arg: 6, scope: !424, file: !66, line: 123, type: !5)
!435 = !DILocalVariable(name: "count2", arg: 7, scope: !424, file: !66, line: 123, type: !427)
!436 = !DILocalVariable(name: "inc2", arg: 8, scope: !424, file: !66, line: 123, type: !5)
!437 = !DILocalVariable(name: "c", scope: !424, file: !66, line: 124, type: !387)
!438 = !DILocalVariable(name: "c2", scope: !424, file: !66, line: 125, type: !387)
!439 = !DILocalVariable(name: "r", scope: !424, file: !66, line: 126, type: !72)
!440 = !{!441}
!441 = !DITemplateTypeParameter(name: "T", type: !44)
!442 = !DILocation(line: 123, column: 26, scope: !424)
!443 = !DILocation(line: 123, column: 33, scope: !424)
!444 = !DILocation(line: 123, column: 42, scope: !424)
!445 = !DILocation(line: 123, column: 57, scope: !424)
!446 = !DILocation(line: 123, column: 69, scope: !424)
!447 = !DILocation(line: 123, column: 79, scope: !424)
!448 = !DILocation(line: 123, column: 94, scope: !424)
!449 = !DILocation(line: 123, column: 106, scope: !424)
!450 = !DILocation(line: 124, column: 5, scope: !424)
!451 = !DILocation(line: 124, column: 12, scope: !424)
!452 = !DILocation(line: 125, column: 5, scope: !424)
!453 = !DILocation(line: 125, column: 12, scope: !424)
!454 = !DILocation(line: 126, column: 5, scope: !424)
!455 = !DILocation(line: 126, column: 8, scope: !424)
!456 = !DILocation(line: 126, column: 32, scope: !424)
!457 = !DILocation(line: 126, column: 35, scope: !424)
!458 = !DILocation(line: 126, column: 40, scope: !424)
!459 = !DILocation(line: 126, column: 46, scope: !424)
!460 = !DILocation(line: 126, column: 52, scope: !424)
!461 = !DILocation(line: 126, column: 59, scope: !424)
!462 = !DILocation(line: 126, column: 70, scope: !424)
!463 = !DILocation(line: 126, column: 77, scope: !424)
!464 = !DILocation(line: 126, column: 16, scope: !424)
!465 = !DILocation(line: 127, column: 5, scope: !424)
!466 = !DILocation(line: 127, column: 12, scope: !424)
!467 = !DILocation(line: 128, column: 5, scope: !424)
!468 = !DILocation(line: 128, column: 12, scope: !424)
!469 = !DILocation(line: 129, column: 12, scope: !424)
!470 = !DILocation(line: 130, column: 1, scope: !424)
!471 = !DILocation(line: 129, column: 5, scope: !424)
!472 = !{!473, !301, i64 0, i64 4}
!473 = !{!302, i64 12, !"_ZTS103chessout___Pvoid_add_3d_byte_int___Pvoid___sint___sint___sint_addr_t_addr_t_addr_t_addr_t_addr_t_addr_t", !301, i64 0, i64 4, !398, i64 4, i64 4, !398, i64 8, i64 4}
!474 = distinct !DISubprogram(name: "window_incr", linkageName: "_ZL11window_incrP13output_windowIfEi", scope: !27, file: !27, line: 530, type: !475, scopeLine: 530, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !477)
!475 = !DISubroutineType(types: !476)
!476 = !{null, !79, !5}
!477 = !{!478, !479}
!478 = !DILocalVariable(name: "w", arg: 1, scope: !474, file: !27, line: 530, type: !79)
!479 = !DILocalVariable(name: "count", arg: 2, scope: !474, file: !27, line: 530, type: !5)
!480 = !{!481}
!481 = distinct !{!481, !482, !"_ZL11window_incrP13output_windowIfEi: unknown scope"}
!482 = distinct !{!482, !"_ZL11window_incrP13output_windowIfEi"}
!483 = !DILocation(line: 530, column: 3, scope: !474)
!484 = !{!352, !301, i64 24, i64 4}
!485 = !{!352, !312, i64 36, i64 4}
