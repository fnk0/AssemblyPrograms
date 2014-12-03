.data
	initial_message: .asciiz "String Search by Marcus Gabilheri\n"
	print_searchable: .asciiz "Please input a String to be searchable: "
	print_sub: .asciiz "Please input a Sub String to search: "
	newline: .asciiz "\n"
	searchable_str: .space 200
	sub_str: .space 200

.text

main:
	li $v0, 4
	la $a0, initial_message
	syscall

	la $a0, print_searchable
	syscall

	la $a0, searchable_str
	li $a1, 200
	li $v0, 8
	syscall

	li $v0, 4
	la $a0, print_sub
	syscall

	la $a0, sub_str
	li $a1, 200
	li $v0, 8
	syscall

	li $v0, 4
	la $a0, searchable_str
	syscall

	la $a0, sub_str
	syscall

	li $t0, 0 # final counter variable
	la $t1, searchable_str
	la $t2, sub_str
	la $t3, sub_str # counter variable to be incremented.

	while: # outer while

		lb $t4, 0($t1)
		lb $t5, 0($t3)
		bne $t4, $t5, notEqual
		nop
		addi $t1, $t1, 1
		addi $t3, $t3, 1
		nop

	notEqual:
		la $t3, $t2
		b while
		nop 

	equal:
		addi $t0, $t0, 1
		b while
		nop


	afterWhile:

		la $a0, $t0
		li $v0, 5
		syscall

		li $v0, 10 # exits the program
		syscall


	