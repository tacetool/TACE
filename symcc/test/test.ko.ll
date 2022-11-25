; ModuleID = '/symcc/test/test.c'
source_filename = "/symcc/test/test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@.str = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"%d %d\0A\00", align 1
@str = private unnamed_addr constant [17 x i8] c"Failed to read x\00"
@__dfsan_arg_tls = external thread_local(initialexec) global [64 x i32]
@__dfsan_retval_tls = external thread_local(initialexec) global i32
@__dfsan_shadow_ptr_mask = external global i64
@__taint_trace_callstack = external thread_local(initialexec) global i32

; Function Attrs: nounwind readnone uwtable
define i32 @"dfs$foo"(i32, i32) local_unnamed_addr #0 !dbg !8 {
  %3 = load i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @__dfsan_arg_tls, i64 0, i64 1), !dbg !15
  %4 = load i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @__dfsan_arg_tls, i64 0, i64 0), !dbg !15
  %5 = load i32, i32* @__taint_trace_callstack, !dbg !15, !nosanitize !2
  %6 = xor i32 %5, 16194490, !dbg !15
  store i32 %6, i32* @__taint_trace_callstack, !dbg !15, !nosanitize !2
  call void @llvm.dbg.value(metadata i32 %0, metadata !13, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.value(metadata i32 %1, metadata !14, metadata !DIExpression()), !dbg !16
  %7 = zext i32 %0 to i64, !dbg !17
  %8 = call zeroext i32 @__taint_union(i32 zeroext %4, i32 zeroext 0, i16 23, i8 32, i64 %7, i64 1), !dbg !17
  %9 = shl nsw i32 %0, 1, !dbg !17
  %10 = zext i32 %9 to i64, !dbg !19
  %11 = zext i32 %1 to i64, !dbg !19
  %12 = call zeroext i32 @__taint_union(i32 zeroext %8, i32 zeroext %3, i16 10291, i8 32, i64 %10, i64 %11), !dbg !19
  %13 = icmp slt i32 %9, %1, !dbg !19
  call void @__taint_trace_cond(i32 %12, i1 %13), !dbg !20
  br i1 %13, label %28, label %14, !dbg !20

; <label>:14:                                     ; preds = %2
  %15 = zext i32 %0 to i64, !dbg !21
  %16 = zext i32 %1 to i64, !dbg !21
  %17 = call zeroext i32 @__taint_union(i32 zeroext %4, i32 zeroext %3, i16 21, i8 32, i64 %15, i64 %16), !dbg !21
  %18 = srem i32 %0, %1, !dbg !21
  %19 = zext i32 %18 to i64, !dbg !21
  %20 = call zeroext i32 @__taint_union(i32 zeroext %17, i32 zeroext 0, i16 8243, i8 32, i64 %19, i64 0), !dbg !21
  %21 = icmp eq i32 %18, 0, !dbg !21
  %22 = select i1 %21, i32 %4, i32 0
  call void @__taint_trace_cond(i32 %20, i1 %21), !dbg !23
  %23 = select i1 %21, i32 %0, i32 0, !dbg !23
  %24 = zext i32 %23 to i64, !dbg !23
  %25 = zext i32 %1 to i64, !dbg !23
  %26 = call zeroext i32 @__taint_union(i32 zeroext %22, i32 zeroext %3, i16 11, i8 32, i64 %24, i64 %25), !dbg !23
  %27 = add nsw i32 %23, %1, !dbg !23
  store i32 %5, i32* @__taint_trace_callstack, !dbg !23, !nosanitize !2
  store i32 %26, i32* @__dfsan_retval_tls, !dbg !23
  ret i32 %27, !dbg !23

; <label>:28:                                     ; preds = %2
  store i32 %5, i32* @__taint_trace_callstack, !dbg !24, !nosanitize !2
  store i32 %4, i32* @__dfsan_retval_tls, !dbg !24
  ret i32 %0, !dbg !24
}

