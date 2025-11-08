	.data
	.comm g,8
	.text
.globl compute
compute:
	# Save Frame pointer
	pushq %rbp
	movq %rsp,%rbp
	subq $256, %rsp
# Save registers. 
# Push one extra to align stack to 16bytes
	pushq %rbx
	pushq %rbx
	pushq %r10
	pushq %r13
	pushq %r14
	pushq %r15


	# moving argument 0 to local var
	movq %rdi, -8(%rbp)

	# moving argument 1 to local var
	movq %rsi, -16(%rbp)

	# push global var
	movq g, %rbx

	# push 9
	movq $9,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -24(%rbp)

	# push local var
	movq -8(%rbp), %rbx

	# push local var
	movq -16(%rbp), %r10

	# +
	addq %r10,%rbx

	# push local var
	movq -24(%rbp), %r10

	# *
	imulq %r10,%rbx

	# assigning to local var
	movq %rbx, -32(%rbp)

	# push local var
	movq -32(%rbp), %rbx
	movq %rbx, %rax
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	popq %rbx
	addq $256, %rsp
	leave
	ret
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	popq %rbx
	addq $256, %rsp
	leave
	ret
	.text
.globl main
main:
	# Save Frame pointer
	pushq %rbp
	movq %rsp,%rbp
	subq $256, %rsp
# Save registers. 
# Push one extra to align stack to 16bytes
	pushq %rbx
	pushq %rbx
	pushq %r10
	pushq %r13
	pushq %r14
	pushq %r15


	# push 9
	movq $9,%rbx

	# assigning to global var
	movq %rbx, g

	# push 2
	movq $2,%rbx

	# push 5
	movq $5,%r10
     # func=compute nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call compute
	movq %rax, %rbx

	# assigning to local var
	movq %rbx, -8(%rbp)
	#top=0

	# push string "j=%d g=%d\n" top=0
	movq $string0, %rbx

	# push local var
	movq -8(%rbp), %r10

	# push global var
	movq g, %r13
     # func=printf nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	popq %rbx
	addq $256, %rsp
	leave
	ret
string0:
	.string "j=%d g=%d\n"

