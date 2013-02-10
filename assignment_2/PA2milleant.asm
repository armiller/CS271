#   Author:         Anthony Miller
#   Date:           February 8, 2012
#   Description:    Prints out the number of fibionaciee numbers 
#                   a user inputs.

.data

greet:      .ascii      "\tFibinnoci numbers\n\n\tBy: Anthony Miller\n\n"
            .asciiz     "This program outpus fibinoccie numbers!\n"

greetintro: .asciiz     "Hello " 
getnumber:  .asciiz     "\nHow many fiboniacci numbers do you want to see?: "
getname:    .asciiz     "\nPlease enter your name: "

notvalid:   .asciiz     "\nNumber is invalid, must be between 1-47"

newline:    .asciiz     "\n"

name:       .space      64  

n:          .word       0

.text
#--------Greet---------------#

li      $v0, 4          #Prepare system to print string
la      $a0, greet      #Load greet string
syscall                 #Print string

#-------Get Name------------#

#"Please enter your name: "
li      $v0, 4          #Prepare system to print string
la      $a0, getname    #Load get name string
syscall                 #Print string

#get_name()
li      $v0, 8          #Prepare system to read string
li      $a1, 64         #Maximum string size
la      $a0, name       #Store name into memory
syscall                 #Get name

#------Greet with name------#

#"Hello"
li      $v0, 4          #Prrepare system to print string
la      $a0, greetintro #Print "Hello"
syscall                 #Print

#"Name"
li      $v0, 4          #Prepare system to print string
la      $a0, name       #Load user name
syscall                 #print name

#------Get Number-----------#

#Loop: 
#   While (n < 1 && n > 47) {
#   
#       printf("Not a valid number. Must be within 1-47");
#       n = get_int();
#
#    }
#
#   Continue...    
#

getNumLoop:   
            #"How many numbers do you want to see?"
            li      $v0, 4              #Prepare system to print string
            la      $a0, getnumber      #Load getnumber string
            syscall                     #Print string

            #get_number() 
            li      $v0, 5              #Prepare system to read Int
            syscall                     #Collect Int from user
            sw      $v0, n              #Store number to memory 
            move    $t0, $v0            #Move number to get ready for if statement

            blez    $t0, nvalid       # if (n <= 0 ) goto notvalid label
            bgt     $t0, 47, nvalid   # if (n > 47) goto notvalid label 
            j       endloop             # goto end if (n > 0 && n < 47)
nvalid:   
            
            #"Number is invalid, must be between 1-47. 
            li      $v0, 4              #Get system ready to print string
            la      $a0, notvalid       #Load not valid string
            syscall                     #Print String

            j       getNumLoop          #Go back to num loop


endloop:

#-------Computer Fibonacci numbers-------#




li      $v0, 10         #Prepare system to exit
syscall                 #Exit
