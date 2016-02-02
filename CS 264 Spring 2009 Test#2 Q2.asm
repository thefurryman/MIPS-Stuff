.data
array1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
array2: .word 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
array1size: .space 80
array2size: .space 80
space: .asciiz " "
.globl main
.text

main:
la $a0, array1
la $a1, array2
li $t0, 80
li $t1, 0
li $t2, 0

swap:
beqz $t0, exit

lw $t3, 0($a0)
lw $t4, 0($a1)

move $t5, $t3 #store $t3 temp
move $t3, $t4 #array2 to array1
sw $t3, 0($a0)
move $t4, $t5 #array1 temp to array2
sw $t4, 0($a1)

addi $a0, $a0, 4
addi $a1, $a1, 4
addi $t0, $t0, -4

j swap

exit:
la $t1, array1
li $t7, 80

jal print
li $v0, 10
syscall

print:
beqz $t7, tran

li $v0, 1
lw $t2, 0($t1)
move $a0, $t2
syscall

li $v0, 4
la $a0, space
syscall

addi $t1, $t1, 4
addi $t7, $t7, -4

j print

tran:
jr $ra