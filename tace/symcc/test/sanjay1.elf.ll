; ModuleID = 'sanjay1.c'
source_filename = "sanjay1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@.str = private unnamed_addr constant [2 x i8] c"r\00", align 1
@str = private unnamed_addr constant [9 x i8] c"branch 0\00", align 1
@str.13 = private unnamed_addr constant [9 x i8] c"branch 1\00", align 1
@str.14 = private unnamed_addr constant [9 x i8] c"branch 2\00", align 1
@str.15 = private unnamed_addr constant [9 x i8] c"branch 6\00", align 1
@str.16 = private unnamed_addr constant [9 x i8] c"branch 3\00", align 1
@str.17 = private unnamed_addr constant [9 x i8] c"branch 5\00", align 1
@str.18 = private unnamed_addr constant [20 x i8] c"vulnerable branch 4\00", align 1
@str.19 = private unnamed_addr constant [19 x i8] c"unrelated branch 4\00", align 1
@str.20 = private unnamed_addr constant [19 x i8] c"unrelated branch 3\00", align 1
@str.21 = private unnamed_addr constant [19 x i8] c"unrelated branch 2\00", align 1
@str.22 = private unnamed_addr constant [19 x i8] c"unrelated branch 1\00", align 1
@str.23 = private unnamed_addr constant [31 x i8] c"too many large chars. Exiting!\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr #0 !dbg !71 {
  %3 = alloca [2000 x i8], align 16
  call void @llvm.dbg.value(metadata i32 %0, metadata !76, metadata !DIExpression()), !dbg !87
  call void @llvm.dbg.value(metadata i8** %1, metadata !77, metadata !DIExpression()), !dbg !87
  %4 = getelementptr inbounds i8*, i8** %1, i64 1, !dbg !88
  %5 = load i8*, i8** %4, align 8, !dbg !88, !tbaa !89
  call void @llvm.dbg.value(metadata i8* %5, metadata !78, metadata !DIExpression()), !dbg !87
  %6 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 0, !dbg !93
  call void @llvm.lifetime.start.p0i8(i64 2000, i8* nonnull %6) #6, !dbg !93
  call void @llvm.dbg.declare(metadata [2000 x i8]* %3, metadata !79, metadata !DIExpression()), !dbg !94
  call void @llvm.dbg.value(metadata i32 0, metadata !84, metadata !DIExpression()), !dbg !87
  %7 = tail call %struct._IO_FILE* @fopen(i8* %5, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0)), !dbg !95
  call void @llvm.dbg.value(metadata %struct._IO_FILE* %7, metadata !86, metadata !DIExpression()), !dbg !87
  %8 = tail call i32 @fseek(%struct._IO_FILE* %7, i64 0, i32 2), !dbg !96
  %9 = tail call i64 @ftell(%struct._IO_FILE* %7), !dbg !97
  call void @llvm.dbg.value(metadata i64 %9, metadata !83, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !87
  %10 = tail call i32 @fseek(%struct._IO_FILE* %7, i64 0, i32 0), !dbg !98
  %11 = shl i64 %9, 32, !dbg !99
  %12 = ashr exact i64 %11, 32, !dbg !99
  %13 = call i64 @fread(i8* nonnull %6, i64 1, i64 %12, %struct._IO_FILE* %7), !dbg !100
  %14 = load i8, i8* %6, align 16, !dbg !101, !tbaa !103
  %15 = sext i8 %14 to i32, !dbg !101
  %16 = shl nsw i32 %15, 1, !dbg !104
  %17 = mul nsw i32 %15, 3, !dbg !105
  %18 = icmp slt i32 %16, %17, !dbg !106
  call void @llvm.dbg.value(metadata i1 %18, metadata !84, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !87
  call void @llvm.dbg.value(metadata i32 undef, metadata !85, metadata !DIExpression()), !dbg !87
  %19 = select i1 %18, i32 2, i32 0, !dbg !107
  call void @llvm.dbg.value(metadata i32 %19, metadata !84, metadata !DIExpression()), !dbg !87
  call void @llvm.dbg.value(metadata i32 undef, metadata !85, metadata !DIExpression()), !dbg !87
  %20 = zext i1 %18 to i32, !dbg !108
  %21 = or i32 %19, %20, !dbg !108
  call void @llvm.dbg.value(metadata i32 %21, metadata !84, metadata !DIExpression()), !dbg !87
  %22 = icmp eq i32 %21, 0, !dbg !109
  br i1 %22, label %100, label %23, !dbg !111

23:                                               ; preds = %2
  %24 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 7, !dbg !112
  %25 = load i8, i8* %24, align 1, !dbg !112, !tbaa !103
  %26 = sext i8 %25 to i32, !dbg !112
  %27 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 5, !dbg !114
  %28 = load i8, i8* %27, align 1, !dbg !114, !tbaa !103
  %29 = sext i8 %28 to i32, !dbg !114
  %30 = add nsw i32 %29, %26, !dbg !115
  %31 = icmp eq i32 %30, 82, !dbg !116
  br i1 %31, label %32, label %100, !dbg !117

32:                                               ; preds = %23
  %33 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @str.13, i64 0, i64 0)), !dbg !118
  %34 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 18, !dbg !120
  %35 = load i8, i8* %34, align 2, !dbg !120, !tbaa !103
  %36 = sext i8 %35 to i32, !dbg !120
  %37 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 19, !dbg !122
  %38 = load i8, i8* %37, align 1, !dbg !122, !tbaa !103
  %39 = sext i8 %38 to i32, !dbg !122
  %40 = add nsw i32 %39, %36, !dbg !123
  %41 = icmp eq i32 %40, 98, !dbg !124
  br i1 %41, label %42, label %100, !dbg !125

