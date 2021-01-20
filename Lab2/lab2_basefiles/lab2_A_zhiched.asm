# Zhicheng ding
# zhiched

.data
newline: .asciiz "\n"
Error: .asciiz "Value must be > 0. Base must be in the range [1,16]\n"
Quotient_string: .asciiz "Quotient is "
Remainder_string: .asciiz ", Remainder is "

.text
BasekDigit:
li $t0, 16
li $t1, 1

bgt $a1, $t0, print
blt $a1, $t1, print
blt $a0, $zero, print

#a0 = value, a1 = base k
div $a0, $a1
mflo $s1 #quotient
mfhi $s2 #remainder

#print quotient_string
la $a0, Quotient_string
li $v0, 4
syscall
move $a0, $s1
li $v0, 1
syscall

#print remainder_string
la $a0, Remainder_string
li $v0, 4
syscall
move $a0, $s2
li $v0, 1
syscall

#new line
la $a0, newline
li $v0, 4
syscall

#switch statement
li $t0, 15
li $t1, 14
li $t2, 13
li $t3, 12
li $t4, 11
li $t5, 10

case15:
bne $s2, $t0, case14
move $v0, $s1
li $t9, 'F'
move $v1, $t9
jr $ra
case14:
bne $s2, $t1, case13
move $v0, $s1
li $t9, 'E'
move $v1, $t9
jr $ra
case13:
bne $s2, $t2, case12
move $v0, $s1
li $t9, 'D'
move $v1, $t9
jr $ra
case12:
bne $s2, $t3, case11
move $v0, $s1
li $t9, 'C'
move $v1, $t9
jr $ra

case11:
bne $s2, $t4, case10
move $v0, $s1
li $t9, 'B'
move $v1, $t9
jr $ra

case10:
bne $s2, $t5, default
move $v0, $s1
li $t9, 'A'
move $v1, $t9
jr $ra

default:
move $v0, $s1
addi $s2, $s2, 48
move $v1, $s2
jr $ra

print:
la $a0, Error
li $v0, 4
syscall
#quit_program
li $v0, 10
syscall










