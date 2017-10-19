#
#  Author: Jinheon Baek
#  Date: 2017-10-19
#  Description: Sort 32 numbers in the descending order using bubble sort method
#

.text
.align 4

main:
	la   $t0, Input_data	# set Input_data address to $t0 register
	la   $t1, Ouput_data	# set Output_data address to $t1 register
	subu $t2, $t1, $t0		# to compute how many numbers, first subtract two addresses
	sra  $t2, $t2, 2		# how many numbers? shift right by 2
	addu $t3, $t2, 0		# temp parameter for move input data to output (how many times the loop should iterate) 

move_input_to_output:
	lw   $s0, 0($t0)		# load word at Input_data address
	sw   $s0, 0($t1)		# save word at Output_data address

	subu $t3, $t3, 1		# $t3 holds how many times the loop should iterate
	beq  $t3, $zero, bubble_sort	# if $t3 value is equal to zero, all Input_data values are moved into Ouput_data address
	addu $t0, $t0, 4		# if not, increase Input_data address by adding 4 (word size)
	addu $t1, $t1, 4		# if not, increase Output_data address by adding 4 (word size)
	
	j    move_input_to_output		# just for iterate loop, jump to begin area


bubble_sort:
	la   $t0, Ouput_data	# t0 : Output_data address storage
	addu $t1, $t2, 0		# t1 : how many times, bubble sort loop 1 iterate
	addu $t2, $t1, 0		# t2 : how many times, bubble sort loop 2 iterate
	addu $t8, $t2, 0		# t8 : how many numbers, I have to sort

bubble_sort_loop_1:	
	la   $t0, Ouput_data	# t0 : Output_data address storage
	addu $t2, $t8, 0		# t2 : how many times, bubble sort loop 2 iterate (for initialize that value to size n before going to the loop 2, that says loop 2 iterate n times)

	subu $t1, $t1, 1		# first loop decrement by 1 (control iterate count)
	beq  $t1, $zero, done	# if $t1 value is equal to zero, bubble sort is finished

	j    bubble_sort_loop_2		# if not, go to bubble sort loop 2 to sort numbers

bubble_sort_loop_2:
	subu $t2, $t2, 1		# second loop decrement by 1 (control iterate time)
	beq  $t2, $zero, bubble_sort_loop_1		# if $t2 value is equal to zero, second loop of bubble sort is finished

	lw   $s0, 0($t0)		# load two numbers to compare, $s0 is first number
	lw   $s1, 4($t0)		# load two numbers to compare, $s1 is second number

	addu $t0, $t0, 4		# change Ouput_data index

	slt  $s2, $s0, $s1		# Compare two numbers
	bne  $s2, $zero, swap	# if $s0, $s1 are not descending order, swap $s0, $s1 in Output_data

	j    bubble_sort_loop_2		# if not, go to bubble sort loop 2 to sort numbers

swap:
	addu $s3, $s0, 0		# temp number storage to swap
	sw   $s3, 0($t0)		# swap two numbers in Output_data 
	sw   $s1, -4($t0)		# swap two numbers in Output_data
	j    bubble_sort_loop_2		# after swap two numbers, go to bubble sort loop 2 to sort numbers

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