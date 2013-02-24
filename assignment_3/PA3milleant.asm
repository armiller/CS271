#Author:    Anthony Miller
#Date:      February 22, 2012
#Detail:    This program outputs the number of each letter that is 
#           encountered in the input sentence.

.data

intro:  .asciiz     "Letter Counter by, Anthony Miller\n"

sentence:   .space      1024


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
jal     count
jal     results

li      $v0, 10         #Exit
syscall                 #

#############################
#           Setup           #
#############################
setup:

#--------intro----------#
li      $v0, 4          #
la      $a0, intro      #Print intro
syscall                 #

#-------get name--------#
li      $v0, 8          #
syscall                 #Collect sentence
sw      $v0, sentence   #Store to memory

jr      $ra             #return

#############################
#           Analyze         #
#############################



