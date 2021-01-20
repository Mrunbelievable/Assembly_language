# zhicheng ding
# zhiched

.include "hw3_helpers.asm"

.text

##############################
# PART 1 FUNCTIONS
##############################

decodedLength:
	######prologue######
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $a0, 20($sp)
	
	######Body##########
	move $s0, $a0 # s0 = address of input string
	move $s3, $a1 # s3 = char[] runflag 
	li $s2, 0 #count
	#check if input string is null
	lb $s1, 0($s0) #s1 = first byte of string
	beqz $s1, decodedLength_InputError
	li $t0, 33
	beq $s3, $t0, inputCheck_done
	li $t0, 64
	beq $s3, $t0, inputCheck_done
	li $t0, 35
	beq $s3, $t0, inputCheck_done
	li $t0, 36
	beq $s3, $t0, inputCheck_done
	li $t0, 37
	beq $s3, $t0, inputCheck_done
	li $t0, 94
	beq $s3, $t0, inputCheck_done
	li $t0, 38
	beq $s3, $t0, inputCheck_done
	li $t0, 42
	beq $s3, $t0, inputCheck_done
	
	j decodedLength_InputError
	
inputCheck_done:
	lb $s1, 0($s0)
	beq $s1, $s3 count_2
	beqz $s1, finish_decodedLength 
	addi $s2, $s2, 1 #count++
	addi $s0, $s0, 1 #str[i++]
	j inputCheck_done
count_2:
	addi $s0, $s0, 2
	move $a0, $s0 # input = str[]
	jal atoui
	add $s2, $s2, $v0
	li $t1, 10
	bgt $v0, $t1 count_3
	addi $s0, $s0, 1
	j inputCheck_done
count_3:
	li $t1, 100
	bgt $v0, $t1 count_4
	addi $s0, $s0, 2
	j inputCheck_done
count_4:
	addi $s0, $s0, 3 # legnth < 1000, there is no need for further steps
	j inputCheck_done
decodedLength_InputError:
	li $v0, 0	
	######peilogue######
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $a0, 20($sp)
	addi $sp, $sp, 24
	jr $ra
	
finish_decodedLength:
	addi $s2, $s2, 1
	move $v0, $s2
	######peilogue######
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $a0, 20($sp)
	addi $sp, $sp, 24
	jr $ra

decodeRun:
    li $t2, 0#loop count
    ########prologue########
    #addi $sp, $sp, -16
    #sw $ra, 0($sp)
    #sw $s0, 4($sp)
    #sw $s1, 8($sp)
    #sw $s2, 12($sp)
    ########body##########
    #move $s0, $a0 # char letter
    #move $s1, $a1 # int runLength
    #move $s2, $a2 # char output
    #firstly check for parameters
    li $t0, 1
    blt $a1, $t0 Unmodified #check length
    li $t0, 65
    blt $a0, $t0 Unmodified
    li $t0, 90
    bgt $a0, $t0 decodeRun_further_check
doneFor_decodeRun_input_check:
	bge $t2, $a1, doneFor_store
	sb $a0, 0($a2)
	addi $a2, $a2, 1
	addi $t2, $t2, 1
	j doneFor_decodeRun_input_check
doneFor_store:
	#addi $a2, $a2, -1
	move $v0, $a2
	li $v1, 1
	#######epilogue#######
   	#lw $ra, 0($sp)
    	#lw $s0, 4($sp)
    	#lw $s1, 8($sp)
    	#lw $s2, 12($sp)
    	#addi $sp, $sp, 16
    	jr $ra
decodeRun_further_check:
	li $t0, 97
	blt $a0, $t0 Unmodified
	li $t0, 123
	bgt $a0, $t0 Unmodified
	j doneFor_decodeRun_input_check
Unmodified:
    	move $v0, $a2
    	li $v1, 0
	#######epilogue#######
   	#lw $ra, 0($sp)
    	#lw $s0, 4($sp)
    	#lw $s1, 8($sp)
    	#lw $s2, 12($sp)
    	#addi $sp, $sp, 16
    	jr $ra



