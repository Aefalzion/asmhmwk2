.data
.text
.globl 	sum1
.type 	sum1, @function
sum1:
	pushl	%ebp
	pushl 	%ebx
	movl	%esp, %ebp
	movl	$0, %eax
	movl	%ebp, %ebx
	addl	$12, %ebx
	movl	(%ebx), %ebx
loop1:
	cmpl	$0, (%ebx)
	je		loop1_end
	addl	(%ebx), %eax
	addl	$4, %ebx
	jmp		loop1
loop1_end:
	movl	%ebp, %esp
	popl	%ebx
	popl	%ebp
	ret

.globl	sum2
.type	sum2, @function
sum2:
	pushl	%ebp
	pushl	%ebx
	movl	%esp, %ebp
	movl	%ebp, %ebx
	addl	$12, %ebx
	movl	(%ebx), %ebx
	fldz
	
loop2:
	cmpl 	$0, (%ebx)
	je 		end_loop2
	flds	(%ebx)
	faddp	%st, %st(1)
	addl	$4, %ebx
	jmp 	loop2
end_loop2:

	
	movl	%ebp, %esp
	popl	%ebx
	popl	%ebp
	ret