; Function Attrs: nounwind uwtable
define i32 @main(i32, i8** nocapture readonly) local_unnamed_addr #1 !dbg !25 {
  %3 = alloca i32
  %4 = load i32, i32* @__taint_trace_callstack, !nosanitize !2
  %5 = xor i32 %4, 173383548
  store i32 %5, i32* @__taint_trace_callstack, !nosanitize !2
  %6 = alloca i32, align 4
  call void @llvm.dbg.value(metadata i32 %0, metadata !32, metadata !DIExpression()), !dbg !97
  call void @llvm.dbg.value(metadata i8** %1, metadata !33, metadata !DIExpression()), !dbg !98
  %7 = bitcast i32* %6 to i8*, !dbg !99
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %7) #5, !dbg !99
  %8 = getelementptr inbounds i8*, i8** %1, i64 1, !dbg !100
  %9 = ptrtoint i8** %8 to i64, !dbg !100
  %10 = and i64 %9, -123145302310913, !dbg !100
  %11 = mul i64 %10, 4, !dbg !100
  %12 = inttoptr i64 %11 to i32*, !dbg !100
  %13 = call zeroext i32 @__taint_union_load(i32* %12, i64 8), !dbg !100
  %14 = load i8*, i8** %8, align 8, !dbg !100, !tbaa !101
  %15 = call %struct._IO_FILE* @__dfsw_fopen(i8* %14, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i32 zeroext %13, i32 zeroext 0, i32* %3), !dbg !105
  %16 = load i32, i32* %3, !dbg !105
  call void @llvm.dbg.value(metadata %struct._IO_FILE* %15, metadata !35, metadata !DIExpression()), !dbg !106
  %17 = call i64 @__dfsw_fread_unlocked(i8* nonnull %7, i64 4, i64 1, %struct._IO_FILE* %15, i32 zeroext 0, i32 zeroext 0, i32 zeroext 0, i32 zeroext %16, i32* %3), !dbg !107
  %18 = load i32, i32* %3, !dbg !107
  %19 = call zeroext i32 @__taint_union(i32 zeroext %18, i32 zeroext 0, i16 8243, i8 64, i64 %17, i64 1), !dbg !109
  %20 = icmp eq i64 %17, 1, !dbg !109
  call void @__taint_trace_cond(i32 %19, i1 %20), !dbg !110
  br i1 %20, label %23, label %21, !dbg !110

; <label>:21:                                     ; preds = %2
  %22 = tail call i32 @puts(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @str, i64 0, i64 0)), !dbg !111
  br label %51, !dbg !113

; <label>:23:                                     ; preds = %2
  %24 = ptrtoint i32* %6 to i64, !dbg !114
  %25 = and i64 %24, -123145302310913, !dbg !114
  %26 = mul i64 %25, 4, !dbg !114
  %27 = inttoptr i64 %26 to i32*, !dbg !114
  %28 = call zeroext i32 @__taint_union_load(i32* %27, i64 4), !dbg !114
  %29 = load i32, i32* %6, align 4, !dbg !114, !tbaa !115
  call void @llvm.dbg.value(metadata i32 %29, metadata !34, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata i32 %29, metadata !13, metadata !DIExpression()), !dbg !118
  call void @llvm.dbg.value(metadata i32 7, metadata !14, metadata !DIExpression()), !dbg !120
  %30 = zext i32 %29 to i64, !dbg !121
  %31 = call zeroext i32 @__taint_union(i32 zeroext %28, i32 zeroext 0, i16 10291, i8 32, i64 %30, i64 4), !dbg !121
  %32 = icmp slt i32 %29, 4, !dbg !121
  call void @__taint_trace_cond(i32 %31, i1 %32), !dbg !122
  br i1 %32, label %45, label %33, !dbg !122

