; ModuleID = 'if.c'
source_filename = "if.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

define dso_local i32 @main() #0 {
	%pa=alloca float,align 4 ;alloc space for float
	store float 0x40163851E0000000,float* %pa,align 4 ;*pa=a=5.555
	%a=load float,float* %pa,align 4 ;a=*pa=5.555
	%b=fcmp ogt float %a,1.0 ;compare a and 1.0 use ogt,b=a>1.0
	br i1 %b,label %t,label %f ;if b=1,then jump to %t, else jump to %f
t:
	ret i32 233
f:
	ret i32 0	
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
;!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}