runLengthDecode:
	#########prologue##########
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	##########body############
	move $s0, $a0 # char[] input
	move $s1, $a1 # char[] output
	move $s2, $a2 # outputSize
	move $s3, $a3 # runflag
	
	#calculate the decodedLength
	move $a0, $a0
	move $a1, $s3
	jal decodedLength
	blt $s2, $v0, partC_unmodified#check if space enough
	#check runFlag
	li $t0, 33
	beq $s3, $t0, partC_check_done
	li $t0, 64
	beq $s3, $t0, partC_check_done
	li $t0, 35
	beq $s3, $t0, partC_check_done
	li $t0, 36
	beq $s3, $t0, partC_check_done
	li $t0, 37
	beq $s3, $t0, partC_check_done
	li $t0, 94
	beq $s3, $t0, partC_check_done
	li $t0, 38
	beq $s3, $t0, partC_check_done
	li $t0, 42
	beq $s3, $t0, partC_check_done
	j partC_unmodified

partC_check_done:
	lb $t1, 0($s0)
	beq $t1, $zero finish_runLengthDecode
	beq $t1, $s3 readyFor_decodeRun
	sb $t1, 0($s1)
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	j partC_check_done
readyFor_decodeRun:
	addi $s0, $s0, 1
	lb $s4, 0($s0) # char needed to decoderun
	addi $s0, $s0, 1
	move $a0, $s0
	jal atoui
	move $a1, $v0
	move $a0, $s4
	#addi $s1, $s1, 1
	move $a2, $s1
	jal decodeRun
	addi $s0, $s0, 1
	#addi $s1, $v0, 1
	move $s1, $v0
	j partC_check_done
finish_runLengthDecode:
	li $t0, '\0'
	sb $t0, 0($s1)
	li $v0, 1
	#########epilogue###########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	jr $ra
partC_unmodified:
	li $v0, 0
	#########epilogue###########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	jr $ra


##############################
# PART 2 FUNCTIONS
##############################

encodedLength:
	#########prologue######
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	
	li $s0, 1 #loop
	li $s1, 0 #count
	lb $t0, 0($a0)
	beq $t0, 0 encodeLength_done
encodeLength_while:	
	lb $t1, 0($a0)
	lb $t2, 1($a0)
	beq $t1, 0 encodeLength_done2
	beq $t1, $t2 repeated
	li $t3, 3
	bgt $s0, $t3 encodeLength_count
	add $s1, $s1, $s0
	addi $a0, $a0, 1
	li $s0, 1 #loop
	j encodeLength_while
encodeLength_count:
	li $t3, 10
	bgt $s0, $t3, encodeLength_count2
	addi $s1, $s1, 3
	addi $a0, $a0, 1
	li $s0, 1 #loop
	j encodeLength_while
encodeLength_count2:
	addi $s1, $s1, 4
	addi $a0, $a0, 1
	li $s0, 1 #loop
	j encodeLength_while
repeated:
	addi $s0, $s0, 1
	addi $a0, $a0, 1
	j encodeLength_while
	
encodeLength_done2:
	addi $s1, $s1, 1
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra	
encodeLength_done:
	#######epilouge#####
	li $v0, 0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8	
    	jr $ra

encodeRun:
    ##########prologue##########
    	addi $sp, $sp, -20
    	sw $ra, 0($sp)
    	sw $s0, 4($sp)
    	sw $s1, 8($sp)
    	sw $s2, 12($sp)
    	sw $s3, 16($sp)
    
    ##########body##############
    	move $s0, $a0 # char letter
    	move $s1, $a1 # int runLength
    	move $s2, $a2 # char[] output
    	move $s3, $a3 # char runFlag
    
   	li $t0, 0
    	ble $s1, $t0 encodeRun_unmodified
#check runFlag
	li $t0, 33
	beq $s3, $t0, partE_further_check
	li $t0, 64
	beq $s3, $t0, partE_further_check
	li $t0, 35
	beq $s3, $t0, partE_further_check
	li $t0, 36
	beq $s3, $t0, partE_further_check
	li $t0, 37
	beq $s3, $t0, partE_further_check
	li $t0, 94
	beq $s3, $t0, partE_further_check
	li $t0, 38
	beq $s3, $t0, partE_further_check
	li $t0, 42
	beq $s3, $t0, partE_further_check
	j encodeRun_unmodified    