; <label>:33:                                     ; preds = %23
  %34 = zext i32 %29 to i64
  %35 = call zeroext i32 @__taint_union(i32 zeroext %28, i32 zeroext 0, i16 20, i8 32, i64 %34, i64 7)
  %36 = urem i32 %29, 7
  %37 = zext i32 %36 to i64, !dbg !123
  %38 = call zeroext i32 @__taint_union(i32 zeroext %35, i32 zeroext 0, i16 8243, i8 32, i64 %37, i64 0), !dbg !123
  %39 = icmp eq i32 %36, 0, !dbg !123
  %40 = zext i32 %29 to i64, !dbg !124
  %41 = call zeroext i32 @__taint_union(i32 zeroext %28, i32 zeroext 0, i16 11, i8 32, i64 %40, i64 7), !dbg !124
  %42 = add i32 %29, 7, !dbg !124
  %43 = select i1 %39, i32 %41, i32 0
  call void @__taint_trace_cond(i32 %38, i1 %39), !dbg !124
  %44 = select i1 %39, i32 %42, i32 7, !dbg !124
  br label %45, !dbg !124

; <label>:45:                                     ; preds = %23, %33
  %46 = phi i32 [ %43, %33 ], [ %28, %23 ]
  %47 = phi i32 [ %44, %33 ], [ %29, %23 ]
  %48 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0), i32 %29, i32 %47), !dbg !125
  %49 = call i32 @__dfsw_fclose(%struct._IO_FILE* %15, i32 zeroext %16, i32* %3), !dbg !126
  %50 = load i32, i32* %3, !dbg !126
  br label %51, !dbg !127

; <label>:51:                                     ; preds = %45, %21
  %52 = phi i32 [ 0, %21 ], [ 0, %45 ]
  %53 = phi i32 [ -1, %21 ], [ 0, %45 ], !dbg !128
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %7) #5, !dbg !129
  store i32 %4, i32* @__taint_trace_callstack, !dbg !129, !nosanitize !2
  ret i32 %53, !dbg !129
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #3

; Function Attrs: nounwind
declare i32 @fclose(%struct._IO_FILE* nocapture) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

; Function Attrs: nounwind
declare i64 @fread_unlocked(i8* nocapture, i64, i64, %struct._IO_FILE* nocapture) local_unnamed_addr #5

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #5

; Function Attrs: nounwind readnone
declare zeroext i32 @__taint_union(i32 zeroext, i32 zeroext, i16, i16, i64, i64) #6

; Function Attrs: nounwind readnone
declare zeroext i32 @taint_union(i32 zeroext, i32 zeroext, i16, i16, i64, i64) #6

; Function Attrs: nounwind readonly
declare zeroext i32 @__taint_union_load(i32*, i64) #7

; Function Attrs: nounwind
declare void @__taint_union_store(i32 zeroext, i32*, i64) #5

declare void @__dfsan_unimplemented(i8*)

declare void @__dfsan_set_label(i32 zeroext, i8*, i64)

declare void @__dfsan_nonzero_label()

declare void @__dfsan_vararg_wrapper(i8*)

declare void @__taint_trace_cmp(i32, i32, i32, i32, i64, i64)

declare void @__taint_trace_cond(i32, i8)

declare void @__taint_trace_indcall(i32)

declare void @__taint_trace_gep(i32, i64)

declare void @__taint_debug(i32, i32, i32, i32, i32)

; Function Attrs: nounwind uwtable
define linkonce_odr i32 @"dfsw$main"(i32, i8** nocapture readonly) local_unnamed_addr #1 {
  %3 = load i32, i32* @__taint_trace_callstack, !nosanitize !2
  %4 = xor i32 %3, 2067514731
  store i32 %4, i32* @__taint_trace_callstack, !nosanitize !2
  %5 = call i32 @main(i32 %0, i8** %1)
  store i32 %3, i32* @__taint_trace_callstack, !nosanitize !2
  store i32 0, i32* @__dfsan_retval_tls
  ret i32 %5
}

; Function Attrs: nounwind
define linkonce_odr noalias %struct._IO_FILE* @"dfsw$fopen"(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #3 {
  %3 = alloca i32
  %4 = load i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @__dfsan_arg_tls, i64 0, i64 1)
  %5 = load i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @__dfsan_arg_tls, i64 0, i64 0)
  %6 = load i32, i32* @__taint_trace_callstack, !nosanitize !2
  %7 = xor i32 %6, 1229548980
  store i32 %7, i32* @__taint_trace_callstack, !nosanitize !2
  %8 = call %struct._IO_FILE* @__dfsw_fopen(i8* %0, i8* %1, i32 zeroext %5, i32 zeroext %4, i32* %3)
  %9 = load i32, i32* %3
  store i32 %6, i32* @__taint_trace_callstack, !nosanitize !2
  store i32 %9, i32* @__dfsan_retval_tls
  ret %struct._IO_FILE* %8
}

