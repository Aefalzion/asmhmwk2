.data
str:
.string "%d "
nstr:
.string "\n"
eqstr:
.string "Equal!\n"
foundstr:
.string "%d is at (%d)!\n"
.text
.globl main
.type main, @function
main:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp, %ebp
	subl	$80, %esp
	movl	$10, %ecx
	movl	%esp, %edi
	movl	$0, %eax
lp:
	addl 	$1, %eax
	stosl
	loop 	lp
	

	movl 	$10, %ecx
	movl 	%esp, %esi 
lp1:
	lodsl
	pushl	%ecx
	pushl	%eax
	pushl	$str
	call 	printf
	addl	$8, %esp
	popl	%ecx
	loop 	lp1
	
	movl 	$10, %ecx
	movl	%esp, %edi
	movl	%esp, %esi
	addl	$40, %edi
	rep		movsl
	
	pushl	$nstr
	call 	printf
	addl	$4, %esp

	movl 	$10, %ecx
	movl 	%esp, %esi
	addl	$40, %esi
lp2:
	lodsl
	pushl	%ecx
	pushl	%eax
	pushl	$str
	call 	printf
	addl	$8, %esp
	popl	%ecx
	loop 	lp2

	movl 	$10, %ecx
	movl	%esp, %esi
	movl	%esp, %edi
	addl	$40, %edi
	repe 	cmpsl

	cmpl	$0, %ecx
	jne ne1
	pushl	$eqstr
	call	printf
	addl	$4, %esp
ne1:
	
	movl	$5,	%eax
	movl	$10, %ecx
	movl	%esp, %edi
	repne	scasl
	
	pushl	%edi
	pushl	$5
	pushl	$foundstr
	call 	printf
	add 	$12, %esp


	movl	$1,	%eax
	movl	$10, %ecx
	movl	%esp, %edi
	repne	scasl
	
	pushl	%edi
	pushl	$1
	pushl	$foundstr
	call 	printf
	add 	$12, %esp

	movl	$0, %eax
	movl	%ebp, %esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret
