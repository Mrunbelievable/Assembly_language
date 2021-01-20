# Zhicheng ding
# zhiched
.include "lab2_A_zhiched.asm"

.data
basek_num: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"   
value: .word 0
k: .word 0
value_prompt: .asciiz "Enter Value: "
base_prompt: .asciiz "Enter Base: "
value_string: .asciiz "Value "
base_string: .asciiz " in Base-"
is_string: .asciiz " is "


.text
.globl main
main:

    # print string
    li $v0, 4
    la $a0, value_prompt
    syscall

    # user input integer
    li $v0, 5
    syscall

    # Store user value in memory at label value
    la $t0, value
    sw $v0, 0($t0) 

    # print string
    li $v0, 4
    la $a0, base_prompt
    syscall

    # user input integer
    li $v0, 5
    syscall

    # Store user value in memory at label k
    la $t0, k
    sw $v0, 0($t0) 

    ##########################
    # Start your code here
    ##########################