; Function Attrs: nounwind
define linkonce_odr i32 @"dfsw$printf"(i8* nocapture readonly, ...) local_unnamed_addr #3 {
  %2 = load i32, i32* @__taint_trace_callstack, !nosanitize !2
  %3 = xor i32 %2, 725258499
  store i32 %3, i32* @__taint_trace_callstack, !nosanitize !2
  %4 = call i32 (i8*, ...) @printf(i8* %0)
  store i32 %2, i32* @__taint_trace_callstack, !nosanitize !2
  store i32 0, i32* @__dfsan_retval_tls
  ret i32 %4
}

; Function Attrs: nounwind
define linkonce_odr i32 @"dfsw$fclose"(%struct._IO_FILE* nocapture) local_unnamed_addr #3 {
  %2 = alloca i32
  %3 = load i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @__dfsan_arg_tls, i64 0, i64 0)
  %4 = load i32, i32* @__taint_trace_callstack, !nosanitize !2
  %5 = xor i32 %4, 1972165933
  store i32 %5, i32* @__taint_trace_callstack, !nosanitize !2
  %6 = call i32 @__dfsw_fclose(%struct._IO_FILE* %0, i32 zeroext %3, i32* %2)
  %7 = load i32, i32* %2
  store i32 %4, i32* @__taint_trace_callstack, !nosanitize !2
  store i32 %7, i32* @__dfsan_retval_tls
  ret i32 %6
}

; Function Attrs: nounwind
define linkonce_odr i64 @"dfsw$fread_unlocked"(i8* nocapture, i64, i64, %struct._IO_FILE* nocapture) local_unnamed_addr #5 {
  %5 = alloca i32
  %6 = load i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @__dfsan_arg_tls, i64 0, i64 3)
  %7 = load i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @__dfsan_arg_tls, i64 0, i64 2)
  %8 = load i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @__dfsan_arg_tls, i64 0, i64 1)
  %9 = load i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @__dfsan_arg_tls, i64 0, i64 0)
  %10 = load i32, i32* @__taint_trace_callstack, !nosanitize !2
  %11 = xor i32 %10, 455030220
  store i32 %11, i32* @__taint_trace_callstack, !nosanitize !2
  %12 = call i64 @__dfsw_fread_unlocked(i8* %0, i64 %1, i64 %2, %struct._IO_FILE* %3, i32 zeroext %9, i32 zeroext %8, i32 zeroext %7, i32 zeroext %6, i32* %5)
  %13 = load i32, i32* %5
  store i32 %10, i32* @__taint_trace_callstack, !nosanitize !2
  store i32 %13, i32* @__dfsan_retval_tls
  ret i64 %12
}

; Function Attrs: nounwind
define linkonce_odr i32 @"dfsw$puts"(i8* nocapture readonly) local_unnamed_addr #5 {
  %2 = load i32, i32* @__taint_trace_callstack, !nosanitize !2
  %3 = xor i32 %2, 1358040735
  store i32 %3, i32* @__taint_trace_callstack, !nosanitize !2
  %4 = call i32 @puts(i8* %0)
  store i32 %2, i32* @__taint_trace_callstack, !nosanitize !2
  store i32 0, i32* @__dfsan_retval_tls
  ret i32 %4
}

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @__dfsw_fopen(i8* nocapture readonly, i8* nocapture readonly, i32, i32, i32*) local_unnamed_addr #3

; Function Attrs: nounwind
declare i32 @__dfsw_fclose(%struct._IO_FILE* nocapture, i32, i32*) local_unnamed_addr #3

