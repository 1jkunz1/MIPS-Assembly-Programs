#THis program will prompt the user to enter an integer, then print e^x using Taylor Series Expansion 

	 .data
enterX:  .asciiz    "Enter x: "
expX:    .asciiz    "exp(x) = "
         .globl     main
         .text


main:
         li         $v0, 4       # print_str
         la         $a0, enterX  # Prompt user for x
         syscall
         li         $v0, 6       # Code for read single
         syscall                 # $f0
         li         $t3, 0       # set n
         li         $t4, 10      # Initialize the endpoint for n
         li.s       $f6, 0.0     # Initialize the total



mloop:   beq        $t3, $t4, exit
                                 # If n > 10, finish
         move       $a0, $t3     
         jal        PW           

         move       $a0, $t3     
         jal        FACT          
         mtc1       $v0, $f4     
         cvt.s.w    $f4, $f4     
         div.s      $f4, $f2, $f4
         add.s      $f6, $f6, $f4

         addi       $t3, $t3, 1  
         j          mloop        # loop


PW:      move       $t0, $a0     # counter
         li.s       $f2, 1.0     # $f2 holds the result

ploop:   beq        $t0, $zero, pdone
                                 # If counter = 0, done
         mul.s      $f2, $f2, $f0# Multiply result by x
         addi       $t0, $t0, -1 # Decrement n
         j          ploop        # Loop
pdone:   jr         $ra          # Return


FACT:    li         $t2, 1       # result
         move       $t1, $a0     # t1 keeps track of the number to multiply by


faloop:  beq        $t1, $zero, fadone
                                 # Exit loop if done
         mul        $t2, $t2, $t1# Multiply the current result by t1
         addi       $t1, $t1, -1 # Decrement 
         j          faloop       # Loop to check if t1 is 0
fadone:  move       $v0, $t2     # Load the result 
         jr         $ra          # Return


exit:    li         $v0, 4       # print string
         la         $a0, expX    # Print "exp(x) = "
         syscall
         mov.s      $f12, $f6    # Pass expansion as arg
         li         $v0, 2       # print float
         syscall
         li         $v0, 10      # exit 
         syscall                 