# zhicheng ding
# zhiched

.include "hw4_helpers.asm"
.data
buffer:	.space 5
.text

##########################################
#  Part #1 Functions
##########################################
initBoard:
	#########prologue#######
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	# a0 = fg, a1 = darkbg, a2 = lightbg
	li $t0, 0 # i
	li $t1, 8 # row
	li $t2, 8 # col
	li $t5, 0xffff0000
	li $t6, 2
	li $t7, 0
	li $s1, 'E'
	li $t8, 1
i_loop:
	bge $t0, $t2, done_i_loop
	#inside for i_loop
	li $t3, 0 # j
	j_loop:
		bge $t3, $t1, done_j_loop
		mul $t4, $t0, $t2 # i*col
		add $t4, $t4, $t3 # i*col+j
		mul $t4, $t4, $t6 # 2(i*col+j)
		add $t4, $t4, $t5
		div $t7, $t6
		mfhi $s0
		div $t8, $t6
		mfhi $s2
		beq $s2, $zero even_row
odd_row:
	beq $s0, $zero odd_square
	sb $s1, 0($t4)
	sll $s3, $a1, 4
	or $s3, $s3, $a0
	sb $s3, 1($t4)
	addi $t7, $t7, 1
	addi $t3, $t3, 1 # j++
	j j_loop
odd_square:
	sb $s1, 0($t4)
	sll $s4, $a2, 4
	or $s4, $s4, $a0
	sb $s4, 1($t4)
	addi $t7, $t7, 1
	addi $t3, $t3, 1 # j++
	j j_loop
even_row:
	beq $s0, $zero even_square
	sb $s1, 0($t4)
	sll $s3, $a2, 4
	or $s3, $s3, $a0
	sb $s3, 1($t4)
	addi $t7, $t7, 1
	addi $t3, $t3, 1 # j++
	j j_loop
even_square:
	sb $s1, 0($t4)
	sll $s4, $a1, 4
	or $s4, $s4, $a0
	sb $s4, 1($t4)
	addi $t7, $t7, 1
	addi $t3, $t3, 1 # j++
	j j_loop
done_j_loop:		
	addi $t0, $t0, 1 # i++
	addi $t8, $t8, 1
	j i_loop
done_i_loop:
	######epilogue########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	jr $ra	
setSquare:
	# a0 = row, a1 = col, a2 = piece, a3 = player, t1 = fg
	lb $t1, 0($sp)
	li $t0, 7
	blt $a0, $zero setSquare_error
	bgt $a0, $t0 setSquare_error
	blt $a1, $zero setSquare_error
	bgt $a1, $t0 setSquare_error
	li $t0, 0xF
	bgt $t1, $t0, setSquare_error
	li $t0, 1
	beq $a3, $t0, player_1
	li $t0, 2
	beq $a3, $t0, player_2
	j setSquare_error
player_1:
	#li $t0, 0xF
	#bgt $t1, $t0, setSquare_error
	li $t2, 8
	mul $a0, $a0, $t2
	add $a0, $a0, $a1
	li $t2, 2
	mul $a0, $a0, $t2
	addi $t2, $a0, 0xffff0000
	li $t0, 'E'
	beq $a2, $t0, set_fg
	sb $a2, 0($t2)
	li $t0, 0xF # white fg
	lb $t3, 1($t2) # loard current color info
	srl $t3, $t3, 4
	sll $t3, $t3, 4
	or $t0, $t0, $t3 # keep bg color, simply add fg
	sb $t0, 1($t2)
	li $v0, 0
	jr $ra
player_2:
	li $t0, 0xF
	bgt $t1, $t0, setSquare_error
	li $t2, 8
	mul $a0, $a0, $t2
	add $a0, $a0, $a1
	li $t2, 2
	mul $a0, $a0, $t2
	addi $t2, $a0, 0xffff0000
	li $t0, 'E'
	beq $a2, $t0, set_fg
	sb $a2, 0($t2)
	li $t0, 0 # black fg
	lb $t3, 1($t2) # loard current color info
	srl $t3, $t3, 4
	sll $t3, $t3, 4
	or $t0, $t0, $t3 # keep bg color, simply add fg
	sb $t0, 1($t2)
	li $v0, 0
	jr $ra
set_fg:
	sb $a2, 0($t2)
	lb $t3, 1($t2) 
	srl $t3, $t3, 4
	sll $t3, $t3, 4
	or $t1, $t1, $t3
	sb $t1, 1($t2)
	li $v0, 0
	jr $ra
