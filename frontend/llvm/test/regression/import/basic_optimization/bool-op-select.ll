; ModuleID = 'bool-op-select.cpp.pp.bc'
source_filename = "bool-op-select.cpp"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

; CHECK-LABEL: Bundle
; CHECK: target-endianness = little-endian
; CHECK: target-pointer-size = 64 bits
; CHECK: target-triple = x86_64-apple-macosx10.13.0

@a = global i32 0, align 4, !dbg !0
; CHECK: define si32* @a, align 4, init {
; CHECK: #1 !entry !exit {
; CHECK:   store @a, 0, align 1
; CHECK: }
; CHECK: }

; Function Attrs: noinline norecurse nounwind ssp uwtable
define i32 @main() #0 !dbg !12 {
  %1 = load i32, i32* @a, align 4, !dbg !15
  %2 = icmp sgt i32 %1, 0, !dbg !16
  br i1 %2, label %3, label %4, !dbg !15

; <label>:3:                                      ; preds = %0
  br label %5, !dbg !15

; <label>:4:                                      ; preds = %0
  br label %5, !dbg !15

; <label>:5:                                      ; preds = %4, %3
  %6 = phi i32 [ 123, %3 ], [ 321, %4 ], !dbg !15
  ret i32 %6, !dbg !17
}
; CHECK: define si32 @main() {
; CHECK: #1 !entry successors={#2, #3} {
; CHECK:   si32 %1 = load @a, align 4
; CHECK: }
; CHECK: #2 predecessors={#1} successors={#4} {
; CHECK:   %1 sigt 0
; CHECK:   si32 %2 = 123
; CHECK: }
; CHECK: #3 predecessors={#1} successors={#4} {
; CHECK:   %1 sile 0
; CHECK:   si32 %2 = 321
; CHECK: }
; CHECK: #4 !exit predecessors={#2, #3} {
; CHECK:   return %2
; CHECK: }
; CHECK: }

attributes #0 = { noinline norecurse nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9, !10}
!llvm.ident = !{!11}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 8, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !3, producer: "clang version 7.0.0 (tags/RELEASE_700/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "bool-op-select.cpp", directory: "/Users/marthaud/ikos/ikos-git/frontend/llvm/test/regression/import/basic_optimization")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{i32 7, !"PIC Level", i32 2}
!11 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!12 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 10, type: !13, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !2, retainedNodes: !4)
!13 = !DISubroutineType(types: !14)
!14 = !{!6}
!15 = !DILocation(line: 11, column: 10, scope: !12)
!16 = !DILocation(line: 11, column: 12, scope: !12)
!17 = !DILocation(line: 11, column: 3, scope: !12)
