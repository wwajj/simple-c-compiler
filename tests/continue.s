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


	# push 0
	movq $0,%rbx

	# assigning to global var
	movq %rbx, i
loop_start_0:

	# push global var
	movq i, %rbx

	# push 15
	movq $15,%r10

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

	# push global var
	movq i, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to global var
	movq %rbx, i
	jmp loop_start_0
loop_statement_start_0:
	#top=0

	# push string "i=%d\n" top=0
	movq $string0, %rbx

	# push global var
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push global var
	movq i, %rbx

	# push 6
	movq $6,%r10

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

	# push global var
	movq i, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to global var
	movq %rbx, i
	jmp loop_continue_3
	jmp if_end_end_3
if_end_3:
if_end_end_3:
	jmp loop_assignment_0
loop_end_0:
	#top=0

	# push string "for i=%d\n" top=0
	movq $string1, %rbx

	# push global var
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx

	# assigning to global var
	movq %rbx, i
loop_start_4:
loop_continue_4:

	# push global var
	movq i, %rbx

	# push 15
	movq $15,%r10

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
	#top=0

	# push string "i=%d\n" top=0
	movq $string2, %rbx

	# push global var
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push global var
	movq i, %rbx

	# push 8
	movq $8,%r10

	# <
	cmpq %r10, %rbx
	jl less_6
	movq $0, %rbx
	jmp relation_end_6
less_6:
	movq $1, %rbx
relation_end_6:
if_7:
	cmpq $0, %rbx
	je if_end_7

	# push global var
	movq i, %rbx

	# push 2
	movq $2,%r10

	# +
	addq %r10,%rbx

	# assigning to global var
	movq %rbx, i
	jmp loop_continue_7
	jmp if_end_end_7
if_end_7:
if_end_end_7:

	# push global var
	movq i, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to global var
	movq %rbx, i
	jmp loop_start_4
loop_end_4:
	#top=0

	# push string "while i=%d\n" top=0
	movq $string3, %rbx

	# push global var
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx

	# assigning to global var
	movq %rbx, i
loop_start_8:
loop_continue_8:
	#top=0

	# push string "i=%d\n" top=0
	movq $string4, %rbx

	# push global var
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push global var
	movq i, %rbx

	# push 10
	movq $10,%r10

	# <
	cmpq %r10, %rbx
	jl less_9
	movq $0, %rbx
	jmp relation_end_9
less_9:
	movq $1, %rbx
relation_end_9:
if_10:
	cmpq $0, %rbx
	je if_end_10

	# push global var
	movq i, %rbx

	# push 2
	movq $2,%r10

	# +
	addq %r10,%rbx

	# assigning to global var
	movq %rbx, i
	jmp loop_continue_10
	jmp if_end_end_10
if_end_10:
if_end_end_10:

	# push global var
	movq i, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to global var
	movq %rbx, i

	# push global var
	movq i, %rbx

	# push 15
	movq $15,%r10

	# <
	cmpq %r10, %rbx
	jl less_11
	movq $0, %rbx
	jmp relation_end_11
less_11:
	movq $1, %rbx
relation_end_11:
	cmpq $0, %rbx
	jne loop_start_8
loop_end_8:
loop_assignment_8:
	#top=0

	# push string "do/while i=%d\n" top=0
	movq $string5, %rbx

	# push global var
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "OK\n" top=0
	movq $string6, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
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
	.string "i=%d\n"

string1:
	.string "for i=%d\n"

string2:
	.string "i=%d\n"

string3:
	.string "while i=%d\n"

string4:
	.string "i=%d\n"

string5:
	.string "do/while i=%d\n"

string6:
	.string "OK\n"

