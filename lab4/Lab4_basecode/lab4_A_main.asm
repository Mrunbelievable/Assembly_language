.include "lab4_A_zhiched.asm"

.globl main
.text
main:

    # load the argument registers
    la $a0, myarray
    lw $a1, rows
    lw $a2, cols
    lb $a3, mychar

    # call the function
    jal findinArray

    # save the return value
    move $s0, $v0
    move $s1, $v1

    # print string
    li $v0, 4
    la $a0, position_str
    syscall

    # print return value
    li $v0, 1
    move $a0, $s0
    syscall

    # print string
    li $v0, 4
    la $a0, comma
    syscall

    # print return value
    li $v0, 1
    move $a0, $s1
    syscall

    # print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit the program
    li $v0, 10
    syscall

.data

#set to [2][10], try [4][5], [5][4], [4][4], [2][4]
# or any combination of row*cols less than 20 for the given array
rows: .word 2
cols: .word 10
mychar: .byte 'h'

# only characters abcdefghijklmnopqrst are accessible for (row*col) == 20
myarray: .ascii "abcdefghijklmnopqrstuvwxyz1234567890"

position_str: .asciiz "Char found at position: "
comma: .asciiz ", "
newline: .asciiz "\n"
