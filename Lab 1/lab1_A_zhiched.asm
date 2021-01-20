# Zhicheng Ding
# zhiched

.globl main
.text
main:
#print string stored in prompt
la $a0, prompt
li $v0, 4
syscall

#read in int from user 
li $v0, 5
syscall

#add user input to num
lw $t0, num
add $t0, $v0, $t0

#print result
move $a0, $t0
li $v0, 1
syscall

#print \n
la $a0, endl
li $v0, 4
syscall

#modify resultant value to negated
sub $t0, $zero, $t0

#store negated value to label value address
la $s0, value
sw $t0, 0($s0)
lw $s0, value


#print vlaue
li $v0, 1
move $a0, $s0
syscall

#print \n
la $a0, endl
li $v0, 4
syscall

#print the char arrary
la $a0, abcd
li $v0, 4
syscall

#print \n
la $a0, endl
li $v0, 4
syscall

#shit left 8 bits
sll $s1, $s0, 8

#print new vlaue
li $v0, 1
move $a0, $s1
syscall

#store value to memory again
la $s0, value
sw $s1, 0($s0)
#lw $s0, value

#print \n
la $a0, endl
li $v0, 4
syscall

#print the char arrary
la $a0, abcd
li $v0, 4
syscall

#terminate the program
li $v0, 10
syscall





.data
num: .word 2010 # an integer
prompt: .asciiz "Enter an integer:"  # a string
endl: .asciiz "\n"   # a string
.align 2
abcd: .ascii "ABCD"  # 4-character array
value: .word -100    # an integer
moreabcs: .asciiz "EFGHIJK"  # a string
