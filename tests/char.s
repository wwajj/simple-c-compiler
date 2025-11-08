	.data
	.comm g,8
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

	# push string "Hello world" top=0
	movq $string0, %rbx

	# assigning to local var
	movq %rbx, -8(%rbp)
	#top=0

	# push string "h[6]=%c\n" top=0
	movq $string1, %rbx

	# push 6
	movq $6,%r10

	# setting offset for char array
	imulq $1, %r10

	# push local var array
	movq -8(%rbp), %r13
	addq %r13, %r10
	movq (%r10), %r10
	movb %r10b, %r13b
	movq $0, %r10
	movb %r13b, %r10b
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "This is a great class!!" top=0
	movq $string2, %rbx

	# assigning to global var
	movq %rbx, g
	#top=0

	# push string "g[11]=%c\n" top=0
	movq $string3, %rbx

	# push 11
	movq $11,%r10

	# setting offset for char array
	imulq $1, %r10

	# push global var array
	movq g, %r13
	addq %r13, %r10
	movq (%r10), %r10
	movb %r10b, %r13b
	movq $0, %r10
	movb %r13b, %r10b
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
	.string "Hello world"

string1:
	.string "h[6]=%c\n"

string2:
	.string "This is a great class!!"

string3:
	.string "g[11]=%c\n"

