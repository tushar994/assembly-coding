.global _start

.text

_start:
#You may change the values stored in these registers


	mov $11, %r8 # R8 IS A
	mov $50, %r9 #r9 is N
	mov $9, %r10 #r10 is B


#please don't change anything else
	mov %r8,%rcx #these are done because this code was made before the clarification.
	mov %r9, %r8
	mov %r10, %r9
	mov $1, %rbx #rbx is ACC
	mov %rcx,%rax #preparing for div
	xor %rdx,%rdx #making rdx zero
	div %r8
	mov %rdx,%rcx #A=A%n
	
	xor %rdx,%rdx #reset rax,rdx
	xor %rax, %rax
	
	mov $2,%r10 #putting 2 into r10	
loop:
	mov %r9,%rax #preparing for division
	div %r10
	cmp $0,%rdx #seeing if b is divisible by 2
	je notgonnamult #if not then dont multiply a
	
	xor %rax,%rax #reset rax,rdx
	xor %rdx,%rdx
	
	mov %rbx,%rax
	mul %rcx
	mov %rax,%rbx #acc=acc*a

	xor %rax,%rax #reset rax,rdx
	xor %rdx,%rdx


	mov %rbx,%rax #preparing for div
	div %r8 
        mov %rdx,%rbx #Acc=Acc%n

notgonnamult:  
	
	xor %rdx,%rdx #reset rax,rdx
        xor %rax, %rax	
	
	mov %r9,%rax
	div %r10
	mov %rax,%r9 #b=b/2
	
	xor %rdx,%rdx #reset rax,rdx
	xor %rax,%rax
        
        mov %rcx,%rax
        mul %rcx
        mov %rax,%rcx #a=a*a

        xor %rax,%rax #reset rax,rdx
        xor %rdx,%rdx


	mov %rcx,%rax
	div %r8
	mov %rdx,%rcx #a=a%n
	
	xor %rdx,%rdx #reset rax,rdx
	xor %rax,%rax
	
	cmp $0,%r9 #check if b=0, if not, then repeat loop
	jne loop

	mov %rbx,%rdi #ans moved to rdi	


exit:
        mov     $60, %rax               # system call 60 is exit
        syscall

