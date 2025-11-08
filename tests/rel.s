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

	# push string "9>8=%d\n" top=0
	movq $string0, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# <
	cmpq %r13, %r10
	jl less_0
	movq $0, %r10
	jmp relation_end_0
less_0:
	movq $1, %r10
relation_end_0:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "8<9=%d\n" top=0
	movq $string1, %rbx

	# push 8
	movq $8,%r10

	# push 9
	movq $9,%r13

	# <
	cmpq %r13, %r10
	jl less_1
	movq $0, %r10
	jmp relation_end_1
less_1:
	movq $1, %r10
relation_end_1:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9<8=%d\n" top=0
	movq $string2, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# <
	cmpq %r13, %r10
	jl less_2
	movq $0, %r10
	jmp relation_end_2
less_2:
	movq $1, %r10
relation_end_2:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "8<9=%d\n" top=0
	movq $string3, %rbx

	# push 8
	movq $8,%r10

	# push 9
	movq $9,%r13

	# <
	cmpq %r13, %r10
	jl less_3
	movq $0, %r10
	jmp relation_end_3
less_3:
	movq $1, %r10
relation_end_3:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9>=8=%d\n" top=0
	movq $string4, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# >=
	cmpq %r13, %r10
	jge greater_equal_4
	movq $0, %r10
	jmp relation_end_4
greater_equal_4:
	movq $1, %r10
relation_end_4:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "8>=9=%d\n" top=0
	movq $string5, %rbx

	# push 8
	movq $8,%r10

	# push 9
	movq $9,%r13

	# >=
	cmpq %r13, %r10
	jge greater_equal_5
	movq $0, %r10
	jmp relation_end_5
greater_equal_5:
	movq $1, %r10
relation_end_5:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9>=9=%d\n" top=0
	movq $string6, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# >=
	cmpq %r13, %r10
	jge greater_equal_6
	movq $0, %r10
	jmp relation_end_6
greater_equal_6:
	movq $1, %r10
relation_end_6:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9>=9=%d\n" top=0
	movq $string7, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# >=
	cmpq %r13, %r10
	jge greater_equal_7
	movq $0, %r10
	jmp relation_end_7
greater_equal_7:
	movq $1, %r10
relation_end_7:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9<=8=%d\n" top=0
	movq $string8, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13

	# <=
	cmpq %r13, %r10
	jle less_equal_8
	movq $0, %r10
	jmp relation_end_8
less_equal_8:
	movq $1, %r10
relation_end_8:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "8<=9=%d\n" top=0
	movq $string9, %rbx

	# push 8
	movq $8,%r10

	# push 9
	movq $9,%r13

	# <=
	cmpq %r13, %r10
	jle less_equal_9
	movq $0, %r10
	jmp relation_end_9
less_equal_9:
	movq $1, %r10
relation_end_9:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9<=9=%d\n" top=0
	movq $string10, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# <=
	cmpq %r13, %r10
	jle less_equal_10
	movq $0, %r10
	jmp relation_end_10
less_equal_10:
	movq $1, %r10
relation_end_10:
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9<=9=%d\n" top=0
	movq $string11, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13

	# <=
	cmpq %r13, %r10
	jle less_equal_11
	movq $0, %r10
	jmp relation_end_11
less_equal_11:
	movq $1, %r10
relation_end_11:
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
	.string "9>8=%d\n"

string1:
	.string "8<9=%d\n"

string2:
	.string "9<8=%d\n"

string3:
	.string "8<9=%d\n"

string4:
	.string "9>=8=%d\n"

string5:
	.string "8>=9=%d\n"

string6:
	.string "9>=9=%d\n"

string7:
	.string "9>=9=%d\n"

string8:
	.string "9<=8=%d\n"

string9:
	.string "8<=9=%d\n"

string10:
	.string "9<=9=%d\n"

string11:
	.string "9<=9=%d\n"

