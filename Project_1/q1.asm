.data
  str1: .asciiz "Joe Kunzler" # string str1 = "Joe Kunzler"
.text
  .globl main
    main: 
      li $v0, 4 # print_string

      # print(str1)
      la $a0, str1 # load address of str1 into $a0
      syscall


      j $ra