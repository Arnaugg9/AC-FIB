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

comprova_a:
    movl        %eax, %edi
    andl        $15, %edi
    cmpl        $0, %edi
    je          a_mult_16			#comprova si direccio mata es multiple de 16

    movdqu 		(%eax), %xmm0		#mata no es multiple de 16
    jmp comprova_b

a_mult_16: 
    movdqa 		(%eax), %xmm0		#mata es multiple de 16

comprova_b:
    movl        %ebx, %edi
    andl        $15, %edi
    cmpl        $0, %edi
    je          b_mult_16			#comprova si direccio matb es multiple de 16

    movdqu 		(%ebx), %xmm1		#matb no es multiple de 16
    jmp         body

b_mult_16:
	movdqa 		(%ebx), %xmm1		#matb es multiple de 16

body:
	
	psubb		%xmm1, %xmm0		#mata[i*n+j] - matb[i*n+j]

	pxor		%xmm2, %xmm2		#Tots bits de xmm2 = 0
	pcmpgtb		%xmm2, %xmm0		

comprova_c:
	movl        %ecx, %edi			
    andl        $15, %edi
    cmpl        $0, %edi
    je          c_mult_16			#comprova si direccio matc es multiple de 16

	movdqu		%xmm0, (%ecx)		#matc no es multiple de 16
	jmp			end_body

c_mult_16:
	movdqa		%xmm0, (%ecx)		#matc es multiple de 16

end_body:
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
	movl    %ebp,%esp
	popl    %ebp
	ret
