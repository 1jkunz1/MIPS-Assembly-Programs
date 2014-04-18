    .data
str:        .space 65   # buffer for input string


newstr:      .space 65   # buffer for string w/o spaces


prompt:     .asciiz "Enter a string up to 64 characters\n"


joe1:      .asciiz "\nOriginal String:  "



joe3:      .asciiz "\nNew string with spaces removed:  "

.text   



#This is a program to prompt user for input. Then, we will loop through the string, compare each member to the ascii value of our whitespace and remove as #necessary




main:   
    #print the first prompt 
    li      $v0, 4          
    la      $a0, prompt     
    syscall                 #print prompt to console
    li      $v0, 8          #load syscall value to read input string
    la      $a0, str        
    li      $a1, 65
    syscall 

    jal     countSpace

    addi    $t1, $v0, 0     #the count of spaces is in $v0, save it into $t1
    li      $v0, 4          #print header then the count
    la      $a0, joe1  
    syscall
    la      $a0, str        #print the original string
    syscall
    

    li      $v0, 4
    la      $a0, joe3      #print the third header
    syscall
    la      $a0, newstr      #print no spaces string
    syscall


End:    
    li      $v0, 10         
    syscall                 #exit

countSpace:
    la      $s0, newstr
    addi    $sp, $sp, -12   
    sw      $s0, 8($sp)     #store addr of nospace string
    sw      $ra, 4($sp)     
    sw      $a0, 0($sp)     #store the count on the stack

    #Begin counting spaces
    addi    $t3, $a0, 0    
    addi    $t5, $s0, 0     
    li      $t6, 0          
    li      $t0, 0          
    li      $t4, 0          


loop:   
    add     $t1, $t3, $t4   #$t1 = addr of str[i]
    lb      $t2, 0($t1)     #$t2 = character in str[i]
    beq     $t2, $zero, exitCS  
    addi    $a0, $t2, 0     

    



#save values onto stack from temp registers to preserve them
    addi    $sp, $sp, -28   
    sw      $t6, 24($sp)    
    sw      $t5, 20($sp)    
    sw      $t4, 16($sp)    
    sw      $t3, 12($sp)    
    sb      $t2, 8($sp)     
    sw      $t1, 4($sp)      
    sw      $t0, 0($sp)     

    jal     isSpace         #result from this jump and link will be in $v0 after call

    




#pop saved values from the stack, then reset the pointer
    lw      $t6, 24($sp)
    lw      $t5, 20($sp)
    lw      $t4, 16($sp)
    lw      $t3, 12($sp)
    lb      $t2, 8($sp)
    lw      $t1, 4($sp)
    lw      $t0, 0($sp)
    addi    $sp, $sp, 28    #reset stack pointer
    beq     $v0, $zero, addTo   #if not a space, continue to next character
    addi    $t0, $t0, 1     #if it is a space, increment count




addTo:  
    bne     $v0, $zero, nextChar #If character is a space, branch
    move    $t7, $t6     #index if nospaces string stores width of 4
    add     $t7, $t7, $t5   
    sb      $t2, 0($t7)     
    addi    $t6, $t6, 1     

nextChar:

    addi    $t4, $t4, 1     #increment the index value
    j       loop            #jump back to loop and continue processing



exitCS:
    addi    $v0, $t0, 0     #count of spaces placed into $v0
    addi    $v1, $t5, 0
    lw      $ra, 4($sp)     #load return addr from the stack
    lw      $a0, 0($sp)     
    addi    $sp, $sp, 8     
    jr      $ra             #return



isSpace:
    addi    $sp, $sp, -12   #adjust stack pointer to make room
    sw      $s0, 8($sp)
    sw      $ra, 4($sp)     #store value of return addr onto stack
    sw      $a0, 0($sp)    

    #Check to see if the character is a space
    li      $t0, 32         
    li      $v0, 0          
    bne     $t0, $a0, endSC #if ascii values match, character is a space
    li      $v0, 1          #$v0 = 1 means it is a space character

endSC:  
    lw      $s0, 8($sp)
    lw      $ra, 4($sp)     #restore return address
    lw      $a0, 0($sp)     #restore addr of str
    addi    $sp, $sp, 12    #reset the stack pointer

end:    jr $ra