; Function Attrs: nounwind
declare i64 @__dfsw_fread_unlocked(i8* nocapture, i64, i64, %struct._IO_FILE* nocapture, i32, i32, i32, i32, i32*) local_unnamed_addr #5

attributes #0 = { nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone speculatable }
attributes #5 = { nounwind }
attributes #6 = { nounwind readnone }
attributes #7 = { nounwind readonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.0 (tags/RELEASE_700/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "/symcc/test/test.c", directory: "/Kirenenko/bin")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 1}
!7 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!8 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 6, type: !9, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !12)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !{!13, !14}
!13 = !DILocalVariable(name: "a", arg: 1, scope: !8, file: !1, line: 6, type: !11)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !8, file: !1, line: 6, type: !11)
!15 = !DILocation(line: 6, column: 13, scope: !8)
!16 = !DILocation(line: 6, column: 20, scope: !8)
!17 = !DILocation(line: 7, column: 8, scope: !18)
!18 = distinct !DILexicalBlock(scope: !8, file: !1, line: 7, column: 6)
!19 = !DILocation(line: 7, column: 12, scope: !18)
!20 = !DILocation(line: 7, column: 6, scope: !8)
!21 = !DILocation(line: 9, column: 16, scope: !22)
!22 = distinct !DILexicalBlock(scope: !18, file: !1, line: 9, column: 14)
!23 = !DILocation(line: 9, column: 14, scope: !18)
!24 = !DILocation(line: 14, column: 1, scope: !8)
!25 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !26, isLocal: false, isDefinition: true, scopeLine: 16, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !31)
!26 = !DISubroutineType(types: !27)
!27 = !{!11, !11, !28}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!31 = !{!32, !33, !34, !35, !96}
!32 = !DILocalVariable(name: "argc", arg: 1, scope: !25, file: !1, line: 16, type: !11)
!33 = !DILocalVariable(name: "argv", arg: 2, scope: !25, file: !1, line: 16, type: !28)
!34 = !DILocalVariable(name: "x", scope: !25, file: !1, line: 17, type: !11)
!35 = !DILocalVariable(name: "fd", scope: !25, file: !1, line: 18, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !38, line: 7, baseType: !39)
!38 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "/Kirenenko/bin")
!39 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !40, line: 49, size: 1728, elements: !41)
!40 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h", directory: "/Kirenenko/bin")
!41 = !{!42, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !57, !59, !60, !61, !65, !67, !69, !73, !76, !78, !81, !84, !85, !87, !91, !92}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !39, file: !40, line: 51, baseType: !11, size: 32)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !39, file: !40, line: 54, baseType: !29, size: 64, offset: 64)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !39, file: !40, line: 55, baseType: !29, size: 64, offset: 128)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !39, file: !40, line: 56, baseType: !29, size: 64, offset: 192)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !39, file: !40, line: 57, baseType: !29, size: 64, offset: 256)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !39, file: !40, line: 58, baseType: !29, size: 64, offset: 320)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !39, file: !40, line: 59, baseType: !29, size: 64, offset: 384)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !39, file: !40, line: 60, baseType: !29, size: 64, offset: 448)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !39, file: !40, line: 61, baseType: !29, size: 64, offset: 512)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !39, file: !40, line: 64, baseType: !29, size: 64, offset: 576)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !39, file: !40, line: 65, baseType: !29, size: 64, offset: 640)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !39, file: !40, line: 66, baseType: !29, size: 64, offset: 704)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !39, file: !40, line: 68, baseType: !55, size: 64, offset: 768)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !56, size: 64)
!56 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !40, line: 36, flags: DIFlagFwdDecl)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !39, file: !40, line: 70, baseType: !58, size: 64, offset: 832)
!58 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !39, file: !40, line: 72, baseType: !11, size: 32, offset: 896)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !39, file: !40, line: 73, baseType: !11, size: 32, offset: 928)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !39, file: !40, line: 74, baseType: !62, size: 64, offset: 960)
!62 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !63, line: 152, baseType: !64)
!63 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "/Kirenenko/bin")
!64 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !39, file: !40, line: 77, baseType: !66, size: 16, offset: 1024)
!66 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !39, file: !40, line: 78, baseType: !68, size: 8, offset: 1040)
!68 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !39, file: !40, line: 79, baseType: !70, size: 8, offset: 1048)
!70 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 8, elements: !71)
!71 = !{!72}
!72 = !DISubrange(count: 1)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !39, file: !40, line: 81, baseType: !74, size: 64, offset: 1088)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !40, line: 43, baseType: null)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !39, file: !40, line: 89, baseType: !77, size: 64, offset: 1152)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !63, line: 153, baseType: !64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !39, file: !40, line: 91, baseType: !79, size: 64, offset: 1216)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !40, line: 37, flags: DIFlagFwdDecl)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !39, file: !40, line: 92, baseType: !82, size: 64, offset: 1280)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !40, line: 38, flags: DIFlagFwdDecl)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !39, file: !40, line: 93, baseType: !58, size: 64, offset: 1344)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !39, file: !40, line: 94, baseType: !86, size: 64, offset: 1408)
!86 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !39, file: !40, line: 95, baseType: !88, size: 64, offset: 1472)
!88 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !89, line: 62, baseType: !90)
!89 = !DIFile(filename: "/root/clang+llvm/lib/clang/7.0.0/include/stddef.h", directory: "/Kirenenko/bin")
!90 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !39, file: !40, line: 96, baseType: !11, size: 32, offset: 1536)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !39, file: !40, line: 98, baseType: !93, size: 160, offset: 1568)
!93 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 160, elements: !94)
!94 = !{!95}
!95 = !DISubrange(count: 20)
!96 = !DILocalVariable(name: "res", scope: !25, file: !1, line: 19, type: !11)
!97 = !DILocation(line: 16, column: 14, scope: !25)
!98 = !DILocation(line: 16, column: 27, scope: !25)
!99 = !DILocation(line: 17, column: 3, scope: !25)
!100 = !DILocation(line: 18, column: 20, scope: !25)
!101 = !{!102, !102, i64 0}
!102 = !{!"any pointer", !103, i64 0}
!103 = !{!"omnipotent char", !104, i64 0}
!104 = !{!"Simple C/C++ TBAA"}
!105 = !DILocation(line: 18, column: 14, scope: !25)
!106 = !DILocation(line: 18, column: 9, scope: !25)
!107 = !DILocation(line: 20, column: 6, scope: !108)
!108 = distinct !DILexicalBlock(scope: !25, file: !1, line: 20, column: 6)
!109 = !DILocation(line: 20, column: 31, scope: !108)
!110 = !DILocation(line: 20, column: 6, scope: !25)
!111 = !DILocation(line: 21, column: 5, scope: !112)
!112 = distinct !DILexicalBlock(scope: !108, file: !1, line: 20, column: 37)
!113 = !DILocation(line: 22, column: 5, scope: !112)
!114 = !DILocation(line: 24, column: 21, scope: !25)
!115 = !{!116, !116, i64 0}
!116 = !{!"int", !103, i64 0}
!117 = !DILocation(line: 17, column: 7, scope: !25)
!118 = !DILocation(line: 6, column: 13, scope: !8, inlinedAt: !119)
!119 = distinct !DILocation(line: 24, column: 24, scope: !25)
!120 = !DILocation(line: 6, column: 20, scope: !8, inlinedAt: !119)
!121 = !DILocation(line: 7, column: 12, scope: !18, inlinedAt: !119)
!122 = !DILocation(line: 7, column: 6, scope: !8, inlinedAt: !119)
!123 = !DILocation(line: 9, column: 16, scope: !22, inlinedAt: !119)
!124 = !DILocation(line: 9, column: 14, scope: !18, inlinedAt: !119)
!125 = !DILocation(line: 24, column: 3, scope: !25)
!126 = !DILocation(line: 25, column: 3, scope: !25)
!127 = !DILocation(line: 26, column: 3, scope: !25)
!128 = !DILocation(line: 0, scope: !25)
!129 = !DILocation(line: 27, column: 1, scope: !25)
