# Zhicheng ding
# zhiched

.text
processStrings:
	####prologue####
	addi $sp, $sp, -40
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $s0, 8($sp)
	sw $s1, 12($sp)
	sw $s2, 16($sp)
	sw $s3, 20($sp)
	sw $s4, 24($sp)
	sw $s5, 28($sp)
	sw $s6, 32($sp)
	sw $s7, 36($sp)
	#####Body#######
	li $s0, 0 # local variable, s0 = total_sym
	li $s1, 0 # local variable , s1 = total_space
	
	move $s2, $a0 # s2 = address of strArray[]
	move $s3, $a1 # s3 = numStr
	li $s4, 0 #index 0
	addi $s5, $s3, -1 # numStr-1 
	
	la $s6, cur_histarray
	la $s7, total_histarray
process_loop:	
	bgt $s4, $s5, done_process
	move $a0, $s6 # a0 = cur_histarray 
	lw $a1, 0($s2) # a1 = s load the char s in strArray
	
	jal countAllChars
	# reutrn the value 
	add $s0, $s0, $v0 # total_sym += a
	add $s1, $s1, $v1 # total_space += b
	
	# agrument set up for function addArray
	# a0 = cur_histarray, a1 = total_histarray, a3 = 26
	move $a0, $s6
	move $a1, $s7
	li $a2, 26
	jal addArray

	# agrument set up for function printStats
	# a0 = total_space, a1 = total_sym, a2 = total_histarray
	move $a0, $s1
	move $a1, $s0
	move $a2, $s7
	jal printStats
	
	addi $s4, $s4, 1 #loop count ++
	addi $s2, $s2, 4 # address of str[] ++ 
	j process_loop
	
done_process:	
	####epilogue####
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $s0, 8($sp)
	lw $s1, 12($sp)
	lw $s2, 16($sp)
	lw $s3, 20($sp)
	lw $s4, 24($sp)
	lw $s5, 28($sp)
	lw $s6, 32($sp)
	lw $s7, 36($sp)
	addi $sp, $sp, 40
	
	jr $ra



.data
total_histarray: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
cur_histarray: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
