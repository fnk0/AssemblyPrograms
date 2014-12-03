# CS 3443 - Fall 2014
# Marcus Gabilheri
# Puzzle Player 8 Game

.data
	initial_message: .asciiz "Puzzle Player 8 by Marcus Gabilheri\n"
	print_initial: .asciiz "Please input a the initial board configuration: "
	print_input: .asciiz "Please enter a valid integer: "
	wrong_move: .asciiz "Wrong move!\n"
	win_message: .asciiz "You Win!!!\n"
	correct_game: .asciiz "12345678."
	newline: .asciiz "\n"
	initial_game: .space 36

	num_index: .asciiz "Num index: "
	dot_index: .asciiz "Dot index: "

.text
.globl main

main:
	# print the initial_message
	li $v0, 4
	la $a0, initial_message
	syscall

	la $a0, print_initial
	syscall

	li $v0, 8
	la $a0, initial_game
	li $a1, 36
	syscall

	add $s0, $a0, $zero # saves the board input into a saved word for persistance

	while:
		move $a1, $s0
		jal printBoard 
		nop

		li $v0, 4
		la $a0, print_input
		syscall

		li $v0, 12 # read integer 
		syscall
		move $a1, $v0 # gets the returned integer and places into $a1 for function call

		li $v0, 4 # needs a newLine because read integer does not append a "\n"
		la $a0, newline 
		syscall

		move $a0, $s0 # gets the current saved board configuration and places in $a0 for function call
		
		jal swapChars  # swap the 2 chars
		nop 

		move $s0, $v1 # gets the returned value from swap chars and saves to $s0 again
		move $a0, $s0 # places $s0 into $a0 for function call
 
		jal isValidResult # check if valid result 
		nop

		b while
		nop

	li $v0, 10
	syscall

# Is valid result checks to see if the result is valid and if the user has won the game
isValidResult:
	li $t5, 9 #string length
	li $t9, 0 # counter variable
	la $t8, correct_game

	whileResult:
		lb $t7, 0($a0) 
		lb $t6, 0($t8)

		bne $t7, $t6, returnValid
		nop

		addi $a0, $a0, 1
		addi $t8, $t8, 1
		addi $t9, $t9, 1

		beq $t9, $t5, winGame
		nop

		b whileResult
		nop

	winGame:
		li $v0, 4 #print win string
		la $a0, win_message
		syscall
		nop

		li $v0, 10
		syscall		
		nop

	returnValid:
		jr $ra
		nop

# Swap chars takes care of swaping 2 chars or printing a error message if
# the move is not allowed
swapChars:
	#a0 = board
	#a1 = num
	#$t7 = numIndex
	#$t6 = dotIndex
	li $t5, '.'
	li $t8, 9 # string size
	li $t9, 0 #counter variable

	add $s5, $a0, $zero # save the parameter $a0 to another register to leave $a0 free for syscalls
	add $s6, $s5, $zero # Save it again so the $s5 pointer can be incremented without a problem.

	whileSwap:

		lb $t4, 0($s5)

		beq $t4, $a1, setNumIndex # if current counter == input 
		nop

		beq $t4, $t5, setDotIndex # if current counter == dot
		nop

		b afterSets
		nop

		setNumIndex:
			add $t7, $t9, $zero #numIndex
			b afterSets
			nop

		setDotIndex:
			add $t6, $t9, $zero #dotIndex
			nop

		afterSets:

		addi $t9, $t9, 1 # increments the counter
		addi $s5, $s5, 1 # increments the position of the read word
		beq $t8, $t9, doSwap # if we reach the end of the string we do the swap
		nop

		b whileSwap
		nop

	# swap the 2 chars 
	doSwap:
		# All 4 possible allowed moves
		li $t0, 1 
		li $t1, -1
		li $t2, 3
		li $t3, -3
		sub $t9, $t7, $t6 # diff
		
		beq $t9, $t0, oneAnd
		nop

		beq $t9, $t1, oneAnd
		nop

		beq $t9, $t2, validSwap
		nop

		beq $t9, $t3, validSwap
		nop

		b wrong
		nop

		oneAnd:
			div $t7, $t2
			mflo $t4
			div $t6, $t2
			mflo $t5

			# this avoids the case of swaping neighbors in the array that are not supposed to be swapped.
			beq $t4, $t5, validSwap
			nop

		wrong:
			li $v0, 4
			la $a0, wrong_move # if the move is wrong we print a error message and exit the function
			syscall

			b returnSwap
			nop

		validSwap:
			#$a0[$t7] = $a1
			#$a0[$t6] = '.'
			add $t9, $t6, $s6
			sb $a1, 0($t9)

			add $t9, $t7, $s6
			li $t8, '.'
			sb $t8, 0($t9)

	returnSwap:
		add $v1, $s6, $zero # places the new swapped string into the return index
		jr $ra
		nop

# Prints the current state of the board
# $a0 is the board parameter
printBoard:
		li $t7, 3 # needed to break a new line
		li $t8, 10 # lenght of the string 
		li $t9, 1 # counter variable
	whileBoard:
		lb $t5, 0($a1)
		add $a0, $t5, $zero
		li $v0, 11 # print character
		syscall

		div $t9, $t7 # if counter % 3 == 0 
		mfhi $t6 # gets the result

		bnez $t6, elseLine # if is not mod 3 don't print newLine
		nop
		ifLine:
			li $v0, 4 #print string
			la $a0, newline
			syscall
			nop

		elseLine:

		addi $t9, $t9, 1 # increments counter
		addi $a1, $a1, 1 # increments string pointer 

		beq $t8, $t9, returnPrint # if the counter == size of string exits
		nop

		b whileBoard
		nop

	returnPrint:
		jr $ra
		nop