partE_further_check:
	li $t0, 65
	blt $s0, $t0, encodeRun_unmodified
	li $t0, 90
	bgt $s0, $t0, encodeRun_last_check
encodeRun_input_checkDone:
	li $t0, 3
	ble $s1, $t0, copyLetter # runLength <=3 
	sb $s3, 0($s2)
	addi $s2, $s2, 1
	sb $s0, 0($s2)
	addi $s2, $s2, 1
	move $a0, $s1
	move $a1, $s2
	move $a2, $s1
	jal uitoa
	move $s2, $v0
	j encodeRun_Done
copyLetter:
	li $t0, 1
inside_loop:	
	bgt $t0, $s1, encodeRun_Done
	sb $s0, 0($s2)
	addi $t0, $t0, 1
	addi $s2, $s2, 1
	j inside_loop
encodeRun_last_check:
	li $t0, 97
	blt $s0, $t0, encodeRun_unmodified
	li $t0, 123
	bgt $s0, $t0, encodeRun_unmodified
	j encodeRun_input_checkDone
	
encodeRun_Done:
	move $v0, $s2
	li $v1, 1
	##########epilogue##########
	lw $ra, 0($sp)
    	lw $s0, 4($sp)
    	lw $s1, 8($sp)
    	lw $s2, 12($sp)
    	lw $s3, 16($sp)
    	addi $sp, $sp, 20
	jr $ra
encodeRun_unmodified:
	move $v0, $s2
	li $v1, 0
	##########epilogue##########
	lw $ra, 0($sp)
    	lw $s0, 4($sp)
    	lw $s1, 8($sp)
    	lw $s2, 12($sp)
    	lw $s3, 16($sp)
    	addi $sp, $sp, 20
	jr $ra

runLengthEncode:
	########Prologue#########
	addi $sp, $sp, -28
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	########body############
	move $s0, $a0 # char[] input
	move $s1, $a1 # char[] output
	move $s2, $a2 # int outputSize
	move $s3, $a3 # runFlag
	li $s5, 1 #count
	#start iniput check
	jal encodedLength
	move $s4, $v0 # encodedLength
	blt $s2, $s4, runLengthEncode_Unmodified
#check runFlag
	li $t0, 33
	beq $s3, $t0, runLengthEncode_CheckDone
	li $t0, 64
	beq $s3, $t0, runLengthEncode_CheckDone
	li $t0, 35
	beq $s3, $t0, runLengthEncode_CheckDone
	li $t0, 36
	beq $s3, $t0, runLengthEncode_CheckDone
	li $t0, 37
	beq $s3, $t0, runLengthEncode_CheckDone
	li $t0, 94
	beq $s3, $t0, runLengthEncode_CheckDone
	li $t0, 38
	beq $s3, $t0, runLengthEncode_CheckDone
	li $t0, 42
	beq $s3, $t0, runLengthEncode_CheckDone
	j runLengthEncode_Unmodified
runLengthEncode_CheckDone:
	lb $t1, 0($s0)
	lb $t2, 1($s0)
	beq $t1, $zero, finish_runLengthEncode
	beq $t1, $t2, count_encodeRun
	li $t7,1
	bgt $s5, $t7, call_encodeRun
	sb $t1, 0($s1)
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	j runLengthEncode_CheckDone
count_encodeRun:
	addi $s5, $s5, 1
	addi $s0, $s0, 1
	#addi $s1, $s1, 1
	j runLengthEncode_CheckDone
call_encodeRun:
	lb $a0, 0($s0) #char
	move $a1, $s5 # int runLength
	move $a2, $s1 # char[] output
	move $a3, $s3 # runFlag
	jal encodeRun
	move $s1, $v0
	addi $s0, $s0, 1
	#addi $s1, $s1, 1
	li $s5, 1 #count
	j runLengthEncode_CheckDone
	
