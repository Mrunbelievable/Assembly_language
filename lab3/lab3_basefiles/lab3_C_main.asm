.include "lab3_B_zhiched.asm"
.include "lab3_C_zhiched.asm"
.include "lab3_functions.asm"

.globl main
.text
main:

	li $v0, 4
	la $a0, stat1
	syscall

	li $v0, 1
	la $t0, n
	lw $a0, 0($t0)
	syscall

	li $v0, 4
	la $a0, stat2
	syscall
	
	li $v0, 4
	la $a0, endl
	syscall 

	li $s0, 0   # i counter
	la $s2, strings # strings[]
	la $s7, n
	lw $s7, 0($s7)  # n

printStr:
	bge $s0, $s7, process
	sll $t7, $s0, 2
	add $t8, $t7, $s2

	li $v0, 4
	la $a0, qoute
	syscall
	lw $a0, 0($t8)	  # strings[i]
	syscall
	la $a0, qoute
	syscall
	la $a0, endl
	syscall 
	addi $s0, $s0, 1
	j printStr

process:
	move $a0, $s2
	move $a1, $s7
	jal processStrings

	li $v0, 4
	la $a0, stat1
	syscall

	li $v0, 1
	la $t0, n
	lw $a0, 0($t0)
	addi $a0, $a0, 1
	syscall

	li $v0, 4
	la $a0, stat2
	syscall
	
	li $v0, 4
	la $a0, endl
	syscall 

	li $s0, 0   # i counter
	la $s2, strings2 # strings[]
	la $s7, n
	lw $s7, 0($s7)  # n
	addi $s7, $s7, 1

printStr2:
	bge $s0, $s7, process2
	sll $t7, $s0, 2
	add $t8, $t7, $s2

	li $v0, 4
	la $a0, qoute
	syscall
	lw $a0, 0($t8)	  # strings[i]
	syscall
	la $a0, qoute
	syscall
	la $a0, endl
	syscall 
	addi $s0, $s0, 1
	j printStr2

process2:
	move $a0, $s2
	move $a1, $s7
	jal processStrings

	li $v0, 10
	syscall

.data
strings: .word str_abc, str_hello, str_b, str_foo
strings2: .word str_xyz, str_world, str_123, str_bar, str_help
n: .word 4

str_foo: .asciiz "FOO"
str_bar: .asciiz "BARRRR"
str_hello: .asciiz "HeLLO!"
str_world: .asciiz "@! wOrLd $!&"
str_abc: .asciiz "Abc"
str_xyz: .asciiz "XXyZ"
str_123: .asciiz "123"
str_b: .asciiz "b"
str_help: .asciiz "HELP! HELP! HELP!"



stat1: .asciiz "There are "
stat2: .asciiz " strings in the array.\nThe strings are "
qoute: .asciiz "\""
endl: .asciiz "\n"
