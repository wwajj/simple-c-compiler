	.text
.globl sum
sum:
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

	# push 0
	movq $0,%rbx

	# assigning to local var
	movq %rbx, -32(%rbp)

	# push 0
	movq $0,%rbx

	# assigning to local var
	movq %rbx, -24(%rbp)
loop_start_0:

	# push local var
	movq -24(%rbp), %rbx

	# push local var
	movq -8(%rbp), %r10

	# <
	cmpq %r10, %rbx
	jl less_1
	movq $0, %rbx
	jmp relation_end_1
less_1:
	movq $1, %rbx
relation_end_1:
	cmpq $0, %rbx
	je loop_end_0
	jne loop_statement_start_0
loop_assignment_0:
loop_continue_0:

	# push local var
	movq -24(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -24(%rbp)
	jmp loop_start_0
loop_statement_start_0:

	# push local var
	movq -32(%rbp), %rbx

	# push local var
	movq -24(%rbp), %r10

	# setting offset for non-char array
	imulq $8, %r10

	# push local var array
	movq -16(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -32(%rbp)
	jmp loop_assignment_0
loop_end_0:

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


	# push 5
	movq $5,%rbx

	# push 8
	movq $8,%r10

	# *
	imulq %r10,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx

	# assigning to local var
	movq %rbx, -8(%rbp)

	# push 0
	movq $0,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push 4
	movq $4,%r10
	movq %r10, (%rbx)

	# push 1
	movq $1,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push 3
	movq $3,%r10
	movq %r10, (%rbx)

	# push 2
	movq $2,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push 1
	movq $1,%r10
	movq %r10, (%rbx)

	# push 3
	movq $3,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push 7
	movq $7,%r10
	movq %r10, (%rbx)

	# push 4
	movq $4,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push 6
	movq $6,%r10
	movq %r10, (%rbx)

	# push 5
	movq $5,%rbx

	# push local var
	movq -8(%rbp), %r10
     # func=sum nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call sum
	movq %rax, %rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
	#top=0

	# push string "sum=%d\n" top=0
	movq $string0, %rbx

	# push local var
	movq -16(%rbp), %r10
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
	.string "sum=%d\n"

