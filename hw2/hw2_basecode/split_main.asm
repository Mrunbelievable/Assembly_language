.include "hw2_zhiched.asm"

.globl main

# Data Section
.data
array: .word 0x100
n: .word 2

str: .asciiz "Goodluck finding the requested delimiter in this string!"
delim: .ascii "Z"

strLabel1: .asciiz "The # of tokens is "
strLabel2: .asciiz "\nThe status is "
newline: .asciiz "\n"


# Program 
.text
main:
    # load the value into the argument register
    la $a0, array
    lw $a1, n
    la $a2, str
    lb $a3, delim
    # call the function
    jal split 

    # save the return values
    move $t9, $v0
    move $t8, $v1

    # print string
    li $v0, 4
    la $a0, strLabel1
    syscall

    # print return value
    li $v0, 1
    move $a0, $t9
    syscall

    # print string
    li $v0, 4
    la $a0, strLabel2
    syscall

    # print return value
    li $v0, 1
    move $a0, $t8
    syscall

    # print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Add a loop here to printout each of the strings at the address stored in array
    # or examine the MARS memory for str for correctness

    # Exit the program
    li $v0, 10
    syscall
