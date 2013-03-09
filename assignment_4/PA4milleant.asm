#Author:	Anthony Miller
#Date:		March 8, 2013
#Prints the number of fibonacci numbers by using 
#recusive algorithims and memoization

.data

greet:		.asciiz	"Fibonacci computation Part two,\n\tby Anthony Miller\n"
getnumber:	.asciiz	"\nHow many numbers do you want to see?"
notvalid:	.asciiz	"\nNumber is invalid, must be between 1-47\n"
banner1:	.asciiz	"\n== Purely Recursive =="

n:			.word	0


.text

main:

	#--------Greet---------------#

	li      $v0, 4          	#Prepare system to print string
	la      $a0, greet      	#Load greet string
	syscall                 	#Print string

	jal		getN				#getn(int n);

	#------Print banner----------#
	
	li		$v0, 4				#
	la		$a0, banner1		#Print first banner
	syscall						#

	li		$v0, 10				#exit
	syscall			



getN:   
	#"How many numbers do you want to see?"
	li	$v0, 4              	#Prepare system to print string
	la	$a0, getnumber      	#Load getnumber string
	syscall                     #Print string

	#get_number() 
	li      $v0, 5              #Prepare system to read Int
    syscall                     #Collect Int from user
	sw      $v0, n              #Store number to memory 
  	move    $t0, $v0            #Move number to get ready for if statement

	blez    $t0, nvalid         # if (n <= 0 ) goto notvalid label
	bgt     $t0, 47, nvalid     # if (n > 47) goto notvalid label 
	jr      $ra	             	# goto end if (n > 0 && n < 47)

nvalid:   
	#"Number is invalid, must be between 1-47. 
	li		$v0, 4              #Get system ready to print string
	la		$a0, notvalid       #Load not valid string
	syscall                     #Print String

	j       getN	          	#Go back to num loop
	
