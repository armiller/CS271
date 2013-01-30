# Author:	Anthony Miller
# Date:		1/30/2013
# Description:	Greets user and prompts user for 2 numbers. 
#		Runs calculations on numbers and outputs concluding message.
.data

greet: .ascii "Computation by Anthony Miller.\n" 
       .asciiz "This program takes two numbers and runs calcuations on them!\n"	
       
prompt1: .asciiz "Enter a number: "
prompt2: .asciiz "Enter a second number: "

num1:	.word 0
num2:	.word 0

.text 

li 	$v0, 4
la	$a0, greet
syscall
li	$v0, 10
syscall