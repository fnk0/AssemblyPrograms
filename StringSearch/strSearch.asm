.data
	initial_message:		.asciiz		"String Search by Marcus Gabilheri\n"
	searchable:	.asciiz		"Enter String to be searchable: "
	search_str:	.asciiz		"Enter Sub string: "
	not_found: .asciiz 		"Not found!\n"
	newLine:	.asciiz		"\n"
	input_searchable:	.space 		200
	input_to_search:	.space		200


#variable declarations
#bigString = $t0
#smallString = $t1
#bigPntr = $t2
#smallPntr = $t3
#possibleindex = $t4

.text
.globl main
main:
	# print the initial_message
	la $a0, initial_message
	addi $v0, $zero, 4
	syscall

	# print searchable
	la $a0, searchable
	addi $v0, $zero, 4
	syscall

	#read String
	li $v0, 8
    la $a0, input_searchable
    li $a1, 64
    syscall
    la $t0, input_searchable

    

	# print the search_str
	la $a0, search_str	
	addi $v0, $zero, 4	
	syscall

	#read String
	li $v0, 8
    la $a0, input_to_search
    li $a1, 64
    syscall
    la $t1, input_to_search


	la $t2, input_searchable
	la $t3, input_to_search



	while1:
		lb $t4, 0($t2)
		beq $t4, $zero, afterWhile1
		nop

		addi $sp, $sp, -20
		sw $t0, 16($sp)
		sw $t1, 12($sp)
		sw $t2, 8($sp)
		sw $t3, 4($sp)
		sw $ra, 0($sp)

		move $a0, $t2
		move $a1, $t3
		jal checkStrings
		nop

		lw $ra, 0($sp)		
		lw $t3, 4($sp)
		lw $t2, 8($sp)
		lw $t1, 12($sp)
		lw $t0, 16($sp)
		addi $sp, $sp, 20

		addi $t2, $t2, 1

		b while1
		nop

	afterWhile1:

		jr $ra
		nop

#$t0 = *bigPointer
#$t1 = *smallPointer
#$t4 = possibleIndex
#$a0 = bigPointer
#$a1 = smallPointer

checkStrings:
	la $t5, input_searchable
	sub $t4, $a0, $t5

		while2:
			lb $t0, 0($a0)
			lb $t1, 0($a1)
			beq $t1, $zero, afterWhile2
			nop
			li $t3, '\n'
			beq $t1, $t3, afterWhile2
			nop
			if2:
				bne $t0, $t1, return
				nop
				addi $a0, $a0, 1
				addi $a1, $a1, 1
				b while2
				nop
			
	afterWhile2:
		add $a0, $t4, $zero
		addi $v0, $zero, 1
		syscall

	return:
		jr $ra
		nop
