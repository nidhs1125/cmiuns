; ModuleID = 'assign.c'
source_filename = "assign.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


define dso_local i32 @main() #0 {
    %pa=alloca [10 x i32], align 16 ;alloc space for array a
    %pa0=getelementptr inbounds [10 x i32],[10 x i32]* %pa,i32 0,i32 0 ;*pa0=a[0]
    store i32 10,i32* %pa0,align 16 ;a[0]=*pa0=10
    %tmp1=load i32,i32* %pa0,align 16 ;tmp1=a[0]=10
    %tmp2=mul nsw i32 %tmp1,2 ;tmp2=2*tmp1=2*a[0]=10
    %pa1=getelementptr inbounds [10 x i32],[10 x i32]* %pa,i32 0,i32 1 ;*pa1=a[1]
    store i32 %tmp2,i32* %pa1,align 4 ;*pa1=a[1]=tmp2=20
    %re=load i32,i32* %pa1,align 4 ;re=*pa1=a[1]=20
    ret i32 %re ;return re
    
}

attributes #0={noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false"}

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}