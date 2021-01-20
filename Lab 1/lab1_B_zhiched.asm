# Zhicheng ding	
# zhiched

.globl main
.text
main:
#ask user to input char
li $v0, 4
la $a0, prompt
syscall

#read 4 char from user
li $a1, 5
li $v0, 8
syscall 

#store the string to str
la $s0, str
sw $a0, 0($s0)
lw $s0, str

#print \n
la $a0, endl
li $v0, 4
syscall

#print the string
li $v0, 4
lw $a0, str
syscall

#print \n
la $a0, endl
li $v0, 4
syscall

#load first 4-bytes into register
lw $s1, 0($s0)
#print the value in register
move $a0, $s1
li $v0, 1
syscall 

#print \n
la $a0, endl
li $v0, 4
syscall

#print value in binary
move $a0, $s1
li $v0, 35
syscall

#print \n
la $a0, endl
li $v0, 4
syscall

#print value in hexadecimal
move $a0, $s1
li $v0, 34
syscall

#add 1 to value 
li $t0, 1
add $s1, $s1, $t0
la $s0, str
sw $s1, 0($s0)

#print \n
la $a0, endl
li $v0, 4
syscall

#print the modified str
li $v0, 4
la $a0, str
syscall

#place value of 2nd char into register
lb $t1, 2($s0)

#print \n
la $a0, endl
li $v0, 4
syscall

#if statement begin
li $t2, 0
li $t3, 2
div $t1, $t3
mfhi $t3
beq $t3, $t2, else
li $v0, 4
la $a0, even
syscall 

#quit program
li $v0, 10
syscall

else:
li $v0, 4
la $a0, odd
syscall 

.data
prompt: .asciiz "Enter 4 characters: "
endl: .asciiz "\n"
.align 2
str: .asciiz "????"
even: .asciiz "EVEN"
odd: .asciiz "ODD"
