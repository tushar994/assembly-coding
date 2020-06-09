.global _start

.text

_start:
	#thsi is for input
	#mov $9,%r9 #this is n
	#mov $9,%r10 #this is k
	#please only change the baove code and nothing else
	

	mov $0,%r11 #r11 is the final answer
	mov $1,%rbx
	mov $1,%rcx #so rcx contains the previous fib, rbx contains current fib

test:	
	cmp %rbx,%r9
	jl done #if rbx>=r9, then continue
	mov $1,%rax #rax will contain the result of the factorial
	mov %rbx,%r12 #we store number whose fact we want to find in r12
	xor %rdx,%rdx
fact:
	mul %r12 #multiply r12
	
	xor %rdx,%rdx
	
	div %r10 #to take mod by r10
	mov %rdx,%rax #mov moded value to rax
	
	xor %rdx,%rdx #set rdx
	
	sub $1,%r12 #subtact r12 by 1, so we can see if its the last number,
		#else multiply it to the factorial
	cmp $0,%r12 #if r12 is zero, then we are done	
	jne fact #if r12 is not zero, multiply it to the factorial

addandmod:
	add %rax,%r11 #we add the factorial to t he final answer
	mov %r11,%rax #we mov r11 to rax
	div %r10 #we divide r11 by r10
	mov %rdx,%r11 # set r11 and r11 mod r10

	xor %rax,%rax #set rax,rdx and 0
	xor %rdx,%rdx

	mov %rbx,%r12 #store rbx
	add %rcx,%rbx #update rbx as next fib value
	mov %r12,%rcx #set rcx as rbx
	cmp %rbx,%r9 #if rbx<= r9, then go back to text
	jge test

done:
	mov %r11,%rdx
exit:
        mov $60, %rax
        syscall
		

