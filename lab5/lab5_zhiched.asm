

pow:
	addi $sp, $sp, -8
	addi $s1, $a1, -1
	sw $ra, 0($sp)
	sw $s1, 4($sp)
	
	bne $s1, 0 else
	li $v0, 1
	addi $sp, $sp, 8
	jr $ra
else:
	move $a1, $s1
	jal pow
	mul $t0, $s0, $v0
	addi $sp, $sp, 8
	jr $ra
	
main:
	li $a0, 1
	li $a1, 2
	jal pow
