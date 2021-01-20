# zhicheng ding
# zhiched

.text
setArray:
	# a0 = int[][], a1 = numRow, a2 = numCol, a3 = myRow
	lw $t3, 0($sp) #value
	lw $t4, 4($sp) #myCol
	
	mul $t5, $a3, $a2 # i * numCol
	add $t5, $t5, $t4 # i * numCol + j
	sll $t5, $t5, 2 # 4 * (i * numCol + j)
	
	add $t5, $t5, $a0
	sw $t3, 0($t5)
	
	jr $ra
