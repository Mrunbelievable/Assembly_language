# Zhicheng ding
# zhiched

.text
F:
    ####################
    # Add prologue here
   	addi $sp, $sp, -12 #adjust sp
    	sw $ra, 0($sp) # save return address
    	sw $a0, 4($sp) #save agrument  n
    	sw $s0, 8($sp) 
    ####################
	move $s0, $a0   # Save argument, n

	li $v0, 4       # Print F label
	la $a0, F_label
	syscall

	li $v0, 1       # Print n value
	move $a0, $s0
	syscall

	li $v0, 11      # Print newline
	li $a0 '\n'
	syscall

	bnez $s0, F_recurse # Check n for recursion
	li $v0, 1           # N == 0, it's base case!
F_done:
    ####################
    # Add epilogue here
    	lw $ra, 0($sp)
    	lw $a0, 4($sp)
    	lw $s0, 8($sp)
    	addi $sp, $sp, 12
    ####################
	jr $ra

F_recurse:
    ####################
    # Calculate & Load F arguments here
    	addi $s0, $s0, -1
   	move $a0, $s0    #a0 = n-1
    ####################
	jal F		# F(n-1)
    ####################
    # Load M arguments here
    	move $a0, $v0
    ####################
	jal M               # M(F(n-1))
    ####################
    # Caluculate return value here 
    # n - F(M(n-1))
    	move $t0, $v0
    	lw $v0, 4($sp)
    	sub $v0, $v0, $t0
    ####################
	j F_done



M:
    ####################
    # Add prologue here
	addi $sp, $sp, -12 #adjust sp
    	sw $ra, 0($sp) # save return address
    	sw $a0, 4($sp) #save n
    	sw $s0, 8($sp) 
    ####################

	move $s0, $a0       # Save argument, n

	li $v0, 4           # Print F label
	la $a0, M_label
	syscall

	li $v0, 1           # Print n value
	move $a0, $s0
	syscall

	li $v0, 11          # Print newline
	li $a0 '\n'
	syscall

	bnez $s0, M_recurse # Check n for recursion
	li $v0, 0           # N == 0, it's base case!
M_done:
    ####################
    # Add epilogue here
    	lw $ra, 0($sp)
    	lw $a0, 4($sp) 
    	lw $s0, 8($sp)
    	addi $sp, $sp, 12
    ####################
	jr $ra

M_recurse:
    ####################
    # Calculate & Load M arguments here
	addi $s0, $s0, -1
   	move $a0, $s0    #a0 = n-1
    ####################
	jal M		    # M(n-1)
    ####################
    # Load F arguments here
    	move $a0, $v0
    ####################
	jal F               # F(M(n-1))
    ####################
    # Caluculate return value here 
    # n - M(F(n-1))
    	move $t0, $v0
    	lw $v0, 4($sp)
    	sub $v0, $v0, $t0
    ####################
	j M_done


.data
F_label: .asciiz "F: "
M_label: .asciiz "M: "

