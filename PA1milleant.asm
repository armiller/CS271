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
differnce:	.word 0
quotient:	.word 0
remainder:	.word 0

text:	.space 100

.text 
#-----greet------#
li 	$v0, 4			#Call system to primt stings
la	$a0, greet		#Load the Greet statment
syscall				#Print the Greet

#---1 prompt-----#
li	$v0, 4			#call system to print string
la	$a0, prompt1		#Load 1st prompt
syscall				#Print first prompt

li	$v0, 8			#Call system to obtain number
li	$a1, 100		#max number = 100
la	$a0, num1		#save entry to num1
syscall

li	$v0, 4
la	$a0, num1
syscall

li	$v0, 10
syscall