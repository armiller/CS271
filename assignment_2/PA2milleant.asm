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

conclusion: .asciiz     "There you go! Have a good day, "
spaces:     .asciiz     "    "

newline:    .asciiz     "\n"

name:       .space      64  

n:          .word       0

.text
#########################################
#               Section 1               #
#########################################

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

#########################################
#               Section 2               #
#########################################

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

            blez    $t0, nvalid         # if (n <= 0 ) goto notvalid label
            bgt     $t0, 47, nvalid     # if (n > 47) goto notvalid label 
            j       endloop             # goto end if (n > 0 && n < 47)
nvalid:   
            
            #"Number is invalid, must be between 1-47. 
            li      $v0, 4              #Get system ready to print string
            la      $a0, notvalid       #Load not valid string
            syscall                     #Print String

            j       getNumLoop          #Go back to num loop

#Continue
endloop:

#########################################      
#               Section 3               #
#########################################

#-------Compute Fibonacci numbers-------#

#   i = $t0; $t0 = 0
#   n = $t1;
#   firstnum = $t3
#   secondnum = $t4
#   tmp = $t5
#
#   for(i; i < n; i++) {
#
#       tmp = firstnum + secondnum;
#       printf("%d   " , tmp);
#       firstnum = secondnum;
#       secondnum = tmp;
#
#    }
#

li      $t0, 1  # i = $t0; $t0 = 1
la      $t1, n  # $t1 = n 
li      $t3, 0  # firstnum $t3 = 0
li      $t4, 0  # secondnum $t4 = 0
li      $t5, 0  # tmp; $t5 = 0 

forloop:
        
        bgt     $t0, $t1, endfor    #if(n > i) loop

        add     $t5, $t3, $t4   #tmp = firstnum + secondnum
        
        #---------Print number-----------#
        li      $v0, 1          #printf()
        move    $a0, $t5        #"%d" = tmp
        syscall                 #Print tmp
        
        #---------Print 4 spaces---------#

        li      $v0, 4          #printf()
        la      $a0, spaces     #print 4 spaces
        syscall                 #print

        #---------move numbers-----------#
        
        move    $t3, $t4        # firstnum = secondnum
        move    $t4, $t5        # secondnum = tmp

        addi    $t0, $t0,  1          #i++

        j   forloop             #loop


endfor:

##############################################
#               Section 4                    #
##############################################

#----------Print conlusion---------#

li      $v0, 4          #Prepare system to print string
la      $a0, conclusion #Load conlusion string
syscall

#---------Print name---------------#
li      $v0, 4          #prepare system to print name
la      $a0, name       #Load nam
syscall                 



li      $v0, 10         #Prepare system to exit
syscall                 #Exit
