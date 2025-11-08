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


	# push 8
	movq $8,%rbx

	# push 20
	movq $20,%r10

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

	# assigning to local var
	movq %rbx, -16(%rbp)
loop_start_0:

	# push local var
	movq -16(%rbp), %rbx

	# push 20
	movq $20,%r10

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
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
	jmp loop_start_0
loop_statement_start_0:

	# push local var
	movq -16(%rbp), %rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push 3
	movq $3,%r10

	# push local var
	movq -16(%rbp), %r13

	# *
	imulq %r13,%r10
	movq %r10, (%rbx)
	jmp loop_assignment_0
loop_end_0:
	#top=0

	# push string "Ok so far\n" top=0
	movq $string0, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
loop_start_2:

	# push local var
	movq -16(%rbp), %rbx

	# push 20
	movq $20,%r10

	# <
	cmpq %r10, %rbx
	jl less_3
	movq $0, %rbx
	jmp relation_end_3
less_3:
	movq $1, %rbx
relation_end_3:
	cmpq $0, %rbx
	je loop_end_2
	jne loop_statement_start_2
loop_assignment_2:
loop_continue_2:

	# push local var
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
	jmp loop_start_2
loop_statement_start_2:
	#top=0

	# push string "%d: %d\n" top=0
	movq $string1, %rbx

	# push local var
	movq -16(%rbp), %r10

	# push local var
	movq -16(%rbp), %r13

	# setting offset for non-char array
	imulq $8, %r13

	# push local var array
	movq -8(%rbp), %r14
	addq %r14, %r13
	movq (%r13), %r13
     # func=printf nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	jmp loop_assignment_2
loop_end_2:
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
	.string "Ok so far\n"

string1:
	.string "%d: %d\n"

