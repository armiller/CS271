# Author:	Anthony Miller
# Date:		1/30/2013
# Description:	Greets user and prompts user for 2 numbers. 
#		Runs calculations on numbers and outputs concluding message.
.data

greet: 		.ascii "\t\tComputation by Anthony Miller\n\n" 
       		.asciiz "This program takes two numbers and runs calcuations on them!\n\n"	
       
prompt1: 	.asciiz "Enter a number: "
prompt2: 	.asciiz "Enter a second number: "

num1:		.word 0
num2:		.word 0

sum:		.word 0
difference:	.word 0
quotient:	.word 0
remainder:	.word 0

text:	.space 100

.text 
#-----greet------#
li 	$v0, 4			#Call system to primt stings
la	$a0, greet		#Load the Greet statment
syscall				#Print the Greet

#---1 prompt-----#
li	$v0, 4			#Call system to print string
la	$a0, prompt1		#Load 1st prompt
syscall				#Print first prompt

li	$v0, 5			#Call system to obtain number
li	$a1, 100		#Max number = 100		
syscall
move	$v0, $t0		#save result to num2
#---2nd prompt---#
la	$a0, prompt2
li	$v0, 4			#Call system to print string
syscall				#Print second prompt

li	$v0, 5			#Call system to obtain number
syscall		
move	$v0, $t1		#save result to num2

#--Compute Numbers-#
add	$t0, $t1, $t2		#Sum of two numbers
sw	$t0, sum		#Store result in memory

sub	$t0, $t1, $t2
sw	$t0, difference

mul	$t0, $t1, $t2
sw	$t0, product

li	$v0, 10
syscall