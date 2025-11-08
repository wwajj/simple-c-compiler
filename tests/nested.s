	.data
	.comm h,8
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

	# moving argument 2 to local var
	movq %rdx, -24(%rbp)

	# push 10
	movq $10,%rbx

	# assigning to local var
	movq %rbx, -32(%rbp)

	# push 11
	movq $11,%rbx

	# assigning to global var
	movq %rbx, h

	# push 2
	movq $2,%rbx

	# push local var
	movq -8(%rbp), %r10

	# *
	imulq %r10,%rbx

	# push local var
	movq -8(%rbp), %r10

	# *
	imulq %r10,%rbx

	# push 4
	movq $4,%r10

	# push local var
	movq -16(%rbp), %r13

	# push local var
	movq -24(%rbp), %r14

	# -
	subq %r14,%r13

	# *
	imulq %r13,%r10

	# push local var
	movq -32(%rbp), %r13

	# *
	imulq %r13,%r10

	# -
	subq %r10,%rbx

	# push global var
	movq h, %r10

	# -
	subq %r10,%rbx
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

	#top=0

	# push string "compute=%d\n" top=0
	movq $string0, %rbx

	# push 1
	movq $1,%r10

	# push 2
	movq $2,%r13

	# push 3
	movq $3,%r14
     # func=compute nargs=3
     # Move values from reg stack to reg args
	movq %r14, %rdx
	movq %r13, %rsi
	movq %r10, %rdi
	call compute
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
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
	.string "compute=%d\n"

