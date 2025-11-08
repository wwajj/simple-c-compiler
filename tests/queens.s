	.data
	.comm queens,8
	.data
	.comm solid,8
	.text
.globl abs
abs:
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

	# push local var
	movq -8(%rbp), %rbx

	# push 0
	movq $0,%r10

	# <
	cmpq %r10, %rbx
	jl less_0
	movq $0, %rbx
	jmp relation_end_0
less_0:
	movq $1, %rbx
relation_end_0:
if_1:
	cmpq $0, %rbx
	je if_end_1

	# push -1
	movq $-1,%rbx

	# push local var
	movq -8(%rbp), %r10

	# *
	imulq %r10,%rbx
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
	jmp if_end_end_1
if_end_1:
if_end_end_1:

	# push local var
	movq -8(%rbp), %rbx
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
.globl check
check:
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

	# push 0
	movq $0,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
loop_start_2:

	# push local var
	movq -16(%rbp), %rbx

	# push local var
	movq -8(%rbp), %r10

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

	# push local var
	movq -16(%rbp), %rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# push global var array
	movq queens, %r10
	addq %r10, %rbx
	movq (%rbx), %rbx

	# push local var
	movq -8(%rbp), %r10

	# setting offset for non-char array
	imulq $8, %r10

	# push global var array
	movq queens, %r13
	addq %r13, %r10
	movq (%r10), %r10

	# ==
	cmpq %r10, %rbx
	jne not_equal_4
	movq $1, %rbx
	jmp equality_end_4
not_equal_4:
	movq $0, %rbx
equality_end_4:

	# push local var
	movq -16(%rbp), %r10

	# setting offset for non-char array
	imulq $8, %r10

	# push global var array
	movq queens, %r13
	addq %r13, %r10
	movq (%r10), %r10

	# push local var
	movq -8(%rbp), %r13

	# setting offset for non-char array
	imulq $8, %r13

	# push global var array
	movq queens, %r14
	addq %r14, %r13
	movq (%r13), %r13

	# -
	subq %r13,%r10
     # func=abs nargs=1
     # Move values from reg stack to reg args
	movq %r10, %rdi
	call abs
	movq %rax, %r10

	# push local var
	movq -8(%rbp), %r13

	# push local var
	movq -16(%rbp), %r14

	# -
	subq %r14,%r13

	# ==
	cmpq %r13, %r10
	jne not_equal_5
	movq $1, %r10
	jmp equality_end_5
not_equal_5:
	movq $0, %r10
equality_end_5:

	# ||
	orq %r10, %rbx
if_6:
	cmpq $0, %rbx
	je if_end_6

	# push 0
	movq $0,%rbx
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
	jmp if_end_end_6
if_end_6:
if_end_end_6:
	jmp loop_assignment_2
loop_end_2:

	# push 1
	movq $1,%rbx
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
.globl bruteforce
bruteforce:
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

	# push local var
	movq -8(%rbp), %rbx

	# push 8
	movq $8,%r10

	# ==
	cmpq %r10, %rbx
	jne not_equal_7
	movq $1, %rbx
	jmp equality_end_7
not_equal_7:
	movq $0, %rbx
equality_end_7:
if_8:
	cmpq $0, %rbx
	je if_end_8
	#top=0

	# push string "Solution #%2ld = [ " top=0
	movq $string0, %rbx

	# push global var
	movq solid, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push global var
	movq solid, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to global var
	movq %rbx, solid

	# push 0
	movq $0,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
loop_start_9:

	# push local var
	movq -16(%rbp), %rbx

	# push 8
	movq $8,%r10

	# <
	cmpq %r10, %rbx
	jl less_10
	movq $0, %rbx
	jmp relation_end_10
less_10:
	movq $1, %rbx
relation_end_10:
	cmpq $0, %rbx
	je loop_end_9
	jne loop_statement_start_9
loop_assignment_9:
loop_continue_9:

	# push local var
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
	jmp loop_start_9
loop_statement_start_9:
	#top=0

	# push string "%ld " top=0
	movq $string1, %rbx

	# push local var
	movq -16(%rbp), %r10

	# setting offset for non-char array
	imulq $8, %r10

	# push global var array
	movq queens, %r13
	addq %r13, %r10
	movq (%r10), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	jmp loop_assignment_9
loop_end_9:
	#top=0

	# push string "]\n" top=0
	movq $string2, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
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
	jmp if_end_end_8
if_end_8:
if_end_end_8:

	# push 0
	movq $0,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
loop_start_11:

	# push local var
	movq -16(%rbp), %rbx

	# push 8
	movq $8,%r10

	# <
	cmpq %r10, %rbx
	jl less_12
	movq $0, %rbx
	jmp relation_end_12
less_12:
	movq $1, %rbx
relation_end_12:
	cmpq $0, %rbx
	je loop_end_11
	jne loop_statement_start_11
loop_assignment_11:
loop_continue_11:

	# push local var
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
	jmp loop_start_11
loop_statement_start_11:

	# push local var
	movq -8(%rbp), %rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assigning global var array
	movq queens, %r10
	addq %r10, %rbx

	# push local var
	movq -16(%rbp), %r10
	movq %r10, (%rbx)

	# push local var
	movq -8(%rbp), %rbx
     # func=check nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call check
	movq %rax, %rbx

	# push 0
	movq $0,%r10

	# !=
	cmpq %r10, %rbx
	jne not_equal_13
	movq $0, %rbx
	jmp equality_end_13
not_equal_13:
	movq $1, %rbx
equality_end_13:
if_14:
	cmpq $0, %rbx
	je if_end_14

	# push local var
	movq -8(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
     # func=bruteforce nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call bruteforce
	movq %rax, %rbx
	jmp if_end_end_14
if_end_14:
if_end_end_14:
	jmp loop_assignment_11
loop_end_11:

	# push 0
	movq $0,%rbx
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


	# push 8
	movq $8,%rbx

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
	movq %rbx, queens

	# push 1
	movq $1,%rbx

	# assigning to global var
	movq %rbx, solid

	# push 0
	movq $0,%rbx
     # func=bruteforce nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call bruteforce
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
	.string "Solution #%2ld = [ "

string1:
	.string "%ld "

string2:
	.string "]\n"

