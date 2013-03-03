#Author:    Anthony Miller
#Date:      February 22, 2012
#Detail:    This program outputs the number of each letter that is 
#           encountered in the input sentence.

.data

intro:      .asciiz     "\t\tLetter Counter by, Anthony Miller\n\nPlease enter a sentence: "

sentence:   .space      1024

alphabet:   .asciiz     "abcdefghijklmnopqrstuvwxyz" 

freq:       .space      104         #26 integer array

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
#jal     analyze         #
#jal     results

li      $v0, 10         #Exit
syscall                 #

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
analyze:

li      $t1, 0 #i = 0

forloop:

bge     $t1, 26, endfor         # i < 26

lb      $t0, $t1(alphabet)      #current = input[i] 

#------prolouge-------#
addiu   $sp, -24                #push stack frame of 8 words

move    $a0, $t0                #count(current);
sw      20($sp), $t1            #save i 
sw		24($sp), $ra			#save ra

jal     count                   #count()

#-----epilogue--------#
lw      $t1, 20($sp)            #get i
lw		$ra	 24($sp)			#get ra

addiu   $sp, 24                 #pop stack

sw      (freq)$t1, $v0          #freq[i] = count();

addi    $t1, $t1, 1             #i++

endfor:

jr      $ra                     #return

###############################
#           Count             #
###############################
#
#    i = $t3
#    counter = $t4 
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

#-----------callee proloug----------------#
addiu		$sp, $sp, -24	#push stack
sw			$ra, 20($sp)	#save
#-----------------------------------------#

li          $t3, 0			# i = $t3
li     		$v0, 0			# counter = $v0

whileloop:

beqz        (sentence)$t3, endwhile   			#While(string[i] != "\0")

beq         (sentence)$t3, $a0, thenbranch      #if(string[i] == input)
addiu       $a0, $a0, -32						# A || a  
beq 		(sentence)$t3, $a0, thenbranch		#if(string[i] == input - 32)

addi		$t3, $t3, 1							#i++

thenbranch:

addi		$v0, $v0, 1							#counter++

j			whileloop							#loop

endwhile:

#------------Callee outro------------------#
lw			$ra, 20($sp)		#load ra
addiu		$sp, $sp, 24
#------------------------------------------#
jr			$ra									#return			


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
#	i = $t5
results:

li		$t5, $t5, 0					#i = 0

resultfor:

blt		$t5, 26, resultend			# (i < 26)

#-----print "letter"---------#
li		$v0, 8						#
lb		$a0, $t5(alphabet)			# printf("%c: ", alphabet[i]);
syscall



resultend:

jr			$ra



