	.text
.globl printArray
printArray:
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

	# push local var
	movq -16(%rbp), %rbx

	# assigning to local var
	movq %rbx, -32(%rbp)
loop_start_0:

	# push local var
	movq -32(%rbp), %rbx

	# push local var
	movq -24(%rbp), %r10

	# <=
	cmpq %r10, %rbx
	jle less_equal_1
	movq $0, %rbx
	jmp relation_end_1
less_equal_1:
	movq $1, %rbx
relation_end_1:
	cmpq $0, %rbx
	je loop_end_0
	jne loop_statement_start_0
loop_assignment_0:
loop_continue_0:

	# push local var
	movq -32(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -32(%rbp)
	jmp loop_start_0
loop_statement_start_0:
	#top=0

	# push string "%d: %s\n" top=0
	movq $string0, %rbx

	# push local var
	movq -32(%rbp), %r10

	# push local var
	movq -32(%rbp), %r13

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
	jmp loop_assignment_0
loop_end_0:
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
.globl print
print:
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
	#top=0

	# push string "==%s==\n" top=0
	movq $string1, %rbx

	# push local var
	movq -8(%rbp), %r10
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
	.text
.globl mystrcmp
mystrcmp:
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
loop_start_2:
loop_continue_2:

	# push 0
	movq $0,%rbx

	# setting offset for char array
	imulq $1, %rbx

	# push local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx
	movb %bl, %r10b
	movq $0, %rbx
	movb %r10b, %bl

	# push 0
	movq $0,%r10

	# setting offset for char array
	imulq $1, %r10

	# push local var array
	movq -16(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10
	movb %r10b, %r13b
	movq $0, %r10
	movb %r13b, %r10b

	# &&
	andq %r10, %rbx

	# push 0
	movq $0,%r10

	# setting offset for char array
	imulq $1, %r10

	# push local var array
	movq -8(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10
	movb %r10b, %r13b
	movq $0, %r10
	movb %r13b, %r10b

	# push 0
	movq $0,%r13

	# setting offset for char array
	imulq $1, %r13

	# push local var array
	movq -16(%rbp), %r14
	addq %r14, %r13
	movq (%r13), %r13
	movb %r13b, %r14b
	movq $0, %r13
	movb %r14b, %r13b

	# ==
	cmpq %r13, %r10
	jne not_equal_3
	movq $1, %r10
	jmp equality_end_3
not_equal_3:
	movq $0, %r10
equality_end_3:

	# &&
	andq %r10, %rbx
	cmpq $0, %rbx
	je loop_end_2

	# push local var
	movq -8(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -8(%rbp)

	# push local var
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
	jmp loop_start_2
loop_end_2:

	# push 0
	movq $0,%rbx

	# setting offset for char array
	imulq $1, %rbx

	# push local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx
	movb %bl, %r10b
	movq $0, %rbx
	movb %r10b, %bl

	# push 0
	movq $0,%r10

	# ==
	cmpq %r10, %rbx
	jne not_equal_4
	movq $1, %rbx
	jmp equality_end_4
not_equal_4:
	movq $0, %rbx
equality_end_4:

	# push 0
	movq $0,%r10

	# setting offset for char array
	imulq $1, %r10

	# push local var array
	movq -16(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10
	movb %r10b, %r13b
	movq $0, %r10
	movb %r13b, %r10b

	# push 0
	movq $0,%r13

	# ==
	cmpq %r13, %r10
	jne not_equal_5
	movq $1, %r10
	jmp equality_end_5
not_equal_5:
	movq $0, %r10
equality_end_5:

	# &&
	andq %r10, %rbx
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

	# push 0
	movq $0,%rbx

	# setting offset for char array
	imulq $1, %rbx

	# push local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx
	movb %bl, %r10b
	movq $0, %rbx
	movb %r10b, %bl

	# push 0
	movq $0,%r10

	# ==
	cmpq %r10, %rbx
	jne not_equal_7
	movq $1, %rbx
	jmp equality_end_7
not_equal_7:
	movq $0, %rbx
equality_end_7:

	# push 0
	movq $0,%r10

	# setting offset for char array
	imulq $1, %r10

	# push local var array
	movq -16(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10
	movb %r10b, %r13b
	movq $0, %r10
	movb %r13b, %r10b

	# push 0
	movq $0,%r13

	# !=
	cmpq %r13, %r10
	jne not_equal_8
	movq $0, %r10
	jmp equality_end_8
not_equal_8:
	movq $1, %r10
equality_end_8:

	# &&
	andq %r10, %rbx
if_9:
	cmpq $0, %rbx
	je if_end_9

	# push -1
	movq $-1,%rbx
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
	jmp if_end_end_9
if_end_9:
if_end_end_9:

	# push 0
	movq $0,%rbx

	# setting offset for char array
	imulq $1, %rbx

	# push local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx
	movb %bl, %r10b
	movq $0, %rbx
	movb %r10b, %bl

	# push 0
	movq $0,%r10

	# !=
	cmpq %r10, %rbx
	jne not_equal_10
	movq $0, %rbx
	jmp equality_end_10
not_equal_10:
	movq $1, %rbx
equality_end_10:

	# push 0
	movq $0,%r10

	# setting offset for char array
	imulq $1, %r10

	# push local var array
	movq -16(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10
	movb %r10b, %r13b
	movq $0, %r10
	movb %r13b, %r10b

	# push 0
	movq $0,%r13

	# ==
	cmpq %r13, %r10
	jne not_equal_11
	movq $1, %r10
	jmp equality_end_11
not_equal_11:
	movq $0, %r10
equality_end_11:

	# &&
	andq %r10, %rbx
if_12:
	cmpq $0, %rbx
	je if_end_12

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
	jmp if_end_end_12
if_end_12:
if_end_end_12:

	# push 0
	movq $0,%rbx

	# setting offset for char array
	imulq $1, %rbx

	# push local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx
	movb %bl, %r10b
	movq $0, %rbx
	movb %r10b, %bl

	# push 0
	movq $0,%r10

	# setting offset for char array
	imulq $1, %r10

	# push local var array
	movq -16(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10
	movb %r10b, %r13b
	movq $0, %r10
	movb %r13b, %r10b

	# >
	cmpq %r10, %rbx
	jg greater_13
	movq $0, %rbx
	jmp relation_end_13
greater_13:
	movq $1, %rbx
relation_end_13:
if_14:
	cmpq $0, %rbx
	je if_end_14

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
	jmp if_end_end_14
if_end_14:
if_end_end_14:

	# push -1
	movq $-1,%rbx
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
.globl quicksortsubrange
quicksortsubrange:
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

	# push local var
	movq -16(%rbp), %rbx

	# push local var
	movq -24(%rbp), %r10

	# >=
	cmpq %r10, %rbx
	jge greater_equal_15
	movq $0, %rbx
	jmp relation_end_15
greater_equal_15:
	movq $1, %rbx
relation_end_15:
if_16:
	cmpq $0, %rbx
	je if_end_16

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
	jmp if_end_end_16
if_end_16:
if_end_end_16:

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

	# push local var
	movq -16(%rbp), %rbx

	# assigning to local var
	movq %rbx, -40(%rbp)

	# push local var
	movq -24(%rbp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx

	# assigning to local var
	movq %rbx, -48(%rbp)
loop_start_17:
loop_continue_17:

	# push local var
	movq -40(%rbp), %rbx

	# push local var
	movq -48(%rbp), %r10

	# <
	cmpq %r10, %rbx
	jl less_18
	movq $0, %rbx
	jmp relation_end_18
less_18:
	movq $1, %rbx
relation_end_18:
	cmpq $0, %rbx
	je loop_end_17
loop_start_19:
loop_continue_19:

	# push local var
	movq -40(%rbp), %rbx

	# push local var
	movq -48(%rbp), %r10

	# <
	cmpq %r10, %rbx
	jl less_20
	movq $0, %rbx
	jmp relation_end_20
less_20:
	movq $1, %rbx
relation_end_20:

	# push local var
	movq -40(%rbp), %r10

	# setting offset for non-char array
	imulq $8, %r10

	# push local var array
	movq -8(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10

	# push local var
	movq -32(%rbp), %r13
     # func=mystrcmp nargs=2
     # Move values from reg stack to reg args
	movq %r13, %rsi
	movq %r10, %rdi
	call mystrcmp
	movq %rax, %r10

	# push 0
	movq $0,%r13

	# <
	cmpq %r13, %r10
	jl less_21
	movq $0, %r10
	jmp relation_end_21
less_21:
	movq $1, %r10
relation_end_21:

	# &&
	andq %r10, %rbx
	cmpq $0, %rbx
	je loop_end_19

	# push local var
	movq -40(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -40(%rbp)
	jmp loop_start_19
loop_end_19:
loop_start_22:
loop_continue_22:

	# push local var
	movq -40(%rbp), %rbx

	# push local var
	movq -48(%rbp), %r10

	# <
	cmpq %r10, %rbx
	jl less_23
	movq $0, %rbx
	jmp relation_end_23
less_23:
	movq $1, %rbx
relation_end_23:

	# push local var
	movq -48(%rbp), %r10

	# setting offset for non-char array
	imulq $8, %r10

	# push local var array
	movq -8(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10

	# push local var
	movq -32(%rbp), %r13
     # func=mystrcmp nargs=2
     # Move values from reg stack to reg args
	movq %r13, %rsi
	movq %r10, %rdi
	call mystrcmp
	movq %rax, %r10

	# push 0
	movq $0,%r13

	# >=
	cmpq %r13, %r10
	jge greater_equal_24
	movq $0, %r10
	jmp relation_end_24
greater_equal_24:
	movq $1, %r10
relation_end_24:

	# &&
	andq %r10, %rbx
	cmpq $0, %rbx
	je loop_end_22

	# push local var
	movq -48(%rbp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx

	# assigning to local var
	movq %rbx, -48(%rbp)
	jmp loop_start_22
loop_end_22:

	# push local var
	movq -40(%rbp), %rbx

	# push local var
	movq -48(%rbp), %r10

	# <
	cmpq %r10, %rbx
	jl less_25
	movq $0, %rbx
	jmp relation_end_25
less_25:
	movq $1, %rbx
relation_end_25:
if_26:
	cmpq $0, %rbx
	je if_end_26

	# push local var
	movq -40(%rbp), %rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# push local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx

	# assigning to local var
	movq %rbx, -56(%rbp)

	# push local var
	movq -40(%rbp), %rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push local var
	movq -48(%rbp), %r10

	# setting offset for non-char array
	imulq $8, %r10

	# push local var array
	movq -8(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10
	movq %r10, (%rbx)

	# push local var
	movq -48(%rbp), %rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push local var
	movq -56(%rbp), %r10
	movq %r10, (%rbx)
	jmp if_end_end_26
if_end_26:
if_end_end_26:
	jmp loop_start_17
loop_end_17:

	# push local var
	movq -24(%rbp), %rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push local var
	movq -40(%rbp), %r10

	# setting offset for non-char array
	imulq $8, %r10

	# push local var array
	movq -8(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10
	movq %r10, (%rbx)

	# push local var
	movq -40(%rbp), %rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push local var
	movq -32(%rbp), %r10
	movq %r10, (%rbx)

	# push local var
	movq -8(%rbp), %rbx

	# push local var
	movq -16(%rbp), %r10

	# push local var
	movq -40(%rbp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=quicksortsubrange nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksortsubrange
	movq %rax, %rbx

	# push local var
	movq -8(%rbp), %rbx

	# push local var
	movq -48(%rbp), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10

	# push local var
	movq -24(%rbp), %r13
     # func=quicksortsubrange nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksortsubrange
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
	.text
.globl quicksort
quicksort:
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

	# push local var
	movq -8(%rbp), %rbx

	# push 0
	movq $0,%r10

	# push local var
	movq -16(%rbp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=quicksortsubrange nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksortsubrange
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


	# push 6
	movq $6,%rbx

	# assigning to local var
	movq %rbx, -8(%rbp)

	# push local var
	movq -8(%rbp), %rbx

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
	movq %rbx, -16(%rbp)

	# push 0
	movq $0,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -16(%rbp), %r10
	addq %r10, %rbx
	#top=1

	# push string "Rachael" top=1
	movq $string2, %r10
	movq %r10, (%rbx)

	# push 1
	movq $1,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -16(%rbp), %r10
	addq %r10, %rbx
	#top=1

	# push string "Monica" top=1
	movq $string3, %r10
	movq %r10, (%rbx)

	# push 2
	movq $2,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -16(%rbp), %r10
	addq %r10, %rbx
	#top=1

	# push string "Phoebe" top=1
	movq $string4, %r10
	movq %r10, (%rbx)

	# push 3
	movq $3,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -16(%rbp), %r10
	addq %r10, %rbx
	#top=1

	# push string "Joey" top=1
	movq $string5, %r10
	movq %r10, (%rbx)

	# push 4
	movq $4,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -16(%rbp), %r10
	addq %r10, %rbx
	#top=1

	# push string "Ross" top=1
	movq $string6, %r10
	movq %r10, (%rbx)

	# push 5
	movq $5,%rbx

	# setting offset for non-char array
	imulq $8, %rbx

	# assignign local var array
	movq -16(%rbp), %r10
	addq %r10, %rbx
	#top=1

	# push string "Chandler" top=1
	movq $string7, %r10
	movq %r10, (%rbx)
	#top=0

	# push string "-------- Before -------\n" top=0
	movq $string8, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push local var
	movq -16(%rbp), %rbx

	# push 0
	movq $0,%r10

	# push local var
	movq -8(%rbp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=printArray nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call printArray
	movq %rax, %rbx

	# push local var
	movq -16(%rbp), %rbx

	# push local var
	movq -8(%rbp), %r10
     # func=quicksort nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksort
	movq %rax, %rbx
	#top=0

	# push string "-------- After -------\n" top=0
	movq $string9, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push local var
	movq -16(%rbp), %rbx

	# push 0
	movq $0,%r10

	# push local var
	movq -8(%rbp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=printArray nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call printArray
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
	.string "%d: %s\n"

string1:
	.string "==%s==\n"

string2:
	.string "Rachael"

string3:
	.string "Monica"

string4:
	.string "Phoebe"

string5:
	.string "Joey"

string6:
	.string "Ross"

string7:
	.string "Chandler"

string8:
	.string "-------- Before -------\n"

string9:
	.string "-------- After -------\n"

