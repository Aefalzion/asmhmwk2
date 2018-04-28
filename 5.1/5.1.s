.macro flagsmacro
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %ebp
	movl %esp, %ebp
	
	pushf
	pushf
	popl %eax 

	movl (of), %ebx
	testl %ebx, %eax
	jne of1
	pushl $0
	jmp of2
	of1:
	pushl $1
	of2:
	
	movl (sf), %ebx
	testl %ebx, %eax
	jne sf1
	pushl $0
	jmp sf2
	sf1:
	pushl $1
	sf2:

	movl (zf), %ebx
	testl %ebx, %eax
	jne zf1
	pushl $0
	jmp zf2
	zf1:
	pushl $1
	zf2:

	movl (cf), %ebx
	testl %ebx, %eax
	jne cf1
	pushl $0
	jmp cf2
	cf1:
	pushl $1
	cf2:
	pushl $str
	call printf
	add $20, %esp
	popf
	
	movl	%ebp, %esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%eax
.endm

.data
cf:
.long 0x00000001
zf:
.long 0x00000040
sf:
.long 0x00000080
of:
.long 0x00000800
str:
.string "%d %d %d %d\n"
.text
.globl main
.type main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	
	flagsmacro
	
	movl	$0, %eax
	movl	%ebp, %esp
	popl	%ebp
	ret
