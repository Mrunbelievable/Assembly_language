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

    #int position = 19
    li $t8, 19
    #pass value to v (stored at $s7)
    lw $t0, value
    move $s7, $t0
    #pass k to $s6
    lw $t0, k
    move $s6, $t0
    
    la $s0, basek_num
    add $t8, $t8, $s0#calculating the address of array
    li $t7, 0 #loop count
while_loop:    
    beq $s7, $zero, done
    #pass parameters
    move $a0, $s7
    move $a1, $s6
    #call function
    jal BasekDigit
    #new value to $s7
    move $s7, $v0
    
    #store digit to string
    sb $v1, 0($t8)
    addi $t8, $t8, -1
    
    addi $t7, $t7, 1
    j while_loop

done:
    #print value
    la $a0, value_string
    li $v0, 4
    syscall
    lw $a0, value
    li $v0, 1
    syscall
    #print basek
    la $a0, base_string
    li $v0, 4
    syscall
    lw $a0, k
    li $v0, 1
    syscall
    #print basek_num
    la $a0, is_string
    li $v0, 4
    syscall
    #la $t0, basek_num
    addi $s0, $s0, 19
    sub $s0, $s0, $t7
    addi $s0, $s0, 1
    #lb $a0, 0($s0)
    #beqz $t0, exit
print_num:
    beqz $t7, exit
    lb $a0, 0($s0)
    li $v0, 11
    syscall
    addi $s0, $s0, 1
    addi $t7, $t7, -1
    j print_num
exit:
    li $v0, 10
    syscall
