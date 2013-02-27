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
#       current = input[i];
#       freq[i] = count(input[], current);
#   }
#}
#   current = $t0
#   i = $t1
analyze:

li      $t1, 0 #i = 0

forloop:

bge     $t1, 26, endfor # i < 26

lb      $t0, $t1(sentence)        #current = input[i] 

#------prolouge-------#
addiu   $sp, -32        #push stack frame of 8 words

move    $a0, $t0        #count(current);
sw      16($sp), $t1    #save i 
sw      14($sp), $ra    #save $ra

jal     count           #count()

#-----epilogue--------#
lw      $t1, 16($sp)    #get i
lw      $ra, 14($sp)    #get $ra

addiu   $sp, 32         #pop stack

sw      (freq)$t1, $v0  #freq[i] = count();

addi    $t1, $t1, 1     #i++

endfor:

jr      $ra     #return

###############################
#           Count             #
###############################





