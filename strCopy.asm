
while:
	lb $t0, 0($a0)
	sb $t0, 0($a1)
	beq $t0, zero, afterWhile
	nop # can be removed for optmization
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	b while
	nop # can not be eliminated as it stands but...
	## optmized version	#
	# addi $a0, $a0, 1
	# b while
	# addi $a1, $a1, 1
	######### 
afterWhile:
	jr $ra
	nop