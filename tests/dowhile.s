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
loop_continue_0:
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

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to global var
	movq %rbx, i

	# push global var
	movq i, %rbx

	# push 11
	movq $11,%r10

	# <
	cmpq %r10, %rbx
	jl less_1
	movq $0, %rbx
	jmp relation_end_1
less_1:
	movq $1, %rbx
relation_end_1:
	cmpq $0, %rbx
	jne loop_start_0
loop_end_0:
loop_assignment_0:
	#top=0

	# push string "OK\n" top=0
	movq $string1, %rbx
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
	.string "OK\n"

