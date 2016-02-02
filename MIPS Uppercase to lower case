#CS 264 Spring 2009 Test#2 Q1 [released]

.data
string: .asciiz "HELLO"
size: .word 5
newLine: .asciiz "\n"
.globl main
.text

main:
la $a0, size
lw  $a0, 0($a0)
la $a1, string
move $t0, $a0

check:
beqz $t0, exit

lb $t1, 0($a1)
addi $t1, $t1, 32
addi $t0, $t0, -1
addi $a1, $a1, 1

li $v0, 11
move $a0, $t1
syscall

j check

exit:
li $v0, 10
syscall
