#   Author:         Anthony Miller
#   Date:           February 8, 2012
#   Description:    Prints out the number of fibionaciee numbers 
#                   a user inputs.

.data

greet:      .ascii      "\tFibinnoci numbers\n\n\tBy: Anthony Miller\n\n"
            .asciiz     "This program outpus fibinoccie numbers!\n"

getnumber:  .asciiz     "\nHow many fiboniacci numbers do you want to see?: "
getname:    .asciiz     "\nPlease enter your name: "

newline:    .asciiz     "\n"

name:       .space      100  

n:          .word       0

.text

li      $v0, 4          #Prepare system to print string
la      $a0, greet      #Load greet string
syscall                 #Print string

li      $v0, 4          #Prepare system to print string
la      $a0, getname    #Load get name string
syscall                 #Print string

li      $v0, 8          #Prepare system to read string
li      $a1, 100        #Maximum string size
la      $a0, name       #Store name into memory
syscall                 #Get name

li      $v0, 4          #Prepare system to print string
la      $a0, getnumber  #Load getnumber string
syscall                 #Print string

li      $v0, 5          #Prepare system to read Int
syscall                 #Collect Int from user
sw      $v0, n          #Store number to memory 


li      $v0, 10         #Prepare system to exit
syscall                 #Exit
