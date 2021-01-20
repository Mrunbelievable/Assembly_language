.include "hw2_netid.asm"

.globl main

# Data Section
.data
array: .word 0,0,0,0,0,0,0,0,4,0,0,0,1,0,0,2,0,0,4,0,0,0,0,0,0,0

str: .asciiz "mississippi"

strLabel1: .asciiz "countAllChars Returned Value ("
comma: .asciiz ", "
strLabel2: .asciiz ")\n"

strLabel3: .asciiz "\ncreateHist Returned Value " 
newline: .asciiz "\n"


# Program 
.text
main:

    # load the arguments & Call function
    la $a0, str
    la $a1, array
    jal countAllChars

    #save arguments
    move $t9, $v0
    move $t8, $v1

    #print label
    la $a0, strLabel1
    li $v0, 4
    syscall
    
    #print return value - number of space characters
    move $a0, $t9
    li $v0, 1
    syscall
    
    #print label
    la $a0, comma
    li $v0, 4
    syscall

    #print return value - number of alphabet chars
    move $a0, $t8
    li $v0, 1
    syscall

    #print label
    la $a0, strLabel2
    li $v0, 4
    syscall

    # load the arguments & Call function
    la $a0, array
    jal createHist

    # save the return value
    move $t0, $v0   

    #print label
    la $a0, strLabel3
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

