# DO NOT MODIFY THIS FILE
# TREAT THIS FILE AS A BLACK BOX. ASSUME YOU DO NOT SEE THIS CODE
.data 
cur_noappear_label: .asciiz "Currently these characters have no occurrences: "
cur_min_label: .asciiz "\nCurrent minimum (earliest char): "
cur_max_label: .asciiz "\nCurrent maximum (earliest char): "
cur_space_label: .asciiz "\nCurrent total # spaces: "
cur_symbol_label: .asciiz "\nCurrent total # symbols: "
newline: .asciiz "\n"
newline_border: .asciiz "\n##########################\n"
space: .asciiz " "
none: .asciiz "none\n"
.text
countC:
	li $t9, 0	# count
	li $t8, 1	# 1
	add $t2, $a1, $0   # copy of $a1, c	
	add $t1, $0, $a0   # copy of $a0, str[]	

countC_Loop:
	lb $t0, 0($t1)
	beq $t0, $0, countC_Done
	bne $t0, $t2, countC_nocount
	add $t9, $t9, $t8	# count++
countC_nocount:
	add $t1, $t1, $t8
	j countC_Loop	

countC_Done:
	move $v0, $t9	# move count to return value
	jr $ra

#################################################

printStats:
	addi $sp, $sp, -8
	sw $a0, 0($sp) # num spaces
	sw $a1, 4($sp) # num symbols

	#print no appear label
	li $v0, 4
	la $a0, cur_noappear_label
	syscall

	move $t9, $a2   # address of histarray
    li $t0, 0		# i = 0

	li $t8, 0x7FFFFFFF # value of min
	li $t7, -1		   # index with min 	    
	li $t6, 0          # value of max 
	li $t5, -1         # index with max	    

printStats_findminmax:
    sll $t3, $t0, 2
	add $t1, $t3, $t9  #address of histarray[i]

	lw $t2, 0($t1)    # value in histarray[i]
	bnez $t2, printStats_notzero

	# hist value is empty
	li $v0, 11
	addi $a0, $t0, 65  # print ascii value of char
	syscall 

	li $v0, 4
	la $a0, space
	syscall

	j printStats_findminmax_done
printStats_notzero:
    #check if min
	bge $t2, $t8, printStats_checkmax
	move $t8, $t2   # save histarray[i]
	move $t7, $t0   # save i

printStats_checkmax:
	#check if max
	ble $t2, $t6, printStats_findminmax_done
	move $t6, $t2   # save histarray[i]
	move $t5, $t0   # save i

printStats_findminmax_done:
	addi $t0, $t0, 1
	beq $t0, 26, printStats_minmaxprint
	j printStats_findminmax

printStats_minmaxprint:
	li $v0, 4
	la $a0, cur_min_label
	syscall

	bltz $t7, printStats_nomin
	li $v0, 11
	addi $a0, $t7, 65
	syscall

	li $v0, 4
	la $a0, space
	syscall

	li $v0, 1
	move $a0, $t8 
	syscall

	j printStats_maxprint

printStats_nomin:
	li $v0, 4
	la $a0, none
	syscall

printStats_maxprint:
	li $v0, 4
	la $a0, cur_max_label
	syscall

	bltz $t7, printStats_nomax
	li $v0, 11
	addi $a0, $t5, 65
	syscall

	li $v0, 4
	la $a0, space
	syscall

	li $v0, 1
	move $a0, $t6 
	syscall

	j printStats_printspaces

printStats_nomax:
	li $v0, 4
	la $a0, none
	syscall

printStats_printspaces:
    # print number of spaces
	li $v0, 4
	la $a0, cur_space_label
	syscall

	li $v0, 1
	lw $a0, 0($sp)  
	syscall

    # print number of symbols
	li $v0, 4
	la $a0, cur_symbol_label
	syscall

	li $v0, 1
	lw $a0, 4($sp)  
	syscall

	li $v0, 4
	la $a0, newline_border
	syscall

	addi $sp, $sp, 8

	jr $ra

#################################################

addArray:
    li $t0, 0

addArray_loop:
	beq $t0, $a2, addArray_done
    sll $t1, $t0, 2
	add $t2, $t1, $a1
	add $t3, $t1, $a0
	lw $t4, 0($t3)
	lw $t5, 0($t2)
	add $t6, $t4, $t5
	sw $t6, 0($t2)
	addi $t0, $t0, 1
	j addArray_loop

addArray_done:
	jr $ra	
