#.include "hw2_zhiched.asm"
.include "mipsD.asm"
.globl main

# Data Section
.data
array: .word 1,2,3,4,10,0,-1
array_size: .word 7
strLabel1: .asciiz " findIndex("
comma: .asciiz ", "
strLabel2: .asciiz ") returned values: ("
paren: .asciiz ")\n"

# Program 
.text
main:

    # load the arguments
    la $a0, array
    lw $a1, array_size

    # call the function
    jal findIndex

    # save the return values
    move $t8, $v0
    move $t9, $v1

    #print label
    la $a0, strLabel1
    li $v0, 4
    syscall

    #print argument value - array address in hex
    la $a0, array
    li $v0, 34
    syscall

    #print comma
    la $a0, comma
    li $v0, 4
    syscall

    #print argument value - n in decimal
    lw $a0, array_size
    li $v0, 1
    syscall

    #print label2
    la $a0, strLabel2
    li $v0, 4
    syscall

    #print return value1
    move $a0, $t8
    li $v0, 1
    syscall

    #print comma
    la $a0, comma
    li $v0, 4
    syscall

    #print return value2
    move $a0, $t9
    li $v0, 1
    syscall

    #print closing paren
    la $a0, paren
    li $v0, 4
    syscall
 
    #quit program
    li $v0, 10
    syscall