setSquare_error:
	li $v0, -1
	jr $ra

initPieces:
	#########prologue#########
	addi $sp, $sp, -16
	sw $s0, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)
	#########body#############
	#player 2 set up
	li $a0, 0
	li $a1, 0
	li $a2, 'R'
	li $a3, 2
	li $s2, 0x9 # a4
	sb $s2, 0($sp)
	#li $s1, 0x9 # a4
	#sw $s1, 12($sp)
	#addi $sp, $sp, -4
	jal setSquare
	li $a0, 0
	li $a1, 1
	li $a2, 'H'
	li $a3, 2
	jal setSquare
	li $a0, 0
	li $a1, 2
	li $a2, 'B'
	li $a3, 2
	jal setSquare
	li $a0, 0
	li $a1, 3
	li $a2, 'Q'
	li $a3, 2
	jal setSquare
	li $a0, 0
	li $a1, 4
	li $a2, 'K'
	li $a3, 2
	jal setSquare
	li $a0, 0
	li $a1, 5
	li $a2, 'B'
	li $a3, 2
	jal setSquare
	li $a0, 0
	li $a1, 6
	li $a2, 'H'
	li $a3, 2
	jal setSquare
	li $a0, 0
	li $a1, 7
	li $a2, 'R'
	li $a3, 2
	jal setSquare
	li $s0, 7 # reday for loop 
	li $a1, 0
player2_setUp:	
	bgt $a1, $s0, done_player2
	li $a0, 1
	li $a3, 2
	li $a2, 'P'
	jal setSquare
	addi $a1, $a1, 1
	j player2_setUp
done_player2:	
	#player 1 set up
	li $a0, 7
	li $a1, 0
	li $a2, 'R'
	li $a3, 1
	#li $s2, 0x9
	#addi $sp, $sp, -4
	#sw $s1, 0($sp)
	#sw $s2, 12($sp)
	jal setSquare
	li $a0, 7
	li $a1, 1
	li $a2, 'H'
	li $a3, 1
	jal setSquare
	li $a0, 7
	li $a1, 2
	li $a2, 'B'
	li $a3, 1
	jal setSquare
	li $a0, 7
	li $a1, 3
	li $a2, 'Q'
	li $a3, 1
	jal setSquare
	li $a0, 7
	li $a1, 4
	li $a2, 'K'
	li $a3, 1
	jal setSquare
	li $a0, 7
	li $a1, 5
	li $a2, 'B'
	li $a3, 1
	jal setSquare
	li $a0, 7
	li $a1, 6
	li $a2, 'H'
	li $a3, 1
	jal setSquare
	li $a0, 7
	li $a1, 7
	li $a2, 'R'
	li $a3, 1
	jal setSquare
	li $s0, 7 #ready for loop
	li $a1, 0
player1_setUp:	
	bgt $a1, $s0, done_setUp
	li $a0, 6
	li $a3, 1
	li $a2, 'P'
	jal setSquare
	addi $a1, $a1, 1
	j player1_setUp
done_setUp:	
	#########epilogue#########
	#lw $s1, 0($sp)
	lw $s0, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	jr $ra
	

mapChessMove:
	# check input char letter, number
	li $t0, 65
	blt $a0, $t0, inValidChar
	li $t0, 72
	bgt $a0, $t0, inValidChar
	li $t0, 49
	blt $a1, $t0, inValidChar
	li $t0, 56
	bgt $a1, $t0, inValidChar
	# done for input check
	li $t0, 65
	beq $a0, $t0, holdCol_A
	li $t0, 66
	beq $a0, $t0, holdCol_B
	li $t0, 67
	beq $a0, $t0, holdCol_C
	li $t0, 68
	beq $a0, $t0, holdCol_D
	li $t0, 69
	beq $a0, $t0, holdCol_E
	li $t0, 70
	beq $a0, $t0, holdCol_F
	li $t0, 71
	beq $a0, $t0, holdCol_G
	li $t0, 72
	beq $a0, $t0, holdCol_H
holdCol_A:
	li $t1, 0
	#sll $t1, $t0, 4
	j holdRow
holdCol_B:
	li $t1, 1
	#sll $t1, $t0, 4
	j holdRow
holdCol_C:
	li $t1, 2
	#sll $t1, $t0, 4
	j holdRow
