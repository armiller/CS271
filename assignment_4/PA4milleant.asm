#Author:	Anthony Miller
#Date:		March 8, 2013
#Prints the number of fibonacci numbers by using 
#recusive algorithims and memoization

.data

greet:		.asciiz	"Fibonacci computation Part two,\n\tby Anthony Miller\n"
getnumber:	.asciiz	"\nEnter a number between [1-25]:"
notvalid:	.asciiz	"\nNumber is invalid, must be between 1-25\n"
banner1:	.asciiz	"\n== Purely Recursive =="

n:			.word	0


.text

#####################
#		Main		#
#####################
#
#	int main(int argc, int* argv[]) {
#
#		int n;		
#		printf("%s\n, greet);
#		n = getN();
#		printf("%s\n, banner1);
#	}
#
#
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
	
	lw		$a0, n				#fib(n);
	jal		fib					#

	li		$v0, 10				#exit
	syscall			


#####################
#		testFib		#
#####################











#####################
#		GetN		#
#####################
#
#	int getN() {
#		int temp;
#		do {
#			printf("%s\n, getnumber);
#			scanf("%d", temp);
#		while(temp <= 0 || temp > 25);
#
#		return temp;
#	}
#	temp => $t0

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
	bgt     $t0, 25, nvalid     # if (n > 47) goto notvalid label 
	jr      $ra	             	# goto end if (n > 0 && n < 47)

	nvalid:   
	#"Number is invalid, must be between 1-47. 
	li		$v0, 4              #Get system ready to print string
	la		$a0, notvalid       #Load not valid string
	syscall                     #Print String

	j       getN	          	#Go back to num loop
	
#####################
#		fib			#
#####################
#
#	int fib(int n) {
#	
#		if (n <= 2) return 1
#		else return fib(n-1) + fib(n-2)
#	}
#
#	n => $a0	 saved n => $s0		return => $s1
#	
fib:

	#----stack frame-----#
	addiu	$sp, $sp, -24		#push stack
	sw		$s0, 16($sp)		#save $s0
	sw		$s1, 20($sp)		#save $s1
	sw		$ra, 24($sp)		#save $ra 
	#--------------------#
	
	move	$s0, $a0			#save n
	
	ble		$a0, 2, fibthen		#if (n <= 2) return 1
	
	sub		$a0, $s0, 1			#prepare for fib(n-1)
	
	jal		fib					#fib(n-1)
	
	add		$s1, $s1, $v0		#$s1 = fib(n-1)
	
	sub		$a0, $s0, 2			#prepare for fib(n-2)
	
	jal		fib					#fib(n-2)
	
	add		$v0, $v0, $s1		#fib(n-1) + fib(n-2)

	fibexit:
	
	#---stack frame-------#
	lw		$ra, 24($sp)		#get $ra
	lw		$s1, 20($sp)		#get $s1
	lw		$s0, 16($sp)		#get $s0
	addiu	$sp, $sp, 24		#push stack
	
	fibthen:
	
	li		$v0, 1				#return 1
	j		fibexit
	