finish_runLengthEncode:
	li $v0, 1
	li $t0, '\0'
	sb $t0, 0($s1)
	#########epilogue#########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addi $sp, $sp, 28
	jr $ra
runLengthEncode_Unmodified:	
	#########epilogue#########
    	li $v0, 0
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addi $sp, $sp, 28
    	jr $ra

##############################
# PART 3 FUNCTION
##############################

editDistance:
	#########prologue#######
	addi $sp, $sp, -32
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	#########body###########
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	li $t0, 0
	blt $s2, $t0 returnNegative
	blt $s3, $t0 returnNegative
	li $t1, 'm'
	move $a0, $t1
	li $v0, 11
	syscall
	li $t1, ':'
	move $a0, $t1
	li $v0, 11
	syscall
	#li $t1, ','
	#move $a0, $t1
	#li $v0, 11
	#syscall
	move $a0, $s2
	li $v0, 1
	syscall
	li $t1, ','
	move $a0, $t1
	li $v0, 11
	syscall
	li $t1, 'n'
	move $a0, $t1
	li $v0, 11
	syscall
	li $t1, ':'
	move $a0, $t1
	li $v0, 11
	syscall
	#li $t1, ','
	#move $a0, $t1
	#li $v0, 11
	#syscall
	move $a0, $s3
	li $v0, 1
	syscall
	li $t1, '\n'
	move $a0, $t1
	li $v0, 11
	syscall
	
	beq $s2, $t0 insertN
	beq $s3, $t0 insertM 
	# str1.charAt(m-1)
	add $s0, $s0, $s2
	addi $s0, $s0, -1
	lb $t2, 0($s0)
	# str2.charAt(n-1)
	add $s1, $s1, $s3
	addi $s1, $s1, -1
	lb $t3, 0($s1)
	beq $t3, $t2 recursive1
	
	addi $s0, $s0, 1
	sub $s0, $s0, $s2
	addi $s1, $s1, 1
	sub $s1, $s1, $s3
	move $a0, $s0 #str1
	move $a1, $s1 #str2
	move $a2, $s2 # m
	addi $s3, $s3, -1 # n-1
	move $a3, $s3
	jal editDistance
	move $s4, $v0 # int insert 
	
	addi $s3, $s3, 1 # n
	addi $s2, $s2, -1 # m-1
	move $a0, $s0 #str1
	move $a1, $s1 #str2
	move $a2, $s2
	move $a3, $s3
	jal editDistance
	move $s5, $v0 # int remove
	
	addi $s3, $s3, -1 # n-1
	move $a0, $s0 #str1
	move $a1, $s1 #str2
	move $a2, $s2
	move $a3, $s3
	jal editDistance
	move $s6, $v0 # int replace
	
	move $a0, $s5
	move $a1, $s6
	jal min
	move $a1, $v0
	move $a0, $s4
	jal min
	addi $v0, $v0, 1
	###########peilogue############
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	addi $sp, $sp, 32
	jr $ra
	
recursive1:
	addi $s0, $s0, 1
	sub $s0, $s0, $s2
	move $a0, $s0
	addi $s1, $s1, 1
	sub $s1, $s1, $s3
	move $a1, $s1
	addi $s2, $s2, -1 # m-1
	addi $s3, $s3, -1 # n-1
	move $a2, $s2
	move $a3, $s3
	jal editDistance
	###########peilogue############
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	addi $sp, $sp, 32
	jr $ra
insertN:
	move $v0, $s3
	###########peilogue############
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	addi $sp, $sp, 32
	jr $ra
insertM:
	move $v0, $s2
	###########peilogue############
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	addi $sp, $sp, 32
	jr $ra
returnNegative:
	li $v0, -1
	###########peilogue############
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	addi $sp, $sp, 32
	jr $ra

min:
	#####prologue########
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	########Body########
	move $s0, $a0
	move $s1, $a1
	li $s2, 0#min
	blt $s0, $s1 else
	move $s2, $s1
	move $v0, $s2
	######epilogue#######
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16
	jr $ra
else:
	move $s2, $s0
	move $v0, $s2
	######epilogue#######
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16
	jr $ra	






