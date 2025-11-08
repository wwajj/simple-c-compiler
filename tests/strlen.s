	.text
.globl mystrlen
mystrlen:
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
loop_start_0:
loop_continue_0:

	# push local var
	movq -16(%rbp), %rbx

	# setting offset for char array
	imulq $1, %rbx

	# push local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx
	movb %bl, %r10b
	movq $0, %rbx
	movb %r10b, %bl
	cmpq $0, %rbx
	je loop_end_0

	# push local var
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# assigning to local var
	movq %rbx, -16(%rbp)
	jmp loop_start_0
loop_end_0:

	# push local var
	movq -16(%rbp), %rbx
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
.globl mystrcpy
mystrcpy:
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
loop_start_1:
loop_continue_1:

	# push 0
	movq $0,%rbx

	# setting offset for char array
	imulq $1, %rbx

	# push local var array
	movq -16(%rbp), %r10
	addq %r10, %rbx
	movq (%rbx), %rbx
	movb %bl, %r10b
	movq $0, %rbx
	movb %r10b, %bl
	cmpq $0, %rbx
	je loop_end_1

	# push 0
	movq $0,%rbx

	# setting offset for char array
	imulq $1, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

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
	movq %r10, (%rbx)

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
	jmp loop_start_1
loop_end_1:

	# push 0
	movq $0,%rbx

	# setting offset for char array
	imulq $1, %rbx

	# assignign local var array
	movq -8(%rbp), %r10
	addq %r10, %rbx

	# push 0
	movq $0,%r10
	movq %r10, (%rbx)
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


	# push 30
	movq $30,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx

	# assigning to local var
	movq %rbx, -8(%rbp)

	# push local var
	movq -8(%rbp), %rbx
	#top=1

	# push string "Hello world" top=1
	movq $string0, %r10
     # func=mystrcpy nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call mystrcpy
	movq %rax, %rbx
	#top=0

	# push string "h=%s\n" top=0
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
	#top=0

	# push string "l=%d\n" top=0
	movq $string2, %rbx

	# push local var
	movq -8(%rbp), %r10
     # func=mystrlen nargs=1
     # Move values from reg stack to reg args
	movq %r10, %rdi
	call mystrlen
	movq %rax, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx

	# push 30
	movq $30,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx

	# assigning to global var
	movq %rbx, g

	# push global var
	movq g, %rbx
	#top=1

	# push string "This is a great course" top=1
	movq $string3, %r10
     # func=strcpy nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call strcpy
	movq %rax, %rbx
	#top=0

	# push string "g=%s\n" top=0
	movq $string4, %rbx

	# push global var
	movq g, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "l=%d\n" top=0
	movq $string5, %rbx

	# push global var
	movq g, %r10
     # func=mystrlen nargs=1
     # Move values from reg stack to reg args
	movq %r10, %rdi
	call mystrlen
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
	.string "Hello world"

string1:
	.string "h=%s\n"

string2:
	.string "l=%d\n"

string3:
	.string "This is a great course"

string4:
	.string "g=%s\n"

string5:
	.string "l=%d\n"

