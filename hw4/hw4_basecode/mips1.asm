.include "hw4_zhiched.asm"	

.data 
file_str: .asciiz "game1.txt"

.text
.globl main	
main:
	li $a0, 0x9
	li $a1, 0xA
	li $a2, 0xE
	jal initBoard
	
	
	la $a0, file_str
	jal loadGame

	addi $sp, $sp, -4
	li $a0, 0x0301
	li $a1, 0x0604
	li $a2, 1
	move $a3, $sp
	jal validBishopMove
	
	
	li $a0, 2
	li $a1, 0x0401
	li $a2, 0x0603
	li $a3, 0x9
	addi $sp, $sp, -4
	li $t0, 0x10010184
	sb $t0, 0($sp)
	jal perform_move
	

