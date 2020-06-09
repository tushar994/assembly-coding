.global _start

.text

_start:
	#this is the part that has the input
#	mov $30,%rbx #this has A
#	mov $15,%rcx #this has B
	#only change the code above, and nothing else	


	mov %rbx,%r9 #this stores a copy of A
	mov %rcx,%r11#this stores a copy of B
comp:
	cmp %rcx,%rbx #this compares A and B reg values
	jg noswitch #this switches them if rcx is greater than rbx

switch:
	#this part switches them

	mov %rbx,%r10
	mov %rcx,%rbx
	mov %r10,%rcx
	#after this part, it is guaranteed that they are such that rbx>=rcx
noswitch:
	mov %rbx,%rax
	xor %rdx,%rdx#prepares for division
	div %rcx #divide %rbx by %rcx(A/B)
	mov %rdx,%rbx
	cmp $0,%rdx
	jne switch #if not done, then switch rbx and rcx and do it again
	#code now has, rcx as gcd, rbx is zero
	#if done, then store A/gcd in r9 and rcx, store B in rbx and find gcd
	cmp $1,%rcx#if gcd is 1, then we have th final answer
	je done
	xor %rdx,%rdx	#else, we divide r9 by gcd, and do the whole thing
	#again with rbx as r9, and rcx as teh original value
	mov %r9,%rax
	div %rcx
	mov %rax,%r9
	mov %r9,%rbx
	mov %r11,%rcx
	#if r9 is one, then also we are done
	cmp $1,%r9
	je done
	jmp comp
done:
	mov %r9,%rax#mov ans into rax
	xor %r9,%r9#set r9 as 0
#this part finds the sum of the digits
sumofdig:
	
	mov $10,%rcx #set rcx as 10
	
	xor %rdx,%rdx#sets rdx as 0
	div %rcx #divides rax with 10
	add %rdx,%r9 #adds remainder to r9
	xor %rdx,%rdx
	cmp $0,%rax#if rax is 0 end loop
	jne sumofdig

	mov %r9,%rdx #final answer was in r9, is now in rdx
exit:
        mov $60, %rax
        syscall
