# zhicheng ding
# zhiched

.text
findinArray:
	# a0 = char[][], a1 = numRow, a2 = numCol, a3 = char
	li $t0, 0
i_loop:	
	bge $t0, $a1, done_i_loop # i = t0
	li $t1, 0
	j_loop:
		bge $t1, $a2, done_j_loop # j = t1
		mul $t3, $t0, $a2
		add $t3, $t3, $t1
		add $t3, $t3, $a0
		
		lb $t4, 0($t3)
		beq $t4, $a3, find
		addi $t1, $t1, 1
		j j_loop
done_j_loop:
	addi $t0, $t0, 1
	j i_loop
done_i_loop:
        li $v0, -1
        li $v1, -1
	jr $ra
find:
	move $v0, $t0
	move $v1, $t1
	jr $ra
