#This code give an overflow error. I am pretty sure the error is somewhere in #the for loop, but I was unable to debug it. 


.data
x: .asciiz    "Enter x: "


y: .asciiz    "Enter y: "



product: .asciiz   "Product = "
.globl     main
.text



main:
    li  $v0, 4 #load to enter the first prompt
    la  $a0, x
    syscall
    li  $v0, 5 #store inputed value
    syscall
    add $t0, $0, $v0

    


    li  $v0, 4 #prompt for second value
    la  $a0, y
    syscall
    li  $v0, 5 #store second input value
    





    syscall
    add $t1, $0, $v0
    add $t2, $0, $0 #create a variable to track loops
    j   loop



loop:
    
    beq $t2, $t1, Print #keep track of loops to multiply 
    add $t0, $t0, $t0 #"multiplies" by looping add
    addi $t2, $0, 1 #add one to counter variable
    j   loop


Print:
    li $v0, 4 #print the product prompt
    la $a0, product
    syscall 
    li $v0, 1 #print the product
    add $a0, $t0, $0
    syscall 
    j   Exit


Exit:
    li $v0, 10 #return control to the user
    syscall 