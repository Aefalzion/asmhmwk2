.data
intstr:
.string "%i\n"
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

safe_pf:
	subl	$10, %esp
	fstpl	(%esp)
	fldl	(%esp)
	pushl	$outputstr
	call 	printf
	addl	$14, %esp
	ret

pb:
	pushl	%ebx
	pushl	$intstr
	call	printf
	addl	$8, %esp
	ret

safe_comip:
	subl	$30, %esp
	fstpl	(%esp)
	fstpl	10(%esp)
	fldl	10(%esp)
	fldl	(%esp)
	fcomip
	ret

safe_comipr:
	fstpl	(%esp)
	fldl	10(%esp)
	addl	$30, %esp
	ret

main:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp, %ebp
	
	subl	$40, %esp


	movl	%esp, %eax
	call 	read_f
	movl	%esp, %eax
	addl	$10, %eax
	call 	read_f
	
	fld1
	flds	(%esp)
	fyl2x
	flds	10(%esp)
	fmul
	
	movl 	$0, %ebx
loop1:
	fld1
	call safe_comip
	jb 	end_loop1	
	call safe_comipr
	fld1
	fsubr
	addl	$1, %ebx
	jmp 	loop1
end_loop1:
	call safe_comipr
loop2:
	fldz
	fld1
	fsub
	call safe_comip
	jb		e
	call safe_comipr
	jmp end_loop2
	e:
	call safe_comipr
	fld1
	fadd
	subl	$1, %ebx
	jmp loop2
end_loop2:
	f2xm1	
	fld1
	fadd
	fldz
stp:
	pushl	%ebx
	pushl	$intstr
	call printf
	addl	$8, %esp
loop3:
	cmpl 	$0, %ebx
	jle 	end_loop3
	fld1
	fadd
	subl 	$1, %ebx
	jmp 	loop3
end_loop3:

loop4:
	cmpl 	$0, %ebx
	jge 	end_loop4
	fld1
	fsub
	addl 	$1, %ebx
	jmp 	loop4
end_loop4:
	
	fxch	%st(1)
	fscale
	
	

	fld1
	fld1
	fld1
	fld1
	faddp
	faddp
	faddp
	call 	print_f
	fstl	(%esp)
	movl	%ebp, %esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	movl	$0, %eax
	ret
