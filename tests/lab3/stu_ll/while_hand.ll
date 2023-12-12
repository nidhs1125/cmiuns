; ModuleID = 'gcd_array.c'
source_filename = "gcd_array.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

define dso_local i32 @main() #0 {
	%pa=alloca i32,align 4 ;alloc for a
    %pi=alloca i32,align 4 ;alloc for i
    store i32 10,i32* %pa,align 4 ;*pa=a=10
    store i32 0,i32* %pi,align 4 ;*pi=i=0
    br label %loop ;go to loop

loop:
	%i=load i32,i32* %pi,align 4 ;i=*pi
    %b=icmp slt i32 %i,10 ;compare i with 10,b=i<10
    br i1 %b,label %block,label %retu ;jump to bock if b=1,else jump to retu

block:
	%tmp1=add nsw i32 %i,1 ;tmp=i+1
    store i32 %tmp1,i32* %pi,align 4 ;*pi=i=tmp=i+1
    %a=load i32,i32* %pa,align 4 ;a=*pa
    %tmp2=load i32,i32* %pi,align 4 ;tmp2=*pi=i
    %a2=add nsw i32 %a,%tmp2 ;a2=tmp2+a=a+i
    store i32 %a2,i32* %pa,align 4 ;a=*pa=a2=a+i
    br label %loop ;return to loop

retu:
	%re=load i32,i32* %pa,align 4 ;re=*pa=a
    ret i32 %re
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}