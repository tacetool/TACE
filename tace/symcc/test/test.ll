; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@.str = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"%d %d\0A\00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 0, void ()* @__sym_ctor, i8* null }]
@str = private unnamed_addr constant [17 x i8] c"Failed to read x\00", align 1

; Function Attrs: norecurse nounwind readnone uwtable willreturn
define dso_local i32 @foo(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !7 {
  call void @_sym_notify_basic_block(i64 28035440) #7, !dbg !14
  %3 = call i8* @_sym_get_parameter_expression(i8 0) #7, !dbg !14
  %4 = call i8* @_sym_get_parameter_expression(i8 1) #7, !dbg !14
  call void @llvm.dbg.value(metadata i32 %0, metadata !12, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.value(metadata i32 %1, metadata !13, metadata !DIExpression()), !dbg !14
  %5 = icmp eq i8* %3, null, !dbg !15
  br i1 %5, label %9, label %6, !dbg !15

6:                                                ; preds = %2
  %7 = call i8* @_sym_build_integer(i64 1, i8 32) #7, !dbg !15
  %8 = call i8* @_sym_build_shift_left(i8* nonnull %3, i8* %7) #7, !dbg !15
  br label %9, !dbg !15

9:                                                ; preds = %2, %6
  %10 = phi i8* [ null, %2 ], [ %8, %6 ], !dbg !15
  %11 = shl nsw i32 %0, 1, !dbg !15
  %12 = icmp eq i8* %10, null, !dbg !17
  %13 = icmp eq i8* %4, null, !dbg !17
  %14 = and i1 %12, %13, !dbg !17
  br i1 %14, label %27, label %15, !dbg !17

15:                                               ; preds = %9
  br i1 %12, label %16, label %19, !dbg !17

16:                                               ; preds = %15
  %17 = zext i32 %11 to i64, !dbg !17
  %18 = call i8* @_sym_build_integer(i64 %17, i8 32) #7, !dbg !17
  br label %19, !dbg !17

19:                                               ; preds = %15, %16
  %20 = phi i8* [ %10, %15 ], [ %18, %16 ], !dbg !17
  br i1 %13, label %21, label %24, !dbg !17

21:                                               ; preds = %19
  %22 = zext i32 %1 to i64, !dbg !17
  %23 = call i8* @_sym_build_integer(i64 %22, i8 32) #7, !dbg !17
  br label %24, !dbg !17

24:                                               ; preds = %19, %21
  %25 = phi i8* [ %4, %19 ], [ %23, %21 ], !dbg !17
  %26 = call i8* @_sym_build_signed_less_than(i8* %20, i8* %25) #7, !dbg !17
  br label %27, !dbg !17

27:                                               ; preds = %9, %24
  %28 = phi i8* [ null, %9 ], [ %26, %24 ], !dbg !17
  %29 = icmp slt i32 %11, %1, !dbg !17
  %30 = icmp eq i8* %28, null, !dbg !18
  br i1 %30, label %32, label %31, !dbg !18

31:                                               ; preds = %27
  call void @_sym_push_path_constraint(i8* nonnull %28, i1 %29, i64 28259888) #7, !dbg !18
  br label %32, !dbg !18

32:                                               ; preds = %27, %31
  br i1 %29, label %71, label %33, !dbg !18

33:                                               ; preds = %32
  call void @_sym_notify_basic_block(i64 28259024) #7, !dbg !19
  %34 = icmp eq i8* %3, null, !dbg !19
  %35 = icmp eq i8* %4, null, !dbg !19
  %36 = and i1 %34, %35, !dbg !19
  br i1 %36, label %49, label %37, !dbg !19

37:                                               ; preds = %33
  br i1 %34, label %38, label %41, !dbg !19

38:                                               ; preds = %37
  %39 = zext i32 %0 to i64, !dbg !19
  %40 = call i8* @_sym_build_integer(i64 %39, i8 32) #7, !dbg !19
  br label %41, !dbg !19

41:                                               ; preds = %37, %38
  %42 = phi i8* [ %3, %37 ], [ %40, %38 ], !dbg !19
  br i1 %35, label %43, label %46, !dbg !19

43:                                               ; preds = %41
  %44 = zext i32 %1 to i64, !dbg !19
  %45 = call i8* @_sym_build_integer(i64 %44, i8 32) #7, !dbg !19
  br label %46, !dbg !19

46:                                               ; preds = %41, %43
  %47 = phi i8* [ %4, %41 ], [ %45, %43 ], !dbg !19
  %48 = call i8* @_sym_build_signed_rem(i8* %42, i8* %47) #7, !dbg !19
  br label %49, !dbg !19

49:                                               ; preds = %33, %46
  %50 = phi i8* [ null, %33 ], [ %48, %46 ], !dbg !19
  %51 = srem i32 %0, %1, !dbg !19
  %52 = icmp eq i8* %50, null, !dbg !19
  br i1 %52, label %56, label %53, !dbg !19

53:                                               ; preds = %49
  %54 = call i8* @_sym_build_integer(i64 0, i8 32) #7, !dbg !19
  %55 = call i8* @_sym_build_equal(i8* nonnull %50, i8* %54) #7, !dbg !19
  br label %56, !dbg !19

56:                                               ; preds = %49, %53
  %57 = phi i8* [ null, %49 ], [ %55, %53 ], !dbg !19
  %58 = icmp eq i32 %51, 0, !dbg !19
  %59 = icmp eq i8* %57, null, !dbg !21
  br i1 %59, label %61, label %60, !dbg !21

60:                                               ; preds = %56
  call void @_sym_push_path_constraint(i8* nonnull %57, i1 %58, i64 29011280) #7, !dbg !21
  br label %61, !dbg !21

61:                                               ; preds = %56, %60
  %62 = select i1 %58, i32 %0, i32 0, !dbg !21
  %63 = icmp eq i8* %4, null, !dbg !21
  br i1 %63, label %68, label %64, !dbg !21

64:                                               ; preds = %61
  %65 = zext i32 %62 to i64, !dbg !21
  %66 = call i8* @_sym_build_integer(i64 %65, i8 32) #7, !dbg !21
  %67 = call i8* @_sym_build_add(i8* %66, i8* nonnull %4) #7, !dbg !21
  br label %68, !dbg !21

68:                                               ; preds = %61, %64
  %69 = phi i8* [ null, %61 ], [ %67, %64 ], !dbg !21
  %70 = add nsw i32 %62, %1, !dbg !21
  call void @_sym_set_return_expression(i8* %69) #7, !dbg !21
  ret i32 %70, !dbg !21

71:                                               ; preds = %32
  call void @_sym_notify_basic_block(i64 27575520) #7, !dbg !22
  call void @_sym_set_return_expression(i8* %3) #7, !dbg !22
  ret i32 %0, !dbg !22
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr #2 !dbg !23 {
  call void @_sym_notify_basic_block(i64 28258944) #7
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata i32 %0, metadata !30, metadata !DIExpression()), !dbg !95
  call void @llvm.dbg.value(metadata i8** %1, metadata !31, metadata !DIExpression()), !dbg !95
  %4 = bitcast i32* %3 to i8*, !dbg !96
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #7, !dbg !96
  %5 = getelementptr inbounds i8*, i8** %1, i64 1, !dbg !97
  %6 = ptrtoint i8** %5 to i64, !dbg !97
  %7 = call i8* @_sym_read_memory(i64 %6, i64 8, i8 1) #7, !dbg !97
  %8 = load i8*, i8** %5, align 8, !dbg !97, !tbaa !98
  call void @_sym_notify_call(i64 28312640) #7, !dbg !102
  call void @_sym_set_parameter_expression(i8 0, i8* %7) #7, !dbg !102
  call void @_sym_set_parameter_expression(i8 1, i8* null) #7, !dbg !102
  call void @_sym_set_return_expression(i8* null) #7, !dbg !102
  %9 = tail call %struct._IO_FILE* @fopen_symbolized(i8* %8, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0)) #7, !dbg !102
  call void @_sym_notify_ret(i64 28312640) #7, !dbg !95
  %10 = call i8* @_sym_get_return_expression() #7, !dbg !95
  call void @llvm.dbg.value(metadata %struct._IO_FILE* %9, metadata !33, metadata !DIExpression()), !dbg !95
  call void @llvm.dbg.declare(metadata i32* undef, metadata !94, metadata !DIExpression()), !dbg !103
  call void @llvm.dbg.value(metadata i32* %3, metadata !32, metadata !DIExpression(DW_OP_deref)), !dbg !95
  call void @_sym_notify_call(i64 28320688) #7, !dbg !104
  call void @_sym_set_parameter_expression(i8 0, i8* null) #7, !dbg !104
  call void @_sym_set_parameter_expression(i8 1, i8* null) #7, !dbg !104
  call void @_sym_set_parameter_expression(i8 2, i8* null) #7, !dbg !104
  call void @_sym_set_parameter_expression(i8 3, i8* %10) #7, !dbg !104
  call void @_sym_set_return_expression(i8* null) #7, !dbg !104
  %11 = call i64 @fread_symbolized(i8* nonnull %4, i64 4, i64 1, %struct._IO_FILE* %9) #7, !dbg !104
  call void @_sym_notify_ret(i64 28320688) #7, !dbg !106
  %12 = call i8* @_sym_get_return_expression() #7, !dbg !106
  %13 = icmp eq i8* %12, null, !dbg !106
  br i1 %13, label %17, label %14, !dbg !106

14:                                               ; preds = %2
  %15 = call i8* @_sym_build_integer(i64 1, i8 64) #7, !dbg !106
  %16 = call i8* @_sym_build_equal(i8* nonnull %12, i8* %15) #7, !dbg !106
  br label %17, !dbg !106

17:                                               ; preds = %2, %14
  %18 = phi i8* [ null, %2 ], [ %16, %14 ], !dbg !106
  %19 = icmp eq i64 %11, 1, !dbg !106
  %20 = icmp eq i8* %18, null, !dbg !107
  br i1 %20, label %22, label %21, !dbg !107

21:                                               ; preds = %17
  call void @_sym_push_path_constraint(i8* nonnull %18, i1 %19, i64 28320928) #7, !dbg !107
  br label %22, !dbg !107

22:                                               ; preds = %17, %21
  br i1 %19, label %25, label %23, !dbg !107

23:                                               ; preds = %22
  call void @_sym_notify_basic_block(i64 28318368) #7, !dbg !108
  call void @_sym_notify_call(i64 28832800) #7, !dbg !108
  call void @_sym_set_parameter_expression(i8 0, i8* null) #7, !dbg !108
  %24 = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([17 x i8], [17 x i8]* @str, i64 0, i64 0)), !dbg !108
  br label %69, !dbg !110

