.text
	.align 4
	.globl procesar
	.type	procesar, @function

procesar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi

# Aqui has de introducir el codigo
	movl		8(%ebp), %eax		#mata
	movl 		12(%ebp), %ebx		#matb
	movl 		16(%ebp), %ecx		#matc
	movl 		20(%ebp), %esi		#n

	imull		%esi, %esi
	addl 		%eax, %esi

for:
	cmp 		%eax, %esi
	jle			end_for

	movdqa 		(%eax), %xmm0
	movdqa 		(%ebx), %xmm1
	psubb		%xmm1, %xmm0		#mata[i*n+j] - matb[i*n+j]

	pxor		%xmm2, %xmm2
	pcmpgtb		%xmm2, %xmm0
	movdqa		%xmm0, (%ecx)
	
	addl 		$16, %eax
	addl 		$16, %ebx
	addl 		$16, %ecx
	jmp 		for

end_for:

# El final de la rutina ya esta programado

	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