holdCol_D:
	li $t1, 3
	#sll $t1, $t0, 4
	j holdRow
holdCol_E:
	li $t1, 4
	#sll $t1, $t0, 4
	j holdRow
holdCol_F:
	li $t1, 5
	#sll $t1, $t0, 4
	j holdRow
holdCol_G:
	li $t1, 6
	#sll $t1, $t0, 4
	j holdRow
holdCol_H:
	li $t1, 7
	#sll $t1, $t0, 4
	j holdRow
	
holdRow:
	li $t0, 49
	beq $a1, $t0, holdRow_1
	li $t0, 50
	beq $a1, $t0, holdRow_2
	li $t0, 51
	beq $a1, $t0, holdRow_3
	li $t0, 52
	beq $a1, $t0, holdRow_4
	li $t0, 53
	beq $a1, $t0, holdRow_5
	li $t0, 54
	beq $a1, $t0, holdRow_6
	li $t0, 55
	beq $a1, $t0, holdRow_7
	li $t0, 56
	beq $a1, $t0, holdRow_8
holdRow_1:
	li $t0, 7
	sll $t2, $t0, 8
	j done_mapChessMove
holdRow_2:
	li $t0, 6
	sll $t2, $t0, 8
	j done_mapChessMove
holdRow_3:
	li $t0, 5
	sll $t2, $t0, 8
	j done_mapChessMove
holdRow_4:
	li $t0, 4
	sll $t2, $t0, 8
	j done_mapChessMove
holdRow_5:
	li $t0, 3
	sll $t2, $t0, 8
	j done_mapChessMove
holdRow_6:
	li $t0, 2
	sll $t2, $t0, 8
	j done_mapChessMove
holdRow_7:
	li $t0, 1
	sll $t2, $t0, 8
	j done_mapChessMove
holdRow_8:
	li $t0, 0
	sll $t2, $t0, 8
	j done_mapChessMove
done_mapChessMove:
	or $t2, $t1, $t2
	move $v0, $t2
	jr $ra
inValidChar:	
	li $v0, 0xFFFF
	jr $ra
	
loadGame:
	#########prologue########
	addi $sp, $sp, -36
	#sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	##############body#############
	li $s3, 0
	li $s4, 0
	#move $s7, $a0
	#### open file #####
	# a0 = file name
	li $v0, 13
	#move $a0, $s7
	li $a1, 0
	li $a2, 0
	syscall 
	move $s7, $v0 # store fd into t0
	blt $s7, $zero error_opening #### file open check
load_loop:
	#### read file #####
	li $v0, 14
	move $a0, $s7
	la $a1, buffer # s2 the buffer 
	li $a2, 5
	syscall
	blt $v0, $zero error_opening
	move $s1, $v0  # s1 = # of characters read
	# s3 = white count  s4 = black count
	beq $s1, $zero, load_done
	la $s2, buffer
	lb $t1, 0($s2)
	lb $t2, 1($s2)
	lb $a0, 2($s2) 
	lb $a1, 3($s2)
	move $s5, $t1 # s5 = palyer
	move $s6, $t2 # s6 = piece
	jal mapChessMove
	####check the player start#######
	li $t0, '1'
	beq $t0, $s5 itsWhite
	addi $s4, $s4, 1
	move $t0, $v0
	srl $t0, $t0, 8
	move $a0, $t0
	sll $t0, $t0, 8
	sub $t0, $v0, $t0
	move $a1, $t0
	move $a2, $s6
	li $t0, 2
	move $a3, $t0
	li $s2, 0x9
	sb $s2, 0($sp)
	jal setSquare
	#beq $s1, $zero, load_done
	j load_loop
itsWhite:
	addi $s3, $s3, 1
	move $t0, $v0
	srl $t0, $t0, 8
	move $a0, $t0
	sll $t0, $t0, 8
	sub $t0, $v0, $t0
	move $a1, $t0
	move $a2, $s6
	li $t0, 1
	move $a3, $t0
	li $s2, 0x9
	sb $s2, 0($sp)
	jal setSquare
	#beq $s1, $zero, load_done
	j load_loop
load_done:	
	##### close file #####
	li $v0, 16
	move $a0, $t0
	syscall
	move $v0, $s3
	move $v1, $s4
	#########prologue########
	#lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)
	addi $sp, $sp, 36
	jr $ra
