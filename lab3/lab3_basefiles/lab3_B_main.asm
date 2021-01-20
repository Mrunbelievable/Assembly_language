.include "lab3_B_zhiched.asm"
.include "lab3_functions.asm"

.globl main
.text
main:
    la $a0, myhist
	la $a1, str
	jal countAllChars

	move $t9, $v0
	move $t8, $v1

	li $v0, 4
	la $a0, numspaces
	syscall

	li $v0, 1
	move $a0, $t8
	syscall

    li $v0, 4
    la $a0, endl
    syscall

	li $v0, 4
	la $a0, numsym
	syscall

	li $v0, 1
	move $a0, $t9
	syscall

    li $v0, 4
    la $a0, endl
    syscall

	# either loop and print out hist array, or manually check memory

	li $v0, 10
	syscall


.data
myhist: .word 0,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18,-19,-20,-21,-22,-23,-24,-25
str: .asciiz "HOWRAZORBACKJUMPINGFROGSCANLEVELSIXPIQUEDGYMNASTS"  # 1,H 1,E, 1,L  1,space  2,sym    HELl0 !
endl: .asciiz "\n"
numspaces: .asciiz "NumSpaces: "
numsym: .asciiz "NumSymbols: "

