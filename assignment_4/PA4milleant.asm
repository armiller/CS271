#Author:	Anthony Miller
#Date:		March 8, 2013
#Prints the number of fibonacci numbers by using 
#recusive algorithims and memoization

.data

greet:		.asciiz	"Fibonacci computation Part two,\n\tby Anthony Miller\n"
getnumber:	.asciiz	"\nEnter a number between [1-25]: "
notvalid:	.asciiz	"\nNumber is invalid, must be between 1-25\n"
banner1:	.asciiz	"\n== Purely Recursive =="
banner2:	.asciiz "\n\n== With Memoization =="
result:		.asciiz "\nResult: "
time:		.asciiz "\nTime: "

.align		2

n:			.word	0

memo:		.word	1
			.word	1
			.space	100

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

	jal		getN				#getN()
	
	
	#------Print banner----------#
	
	li		$v0, 4				#
	la		$a0, banner1		#Print first banner
	syscall						#
	
	la		$a0, fib			#first argument for testFib
	lw		$a1, n				#second argument for testFib
	
	jal		testFib				#testFib(int n);

	#------Print banner----------#
	
	li		$v0, 4				#
	la		$a0, banner2		#print second banner
	syscall						#
	
	la		$a0, fibM			#first argument
	lw		$a1, n				#second argument
	
	jal		testFib

	li		$v0, 10				#exit
	syscall			


#####################
#		testFib		#
#####################
#
#	void testFib(func* f, int n) {
#		int temp1, temp2, answer;
#		temp2start time();
#		anser = fib(n)
#		temp1 = stop time();
#		printf("anser: %d, time: %d", f, time1-time2);
#	}
#	starttime => $t1	endtime => $t2		result => $t3
testFib:

	addiu	$sp, $sp, -24		#push stack
	sw		$ra, 20($sp)		#save ra
	sw		$a1, 24($sp)		#save n

	move	$t0, $a0			#save function pointer
	
	li		$v0, 30				#start time
	syscall
	
	move 	$t1, $a0			#save time
	
	lw		$a0, 24($sp)		#get n
	
	jalr	$t0					#call function fib or fibm
	
	move	$t3, $v0			#save result
	
	li		$v0, 30				#stop time
	syscall				
	
	move	$t2, $a0			#time
	
	sub		$t5, $t2, $t1		#temp = time1 - time2
	
	li		$v0, 4				#
	la		$a0, result			#Print "Result:"
	syscall
	
	li		$v0, 1
	move	$a0, $t3			#print return
	syscall
	
	li		$v0, 4				#print "Time:"
	la		$a0, time			
	syscall
	
	li		$v0, 1
	move	$a0, $t5			#print time
	syscall
	
	lw		$ra, 20($sp)		#
	addiu	$sp, $sp, 24
	jr		$ra				


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
	sw		$s0, 20($sp)		#save n
	sw		$s1, 24($sp)		#save 
	sw		$ra, 16($sp)		#save $ra 
	#--------------------#

	move 	$s0, $a0			#save n
	blt     $a0, 2, return1     #if n <= 2 return 1;
	
	sub 	$a0, $s0, 1			#n-2
	
	jal		fib					#fib(n-1)
	
	move	$s1, $v0			#si = fib(n-1)
	
	sub		$a0, $s0, 2			#n-2
	
	jal		fib					#fib(n-2)
	
	add		$v0, $v0, $s1		#fib(n-1) + fib(n-2)

fibend:
	#---stack frame-------#
	lw		$s0, 20($sp)		#get fib(n-1)
	lw		$s1, 24($sp)		#get fib(n-2)
	lw		$ra, 16($sp)		#get ra
	addiu	$sp, $sp, 24		#push stack
	jr		$ra

return1:
	li		$v0, 1
	j		fibend
	
#####################
#		FibM		#
#####################
#
#	int FibM(int n) {
#		
#		if(memo[n] != 0) {
#			
#			return memo[n];
#		}
#		
#		else if(n < 2) {
#			memo[n] = n;
#		}
#		
#		else {
#			memo[n] = fib(n-1) + fib(n-2);
#		}
#
#	$t0 => i(memory counter)
#	$t1 => n
#	$t2 => fib(n-1)
#

fibM:
	#------stack frame----#
	addiu	$sp, $sp, -32		#push stack
	sw		$ra, 16($sp)		#save ra
	#---------------------#

	mul		$t0, $a0, 4			#i = n * 4
	
	lw		$v0, memo($t0)		#memo[n]
	
	bnez	$v0, fibMclose		#if(memo[n] == 0)
	
	bge		$a0, 2, fibMelse	#if(n > 2) 
	
	sw		$v0, memo($t0)		#memo[n] = n
	
	j		fibMclose
	
fibMelse:
		
	sw		$t0, 20($sp)		#save i
	sw		$a0, 24($sp)		#save n
		
	subi 	$a0, $a0, 1			#n-1
		
	jal		fibM				#fib(n-1)
		
	sw		$v0, 28($sp)		#save return
		
	lw		$a0, 24($sp)		#get n
	subi	$a0, $a0, 2			#n - 2
		
	jal		fibM				#fib(n-2)
	
	lw		$t0, 20($sp) 		#get i
	lw		$t2, 28($sp)		#get fib(n-1)
	
	add		$v0, $v0, $t2		#fib(n-1) + fib(n-2)
	
	sw		$v0, memo($t0)		#memo[n] = fib(n-1) + fib(n-2)

fibMclose:
	lw		$ra, 16($sp)		#get ra
	addiu	$sp, $sp, 32		#pop stack
	jr		$ra					#return