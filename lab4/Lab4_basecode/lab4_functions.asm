.data 
print_python: .asciiz "[], "
print_error: .asciiz "Error with list"
.text

printList:
	addi $sp, $sp, 20
	sw $ra, 0($sp)		# save the ra
	sw $a0, 4($sp)		# save the myList address
	sw $a1, 8($sp)		# save listLength
	sw $s0, 12($sp)		# item iterator
	sw $s1, 16($sp)		# flag for first item

	li $s0, 0			# item iterator
	li $s1, 0			# first item not seen

	li $v0, 11			# print '[' if the first list item
	lb $a0, print_python
	syscall

printList_printnextitem:
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	move $a2, $s0	#start at index 0
	jal printListItem

	bltz $v0, printListError	# printListItem returned error


	addi $s0, $s0, 1

	lw $t0, 8($sp) # listLength
	sub $t0, $t0, $s0
	beqz $t0, printList_closeBracket 

	li $v0, 4				# print ", "
	la $a0, print_python
	addi $a0, $a0, 2	
	syscall

	j printList_printnextitem

printList_closeBracket:
	li $v0, 11			# print ']' 
	la $a0, print_python
	lb $a0, 1($a0)
	syscall	

	li $v0, 11		# print newline
	li $a0, '\n'
	syscall

printList_done:
	lw $ra, 0($sp)		# restore the ra
	lw $s0, 12($sp)		# restore
	lw $s1, 16($sp)		# restore
	addi $sp, $sp, 20
    jr $ra


printListError:
	li $v0, -1
	j printList_done
