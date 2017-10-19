#
#  Author: Jinheon Baek
#  Date: 2017-10-19
#  Description: Sort 32 numbers in the descending order
#

.text
.align 4

main:
	la   $t0, Input_data
	la   $t1, Ouput_data
	subu $t2, $t1, $t0
	sra  $t2, $t2, 2		# how many numbers? shift right by 2
	addu $t3, $t2, 0		# temp parameter for move input data to output 

move_input_to_output:
	lw   $s0, 0($t0)
	sw   $s0, 0($t1)

	subu $t3, $t3, 1
	beq  $t3, $zero, bubble_sort
	addu $t0, $t0, 4
	addu $t1, $t1, 4
	
	j    move_input_to_output


bubble_sort:
	la   $t0, Ouput_data	# t0 : Output_data address storage
	addu $t1, $t2, 0		# t1 : how many times, bubble sort loop 1 iterate
	addu $t2, $t1, 0		# t2 : how many times, bubble sort loop 2 iterate
	addu $t8, $t2, 0		# t8 : how many numbers

bubble_sort_loop_1:	
	la   $t0, Ouput_data	# t0 : Output_data address storage
	addu $t2, $t8, 0

	subu $t1, $t1, 1		# first loop decrement by 1 (control iterate time)
	beq  $t1, $zero, done

	j    bubble_sort_loop_2

bubble_sort_loop_2:
	subu $t2, $t2, 1		# second loop decrement by 1 (control iterate time)
	beq  $t2, $zero, bubble_sort_loop_1

	lw   $s0, 0($t0)		# load two numbers to compare
	lw   $s1, 4($t0)

	addu $t0, $t0, 4		# change Ouput_data index

	slt  $s2, $s0, $s1		# Compare two numbers
	bne  $s2, $zero, swap

	j    bubble_sort_loop_2

swap:
	addu $s3, $s0, 0		# temp num to swap
	sw   $s3, 0($t0)
	sw   $s1, -4($t0)
	j    bubble_sort_loop_2

done:
	j    done

.data
.align 4
Input_data: .word 2, 0, -7, -1, 3, 8, -4, 10
			.word -9, -16, 15, 13, 1, 4, -3, 14
			.word -8, -10, -15, 6, -13, -5, 9, 12
			.word -11, -14, -6, 11, 5, 7, -2, -12
Ouput_data:	.word 0, 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0, 0