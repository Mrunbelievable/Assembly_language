.data
temp_array: .space 100


.text
#################### atoui ####################
	# Converts string containing an unsigned int into an integer.
	# $a0: char[] input
	# $v0: parseInt($a0)
		
atoui:
	move $t0, $a0 # $t0 has address of current character
	li $v0, 0 

atoui_next_char:	
	lbu $t1, 0($t0) # $t1 has current character
	bgt $t1, '9', atoui_done
	blt $t1, '0', atoui_done
	li $t2, '0' # perform calculations to convert char to digit
	sub $t1, $t1, $t2 # now $t1 has curr char converted to digit
	li $t3, 10
	mul $v0, $v0, $t3
	add $v0, $v0, $t1
	addi $t0, $t0, 1 # advance to next character
	j atoui_next_char
	
atoui_done:	

	jr $ra

#################### uitoa ####################
	# Converts an unsigned integer to a string.
	# $a0: int value
	# $a1: char[] output
	# $a2: int outpuSize
	# $v0: byte immediately following last digit of string
	# $v1: integer 1 or 0 indicating success/failure

uitoa:
	li $v0, 0
	move $v1, $a0
	blez $a0, uitoa_done # value to convert is not positive
	li $t9, 0 # $t9 stores number of digits in $a0
	li $t8, 10 # $t8 holds constant 10 for extracting digits from $a0
	
	# fill temp_array with all zeroes
	la $t0, temp_array
	li $t1, 0 # counter from 0 to 99 (inclusive)
uitoa_zeroing_temp_array:
	sb $0, 0($t0)
	addi $t0, $t0, 1 # advance to next byte in array
	addi $t1, $t1, 1 # add 1 to counter
	blt $t1, 99, uitoa_zeroing_temp_array	

	# we have now finished zeroing out the temp_array	
	# now temporarily store converted value in temp_array
	la $t0, temp_array
uitoa_convert_next_digit:
	div $a0, $t8 # divide $a0 by 10
	mfhi $t7 # $t7 contains remainder of $a0 / 10
	mflo $a0 # replace $a0 with quotient of $a0 / 10
	addi $t7, $t7, '0' # convert digit to character
	addi $t9, $t9, 1 # add 1 to count of digits in original $a0
	sb $t7, 0($t0) # store the character in temp_array
	addi $t0, $t0, 1 # advance to next byte of temp_array

	bgtz $a0, uitoa_convert_next_digit # see if there are any more digits to convert
	# done converting digits	
	
	# make sure we have enough memory to store the result
	ble $t9, $a2, uitoa_sufficient_memory
	move $v0, $a1 # we don't have enough memory to store the result, return base address of output array
	j uitoa_done

uitoa_sufficient_memory:		
	# we have enough memory to store the result	
	# the digits are stored backwards in temp_array, so we need to reverse their order
	
	# need to copy from temp_array to $a1
	la $t2, temp_array
	add $t2, $t2, $t9 # $t2 starts by pointing to final character of temp_array
	addi $t2, $t2, -1 # need to subtract 1 because $t9 is the count of how many digits
uitoa_copy_next_digit:	
	lbu $t3, 0($t2)
	sb $t3, 0($a1)
	addi $t9, $t9, -1 # subtract 1 from number of digits remaining to copy	
	addi $a1, $a1, 1 # advance to next byte of output array
	addi $t2, $t2, -1 # advance to previous byte of temp_array
	bgtz $t9, uitoa_copy_next_digit
	
	# done converting
	move $v0, $a1
	li $v1, 1 # successful conversion
		
uitoa_done:
	jr $ra
