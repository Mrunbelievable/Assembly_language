.include "lab3_A_zhiched.asm"
.globl main
.text
main:

    # load the argument registers
    li $a0, 2

    # call the function
    jal F

    # save the return value
    move $s0, $v0

    # print string
    li $v0, 4
    la $a0, F_return
    syscall

    # print return value
    li $v0, 1
    move $a0, $s0
    syscall
    
    # print newline
    li $v0, 4
    la $a0, newline
    syscall

    # load the argument registers
    li $a0, 2

    # call the function
    jal M

    # save the return value
    move $s0, $v0	
	
    # print string
    li $v0, 4
    la $a0, M_return
    syscall

    # print return value
    li $v0, 1
    move $a0, $s0
    syscall
    
    # print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit the program
    li $v0, 10
    syscall

.data
F_return: .asciiz "F returned "
M_return: .asciiz "M returned "
newline: .asciiz "\n"
