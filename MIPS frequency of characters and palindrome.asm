	.data
asciiArray: .space 508
strSize: .space 100
prompt: .asciiz "Enter a string: \n"
false: .asciiz "not a palindrome \n"
true: .asciiz "is a palindrome \n"
space: .asciiz " "
newLine: .asciiz "\n"
	.globl main
	.text

main:
	la $a1, strSize
	la $s1, asciiArray
	li $s2, -1 #string length counter. use -1 to subtract the null character
	li $s4, 4 #multiply something by 4 since array is elements * 4

readStr:
	#reads string from user and stores it into $s0
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, strSize
	li $a1, 100
	move $s0, $a0
	syscall

checkLength:
	#checks size of string and stores into $s2
	
	lb $t0, 0($s0)
	beqz $t0, transition1
	addi $s2, $s2, 1  #increment length counter
	addi $s0, $s0, 1  #increment to next byte
	b checkLength
	
transition1:
	move $s3, $s2  #make a copy of length 
	la $s0, strSize  #reset $s0 to beginning of the string
	b checkFreq
	
checkFreq:
	#loads each character and will jump to loopLocation afterwards
	beqz $s3, transition2 #$s3 is string length and will jump to the next part after it reaches 0
	lb $t0, 0($s0) #load character 
	addi $s3, $s3, -1
	addi $s0, $s0, 1
	jal loopLocation
	
	b checkFreq
loopLocation:
	#now that we know what the character (ascii value) is we can find the location in the array and 
	#increment the element of the index. 508 = 127 * 4, so we multiply the character by 4 to match the array
	
	#move $t1, $t0	
	mulo $t2, $s4, $t0 #multiply asciiz value by 4 to match array
	lw $s7, asciiArray($t2)  #load the value at the index 
	addi $s7, $s7, 1	#increment the frequency by 1
	sw $s7, asciiArray($t2) #store it back into the array
	
	jr $ra  #return to checkFreq
transition2:
	la $s0, asciiArray
	li $t0, 0
	b printN

printN:
	#this and printN2 will print out the frequency of each character, this function specifically locates 
	#the character frequencies in the array
	
	beq $t0, 508, transition3
	lw $t1, 0($s0)  #load value to $t1 (the value is the number of the particular ascii from the string)
	add $t0, $t0, 4
	addi $s0, $s0, 4   #offset array index
	bgtz $t1, printN2  #check if value is greater than zero (meaning that the string had this character), and will print
	
	b printN
printN2:
	# this is mostly responsible for printing function
	
	#load the ascii character
	div $s0, $s4 #divide array index in memory by 4 to get the ascii value
	li $v0, 11
	mflo $a0
	addi $a0, $a0, -1
	syscall
	
	#makes a space 
	li $v0, 4
	la $a0, space
	syscall
	
	#loads the frequency of the the ascii value
	li $v0, 1
	move $a0, $t1
	syscall
	
	#makes new line 
	li $v0, 4
	la $a0, newLine
	syscall
	
	j printN
	
transition3:
	#reset for palindrome
	la $s0, strSize
	li $s1, 2
	addi $s2, $s2, -1
	move $s7, $s2
	div $s2, $s1
	mflo $s7
	#addi $s7, $s7, -1
	
	
palindrome:
	blt $s2, $s1, returnFalse
	beqz $s7, returnTrue
	
	lb $t0, 0($s0) #start at "left side" of string
	
	lb $t1, strSize($s2)  #start at "right side" of string
	
	bne $t0, $t1, returnFalse
	
	addi $s0, $s0, 1 #increment left side by 1
	addi $s2, $s2, -1  #increment right side by -1
	addi $s7, $s7, -1  #decrease the counter
	
	j palindrome
	
returnFalse:
	li $v0, 4
	la $a0, false
	syscall
	j exit
	
returnTrue:
	li $v0, 4
	la $a0, true
	syscall
	j exit
	
exit:
	li $v0, 10
	syscall
