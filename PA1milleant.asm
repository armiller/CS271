# Author:	Anthony Miller
# Date:		1/30/2013
# Description:	Greets user and prompts user for 2 numbers. 
#		Runs calculations on numbers and outputs concluding message.
.data

greet: 		.ascii "\t\tComputation by Anthony Miller\n\n" 
       		.asciiz "This program takes two numbers and runs calcuations on them!\n\n"
       		
close:		.asciiz "Thank you for using Computation! Have a good day!\n"	

prompt1: 	.asciiz "Enter a number: "
prompt2: 	.asciiz "Enter a second number: "

equals:		.asciiz " = "
plus:		.asciiz " + "
minus:		.asciiz " - "
divide:		.asciiz " / "
times:		.asciiz " * "
leftover:	.asciiz " % "
newline:	.asciiz "\n"

sum:		.word	0
difference:	.word	0
product:	.word	0
quotient:	.word	0
remainder:	.word	0

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
syscall
move	$t1, $v0		#Move number to t0 register

#---2nd prompt---#
la	$a0, prompt2
li	$v0, 4			#Call system to print string
syscall				#Print second prompt

li	$v0, 5			#Call system to obtain number
syscall		
move	$t2, $v0		#Move number to t0 resgister


#--Compute Numbers-#
add	$t5, $t1, $t2		#Sum of two numbers
sw	$t5, sum		#Store result in memory

sub	$t6, $t1, $t2		#difference between two numbers
sw	$t6, difference		#store result in memory

mul	$t7, $t1, $t2		#mulitply two numbers
sw	$t7, product		#store result in memory

div	$t1, $t2		#divide numbers 
mflo	$t3			#Move quotient into t3
mfhi	$t4			#Move remainder into t4
sw	$t3, quotient		#Store quotient in memory
sw	$t4, remainder		#Store remainder in memory

#---Print Sum Output---#
li	$v0, 4			#
la	$a0, newline		#New line
syscall				#

li	$v0, 1			#
move	$a0, $t1		#
syscall 			#

la	$a0, plus		#
li	$v0, 4			#Print out Sum of two numbers.
syscall				#

li	$v0, 1			#
move	$a0, $t2		#
syscall				#

la	$a0, equals		#
li	$v0, 4			#
syscall				#

li	$v0, 1			#
lw	$a0, sum		#
syscall

#---Print Difference Output--#
li	$v0, 4			#
la	$a0, newline		#New line
syscall				#

li	$v0, 1			#
move	$a0, $t1		#
syscall 			#

la	$a0, minus		#
li	$v0, 4			#Print out Difference of two numbers.
syscall				#

li	$v0, 1			#
move	$a0, $t2		#
syscall				#

la	$a0, equals		#
li	$v0, 4			#
syscall				#

li	$v0, 1			#
lw	$a0, difference		#
syscall

#--Print Product---#
li	$v0, 4			#
la	$a0, newline		#New line
syscall				#

li	$v0, 1			#
move	$a0, $t1		#
syscall 			#

la	$a0, times		#
li	$v0, 4			#Print out Product of two numbers.
syscall				#

li	$v0, 1			#
move	$a0, $t2		#
syscall				#

la	$a0, equals		#
li	$v0, 4			#
syscall				#

li	$v0, 1			#
lw	$a0, product		#
syscall

#--Print Qoutient---#
li	$v0, 4			#
la	$a0, newline		#New line
syscall				#

li	$v0, 1			#
move	$a0, $t1		#
syscall 			#

la	$a0, divide		#
li	$v0, 4			#Print out Quotient of two numbers.
syscall				#

li	$v0, 1			#
move	$a0, $t2		#
syscall				#

la	$a0, equals		#
li	$v0, 4			#
syscall				#

lw	$a0, quotient
li	$v0, 1			#
syscall

#----Print Remainder----#
li	$v0, 4			#
la	$a0, newline		#New line
syscall				#

li	$v0, 1			#
move	$a0, $t1		#
syscall 			#

la	$a0, leftover		#
li	$v0, 4			#Print out Remainder of two numbers.
syscall				#

li	$v0, 1			#
move	$a0, $t2		#
syscall				#

la	$a0, equals		#
li	$v0, 4			#
syscall				#

li	$v0, 1			#
lw	$a0, remainder		#
syscall

#---Print Close----#
li	$v0, 4			#
la	$a0, newline		#New line
syscall	

li	$v0, 4			#
la	$a0, newline		#New line
syscall	

li	$v0, 4
la	$a0, close
syscall

#---Exit-----#

li	$v0, 10
syscall