25:                                               ; preds = %22
  call void @_sym_notify_basic_block(i64 28318448) #7, !dbg !111
  %26 = ptrtoint i32* %3 to i64, !dbg !111
  %27 = call i8* @_sym_read_memory(i64 %26, i64 4, i8 1) #7, !dbg !111
  %28 = load i32, i32* %3, align 4, !dbg !111, !tbaa !112
  call void @llvm.dbg.value(metadata i32 %28, metadata !32, metadata !DIExpression()), !dbg !95
  call void @llvm.dbg.value(metadata i32 %28, metadata !12, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.value(metadata i32 7, metadata !13, metadata !DIExpression()), !dbg !114
  %29 = icmp eq i8* %27, null, !dbg !116
  br i1 %29, label %33, label %30, !dbg !116

30:                                               ; preds = %25
  %31 = call i8* @_sym_build_integer(i64 4, i8 32) #7, !dbg !116
  %32 = call i8* @_sym_build_signed_less_than(i8* nonnull %27, i8* %31) #7, !dbg !116
  br label %33, !dbg !116

33:                                               ; preds = %25, %30
  %34 = phi i8* [ null, %25 ], [ %32, %30 ], !dbg !116
  %35 = icmp slt i32 %28, 4, !dbg !116
  %36 = icmp eq i8* %34, null, !dbg !117
  br i1 %36, label %38, label %37, !dbg !117

37:                                               ; preds = %33
  call void @_sym_push_path_constraint(i8* nonnull %34, i1 %35, i64 28853760) #7, !dbg !117
  br label %38, !dbg !117

38:                                               ; preds = %33, %37
  br i1 %35, label %64, label %39, !dbg !117

39:                                               ; preds = %38
  call void @_sym_notify_basic_block(i64 29077632) #7, !dbg !118
  %40 = icmp eq i8* %27, null, !dbg !118
  br i1 %40, label %44, label %41, !dbg !118

41:                                               ; preds = %39
  %42 = call i8* @_sym_build_integer(i64 7, i8 32) #7, !dbg !118
  %43 = call i8* @_sym_build_unsigned_rem(i8* nonnull %27, i8* %42) #7, !dbg !118
  br label %44, !dbg !118

44:                                               ; preds = %39, %41
  %45 = phi i8* [ null, %39 ], [ %43, %41 ], !dbg !118
  %46 = urem i32 %28, 7, !dbg !118
  %47 = icmp eq i8* %45, null, !dbg !118
  br i1 %47, label %51, label %48, !dbg !118

48:                                               ; preds = %44
  %49 = call i8* @_sym_build_integer(i64 0, i8 32) #7, !dbg !118
  %50 = call i8* @_sym_build_equal(i8* nonnull %45, i8* %49) #7, !dbg !118
  br label %51, !dbg !118

51:                                               ; preds = %44, %48
  %52 = phi i8* [ null, %44 ], [ %50, %48 ], !dbg !118
  %53 = icmp eq i32 %46, 0, !dbg !118
  %54 = icmp eq i8* %27, null, !dbg !119
  br i1 %54, label %58, label %55, !dbg !119

55:                                               ; preds = %51
  %56 = call i8* @_sym_build_integer(i64 7, i8 32) #7, !dbg !119
  %57 = call i8* @_sym_build_add(i8* nonnull %27, i8* %56) #7, !dbg !119
  br label %58, !dbg !119

58:                                               ; preds = %51, %55
  %59 = add nuw i32 %28, 7, !dbg !119
  %60 = icmp eq i8* %52, null, !dbg !119
  br i1 %60, label %62, label %61, !dbg !119

61:                                               ; preds = %58
  call void @_sym_push_path_constraint(i8* nonnull %52, i1 %53, i64 29092064) #7, !dbg !119
  br label %62, !dbg !119

62:                                               ; preds = %58, %61
  %63 = select i1 %53, i32 %59, i32 7, !dbg !119
  br label %64, !dbg !119

64:                                               ; preds = %38, %62
  %65 = phi i8* [ null, %62 ], [ %27, %38 ]
  %66 = phi i32 [ %63, %62 ], [ %28, %38 ]
  call void @_sym_notify_basic_block(i64 29090112) #7, !dbg !120
  call void @_sym_notify_call(i64 26100544) #7, !dbg !120
  call void @_sym_set_parameter_expression(i8 0, i8* null) #7, !dbg !120
  call void @_sym_set_parameter_expression(i8 1, i8* %27) #7, !dbg !120
  call void @_sym_set_parameter_expression(i8 2, i8* %65) #7, !dbg !120
  %67 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0), i32 %28, i32 %66), !dbg !120
  call void @_sym_notify_ret(i64 26100544) #7, !dbg !121
  call void @_sym_notify_call(i64 28325184) #7, !dbg !121
  call void @_sym_set_parameter_expression(i8 0, i8* %10) #7, !dbg !121
  %68 = call i32 @fclose(%struct._IO_FILE* %9), !dbg !121
  br label %69, !dbg !122

