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
    # Your code goes here
