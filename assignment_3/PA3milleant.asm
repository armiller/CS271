#Author:    Anthony Miller
#Date:      February 22, 2012
#Detail:    This program outputs the number of each letter that is 
#           encountered in the input sentence.

.data

intro:		.asciiz	"Letter Counter by, Anthony Miller\n\nPlease enter a sentence:"
sentence:	.space 	1024
freq:		.space 	104         #26 integer array

.text

#############################
#           Main            #
#############################
#
#int main() {
#
#   setup();
#   analyze();
#   count();
#   results();
#
#   return 0;
#}
#
#
main:

	jal     setup           #Print notice and collect sentence
	jal     analyze         #
	jal     results

	li      $v0, 10         #Exit
	syscall	                 #

#############################
#           Setup           #
#############################
#
#void get_string(*sentence) {
#
#   printf("Letter Counter, by Anthony Miller\n");
#   sentence = scanf();
#
#   return;
#}
setup:

	#--------intro----------#
	li      $v0, 4          #
	la      $a0, intro      #Print intro
	syscall                 #

	#-------get name--------#
	li      $v0, 8          #
	li      $a1, 1024       #Size of input
	la      $a0, sentence   #Store sentence to memory
	syscall                 #Collect sentence

	jr      $ra             #return

#############################
#           Analyze         #
#############################
#
#void analyze(char[] input, char[] alphabet) {
#
#   char current;
#
#   for(int i = 0; i < 26; i++) {
#
#       current = alphabet[i];
#       freq[i] = count(input[], current);
#   }
#}
#   current = $t0
#   i = $t1
#   wordcount = $s1
analyze:

	addiu   $sp, $sp, -24           #push stack
	sw      $ra, 20($sp)            #save ra
	li      $t1, 0			#i = 0
	la	$s1, freq		#freq pointer
	li      $t0, 'A'                #current = input[i] 


	forloop:

	bge     $t1, 26, endfor         # i < 26

	#------prolouge-------#
	move    $a0, $t0                #count(current);

	jal     count                   #count()

	#-----epilogue--------#
	sw      $v0, 0($s1)             #freq[i] = return


	addi    $t0, $t0, 1             #freq[i+1]
	addi    $s1, $s1, 4             #word count + 4
	addi    $t1, $t1, 1		#i++

	j       forloop

	endfor:

	lw      $ra, 20($sp)            #get ra
	addiu   $sp, $sp, 24            #pop stack
	jr      $ra                     #return

###############################
#           Count             #
###############################
#
#   i = $t3
#   counter = $t4 
#   current = $t5
#   text = $t8
#
#int count(char input, char[] string) {   
#
#   while(string[i] != "\0") {
#
#       if(string[i] == input || string[i] == input - 32) {
#
#           counter++;
#
#        i++;
#
#   return counter;
#}
count:

	li          $t4, 0          # counter = $t4
	la          $t3, sentence

	whileloop:

	lb          $t5, 0($t3)                  	#string[i]                                
	beqz        $t5, endwhile                       #While(string[i] != "\0")

	beq         $t5, $a0, thenbranch                #if(string[i] == input)
	addi	    $t8, $a0, 32						# A || a  
	beq         $t5, $t8, thenbranch                #if(string[i] == input - 32)

	addi        $t3, $t3, 1                         #i++

	j           whileloop                           #loop

	thenbranch:

	addi		$t4, $t4, 1                    	#counter++
	addi        	$t3, $t3, 1                    	#i++

	j           whileloop                           #loop

	endwhile:

	move        $v0, $t4

	jr          $ra                                 #return			


#####################################
#			Results					#
#####################################
#
#	void analyze(char[] freq, char[] alphabet) {
#	
#		for(int i = 0; i < 26; i++) {
#	
#			printf("%c: ", alphabet[i]);
#			printf("%d\n", freq[i]);
#		}	
#	}
#
#	i = $t6
results:

	la	$t6, freq			#i = 0
	li      $t7, 'A'

	resultfor:
	#-----print newline----------#
	li		$v0, 11
	li		$a0, '\n'
	syscall
	#-----print "letter"---------#		#
	move		$a0, $t7        	# printf("%c: ", alphabet[i]);
	syscall

	#-----print ": "--------------#
	li		$a0, ':'
	syscall
	
	#-----print space-------------#
	li		$a0, ' '
	syscall

	#------print number-----------#
	li		$v0, 1
	lw		$a0, 0($t6)		# printf("%d\n", freq[i]); 
	syscall

	addi    $t6, $t6, 4                 	#increment word
	addi    $t7, $t7, 1                 	#i++

	beq     $t7, 'Z', resultend         	#(i == "z") break;

	j	resultfor					#loop

	resultend:

	jr			$ra
