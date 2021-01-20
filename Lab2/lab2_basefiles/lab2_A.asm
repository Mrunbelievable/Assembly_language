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


print:
la $a0, Error
li $v0, 4
syscall











