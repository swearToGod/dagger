# RUN: llvm-mc -triple x86_64--darwin -filetype=obj -o - %s | llvm-dec - -dc-translate-unknown-to-undef -enable-dc-reg-mock-intrin | FileCheck %s

## MOVMSKPDrr
# CHECK-LABEL: call void @llvm.dc.startinst
# CHECK-NEXT: [[RIP_0:%.+]] = call i64 @llvm.dc.getreg.i64(metadata !"RIP")
# CHECK-NEXT: [[V0:%.+]] = add i64 [[RIP_0]], 5
# CHECK-NEXT: call void @llvm.dc.setreg{{.*}} !"RIP")
# CHECK-NEXT: [[XMM9_0:%.+]] = call <4 x float> @llvm.dc.getreg.v4f32(metadata !"XMM9")
# CHECK-NEXT: [[V1:%.+]] = bitcast <4 x float> [[XMM9_0]] to i128
# CHECK-NEXT: [[V2:%.+]] = bitcast i128 [[V1]] to <2 x double>
# CHECK-NEXT: call void @llvm.trap()
movmskpd	%xmm9, %r8d

retq