error_opening:
	li $v0, -1 
	li $v1, -1 
	#########prologue########
	#lw $s0, 0($sp)
	#lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)
	addi $sp, $sp, 36
	jr $ra

##########################################
#  Part #2 Functions
##########################################

getChessPiece:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	srl $t0, $a0, 8 
	move $s1, $t0 #s1 = row
	sll $t0, $t0, 8
	sub $t1, $a0, $t0 
	move $s0, $t1 # s0 = col
	### calculation of 2d array ####
	li $t2, 0xffff0000
	li $t3, 8
	mul $s1, $s1, $t3
	add $s1, $s1, $s0
	li $t3, 2
	mul $s1, $s1, $t3
	add $s1, $s1, $t2
	lb $t4, 0($s1) # load the char
	li $t3, 'E'
	beq $t4, $t3, empty_cell
	addi $s1, $s1, 1
	lb $t5, 0($s1) # load the color info
	sll $t6, $t5, 28
	srl $t6, $t6, 28
	#sub $t5, $t5, $t6
	#srl $t5, $t5, 4
	li $t3, 0xF
	beq $t6, $t3, itsplayer_1
	move $v0, $t4
	li $v1, 2
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
	jr $ra
itsplayer_1:
	move $v0, $t4
	li $v1, 1
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
	jr $ra
empty_cell:
	li $v0, 'E'
	li $v1, -1
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
	jr $ra

validBishopMove:
	##########prologue#########
	addi $sp, $sp, -36
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	###########body###########
	move $s0, $a0 #from
	move $s1, $a1 #to
	move $s2, $a2 #player
	move $s3, $a3 #capture
	# test for argument #
	# test  short from
	srl $t0, $s0, 8
	move $s4, $t0 # s4 = from row
	blt $t0, $zero argument_error
	li $t1, 7
	bgt $t0, $t1 argument_error
	sll $t0, $t0, 8
	sub $t0, $s0, $t0 
	move $s5, $t0 # s5 = from col
	blt $t0, $zero argument_error
	li $t1, 7
	bgt $t0, $t1 argument_error
	# test short to
	srl $t0, $s1, 8
	move $s6, $t0 # s6 = to row
	blt $t0, $zero argument_error
	li $t1, 7
	bgt $t0, $t1 argument_error
	sll $t0, $t0, 8
	sub $t0, $s1, $t0
	move $s7, $t0 # s7 = to col
	blt $t0, $zero argument_error
	li $t1, 7
	bgt $t0, $t1 argument_error
	li $t1, 1
	beq $s2, $t1, done_argument_check
	li $t1, 2
	beq $s2, $t1, done_argument_check
	j argument_error
done_argument_check:
	# test  if positon contain own piece at to position
	move $a0, $s1
	jal getChessPiece
	move $t0, $v0 # char
	move $t1, $v1 # player
	beq $t1, $s2, invalid_move 
	beq $s0, $s1, invalid_move # check from and to positions are the same
	### check if any piece is obstructing
	move $t6, $s4 # row_from
	move $t7, $s5 # col_from
	sub $t0, $s4, $s6
	sub $t1, $s5, $s7
	beq $t0, $t1, checking_obstruct
	add $t0, $t1, $t0
	beq $t0, $zero, checking_obstruct
	j invalid_move
checking_obstruct:
	bgt $s6, $s4, at_down
	# s6 < s4,  to_row < from_row
	# at_up
	bgt $s7, $s5, at_up_right
	# at_up_left
	addi $t6, $t6, -1
	addi $t7, $t7, -1
	beq $t6, $s6, done_for_check
	li $t0, 8
	mul $t8, $t6, $t0 # row*8
	add $t8, $t8, $t7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t9, $t0, go_up_left_check
	j invalid_move
at_down:
	bgt $t7, $s5, at_down_right
	# at_down_left
	addi $t6, $t6, 1
	addi $t7, $t7, -1
	beq $t6, $s6, done_for_check
	li $t0, 8
	mul $t8, $t6, $t0 # row*8
	add $t8, $t8, $t7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t9, $t0, go_down_left_check
	j invalid_move
at_down_right:
	addi $t6, $t6, 1
	addi $t7, $t7, 1
	beq $t6, $s6, done_for_check
	li $t0, 8
	mul $t8, $t6, $t0 # row*8
	add $t8, $t8, $t7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t9, $t0, go_down_right_check
	j invalid_move
