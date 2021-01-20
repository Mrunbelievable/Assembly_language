

findIndex:
#a0 = array address
#a1 = size of array
# s1 = max
# s2 = min
ble $a1, $zero, findIndexError
lw $s1, 0($a0)
lw $s2, 0($a0)
move $s7, $a0
li $t0, '\0'
li $t3, 0
first_while:
li $t5, 0 #i
lw $t2, 0($a0)
beq $t2, $t0, doneForSearching
second_while:
addi $a0, $a0, 4
addi $t3, $t3, 1
lw $t1, 0($a0)
beq $t1, $t0, go_first_while
addi $t5, $t5, 1
bgt $t1, $s1, Max
blt $t1, $s2, Min
j second_while
go_first_while:
li $t4, 4
mul $t4, $t3, $t4
sub $a0, $a0, $t4
addi $a0, $a0, 4
li $t3, 0
j first_while
Max:
move $s1, $t1
move $4, $t5
j second_while
Min:
move $s2, $t1
move $4, $t5
j second_while
findIndexError:
	li $v0, -1
	li $v1, -1
	jr $ra
doneForSearching:
	move $v0, $s4
	move $v1, $s5
	jr $ra