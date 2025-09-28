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
	movl	8(%ebp), %eax		#mata
	movl 	12(%ebp), %ebx		#matb
	movl 	16(%ebp), %ecx		#matc
	movl 	20(%ebp), %esi		#n

	imull	%esi, %esi
	addl 	%eax, %esi

for:
	cmp 	%eax, %esi
	jle		end_for

	movb	(%eax), %dl
	subb	(%ebx), %dl			#mata[i*n+j] - matb[i*n+j]

if:
	cmp		$0, %dl
	jle		else_if
	movb	$255, (%ecx)
	jmp		end_if

else_if:
	movb	$0, (%ecx)

end_if:
	incl 	%eax
	incl 	%ebx
	incl 	%ecx
	jmp 	for

end_for:
# El final de la rutina ya esta programado

	popl	%edi
	popl	%esi
	popl	%ebx
	movl 	%ebp,%esp
	popl 	%ebp
	ret
