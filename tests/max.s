	.text
.globl max
max:
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

	# setting offset for non-char array
	imulq $8, %rbx

	# push local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx

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
	movq -16(%rbp), %r10

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
	movq -8(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10

	# <
	cmpq %r10, %rbx
	jl less_2
	movq $0, %rbx
	jmp relation_end_2
less_2:
	movq $1, %rbx
relation_end_2:
if_3:
	cmpq $0, %rbx
	je if_end_3

	# push local var
	movq -24(%rbp), %rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# push local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx

	# assigning to local var
	movq %rbx, -32(%rbp)
	jmp if_end_end_3
if_end_3:
if_end_end_3:
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
	.data
	.comm a,8
	.data
	.comm n,8
	.data
	.comm i,8
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


	# push 10
	movq $10,%rbx

	# assigning to global var
	movq %rbx, n

	# push 10
	movq $10,%rbx

	# push 8
	movq $8,%r10

	# *
	imulq %r10,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx

	# assigning to global var
	movq %rbx, a

	# push 0
	movq $0,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 8
	movq $8,%r10
	movq %r10, (%rbx)

	# push 1
	movq $1,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 7
	movq $7,%r10
	movq %r10, (%rbx)

	# push 2
	movq $2,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 1
	movq $1,%r10
	movq %r10, (%rbx)

	# push 3
	movq $3,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 9
	movq $9,%r10
	movq %r10, (%rbx)

	# push 4
	movq $4,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 11
	movq $11,%r10
	movq %r10, (%rbx)

	# push 5
	movq $5,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 83
	movq $83,%r10
	movq %r10, (%rbx)

	# push 6
	movq $6,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 7
	movq $7,%r10
	movq %r10, (%rbx)

	# push 7
	movq $7,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 13
	movq $13,%r10
	movq %r10, (%rbx)

	# push 8
	movq $8,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 94
	movq $94,%r10
	movq %r10, (%rbx)

	# push 9
	movq $9,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq a, %r10
	addq %r10, %rbx

	# push 1
	movq $1,%r10
	movq %r10, (%rbx)

	# push 0
	movq $0,%rbx

	# assigning to global var
	movq %rbx, i
loop_start_4:

	# push global var
	movq i, %rbx

	# push global var
	movq n, %r10

	# <
	cmpq %r10, %rbx
	jl less_5
	movq $0, %rbx
	jmp relation_end_5
less_5:
	movq $1, %rbx
relation_end_5:
	cmpq $0, %rbx
	je loop_end_4
	jne loop_statement_start_4
loop_assignment_4:
loop_continue_4:

	# push global var
	movq i, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to global var
	movq %rbx, i
	jmp loop_start_4
loop_statement_start_4:
	#top=0

	# push string "%d: %d\n" top=0
	movq $string0, %rbx

	# push global var
	movq i, %r10

	# push global var
	movq i, %r13

	# setting offset for non-char array
	imulq $8, %r13

	# push global var array
	movq a, %r14
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
	jmp loop_assignment_4
loop_end_4:
	#top=0

	# push string "n=%d\n" top=0
	movq $string1, %rbx

	# push global var
	movq n, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "max=%d\n" top=0
	movq $string2, %rbx

	# push global var
	movq a, %r10

	# push global var
	movq n, %r13
     # func=max nargs=2
     # Move values from reg stack to reg args
	movq %r13, %rsi
	movq %r10, %rdi
	call max
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
	.string "%d: %d\n"

string1:
	.string "n=%d\n"

string2:
	.string "max=%d\n"

