    
#Attempt at a solution. I found similar programs online, this program will #multiply the first numbers but doesn't get to the rest of the array


    .data
arrayA:     .byte 9,13,10,20,1,6,9,14
arrayB:     .byte 41,3,5,7,19,2,1,7
arrayC:     .space 40 
result:     .asciiz "Product = "
    .globl main

    .text




main:
    



    la  $s0, arrayA             #Load address of array1 to s0
    la  $s1, arrayB             #…
    la  $s2, arrayC             #...
    lb  $t0, 0($s0)             #Load first byte of array1 to t0
    lb  $t1, 0($s1)             #...
    li  $t8, 8                  

loop:
    beq $t0, 0, next        #if the variable X is 0, go to next
    add $t2, $t1, $t2       #add t2 and Y
    addi $t0, $t0, -1       #decrement X
    j loop                  #jump to loop

next:
    sw $t2, 0($s2)          #Store the product into array3 
    
    li $t2, 0               #Load 0 to t2 to reset it  



loop
    addi $t8, $t8, -1       #decrement t8
    add  $s0, $s0, 1        #Shift to next byte 
    lb  $t0, 0($s0)         #Load first byte of array1 to t0
    add  $s1, $s1, 1        #Shift to next byte 
    lb  $t1, 0($s1)         #Load first byte of array2 to t1
    add  $s2, $s2, 4        #Shift to next word in array3
    bne  $t8, 0, loop       #If t8 is not yet 0 
    li $t8, 8               #Load 8 to t8
    add  $s2, $s2, -32      #Shift to first word of array3
    j print1                    #jump to print procedure

print1:
    li $v0, 4               #system call code for print string
    la $a0, result          #Load address of result to a0
    syscall                 #print result
    j print2                #jump to print2 procedure

print2:
    li $v0, 1                   #Load system call for print integer
    lw $a0, 0($s2)              #Load first word of array3 to a0
    syscall                     #print Integer
    bne $t8, 0, print2          #if t8 is not equal to 8, loop to print2 procedure
    j close                     #Else jump to close

close:
    li $v0, 10                  #load system call code for terminate
    syscall                     #return control to system