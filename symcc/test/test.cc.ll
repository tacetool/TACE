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
@str = private unnamed_addr constant [17 x i8] c"Failed to read x\00", align 1

; Function Attrs: norecurse nounwind readnone uwtable willreturn
define dso_local i32 @foo(i32 %0, i32 %1) local_unnamed_addr #0 !dbg !7 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !12, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.value(metadata i32 %1, metadata !13, metadata !DIExpression()), !dbg !14
  %3 = shl nsw i32 %0, 1, !dbg !15
  %4 = icmp slt i32 %3, %1, !dbg !17
  br i1 %4, label %10, label %5, !dbg !18

5:                                                ; preds = %2
  %6 = srem i32 %0, %1, !dbg !19
  %7 = icmp eq i32 %6, 0, !dbg !19
  %8 = select i1 %7, i32 %0, i32 0, !dbg !21
  %9 = add nsw i32 %8, %1, !dbg !21
  ret i32 %9, !dbg !21

10:                                               ; preds = %2
  ret i32 %0, !dbg !22
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr #2 !dbg !23 {
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata i32 %0, metadata !30, metadata !DIExpression()), !dbg !95
  call void @llvm.dbg.value(metadata i8** %1, metadata !31, metadata !DIExpression()), !dbg !95
  %4 = bitcast i32* %3 to i8*, !dbg !96
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #6, !dbg !96
  %5 = getelementptr inbounds i8*, i8** %1, i64 1, !dbg !97
  %6 = load i8*, i8** %5, align 8, !dbg !97, !tbaa !98
  %7 = tail call %struct._IO_FILE* @fopen(i8* %6, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0)), !dbg !102
  call void @llvm.dbg.value(metadata %struct._IO_FILE* %7, metadata !33, metadata !DIExpression()), !dbg !95
  call void @llvm.dbg.declare(metadata i32* undef, metadata !94, metadata !DIExpression()), !dbg !103
  call void @llvm.dbg.value(metadata i32* %3, metadata !32, metadata !DIExpression(DW_OP_deref)), !dbg !95
  %8 = call i64 @fread(i8* nonnull %4, i64 4, i64 1, %struct._IO_FILE* %7), !dbg !104
  %9 = icmp eq i64 %8, 1, !dbg !106
  br i1 %9, label %12, label %10, !dbg !107

10:                                               ; preds = %2
  %11 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([17 x i8], [17 x i8]* @str, i64 0, i64 0)), !dbg !108
  br label %24, !dbg !110

12:                                               ; preds = %2
  %13 = load i32, i32* %3, align 4, !dbg !111, !tbaa !112
  call void @llvm.dbg.value(metadata i32 %13, metadata !32, metadata !DIExpression()), !dbg !95
  call void @llvm.dbg.value(metadata i32 %13, metadata !12, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.value(metadata i32 7, metadata !13, metadata !DIExpression()), !dbg !114
  %14 = icmp slt i32 %13, 4, !dbg !116
  br i1 %14, label %20, label %15, !dbg !117

15:                                               ; preds = %12
  %16 = urem i32 %13, 7, !dbg !118
  %17 = icmp eq i32 %16, 0, !dbg !118
  %18 = add nuw i32 %13, 7, !dbg !119
  %19 = select i1 %17, i32 %18, i32 7, !dbg !119
  br label %20, !dbg !119

20:                                               ; preds = %12, %15
  %21 = phi i32 [ %19, %15 ], [ %13, %12 ]
  %22 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0), i32 %13, i32 %21), !dbg !120
  %23 = tail call i32 @fclose(%struct._IO_FILE* %7), !dbg !121
  br label %24, !dbg !122

24:                                               ; preds = %20, %10
  %25 = phi i32 [ -1, %10 ], [ 0, %20 ], !dbg !95
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #6, !dbg !123
  ret i32 %25, !dbg !123
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: nofree nounwind
declare dso_local noalias noundef %struct._IO_FILE* @fopen(i8* nocapture noundef readonly, i8* nocapture noundef readonly) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare dso_local noundef i64 @fread(i8* nocapture noundef, i64 noundef, i64 noundef, %struct._IO_FILE* nocapture noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare !dbg !124 dso_local noundef i32 @fclose(%struct._IO_FILE* nocapture noundef) local_unnamed_addr #4

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: nofree nounwind
declare noundef i32 @puts(i8* nocapture noundef readonly) local_unnamed_addr #5

attributes #0 = { norecurse nounwind readnone uwtable willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nofree nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nofree nosync nounwind willreturn }
attributes #4 = { nofree nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree nounwind }
attributes #6 = { nounwind }

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
