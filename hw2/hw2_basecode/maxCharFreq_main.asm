.include "hw2_zhiched.asm"

.globl main

# Data Section
.data
strLabel: .asciiz "maxCharFreq of \""
qoute: .asciiz"\" is "
str: .asciiz "abbbcccc"
newline: .asciiz "\n"




# Program 
.text
main:

    # load the arguments
    la $a0, str

    # call the function
    jal maxCharFreq

    # save the return values
    move $t9, $v0
    move $t8, $v1

    #print Label string
    la $a0, strLabel
    li $v0, 4
    syscall

    #print string
    la $a0, str
    li $v0, 4
    syscall

    #print Label string
    la $a0, qoute
    li $v0, 4
    syscall
    
    #print char
    move $a0, $t9
    li $v0, 11
    syscall

    #print comma
    li $a0, ','
    li $v0, 11
    syscall

    #print integer frequency
    move $a0, $t8
    li $v0, 1
    syscall

    #print newline 
    la $a0, newline
    li $v0, 4
    syscall

    #quit program
    li $v0, 10
    syscall