at_up_right:
	addi $t6, $t6, -1
	addi $t7, $t7, 1
	beq $t6, $s6, done_for_check
	li $t0, 8
	mul $t8, $t6, $t0 # row*8
	add $t8, $t8, $t7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t9, $t0, go_up_right_check
	j invalid_move
go_down_right_check:
	#addi $t6, $t6, 1
	#addi $t7, $t7, 1
	j checking_obstruct
go_down_left_check:
	#addi $t6, $t6, 1
	#addi $t7, $t7, -1
	j checking_obstruct
go_up_right_check:
	#addi $t6, $t6, -1
	#addi $t7, $t7, 1
	j checking_obstruct
go_up_left_check:
	#addi $t6, $t6, -1
	#addi $t7, $t7, -1
	j checking_obstruct
done_for_check:
	li $t0, 8
	mul $t8, $s6, $t0 # row*8
	add $t8, $t8, $s7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t9, $t0, valid_unobstructed
	li $v0, 1
	sll $s6, $s6, 8
	or $s6, $s6, $s7
	sw $s6, 0($s3)  # stroe the capture info
	move $v1, $t9
	##########peilogue#########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36
	jr $ra
valid_unobstructed:
	li $v0, 0
	li $v1, '\0'
	##########peilogue#########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36
	jr $ra
invalid_move:
	li $v0, -1
	li $v1, '\0'
	##########peilogue#########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36
	jr $ra
argument_error:
	li $v0, -2
	li $v1, '\0'
	##########peilogue#########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36
	jr $ra

validRookMove:
	##########prologue#########
	addi $sp, $sp, -36
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	###########body#################
	move $s0, $a0 #from
	move $s1, $a1 #to
	move $s2, $a2 #player
	move $s3, $a3 #capture
	# test for argument #
	# test  short from
	srl $t0, $s0, 8
	move $s4, $t0 # s4 = from row
	blt $t0, $zero validRookMove_argument_error
	li $t1, 7
	bgt $t0, $t1 validRookMove_argument_error
	sll $t0, $t0, 8
	sub $t0, $s0, $t0 
	move $s5, $t0 # s5 = from col
	blt $t0, $zero validRookMove_argument_error
	li $t1, 7
	bgt $t0, $t1 validRookMove_argument_error
	# test short to
	srl $t0, $s1, 8
	move $s6, $t0 # s6 = to row
	blt $t0, $zero validRookMove_argument_error
	li $t1, 7
	bgt $t0, $t1 validRookMove_argument_error
	sll $t0, $t0, 8
	sub $t0, $s1, $t0
	move $s7, $t0 # s7 = to col
	blt $t0, $zero validRookMove_argument_error
	li $t1, 7
	bgt $t0, $t1 validRookMove_argument_error
	li $t1, 1
	beq $s2, $t1, done_argumentCheck
	li $t1, 2
	beq $s2, $t1, done_argumentCheck
	j validRookMove_argument_error
done_argumentCheck:
	beq $s0, $s1, invalid_Rook_Move
	# test  if positon contain own piece at to position
	move $a0, $s1
	jal getChessPiece
	move $t0, $v0 # char
	move $t1, $v1 # player
	beq $t1, $s2, invalid_Rook_Move 
	beq $s0, $s1, invalid_Rook_Move
	beq $s4, $s6, go_further_check_row
	beq $s5, $s7, go_further_check_col
	j invalid_Rook_Move
go_further_check_row:
	move $t7, $s7 # t7 = to col
	move $t6, $s6 # t6 = to row
director_left:
	bgt $t7, $s5, director_right
	addi $t7, $t7, 1
	beq $t7, $s4, validRookMove_done
	li $t0, 8
	mul $t8, $t6, $t0 # row*8
	add $t8, $t8, $t7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t0, $t9, loop_director_left
	j invalid_Rook_Move
go_further_check_col:
	move $t7, $s7 # t7 = to col
	move $t6, $s6 # t6 = to row
director_down:
	bgt $t6, $s4, director_up
	addi $t6, $t6, 1
	beq $t6, $s4, validRookMove_done
	li $t0, 8
	mul $t8, $t6, $t0 # row*8
	add $t8, $t8, $t7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t0, $t9, loop_director_down
	j invalid_Rook_Move
