.data
Prompt1:    .asciiz "Enter the value of n here: "
Prompt2:    .asciiz "The Letter is: "
Prompt3:    .asciiz "?\n"

.globl main
.text
main:

				#print prompt 1
li  $v0, 4
la  $a0, Prompt1
syscall

				#get N
li  $v0, 5
syscall
blez    $v0, end
move $t8, $v0 #store N in $t8

				#print prompt2
li  $v0, 4
la  $a0, Prompt2
syscall

				#print character equivalent
li  $v0, 4
li  $t1, '@'
add $a0, $t1, $t8
li  $v0, 11
syscall

#print ?
li  $v0, 4
la  $a0, Prompt3
syscall

end:
li  $v0, 10
syscall