69:                                               ; preds = %64, %23
  %70 = phi i64 [ 28325184, %64 ], [ 28832800, %23 ]
  %71 = phi i32 [ 0, %64 ], [ -1, %23 ], !dbg !95
  call void @_sym_notify_ret(i64 %70) #7, !dbg !95
  call void @_sym_notify_basic_block(i64 28322464) #7, !dbg !123
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #7, !dbg !123
  call void @_sym_set_return_expression(i8* null) #7, !dbg !123
  ret i32 %71, !dbg !123
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

declare dso_local %struct._IO_FILE* @fopen_symbolized(i8*, i8*) local_unnamed_addr #4

declare dso_local i64 @fread_symbolized(i8*, i64, i64, %struct._IO_FILE*) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare !dbg !124 dso_local noundef i32 @fclose(%struct._IO_FILE* nocapture noundef) local_unnamed_addr #5

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

declare void @_sym_initialize() local_unnamed_addr

define internal void @__sym_ctor() {
  tail call void @_sym_initialize()
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @puts(i8* nocapture noundef readonly) local_unnamed_addr #6

declare i8* @_sym_build_integer(i64, i8)

declare void @_sym_push_path_constraint(i8*, i1, i64)

declare void @_sym_set_parameter_expression(i8, i8*)

declare i8* @_sym_get_parameter_expression(i8)

declare void @_sym_set_return_expression(i8*)

declare i8* @_sym_get_return_expression()

declare i8* @_sym_build_add(i8*, i8*)

declare i8* @_sym_build_unsigned_rem(i8*, i8*)

declare i8* @_sym_build_signed_rem(i8*, i8*)

declare i8* @_sym_build_shift_left(i8*, i8*)

declare i8* @_sym_build_equal(i8*, i8*)

declare i8* @_sym_build_signed_less_than(i8*, i8*)

declare i8* @_sym_read_memory(i64, i64, i8)

declare void @_sym_notify_call(i64)

declare void @_sym_notify_ret(i64)

declare void @_sym_notify_basic_block(i64)

attributes #0 = { norecurse nounwind readnone uwtable willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nofree nosync nounwind willreturn }
attributes #4 = { "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nofree nounwind }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 12.0.0-3ubuntu1~20.04.4", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test.c", directory: "/symcc/test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.4"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 6, type: !8, scopeLine: 6, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !11)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{!12, !13}
!12 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 6, type: !10)
!13 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 6, type: !10)
!14 = !DILocation(line: 0, scope: !7)
!15 = !DILocation(line: 7, column: 8, scope: !16)
!16 = distinct !DILexicalBlock(scope: !7, file: !1, line: 7, column: 6)
!17 = !DILocation(line: 7, column: 12, scope: !16)
!18 = !DILocation(line: 7, column: 6, scope: !7)
!19 = !DILocation(line: 9, column: 16, scope: !20)
!20 = distinct !DILexicalBlock(scope: !16, file: !1, line: 9, column: 14)
!21 = !DILocation(line: 9, column: 14, scope: !16)
!22 = !DILocation(line: 14, column: 1, scope: !7)
!23 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !24, scopeLine: 16, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !29)
!24 = !DISubroutineType(types: !25)
!25 = !{!10, !10, !26}
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!29 = !{!30, !31, !32, !33, !94}
!30 = !DILocalVariable(name: "argc", arg: 1, scope: !23, file: !1, line: 16, type: !10)
!31 = !DILocalVariable(name: "argv", arg: 2, scope: !23, file: !1, line: 16, type: !26)
!32 = !DILocalVariable(name: "x", scope: !23, file: !1, line: 17, type: !10)
!33 = !DILocalVariable(name: "fd", scope: !23, file: !1, line: 18, type: !34)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !36, line: 7, baseType: !37)
!36 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "")
!37 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !38, line: 49, size: 1728, elements: !39)
!38 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h", directory: "")
!39 = !{!40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !55, !57, !58, !59, !63, !65, !67, !71, !74, !76, !79, !82, !83, !85, !89, !90}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !37, file: !38, line: 51, baseType: !10, size: 32)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !37, file: !38, line: 54, baseType: !27, size: 64, offset: 64)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !37, file: !38, line: 55, baseType: !27, size: 64, offset: 128)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !37, file: !38, line: 56, baseType: !27, size: 64, offset: 192)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !37, file: !38, line: 57, baseType: !27, size: 64, offset: 256)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !37, file: !38, line: 58, baseType: !27, size: 64, offset: 320)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !37, file: !38, line: 59, baseType: !27, size: 64, offset: 384)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !37, file: !38, line: 60, baseType: !27, size: 64, offset: 448)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !37, file: !38, line: 61, baseType: !27, size: 64, offset: 512)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !37, file: !38, line: 64, baseType: !27, size: 64, offset: 576)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !37, file: !38, line: 65, baseType: !27, size: 64, offset: 640)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !37, file: !38, line: 66, baseType: !27, size: 64, offset: 704)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !37, file: !38, line: 68, baseType: !53, size: 64, offset: 768)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!54 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !38, line: 36, flags: DIFlagFwdDecl)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !37, file: !38, line: 70, baseType: !56, size: 64, offset: 832)
!56 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !37, file: !38, line: 72, baseType: !10, size: 32, offset: 896)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !37, file: !38, line: 73, baseType: !10, size: 32, offset: 928)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !37, file: !38, line: 74, baseType: !60, size: 64, offset: 960)
!60 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !61, line: 152, baseType: !62)
!61 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!62 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !37, file: !38, line: 77, baseType: !64, size: 16, offset: 1024)
!64 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !37, file: !38, line: 78, baseType: !66, size: 8, offset: 1040)
!66 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !37, file: !38, line: 79, baseType: !68, size: 8, offset: 1048)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 8, elements: !69)
!69 = !{!70}
!70 = !DISubrange(count: 1)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !37, file: !38, line: 81, baseType: !72, size: 64, offset: 1088)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !38, line: 43, baseType: null)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !37, file: !38, line: 89, baseType: !75, size: 64, offset: 1152)
!75 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !61, line: 153, baseType: !62)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !37, file: !38, line: 91, baseType: !77, size: 64, offset: 1216)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !38, line: 37, flags: DIFlagFwdDecl)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !37, file: !38, line: 92, baseType: !80, size: 64, offset: 1280)
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !38, line: 38, flags: DIFlagFwdDecl)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !37, file: !38, line: 93, baseType: !56, size: 64, offset: 1344)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !37, file: !38, line: 94, baseType: !84, size: 64, offset: 1408)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !37, file: !38, line: 95, baseType: !86, size: 64, offset: 1472)
!86 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !87, line: 46, baseType: !88)
!87 = !DIFile(filename: "/usr/lib/llvm-12/lib/clang/12.0.0/include/stddef.h", directory: "")
!88 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !37, file: !38, line: 96, baseType: !10, size: 32, offset: 1536)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !37, file: !38, line: 98, baseType: !91, size: 160, offset: 1568)
!91 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 160, elements: !92)
!92 = !{!93}
!93 = !DISubrange(count: 20)
!94 = !DILocalVariable(name: "res", scope: !23, file: !1, line: 19, type: !10)
!95 = !DILocation(line: 0, scope: !23)
!96 = !DILocation(line: 17, column: 3, scope: !23)
!97 = !DILocation(line: 18, column: 20, scope: !23)
!98 = !{!99, !99, i64 0}
!99 = !{!"any pointer", !100, i64 0}
!100 = !{!"omnipotent char", !101, i64 0}
!101 = !{!"Simple C/C++ TBAA"}
!102 = !DILocation(line: 18, column: 14, scope: !23)
!103 = !DILocation(line: 19, column: 7, scope: !23)
!104 = !DILocation(line: 20, column: 6, scope: !105)
!105 = distinct !DILexicalBlock(scope: !23, file: !1, line: 20, column: 6)
!106 = !DILocation(line: 20, column: 31, scope: !105)
!107 = !DILocation(line: 20, column: 6, scope: !23)
!108 = !DILocation(line: 21, column: 5, scope: !109)
!109 = distinct !DILexicalBlock(scope: !105, file: !1, line: 20, column: 37)
!110 = !DILocation(line: 22, column: 5, scope: !109)
!111 = !DILocation(line: 24, column: 21, scope: !23)
!112 = !{!113, !113, i64 0}
!113 = !{!"int", !100, i64 0}
!114 = !DILocation(line: 0, scope: !7, inlinedAt: !115)
!115 = distinct !DILocation(line: 24, column: 24, scope: !23)
!116 = !DILocation(line: 7, column: 12, scope: !16, inlinedAt: !115)
!117 = !DILocation(line: 7, column: 6, scope: !7, inlinedAt: !115)
!118 = !DILocation(line: 9, column: 16, scope: !20, inlinedAt: !115)
!119 = !DILocation(line: 9, column: 14, scope: !16, inlinedAt: !115)
!120 = !DILocation(line: 24, column: 3, scope: !23)
!121 = !DILocation(line: 25, column: 3, scope: !23)
!122 = !DILocation(line: 26, column: 3, scope: !23)
!123 = !DILocation(line: 27, column: 1, scope: !23)
!124 = !DISubprogram(name: "fclose", scope: !125, file: !125, line: 213, type: !126, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !2)
!125 = !DIFile(filename: "/usr/include/stdio.h", directory: "")
!126 = !DISubroutineType(types: !127)
!127 = !{!10, !56}