director_up:
	addi $t6, $t6, -1
	beq $t6, $s4, validRookMove_done
	li $t0, 8
	mul $t8, $t6, $t0 # row*8
	add $t8, $t8, $t7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t0, $t9, loop_director_up
	j invalid_Rook_Move
director_right:
	addi $t7, $t7, -1
	beq $t7, $s5, validRookMove_done
	li $t0, 8
	mul $t8, $t6, $t0 # row*8
	add $t8, $t8, $t7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t0, $t9, loop_director_right
	j invalid_Rook_Move
loop_director_right:
	j director_right
loop_director_left:
	j director_left
loop_director_up:
	j director_up
loop_director_down:
	j director_down
validRookMove_done:
	li $t0, 8
	mul $t8, $s6, $t0 # row*8
	add $t8, $t8, $s7 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t9, $t0, valid_unobstructed_2
	li $v0, 1
	sll $s6, $s6, 8
	or $s6, $s6, $s7
	sw $s6, 0($s3)  # stroe the capture info
	move $v1, $t9
	##########peilogue#########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36
	jr $ra
valid_unobstructed_2:
	li $v0, 0
	li $v1, '\0'
	##########peilogue#########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36
	jr $ra
invalid_Rook_Move:
	li $v0, -1
	li $v1, 0
	##########peilogue#########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36
	jr $ra
validRookMove_argument_error:
	li $v0, -2  
	li $v1, 0
	##########peilogue#########
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addi $sp, $sp, 36
	jr $ra
	
perform_move:
	###########prologue#############
	addi $sp, $sp, -44
	sw $ra, 4($sp)
	sw $s0, 8($sp)
	sw $s1, 12($sp)
	sw $s2, 16($sp)
	sw $s3, 20($sp)
	sw $s4, 24($sp)
	sw $s5, 28($sp)
	sw $s6, 32($sp)
	sw $s7, 36($sp)
	sw $t7, 40($sp)
	#addi $sp, $sp, -4 # for 5th argument
	###########body#################
	lw $t7, 0($sp) # king_pos
	move $s0, $a0 # player
	move $s1, $a1 # from
	move $s2, $a2 # to
	move $s3, $a3 # fg
	# test for argument #
	# test  short from
	srl $t0, $s1, 8
	move $s4, $t0 # s4 = from row
	blt $t0, $zero error_input_aru
	li $t1, 7
	bgt $t0, $t1 error_input_aru
	sll $t0, $t0, 8
	sub $t0, $s1, $t0 
	move $s5, $t0 # s5 = from col
	blt $t0, $zero error_input_aru
	li $t1, 7
	bgt $t0, $t1 error_input_aru
	# test short to
	srl $t0, $s2, 8
	move $s6, $t0 # s6 = to row
	blt $t0, $zero error_input_aru
	li $t1, 7
	bgt $t0, $t1 error_input_aru
	sll $t0, $t0, 8
	sub $t0, $s2, $t0
	move $s7, $t0 # s7 = to col
	blt $t0, $zero error_input_aru
	li $t1, 7
	bgt $t0, $t1 error_input_aru
	li $t1, 1
	beq $s0, $t1, done_argument_Check
	li $t1, 2
	beq $s0, $t1, done_argument_Check
	j error_input_aru
done_argument_Check:
	###### check if there is a peiece at from position
	li $t0, 8
	mul $t8, $s4, $t0 # row*8
	add $t8, $t8, $s5 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t9, 0($t8)
	li $t0, 'E'
	beq $t9, $t0, return_invalid
	### check if the piece is specified player 
	move $a0, $s1
	jal getChessPiece
	move $t0, $v0 # char for piece
	move $t1, $v1  # player 
	beq $s0, $t1, go_next_step
	j error_input_aru
	#lb $t9, 1($t8) # get color 
	#sll $t0, $t9, 28
	#srl $t0, $t0, 28
	#beq $t0, $zero, play2
	# it's white
	#li $t0, 1
	#bne $s0, $t0, return_invalid
	#j go_next_step
#play2:
	# it's black
#	li $t0, 2
#	bne $s0, $t0, return_invalid
go_next_step:
	lb $t0, 0($t8)
	li $t3, 'B'
	beq $t0, $t3, call_bishop
	li $t3, 'R'
	beq $t0, $t3, call_rook
	li $t3, 'P'
	beq $t0, $t3, call_pawn
	li $t3, 'p'
	beq $t0, $t3, call_pawn
	li $t3, 'H'
	beq $t0, $t3, call_knight
	li $t3, 'Q'
	beq $t0, $t3, call_queen
	li $t3, 'K'
	beq $t0, $t3, call_king
	j error_input_aru
