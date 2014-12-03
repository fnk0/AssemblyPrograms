.data
	initial_message: .asciiz "Power by Marcus Gabilheri.\n"
	int1: .asciiz "Please input first integer: "
	int2: .asciiz "Please input second integer: "
	newline: .asciiz "\n"

.text

main:	
	li $v0, 4 # Print string syscall
	la $a0, initial_message # loads the initial message
	syscall # prints initial message 

	la $a0, int1 # loads message for int 1
	syscall # prints message int 1

	li $v0, 5 # Syscall read integer
	syscall
	move $t0, $v0 # Sycall result returned from v0 to t0

	li $v0, 4 #Print String syscall
	la $a0, int2
	syscall

	li $v0, 5 # Syscall read integer
	syscall
	move $t1, $v0

	li $t3, 1 # result variable

	while: #while int2 >= 0
		blez $t1, afterWhile 
		nop 
		mult $t3, $t0 
		mflo $t3
		sub $t1, $t1, 1 #decrements int2 by 1
		b while 
		nop

	afterWhile:
		li $v0, 1 # print integer syscall
		move $a0, $t3 # moves the result to be printed by the syscall
		syscall

		li $v0, 10
		syscall

	
