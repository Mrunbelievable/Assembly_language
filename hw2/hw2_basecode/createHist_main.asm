.include "hw2_zhiched.asm"

.globl main

# Data Section
.data
strLabel1: .asciiz "createHist Returned Value " 
newline: .asciiz "\n"
array: .word 0,0,0,0,0,0,0,0,4,0,0,0,1,0,0,2,0,0,4,0,0,0,0,0,0,0

# Program 
.text
main:

    # load the arguments & Call function
    la $a0, array
    jal createHist

    # save the return value
    move $t0, $v0   

    #print label
    la $a0, strLabel1
    li $v0, 4
    syscall

    #print return  value - v0
    move $a0, $t0
    li $v0, 1
    syscall

    #print newline
    la $a0, newline
    li $v0, 4
    syscall

    #quit program
    li $v0, 10
    syscall

