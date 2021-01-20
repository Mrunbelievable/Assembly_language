# zhicheng ding
# zhiched

.data
str_empty: .asciiz "empty"

.text

updateList:
	# a0 = list[] mylist, a1 = listLength, a2 = index
	# a3 = char datatype, a4($sp) = void* data
	lw $t5, 0($sp)
	sub $t0, $zero, $a1 # -listlength
	blt $a2, $t0, return_error
	bge $a2, $a1, return_error
	blt $a2, $zero, update_rowNum
	move $t1, $a2 # rowNum =  index
	j nextLine
update_rowNum:
	add $t1, $a1, $a2 # rowNum = listLength + index
nextLine:
	li $t0, 2
	mul $t4, $t1, $t0
	add $t4, $t4, $zero
	sll $t4, $t4, 2
	add $t4, $a0, $t4
	sb $a3, 0($t4)  # myList[rowNum][0] = datatype
	addi $t4, $t4, 4
	sw $t5, 0($t4) #myList[rowNum][1] = data
	li $v0, 0
	jr $ra
return_error:
   	li $v0, -1
	jr $ra

printListItem:
	# a0 = myList, a1 = listLength, a2 = index
	sub $t0, $zero, $a1
	blt $a2, $t0, Negative_return
	bge $a2, $a1, Negative_return
	
	blt $a2, $zero, rowNum_update
	move $t1, $a2
	j switch
rowNum_update:
	add $t1, $a1, $a2 #rowNum = listLength + index
switch:
	li $t0, 2
	mul $t2, $t1, $t0
	sll $t2, $t2, 2
	add $t2, $t2, $a0
	lb $t3, 0($t2) # datatype myList[rowNum]
	beq $t3, $zero, case_0
	li $t0, 1
	beq $t3, $t0, case_1
	li $t0, 2
	beq $t3, $t0, case_2
	li $t0, 3
	beq $t3, $t0, case_3
	li $t0, 4
	beq $t3, $t0, case_4
	j Negative_return
case_0:
	li $t0, 'e'
	move $a0, $t0
	li $v0, 11
	syscall
	li $t0, 'm'
	move $a0, $t0
	li $v0, 11
	syscall
	li $t0, 'p'
	move $a0, $t0
	li $v0, 11
	syscall
	li $t0, 't'
	move $a0, $t0
	li $v0, 11
	syscall
	li $t0, 'y'
	move $a0, $t0
	li $v0, 11
	syscall
	li $v0, 0
	jr $ra
case_1:
	addi $t2, $t2, 4
	lb $t0, 0($t2)
	move $a0, $t0
	li $v0, 11
	syscall
	li $v0, 0
	jr $ra
case_2:
	addi $t2, $t2, 4
	lw $t0, 0($t2)
	move $a0, $t0
	li $v0, 1
	syscall
	li $v0, 0
	jr $ra
case_3:
	addi $t2, $t2, 4
	lw $t0, 0($t2)
	move $a0, $t0
	li $v0, 1
	syscall
	li $v0, 0
	jr $ra
case_4:
	addi $t2, $t2, 4
	lw $t0, 0($t2)
	move $a0, $t0
	li $v0, 4
	syscall
	li $v0, 0
	jr $ra
Negative_return:
   	li $v0, -1
	jr $ra