42:                                               ; preds = %32
  %43 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @str.14, i64 0, i64 0)), !dbg !126
  %44 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 2, !dbg !128
  %45 = load i8, i8* %44, align 2, !dbg !128, !tbaa !103
  %46 = sext i8 %45 to i32, !dbg !128
  %47 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 4, !dbg !130
  %48 = load i8, i8* %47, align 4, !dbg !130, !tbaa !103
  %49 = sext i8 %48 to i32, !dbg !130
  %50 = add nsw i32 %49, %46, !dbg !131
  %51 = icmp eq i32 %50, 88, !dbg !132
  br i1 %51, label %52, label %54, !dbg !133

52:                                               ; preds = %42
  %53 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @str.22, i64 0, i64 0)), !dbg !134
  br label %54, !dbg !136

54:                                               ; preds = %52, %42
  %55 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 8, !dbg !137
  %56 = load i8, i8* %55, align 8, !dbg !137, !tbaa !103
  %57 = sext i8 %56 to i32, !dbg !137
  %58 = add nsw i32 %57, %49, !dbg !139
  %59 = icmp eq i32 %58, 88, !dbg !140
  br i1 %59, label %60, label %62, !dbg !141

60:                                               ; preds = %54
  %61 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @str.21, i64 0, i64 0)), !dbg !142
  br label %62, !dbg !144

62:                                               ; preds = %60, %54
  %63 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 15, !dbg !145
  %64 = load i8, i8* %63, align 1, !dbg !145, !tbaa !103
  %65 = sext i8 %64 to i32, !dbg !145
  %66 = add nsw i32 %65, %36, !dbg !147
  %67 = icmp eq i32 %66, 85, !dbg !148
  br i1 %67, label %68, label %98, !dbg !149

68:                                               ; preds = %62
  %69 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @str.16, i64 0, i64 0)), !dbg !150
  %70 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 9, !dbg !152
  %71 = load i8, i8* %70, align 1, !dbg !152, !tbaa !103
  %72 = sext i8 %71 to i32, !dbg !152
  %73 = add nsw i32 %72, %29, !dbg !154
  %74 = icmp eq i32 %73, 88, !dbg !155
  br i1 %74, label %75, label %77, !dbg !156

