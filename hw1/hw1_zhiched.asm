# Homework 1
# Zhicheng Ding
# Net ID: zhiched 
.globl main

.data
newline: .asciiz "\n"
err_string: .asciiz "INPUT ERROR"

prompt_type: .asciiz "Random Numbers (r/R) or ASCII string (a/A)? "
prompt_ascii: .asciiz "Enter a ASCII string (max 100 characters): "
prompt_seed: .asciiz "Enter the seed: "
prompt_numbers: .asciiz "How many numbers? "

rand_last: .asciiz "Last value drawn: "
rand_odd: .asciiz "# of Odd: "
rand_power: .asciiz "Power of 2: "
rand_mult: .asciiz "Multiple of 8: "
rand_values: .asciiz "Values <= 512: "

ascii_length: .asciiz "Length of string: "
ascii_space: .asciiz "# of space characters: "
ascii_upper: .asciiz "# of uppercase letters: "
ascii_symbols: .asciiz "# of symbols: "
ascii_pairs: .asciiz "# of character pairs: "

.text

main:
    # prompting user for type of statistics they wish to collect
    la $a0, prompt_type
    li $v0, 4
    syscall
    
    #read the user input
    li $v0, 12
    syscall
    
    #test user input
    li $t0, 'a' 
    li $t1, 'A'
    li $t2, 'r'
    li $t3, 'R'
    beq $v0, $t0 else #if input = a go to else
    beq $v0, $t1 else#if input = A go to else 
    beq $v0, $t2 else2 #if input = r go to else
    beq $v0, $t3 else2#if input = R go to else 
    
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, err_string
    li $v0, 4
    syscall
    #eixt the program
    li $v0, 10
    syscall
    
    else:
    la $a0, newline
    li $v0, 4
    syscall
    la $a0, prompt_ascii
    li $v0, 4
    syscall
    
    #let user input string
    li $a1, 100
    li $v0, 8
    syscall
    
    #start for checking the user input
    
    li $t0, 0 #count = 0
    li $t2, 32
    li $t3, 0 #space count
    li $t4, 64
    li $t5, 90
    li $t6, 0 #Letter count
    li $t8, 47
    li $t9, 57
    li $s6, 96
    li $s5, 123
    li $s7, 0#symbol count
    li $s3, 0#pair count
loop2:
    lb $t1, 0($a0)
    lb $s2, 1($a0)
    beq $t1, $s2 pair_count
    j continue
    pair_count:
    addi $s3, $s3, 1
continue:    
    beqz $t1, end
    addi $a0, $a0, 1
    addi $t0, $t0, 1    
    ble $t1, $t2, space_count #t1<32
    ble $t1, $t8, symbol_count#t1<47
    j letter
letter:# t1>47
    ble $t1, $t9, symbol_end # 48<=t1<58
    ble $t1, $t4, symbol_count# 58<=t1<=64
    ble $t1, $t5, next_check # 65<=t1<=90
    ble $t1, $s6, symbol_count# 91<=t1<=96
    bge $t1, $s5, symbol_count# t1>123
    j loop2
    
symbol_end:
    j loop2
symbol_count:
    addi $s7, $s7, 1
    j loop2
space_count:
    beq $t1, $t2, space_count_2
    j loop2
symbol_count2:
    bgt $t1, $t2 space_count_2
    j loop2     
space_count_2:
    addi $t3, $t3, 1
    j letter
next_check: # t1: 65-90
    addi $t6, $t6, 1    
    j loop2

end:
    #print length
    la $a0, ascii_length
    li $v0, 4
    syscall
    addi $t0, $t0, -1
    move $a0, $t0
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall
    #print space
    la $a0, ascii_space
    li $v0, 4
    syscall
    move $a0, $t3
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall
    #print uppercase letter
    la $a0, ascii_upper
    li $v0, 4
    syscall
    move $a0, $t6
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall
    #print symbol
    la $a0, ascii_symbols
    li $v0, 4
    syscall
    move $a0, $s7
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    #print character pairs
    la $a0, ascii_pairs
    li $v0, 4
    syscall
    move $a0, $s3
    li $v0, 1
    syscall
    
    #eixt the program
    li $v0, 10
    syscall
        
else2:
    la $a0, newline
    li $v0, 4
    syscall
    la $a0, prompt_seed
    li $v0, 4
    syscall
    
    #let user input the seed
    li $v0, 5
    syscall
    #store this value to a safe palce
    move $s6, $v0
    
    #prompt "how many number"
    la $a0, prompt_numbers
    li $v0, 4
    syscall
    
    #let user input th number
    li $v0, 5
    syscall 
    move $t5, $v0
    
    #check if this value is positive of negative
    bgtz $v0, next
    
    #print error message
    la $a0, err_string
    li $v0, 4
    syscall
        
    #eixt the program
    li $v0, 10
    syscall
    
next:# if user input value is positive
    li $t7, 1#count loop times
    li $t2, 0#for count odd
    li $t3, 0#for count powe of 2
    li $t4, 0#for count multiple
    li $t6, 0#for count value <=512
    li $t8, 1# for chekcing power
    #set id of pseudorandom number generator 1
    move $a1, $s6
    li $a0, 1
    li $v0, 40
    syscall
loop:
    bgt $t7, $t5 done# times of loop
    #set reange from 1-1024 
    #set upper bounds to 1023 
    #and add 1 to the value returned by the syscall
    li $a1, 1023
    li $a0, 1    
    li $v0, 42
    syscall
    addi $a0, $a0, 1     	 
    
    #begin check the drwan number 
    # of odd:
    li $t0, 2
    div $a0, $t0
    mfhi $s1
    li $t1, 1
    beq $s1, $t1 count#count the times of odd number apperance
    j power_check
count:
    addi $t2, $t2, 1
    
power_check:    
    blt $t8, $a0, power_check_start
    j multiple
power_check_start:    
    beq $a0, $t8 power_count#count the times of power of 2 appear
    sll $t8, $t8, 1
    #ble $t8, $a0, power_check2
    #j multiple
    j power_check
#power_check2:
#    beq $a0, $t8, power_count
#    j power_check    
power_count:
    addi $t3, $t3, 1 
 
multiple: 
    li $t0, 8
    div $a0, $t0
    mfhi $s2
    beq $s2, $zero count3
    j less
    count3:
    addi $t4, $t4, 1
    
less:
    li $s3, 512
    blt $a0, $s3 count4
    j count_loop
count4:
    addi $t6, $t6, 1
    j count_loop
count_loop:    
    addi $t7, $t7, 1
    j loop
done:
    #drwan number move to a safe register
    move $s7, $a0
    #last value of drawn
    la $a0, rand_last
    li $v0, 4
    syscall
    
    #print this integer
    move $a0, $s7
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # of Odd:
    la $a0, rand_odd
    li $v0, 4
    syscall
    
    #print odd:
    move $a0, $t2
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall
    
    #power of 2:
    la $a0, rand_power
    li $v0, 4
    syscall
    
    #print number
    move $a0, $t3
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall
    
    #print multiple of 8
    la $a0, rand_mult
    li $v0, 4
    syscall
    
    move $a0, $t4
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall    
    #print value<=512
    la $a0, rand_values
    li $v0, 4
    syscall
    
    move $a0, $t6
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall   
    
    #eixt the program
    li $v0, 10
    syscall    
    

    
    
    
    
