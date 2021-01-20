.include "lab4_B_zhiched.asm"

.globl main
.text
main:


	la $a0, myarray
	lw $a1, numRows
	lw $a2, numCols
	lw $a3, myrow
	lw $t0, mycol
	lw $t1, myvalue
	addi $sp, $sp, -8
	sw $t0, 4($sp)
	sw $t1, 0($sp)
	jal setArray  

	# manually check memory to determine if the value of the array has changed
	# base file will overwrite the number 100 with 255

	li $v0, 10
	syscall

.data
myarray: .word 10,20,30,40,50,60,70,80,90,100, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010

#set to [2][10], try [4][5], [5][4], [4][4], [2][4]
# or any combination of row*cols less than 20 for the given array
numRows: .word 5
numCols: .word 4

myrow: .word 2  # will overwrite 100 with 255
mycol: .word 1
myvalue: .word 0xFF  # integer value 255
