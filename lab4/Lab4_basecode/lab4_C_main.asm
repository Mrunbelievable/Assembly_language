#.include "../lab4_jwongma/lab4_C_jwongma.asm"
.include "lab4_functions.asm"
.include "lab4_C_zhiched.asm"
.globl main
.text
main:

######################
	# Modify the List to hold the char at index 4
    la $a0, myList
    lw $a1, myListLength
    li $a2, 1				# load the position to store the data in the list
    li $a3, 0				# load the type of data to store

    la $t0, myData_char     # load the data to be stored
    lb $t0, 0($t0)

    addi $sp, $sp, -4		# pass the 5th argument
    sw $t0, 0($sp)
	jal updateList
	addi $sp, $sp, 4
######################
	# print list in python format
    la $a0, myList
    lw $a1, myListLength
	jal printList
######################
	# Modify the List to hold the int at index 1
    la $a0, myList
    lw $a1, myListLength
    li $a2, 1				# load the position to store the data in the list
    li $a3, 3				# load the type of data to store

    la $t0, myData_int     # load the data to be stored
    lw $t0, 0($t0)

    addi $sp, $sp, -4		# pass the 5th argument
    sw $t0, 0($sp)
	jal updateList
	addi $sp, $sp, 4
######################
	# print list in python format
    la $a0, myList
    lw $a1, myListLength
	jal printList
######################
	# Modify the List to hold the short at index 0
    la $a0, myList
    lw $a1, myListLength
    li $a2, 1				# load the position to store the data in the list
    li $a3, 2				# load the type of data to store

    la $t0, myData_short     # load the data to be stored
    lh $t0, 0($t0)

    addi $sp, $sp, -4		# pass the 5th argument
    sw $t0, 0($sp)
	jal updateList
	addi $sp, $sp, 4
######################
	# print list in python format
    la $a0, myList
    lw $a1, myListLength
	jal printList
######################
	# Modify the List to hold the new string at index 2
    la $a0, myList
    lw $a1, myListLength
    li $a2, 1				# load the position to store the data in the list
    li $a3, 4				# load the type of data to store

    la $t0, myData_string     # load the data to be stored
    lw $t0, 0($t0)

    addi $sp, $sp, -4		# pass the 5th argument
    sw $t0, 0($sp)
	jal updateList
	addi $sp, $sp, 4
######################
	# print list in python format
    la $a0, myList
    lw $a1, myListLength
	jal printList
######################
	# Update list using negative position
    la $a0, myList
    lw $a1, myListLength
    li $a2, -5				# load the position to store the data in the list
    li $a3, 4				# load the type of data to store

    la $t0, str_foobar    # load the data to be stored

    addi $sp, $sp, -4		# pass the 5th argument
    sw $t0, 0($sp)
	jal updateList
	addi $sp, $sp, 4
######################
	# print list in python format
    la $a0, myList
    lw $a1, myListLength
	jal printList
######################
	# Update list using error position
    la $a0, myList
    lw $a1, myListLength
    li $a2, -10				# load the position to store the data in the list
    li $a3, 4				# load the type of data to store

    la $t0, str_foobar    # load the data to be stored

    addi $sp, $sp, -4		# pass the 5th argument
    sw $t0, 0($sp)
	jal updateList
	addi $sp, $sp, 4

	# print out error with printList
    beqz $v0 main_printList_err
   	li $v0, 4
   	la $a0, str_updateListErr
   	syscall
######################
main_printList_err:
	# Error for print list in python format
    la $a0, myList
    li $a1, -10
	jal printList
######################
	# print out error with printList
    beqz $v0, main_done
   	li $v0, 4
   	la $a0, str_printListErr
   	syscall

main_done:
	li $v0, 10
	syscall



.data

myListLength: .word 3
myList: .word 0x11FFEE02, 0xABCD7FFF, 0xDDBBAA01, 0x88776621, 0x11002204, str_hello, 0x00000003, 0x7FFFFFFF, 0xABCDEF00, -1
str_foobar: .asciiz "foo bar"
str_hello: .asciiz "Hello ICS51!"
newline: .asciiz "\n"
myData_char: .asciiz "????????"
myData_short: .half 0x1234
myData_int: .word 0x88776655
myData_string: .word str_foobar

str_updateListErr: .asciiz "updateList returned -1\n"
str_printListErr: .asciiz "printList returned -1\n"


