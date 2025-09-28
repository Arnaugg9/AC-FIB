 .text
	.align 4
	.globl Buscar
	.type Buscar,@function
Buscar:
        pushl 	%ebp
		movl	%esp, %ebp
		subl	$16, %esp
		pushl	%ebx

		movl	$-1, %ebx			#trobat = -1
		movl	$0, -16(%ebp)		#low = 0
		movl	-16(%ebp), %ecx		#%ecx <- low
		movl	%ecx, -8(%ebp)		#mid = low
		movl	24(%ebp), %edx		#edx <- N
		decl	%edx
		movl	%edx, -12(%ebp)		#high = N-1

while:	cmpl 	%ecx, -12(%ebp)
		jl		end
		pushl	8(%ebp)				#&v
		pushl	20(%ebp)			#X.m 
		pushl	16(%ebp)			#X.k
		movsbl	12(%ebp), %eax
		pushl	%eax				#X.c
		leal	-8(%ebp), %eax
		pushl	%eax				#&mid
		leal	-12(%ebp), %eax
		pushl	%eax				#&high
		leal	-16(%ebp), %eax
		pushl	%eax				#&low
		call	BuscarElemento
		addl	$28, %esp

		movl	%eax, %ebx			#trobat = (return)

if:		cmpl	$0, %ebx
		jl		while

end:	movl	%ebx, -4(%ebp)
		movl	%ebx, %eax

		popl	%ebx
		movl	%ebp, %esp
		popl 	%ebp
		ret
