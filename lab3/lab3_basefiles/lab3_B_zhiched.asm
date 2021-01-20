# Zhicheng ding
# zhiched

.text
countAllChars:
	###prologue####  
	addi $sp, $sp, -36
	sw $ra, 0($sp) # ra for return address
	sw $a0, 4($sp) # a0 = myhist[]
	sw $a1, 8($sp) # a1 = char str[]
	sw $s1, 12($sp) #sym
	sw $s2, 16($sp) #space
	sw $s7, 20($sp) # agrument str
	sw $s6, 24($sp)
	sw $s3, 28($sp)
	sw $s4, 32($sp)
	
	#body
	li $s3, 33 # !
	li $s4, 64 # @
	li $s1, 0 #initial sym=0
	li $s2, 0 #initial space=0
	
	move $s6, $a0 # s6 = myhist[] address
	move $s7, $a1 # s7 = agrument str
	#start count symbol
	#use loop for go trough each synbol checking if it is in the str
	# !(33) - @(64)
first_part:
	bgt $s3, $s4 done
	move $a0, $s7
	move $a1, $s3
	jal countC
	add $s1, $s1, $v0 # s1 = sym
	addi $s3, $s3, 1 # ascii + 1
	j first_part
	
done:	

	# space count
	li $t3, 32
	move $a0, $s7
	move $a1, $t3
	jal countC
	# store the count number
	move $s2, $v0 # s2 = spcae
	# start oevrwirte int[]	
	li $s3, 65
	li $s4, 90
	#sw $s3, 36($sp)
	#sw $s4, 40($sp)
second_part:
	bgt $s3, $s4 second_done
	move $a0, $s7
	move $a1, $s3
	jal countC
	sw $v0, 0($s6)
	addi $s6, $s6, 4
	addi $s3, $s3, 1
	j second_part

second_done:	
	move $v0, $s1 # sym
    	move $v1, $s2 # spcae
    	
	#epilogue
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $s1, 12($sp)
	lw $s2, 16($sp)
	lw $s7, 20($sp)
	lw $s6, 24($sp)
	lw $s3, 28($sp)
	lw $s4, 32($sp)
    	addi $sp, $sp, 36
    	
	jr $ra

