	.data
arraySize: .space 80
integerPrompt: .asciiz "Enter a digit to be stored into the array: "
newLine: .asciiz "\n"

	.globl main
	.text

main:
	li $s3, 0 #array index offsetter

readInt:
	li $v0, 4
	la $a0, integerPrompt
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, arraySize($s3)
	addi $s3, $s3, 4
	
	beq $s3, 80, trans1
	
	j readInt
	
trans1:
	li $t7, 0 #will hold max value
	li $t6, 99999 #will hold min value
	li $s3, 0 #array counter
	j smallestLargest

smallestLargest:
	beq $s3, 80, trans2
	lw $t0, arraySize($s3) 
	addi $s3, $s3, 4
	
	jal checkMin    #these two lines will check for min and max values of the index
	bge $t0, $t7, newMax  #this just checks if index is greater than value in $t7
	
	j smallestLargest
	
checkMin:
	ble $t0, $t6, newMin  #check if the element is smaller than $t6 value
	jr $ra

newMin:
	move $t6, $t0 #move element to the min value holder $t6
	jr $ra
	
newMax:
	move $t7, $t0
	j smallestLargest
	
trans2:
	li $s3, 0
	li $s1, 4	#set to number 4 to divide
	li $s2, 0	#counter for number of integers divisible by 4
	j divisible
	
divisible:
	lw $t0, arraySize($s3)
	addi $s3, $s3, 4
	rem $s0, $t0, $s1  #remainder/modulus and store into $s0
	
	beqz $s0, upCounter  #if $s0 is 0, then it means that the element was divisible by 4
	beq $s3, 80, exit
	
	j divisible
	
upCounter:
	addi $s2, $s2, 1  #increase counter by 1
	j divisible
	
exit:
	li $v0, 1  #this prints the max which is stored in $t7
	la $a0, ($t7)
	syscall
	
	li $v0, 4  #new line
	la $a0, newLine
	syscall
	
	li $v0, 1   #this prints the min stored in $t6
	la $a0, ($t6) 
	syscall
	
	li $v0, 4  
	la $a0, newLine
	syscall
	
	li $v0, 1    #this prints the number of integers divisible by 4
	move $a0, $s2
	syscall
	
	li $v0, 10
	syscall
	
