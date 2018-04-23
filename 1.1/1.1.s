	.text
	.globl	main
	.type	main, @function
main:
	pushl 	%edx
	pushl 	%ecx
	pushl 	%ebx
	pushl 	%ebp
	movl	%esp, %ebp

	subl	$16, %esp
	movl	$100, -12(%ebp)
	movl	$3, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%eax, %ecx
	sarl	%cl, %edx		#двоичный сдвиг вправо
	movl	-8(%ebp), %eax
	movl	%eax, %ecx
	sall	%cl, %edx		#двоичный сдвиг влево
	movl	%edx, %eax
	andl	-12(%ebp), %eax	#побитовое и
	orl 	-8(%ebp), %eax  #побитовое или
	movl	%eax, -4(%ebp)
	movl	$0, %eax
	
	movl 	%ebp, %esp
	popl 	%ebp
	popl 	%ebx
	popl 	%ecx
	popl 	%edx
	ret
