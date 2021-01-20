.include "hw2_zhiched.asm"


.globl main

# Data Section
.data
strLabel1: .asciiz " countAllChars returned (" 
comma: .asciiz ", "
strLabel2: .asciiz ")\n"

str: .asciiz "ics 51!&?@."
array: .word 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25

# Program 
.text
main:

    # load the arguments
    la $a0, str
    la $a1, array

    # call the function     
    jal countAllChars

    # save the return values
    move $t9, $v0   
    move $t8, $v1   

    #print label
    la $a0, strLabel1
    li $v0, 4
    syscall

    #print return value - numSpaceChar
    move $a0, $t9
    li $v0, 1
    syscall

    #print label
    la $a0, comma
    li $v0, 4
    syscall

    #print return value - numAlphaChars
    move $a0, $t8
    li $v0, 1
    syscall

    #print label
    la $a0, strLabel2
    li $v0, 4
    syscall

    # To see the array values, check the MARS memory for the array 

    #quit program
    li $v0, 10
    syscall

