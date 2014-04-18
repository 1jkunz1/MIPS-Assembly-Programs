# PrintList.asm

.data
Size: .word 8
Array: .word 9, 72, 101, 108, 108, 111, 13, 10, 0
NL: .asciiz "\n"
.text

main:
lw $s7, Size # get size of list
move $s1, $zero # set counter for # of elems printed
move $s2, $zero # set offset from Array
print_loop:
bge $s1, $s7, print_loop_end # stop after last elem is printed

lw $a0, Array($s2) # print next value from the list
li $v0, 1 #print_char opcode
syscall

la $a0, NL # print a newline
li $v0, 4
syscall

addi $s1, $s1, 1 # increment the loop counter
addi $s2, $s2, 4 # step to the next array elem

j print_loop # repeat the loop
print_loop_end: