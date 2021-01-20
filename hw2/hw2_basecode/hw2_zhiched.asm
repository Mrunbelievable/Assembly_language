# Zhicheng Ding
# zhiched

.text

findIndex:
    bltz $a1, error
    li $t7, 0 #count loop
    li $t6, 0 #count max index
    li $t5, 0#min index
    lw $t0, 0($a0)
    move $s0, $t0 #s0 contain max number
    move $s1, $t0 #contian min 
    addi $a1, $a1, -1
loop:
    #li $t9, '\0'
    #beq $t1, $t9, exit
    bgt $t7, $a1, exit
    lw $t1, 4($a0)
    #beq $t1, $t9, exit
    bgt $s0, $t1, great
    move $s0, $t1#stroe the great one to a temp register
    addi $t6, $t6, 1 #max index increse
    blt $s1, $t1 less
    move $s1, $t1
    move $t5, $t7
    addi $a0, $a0, 4
    addi $t7, $t7, 1
    j loop
great:
    blt $s1, $t1 less
    move $s1, $t1
    move $t5, $t7
    addi $t5, $t5, 1
    addi $a0, $a0, 4
    addi $t7, $t7, 1
    j loop
less:
    addi $a0, $a0, 4
    addi $t7, $t7, 1
    j loop
exit:
    move $v0, $t6
    move $v1, $t5
    jr $ra
error:
    li $v0, -1   
    li $v1, -1   
    jr $ra


maxCharFreq:
    lb $s0, 0($a0)
    li $t1, '\0' #last char
    li $t2, 0
    beq $s0, $t2, charError
    li $t3, 0# assume max freq 
for:
    li $t4, 0
    lb $s0, 0($a0)
    beq $s0, $t1, endChecking
    li $t0, 0#freq_count
for2:
    addi $a0, $a0, 1
    addi $t4, $t4, 1
    lb $s1, 0($a0)
    beq $s1, $t1, next_position
    beq $s0, $s1, max_count
    j for2
max_count:
    addi $t0, $t0, 1
    j for2    
update:
    move $t3, $t0 # assign max freq to t3
    move $s3, $s0# assign the freq value 
    sub $a0, $a0, $t4 #sub the count times
    addi $a0, $a0, 1 #move to next array 
    j for 
next_position:
    bgt $t0, $t3, update
    sub $a0, $a0, $t4
    addi $a0, $a0, 1
    j for    
endChecking:
    move $v0, $s3
    addi $t3, $t3, 1
    move $v1, $t3
    jr $ra
                
charError:   
    li $v0, -1 
    li $v1, -1  
    jr $ra

countAllChars:
li $t0, 0
li $t1, 25
initial: #initial the array 
bgt $t0, $t1, finish
li $t2, 0
sw $t2, 0($a1) #the array address 
addi $a1, $a1, 4
addi $t0, $t0, 1
j initial
finish:
li $t0, 104
sub $a1, $a1, $t0 
li $t0, '\0'
li $t2, 65
li $t3, 90
li $t4, 97
li $t5, 122
li $t6, 0 #space counter
li $t7, 0 #alpha counter

while_countAll:
    lb $s0, 0($a0)
    beq $s0, $t0, done
    li $t1, 32
    beq $s0, $t1, space_count # =32
    li $t3, 65
    li $t4, 97
    beq $s0, $t3, countA
    beq $s0, $t4, countA
    li $t3, 66
    li $t4, 98
    beq $s0, $t3, countB
    beq $s0, $t4, countB
    li $t3, 67
    li $t4, 99
    beq $s0, $t3, countC
    beq $s0, $t4, countC
    li $t3, 68
    li $t4, 100
    beq $s0, $t3, countD
    beq $s0, $t4, countD
    li $t3, 69
    li $t4, 101
    beq $s0, $t3, countE
    beq $s0, $t4, countE
    li $t3, 70
    li $t4, 102
    beq $s0, $t3, countF
    beq $s0, $t4, countF
    li $t3, 71
    li $t4, 103
    beq $s0, $t3, countG
    beq $s0, $t4, countG
    li $t3, 72
    li $t4, 104
    beq $s0, $t3, countH
    beq $s0, $t4, countH
    li $t3, 73
    li $t4, 105
    beq $s0, $t3, countI
    beq $s0, $t4, countI
    li $t3, 74
    li $t4, 106
    beq $s0, $t3, countJ
    beq $s0, $t4, countJ
    li $t3, 75
    li $t4, 107
    beq $s0, $t3, countK
    beq $s0, $t4, countK
    li $t3, 76
    li $t4, 108
    beq $s0, $t3, countL
    beq $s0, $t4, countL
    li $t3, 77
    li $t4, 109
    beq $s0, $t3, countM
    beq $s0, $t4, countM
    li $t3, 78
    li $t4, 110
    beq $s0, $t3, countN
    beq $s0, $t4, countN
    li $t3, 79
    li $t4, 111
    beq $s0, $t3, countO
    beq $s0, $t4, countO
    li $t3, 80
    li $t4, 112
    beq $s0, $t3, countP
    beq $s0, $t4, countP
    li $t3, 81
    li $t4, 113
    beq $s0, $t3, countQ
    beq $s0, $t4, countQ
    li $t3, 82
    li $t4, 114
    beq $s0, $t3, countR
    beq $s0, $t4, countR
    li $t3, 83
    li $t4, 115
    beq $s0, $t3, countS
    beq $s0, $t4, countS
    li $t3, 84
    li $t4, 116
    beq $s0, $t3, countT
    beq $s0, $t4, countT
    li $t3, 85
    li $t4, 117
    beq $s0, $t3, countU
    beq $s0, $t4, countU
    li $t3, 86
    li $t4, 118
    beq $s0, $t3, countV
    beq $s0, $t4, countV
    li $t3, 87
    li $t4, 119
    beq $s0, $t3, countW
    beq $s0, $t4, countW
    li $t3, 88
    li $t4, 120
    beq $s0, $t3, countX
    beq $s0, $t4, countX
    li $t3, 89
    li $t4, 121
    beq $s0, $t3, countY
    beq $s0, $t4, countY
    li $t3, 90
    li $t4, 122
    beq $s0, $t3, countZ
    beq $s0, $t4, countZ
    addi $a0, $a0, 1
    j while_countAll
countA:
    addi $t7, $t7, 1
    lw $t3, 0($a1)
    addi $t3, $t3, 1
    sw $t3, 0($a1)
    addi $a0, $a0, 1
    j while_countAll
countB:
    addi $t7, $t7, 1
    lw $t3, 4($a1)
    addi $t3, $t3, 1
    sw $t3, 4($a1)
    addi $a0, $a0, 1
    j while_countAll
countC:
    addi $t7, $t7, 1
    lw $t3, 8($a1)
    addi $t3, $t3, 1
    sw $t3, 8($a1)
    addi $a0, $a0, 1
    j while_countAll
countD:
    addi $t7, $t7, 1
    lw $t3, 12($a1)
    addi $t3, $t3, 1
    sw $t3, 12($a1)
    addi $a0, $a0, 1
    j while_countAll
countE:
    addi $t7, $t7, 1
    lw $t3, 16($a1)
    addi $t3, $t3, 1
    sw $t3, 16($a1)
    addi $a0, $a0, 1
    j while_countAll
countF:
    addi $t7, $t7, 1
    lw $t3, 20($a1)
    addi $t3, $t3, 1
    sw $t3, 20($a1)
    addi $a0, $a0, 1
    j while_countAll
countG:
    addi $t7, $t7, 1
    lw $t3, 24($a1)
    addi $t3, $t3, 1
    sw $t3, 24($a1)
    addi $a0, $a0, 1
    j while_countAll 
countH:
    addi $t7, $t7, 1
    lw $t3, 28($a1)
    addi $t3, $t3, 1
    sw $t3, 28($a1)
    addi $a0, $a0, 1
    j while_countAll
countI:
    addi $t7, $t7, 1
    lw $t3, 32($a1)
    addi $t3, $t3, 1
    sw $t3, 32($a1)
    addi $a0, $a0, 1
    j while_countAll
countJ:
    addi $t7, $t7, 1
    lw $t3, 36($a1)
    addi $t3, $t3, 1
    sw $t3, 36($a1)
    addi $a0, $a0, 1
    j while_countAll
countK:
    addi $t7, $t7, 1
    lw $t3, 40($a1)
    addi $t3, $t3, 1
    sw $t3, 40($a1)
    addi $a0, $a0, 1
    j while_countAll
countL:
    addi $t7, $t7, 1
    lw $t3, 44($a1)
    addi $t3, $t3, 1
    sw $t3, 44($a1)
    addi $a0, $a0, 1
    j while_countAll
countM:
    addi $t7, $t7, 1
    lw $t3, 48($a1)
    addi $t3, $t3, 1
    sw $t3, 48($a1)
    addi $a0, $a0, 1
    j while_countAll     
countN:
    addi $t7, $t7, 1
    lw $t3, 52($a1)
    addi $t3, $t3, 1
    sw $t3, 52($a1)
    addi $a0, $a0, 1
    j while_countAll
countO:
    addi $t7, $t7, 1
    lw $t3, 56($a1)
    addi $t3, $t3, 1
    sw $t3, 56($a1)
    addi $a0, $a0, 1
    j while_countAll   
countP:
    addi $t7, $t7, 1
    lw $t3, 60($a1)
    addi $t3, $t3, 1
    sw $t3, 60($a1)
    addi $a0, $a0, 1
    j while_countAll
countQ:
    addi $t7, $t7, 1
    lw $t3, 64($a1)
    addi $t3, $t3, 1
    sw $t3, 64($a1)
    addi $a0, $a0, 1
    j while_countAll
countR:
    addi $t7, $t7, 1
    lw $t3, 68($a1)
    addi $t3, $t3, 1
    sw $t3, 68($a1)
    addi $a0, $a0, 1
    j while_countAll      
countS:
    addi $t7, $t7, 1
    lw $t3, 72($a1)
    addi $t3, $t3, 1
    sw $t3, 72($a1)
    addi $a0, $a0, 1
    j while_countAll  
countT:
    addi $t7, $t7, 1
    lw $t3, 76($a1)
    addi $t3, $t3, 1
    sw $t3, 76($a1)
    addi $a0, $a0, 1
    j while_countAll      
countU:
    addi $t7, $t7, 1
    lw $t3, 80($a1)
    addi $t3, $t3, 1
    sw $t3, 80($a1)
    addi $a0, $a0, 1
    j while_countAll    
countV:
    addi $t7, $t7, 1
    lw $t3, 84($a1)
    addi $t3, $t3, 1
    sw $t3, 84($a1)
    addi $a0, $a0, 1
    j while_countAll      
countW:
    addi $t7, $t7, 1
    lw $t3, 88($a1)
    addi $t3, $t3, 1
    sw $t3, 88($a1)
    addi $a0, $a0, 1
    j while_countAll      
countX:
    addi $t7, $t7, 1
    lw $t3, 92($a1)
    addi $t3, $t3, 1
    sw $t3, 92($a1)
    addi $a0, $a0, 1
    j while_countAll 
countY:
    addi $t7, $t7, 1
    lw $t3, 96($a1)
    addi $t3, $t3, 1
    sw $t3, 96($a1)
    addi $a0, $a0, 1
    j while_countAll   
countZ:
    addi $t7, $t7, 1
    lw $t3, 100($a1)
    addi $t3, $t3, 1
    sw $t3, 100($a1)
    addi $a0, $a0, 1
    j while_countAll                                      
space_count:
    addi $t6, $t6, 1
    addi $a0, $a0, 1
    j while_countAll
done:    
    move $v0, $t6   
    move $v1, $t7 
    jr $ra

createHist:
    #load the array to s0
    li $t0, 25
    li $t1, 0 #loop count
    li $t2, 0 #return value count
    move $a3, $a0
loop_start:
    bgt $t1, $t0, done_Hist
    lw $s0, 0($a3)
    #for check if contain negative
    blt $s0, $zero, error_output
    #addi $t2, $t2, 1 #return value +1
    #the array[index] >0
    li $t4, 0
    bgt $s0, $t4, print_Hist
    addi $a3, $a3, 4
    addi $t1, $t1, 1
    j loop_start
print_Hist:
    li $t5, 0
    beq $t1, $t5, print_a
    li $t5, 1
    beq $t1, $t5, print_b
    li $t5, 2
    beq $t1, $t5, print_c
    li $t5, 3
    beq $t1, $t5, print_d     
    li $t5, 4
    beq $t1, $t5, print_e  
    li $t5, 5
    beq $t1, $t5, print_f
    li $t5, 6
    beq $t1, $t5, print_g
    li $t5, 7
    beq $t1, $t5, print_h
    li $t5, 8
    beq $t1, $t5, print_i
    li $t5, 9
    beq $t1, $t5, print_j
    li $t5, 10
    beq $t1, $t5, print_k
    li $t5, 11
    beq $t1, $t5, print_l
    li $t5, 12
    beq $t1, $t5, print_m
    li $t5, 13
    beq $t1, $t5, print_n
    li $t5, 14
    beq $t1, $t5, print_o
    li $t5, 15
    beq $t1, $t5, print_p
    li $t5, 16
    beq $t1, $t5, print_q
    li $t5, 17
    beq $t1, $t5, print_r
    li $t5, 18
    beq $t1, $t5, print_s
    li $t5, 19
    beq $t1, $t5, print_t
    li $t5, 20
    beq $t1, $t5, print_u
    li $t5, 21
    beq $t1, $t5, print_v
    li $t5, 22
    beq $t1, $t5, print_w
    li $t5, 23
    beq $t1, $t5, print_x
    li $t5, 24
    beq $t1, $t5, print_y
    li $t5, 25
    beq $t1, $t5, print_z
    addi $a0, $a0, 1
    addi $t1, $t1, 1
    j loop_start   