call_king:
	move $a0, $s1
	move $a1, $s2
	move $a2, $s0
	move $a3, $sp
	jal validKingMove
	j result
call_queen:
	move $a0, $s1
	move $a1, $s2
	move $a2, $s0
	move $a3, $sp
	jal validQueenMove
	j result
call_knight:
	move $a0, $s1
	move $a1, $s2
	move $a2, $s0
	move $a3, $sp
	jal validKnightMove
	j result
call_pawn:
	move $a0, $s1
	move $a1, $s2
	move $a2, $s0
	move $a3, $sp
	jal validPawnMove
	j result
call_bishop:
	move $a0, $s1
	move $a1, $s2
	move $a2, $s0
	move $a3, $sp
	jal validBishopMove
	j result
call_rook:
	move $a0, $s1
	move $a1, $s2
	move $a2, $s0
	move $a3, $sp
	jal validBishopMove
	j result
result:
	li $t0, -2
	beq $v0, $t0, error_input_aru
	li $t0, -1
	beq $v0, $t0, return_invalid
	### can move ####
	li $t0, 8
	mul $t8, $s4, $t0 # row*8
	add $t8, $t8, $s5 # row*8+col
	li $t0, 2
	mul $t8, $t8, $t0 # (row*8+col)*2
	li $t0, 0xffff0000
	add $t8, $t8, $t0
	lb $t0, 0($t8)
	lb $t1, 1($t8)
	bne $t0, 112, set_position
	addi $t0, $t0, -32
	##it's p, transfrom to P
	beq $v0, $zero, noCap
	#cap
	move $a0, $s6 
	move $a1, $s7
	move $a2, $t0 # char
	move $a3, $s0 # player
	sb $s3, 0($sp) # fg
	jal setSquare
	
	move $a0, $s4
	move $a1, $s5
	li $t5, 'E'
	move $a2, $t5
	move $a3, $s0
	sb $s3, 0($sp)
	jal setSquare
	# check if king moved
	li $v0, 1
	j return_I
set_position:
	beq $v0, $zero, noCap
	#cap
	move $a0, $s6 
	move $a1, $s7
	move $a2, $v1 # char
	move $a3, $s0 # player
	sb $s3, 0($sp) # fg
	jal setSquare
	
	move $a0, $s4
	move $a1, $s5
	li $t5, 'E'
	move $a2, $t5
	move $a3, $s0
	sb $s3, 0($sp)
	jal setSquare
	# check if king moved
	li $v0, 1
	j return_I
noCap:
	move $a0, $s6 
	move $a1, $s7
	move $a2, $v1 # char
	move $a3, $s0 # player
	addi $sp, $sp, -1
	sb $s3, 0($sp) # fg
	jal setSquare
	addi $sp, $sp, 1
	
	move $a0, $s4
	move $a1, $s5
	li $t5, 'E'
	move $a2, $t5
	move $a3, $s0
	addi $sp, $sp, -1
	sb $s3, 0($sp)
	jal setSquare
	addi $sp, $sp, 1
	li $v0, 0
	j return_I
return_invalid:
	li $v0, -1
	li $v1, 0
	j return_I
error_input_aru:
	li $v0, -2
	li $v1, 0 
	j return_I
return_I:
	###########epilogue############
	lw $ra, 4($sp)
	lw $s0, 8($sp)
	lw $s1, 12($sp)
	lw $s2, 16($sp)
	lw $s3, 20($sp)
	lw $s4, 24($sp)
	lw $s5, 28($sp)
	lw $s6, 32($sp)
	lw $s7, 36($sp)
	lw $t7, 40($sp)
	addi $sp, $sp, 44
	jr $ra
##########################################
#  Part #3 Function
##########################################

check:
	#########prologue############
	addi $sp, $sp, -28
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	#########Body################
	move $s0, $a0 # player
	move $s1, $a1 # oppoentKingPos
	srl $t0, $s1, 8
	move $s2, $t0 # s2 = to row
	blt $t0, $zero check_argument_error
	li $t1, 7
	bgt $t0, $t1 check_argument_error
	sll $t0, $t0, 8
	sub $t0, $s1, $t0
	move $s3, $t0 # s3 = to col
	blt $t0, $zero check_argument_error
	li $t1, 7
	bgt $t0, $t1 check_argument_error
	li $t1, 1
	beq $s0, $t1 check_aru_done
	li $t1, 2
	beq $s0, $t1 check_aru_done
	j check_argument_error
