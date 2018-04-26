	.file	"test.c"
	.globl	a
	.data
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.long	1084227584
	.globl	b
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	1092616192
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	flds	a
	flds	b
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	.L6
	movl	$1, %eax
	jmp	.L4
.L6:
	movl	$0, %eax
.L4:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
