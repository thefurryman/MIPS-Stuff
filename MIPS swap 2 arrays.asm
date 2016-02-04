#CS 264 Spring 2009 Test#2 Q2
  .data
array1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
array2: .word 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
array1size: .space 80
array2size: .space 80
space: .asciiz " "
  .globl main
  .text

main: #load arrays and sizes
  la $a0, array1
  la $a1, array2
  li $t0, 80 #array counter 20 * 4 = 80
  li $t1, 0 #$t1 and $t2 for starting byte indexes for array
  li $t2, 0

swap:
  beqz $t0, exit

  lw $t3, 0($a0) #load indexes from array1 and array2 at $a0 and $a1 respectively
  lw $t4, 0($a1)

  #swapping values from same index
  move $t5, $t3 #store $t3 temp 
  move $t3, $t4 #array2 to array1
  sw $t3, 0($a0) #swapping actual values
  move $t4, $t5 #array1 temp to array2
  sw $t4, 0($a1)
  
  addi $a0, $a0, 4 #offset array1 to next integer
  addi $a1, $a1, 4 #offset array2 to next integer
  addi $t0, $t0, -4 #offset the counter by -4
  
  j swap 

exit:
  #loads only array1 to test what is stored and print
  la $t1, array1
  li $t7, 80
  
  jal print
  li $v0, 10
  syscall

print: #loop to print array1
  beqz $t7, tran
  
  li $v0, 1
  lw $t2, 0($t1)
  move $a0, $t2
  syscall
  
  #add a space in between numbers
  li $v0, 4 
  la $a0, space
  syscall
  
  addi $t1, $t1, 4 #offset array index to loop through
  addi $t7, $t7, -4 #offset counter to end loop
  
  j print

tran: #jump back to after jal print
  jr $ra
