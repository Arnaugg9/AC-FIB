 .text
	.align 4
	.globl BuscarElemento
	.type BuscarElemento,@function
BuscarElemento:
        pushl 	%ebp
		movl	%esp, %ebp
		pushl	%esi

		movl	16(%ebp), %ecx	
		imull	$12, (%ecx), %ecx		#12*(*mid)
		movl 	32(%ebp), %esi			#%ecx = @v
		movl	4(%esi, %ecx), %ecx		#%ecx = v[*mid].k

if:		cmpl	24(%ebp), %ecx			#X.k == v[*mid].k ?
		jne 	else
		movl	16(%ebp), %eax			#%eax = mid
		movl	(%eax), %eax			#%eax = *(mid)
		jmp 	end

else:	movl	12(%ebp), %ecx			#%ecx = high
		movl	(%ecx), %ecx			#%ecx = *(high)
		movl	16(%ebp), %edx			#%edx = mid

if2:	cmpl	%ecx, (%edx)
		jge		else2
		movl	%ecx, (%edx)			#*mid = *high
		movl 	8(%ebp), %ecx			#%ecx = low
		incl	(%ecx)
		movl	$-1, %eax				#%eax = -1
		jmp 	end

else2:	movl	8(%ebp), %eax			#%eax = low
		movl	(%eax), %eax			#%eax = *low
		movl 	%eax, (%edx)			#*mid = *low
		movl 	12(%ebp), %ecx			#%ecx = high
		decl 	(%ecx)
		movl 	$-1, %eax

end:	popl	%esi
		movl	%ebp, %esp
		popl 	%ebp
		ret