75:                                               ; preds = %68
  %76 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @str.20, i64 0, i64 0)), !dbg !157
  br label %77, !dbg !159

77:                                               ; preds = %75, %68
  %78 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 11, !dbg !160
  %79 = load i8, i8* %78, align 1, !dbg !160, !tbaa !103
  %80 = sext i8 %79 to i32, !dbg !160
  %81 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 24, !dbg !162
  %82 = load i8, i8* %81, align 8, !dbg !162, !tbaa !103
  %83 = sext i8 %82 to i32, !dbg !162
  %84 = add nsw i32 %83, %80, !dbg !163
  %85 = icmp eq i32 %84, 88, !dbg !164
  br i1 %85, label %86, label %88, !dbg !165

86:                                               ; preds = %77
  %87 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @str.19, i64 0, i64 0)), !dbg !166
  br label %88, !dbg !168

88:                                               ; preds = %86, %77
  %89 = getelementptr inbounds [2000 x i8], [2000 x i8]* %3, i64 0, i64 14, !dbg !169
  %90 = load i8, i8* %89, align 2, !dbg !169, !tbaa !103
  %91 = sext i8 %90 to i32, !dbg !169
  %92 = add nsw i32 %91, %65, !dbg !171
  %93 = icmp eq i32 %92, 103, !dbg !172
  br i1 %93, label %94, label %96, !dbg !173

94:                                               ; preds = %88
  %95 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @str.18, i64 0, i64 0)), !dbg !174
  tail call void @abort() #7, !dbg !176
  unreachable, !dbg !176

96:                                               ; preds = %88
  %97 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @str.17, i64 0, i64 0)), !dbg !177
  br label %100, !dbg !178

98:                                               ; preds = %62
  %99 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @str.15, i64 0, i64 0)), !dbg !179
  br label %100

