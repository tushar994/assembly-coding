.global _start

.text

_start:
	#input is
	#n is in %rbx
	#mov $6,%rbx
	#input array is in %rcx
	#output array is in %rdx
	#to initialise pointer
	
	
	mov $0,%rax
	#rax points to whichever 
	mov %rsp,%rdx
	mov (%rsp,%rbx,8),%rcx
	
	
	#to initialize output array
	#movq $4,(%rcx)
	#movq $4,8(%rcx)
	#movq $5,16(%rcx)
	#movq $2,24(%rcx)
	#movq $10,32(%rcx)
	#movq $8,40(%rcx)


outputinit:
	movq $-2,(%rdx,%rax,8) #this is a loop to initialize all
	add $1,%rax #values in output array as -2, i.e. undetermined so far
	cmp %rbx,%rax
	jl outputinit

	movq $-1,(%rdx) #we initialize ans[0] as -1, i.e. the first element has an answer -1 
	
	mov %rbx,%rax #this puts n-1 in rax, so we can call the function(n-1)
	sub $1,%rax

#this is a loop to call the function for every value from n-1 to 1 
#in decending order
looptocallfunction:
	pushq %rax #we store the value for which we call the function in the
	#stack. this is the only value we store in the stack
	#we call the function, putting indexs into it
	call function #we call the function
	
	popq %rax #we put the value we called the function with into rax
	sub $1,%rax #we dec rax
	cmp $0, %rax #we call the loop again if rax is greater than zero
	jg looptocallfunction
	jmp convertitoy #if rax is zero, then we have called the function

	# for all values possible, so we simply have to finish it off


#input array is in %rcx
#output array is in %rdx

#this is th functon we call on each index, to find the answer for each index
function:
	movq 8(%rsp),%r9
	mov %r9,%r10
	sub $1,%r9 #r9 has i-1, r10 has i where i is the index we called for 
	#the function
	cmp $-2,(%rdx,%r10,8)
	je notlite #if i's answer has already been found,then no need to contiue
	ret
#this is when the answer has not already been found
notlite:
	movq (%rcx,%r9,8),%r8
	cmp %r8,(%rcx,%r10,8) #here we cmp the value of arr[i-1] and arr[i]
	jg found #if arr[i]>arr[i-1], then the answer has been found
	#otherwise, we will check if arr[ans[i-1]]<arr[i]
	#NOTE: %r9 at this stage has i-1
ohwell:	
	cmp $-2,(%rdx,%r9,8)
	jne weknowit #we check if ans[%r9] has been found, if not, we call the
	#function(%r9) and find it
	push %r9 #we push %r9 so that we can call the functon(%r9)
	call function #we call the function
	pop %r9 #once it returns, ans[%r9] has been found
	mov 8(%rsp),%r10 #we reset r10 as i

#now we check if arr[ans[%r9]] < arr[i]
#if so, then ans[i]=arr[ans[%r9]]
#if not, we set %r9 as ans[%r9] and repeat
weknowit:
	mov (%rdx,%r9,8),%r12 #we mov ans[%r9] into r12
	cmp $-1,%r12 #if r12 is -1, then we know that ans[i]=-1
	je itz	
	mov (%rcx,%r12,8),%r8
	cmp %r8,(%rcx,%r10,8) #else, we check if arr[r12]<arr[i]
	jle fuckagain#if not, then we do whole thing again with the new r9
itz:
	mov %r12,%r9 #we know the answer is in r12, so we move it to r9 
	#and call a function that sets the ans[i]=%r9
	jmp found

fuckagain:
	mov %r12,%r9 #we set the new r9 and do the whole thing again
	jmp ohwell		
found:
	mov %r9,(%rdx,%r10,8) #we set the ans as r9
	ret

#we, so far have stored the indexs of the answers in the ans array, we convert 
#this to the actual values here
convertitoy:
	mov %rbx,%rax
	sub $1,%rax

okayletsgo:
	mov (%rdx,%rax,8),%r12
	cmp $-1,%r12 #if it is -1, then we dont need to convert to number
	je skip
	mov (%rcx,%r12,8),%r9#we the thing to its number
	mov %r9,(%rdx,%rax,8)
skip:
	sub $1,%rax
	cmp $0,%rax#we call the loop again for a lower index, untill all indexs
	#have been converted
	jg okayletsgo

#when the loop ends, we are done
exit:
	mov $60, %rax
	syscall	