print_a:
    li $t7, 'a'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
a:    
    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j a
print_b:
    li $t7, 'b'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
b:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j b
print_c:
    li $t7, 'c'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
c:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j c
print_d:
    li $t7, 'd'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
d:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j d
print_e:
    li $t7, 'e'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
e:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j e
print_f:
    li $t7, 'f'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
f:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j f
print_g:
    li $t7, 'g'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
g:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j g
print_h:
    li $t7, 'h'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
h:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j h
print_i:
    li $t7, 'i'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
i:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j i
print_j:
    li $t7, 'j'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
toj:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j toj
print_k:
    li $t7, 'k'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
k:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j k
print_l:
    li $t7, 'l'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
l:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j l
print_m:
    li $t7, 'm'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
m:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j m
print_n:
    li $t7, 'n'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
for_n:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j for_n
print_o:
    li $t7, 'o'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
o:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j o
print_p:
    li $t7, 'p'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
p:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j p
print_q:
    li $t7, 'q'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
q:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j q
print_r:
    li $t7, 'r'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
r:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j r
print_s:
    li $t7, 's'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
s:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j s
print_t:
    li $t7, 't'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
t:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j t
print_u:
    li $t7, 'u'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
u:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j u
print_v:
    li $t7, 'v'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
v:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j v
print_w:
    li $t7, 'w'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
w:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j w
print_x:
    li $t7, 'x'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
x:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j x
print_y:
    li $t7, 'y'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
y:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j y
print_z:   
    li $t7, 'z'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, ':'
    li $t8, 0
    move $a0, $t7
    li $v0, 11
    syscall
    li $t7, '*'
z:    bge $t8, $s0, done_print
    move $a0, $t7
    li $v0, 11
    syscall
    addi $t8, $t8, 1
    j z
done_print: 
    addi $t2, $t2, 1 #return value +1
    addi $t1, $t1, 1
    addi $a3, $a3, 4
    li $t7, '\n'
    move $a0, $t7
    li $v0, 11
    syscall
    j loop_start
error_output:      
    li $v0, -1
    jr $ra
done_Hist:
    move $v0, $t2
    jr $ra
split:
    lb $s0, 0($a2)#str[]
    li $t0, '\0' 
    li $t1, 0x00#0
    li $t2, 0x7F#127	
    beq $s0, $t1, splitInputError
    blt $a3, $t1, splitInputError
    bgt $a3, $t2, splitInputError
    li $t1, 0 # for i, index of str[] 
    li $t2, -1 # for j, index of int[]
    li $t3, 0 # count the oucrrence of changes 
    move $s3, $a2 #first address of first char instring 
split_while:
    lb $s0, 0($a2)
    beq $s0, $t0, go_return
    beq $s0, $a3, go_split
    addi $a2, $a2, 1 
    addi $t1, $t1, 1 #i++ not found 
    j split_while
go_split:
    addi $t2, $t2, 1
    sb $t0, 0($a2) #svae '\o' in delimiter found location
    ble $t3, $zero, go_split_first
    addi $a0, $a0, 4
    li $t4, 0
    addi $t4, $a2, 1
    sw $t4, 0($a0)# store new term address into int[] 
    addi $t3, $t3, 1
    addi $a2, $a2, 1# str[] index ++
    j split_while
go_split_first:
    sw $s3, 0($a0)# store first term address at first index 
    addi $a0, $a0, 4
    li $t4, 0
    addi $t4, $a2, 1
    sw $t4, 0($a0) # store second term address at at second index
    addi $t3, $t3, 1
    addi $a2, $a2, 1# str[] index ++
    j split_while
go_return:
    li $t4, 0 #check if found char in string or not
    sub $t4, $a2, $s3
    beq $t4, $t1, NotFound
    addi $t2, $t2, 1
    beq $t2, $t3, go_return_2
    li $v1, -1  
    move $v0, $t3
    jr $ra  
go_return_2:
    li $v1, 0    
    addi $t3, $t3, 1
    move $v0, $t3
    jr $ra
splitInputError:
    li $v0, -1
    li $v1, -1    
    jr $ra
NotFound:
    sw $s3, 0($a0)
    li $v0, 1
    li $v1, 0
    jr $ra