100:                                              ; preds = %23, %96, %98, %32, %2
  %101 = phi i8* [ getelementptr inbounds ([31 x i8], [31 x i8]* @str.23, i64 0, i64 0), %2 ], [ getelementptr inbounds ([9 x i8], [9 x i8]* @str, i64 0, i64 0), %32 ], [ getelementptr inbounds ([9 x i8], [9 x i8]* @str, i64 0, i64 0), %98 ], [ getelementptr inbounds ([9 x i8], [9 x i8]* @str, i64 0, i64 0), %96 ], [ getelementptr inbounds ([9 x i8], [9 x i8]* @str, i64 0, i64 0), %23 ]
  %102 = phi i32 [ -1, %2 ], [ 0, %32 ], [ 0, %98 ], [ 0, %96 ], [ 0, %23 ], !dbg !87
  %103 = tail call i32 @puts(i8* nonnull dereferenceable(1) %101), !dbg !87
  call void @llvm.lifetime.end.p0i8(i64 2000, i8* nonnull %6) #6, !dbg !180
  ret i32 %102, !dbg !180
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nofree nounwind
declare dso_local noalias noundef %struct._IO_FILE* @fopen(i8* nocapture noundef readonly, i8* nocapture noundef readonly) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare !dbg !181 dso_local noundef i32 @fseek(%struct._IO_FILE* nocapture noundef, i64 noundef, i32 noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare !dbg !185 dso_local noundef i64 @ftell(%struct._IO_FILE* nocapture noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare dso_local noundef i64 @fread(i8* nocapture noundef, i64 noundef, i64 noundef, %struct._IO_FILE* nocapture noundef) local_unnamed_addr #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() local_unnamed_addr #4

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: nofree nounwind
declare noundef i32 @puts(i8* nocapture noundef readonly) local_unnamed_addr #5

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nofree nosync nounwind willreturn }
attributes #3 = { nofree nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree nounwind }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!67, !68, !69}
!llvm.ident = !{!70}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 12.0.0-3ubuntu1~20.04.4", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "sanjay1.c", directory: "/symcc/test")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !6, line: 7, baseType: !7)
!6 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "")
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !8, line: 49, size: 1728, elements: !9)
!8 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h", directory: "")
!9 = !{!10, !12, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !28, !30, !31, !32, !36, !38, !40, !44, !47, !49, !52, !55, !56, !58, !62, !63}
!10 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !7, file: !8, line: 51, baseType: !11, size: 32)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !7, file: !8, line: 54, baseType: !13, size: 64, offset: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !7, file: !8, line: 55, baseType: !13, size: 64, offset: 128)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !7, file: !8, line: 56, baseType: !13, size: 64, offset: 192)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !7, file: !8, line: 57, baseType: !13, size: 64, offset: 256)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !7, file: !8, line: 58, baseType: !13, size: 64, offset: 320)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !7, file: !8, line: 59, baseType: !13, size: 64, offset: 384)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !7, file: !8, line: 60, baseType: !13, size: 64, offset: 448)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !7, file: !8, line: 61, baseType: !13, size: 64, offset: 512)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !7, file: !8, line: 64, baseType: !13, size: 64, offset: 576)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !7, file: !8, line: 65, baseType: !13, size: 64, offset: 640)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !7, file: !8, line: 66, baseType: !13, size: 64, offset: 704)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !7, file: !8, line: 68, baseType: !26, size: 64, offset: 768)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !8, line: 36, flags: DIFlagFwdDecl)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !7, file: !8, line: 70, baseType: !29, size: 64, offset: 832)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !7, file: !8, line: 72, baseType: !11, size: 32, offset: 896)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !7, file: !8, line: 73, baseType: !11, size: 32, offset: 928)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !7, file: !8, line: 74, baseType: !33, size: 64, offset: 960)
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !34, line: 152, baseType: !35)
!34 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!35 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !7, file: !8, line: 77, baseType: !37, size: 16, offset: 1024)
!37 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !7, file: !8, line: 78, baseType: !39, size: 8, offset: 1040)
!39 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !7, file: !8, line: 79, baseType: !41, size: 8, offset: 1048)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 8, elements: !42)
!42 = !{!43}
!43 = !DISubrange(count: 1)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !7, file: !8, line: 81, baseType: !45, size: 64, offset: 1088)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!46 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !8, line: 43, baseType: null)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !7, file: !8, line: 89, baseType: !48, size: 64, offset: 1152)
!48 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !34, line: 153, baseType: !35)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !7, file: !8, line: 91, baseType: !50, size: 64, offset: 1216)
!50 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !51, size: 64)
!51 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !8, line: 37, flags: DIFlagFwdDecl)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !7, file: !8, line: 92, baseType: !53, size: 64, offset: 1280)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!54 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !8, line: 38, flags: DIFlagFwdDecl)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !7, file: !8, line: 93, baseType: !29, size: 64, offset: 1344)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !7, file: !8, line: 94, baseType: !57, size: 64, offset: 1408)
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !7, file: !8, line: 95, baseType: !59, size: 64, offset: 1472)
!59 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !60, line: 46, baseType: !61)
!60 = !DIFile(filename: "/usr/lib/llvm-12/lib/clang/12.0.0/include/stddef.h", directory: "")
!61 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !7, file: !8, line: 96, baseType: !11, size: 32, offset: 1536)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !7, file: !8, line: 98, baseType: !64, size: 160, offset: 1568)
!64 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 160, elements: !65)
!65 = !{!66}
!66 = !DISubrange(count: 20)
!67 = !{i32 7, !"Dwarf Version", i32 4}
!68 = !{i32 2, !"Debug Info Version", i32 3}
!69 = !{i32 1, !"wchar_size", i32 4}
!70 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.4"}
!71 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 5, type: !72, scopeLine: 6, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !75)
!72 = !DISubroutineType(types: !73)
!73 = !{!11, !11, !74}
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!75 = !{!76, !77, !78, !79, !83, !84, !85, !86}
!76 = !DILocalVariable(name: "argc", arg: 1, scope: !71, file: !1, line: 5, type: !11)
!77 = !DILocalVariable(name: "argv", arg: 2, scope: !71, file: !1, line: 5, type: !74)
!78 = !DILocalVariable(name: "file", scope: !71, file: !1, line: 7, type: !13)
!79 = !DILocalVariable(name: "str", scope: !71, file: !1, line: 8, type: !80)
!80 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 16000, elements: !81)
!81 = !{!82}
!82 = !DISubrange(count: 2000)
!83 = !DILocalVariable(name: "fsize", scope: !71, file: !1, line: 9, type: !11)
!84 = !DILocalVariable(name: "check", scope: !71, file: !1, line: 10, type: !11)
!85 = !DILocalVariable(name: "i", scope: !71, file: !1, line: 10, type: !11)
!86 = !DILocalVariable(name: "fp", scope: !71, file: !1, line: 11, type: !4)
!87 = !DILocation(line: 0, scope: !71)
!88 = !DILocation(line: 7, column: 18, scope: !71)
!89 = !{!90, !90, i64 0}
!90 = !{!"any pointer", !91, i64 0}
!91 = !{!"omnipotent char", !92, i64 0}
!92 = !{!"Simple C/C++ TBAA"}
!93 = !DILocation(line: 8, column: 5, scope: !71)
!94 = !DILocation(line: 8, column: 10, scope: !71)
!95 = !DILocation(line: 11, column: 16, scope: !71)
!96 = !DILocation(line: 12, column: 5, scope: !71)
!97 = !DILocation(line: 13, column: 10, scope: !71)
!98 = !DILocation(line: 14, column: 2, scope: !71)
!99 = !DILocation(line: 17, column: 27, scope: !71)
!100 = !DILocation(line: 17, column: 2, scope: !71)
!101 = !DILocation(line: 29, column: 6, scope: !102)
!102 = distinct !DILexicalBlock(scope: !71, file: !1, line: 29, column: 5)
!103 = !{!91, !91, i64 0}
!104 = !DILocation(line: 29, column: 12, scope: !102)
!105 = !DILocation(line: 29, column: 41, scope: !102)
!106 = !DILocation(line: 29, column: 22, scope: !102)
!107 = !DILocation(line: 32, column: 5, scope: !71)
!108 = !DILocation(line: 35, column: 5, scope: !71)
!109 = !DILocation(line: 39, column: 10, scope: !110)
!110 = distinct !DILexicalBlock(scope: !71, file: !1, line: 39, column: 5)
!111 = !DILocation(line: 39, column: 5, scope: !71)
!112 = !DILocation(line: 45, column: 8, scope: !113)
!113 = distinct !DILexicalBlock(scope: !71, file: !1, line: 45, column: 8)
!114 = !DILocation(line: 45, column: 17, scope: !113)
!115 = !DILocation(line: 45, column: 15, scope: !113)
!116 = !DILocation(line: 45, column: 24, scope: !113)
!117 = !DILocation(line: 45, column: 8, scope: !71)
!118 = !DILocation(line: 47, column: 9, scope: !119)
!119 = distinct !DILexicalBlock(scope: !113, file: !1, line: 46, column: 5)
!120 = !DILocation(line: 48, column: 12, scope: !121)
!121 = distinct !DILexicalBlock(scope: !119, file: !1, line: 48, column: 12)
!122 = !DILocation(line: 48, column: 22, scope: !121)
!123 = !DILocation(line: 48, column: 20, scope: !121)
!124 = !DILocation(line: 48, column: 30, scope: !121)
!125 = !DILocation(line: 48, column: 12, scope: !119)
!126 = !DILocation(line: 51, column: 13, scope: !127)
!127 = distinct !DILexicalBlock(scope: !121, file: !1, line: 49, column: 9)
!128 = !DILocation(line: 52, column: 16, scope: !129)
!129 = distinct !DILexicalBlock(scope: !127, file: !1, line: 52, column: 16)
!130 = !DILocation(line: 52, column: 25, scope: !129)
!131 = !DILocation(line: 52, column: 23, scope: !129)
!132 = !DILocation(line: 52, column: 32, scope: !129)
!133 = !DILocation(line: 52, column: 16, scope: !127)
!134 = !DILocation(line: 54, column: 21, scope: !135)
!135 = distinct !DILexicalBlock(scope: !129, file: !1, line: 53, column: 17)
!136 = !DILocation(line: 55, column: 17, scope: !135)
!137 = !DILocation(line: 56, column: 25, scope: !138)
!138 = distinct !DILexicalBlock(scope: !127, file: !1, line: 56, column: 16)
!139 = !DILocation(line: 56, column: 23, scope: !138)
!140 = !DILocation(line: 56, column: 32, scope: !138)
!141 = !DILocation(line: 56, column: 16, scope: !127)
!142 = !DILocation(line: 58, column: 21, scope: !143)
!143 = distinct !DILexicalBlock(scope: !138, file: !1, line: 57, column: 17)
!144 = !DILocation(line: 59, column: 17, scope: !143)
!145 = !DILocation(line: 61, column: 16, scope: !146)
!146 = distinct !DILexicalBlock(scope: !127, file: !1, line: 61, column: 16)
!147 = !DILocation(line: 61, column: 24, scope: !146)
!148 = !DILocation(line: 61, column: 34, scope: !146)
!149 = !DILocation(line: 61, column: 16, scope: !127)
!150 = !DILocation(line: 63, column: 17, scope: !151)
!151 = distinct !DILexicalBlock(scope: !146, file: !1, line: 62, column: 13)
!152 = !DILocation(line: 64, column: 29, scope: !153)
!153 = distinct !DILexicalBlock(scope: !151, file: !1, line: 64, column: 20)
!154 = !DILocation(line: 64, column: 27, scope: !153)
!155 = !DILocation(line: 64, column: 36, scope: !153)
!156 = !DILocation(line: 64, column: 20, scope: !151)
!157 = !DILocation(line: 66, column: 21, scope: !158)
!158 = distinct !DILexicalBlock(scope: !153, file: !1, line: 65, column: 17)
!159 = !DILocation(line: 67, column: 17, scope: !158)
!160 = !DILocation(line: 68, column: 20, scope: !161)
!161 = distinct !DILexicalBlock(scope: !151, file: !1, line: 68, column: 20)
!162 = !DILocation(line: 68, column: 30, scope: !161)
!163 = !DILocation(line: 68, column: 28, scope: !161)
!164 = !DILocation(line: 68, column: 38, scope: !161)
!165 = !DILocation(line: 68, column: 20, scope: !151)
!166 = !DILocation(line: 70, column: 21, scope: !167)
!167 = distinct !DILexicalBlock(scope: !161, file: !1, line: 69, column: 17)
!168 = !DILocation(line: 71, column: 17, scope: !167)
!169 = !DILocation(line: 72, column: 30, scope: !170)
!170 = distinct !DILexicalBlock(scope: !151, file: !1, line: 72, column: 20)
!171 = !DILocation(line: 72, column: 28, scope: !170)
!172 = !DILocation(line: 72, column: 38, scope: !170)
!173 = !DILocation(line: 72, column: 20, scope: !151)
!174 = !DILocation(line: 74, column: 21, scope: !175)
!175 = distinct !DILexicalBlock(scope: !170, file: !1, line: 73, column: 17)
!176 = !DILocation(line: 76, column: 21, scope: !175)
!177 = !DILocation(line: 79, column: 21, scope: !170)
!178 = !DILocation(line: 80, column: 14, scope: !151)
!179 = !DILocation(line: 82, column: 15, scope: !146)
!180 = !DILocation(line: 88, column: 2, scope: !71)
!181 = !DISubprogram(name: "fseek", scope: !182, file: !182, line: 684, type: !183, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !2)
!182 = !DIFile(filename: "/usr/include/stdio.h", directory: "")
!183 = !DISubroutineType(types: !184)
!184 = !{!11, !29, !35, !11}
!185 = !DISubprogram(name: "ftell", scope: !182, file: !182, line: 689, type: !186, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !2)
!186 = !DISubroutineType(types: !187)
!187 = !{!35, !29}
