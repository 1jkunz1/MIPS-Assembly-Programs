         .data
enterX:  .asciiz    "Enter x: "
enterN:  .asciiz    "Enter n: "
factP:   .asciiz    "n! = "
powP:    .asciiz    "x^n = "
newl:    .asciiz    "\n"
         .globl     main
         .text

#This is a program to prompt the user to enter two numbers. It will ask for x and n. I will return x^n and n!        

main:
         li         $v0, 4       # prompt for string
         la         $a0, enterX  # Promptfor x
         syscall
         li         $v0, 6       
         syscall                

         li         $v0, 4       # print_str
         la         $a0, enterN  # load address enterX
         syscall

         li         $v0, 5       #read int
         syscall

         move       $t0, $v0     # Save n to $t0
         move       $a0, $t0     
         jal        FACT         # calculate n!
         move       $t1, $v0     # Store result
         li         $v0, 4       # print string
         la         $a0, factP   # load address factP
         syscall
         li         $v0, 1       # print int
         move       $a0, $t1     # Load Result
         syscall                 # Print result

         li         $v0, 4       # Print String
         la         $a0, newl    # newline
         syscall

         move       $a0, $t0     # Pass n as arg
         jal        POW          # Compute x^n, 
         li         $v0, 4       # print string
         la         $a0, powP    # Print our power of p
         syscall

         li         $v0, 2       # print float
         mov.s      $f12, $f2    # Load the float
         syscall                 # Print result
         j          exit



FACT:    li         $t2, 1       # t2 hold result
         move       $t1, $a0     
faloop:  beq        $t1, $zero, fadone
                                 # Exit loop if done
         mul        $t2, $t2, $t1
         addi       $t1, $t1, -1 # Decrement t1
         j          faloop       # Loop


fadone:  move       $v0, $t2     # Load the result into the result register
         jr         $ra          # Return



POW:     move       $t0, $a0     # $t0 is the counter, goes from n to 0
         li.s       $f2, 1.0     # $f2 holds the result, x is in $f0


poloop:  beq        $t0, $zero, podone
                                 # If counter = 0,DONE
         mul.s      $f2, $f2, $f0# Multiply result by x
         addi       $t0, $t0, -1 # Decrement n
         j          poloop        # Loop
podone:  jr         $ra          # Return

exit:    li         $v0, 10     
         syscall                 # Return control to system
