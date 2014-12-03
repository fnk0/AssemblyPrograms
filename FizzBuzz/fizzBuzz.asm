.data
	initial_message: .asciiz "FizzBuzz by Marcus Gabilheri.\n"
	numTimes: .asciiz "Please input an integer: "
	fizz: .asciiz "Marcus"
	buzz: .asciiz "Gabilheri"
	fizzBuzz: .asciiz "Marcus Gabilheri"
	newline: .asciiz "\n"

.text

main:
	li $v0, 4
	la $a0, initial_message
	syscall

	la $a0, numTimes
	syscall

	li $v0, 5
	syscall
	move $t0, $v0

	li $t1, 1 # counter variable
	# Necessary for division 
	li $t2, 3 
	li $t3, 5 
	addi $t0, $t0, 1

	while:
		bge $t1, $t0, afterWhile
		nop
		li $v0, 4
		div $t1, $t2
		mfhi $t4

		div $t1, $t3
		mfhi $t5

		bne $t4, $zero, notBy3
		nop
		bne $t5, $zero, by3
		nop
		
		la $a0, fizzBuzz
		syscall

		b end
		nop

		by3:
			la $a0, fizz
			syscall
			b end
			nop

		notBy3:
			bne $t5, $zero, else
			nop
			la $a0, buzz
			syscall
			b end
			nop

		else:
			li $v0, 1
			move $a0, $t1
			syscall
		
		end:
			li $v0, 4
			la $a0, newline
			syscall
			addi $t1, $t1, 1
			b while
			nop

	afterWhile:
		li $v0, 10
		syscall







