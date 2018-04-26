.data
inputstr:
.string "%f"
outputstr:
.string "%f\n"
number:
.float 	0
.text
.globl 	main
.type	main, @function
read_f:
	pushl 	%eax
	pushl 	$inputstr
	call 	scanf
	addl	$8, %esp
	ret

print_f:
	subl 	$10, %esp
	fstpl	(%esp)
	pushl	$outputstr
	call 	printf
	addl	$14, %esp
	ret

main:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp, %ebp
	
	fldz
	subl	$40, %esp

loop:

	movl	%esp, %eax
	call 	read_f
	flds	(%esp)
	fadd
	movl	(%esp), %ebx
	cmpl	$0, %ebx
	jne 	loop

	call 	print_f

	movl	%ebp, %esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	movl	$0, %eax
	ret
