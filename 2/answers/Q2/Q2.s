.global _start

.text

_start:
#change the value going into r8 here, to change the input, i.e. input is in r8
	mov $99, %r8 #this is the input
#please don't change anything else
	
	mov %r8, %rcx #as, you told to put x in %r8 long after i had made this code.
	mov $1, %rbx #putting i into rbx
	mov %rbx,%rsi #putting starting value into rsi, which contains fib
	cmp $1, %rcx #compares rcx and 1, if they are equal, then ends the program, as the answer is one
	je divide 
test:	
	add $1,%rbx # adding 1 to rbx every test
	

	mov %rsi, %rax
	mul %rbx
	mov %rax, %rsi #this block updates the fibonacci value in rsi
	xor %rax,%rax
	xor %rdx,%rdx
	
	mov %rsi, %rax #prepares for division 
	div %rcx #divides fac by number
	cmp $0,%rdx
	je divide #when teh remainder is zero, you're done!!
	
	#this is when it is not zero
	xor %rax, %rax #resents rax and rdx
	xor %rdx, %rdx
	jmp test #keeps the loop running
	#this is the end of the case that the remainder is not zero


divide:
	mov %rbx, %rdi #ans is in rbx, this puts it into rdi


exit:
	mov $60, %rax	
	syscall