check_aru_done:
	li $t0, 0 # i
	li $t1, 8
	li $t2, 0xffff0000
	li $t3, 2
iterate_i_loop:
	bge $t0, $t1, done_iterate_i_loop
	#inside for i_loop
	li $t4, 0 # j
	iterate_j_loop:
		bge $t4, $t1, done_iterate_j_loop
		j getFromPosition
	begain_check:	
		jal mapChessMove
		# get from position
		move $s4, $v0 # from short 
		move $a0, $v0
		jal getChessPiece
		## get the piece char
		move $s5, $v0
		j check_Piece
	done_king_check:
		# v0 = int 
		# v1 = char
		beq $v0, $zero success
		beq $v0, 1 success
		addi $t4, $t4, 1
		j iterate_j_loop
done_iterate_j_loop:
	addi $t0, $t0, 1
	j iterate_i_loop
done_iterate_i_loop:
	j failure
check_Piece:
	li $t3, 'B'
	beq $s5, $t3, bishop_call
	li $t3, 'R'
	beq $s5, $t3, rook_call
	li $t3, 'P'
	beq $s5, $t3, pawn_call
	li $t3, 'p'
	beq $s5, $t3, pawn_call
	li $t3, 'H'
	beq $s5, $t3, knight_call
	li $t3, 'Q'
	beq $s5, $t3, queen_call
	li $t3, 'K'
	beq $s5, $t3, king_call
bishop_call:
	move $a0, $s4
	move $a1, $s1
	move $a2, $s0
	move $a3, $sp
	jal validBishopMove
	j done_king_check
rook_call:
	move $a0, $s4
	move $a1, $s1
	move $a2, $s0
	move $a3, $sp
	jal validRookMove
	j done_king_check
pawn_call:
	move $a0, $s4
	move $a1, $s1
	move $a2, $s0
	move $a3, $sp
	jal validPawnMove
	j done_king_check
knight_call:
	move $a0, $s4
	move $a1, $s1
	move $a2, $s0
	move $a3, $sp
	jal validKnightMove
	j done_king_check
queen_call:
	move $a0, $s4
	move $a1, $s1
	move $a2, $s0
	move $a3, $sp
	jal validQueenMove
	j done_king_check
king_call:
	move $a0, $s4
	move $a1, $s1
	move $a2, $s0
	move $a3, $sp
	jal validKingMove
	j done_king_check
getFromPosition:
	beq $t0, 0, its8
	beq $t0, 1, its7
	beq $t0, 2, its6
	beq $t0, 3, its5
	beq $t0, 4, its4
	beq $t0, 5, its3
	beq $t0, 6, its2
	beq $t0, 7, its1
its8:
	li $a1, '8'
	j secnondP
its7:
	li $a1, '7'
	j secnondP
its6:
	li $a1, '6'
	j secnondP
its5:
	li $a1, '5'
	j secnondP
its4:
	li $a1, '4'
	j secnondP
its3:
	li $a1, '3'
	j secnondP
its2:
	li $a1, '2'
	j secnondP
its1:
	li $a1, '1'
	j secnondP
secnondP:
	beq $t4, 0, itsA
	beq $t4, 1, itsB
	beq $t4, 2, itsC
	beq $t4, 3, itsD
	beq $t4, 4, itsE
	beq $t4, 5, itsF
	beq $t4, 6, itsG
	beq $t4, 7, itsH
itsA:
	li $a0, 'A'
	j begain_check
itsB:
	li $a0, 'B'
	j begain_check
itsC:
	li $a0, 'C'
	j begain_check
itsD:
	li $a0, 'D'
	j begain_check
itsE:
	li $a0, 'E'
	j begain_check
itsF:
	li $a0, 'F'
	j begain_check
itsG:
	li $a0, 'G'
	j begain_check
itsH:
	li $a0, 'H'
	j begain_check
check_argument_error:
	li $v0, -2
	j check_return
success:
	li $v0, 0
	j check_return
failure:
	li $v0, -1
	j check_return
check_return:
	#########epilogue#######
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addi $sp, $sp, 28
	jr $ra