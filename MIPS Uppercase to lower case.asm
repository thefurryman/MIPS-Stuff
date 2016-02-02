#CS 264 Spring 2009 Test#2 Q1 [released]

.data
string: .asciiz "HELLO"
size: .word 5
newLine: .asciiz "\n"
.globl main
.text

main: #load size and string
la $a0, size
lw  $a0, 0($a0)
la $a1, string
move $t0, $a0 #move size to $t0 register for counter

check:
beqz $t0, exit #when size = 0, exit

lb $t1, 0($a1) #load byte at $a1
addi $t1, $t1, 32 #convert to lower case add 32 (decimal ascii)
sb $t1, 0($a1) #UNTESTED, switches original uppercase with new lowercase character
addi $t0, $t0, -1 #-1 offset counter for size
addi $a1, $a1, 1 #offset byte location on string to the next character

li $v0, 11 #print character
move $a0, $t1
syscall

j check #jump back to check function to continue loop

exit:
li $v0, 10
syscall
