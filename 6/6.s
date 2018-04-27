.data				
string:
.space 101
okstr:
.string "String contains only numbers and latin characters\n"
notokstr:
.string "String contains smthg that is not a number or latin character\n"
infostr:
.string "Rule #2: changes 1->a, 2->b, etc and reverses the text\n"
newstr:
.string "\n"
.text
.global main
.type main, @function

check_char:	#eax-input, ebx-output
	cmpb	$'0', %al
	jl		notnum
	cmpb	$'9', %al
	jg		notnum
	ret
	notnum:

	cmpb	$'a', %al
	jl		notsmall
	cmpb	$'z', %al
	jg		notsmall
	ret
	notsmall:

	cmpb	$'A', %al
	jl		notbig
	cmpb	$'Z', %al
	jg		notbig
	ret
	notbig:
	
	movl	$0, %ebx
	ret

scan:
	movl	$string, %ebx

scan_loop:
	call	getchar
	cmpb	$'.', %al
	je		scan_loop_end
	cmpb	$0, %al
	je		scan_loop_end
	movb	%al, (%ebx)
	addl	$1, %ebx
	jmp 	scan_loop
scan_loop_end:
	movl	$0, (%ebx)
	ret

rule11:
	cmpb	$'1', %al 
	jl		rule1_notnumber
	cmpb 	$'9', %al
	jg		rule1_notnumber
	subb	$'1', %al
	addb	$'a', %al
	rule1_notnumber:
	ret

rule1:					#rule1 - change 1->a, 2->b, 3->c, etc
	movl	4(%esp),	%ecx
rule1_loop:
	cmpb	$0, (%ecx)
	je		rule1_loop_end
	movb	(%ecx), %al
	call 	rule11
	movb	%al, (%ecx)
	addl	$1, %ecx
	jmp		rule1_loop
rule1_loop_end:
	ret

rule2:					#rule2 - reverse text without using additional memory
	movl	4(%esp), %ecx
	movl	%ecx, %edx
notz:
	cmpb 	$0, (%edx)
	je 		z
	addl	$1, %edx
	jmp notz
z:
	subl	$1, %edx

rule2_loop:
	cmpl	%ecx, %edx
	jle 	rule2_loop_end
	movb	(%edx), %al
	movl 	%eax, %ebx
	movb	(%ecx), %al
	movb	%al, (%edx)
	movl	%ebx, %eax
	movb	%al, (%ecx)
	addl	$1, %ecx
	subl	$1, %edx
	jmp		rule2_loop
rule2_loop_end:

	ret

main:
	pushl 	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp, %ebp
	
	call 	scan
	
	pushl	$string
	call 	printf
	pushl	$newstr
	call	printf
	
	addl	$8, %esp
	
	movl	$1, %ebx
	movl	$string, %ecx
check_loop:
	cmpb	$0, (%ecx)
	je 		check_loop_end
	movb	(%ecx), %al
	call 	check_char
	addl	$1, %ecx
	jmp		check_loop
check_loop_end:
	
	cmpl	$1, %ebx
	je 		ok
	pushl	$notokstr
	call	printf
	jmp e
	ok:
	pushl	$okstr
	call	printf
	e:
	
	addl	$4, %esp
	
	pushl	$string
	call 	rule1
	addl	$4, %esp

	pushl	$string
	call	rule2
	addl	$4, %esp

	pushl	$string
	call 	printf
	pushl	$newstr
	call 	printf

	pushl	$infostr
	call 	printf

	movl	$0, %eax
	movl	%ebp, %esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret
